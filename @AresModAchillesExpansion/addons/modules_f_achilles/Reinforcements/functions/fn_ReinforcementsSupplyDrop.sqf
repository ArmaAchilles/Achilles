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

if (!(_object isKindOf "Helicopter")) exitWith {[localize "STR_NO_HELICOPTER_SELECTED"] call Achilles_fnc_showZeusErrorMessage};
if (isNull (driver _object)) exitWith {[localize "STR_HELICOPTER_NEEDS_DRIVER"] call Achilles_fnc_showZeusErrorMessage};

private _LZs = ["LZ"] call Achilles_fnc_getAllLZsOrRPs;
if (count (_LZs select 0) == 0) exitWith {[localize "STR_NO_LZ"] call Achilles_fnc_showZeusErrorMessage};

if (!isNull (getSlingLoad _object)) exitWith {[localize "STR_CARGO_ALREADY_ATTACHED"] call Achilles_fnc_showZeusErrorMessage};

private _ammoCratesDisplayName = [];
private _ammoCrates = ["B_supplyCrate_F", "O_supplyCrate_F", "I_supplyCrate_F", "IG_supplyCrate_F", "C_supplyCrate_F", "C_T_supplyCrate_F"];
{_ammoCratesDisplayName pushBack (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _ammoCrates;

//TODO: Possibly add option to spawn a helicopter
//TODO: Maybe add vehicles as well
//TODO: Add option to stay at or leave the LZ
private _dialogResult =
[
	localize "STR_SUPPLY_DROP",
	[
		["Ammunition Crate", _ammoCratesDisplayName],
		[localize "STR_CARGO_LW", [localize "STR_DEFAULT", localize "STR_EDIT_CARGO", localize "STR_EMPTY"]],
		[localize "STR_LZ_DZ", (_LZs select 1)]
	]
] call Ares_fnc_showChooseDialog;
if (count _dialogResult == 0) exitWith {};

private _objectDriver = driver _object;
private _objectGroup = group _objectDriver;

_objectDriver setSkill 1;
_objectGroup allowFleeing 0;

_dialogResult params ["_ammoCrateDisplayName", "_fillType", "_LZ"];

private _ammoCrateClassname = _ammoCrates select _ammoCrateDisplayName;

private _box = _ammoCrateClassname createVehicle (getPos _object);
[[_box]] call Ares_fnc_AddUnitsToCurator;

switch (_fillType) do
{
	case 1:
	{
		//TODO: This works, but can't tell it to edit the boxes inventory
		createDialog "RscDisplayAttributeInventory";
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
if (!_hasAttached) exitWith {[localize "STR_FAILED_TO_ATTACH_CARGO"] call Achilles_fnc_showZeusErrorMessage; deleteVehicle _box};

private _LZWaypoint = _objectGroup addWaypoint [(getPos ((_LZs select 0) select _LZ)), 20];
_objectGroup setSpeedMode "FULL";
_LZWaypoint setWaypointType "UNHOOK";
_objectGroup addWaypoint [(getPos _object), 0];

#include "\achilles\modules_f_ares\module_footer.hpp"