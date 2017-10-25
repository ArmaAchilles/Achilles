/*
	Author: CreepPork_LV

	Description:
		Uses a created helicopter that sling loads a Supply Crate which then is taken to the destination.

	Parameters:
    	None

	Returns:
    	Nothing
*/

#include "\achilles\modules_f_ares\module_header.hpp"

private _object = [_logic, false] call Ares_fnc_getUnitUnderCursor;

//TODO: Check if isKindOf "Helicopter" works
if (getText (configFile >> "CfgVehicles" >> typeOf _object >> "simulation") != "helicopterrtd") exitWith {["No helicopter selected!"] call Achilles_fnc_showZeusErrorMessage};
if (!isNull (driver _object)) exitWith {["The helicopter needs a driver!"] call Achilles_fnc_showZeusErrorMessage};

private _LZs = [true] call Achilles_fnc_getAllLZs;
if (count _LZs == 0) exitWith {};

private _ammoCratesDisplayName = [];
private _ammoCrates = ["B_supplyCrate_F", "O_supplyCrate_F", "I_supplyCrate_F", "IG_supplyCrate_F", "C_supplyCrate_F", "C_T_supplyCrate_F"];
private _ammoCratesFromConfigDisplayName = {_ammoCratesDisplayName pushBack (getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName"))} forEach _ammoCrates;

//TODO: Localize
//TODO: Possibly add option to spawn a helicopter
//TODO: Maybe add vehicles as well
//TODO: Add option to stay at or leave the LZ
private _dialogResult =
[
	localize "STR_SUPPLY_DROP",
	[
		["Ammunition Crate", _ammoCratesDisplayName],
		["Cargo", ["Default", "Edit Cargo", "Empty"]],
		[localize "STR_LZ_DZ", _LZs]
	]
] call Ares_fnc_showChooseDialog;
if (count _dialogResult == 0) exitWith {};

private _objectDriver = driver _object;
private _objectGroup = group _objectDriver;

_objectDriver setSkill 1;
_objectGroup allowFleeing 0;

_dialogResult params ["_ammoCrateDisplayName", "_fillType", "_LZ"];

private _ammoCrateClassname = _ammoCrates select (_ammoCratesDisplayName find _ammoCrateDisplayName);

private _box = _ammoCrateClassname createVehicle (getPos _object);
[[_box]] call Ares_fnc_AddUnitsToCurator;

switch (_fillType) do 
{
	case 1:
	{
		//TODO: Check if this works
		[_this,"RscAttributeInventory",'AresDisplays'] call (uinamespace getvariable "Achilles_fnc_initCuratorAttribute");
	};
	case 2:
	{
		clearItemCargoGlobal _box;
		clearWeaponCargoGlobal _box;
		clearBackpackCargoGlobal _box;
		clearMagazineCargoGlobal _box;
	};
};

private _hasAttached = _object setSlingLoad _box;
if (!_hasAttached) exitWith {["Failed to attach the cargo!"] call Achilles_fnc_showZeusErrorMessage};

//TODO: Check if the getPos _LZ works.
private _LZWaypoint = _objectGroup addWaypoint [(getPos _LZ), 20];
_LZWaypoint setWaypointType "UNHOOK";
_objectGroup addWaypoint [(getPos _object), 0];

#include "\achilles\modules_f_ares\module_footer.hpp"