#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <Windows.h>

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

__declspec(dllexport) void __stdcall __X86UP(RVExtension) (char *output, int outputSize, const char *function);