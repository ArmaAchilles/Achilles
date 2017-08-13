/******************************************************************************************************************************
* Checks if dll can be loaded
* Based on https://forums.bistudio.com/forums/topic/193084-building-extensions-on-mingw/?do=findComment&comment=3073199
/*****************************************************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <Windows.h>

// dll postfix and proc address name
#if defined(__amd64__)
	#define ARCHITECTURE "64bit"
	#define DLL_POSTFIX "_x64.dll" 
	#define RV_EXTENSION_PROC_ADDRESS "RVExtension"
#else
	#define ARCHITECTURE "32bit"
	#define DLL_POSTFIX ".dll"
	#define RV_EXTENSION_PROC_ADDRESS "_RVExtension@12"
#endif

int main()
{
	HMODULE module = LoadLibrary( "achilles_test_dll" DLL_POSTFIX );
	// dump binary
	system("nm achilles_test_dll" DLL_POSTFIX "> nm" ARCHITECTURE ".log 2>&1&");
	if (!module)
	{
		printf_s("Error: Could not load module!\n");
		return EXIT_FAILURE;
	}
	
	FARPROC farproc = GetProcAddress(module, RV_EXTENSION_PROC_ADDRESS);
	
	if (!farproc)
	{
		printf_s("Error: Could not find function!\n");
		return EXIT_FAILURE;
	}
	
	char buffer[10240];
	buffer[0] = 0;
	(*farproc)(buffer, sizeof(buffer), "my extension arguments");
	printf_s("%s\n", buffer);
	
	return EXIT_SUCCESS;
}