////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/12/17
//	VERSION: 1.0
//  DESCRIPTION: Function that is executed when reloading the interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (isNull (findDisplay 312)) exitWith 
{
	Achilles_var_reloadDisplay = nil;
	Achilles_var_reloadVisionModes = nil;
};

if (not isNil "Achilles_var_reloadDisplay") then
{
	// reload display
	cutText ["","BLACK OUT", 0.1,true];
	uiSleep 0.1;
	(findDisplay 312) closeDisplay 0;
	uiSleep 0.1;
	openCuratorInterface;
	cutText ["","BLACK IN", 0.1, true];
	Achilles_var_reloadDisplay = nil;
};

if (not isNil "Achilles_var_reloadVisionModes") then
{
	[] call Achilles_fnc_setCuratorVisionModes;
	Achilles_var_reloadVisionModes = nil;
};