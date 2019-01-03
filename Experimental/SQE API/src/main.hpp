#pragma once
#define ACHILLES_SQE_API __declspec(dllexport)

extern "C"
{
	ACHILLES_SQE_API void __stdcall RVExtension(char *output, int outputSize, const char *function);
	ACHILLES_SQE_API int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **argv, int argc);
	ACHILLES_SQE_API void __stdcall RVExtensionVersion(char *output, int outputSize);
};

extern std::atomic<bool> is_working;
extern std::string file_path;
extern std::mutex thread_lock;
extern std::thread worker_thread;
extern std::string data;
