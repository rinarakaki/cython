#!/usr/bin/env python
from setuptools import setup, Extension
import os
import stat
import subprocess
import textwrap
import sys

if sys.platform == "darwin":
    # Don't create resource files on OS X tar.
    os.environ['COPY_EXTENDED_ATTRIBUTES_DISABLE'] = 'true'
    os.environ['COPYFILE_DISABLE'] = 'true'

setup_args = {}

def add_command_class(name, cls):
    cmdclasses = setup_args.get('cmdclass', {})
    cmdclasses[name] = cls
    setup_args['cmdclass'] = cmdclasses

from distutils.command.sdist import sdist as sdist_orig
class sdist(sdist_orig):
    def run(self):
        self.force_manifest = 1
        if (sys.platform != "win32" and
            os.path.isdir('.git')):
            assert os.system("git rev-parse --verify HEAD > .gitrev") == 0
        sdist_orig.run(self)
add_command_class('sdist', sdist)

# This dict is used for passing extra arguments that are setuptools
# specific to setup
setuptools_extra_args = {}

if 'setuptools' in sys.modules:
    pass
else:
    if os.name == "posix":
        pass
    else:
        scripts = ["cython.py"]


# Always inherit from the "build_ext" in distutils since setuptools already imports
# it from Cython if available, and does the proper distutils fallback otherwise.
# https://github.com/pypa/setuptools/blob/9f1822ee910df3df930a98ab99f66d18bb70659b/setuptools/command/build_ext.py#L16

# setuptools imports Cython's "build_ext", so make sure we go first.
_build_ext_module = sys.modules.get('setuptools.command.build_ext')
if _build_ext_module is None:
    # Python 3.12 no longer has distutils, but setuptools can replace it.
    import setuptools.command.build_ext as _build_ext_module

# setuptools remembers the original distutils "build_ext" as "_du_build_ext"
_build_ext = getattr(_build_ext_module, '_du_build_ext', None)
if _build_ext is None:
    _build_ext = getattr(_build_ext_module, 'build_ext', None)
if _build_ext is None:
    from distutils.command.build_ext import build_ext as _build_ext


class build_ext(_build_ext, object):
    user_options = _build_ext.user_options + [
        ('cython-cplus', None,
             "generate C++ source files"),
        ('cython-create-listing', None,
             "write errors to a listing file"),
        ('cython-line-directives', None,
             "emit source line directives"),
        ('cython-include-dirs=', None,
             "path to the Cython include files" + _build_ext.sep_by),
        ('cython-c-in-temp', None,
             "put generated C files in temp directory"),
        ('cython-gen-pxi', None,
            "generate .pxi file for public declarations"),
        ('cython-directives=', None,
            "compiler directive overrides"),
        ('cython-gdb', None,
             "generate debug information for cygdb"),
        ('cython-compile-time-env', None,
            "cython compile time environment"),
        ]

    boolean_options = _build_ext.boolean_options + [
        'cython-cplus', 'cython-create-listing', 'cython-line-directives',
        'cython-c-in-temp', 'cython-gdb',
    ]

    def initialize_options(self):
        super(build_ext, self).initialize_options()
        self.cython_cplus = 0
        self.cython_create_listing = 0
        self.cython_line_directives = 0
        self.cython_include_dirs = None
        self.cython_directives = None
        self.cython_c_in_temp = 0
        self.cython_gen_pxi = 0
        self.cython_gdb = False
        self.cython_compile_time_env = None

    def finalize_options(self):
        super(build_ext, self).finalize_options()
        if self.cython_include_dirs is None:
            self.cython_include_dirs = []
        elif isinstance(self.cython_include_dirs, str):
            self.cython_include_dirs = \
                self.cython_include_dirs.split(os.pathsep)
        if self.cython_directives is None:
            self.cython_directives = {}

    def get_extension_attr(self, extension, option_name, default=False):
        return getattr(self, option_name) or getattr(extension, option_name, default)

    def build_extension(self, ext):
        from Cython.Build.Dependencies import cythonize

        # Set up the include_path for the Cython compiler:
        #    1.    Start with the command line option.
        #    2.    Add in any (unique) paths from the extension
        #        cython_include_dirs (if Cython.Distutils.extension is used).
        #    3.    Add in any (unique) paths from the extension include_dirs
        includes = list(self.cython_include_dirs)
        for include_dir in getattr(ext, 'cython_include_dirs', []):
            if include_dir not in includes:
                includes.append(include_dir)

        # In case extension.include_dirs is a generator, evaluate it and keep
        # result
        ext.include_dirs = list(ext.include_dirs)
        for include_dir in ext.include_dirs + list(self.include_dirs):
            if include_dir not in includes:
                includes.append(include_dir)

        # Set up Cython compiler directives:
        #    1. Start with the command line option.
        #    2. Add in any (unique) entries from the extension
        #         cython_directives (if Cython.Distutils.extension is used).
        directives = dict(self.cython_directives)
        if hasattr(ext, "cython_directives"):
            directives.update(ext.cython_directives)

        if self.get_extension_attr(ext, 'cython_cplus'):
            ext.language = 'c++'

        options = {
            'use_listing_file': self.get_extension_attr(ext, 'cython_create_listing'),
            'emit_linenums': self.get_extension_attr(ext, 'cython_line_directives'),
            'include_path': includes,
            'compiler_directives': directives,
            'build_dir': self.build_temp if self.get_extension_attr(ext, 'cython_c_in_temp') else None,
            'generate_pxi': self.get_extension_attr(ext, 'cython_gen_pxi'),
            'gdb_debug': self.get_extension_attr(ext, 'cython_gdb'),
            'c_line_in_traceback': not getattr(ext, 'no_c_in_traceback', 0),
            'compile_time_env': self.get_extension_attr(ext, 'cython_compile_time_env', default=None),
        }

        new_ext = cythonize(
            ext,force=self.force, quiet=self.verbose == 0, **options
        )[0]

        ext.sources = new_ext.sources
        super(build_ext, self).build_extension(ext)


def compile_cython_modules(profile=False, coverage=False, compile_minimal=False, compile_more=False, cython_with_refnanny=False):
    source_root = os.path.abspath(os.path.dirname(__file__))
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

    from distutils.spawn import find_executable
    from distutils.sysconfig import get_python_inc
    pgen = find_executable(
        'pgen', os.pathsep.join([os.environ['PATH'], os.path.join(get_python_inc(), '..', 'Parser')]))
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
        source_file = os.path.join(source_root, *module.split('.'))
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

    print("BEFORE import Cython.Distutils")
    from Cython.Compiler.Options import get_directive_defaults
    print("AFTER import Cython.Compiler")
    get_directive_defaults().update(
        language_level=2,
        binding=False,
        always_allow_keywords=False,
        autotestdict=False,
    )
    print("AFTER get_directive_defaults")
    if profile:
        get_directive_defaults()['profile'] = True
        sys.stderr.write("Enabled profiling for the Cython binary modules\n")
    if coverage:
        get_directive_defaults()['linetrace'] = True
        sys.stderr.write("Enabled line tracing and profiling for the Cython binary modules\n")

    # not using cythonize() directly to let distutils decide whether building extensions was requested
    add_command_class("build_ext", build_ext)
    print("AFTER add_command_class")
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

setup_args.update(setuptools_extra_args)


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

    setup(
        classifiers=[
            dev_status(version),
        ],
        **setup_args
    )


if __name__ == '__main__':
    run_build()
