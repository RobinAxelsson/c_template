#include <stdio.h>
#include "math_utils.h"

int main() {
    int a = 5, b = 3;

    if (add(a, b) == 8) {
        printf("Addition test passed.\n");
    } else {
        printf("Addition test failed.\n");
    }

    if (subtract(a, b) == 2) {
        printf("Subtraction test passed.\n");
    } else {
        printf("Subtraction test failed.\n");
    }

    return 0;
}