class CfgPatches
{
	class achilles_data_f_ares
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Anton Struyk";
		authorUrl = "https://github.com/astruyk/";
		version = 1.8.1;
		versionStr = "1.8.1";
		versionAr[] = {1,8,1};
		
		units[] = {};
		requiredAddons[] = {};
	};
};

class CfgGroups
{
	#include "Compositions\compositions.hpp"
};

class CfgVehicles
{
	#include "config\cfgVehiclesSortingOverrides.hpp"
};

class CfgWeapons
{
	#include "config\cfgWeaponsSortingOverrides.hpp"
};