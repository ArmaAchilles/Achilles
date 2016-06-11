#include "\ares_zeusExtensions\Ares\module_header.hpp"
if (isNil "Ares_Spawn_Smoke_Function") then
{
	Ares_Spawn_Smoke_Function = compile preprocessFileLineNumbers '\ares_zeusExtensions\Ares\scripts\spawnSmoke.sqf';
	publicVariable "Ares_Spawn_Smoke_Function";
};

_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_options = [
	"Vehicle Fire Look-Alike",
	"Small Oil Smoke",
	"Medium Oil Smoke",
	"Large Oil Smoke",
	"Small Wood Smoke",
	"Medium Wood Smoke",
	"Large Wood Smoke",
	"Small Mixed Smoke",
	"Large Mixed Smoke"
	];
_dialogResult = ["Create Smoke Effect", ["Smoke Type", _options]] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult > 0) then
{
	_sourceObject = _unitUnderCursor;
	if (isNull _sourceObject) then
	{
		_sourceObject = "Land_ClutterCutter_small_F" createVehicle (position _logic);
		_sourceObject setName format["Smoke (%1)", _options select (_dialogResult select 0)];
		[[_sourceObject]] call Ares_fnc_AddUnitsToCurator;
	};

	[[(_dialogResult select 0), _sourceObject], "Ares_Spawn_Smoke_Function", true, true] call BIS_fnc_MP;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
