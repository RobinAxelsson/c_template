# GCC Cheat Sheet

| **Flag**               | **Description**                                                                                              |
|------------------------|--------------------------------------------------------------------------------------------------------------|
| `-Wall`                | Enables most common warning messages.                                                                        |
| `-Wextra`              | Enables additional warning messages not covered by `-Wall`.                                                  |
| `-Werror`              | Treats warnings as errors.                                                                                   |
| `-Wno-<warning>`       | Disables specific warnings (e.g., `-Wno-unused-variable`).                                                   |
| `-O0`                  | Disables optimization (default).                                                                             |
| `-O1`                  | Enables basic optimization.                                                                                  |
| `-O2`                  | Enables more aggressive optimizations without compromising safety or correctness.                            |
| `-O3`                  | Enables the most aggressive optimizations (might increase code size).                                        |
| `-Os`                  | Optimizes for size (reduces binary size).                                                                    |
| `-g`                   | Includes debug information in the output.                                                                    |
| `-fPIC`                | Generates position-independent code (useful for shared libraries).                                           |
| `-shared`              | Creates a shared (dynamic) library.                                                                          |
| `-c`                   | Compiles source files into object files (`.o`), without linking.                                             |
| `-I<dir>`              | Adds a directory to the search path for header files (e.g., `-I./src`).                                      |
| `-L<dir>`              | Adds a directory to the search path for libraries (e.g., `-L./libs`).                                        |
| `-l<libname>`          | Links with a library (`lib<libname>.a` or `lib<libname>.so`).                                                |
| `-std=<standard>`      | Specifies the C language standard (e.g., `-std=c99`, `-std=c11`).                                            |
| `-D<macro>`            | Defines a macro for the preprocessor (e.g., `-DDEBUG` to define `DEBUG`).                                    |
| `-U<macro>`            | Undefines a macro (e.g., `-UNDEBUG` to remove the `DEBUG` macro).                                            |
| `-fno-stack-protector` | Disables stack protection, which can prevent buffer overflow attacks.                                        |
| `-fno-exceptions`      | Disables exception handling (useful in C++).                                                                 |
| `-fno-rtti`            | Disables runtime type information (useful in C++).                                                           |
| `-v`                   | Verbose mode, shows detailed information about the compilation process.                                      |
| `-march=<arch>`        | Specifies the target architecture (e.g., `-march=x86-64`).                                                   |
| `-mtune=<cpu>`         | Tunes the code for a specific CPU architecture (e.g., `-mtune=corei7`).                                      |
| `-flto`                | Enables link-time optimization, allowing optimizations across different translation units.                   |
| `-fstack-protector`    | Enables stack protection (helps prevent buffer overflow attacks).                                            |
| `-fvisibility=hidden`  | Hides symbols by default, useful for shared libraries.                                                       |
| `-fno-inline`          | Disables function inlining.                                                                                  |
| `-fomit-frame-pointer` | Omits the frame pointer, which can improve performance in some cases.                                        |


## 4 Steps

```makefile

# Preprocessing (-> .i file)
# Compilation (-> .s file)
# Assembly (-> .o file)
# Linking (-> program)

OUTPUT = a.out main.o main.i main.s

all:
a.out: main.o
	gcc -o a.out main.o

main.o: main.s
	gcc -c main.s -o main.o

# -S create only assembly
main.s: main.i
	gcc -S -masm=intel main.i -o main.s

# -E create only preprocessing file
main.i:
	gcc -E src/main.c -o main.i

# dissasemble to intel syntax
disasm: a.out
	objdump -M intel -d a.out > a.s 

clean:
	rm -f $(OUTPUT)

```

## Linking examples

```shell
# STATIC ARCHIVE - basically a archive of .o files

# step 1
# -c creates only a .o file
gcc -c myfile.c

# step 2
# r: Replace or add object files into the archive.
# c: Create the archive if it doesn't already exist.
# s: Write an index to the archive (for faster linking).
ar rcs libmylibrary.a myfile.o

# Step 3 linking:
# -static ensure linker uses static libraries libmylib.a instead of libmylib.so
gcc -o myprogram main.o -L/path/to/static/libs -lmylib -lotherlib -static

# SHARED LIBRARY - loaded at runtime by dynamic linker (can be shared between processes)

# step 1
# -fPIC: Generates position-independent code- required
gcc -fPIC -shared -o libmylibrary.so myfile.c

# step 2
# Shared Library - Dynamic linking
# target library named libmylibrary.so
gcc -o myprogram myprogram.c -L/usr/lib -lmylibrary

# COMBINED shared and static
# The shared library dependencies is needed to explicitly link in e.g. libmylib.a depends on -lsharedlib
gcc -o myprogram main.o /path/to/libmylib.a -L/path/to/shared/libs -lsharedlib

# Unlink standard lib

# std lib is implicit but you can unlink it but you have to manage a lot of system level functionality mannually.
gcc -nostdlib -o myprogram myprogram.c

# CHECK DEPENDENCIES
ldd myprogram
```

## Debugging and optimizations

```shell

# DEBUG
# -g include debug symbols (not default)
# -00 disables all optimizations to make the code easier to follow 
gcc -g -O0 -o myprogram myprogram.c

# RELEASE
# -02 enables standard levels of optimizations without increasing size and complexity
# -DNDEBUG disables debug assertions
# -s strips debug symbols to reduce size (optional)
# -flto link time optimizations, cross .o files - can possibly bugs. Inlines functions, removes dead code and more.
gcc -O2 -flto -DNDEBUG -o myprogram myprogram.c

# FOR SIZE+OPT
gcc -Os -o myprogram myprogram.c

# link time optimization -flto

```

## More gcc options

```shell

# "cpp" but handle internally by gcc
-Wp,<options>	# Pass options to the preprocessor (e.g., -DDEBUG to define a macro).

# "as" the portable gnu assembler
-Wa,<options>	# Pass options to the assembler (e.g., -al to generate an assembly listing).

# "ld"
-Wl,<options>	# Pass options to the linker (e.g., -rpath to specify the runtime library path).

# example
gcc -c myfile.c -Wa,-al -Wp,-DDEBUG -Wl,-rpath,/lib

```

## All default settings running gcc -v src/main.c

```shell
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-linux-gnu/14/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: 
../src/configure -v 
--with-pkgversion='Debian 14.2.0-6' 
--with-bugurl=file:///usr/share/doc/gcc-14/README.Bugs 
--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2,rust 
--prefix=/usr 
--with-gcc-major-version-only 
--program-suffix=-14 
--program-prefix=x86_64-linux-gnu- 
--enable-shared 
--enable-linker-build-id 
--libexecdir=/usr/libexec 
--without-included-gettext 
--enable-threads=posix 
--libdir=/usr/lib 
--enable-nls 
--enable-bootstrap 
--enable-clocale=gnu 
--enable-libstdcxx-debug 
--enable-libstdcxx-time=yes 
--with-default-libstdcxx-abi=new 
--enable-libstdcxx-backtrace 
--enable-gnu-unique-object 
--disable-vtable-verify 
--enable-plugin 
--enable-default-pie 
--with-system-zlib 
--enable-libphobos-checking=release 
--with-target-system-zlib=auto 
--enable-objc-gc=auto 
--enable-multiarch 
--disable-werror 
--enable-cet 
--with-arch-32=i686 
--with-abi=m64
--with-multilib-list=m32,m64,mx32 
--enable-multilib 
--with-tune=generic 
--enable-offload-targets=nvptx-none=/build/reproducible-path/gcc-14-14.2.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/reproducible-path/gcc-14-14.2.0/debian/tmp-gcn/usr 
--enable-offload-defaulted 
--without-cuda-driver 
--enable-checking=release 
--build=x86_64-linux-gnu 
--host=x86_64-linux-gnu 
--target=x86_64-linux-gnu 
--with-build-config=bootstrap-lto-lean 
--enable-link-serialization=3

####### Compilation step ###########

Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 14.2.0 (Debian 14.2.0-6) 

COLLECT_GCC_OPTIONS=
'-v'
'-mtune=generic'
'-march=x86-64'
'-dumpdir'
'a-'
/usr/libexec/gcc/x86_64-linux-gnu/14/cc1
-quiet
-v
-imultiarch
x86_64-linux-gnu
src/main.c
-quiet 
-dumpdir a- 
-dumpbase main.c
-dumpbase-ext .c 
-mtune=generic 
-march=x86-64 
-version 
-fasynchronous-unwind-tables 
-o /tmp/ccYmUcu4.s # output assembly file

######## ASSEMBLY STEP ##############
# C standard C17
GNU C17 (Debian 14.2.0-6) version 14.2.0 (x86_64-linux-gnu)
    compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

GGC heuristics: 
--param ggc-min-expand=100 
--param ggc-min-heapsize=131072

ignoring nonexistent directory "/usr/local/include/x86_64-linux-gnu"
ignoring nonexistent directory "/usr/lib/gcc/x86_64-linux-gnu/14/include-fixed/x86_64-linux-gnu"
ignoring nonexistent directory "/usr/lib/gcc/x86_64-linux-gnu/14/include-fixed"
ignoring nonexistent directory "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../x86_64-linux-gnu/include"

#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/gcc/x86_64-linux-gnu/14/include
 /usr/local/include
 /usr/include/x86_64-linux-gnu
 /usr/include
End of search list.

Compiler executable checksum: f44db78a3a955f30f66df4ad66ac6b2b
COLLECT_GCC_OPTIONS=
'-v'
'-mtune=generic'
'-march=x86-64'
'-dumpdir'
'a-'

as -v --64 -o /tmp/ccHWI2sy.o /tmp/ccYmUcu4.s #as the portable gnu assembler

####### LINKING STEP ###########

GNU assembler version 2.43.1 (x86_64-linux-gnu) using BFD version (GNU Binutils for Debian) 2.43.1

COMPILER_PATH=/usr/libexec/gcc/x86_64-linux-gnu/14/:
/usr/libexec/gcc/x86_64-linux-gnu/14/:
/usr/libexec/gcc/x86_64-linux-gnu/:
/usr/lib/gcc/x86_64-linux-gnu/14/:
/usr/lib/gcc/x86_64-linux-gnu/

LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/14/:
/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/:
/usr/lib/gcc/x86_64-linux-gnu/14/../../../../lib/:
/lib/x86_64-linux-gnu/:
/lib/../lib/:
/usr/lib/x86_64-linux-gnu/:
/usr/lib/../lib/:
/usr/lib/gcc/x86_64-linux-gnu/14/../../../:
/lib/:
/usr/lib/

COLLECT_GCC_OPTIONS=
'-v'
'-mtune=generic'
'-march=x86-64'
'-dumpdir'
'a.'

/usr/libexec/gcc/x86_64-linux-gnu/14/collect2 
-plugin /usr/libexec/gcc/x86_64-linux-gnu/14/liblto_plugin.so 
-plugin-opt=/usr/libexec/gcc/x86_64-linux-gnu/14/lto-wrapper 
-plugin-opt=-fresolution=/tmp/cc60FjuX.res 
-plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s 
-plugin-opt=-pass-through=-lc 
-plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s 
--build-id 
--eh-frame-hdr 
-m elf_x86_64 # file type
--hash-style=gnu 
--as-needed 
-dynamic-linker /lib64/ld-linux-x86-64.so.2 # runtime linker 
-pie # position independent executeable
/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/Scrt1.o 
/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/crti.o 
/usr/lib/gcc/x86_64-linux-gnu/14/crtbeginS.o 

### Shared Library Folders
-L/usr/lib/gcc/x86_64-linux-gnu/14 
-L/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu 
-L/usr/lib/gcc/x86_64-linux-gnu/14/../../../../lib 
-L/lib/x86_64-linux-gnu 
-L/lib/../lib 
-L/usr/lib/x86_64-linux-gnu 
-L/usr/lib/../lib 
-L/usr/lib/gcc/x86_64-linux-gnu/14/../../.. 

/tmp/ccHWI2sy.o # object file
-lgcc 
--push-state 
--as-needed 
-lgcc_s 
--pop-state 
-lc # c standard library
-lgcc 
--push-state 
--as-needed 
-lgcc_s 
--pop-state 
/usr/lib/gcc/x86_64-linux-gnu/14/crtendS.o 
/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/crtn.o
COLLECT_GCC_OPTIONS=
'-v'
'-mtune=generic'
'-march=x86-64'
'-dumpdir'
'a.'

```