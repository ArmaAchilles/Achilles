#include <iostream>
#include <fstream>
#include <cstring>
#include "main.hpp"

ACHILLES_SQE_API void __stdcall RVExtension(char *output, int outputSize, const char *function)
{
	std::strncpy(output, "Hello World!", outputSize - 1);
};

ACHILLES_SQE_API int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **argv, int argc)
{
	std::strncpy(output, "Hello World!", outputSize - 1);
	return EXIT_SUCCESS;
};

ACHILLES_SQE_API void __stdcall RVExtensionVersion(char *output, int outputSize)
{
	std::strncpy(output, "v1", outputSize - 1);
};
