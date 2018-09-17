/*
	Function:
		Achilles_fnc_ambient_moduleCivilianPresence
	Authors:
		Kex
*/

params
[
	["_mode", "", [""]],
	["_params", [], [[]]]
];
_params params
[
	["_logic", objNull, [objNull]],
	["_isActivated", true, [true]],
	["_isCuratorPlaced", true, [true]],
	["_caller", "", [""]]
];
// set the new caller
_params set [3, _mode];

switch (_mode) do
{
	case "init":
	{
		["basic"] call Achilles_fnc_module_init;
	};
	case "postinit":
	{
		private _selectedUnits = _logic getVariable ["#selection", []];
		[
			localize "STR_a3_to_basicCivilianPresence19",
			[
				["TEXT", "#unitCount", localize "STR_AMAE_NUMBER_OF_UNITS", "SCALAR:N", "15"],
				["TEXT", "#radius", localize "STR_AMAE_RADIUS", "SCALAR:R>0", "150"],
				["TEXT", "#nSafeSpots", localize "STR_AMAE_NUMBER_OF_PREGENERATED_SAFE_SPOTS", "SCALAR:N", "0"],
				["CHECKBOX", "#useAgents", localize "STR_AMAE_USE_AGENTS", "BOOL", true],
				["CHECKBOX", "#usePanicMode", localize "STR_AMAE_USE_PANIC_ACTION", "BOOL", true]
				["CODE", "#usePanicMode", localize "STR_AMAE_USE_PANIC_ACTION", true]
			]
		] call Achilles_fnc_module_openDialog;
	};
	case "confirmed":
	{
	};
	case "canceled":
	{
	};
	case "onModuleDoubleClicked":
	{
		["edit", _moduleParams] call _fnc_scriptName;
	};
	case "onModuleSelected":
	{
	};
	case "onModuleDeleted":
	{
	};
};