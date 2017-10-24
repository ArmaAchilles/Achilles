////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 4/27/17
//	VERSION: 1.0
//  DESCRIPTION: Module for showing config of an object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;
if (not isNull _object) then
{
	BIS_fnc_configviewer_path = ["configfile","CfgVehicles"];
	BIS_fnc_configviewer_selected = typeOf _object;
};
[] call BIS_fnc_configviewer;

#include "\achilles\modules_f_ares\module_footer.hpp"
