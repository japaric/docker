# `mips-unknown-linux-uclibc`

- Path and misc options > Prefix directory = /x-tools/${CT\_TARGET}
- Target options > Target Architecture = mips
- Target options > Endianness = **Big** endian
- Target options > Architecture level = mips32r2 -- (\*)
- Target options > Floating point = software (no FPU) -- (\*)
- Operating System > Target OS = linux
- Operating System > Linux kernel version = 3.18 - OpenWRT 15.05
- C-library > C library = uClibc
- C-library > uClibc version = 0.9.33.2 -- OpenWRT 15.05
- C compiler > gcc version = 4.9 -- OpenWRT 15.05 uses 4.8

(\*) Matches rustc target

# `mipsel-unknown-linux-uclibc`

- Path and misc options > Prefix directory = /x-tools/${CT\_TARGET}
- Target options > Target Architecture = mips
- Target options > Endianness = **Little** endian
- Target options > Architecture level = mips32 -- (\*)
- Target options > Floating point = software (no FPU) -- (\*)
- Operating System > Target OS = linux
- Operating System > Linux kernel version = 3.18 - OpenWRT 15.05
- C-library > C library = uClibc
- C-library > uClibc version = 0.9.33.2 -- OpenWRT 15.05
- C compiler > gcc version = 4.9 -- OpenWRT 15.05 uses 4.8

(\*) Matches rustc target
