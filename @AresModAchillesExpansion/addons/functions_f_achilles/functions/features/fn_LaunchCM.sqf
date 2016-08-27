////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/7/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_LaunchCM.sqf
//  DESCRIPTION: function that force vehicle to lauch countermeasure (CM).
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- Vehicle that launches the CM.
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	["INIT",_vehicle] call Achilles_fnc_LaunchCM;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define ALL_SL_WEAP_CLASSES ["SmokeLauncher","rhs_weap_smokegen","rhs_weap_902a","rhs_weap_902b","rhsusf_weap_M259"]
#define ALL_CM_WEAP_CLASSES ["CMFlareLauncher","rhs_weap_CMFlareLauncher","rhsusf_weap_CMFlareLauncher"]


_vehicle = param [0,ObjNull,[ObjNull]];

_nameSound = if (_vehicle isKindOf "Air") then {"magazine"} else {"smokeshell"};
_weapon_classes = if (_vehicle isKindOf "Air") then {ALL_CM_WEAP_CLASSES} else {ALL_SL_WEAP_CLASSES};

if (_vehicle isKindOf "Man") exitWith
{
	_all_smoke_magazines = 
	[
		magazinesAmmoFull _vehicle,
		[],
		{_x select 0},
		"ASCEND",
		{((getText (configfile >> "CfgMagazines" >> (_x select 0) >> "nameSound")) == _nameSound) and  (_x select 2)}
	] call BIS_fnc_sortBy;
	if(count _all_smoke_magazines == 0) exitWith {["No smoke grenade avaiable!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};
	_smoke_muzzle = _all_smoke_magazines select 0 select 4;
	_vehicle forceWeaponFire [_smoke_muzzle, _smoke_muzzle];
};

_all_smoke_magazines = 
[
	magazinesAllTurrets _vehicle,
	[],
	{_x select 0},
	"ASCEND",
	{((getText (configfile >> "CfgMagazines" >> (_x select 0) >> "nameSound")) == _nameSound) and ((_x select 2) > 0)}
] call BIS_fnc_sortBy;

if(count _all_smoke_magazines == 0) exitWith {["No countermeasure avaiable!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";};

_turretPath = _all_smoke_magazines select 0 select 1;
_weapons = _vehicle weaponsTurret _turretPath;
_CM_weapons = _weapons arrayIntersect _weapon_classes;
if(count _CM_weapons == 0) exitWith {["No countermeasure avaiable!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F";}; 
_CM_weapon = _CM_weapons select 0;

if (_vehicle isKindOf "Plane") then
{
	[_vehicle,_CM_weapon] spawn
	{
		_vehicle = _this select 0;
		_CM_weapon = _this select 1;
		
		for "_i" from 1 to 12 do 
		{
			_vehicle fireAtTarget [_vehicle,_CM_weapon];
			sleep 0.1;
		};
	};
} else
{
	_vehicle fire _CM_weapon;
};

