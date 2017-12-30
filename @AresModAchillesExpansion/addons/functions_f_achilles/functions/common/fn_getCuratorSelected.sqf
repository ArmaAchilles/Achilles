////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 2/26/17
//	VERSION: 1.0
//  DESCRIPTION: Get current selected units, vehicles , waypoints or groups by curator
//
//	ARGUMENTS:
//	_this select 0:		STRING	- either "man" (units including crew), "vehicle" (vehicles), "cargo" (any object that can store items), "group" (groups), "wp" (waypoints)
//
//	RETURNS:
//	_this:				ARRAY	- array of selected objects, waypoints or groups
//
//	Example:
//	["man"] call Achilles_fnc_getCuratorSelected;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_unaddedCrew"];
private _mode = toLower param [0, "man",[""]];

switch (_mode) do
{
	case "man":
	{
        private _selected = (curatorSelected select 0) select {_x isKindOf "Man"};
	    {
				_unaddedCrew = (crew _x) select {!(_x in _selected)};
				_selected append _unaddedCrew;
		} forEach ((curatorSelected select 0) select {!(_x isKindOf "Man") and (_x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship")});
        _selected
	};
	case "vehicle":
	{
        (curatorSelected select 0) select { _x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship" }
	};
	case "cargo":
	{
		(curatorSelected select 0) select { getNumber (configfile >> "CfgVehicles" >> typeOf _x >> "transportMaxMagazines") > 0 }
	};
	case "object":
	{
		(curatorSelected select 0)
	};
	case "group":
	{
		(curatorSelected select 1)
	};
	case "wp":
	{
		(curatorSelected select 2)
	};
};
