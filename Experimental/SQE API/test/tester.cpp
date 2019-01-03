#include <iostream>
#include <string>
#include <exception>
#include <thread>
#include <chrono>
#include <boost/filesystem.hpp>
#include <windows.h>

#define THROW_ERROR(MSG) throw AchillesError(MSG, __FILE__, __LINE__, __func__)
class AchillesError: public std::exception
{
	protected:
		std::string msg;
		std::string file;
		int line;
		std::string func;
    
    public:
    	AchillesError(std::string _msg, std::string _file, int _line, std::string _func):
        	file(_file),
        	line(_line),
        	func(_func)
		{
			msg = "Error: " + _msg + "\nFile " + file + ", " + "line " + std::to_string(line) + ", in function \"" + func + "\".\n";
		};
		
		virtual char const* what() const noexcept
		{
			return msg.c_str();
		};
};

#define LOAD_API(PATH) \
	base_address = LoadLibrary(PATH); \
	if (!base_address) {THROW_ERROR("Unable to load dynamic linked library \"" + path + "\"!");}

#define LOAD_API_FUNCTION(NAME,SYMBOL) \
	NAME = (NAME##_t)GetProcAddress(base_address, SYMBOL); \
	if (!NAME) {THROW_ERROR("Unable to load function " #SYMBOL "!");}

#define DECLARE_API_FUNCTION(RETTYPE, NAME, ARGS) \
	typedef RETTYPE (__stdcall* NAME##_t)ARGS; NAME##_t NAME

#define UNLOAD_API \
	FreeLibrary(base_address)

class A3Extension
{
	protected:
		std::string path;
		HMODULE base_address;
	
	public:
		A3Extension(std::string _path):
			path(_path)
		{
			LOAD_API(path.c_str());
			#if __x86_64__
				LOAD_API_FUNCTION(RVExtension,"RVExtension");
				LOAD_API_FUNCTION(RVExtensionArgs,"RVExtensionArgs");
				LOAD_API_FUNCTION(RVExtensionVersion,"RVExtensionVersion");
			#else
				LOAD_API_FUNCTION(RVExtension,"RVExtension@12");
				LOAD_API_FUNCTION(RVExtensionArgs,"RVExtensionArgs@20");
				LOAD_API_FUNCTION(RVExtensionVersion,"RVExtensionVersion@8");
			#endif
		};
		DECLARE_API_FUNCTION(void,RVExtension,(char *output, int outputSize, const char *function));
		DECLARE_API_FUNCTION(int,RVExtensionArgs,(char *output, int outputSize, const char *function, const char **argv, int argc));
		DECLARE_API_FUNCTION(void,RVExtensionVersion,(char *output, int outputSize));
		~A3Extension()
		{
			UNLOAD_API;
		};
};

int main(int argc, char** argv)
{
	try
	{
		int ret;
		
		if (argc != 2) {THROW_ERROR("Expects 1 command line argument, " + std::to_string(argc - 1) + " were given.");};
		// Load API
		std::string api_path(argv[1]);
		if (!boost::filesystem::exists(api_path)) {THROW_ERROR(api_path + " was not found!");};
		A3Extension AchillesSqeApi(api_path);
		// initialize arguments passed to RVExtension
		char output[20] = {0};
		int outputSize = 20;
		const char function[] = "MyFunction";
		const char cat[] = "MyCat"; 
		const char item[] = "MyItem"; 
		const char* args[] = {"MyCat", "MyItem"};
		const int argv = 2;
		// Call RVExtension and return output
		AchillesSqeApi.RVExtension(output, outputSize, function);
		std::clog << "Loaded " << api_path << std::endl << "RVExtension returns:" << std::endl << output << std::endl << std::endl;
		std::memset(output, 0, outputSize);
		AchillesSqeApi.RVExtensionArgs(output, outputSize, "init", args, argv); std::clog << "\"init\" returns " << output << std::endl;
		std::memset(output, 0, outputSize);
		AchillesSqeApi.RVExtensionArgs(output, outputSize, "request", args, argv); std::clog << "\"request\" returns " << output << std::endl;
		std::clog << "\"read\" returns " << std::endl;
		do
		{
			std::memset(output, 0, outputSize);
			ret = AchillesSqeApi.RVExtensionArgs(output, outputSize, "read", args, argv); std::clog << output;
			std::this_thread::sleep_for(std::chrono::milliseconds(20));
		}
		while(ret == 0);
		std::clog << std::endl;
	}
	catch (std::exception& e)
	{
		std::cerr << e.what() << std::endl;
		return EXIT_FAILURE;
	};
	return EXIT_SUCCESS;
};