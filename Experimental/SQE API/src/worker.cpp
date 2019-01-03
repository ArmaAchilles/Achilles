#include <thread>
#include <atomic>
#include <mutex>
#include <chrono>
#include "main.hpp"
#include "worker.hpp"

void worker(std::string& file_path)
{
	for(int i=0; i<=10; i++)
	{
		thread_lock.lock();
		data += "This is line number " + std::to_string(i) + "\n";
		thread_lock.unlock();
		std::this_thread::sleep_for(std::chrono::milliseconds(20));
	};
	is_working = false;
};
