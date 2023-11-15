// -*- c++ -*-
#include <stdio.h>
template<uint32_t N>
class Integral {
    uint8_t bytes[N];

public:
    Integral() {
        for (uint32_t i = 0; i < N; i++)
            bytes[i] = 0;
    }
    Integral(const Integral &I) {
      for (uint32_t i = 0; i < N; i++)
        bytes[i] = I.bytes[i];
    }
    Integral(long long value) {
      resize_signed_int((uint8_t*)&value, sizeof(value), bytes, N);
    }

    operator long long() const {
        long long value;
        resize_signed_int(bytes, N, (uint8_t*)&value, sizeof(value));
        return value;
    }
    
    Integral& operator=(const Integral &I) {
        for (uint32_t i=0; i<N; i++)
            bytes[i] = I.bytes[i];
        return *this;
    }
    bool operator<(const Integral &I) const
    { return cmp(I) < 0; }
    bool operator>(const Integral &I) const
    { return cmp(I) > 0; }
    bool operator<=(const Integral &I) const
    { return cmp(I) <= 0; }
    bool operator>=(const Integral &I) const
    { return cmp(I) >= 0; }
    bool operator==(const Integral &I) const
    { return cmp(I) == 0; }
    bool operator!=(const Integral &I) const
    { return cmp(I) != 0; }
    
    bool operator==(const long long value) const {
        size_t len = sizeof(long long) > N ? sizeof(long long) : N;
        uint8_t* extended = new uint8_t[len];
        uint8_t* other;
        if (sizeof(long long) < N) {
            resize_signed_int((uint8_t*)&value, sizeof(value), extended, len);
            other = bytes;
        } else {
            resize_signed_int(bytes, N, extended, len);
        }
        bool res = memcmp(extended, other, len);
        delete [] extended;
        return res;
    }
    bool operator!=(const long long val) const
    { return !(*this == val); }

 private:
    static bool is_le() {
        int32_t one = 1;
        int32_t b = (int32_t)*(uint8_t *)&one;
        return b ? true : false;
    }
    static uint32_t lsb() {
        return is_le() ? 0 : N - 1;
    }
    static uint32_t msb() {
        return is_le() ? N - 1 : 0;
    }
    int32_t cmp(const Integral& J) const {
        const Integral& I = *this;
        uint8_t sI = I.bytes[msb()] & 0x80;
        uint8_t sJ = J.bytes[msb()] & 0x80;
        if (sI > sJ) return -1;
        if (sI < sJ) return +1;
        uint8_t bI = I.bytes[msb()] & 0x7F;
        uint8_t bJ = J.bytes[msb()] & 0x7F;
        int32_t cmpabs = 0;
        if (bI < bJ)
            cmpabs = -1;
        else if (bI > bJ)
            cmpabs = +1;
        else {
            int32_t incr = is_le() ? -1 : 1;
            uint32_t i = msb() + incr;
            while (i != lsb()) {
                if (I.bytes[i] < J.bytes[i])
                { cmpabs = -1; break; }
                if (I.bytes[i] > J.bytes[i])
                { cmpabs = +1; break; }
                i += incr;
            }
        }
        if (sI) return -cmpabs;
        else    return +cmpabs;
    }
    
    static void resize_signed_int(const uint8_t* src, size_t src_len, uint8_t* dst, size_t dst_len) {
        uint8_t msb;
        size_t dst_offset = 0;
        size_t src_offset = 0;
        if (is_le()) {
            dst_offset = 0;
            src_offset = 0;
            msb = ((uint8_t*) src)[src_len - 1];
            if (src_len > dst_len) {
                src_len = dst_len;
            }
        } else {
            if (dst_len > src_len) {
                dst_offset = dst_len - src_len;
            } else {
                src_offset = src_len - dst_len;
                src_len = dst_len;
            }
            msb = ((uint8_t*) src)[0];
        }
        if (msb & 0x80) {
            memset(dst, 0xFF, dst_len);
        } else {
            memset(dst, 0, dst_len);
        }
        memcpy(dst + dst_offset, src + src_offset, src_len);
    }
};

typedef Integral<3> Int24;
typedef Integral<7> Int56;
typedef Integral<11> Int88;
typedef Integral<64> Int512;
