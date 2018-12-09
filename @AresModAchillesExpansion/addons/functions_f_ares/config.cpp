class CfgPatches
{
	class Achilles_Functions_F_Ares
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Anton Struyk";
		authorUrl = "https://github.com/astruyk/";
		version = 1.8.1;
		versionStr = "1.8.1";
		versionAr[] = {1,8,1};
		
		units[] = {};
		
		requiredAddons[] = 
		{
			"A3_UI_F",
			"A3_UI_F_Curator",
			"A3_Functions_F",
			"A3_Functions_F_Curator",
			"A3_Modules_F",
			"A3_Modules_F_Curator",
			"Achilles_Language_F"
		};
	};
};

#include "cfgFunctions.hpp"