#!/usr/bin/env python
import os
import shutil
import stat
import subprocess
import sys
import sysconfig

from setuptools import setup, Extension

from Cython.Distutils.build_ext import build_ext
from Cython.Compiler.Options import get_directive_defaults

if sys.platform == "darwin":
    # Don't create resource files on OS X tar.
    os.environ['COPY_EXTENDED_ATTRIBUTES_DISABLE'] = 'true'
    os.environ['COPYFILE_DISABLE'] = 'true'

setup_args = {}

def add_command_class(name, cls):
    cmdclasses = setup_args.get('cmdclass', {})
    cmdclasses[name] = cls
    setup_args['cmdclass'] = cmdclasses

from setuptools.command.sdist import sdist as sdist_orig
class sdist(sdist_orig):
    def run(self):
        self.force_manifest = 1
        if (sys.platform != "win32" and
            os.path.isdir('.git')):
            assert os.system("git rev-parse --verify HEAD > .gitrev") == 0
        sdist_orig.run(self)
add_command_class('sdist', sdist)


def compile_cython_modules(profile=False, coverage=False, compile_minimal=False, compile_more=False, cython_with_refnanny=False):
    compiled_modules = [
        "Cython.Plex.Actions",
        "Cython.Plex.Scanners",
        "Cython.Compiler.FlowControl",
        "Cython.Compiler.Scanning",
        "Cython.Compiler.Visitor",
        "Cython.Runtime.refnanny",
    ]
    if not compile_minimal:
        compiled_modules.extend([
            "Cython.Plex.Machines",
            "Cython.Plex.Transitions",
            "Cython.Plex.DFA",
            "Cython.Compiler.Code",
            "Cython.Compiler.FusedNode",
            "Cython.Compiler.Parsing",
            "Cython.Tempita._tempita",
            "Cython.StringIOTree",
            "Cython.Utils",
        ])
    if compile_more and not compile_minimal:
        compiled_modules.extend([
            "Cython.Compiler.Lexicon",
            "Cython.Compiler.Pythran",
            "Cython.Build.Dependencies",
            "Cython.Compiler.ParseTreeTransforms",
            "Cython.Compiler.Nodes",
            "Cython.Compiler.ExprNodes",
            "Cython.Compiler.ModuleNode",
            "Cython.Compiler.Optimize",
            ])

    pgen = shutil.which(
        'pgen', os.pathsep.join([os.environ['PATH'], os.path.join(sysconfig.get_path('platstdlib'), 'Parser')]))
    if not pgen:
        sys.stderr.write("Unable to find pgen, not compiling formal grammar.\n")
    else:
        parser_dir = os.path.join(os.path.dirname(__file__), 'Cython', 'Parser')
        grammar = os.path.join(parser_dir, 'Grammar')
        subprocess.check_call([
            pgen,
            os.path.join(grammar),
            os.path.join(parser_dir, 'graminit.h'),
            os.path.join(parser_dir, 'graminit.c'),
            ])
        cst_pyx = os.path.join(parser_dir, 'ConcreteSyntaxTree.pyx')
        if os.stat(grammar)[stat.ST_MTIME] > os.stat(cst_pyx)[stat.ST_MTIME]:
            mtime = os.stat(grammar)[stat.ST_MTIME]
            os.utime(cst_pyx, (mtime, mtime))
        compiled_modules.extend([
                "Cython.Parser.ConcreteSyntaxTree",
            ])

    defines = []
    if cython_with_refnanny:
        defines.append(('CYTHON_REFNANNY', '1'))
    if coverage:
        defines.append(('CYTHON_TRACE', '1'))

    extensions = []
    for module in compiled_modules:
        source_file = os.path.join(*module.split('.'))
        pyx_source_file = source_file + ".py"
        if not os.path.exists(pyx_source_file):
            pyx_source_file += "x"  # .py -> .pyx

        dep_files = []
        if os.path.exists(source_file + '.pxd'):
            dep_files.append(source_file + '.pxd')

        extensions.append(Extension(
            module, sources=[pyx_source_file],
            define_macros=defines if '.refnanny' not in module else [],
            depends=dep_files))
        # XXX hack around setuptools quirk for '*.pyx' sources
        extensions[-1].sources[0] = pyx_source_file

    # optimise build parallelism by starting with the largest modules
    extensions.sort(key=lambda ext: os.path.getsize(ext.sources[0]), reverse=True)

    get_directive_defaults().update(
        language_level=2,
        binding=False,
        always_allow_keywords=False,
        autotestdict=False,
    )
    if profile:
        get_directive_defaults()['profile'] = True
        sys.stderr.write("Enabled profiling for the Cython binary modules\n")
    if coverage:
        get_directive_defaults()['linetrace'] = True
        sys.stderr.write("Enabled line tracing and profiling for the Cython binary modules\n")

    # not using cythonize() directly to let distutils decide whether building extensions was requested
    add_command_class("build_ext", build_ext)
    setup_args['ext_modules'] = extensions


def check_option(name):
    cli_arg = "--" + name
    if cli_arg in sys.argv:
        sys.argv.remove(cli_arg)
        return True

    env_var = name.replace("-", "_").upper()
    if os.environ.get(env_var) == "true":
        return True

    return False


cython_profile = check_option('cython-profile')
cython_coverage = check_option('cython-coverage')
cython_with_refnanny = check_option('cython-with-refnanny')

compile_cython_itself = not check_option('no-cython-compile')
if compile_cython_itself:
    cython_compile_more = check_option('cython-compile-all')
    cython_compile_minimal = check_option('cython-compile-minimal')


def dev_status(version):
    if 'b' in version or 'c' in version:
        # 1b1, 1beta1, 2rc1, ...
        return 'Development Status :: 4 - Beta'
    elif 'a' in version:
        # 1a1, 1alpha1, ...
        return 'Development Status :: 3 - Alpha'
    else:
        return 'Development Status :: 5 - Production/Stable'


def run_build():
    if compile_cython_itself:
        compile_cython_modules(cython_profile, cython_coverage, cython_compile_minimal, cython_compile_more, cython_with_refnanny)

    setup(**setup_args)


if __name__ == '__main__':
    run_build()
