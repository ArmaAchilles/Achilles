////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 2/4/17
//	VERSION: 4.0
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
	if (_component == "") then {_component = _allHitPointsDamage select 1 select _i};
	_entries pushBack [_component,"SLIDER"];
};

_dialogResult = 
[
	"Damage Components",
	_entries,
	"Achilles_fnc_RscDisplayAtttributes_DamageComponents"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;

if (local _vehicle) then
{
	{
		{
			_x setHitIndex [_forEachIndex,_x];
		} forEach _dialogResult;
	} forEach _curatorSelected;
} else
{
	{
		[[_x,_dialogResult],
		{
			_vehicle = _this select 0;
			_attribute_values = _this select 1;
			{
				_vehicle setHitIndex [_forEachIndex,_x];
			} forEach _attribute_values;
		}] remoteExec ["spawn",_x];
	} forEach _curatorSelected;
};