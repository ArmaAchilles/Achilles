#ifndef ARMA_REGEX_DLL_H
	#define ARMA_REGEX_DLL_H

	#ifdef __cplusplus
	extern "C" {
	#endif
	__declspec(dllexport) int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **args, int argCnt);
	#ifdef __cplusplus
	}
	#endif
#endif
