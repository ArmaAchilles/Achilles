////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/3/17
//	VERSION: 2.0
//  DESCRIPTION: Function for module "spawn advanced composition"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#define CHAIRS_CLASS_NAMES 		["Land_CampingChair_V2_F", "Land_CampingChair_V1_F", "Land_Chair_EP1", "Land_RattanChair_01_F", "Land_Bench_F", "Land_ChairWood_F", "Land_OfficeChair_01_F"]
#define IDD_COMPOSITIONS 		133799

#include "\achilles\modules_f_ares\module_header.h"

// load basic advanced compositions
if (isNil "Achilles_var_acs_init_done") then
{
	[] call compile preprocessFileLineNumbers "\achilles\data_f_achilles\Advanced Compositions\Ares_var_advanced_compositions.sqf";
	Achilles_var_acs_init_done = true;
};

private _spawn_pos = position _logic;

createDialog "Ares_composition_Dialog";
["LOADED"] spawn Achilles_fnc_RscDisplayAttributes_spawnAdvancedComposition;
waitUntil {!dialog};
if ((uiNamespace getVariable ['Ares_Dialog_Result', -1]) == -1) exitWith {};

private _objects_info = [] call compile Ares_var_current_composition;
if (count _objects_info == 0) exitWith {[localize "STR_AMAE_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
private _center_object_info = _objects_info select 0;
_objects_info = _objects_info - [_center_object_info];
_center_object_info params ["_type", "_", "_center_dir", "_allow_sim"];

private _center_object = _type createVehicle [0,0,0];

[_center_object,false] remoteExec ["enableSimulationGlobal",2];
_center_object setPosATL [-500,-500,0];
_center_object setDir _center_dir;

[[_center_object], true] call Ares_fnc_AddUnitsToCurator;

private _attached_objects = [];
{
	_x params ["_type", "_pos", "_dir", "_allow_sim"];
	
	_pos = (getPosWorld _center_object) vectorAdd _pos;
	_dir = _dir - (getDir _center_object);
	
	private _object = _type createVehicle [0,0,0];
	
	[_object,_allow_sim] remoteExec ["enableSimulationGlobal",2];
	_object setPosWorld _pos;
	_object attachTo [_center_object];
	[_object, _dir] remoteExec ['setDir',0,true];
	_attached_objects pushBack _object;
} forEach _objects_info;
_center_object setPos _spawn_pos;
[_center_object,true] remoteExec ["enableSimulationGlobal",2];
_center_object setVariable ["ACS_attached_objects",_attached_objects];
_center_object setVariable ["ACS_center_dir", _center_dir];
_center_object addEventHandler ["Deleted", {_attached_objects = (_this select 0) getVariable ["ACS_attached_objects", []]; {deleteVehicle _x} forEach _attached_objects}];

#include "\achilles\modules_f_ares\module_footer.h"
