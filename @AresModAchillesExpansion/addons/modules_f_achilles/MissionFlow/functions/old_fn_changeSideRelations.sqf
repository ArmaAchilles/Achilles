/*
	Author: CreepPork_LV

	Description:
		Change what sides are going to be friendly.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

_bluforSelectNumber = 3;

if ([blufor, independent] call BIS_fnc_sideIsFriendly) then
{
	_bluforSelectNumber = 3;
}
else
{
	_bluforSelectNumber = 4;
};

_dialogResult = 
[
	localize "STR_CHANGE_SIDE_RELATIONS",
	[
		[localize "STR_SIDE", ["OPFOR", "BLUFOR", localize "STR_INDEPENDENT"], 1],
		[localize "STR_FRIENDLY_TO", ["OPFOR", "BLUFOR", localize "STR_INDEPENDENT", localize "STR_NOBODY"], _bluforSelectNumber]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_firstSelectedSide = _dialogResult select 0;
_secondSelectedSide = _dialogResult select 1;

_firstSelectedSide = _firstSelectedSide + 1;
_secondSelectedSide = _secondSelectedSide + 1;

if (_firstSelectedSide == _secondSelectedSide) exitWith {[localize "STR_SIDES_CANT_MATCH"] call Achilles_fnc_ShowZeusErrorMessage};

_firstSelectedSide = switch (_firstSelectedSide) do 
{
	case 1: {"opfor"};
	case 2: {"blufor"};
	case 3: {"independent"};
};

_secondSelectedSide = switch (_secondSelectedSide) do 
{
	case 1: {"opfor"};
	case 2: {"blufor"};
	case 3: {"independent"};
	case 4: {"nobody"};
};

player getVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", [blufor, opfor] call BIS_fnc_sideIsFriendly];
player getVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", [blufor, independent] call BIS_fnc_sideIsFriendly];
player getVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", [independent, opfor] call BIS_fnc_sideIsFriendly];

switch (_firstSelectedSide) do 
{
	case "blufor": 
	{
		switch (_secondSelectedSide) do 
		{
			case "opfor": 
			{
				if (player getVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", [blufor, opfor] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_BLUFORfriendlyToOPFOR;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", false];
				}
				else
				{
					[true] call Achilles_fnc_BLUFORfriendlyToOPFOR;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", true];
				};
			};
			case "independent": 
			{
				if (player getVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", [blufor, independent] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_BLUFORfriendlyToIndependents;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", false];
				}
				else
				{
					[true] call Achilles_fnc_BLUFORfriendlyToIndependents;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", true];
				};
			};
			case "nobody":
			{
				[false] call Achilles_fnc_BLUFORfriendlyToOPFOR;
				player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", false];

				[false] call Achilles_fnc_BLUFORfriendlyToIndependents;
				player setVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", false];
			};
		};
	};
	case "opfor": 
	{
		switch (_secondSelectedSide) do 
		{
			case "blufor": 
			{
				if (player getVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", [blufor, opfor] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_BLUFORfriendlyToOPFOR;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", false];
				}
				else
				{
					[true] call Achilles_fnc_BLUFORfriendlyToOPFOR;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", true];
				};
			};
			case "independent":
			{
				if (player getVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", [independent, opfor] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_OPFORfriendlyToIndependents;
					player setVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", false];
				}
				else
				{
					[true] call Achilles_fnc_OPFORfriendlyToIndependents;
					player setVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", true];
				};
			};
			case "nobody":
			{
				[false] call Achilles_fnc_BLUFORfriendlyToOPFOR;
				player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", false];
				
				[false] call Achilles_fnc_OPFORfriendlyToIndependents;
				player setVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", false];
			};
		};
	};
	case "independent": 
	{
		switch (_secondSelectedSide) do 
		{
			case "blufor": 
			{
				if (player getVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", [blufor, independent] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_BLUFORfriendlyToIndependents;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToIndependents", false];
				}
				else
				{
					[true] call Achilles_fnc_BLUFORfriendlyToIndependents;
					player setVariable ["Achilles_var_BLUFORIsFriendlyToOPFOR", true];
				};
			};
			case "opfor": 
			{
				if (player getVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", [independent, opfor] call BIS_fnc_sideIsFriendly]) then 
				{
					[false] call Achilles_fnc_OPFORfriendlyToIndependents;
					player setVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", false];
				}
				else
				{
					[true] call Achilles_fnc_OPFORfriendlyToIndependents;
					player setVariable ["Achilles_var_IndependentsIsFriendlyToOPFOR", true];
				};
			};
			case "nobody": 
			{
				call Achilles_fnc_IndependentsNotFriendly;
			};
		};	
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"