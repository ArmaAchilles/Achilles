#include <iostream>
#include <string>
#include <cstring>
#include "regex.h"

int main()
{
	const char function[] = "boolean";
	const char str[] = "I'm in here!";
	const char expr[] = "/\\sIn\\s/i";
	const char *argArray[2] = { str, expr };
	int argCnt = 2;
	const int outputSize = 1024;
	char output[outputSize] = {0};
	RVExtensionArgs(output, outputSize, function, argArray, argCnt);
	printf("\"regex.dll\" callExtension [\"%s\", [\"%s\", \"%s\"]]\n", function, expr, str);
	printf("would return \"%s\"", output);
	return 0;
}
