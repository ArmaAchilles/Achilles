/*
	Author: Karel Moricky (edited by Kex for specify position exception handling. Edited by CreepPork_LV to make it work with dummy logics)

	Description:
	Code executed when curator object is edited (i.e., moved or rotated).
	When a soldier or a vehicle is moved high above ground, create a parachute for them

	Parameter(s):
		0: OBJECT - curator module
		1: OBJECT - edited object

	Returns:
	BOOL
*/
[42,_this] call bis_fnc_log;

#define EHVAR	"BIS_fnc_curatorObjectEdited_eh"
#define PARAVAR	"BIS_fnc_curatorObjectEdited_para"

params [["_curator", objNull, [objNull]], ["_object", objNull, [objNull]]];
_para = objnull;

_object call bis_fnc_curatorAttachObject;

_objectPos = position _object;
_objectData = _object call bis_fnc_objectType;
_objectCategory = _objectData select 0;
_objectType = _objectData select 1;

//--- Delete existing parachute
deletevehicle (_object getvariable [PARAVAR,objnull]);

// if specify position
if (_object in (missionNamespace getVariable ["Achilles_var_preplaceModeObjects",[]])) exitWith {true};

//--- Slingload when possible
_curatormouseover = curatormouseover;
if ((_curatormouseover select 0) == "object") exitwith {
	private _target = _curatormouseover select 1;
	
	switch (true) do
	{
		case (_target == isVehicleCargo _object):
		{
			objNull setVehicleCargo _object;
		};
		case (_target == ropeAttachedto _object):
		{
			_target setSlingload objnull;
			_object setPosATL [position _target select 0, position _target select 1, 0];
		};
		case ((_target canVehicleCargo _object) select 0):
		{
			detach _object;
			_target setVehicleCargo _object;
		};
		case (_target canSlingLoad _object):
		{
			private _old_transporter = ropeAttachedto _object;
			if (not isNull _old_transporter) then
			{
				_old_transporter setSlingLoad objNull;
			};
			[getslingload _target,0] call bis_fnc_setheight;
			detach _object;
			_object setpos (_target modeltoworld [0,0,-15]);
			_target setSlingLoad _object;
		};
	};
};

switch _objectCategory do {
	case "Object": {
		switch _objectType do {
			case "AmmoBox": {
				//--- Create parachute for vehicles in the air
				if ((position _object select 2) > 20 && alive _object) then {
					_para = createvehicle ["B_Parachute_02_F",_objectPos,[],0,"none"];
					_object attachto [_para,[0,0,1]];
				};
			};
		};
	};
	case "Vehicle";
	case "VehicleAutonomous": {
		switch _objectType do {
			case "Car";
			case "Motorcycle";
			case "Ship";
			case "Submarine";
			case "TrackedAPC";
			case "Tank";
			case "WheeledAPC": {
				//--- Create parachute for vehicles in the air
				if ((position _object select 2) > 20 && alive _object) then {
					_para = createvehicle ["B_Parachute_02_F",_objectPos,[],0,"none"];
					_object attachto [_para,[0,0,(abs ((boundingbox _object select 0) select 2))]];
				};
			};
		};
	};
	case "Soldier": {
		//--- Create parachute for soldiers in the air
		if ((position _object select 2) > 20 && alive _object) then {
			_para = createvehicle ["Steerable_Parachute_F",_objectPos,[],0,"none"];
			_object moveindriver _para;

		};
	};
};

//--- Set parachute
if !(isnull _para) then {
	_para setpos _objectPos;
	_para setdir direction _object;
	_object setvariable [PARAVAR,_para];
	_para setvelocity [0,0,-1];

	//--- Play jet flyby sound to warn players about parachutes
	if (time - (missionnamespace getvariable ["bis_fnc_curatorobjectedited_paraSoundTime",0]) > 0) then {
		_soundFlyover = ["BattlefieldJet1","BattlefieldJet2"] call bis_fnc_selectrandom;
		[[_para,_soundFlyover,"say3d"],"bis_fnc_sayMessage"] call bis_fnc_mp;
		missionnamespace setvariable ["bis_fnc_curatorobjectedited_paraSoundTime",time + 10]
	};

	[_object,_para] spawn {
		scriptname "BIS_fnc_curatorObjectEdited: Parachute";
		_object = _this select 0;
		_para = _this select 1;

		waituntil {isnull _para || isnull _object};
		_object setdir direction _object;
		deletevehicle _para;
	};
};

true
