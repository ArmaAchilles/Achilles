#include "achilles_test_dll.h"

void __stdcall __X86UP(RVExtension) (char *output, int outputSize, const char *function)
{
	int itmp;
	char stmp[64];
	
	sprintf_s(stmp, _TRUNCATE, ">>>ACHILLES RULES!<<< (%s; outputSize=%d)", ARCHITECTURE, outputSize);
	strncpy_s(output, outputSize, stmp, _TRUNCATE);
}