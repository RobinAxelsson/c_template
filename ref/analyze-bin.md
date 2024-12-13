# Analyzing binaries

```shell

# the .h files for the c standard lib
ls -la /usr/include | grep .h

# the c standard library - as shared library
ls -la /lib/x86_64-linux-gnu | grep libc.so

-rw-r--r--   1 root root       283 Sep 24 21:46 libc.so
-rwxr-xr-x   1 root root   2003408 Sep 24 21:46 libc.so.6

# -T option used to display the dynamic symbol table of an object file or a shared library.
# All is available for dynamic linking - use this for shared libraries
objdump -T /lib/x86_64-linux-gnu/libc.so.6 | grep printf


# Get the static libs
ls -la /usr/lib/x86_64-linux-gnu | grep "\.a"

-rw-r--r--   1 root root         8 Sep 24 21:46 libanl.a
-rw-r--r--   1 root root      1734 Sep 24 21:46 libBrokenLocale.a
-rw-r--r--   1 root root   5675010 Sep 24 21:46 libc.a
-rw-r--r--   1 root root   7976282 Feb 20  2024 libcapstone.a

# Compare shared lib with static
libc.so.6 2003408 #1.91 MB
libc.a    5675010 #5.41 MB

# check props of libc.so.6
file /lib/x86_64-linux-gnu/libc.so.6
    libc.so.6: ELF 64-bit LSB
    shared object,
    x86-64, 
    version 1 (GNU/Linux),
    dynamically linked, 
    interpreter /lib64/ld-linux-x86-64.so.2, # dynamic loader/linker see below
    BuildID[sha1]=522aec690df2798fac29fc4608b2c28fd5968271,
    for GNU/Linux 3.2.0, 
    stripped # no debugging symbols

# dynamic dependencies
ldd /lib/x86_64-linux-gnu/libc.so.6
    # dynamic linker/loader and memory address it is loaded into memory
    /lib64/ld-linux-x86-64.so.2 (0x00007f014a4b4000)

    # virtual dynamic shared object (VDSO). A special shared library that the kernel provides to user-space programs to speed up certain system calls.
    # Not an actual file but a virtual object provided by the kernel
    # Vdso functions exist when writing pure assembly as well
    linux-vdso.so.1 (0x00007f014a4b2000)

# check dynamic dependencies of libc.a
ldd /lib/x86_64-linux-gnu/libc.a
    not a dynamic executable


# libc.a is a static library - an archive file created by the ar tool.
    # archive of object files that is copied into the binary at link time
# It can not be analyzed like an executeable nor a shared library (.so)
file /lib/x86_64-linux-gnu/libc.a
    /lib/x86_64-linux-gnu/libc.a: current ar archive

# list the object files
ar -t /lib/x86_64-linux-gnu/libc.a | grep printf

# extract object file
ar -x /lib/x86_64-linux-gnu/libc.a printf.o

# dissassemble
objdump -M intel -d printf.o > printf.s

# libc binaries have multiple header files

# USE ghidra!

```