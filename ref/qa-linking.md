# Q&A Linking

### If I know exacly the function names inside a library can I call them without a header file?

If you know the exact function names and their signatures, you technically can call the functions in a shared library without a header file. 
Header files help with:
- The correct calling convention
- Function signatures
- Type safety
- Symbol Resolution: At runtime, when you use shared libraries like libc.so.6, the function calls are resolved dynamically. The header file helps by providing a declarative interface so that the compiler knows how to translate the function calls into the correct format for the dynamic linker/loader.
- You need to use extern keyword

## Linking

```c
//If you define extern function in main.c
extern void libAdd(int x, int y);

// lib.c
void libAdd(int x, int y) {
    printf("%d + %d = %d\n", x, y, x + y);
}
```

### Static linking

If you statically compile it (static linking) the linker will search the definition in the .o files and resolve the reference to libAdd the file is specified in the
compile step: gcc main.c lib.c -o myprogram

### Dynamic linking

With dynamic linking, shared libraries (e.g. lib.so), the dynamic linker/loader (ld.so / ld-linux-x86-64.so.2) will search for the function at runtime.

In dynamic linking, the symbol resolution happens at program startup when the program is loaded into memory. The dynamic loader looks for the function (libAdd), and resolve the references to the correct memory address.

```shell

# link with shared libraries
gcc -c main.c -o main.o
gcc main.o -L/path/to/libs -lmylib -o myprogram

```

### Implicit linking

- Some dynamic libraries are linked in implicitly
- gcc does this automatically - either the static or the dynamic version
- Check the binary dependencies with ```ldd a.out```
- Check with ```gcc -v``` to get verbose output
- Show gcc default library paths ```gcc -print-search-dirs```

### Is libc.so linked even if I dont use it in my code?

Yes, it is considered a default library. Some runtime functions in libc are always needed. For example, libc handles low-level system calls, memory management, and setting up the program's environment. You can compile a program without lib c ```gcc -nostdlib -o myprogram myprogram.c``` but you have to manage a lot of system level functionality mannually.

### If I add another "standard" library do I need to specify it with gcc or is it enough with using a correct header file?

No the header file is not enough, you need to specify the library to gcc. Only libc is implicit. The flag convention is libcustom.so -> -lcustom, libm.so -> -lm. ```gcc -o myprogram main.c -L/path/to/custom/libs -lcustom -lm``` (lm for math library).

### Are all functions and symbols "public" in C? Is that not very error prone with name clashes?

- Global Scope: By default, any variable or function that is defined outside of a function is globally visible to rest of the assembly.
- If you use the static keyword it is limited to the file
- With the extern keyword you tell the linker that the method is elseware in the project.

### Can you statically link a .a file that has shared library dependencies?

Static binaries are a group of object files and if they depend on shared libraries they do not automatically follow with the .a file.
- Fully static binary:
    - all the dependencies of the .a file must be available as static binaries (replace shared with static)