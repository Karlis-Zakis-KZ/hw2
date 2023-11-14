#include <stdio.h>
#include <stdlib.h>
#include "matmul.h"

void read_matrix(int height, int width, int* matrix) {
    for (int* p = matrix; p < matrix + height * width; p++)
        scanf("%d", p);
}

int main(int argc, char *argv[]) {
    int w1, h1, w2, h2;
    int *m1, *m2, *m_final;

    // Read dimensions of m1 and allocate memory
    scanf("%d %d", &h1, &w1);
    m1 = (int *)malloc(sizeof(int) * h1 * w1);
    read_matrix(h1, w1, m1);

    // Read dimensions of m2 and allocate memory
    scanf("%d %d", &h2, &w2);
    m2 = (int *)malloc(sizeof(int) * h2 * w2);
    read_matrix(h2, w2, m2);

    // Check for matrix multiplication compatibility
    if (w1 != h2){
        free(m1);
        free(m2);
        exit(1);
    }

    // Allocate memory for result matrix
    int h_final = h1;
    int w_final = w2;
    m_final = (int *)malloc(sizeof(int) * h_final * w_final);

    // Perform matrix multiplication
    matmul(h1, w1, m1, h2, w2, m2, m_final);

    // Print result
    printf("%d %d\n", h_final, w_final);
    for (int i = 0; i < h_final; i++){
        for (int j = 0; j < w_final; j++)
        {
            printf("%d", m_final[i * w_final + j]);
            if (j != w_final - 1)
                printf(" ");
        }
        printf("\n");
    }

    // Free allocated memory
    free(m1);
    free(m2);
    free(m_final);

    return 0;
}