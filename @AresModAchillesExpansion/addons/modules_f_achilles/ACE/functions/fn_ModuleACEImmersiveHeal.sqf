////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: ServiusHack
//	DESCRIPTION: Command an AI unit to revive a player using farooq's Revive.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "\achilles\modules_f_ares\module_header.h"

#include "\a3\functions_f_mp_mark\revive\defines.inc"

// Command an AI (second parameter) to revive a player (first parameter).
private _revive = {
	params ["_player", "_ai"];

	// Let Zeus know what will happen
	[format [localize "STR_AMAE_REVIVE_PLAYER", name _player]] call Ares_fnc_ShowZeusMessage;

	private _vehicle = vehicle _ai;

	if (_vehicle isEqualTo _ai) then
	{
		// move unit to perform the revive
		_ai doMove (getPos _player);
	} else
	{
		// make vehicle drive to the player
		driver _vehicle doMove (getPos _player);

		// wait for vehicle to be close enough
		// Make sure we're close to get off when the vehicle stands still.
		waitUntil{ (speed _vehicle) < 0.1 && (_ai distance _player) < 20 };

		// make sure the vehicle stops
		doStop driver _vehicle;

		// make the unit leave the vehicle
		_ai action ["GetOut", _vehicle];
		_ai leaveVehicle _vehicle;

		// finally move unit to perform the revive
		_ai doMove (getPos _player);
	};

	waitUntil{ (_ai distance _player) < 2 };

	// make it look nice
	_ai lookAt _player;
	sleep 2;
	_ai playMove "AinvPknlMstpSnonWnonDnon_medic1";
	_ai playMove "AinvPknlMstpSnonWnonDnon_medicEnd";
	_ai playMove "AinvPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon";
	_ai playMove "AmovPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon";

	// do the actual revive
	if (isClass (configfile >> "CfgPatches" >> "ace_medical")) then
	{
		if (local _player) then
		{
			[_player, _player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal
		} else
		{
			[_player, _player] remoteExec ["ace_medical_fnc_treatmentAdvanced_fullHealLocal", _player]
		};
	};

	if (!isNil "FAR_ReviveMode") then
	{
		_player setVariable ["FAR_isUnconscious", 0, true];
		_player setVariable ["FAR_isDragged", 0, true];
	};

	if (REVIVE_ENABLED(_player) && lifeState _player == "INCAPACITATED" && IS_DISABLED(_player)) then
	{
		SET_STATE(_player, STATE_REVIVED);
	} else
	{
		_player setDamage 0;
	};

	// stop always looking at the revived player
	_ai lookAt objNull;
};

// Gets the object that the module was placed upon
private _object = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

// Displays error message if no object or unit has been selected.
if (isNull _object) exitWith
{
	[localize "STR_AMAE_NO_UNIT_SELECTED"] call Achilles_fnc_ShowZeusErrorMessage;
};

if (isPlayer _object || isPlayer driver _object) exitWith
{
	// find nearest units
	private _nearestUnits = nearestObjects [_object, ["man", "landvehicle"], 500];

	// find closest AI unit of same side
	private _sameSideUnitIndex = _nearestUnits findIf { side group _object isEqualTo side driver _x && !isPlayer driver _x };

	if (_sameSideUnitIndex == -1) exitWith
	{
		[localize "STR_AMAE_REVIE_NO_NEAR_UNITS"] call Achilles_fnc_ShowZeusErrorMessage;
	};

	// spawn off movement and revive action
	[driver _object, driver (_nearestUnits select _sameSideUnitIndex)] spawn _revive;
};

// Make sure we use a unit. Vehicles support kicks in later.
_object = driver _object;

if (!isNull _object) exitWith
{
	// find all unconsious players
	private _unconsiousPlayers = allPlayers select { _x getVariable ["FAR_isUnconscious", 0] == 1 };

	// find nearest player to revive
	private _sortedPlayers = [_unconsiousPlayers, [], {_x distance _object}, "ASCEND"] call BIS_fnc_sortBy;
	private _nearestPlayer = _sortedPlayers select 0;

	if (isNil "_nearestPlayer") exitWith { [localize "STR_AMAE_NO_PLAYER_UNCONSIOUS"] call Achilles_fnc_ShowZeusErrorMessage; };

	// spawn off movement and revive action
	[_nearestPlayer, _object] spawn _revive;
};

[localize "STR_AMAE_REVIE_INVALID_SELECTION"] call Achilles_fnc_ShowZeusErrorMessage;

#include "\achilles\modules_f_ares\module_footer.h"
