/*
	Author: CreepPork_LV

	Description:
		Sets channel frequency for active TFAR SR radio

	Parameters:
		_this select 0: NUMBER - Channel
    	_this select 1: STRING - Frequency

	Returns:
    	Nothing
*/

params ["_channel", "_freq"];

if (!isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {};

if (call TFAR_fnc_haveSWRadio) then
{
	[(call TFAR_fnc_activeSwRadio), _channel, _freq] call TFAR_fnc_SetChannelFrequency;
};
