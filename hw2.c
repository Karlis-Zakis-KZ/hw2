#include <stdio.h>
#include <stdlib.h>
#include "matmul.h"

int main(int argc, char *argv[]) {
	
	int w_final, h_final;
	int w1, h1, w2, h2;
	int *m1;
	int *m2;
	int *m_final;
	int *p;

	// Read m1
	scanf("%d %d", &h1, &w1);

	// allocate memory for m1
	m1 = (int *)malloc(sizeof(int) * h1 * w1);

	// Read m1
	for (p = m1; p < m1 + h1 * w1; p++)
		scanf("%d", p);

	// Read m2
	scanf("%d %d", &h2, &w2);

	// allocate memory for m2
	m2 = (int *)malloc(sizeof(int) * h2 * w2);

	// Read m2
	for (p = m2; p < m2 + h2 * w2; p++)
		scanf("%d", p);

	//
	w_final = w2;
	h_final = h1;
	if (w1 != h2)
	{
		// The number of columns of the 1st matrix must equal the number of rows of the 2nd matrix.
		free(m1);
		free(m2);
		exit(1);
	}
	// allocate memory for matrix
	m_final = (int *)malloc(sizeof(int) * h_final * w_final);

	// Printing out the matrixes to check them 
	for (p = m1; p < m1 + h1 * w1; p++)
		printf("%d ", *p);
	printf("\n");
	for (p = m2; p < m2 + h2 * w2; p++)
		printf("%d ", *p);
	printf("\n");
	

	// call matmul function
	matmul(h1, w1, m1, h2, w2, m2, m_final);

	// print result
	int i, j;
	printf("%d %d\n", h_final, w_final);
	for (i = 0; i < h_final; i++)
	{
		for (j = 0; j < w_final; j++)
		{
		printf("%d", m_final[i * w_final + j]);
		if (j != w_final - 1)
			printf(" ");
		}
		printf("\n");
	}

	free(m1);
	free(m2);
	free(m_final);
}