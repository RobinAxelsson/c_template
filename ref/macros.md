# Macros

## Architecture

| **Macro**  | **Description**                                         |
|-------------------------|---------------------------------------------------------|
| `__i386__`             | Defined for 32-bit Intel x86 architecture.              |
| `__x86_64__`           | Defined for 64-bit Intel x86 architecture.              |
| `__arm__`              | Defined for 32-bit ARM architecture.                    |
| `__aarch64__`          | Defined for 64-bit ARM architecture.                    |

## Common Macros

| **Macro** | Description | Example Usage          |
|--------------------|---------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| `#define`         | Defines a constant or a macro function.                                                     | `#define PI 3.14`                                            |
| `#undef`          | Undefines a previously defined macro.                                                       | `#undef PI`                                                  |
| `#ifdef`          | Checks if a macro is defined.                                                               | `#ifdef DEBUG`                                               |
| `#ifndef`         | Checks if a macro is not defined.                                                           | `#ifndef CONFIG`                                             |
| `#if`             | Conditional compilation based on an expression.                                             | `#if VERSION > 2`                                            |
| `#else`           | Provides an alternative block for `#if` or `#ifdef`.                                        | `#else`                                                      |
| `#elif`           | Combines `else` and `if` for conditional compilation.                                       | `#elif VERSION == 2`                                         |
| `#endif`          | Ends a conditional directive (`#if`, `#ifdef`, etc.).                                        | `#endif`                                                     |
| `__FILE__`        | A predefined macro that represents the current filename as a string.                        | `printf("File: %s\n", __FILE__);`                            |
| `__LINE__`        | A predefined macro that represents the current line number as an integer.                   | `printf("Line: %d\n", __LINE__);`                            |
| `__DATE__`        | A predefined macro for the current compilation date.                                        | `printf("Date: %s\n", __DATE__);`                            |
| `__TIME__`        | A predefined macro for the current compilation time.                                        | `printf("Time: %s\n", __TIME__);`                            |
| `__STDC__`        | Indicates if the compiler conforms to the ANSI C standard.                                  | `#if __STDC__`                                               |
| `#pragma`         | Provides compiler-specific instructions.                                                   | `#pragma warning(disable: 4996)`                             |
| `##`              | Concatenates two tokens in a macro definition.                                              | `#define CONCAT(a, b) a##b`                                  |
| `#`               | Converts a macro argument into a string.                                                   | `#define STRINGIFY(x) #x`                                    |
| `sizeof`          | Calculates the size (in bytes) of a data type or variable.                                  | `printf("%zu", sizeof(int));`                                |
| `_Static_assert`  | Performs compile-time assertions.                                                           | `_Static_assert(sizeof(int) == 4, "int size is not 4 bytes");`|
| `assert`          | Tests an expression and aborts the program if the test fails (only in debug builds).        | `assert(ptr != NULL);`                                       |