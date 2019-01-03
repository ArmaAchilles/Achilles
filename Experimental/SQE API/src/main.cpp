#include <cstring>
#include <map>
#include <thread>
#include <atomic>
#include <mutex>
#include "main.hpp"
#include "worker.hpp"

std::atomic<bool> is_working(false);
std::string data("");
std::mutex thread_lock;
std::thread worker_thread;
int reader_offset = 0;

ACHILLES_SQE_API void __stdcall RVExtension(char* output, int outputSize, const char* function)
{
	std::strncpy(output, "Hello World!", outputSize);
};

ACHILLES_SQE_API int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char **argv, int argc)
{
	enum functions
	{
		init,
		request,
		read
	};
	static std::map<std::string, int> functions_map;
	functions_map["init"] = init;
	functions_map["request"] = request;
	functions_map["read"] = read;
	
	switch(functions_map[std::string(function)])
	{
		case init:
		{
			return 0;
		};
		
		case request:
		{
			thread_lock.lock();
			// clear earlier request	
			reader_offset = 0;
			data.clear();
			// Spawn worker thread
			is_working = true;
			std::string category_name(argv[0]);
			std::string item_name(argv[1]);
			std::string file_path = category_name + "\\" + item_name;
			thread_lock.unlock();
			worker_thread = std::thread(worker, std::ref(file_path));
			worker_thread.detach();
			return 0;
		};
		
		case read:
		{
			thread_lock.lock();
			int data_len = data.length();
			int chunk_size = std::min(outputSize, data_len - reader_offset) - 1;
			if (chunk_size > 0)
			{
				
				std::strncpy(output, data.substr(reader_offset, chunk_size).c_str(), chunk_size);
				reader_offset += chunk_size;
			};
			if (is_working || data_len > reader_offset + 1)
			{
				thread_lock.unlock();
				return 0;
			}
			else
			{
				thread_lock.unlock();
				return 1;
			};
		};
		default:
		{
			return 2;
		};
	};
};

ACHILLES_SQE_API void __stdcall RVExtensionVersion(char* output, int outputSize)
{
	std::strncpy(output, "v1", outputSize);
};
