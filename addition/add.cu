#include <stdio.h>
#include <stdlib.h>

__global__ 
void add(int *a, int *b, int *c)
{
	 *c = *a + *b;        // c[0] = a[0] + b[0];
}

int main(void) 
{
	int a = 12, b = 13, c;        // host copies
	int *d_a, *d_b, *d_c;		      // device copies

	// allocate space for device copies of a,b,c
	cudaMalloc((void **) &d_a, sizeof(int));
	cudaMalloc((void **) &d_b, sizeof(int));
	cudaMalloc((void **) &d_c, sizeof(int));

	// copy a,b from host to the device
	cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

	// launch add() kernel on GPU
	add<<<1,1>>>(d_a,d_b,d_c);

	// copy result back to host
	cudaMemcpy(&c, d_c, sizeof(int), cudaMemcpyDeviceToHost);

	printf("%d\n", c);

	// cleanup
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	return 0;
}
