
#include "\achilles\modules_f_ares\module_header.inc.sqf"

// get the unit
private _unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// get effects
private _classNames = (configfile >> "CfgVehicles" >> "ModuleChemlight_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
_classNames pushBack "ModuleIRGrenade_F";
private _displayNames = [localize "STR_AMAE_NONE"];
private _ammoClasses = [];
{
	_displayNames pushBack getText (configfile >> "CfgVehicles" >> _x >> "displayName");
	_ammoClasses pushBack getText (configfile >> "CfgVehicles" >> _x >> "ammo");
} forEach _classNames;

private _units = [];
private _ammoIdx = 0;
if (isNull _unitUnderCursor) then
{
	// module was not placed on an unit
	private _dialogResult =
	[
		localize "STR_AMAE_ATTACH_DETACH_EFFECT",
		[
			[localize "STR_AMAE_MODE",[localize "STR_AMAE_ALL",localize "STR_AMAE_SELECTION",localize "STR_AMAE_SIDE"]],
			[localize "STR_AMAE_SIDE","SIDE"],
			[localize "STR_EFFECT", _displayNames]
		],
		"Achilles_fnc_RscDisplayAttributes_selectAIUnits"
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

	_units = switch (_dialogResult select 0) do
	{
		case 0:
		{
			allUnits select {alive _x};
		};
		case 1:
		{
			private _selection = [toLower localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_selection select {alive _x};
		};
		case 2:
		{
			private _side_index = _dialogResult select 1;
			private _side = [east,west,independent,civilian] select (_side_index - 1);
			allUnits select {(alive _x) and (side _x == _side)};
		};
	};

	if (isNil "_units") exitWith {};
	if (_units isEqualTo []) exitWith { [localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage };
	_ammoIdx = _dialogResult select 2;
}
else
{
	// module was placed on an unit
	private _dialogResult =
	[
		localize "STR_AMAE_ATTACH_DETACH_EFFECT",
		[
			[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_ENTIRE_GROUP", localize "STR_AMAE_SELECTED_PLAYER"]],
			[localize "STR_EFFECT", _displayNames]
		]
	] call Ares_fnc_ShowChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};

    _units = [units (group _unitUnderCursor), [_unitUnderCursor]] select (_dialogResult select 0);
	_ammoIdx = _dialogResult select 1;
};

if (isNil "_units") exitWith {};
{
	private _unit = _x;
	// detach old effects
	{
		private _attachedObject = _x;
		if (_attachedObject isKindOf "GrenadeHand") then
		{
			detach _attachedObject;
			deleteVehicle _attachedObject;
		};
	} forEach (attachedObjects _unit);
	// attach new effects
	if (_ammoIdx > 0) then
	{
		private _effect = (_ammoClasses select (_ammoIdx - 1)) createVehicle [0,0,0];
		_effect attachTo [_unit, [0.05,-0.09,0.1], "LeftShoulder"];
	};
} forEach _units;

[localize "STR_AMAE_APPLIED_MODULE_TO_X_UNITS", count _units] call Ares_fnc_ShowZeusMessage;
#include "\achilles\modules_f_ares\module_footer.inc.sqf"
