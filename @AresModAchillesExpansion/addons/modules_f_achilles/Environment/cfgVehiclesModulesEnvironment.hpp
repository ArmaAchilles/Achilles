class Achilles_Environment_Module_Base : Achilles_Module_Base
{
	//subCategory = "$STR_ENVIRONMENT";
	Category = "Environment";
};

class Achilles_Set_Weather_Module : Achilles_Environment_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Set_Weather_Module";
	displayName = "$STR_ADVANCED_WEATHER_CHANGE";
	function = "Achilles_fnc_EnvironmentSetWeatherModule";
	icon = "\a3\Modules_F_Curator\Data\portraitWeather_ca.paa";
	portrait = "\a3\Modules_F_Curator\Data\portraitWeather_ca.paa";
};

class Achilles_Set_Date_Module : Achilles_Environment_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Set_Date_Module";
	displayName = "$STR_SET_DATE";
	function = "Achilles_fnc_EnvironmentSetDate";
	icon = "\a3\Modules_F_Curator\Data\portraitSkiptime_ca.paa";
	portrait = "\a3\Modules_F_Curator\Data\portraitSkiptime_ca.paa";
};

class Achilles_Earthquake_Module : Achilles_Environment_Module_Base
{
	scopeCurator = 2;
	_generalMacro = "Achilles_Earthquake_Module";
	displayName = "$STR_EARTHQUAKE";
	function = "Achilles_fnc_EnvironmentEarthquake";
	icon = "\achilles\data_f_achilles\icons\icon_position.paa";
	portrait = "\achilles\data_f_achilles\icons\icon_position.paa";
};