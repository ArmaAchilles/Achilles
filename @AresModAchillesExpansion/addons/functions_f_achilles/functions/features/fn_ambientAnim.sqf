////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on BIS_fnc_ambientAnim and BIS_fnc_ambientAnimCombat)
//	DATE: 6/29/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_ambientAnim.sqf
//  DESCRIPTION: THIS FUNCTION HAS TO BE EXECUTED WHERE THE UNIT IS LOCAL!!!
//				 this function force AI to execute an animation in loop
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- unit that the animation performs
//	_this select 1:			STRING	- (default: "TERMINATE"); animation name; if "TERMINATE" then terminate animation loop.
//	_this select 2:			BOOL	- (default: false); true: combat ready => animation is terminated if enemies are close
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,"GUARD",true] call Achilles_fnc_ambientAnim;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// get genaral params
_unit = param [0,ObjNull,[ObjNull]];
_anim_set = param [1,"",[""]];
_combatReady = param [2,false,[false]];

//define relevant animation functions
Achilles_fnc_ambientAnim_terminate =
{
	_unit = _this;
	_noWeapon = _unit getVariable ["Achilles_var_noWeapon",false];
	if (_noWeapon) then
	{
		_primary_weapon = _unit getVariable ["Achilles_var_primWeapon",""];
		_unit addWeapon _primary_weapon;
		_unit selectWeapon _primary_weapon;
	};
	{_unit enableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];
	_unit playMoveNow "AmovPercMstpSrasWrflDnon";
	_unit setUnitPos "UP";
	_unit setVariable ["Achilles_var_animations", nil,true];
	_unit setVariable ["Achilles_var_noWeapon", nil,true];
	_ehAnimDone = _unit getVariable ["Achilles_EhAnimDone", 0];
	_unit removeEventHandler ["AnimDone", _ehAnimDone];
	_ehKilled = _unit getVariable ["Achilles_EhKilled",0];
	_unit removeEventHandler ["Killed", _ehKilled];
};

//Terminate previous animation
if (_anim_set == "TERMINATE") exitWith {_unit call Achilles_fnc_ambientAnim_terminate};
if (not isNil "Achilles_var_animations") then {_unit call Achilles_fnc_ambientAnim_terminate};

// get anim params
_params = _anim_set call Achilles_fnc_ambientAnimGetParams;
_avaiable_anims = _params param [0,[],[[]]];
_noWeapon = _params param [1, false, [false]];

if (count _avaiable_anims == 0) exitWith {};

//set animation variables
_unit setVariable ["Achilles_var_animations",_avaiable_anims,true];
_unit setVariable ["Achilles_var_noWeapon", _noWeapon,true];

//surpress the unit "intelligence"
{_unit disableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

//detach unit, if already attached to something
detach _unit;

//remove primary weapon if requested
if (_noWeapon) then
{
	_primWeapon = primaryWeapon _unit;
	_unit setVariable ["Achilles_var_primWeapon",_primWeapon,true];
	_unit removeWeapon _primWeapon;
};

//define relevant animation functions
Achilles_fnc_ambientAnim_playAnim =
{
	_unit = _this;
	_avaiable_anims = _unit getVariable ["Achilles_var_animations",""];
	
	//select a random anim from the pool of available animations and play it
	_anim = _avaiable_anims call BIS_fnc_selectRandom;
	[_unit,_anim] remoteExec ["switchMove",0];	
};

// start animation and add termination handlers
[_unit,_combatReady] spawn
{
	private["_unit","_combatReady","_ehAnimDone","_ehKilled"];

	_unit			= _this select 0;
	_combatReady	= _this select 1;

	//wait for the simulation to start
	waitUntil{time > 0};

	if (isNil "_unit") exitWith {};
	if (isNull _unit) exitWith {};
	if !(alive _unit && canMove _unit) exitWith {};

	//"smart-select" animation that is not played on nearby unit and play it
	_unit call Achilles_fnc_ambientAnim_playAnim;

	//play next anim when previous finishes
	_ehAnimDone = _unit addEventHandler
	[
		"AnimDone",
		{
			private["_unit"];

			_unit = _this select 0;

			if (alive _unit) then
			{
				_unit call Achilles_fnc_ambientAnim_playAnim;
			}
			else
			{
				_unit call Achilles_fnc_ambientAnim_terminate;
			};
		}
	];
	_unit setVariable ["Achilles_EhAnimDone", _ehAnimDone,true];

	//free unit from anim loop if it is killed
	_ehKilled = _unit addEventHandler
	[
		"Killed",
		{
			(_this select 0) call Achilles_fnc_ambientAnim_terminate;
		}
	];
	_unit setVariable ["Achilles_EhKilled", _ehKilled,true];
	
	if (_combatReady) then
	{
		// make unit combat ready
		_previous_unit_damage = damage _unit;
		waitUntil
		{
			sleep 0.1;

			(behaviour _unit == "COMBAT") || (damage _unit > _previous_unit_damage) || (_unit call BIS_fnc_enemyDetected)
		};
		_unit call Achilles_fnc_ambientAnim_terminate;
	};
};
