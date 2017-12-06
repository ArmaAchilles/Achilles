////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 7/23/17
//	VERSION: 5.0
//  DESCRIPTION: opens the "damage components" dialog for vehicles.
//
//	ARGUMENTS:
//	_this select 0		_vehicle (optional)
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_vehicle] call Achilles_fnc_damageComponents;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// get params
_vehicle = _this select 0;

_entries = [];

_allHitPointsDamage = getAllHitPointsDamage _vehicle;

for "_i" from 0 to (count (_allHitPointsDamage select 0) - 1) do
{
	_component = _allHitPointsDamage select 0 select _i;
	_damage_value = _allHitPointsDamage select 2 select _i;
	if (_component == "") then {_component = _allHitPointsDamage select 1 select _i};
	_entries pushBack ["SLIDER", _component, [], _damage_value, true];
};

_attribute_values = 
[
	localize "STR_DAMAGE_COMPONENTS",
	_entries
] call Achilles_fnc_ShowChooseDialog;

if (count _attribute_values == 0) exitWith {};

_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;

if (local _vehicle) then
{
	{
		_vehicle = _x;
		{
			_vehicle setHitIndex [_forEachIndex, _x];
		} forEach _attribute_values;
	} forEach _curatorSelected;
} else
{
	{
		_vehicle = _x;
		{
			[_vehicle, [_forEachIndex, _x]] remoteExecCall ["setHitIndex", _vehicle];
		} forEach _attribute_values;
	} forEach _curatorSelected;
};