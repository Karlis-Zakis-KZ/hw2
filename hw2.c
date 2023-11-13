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

	for (p = m1; p < m1 + h1 * w1; p++)
		scanf("%d", p);

	// Print m1
	for (p = m1; p < m1 + h1 * w1; p++) {
		printf("%d ", *p);
		if ((p - m1 + 1) % w1 == 0)
			printf("\n");
	}
}