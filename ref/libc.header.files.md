# libc header files

| **Header File**       | **Functions Implemented by `libc.so.6`**                                  |
|-----------------------|---------------------------------------------------------------------------|
| **`<stdio.h>`**       | `printf()`, `scanf()`, `fopen()`, `fclose()`, `fputs()`, `fgets()`, `fprintf()` |
| **`<stdlib.h>`**      | `malloc()`, `free()`, `realloc()`, `exit()`, `atoi()`, `strtol()`, `getenv()`, `system()` |
| **`<string.h>`**      | `strlen()`, `strcpy()`, `strncpy()`, `strcat()`, `strcmp()`, `memcpy()`, `memset()` |
| **`<unistd.h>`**      | `read()`, `write()`, `open()`, `close()`, `fork()`, `exec()`, `getpid()`, `chdir()` |
| **`<math.h>`**        | `sin()`, `cos()`, `tan()`, `log()`, `sqrt()`, `pow()`, `ceil()`, `floor()` |
| **`<ctype.h>`**       | `isalpha()`, `isdigit()`, `islower()`, `toupper()`, `tolower()` |
| **`<time.h>`**        | `time()`, `localtime()`, `strftime()`, `gmtime()`, `difftime()` |
| **`<signal.h>`**      | `signal()`, `raise()`, `kill()`, `abort()`, `pause()` |
| **`<errno.h>`**       | Error codes: `ENOMEM`, `EIO`, `EINVAL`, etc.                             |
| **`<stdarg.h>`**      | `va_start()`, `va_arg()`, `va_end()` (for variable arguments) |
| **`<pthread.h>`**     | `pthread_create()`, `pthread_join()`, `pthread_mutex_lock()`, `pthread_cond_wait()` |
| **`<sys/types.h>`**   | Types: `pid_t`, `size_t`, `ssize_t`, `off_t`, `time_t`                   |
| **`<sys/stat.h>`**    | `stat()`, `fstat()`, `lstat()`, `chmod()`, `chown()`                     |
| **`<fcntl.h>`**       | `open()`, `fcntl()`, `flock()`                                            |
| **`<sys/socket.h>`**  | `socket()`, `bind()`, `connect()`, `send()`, `recv()`, `close()`         |