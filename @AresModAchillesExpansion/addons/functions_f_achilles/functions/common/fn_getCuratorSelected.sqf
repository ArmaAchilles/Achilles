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

private ["_unaddedCrew","_intersection"];
private _mode = toLower param [0, "man",[""]];
private _selected = [];

switch (_mode) do
{
	case "man":
	{
		{
			if (_x isKindOf "Man") then
			{
				_selected pushBack _x;
			} else
			{
				if (_x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship") then
				{
					_unaddedCrew = (crew _x) select {not (_x in _selected)};
					_selected append _unaddedCrew;
				};
			};
		} forEach (curatorSelected select 0);	
	};
	case "vehicle":
	{
		{
			if (_x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship") then
			{
				_selected pushBack _x;
			};
		} forEach (curatorSelected select 0);			
	};
	case "cargo":
	{
		{
			if (getNumber (configfile >> "CfgVehicles" >> typeOf _x >> "transportMaxMagazines") > 0) then
			{
				_selected pushBack _x;
			};
		} forEach (curatorSelected select 0);		
	};
	case "object":
	{
		_selected = (curatorSelected select 0);
	};
	case "group":
	{
		_selected = (curatorSelected select 1);
	};
	case "wp":
	{
		_selected = (curatorSelected select 2);
	};
};
_selected;