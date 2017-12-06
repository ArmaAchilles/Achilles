#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>
#include "achilles_test_dll.h"

int main(void)
{
	int outputSize = 100;
	char output[outputSize];
	
	__X86UP(RVExtension) (output, outputSize, "Test");
	printf_s("%s\n", output);
	
	return EXIT_SUCCESS;
}