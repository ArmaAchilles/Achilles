#ifndef ACHILLES_TEST_DLL  
	#define ACHILLES_TEST_DLL_API __declspec(dllexport) 
	#define ACHILLES_TEST_DLL
#else  
	#define ACHILLES_TEST_DLL_API __declspec(dllimport)   
#endif

#if defined(__amd64__)
	#define ARCHITECTURE "64bit"
	#define __X86UP(fnc) fnc
#else
	#define ARCHITECTURE "32bit"
	#ifdef __MINGW32__	// workaround mingw-w64: adding manually (U)nderscore (P)refix to 32 bit version
		#define __X86UP(fnc) _ ## fnc
	#else
		#define __X86UP(fnc) fnc
	#endif
#endif

#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>

ACHILLES_TEST_DLL_API void __stdcall __X86UP(RVExtension) (char *output, int outputSize, const char *function);