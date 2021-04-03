#include<stdio.h>
#include<stdlib.h>

__global__
void print_from_gpu()
{
	printf("Hello World! from device (GPU)\n");
}

int main(void) 
{
	printf("Hello World from host (CPU)\n");
	print_from_gpu<<<1,1>>>();
	return 0;
}

