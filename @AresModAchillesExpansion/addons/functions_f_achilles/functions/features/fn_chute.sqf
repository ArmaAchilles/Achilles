////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on cobra4v320's Ai HALO Jump script)
//	DATE: 5/15/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_chute.sqf
//  DESCRIPTION: 	THIS FUNCTION HAS TO BE EXECUTED WHERE THE UNIT IS LOCAL!!!
//					force unit to eject aircraft and use chute (AI) or HALO (player)
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- unit that performs the para drop
//  _this select 1:		SCALAR	- delay in seconds befor starting the air drop
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[player,3] spawn Achilles_fnc_chute;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_unit", "_delay"];

sleep _delay;

if (!isPlayer _unit) then
{
	// for AI units
	private _id = _unit addEventHandler ["HandleDamage",{[_this select 2, 0] select (_this select 4 == "")}];
	moveOut _unit;
	unassignVehicle _unit;
	[_unit] orderGetIn false;

	private _backpackClass = backpack _unit;
	if (_backpackClass != "") then
	{
		private _container = backpackContainer _unit;
		private _weapon_cargo = getWeaponCargo _container;
		private _magazine_cargo = getMagazineCargo _container;
		private _item_cargo = getItemCargo _container;
		removeBackpack _unit;
		waitUntil {sleep 1; !alive _unit || getPos _unit select 2 < 150};
		private _chuteClass = ["b_parachute", _backpackClass] select (getText (configfile >> "CfgVehicles" >> _backpackClass >> "backpackSimulation") isEqualTo "ParachuteSteerable");
		_unit addBackpack _chuteClass;
		_unit action ["openParachute"];
		_unit addBackpack _backpackClass;
		_container = backpackContainer _unit;
		{_container addWeaponCargo [_x, (_weapon_cargo select 1) select _forEachIndex]} forEach (_weapon_cargo select 0);
		{_container addMagazineCargo [_x, (_magazine_cargo select 1) select _forEachIndex]} forEach (_magazine_cargo select 0);
		{_container addItemCargo [_x, (_item_cargo select 1) select _forEachIndex]} forEach (_item_cargo select 0);
	} else
	{
		waitUntil {sleep 1; !alive _unit || getPos _unit select 2 < 150};
		_unit addBackpack "b_parachute";
		_unit action ["openParachute"];				
	};
	// prevent AI to be killed by fall damage
	waitUntil {isTouchingGround _unit or (!alive _unit)};
	_unit removeEventHandler ["HandleDamage",_id];

} else
{
	// for player units
	_unit action ["Eject", vehicle _unit];
	private _backpack_class = backpack _unit;

	// if the unit already have a chute
	if (backpack _unit != "" and {getText (configfile >> "CfgVehicles" >> backpack _unit >> "backpackSimulation") isEqualTo "ParachuteSteerable"}) then {_backpack_class = "";};

	if (_backpack_class != "") then
	{
		private _container = backpackContainer _unit;
		private _weapon_cargo = getWeaponCargo _container;
		private _magazine_cargo = getMagazineCargo _container;
		private _item_cargo = getItemCargo _container;
		removeBackpack _unit;
		_unit addBackpack "b_parachute";
		private _packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"];
		_packHolder addBackpackCargoGlobal [_backpack_class, 1];
		waitUntil {animationState _unit == "HaloFreeFall_non" or (!alive _unit)};
		_packHolder attachTo [_unit,[-0.12,-0.02,-.74],"pelvis"];
		[_packHolder, [[0,-1,-0.05],[0,0,-1]]] remoteExecCall ["setVectorDirAndUp", 0, _packHolder];
		waitUntil {animationState _unit == "para_pilot" or (!alive _unit)};
		_packHolder attachTo [vehicle _unit,[-0.07,0.67,-0.13],"pelvis"];
		[_packHolder, [[0,-0.2,-1],[0,1,0]]] remoteExecCall ["setVectorDirAndUp", 0, _packHolder];

		waitUntil {isTouchingGround _unit or (getPos _unit select 2) < 1 or (!alive _unit)};
		deleteVehicle _packHolder;
		_unit addBackpack _backpack_class;
		_container = backpackContainer _unit;
		{_container addWeaponCargo [_x, (_weapon_cargo select 1) select _forEachIndex]} forEach (_weapon_cargo select 0);
		{_container addMagazineCargo [_x, (_magazine_cargo select 1) select _forEachIndex]} forEach (_magazine_cargo select 0);
		{_container addItemCargo [_x, (_item_cargo select 1) select _forEachIndex]} forEach (_item_cargo select 0);
	} else
	{
		_unit addBackpack "b_parachute";
	};
};
