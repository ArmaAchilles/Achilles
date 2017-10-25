/*
	Author: CreepPork_LV, shay_gman

	Description:
	 Sets a object as an IED.

  Parameters:
    _this select: 0 - OBJECT - Object that the module was placed upon
    _this select: 1 - NUMBER - Explosion Size
    _this select: 2 - NUMBER - Explosion Effect
    _this select: 3 - STRING - Activation Distance
    _this select: 4 - NUMBER - Activation Side
    _this select: 5 - NUMBER - Activation Type
    _this select: 6 - NUMBER - Can be Jammed
    _this select: 7 - STRING - Disarm Time
    _this select: 8 - NUMBER - Can be Disarmed

  Returns:
    Nothing
*/

private _object = _this select 0;
private _explosionSize = _this select 1;
private _explosionEffect = _this select 2;
private _activationDistance = _this select 3;
private _activationSide = _this select 4;
private _activationType = _this select 5;
private _isJammable = _this select 6;
private _disarmTime = _this select 7;
private _canBeDefused = _this select 8;

_activationDistance = parseNumber _activationDistance;
_disarmTime = parseNumber _disarmTime;

_activationSide = switch (_activationSide) do
{
  case 1: {[east]};
  case 2: {[west]};
  case 3: {[resistance]};
  default {[west]};
};

if (typeName _activationSide == typeName sideLogic) then {_activationSide = [_activationSide];};

private _dummyObject = "Land_HelipadEmpty_F" createVehicle (getPosATL _object);
_dummyObject attachTo [_object,[0,0,0]];

_dummyObject setVariable["activationType", _activationType, true];

[_object, ["HandleDamage", {_this call Achilles_fnc_IED_DamageHandler}]] remoteExec ["addEventHandler", _object];

_dummyObject setVariable ["object", _object, true];
_dummyObject setVariable ["armed", true, true];

_object setVariable ["dummyObject", _dummyObject, true];

private _hasACEExplosives = isClass (configFile >> "CfgPatches" >> "ace_explosives");

private _targets = ["Car", "Tank", "Man"];
private _loop = true;
private _armed = _dummyObject getVariable ["armed", true];
private _triggered = _dummyObject getVariable ["iedTriggered", false];
_object = _dummyObject getVariable ["object", objNull];
private _defused = _dummyObject getVariable ["defused", false];
private _targetSpeed = false;
private _onCompletion = {};

if (_canBeDefused == 0) then
{
  _onCompletion =
  {
    private _returnArray = _this select 3;

    private _dummyObject = _returnArray select 1;

    private _random = random 100;

    if (_random <= 70) then
    {
      systemChat "Disarmed";
      _dummyObject setVariable["armed", false, true];
      _dummyObject setVariable["iedTriggered", false, true];
      _dummyObject setVariable["defused", true, true];
      _defused = true;
    }
    else
    {
      systemChat "Failed to Disarm";
      _dummyObject setVariable["iedTriggered", true, true];
      _dummyObject setVariable["defused", false, true];
      _defused = false;
    };
  };

  if (_hasACEExplosives) then
  {
    [
      _object,
      "Disarm",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
      "_this distance _target < 3 && 'ACE_DefusalKit' in (items _this + assignedItems _this)",
      "_caller distance _target < 3",
      {},
      {},
      _onCompletion,
      {},
      [_object, _dummyObject],
      _disarmTime,
      20,
      true,
      false
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];
  }
  else
  {
    [
      _object,
      "Disarm",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
      "_this distance _target < 3",
      "_caller distance _target < 3",
      {},
      {},
      _onCompletion,
      {},
      [_object, _dummyObject],
      _disarmTime,
      20,
      true,
      false
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];
  };
};

if (_activationType == 0) then
{
	while {!_triggered} do
	{
		_triggered = _dummyObject getVariable ["iedTriggered", false];
		_armed = _dummyObject getVariable ["armed", false];
        _defused = _dummyObject getVariable ["defused", false];

        if ((!alive _object && _armed) || (isNull _object && _armed)) then
        {
          if (_defused) then
          {
            _dummyObject setVariable ["armed", false, true];
            _dummyObject setVariable ["iedTriggered", false, true];

            deleteVehicle _dummyObject;
          }
          else
          {
            _dummyObject setVariable ["iedTriggered", true, true];
          };
        };
	    sleep 1;
	};
}
else
{
	while {alive _object && !isNull _object && _loop && _armed && !_triggered} do
	{
		sleep 3;
		_triggered = _dummyObject getVariable ["iedTriggered", false];
		_armed = _dummyObject getVariable ["armed", true];

		private _nearestObjects = (getPos _dummyObject) nearObjects 150;

		if ({side _x in _activationSide} count _nearestObjects > 0) then
		{
			while {alive _object && _loop && _armed && !_triggered} do
			{
				sleep 1;
				private _nearestTarget  = (getPos _dummyObject) nearObjects (_activationDistance);
				private _nearestSide = [];

				{
					if (side _x in _activationSide) then
					{
						_nearestSide = _nearestSide + [_x];
					};
				} forEach _nearestTarget;

				private _howMany = count _nearestSide;

				for [{_x = 0;}, {_x < _howMany;}, {_x = _x + 1;}] do
				{
					private _target = _nearestSide select _x;
					private _isJammableVehicle = _target getVariable ["isECM", false];

					if ((_isJammable == 0) && _isJammableVehicle && ((_target distance _dummyObject) <= 80)) then
					{
							private _random = random 100;
							while {((_target distance _dummyObject) < 80) && (_random > 1)} do
							{
								_random = random 100;
								sleep 2;
							};
							if (_random <= 1) exitWith {_loop = false; _dummyObject setVariable ["iedTriggered", true, true];};
					};

					if (_loop) then
					{
						{
							_targetSpeed = if (_activationType == 2) then {true} else {(speed _target) > 7};
							if ((_target isKindOf _x) && ((_target distance _dummyObject) <= _activationDistance) && _targetSpeed) exitWith {_loop = false; _dummyObject setVariable ["iedTriggered", true, true]};
						} forEach _targets;
					};
				};
			};
		};
	};
};

_armed = _dummyObject getVariable ["armed", false];
_triggered = _dummyObject getVariable ["iedTriggered", false];

_object setVariable ["armed", _armed, true];
_object setVariable ["iedTriggered", _triggered, true];

private _spawnPos = [((getPosATL _object) select 0),((getPosATL _object) select 1),(((getPosATL _object) select 2) + 3)];

private _explosion = {};

switch (_explosionEffect) do
{
	case 0:
	{
		_explosion = Achilles_fnc_deadlyExplosion;
	};
	case 1:
	{
	   _explosion = Achilles_fnc_disablingExplosion;
	};
	case 2:
	{
	   _explosion = Achilles_fnc_fakeExplosion;
	};
};

if ((_armed && _triggered) || (!alive _object && _armed)) then
{
	[_spawnPos, _explosionSize] spawn _explosion;
	_object setDamage 1;
};

_object setVariable ["isIED", false, true];
_object setVariable ["armed", false, true];
_object setVariable ["iedTriggered", false, true];

[_object, 0] remoteExec ["BIS_fnc_holdActionRemove", 0, _object];

sleep 2;
deleteVehicle _dummyObject;
