/*
	Function:
		Achilles_fnc_ace_moduleHeal
	Authors:
		S.Crowe
		Kex
*/

params
[
	["_mode", "", [""]],
	["_moduleParams", [], [[]]]
];
_moduleParams params
[
	["_logic", objNull, [objNull]],
	["_isActivated", true, [true]],
	["_isCuratorPlaced", true, [true]],
	["_caller", "", [""]]
];
// set the new caller
_moduleParams set [3, _mode];

switch (_mode) do
{
	case "init":
	{
		[_logic] call Achilles_fnc_moduleInit;
		private _selectedUnits = [_logic, objNull, "man"] call Achilles_fnc_getSelectedEntities;
		deleteVehicle _logic;
		if (_selectedUnits isEqualTo []) exitWith {};
		
		if (isClass (configfile >> "CfgPatches" >> "ace_medical")) then
		{
			{
				if (local _x) then
				{
					[_x, _x] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
				}
				else
				{
					[_x, _x] remoteExec ["ace_medical_fnc_treatmentAdvanced_fullHealLocal", _x];
				};
			} forEach _selectedUnits;
		} else
		{
			// Vanilla Injury System
			{
				_x setDamage 0;
			} forEach _selectedUnits;
		};
		[localize "STR_AMAE_HEALED"] call Achilles_fnc_printZeusMessage;
	};
};
