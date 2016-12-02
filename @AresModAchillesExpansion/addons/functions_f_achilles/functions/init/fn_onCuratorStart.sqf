////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/18/16
//	VERSION: 1.0
//	FILE: Achilles\main_f\functions\init\fn_init.sqf
//  DESCRIPTION: Initalization function; this function is called when the curator display is loaded for the first time
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// trick to unlock module addons for Zeus (part 1)
if (isNil "Achilles_fnc_serverInitDone") then
{
	_logic = (createGroup sideLogic) createUnit ["Achilles_Module_Base", getPos player, [], 0, "NONE"];
	_logic = (createGroup sideLogic) createUnit ["Ares_Module_Base", getPos player, [], 0, "NONE"];
};

// broadcast public functions
publicVariable "Ares_fnc_addIntel";
publicVariable "Ares_fnc_surrenderUnit";
publicVariable "Achilles_fnc_chute";
publicVariable "Achilles_fnc_ambientAnimGetParams";
publicVariable "Achilles_fnc_ambientAnim";
publicVariable "Achilles_fnc_setUnitAmmoDef";

// broadcase server functions
publicVariableServer "Achilles_fnc_eject_passengers";

// load basic advanced compositions
[] spawn compile preprocessFileLineNumbers "\achilles\data_f_achilles\Adcanced Compositions\Ares_var_advanced_compositions.sqf";

// Enable the selected VisionModes for Zeus
[] call Achilles_fnc_setCuratorVisionModes;

// Add curator event handlers

_curatorModule = getassignedcuratorLogic player;
_curatorModule addEventHandler ["CuratorObjectPlaced", { _this call Achilles_fnc_HandleCuratorObjectPlaced; }];
_curatorModule addEventHandler ["CuratorObjectDoubleClicked", { _this call Achilles_fnc_HandleCuratorObjectDoubleClicked; }];

// trick to unlock module addons for Zeus (part 2)
if (isNil "Achilles_fnc_serverInitDone") then
{
	[{
		{
			_x addCuratorAddons ["achilles_modules_f_achilles","achilles_modules_f_ares"]
		} forEach allCurators;
		//Achilles_fnc_serverInitDone = true; 
		//publicVariable "Achilles_fnc_serverInitDone";
		
	}, [], 2] call Ares_fnc_BroadcastCode;
};
/*
	_didRegisterForEvents = false;
{
	if ((getassignedcuratorunit _x) == player) then
	{
		["Found curator instance, registering for callbacks..."] call Ares_fnc_LogMessage;
		_x addEventHandler ["CuratorObjectPlaced", { _this call Ares_fnc_HandleCuratorObjectPlaced; }];
		_x addEventHandler ["CuratorObjectDoubleClicked", { _this call Ares_fnc_HandleCuratorObjectDoubleClicked; }];
		_didRegisterForEvents = true;
	}
	else
	{
		["Skipping curator with different assigned unit."] call Ares_fnc_LogMessage;
	}
} foreach allCurators;
*/
