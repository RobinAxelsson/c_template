#include <stdio.h>
#include "math_utils.h"

int main() {
    int a = 5, b = 3;
    printf("Addition of %d and %d: %d\n", a, b, add(a, b));
    printf("Subtraction of %d and %d: %d\n", a, b, subtract(a, b));
    return 0;
}