////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 2/26/17
//	VERSION: 1.0
//  DESCRIPTION: Get current selected units, vehicles or groups by curator
//
//	ARGUMENTS:
//	_this select 0:		STRING	- either "man", "vehicle" or "group"
//
//	RETURNS:
//	_this:				ARRAY	- array of selected units or groups
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
	case "group":
	{
		_selected = (curatorSelected select 1);
	};
};
_selected;