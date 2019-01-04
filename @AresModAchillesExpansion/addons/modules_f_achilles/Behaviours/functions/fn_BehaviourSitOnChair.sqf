////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/4/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_BehaviourSitOnChair.sqf
//  DESCRIPTION: Function for the module "sit on chair"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

private _chair = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

private _type_id = ["Land_CampingChair_V2_F", "Land_CampingChair_V1_F", "Land_Chair_EP1", "Land_RattanChair_01_F", "Land_Bench_F", "Land_ChairWood_F", "Land_OfficeChair_01_F"] find (typeOf _chair);
if (_type_id == -1) exitWith {["No chair selected!"] call Achilles_fnc_ShowZeusErrorMessage};

// chairs can only be properly occupied if their simulation is enabled!
[_chair,true] remoteExec ["enableSimulationGlobal",2];

if (isNull (_chair getVariable ['occupier', ObjNull])) then
{
	private _unit = (["unit"] call Achilles_fnc_SelectUnits) select 0;
	if (isNil "_unit") exitWith {};
	if (!(_unit isKindOf "Man")) exitWith {["No unit selected!"] call Achilles_fnc_ShowZeusErrorMessage};
	private _ehAnimDone = _unit addEventHandler
	[
		"AnimDone",
		{
			private["_unit","_animset","_anim"];

			_unit = _this select 0;
			_animset = ["HubSittingChairA_idle1","HubSittingChairA_idle2","HubSittingChairA_idle3","HubSittingChairA_move1"];

			if (alive _unit) then
			{
				_anim = _animset select (round random (count _animset - 1));
				[_unit,_anim] remoteExec ["switchMove", 0];
			};
		}
	];
	_unit setVariable ["Achilles_AnimEH",_ehAnimDone];
	[_unit, "HubSittingChairA_idle1"] remoteExec ["switchMove", 0];
	private _offset = [[0,-0.1,-0.5], [0,-0.1,-0.5], [0,0,-0.5], [0,0,-0.5], [0,0,-0.2], [0,0,0], [0,0,-0.6]] select _type_id;
	private _dir = [180, 180, 90, 180, 90, 180, 180] select _type_id;
	_unit attachTo [_chair, _offset];
	[_unit, _dir] remoteExec ['setDir',0,true];
	_chair setVariable ['occupier', _unit];
} else {
	private _unit = _chair getVariable 'occupier';
	_unit removeEventHandler ["AnimDone",_unit getVariable ["Achilles_AnimEH",0]];
	[_unit, ""] remoteExec ["switchMove", 0];
	detach _unit;
	_unit setPos (_chair modelToWorld [0,0.8,-0.5]);
	_chair setVariable ['occupier', ObjNull];
};

#include "\achilles\modules_f_ares\module_footer.hpp"
