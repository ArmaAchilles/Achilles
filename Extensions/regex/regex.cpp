#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <iostream>
#include <string>
#include <regex>
#include "regex.h"

BOOL APIENTRY DllMain( HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{
	switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
	}
	return TRUE;
}

void replace(std::string str, std::string oldExpr, std::string newExpr)
{
	size_t idx = 0;
	while (idx < str.length())
	{
		idx = str.find(oldExpr, idx);
		if (idx == std::string::npos) break;
		str.replace(idx, oldExpr.length(), newExpr);
		idx += oldExpr.length();
	}
}

int __stdcall RVExtensionArgs(char *output, int outputSize, const char *function, const char **args, int argCnt)
{
	// declare common regex variables
	std::smatch matches;
	std::regex compRe;
	// inidialize output
	std::string out = "";
	// check argument count
	if (argCnt < 2)
	{
		out += "Error: too few arguments (";
		out += std::to_string(argCnt);
		out += " instead of 2)";
		out.copy(output, outputSize);
		return 1;
	}
	// get arguments
	std::string str(args[1]);
	// extract data from php-style regex syntax
	std::string rawExpr(args[0]);
	std::string del(args[1], 1);
	compRe = std::regex(del + std::string("(.*)") + del + std::string("(.*)"));
	std::regex_match(rawExpr, matches, compRe);
	std::string re(matches.str(1));
	// translate php regex flags
	std::regex_constants::syntax_option_type flags = std::regex_constants::ECMAScript;
	for(char& flag : matches.str(2)) {
		switch (flag)
		{
			case 'i': // case insensitive
				flags = flags | std::regex_constants::icase;
				break;
			/*
			case 'm': // multi line
				replace(re, "^", "[^|\n]");
				replace(re, "$", "[$|\n|\r]");
				break;
			*/
			default:
				out += "Error: the flag '";
				out += flag;
				out += "' is not available";
				out.copy(output, outputSize);
				return 1;
		}
	}
	compRe = std::regex(re, flags);
	// apply the regex function
	if (std::strcmp(function, "bool") == 0 || std::strcmp(function, "boolean") == 0)
	{
		out = std::regex_search(str, matches, compRe) ? "true" : "false";
	}
	else if (std::strcmp(function, "search") == 0)
	{
		out += "Eror: search is not yet available";
	}
	else if (std::strcmp(function, "match") == 0)
	{
		out += "Eror: match is not yet available";
	}
	else if (std::strcmp(function, "replace") == 0)
	{
		if (argCnt < 3)
		{
			out += "Error: too few arguments (";
			out += std::to_string(argCnt);
			out += " instead of 3)";
			out.copy(output, outputSize);
			return 1;
		}
		out += "Eror: replace is not yet available";
	}
	else if (std::strcmp(function, "help") == 0)
	{
		out += "Eror: Help is not yet available";
	}
	else
	{
		out += "Error: ";
		out += function;
		out += " does not exist";
	}
	// copy the result to the output
	out.copy(output, outputSize);
	return 0;
}
