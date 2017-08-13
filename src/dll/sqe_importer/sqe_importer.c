#include "achilles.h"

void __stdcall __X86UP(RVExtension) (char *output, int outputSize, const char *function)
{
	strncpy_s(output, outputSize, "ACHILLES RULES!", _TRUNCATE);
}