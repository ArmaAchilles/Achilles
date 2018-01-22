#include "\achilles\modules_f_ares\module_header.hpp"
#define FURNITURE_CATEGORY_LABELS	[localize "STR_AMAE_CIVILIANS", localize "STR_AMAE_ABANDONED", localize "STR_AMAE_FORTIFIED", localize "STR_AMAE_MILITARY_BASE", localize "STR_AMAE_INSURGENT_HIDEOUT"]
#define FURNITURE_CATEGORIES		["civilian", "abandoned", "fortified", "base", "hideout"]

private _centerPos = position _logic;

private _dialogResult =
[
	localize "STR_AMAE_COPY_FURNITURE_TO_CLIPBOARD",
	[
		[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_NEAREST", localize "STR_AMAE_RANGE_NO_SI"]],
		[localize "STR_AMAE_RANGE","","100"],
		[localize "STR_AMAE_CATEGORY", FURNITURE_CATEGORY_LABELS]
	],
	"Achilles_fnc_RscDisplayAttributes_LockDoors"
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_dialogResult params ["_selectionMode", "_strRadius", "_categoryIdx"];
private _category = FURNITURE_CATEGORIES select _categoryIdx;

private _buildings = [];
switch (_selectionMode) do
{
	case 0:
	{
		_buildings = nearestObjects [_centerPos, ["House"], 50, true];
		_buildings resize 1;
	};
	case 1:
	{
		_buildings = nearestObjects [_centerPos, ["House"], parseNumber _strRadius, true];
	};
};
if (_buildings isEqualTo []) exitWith {[localize "STR_AMAE_NO_BUILDINGS_FOUND"] call Achilles_fnc_showZeusErrorMessage};

private _clipboard = "";
{
	private _building = _x;
	private _detectionBox = boundingBoxReal _building;
	_detectionBox params ["_p1", "_p2"];
	private _detectionRadius = vectorMagnitude (_p1 vectorDiff _p2);
	systemChat str _detectionBox;
	private _furniture = nearestObjects [position _building, [], _detectionRadius];
	private _allHitPointsDamage = getAllHitPointsDamage _building;
	_hitPointDamageValues = if (count _allHitPointsDamage == 3) then {_allHitPointsDamage select 2} else {[]};
	private _data = [_category, typeOf _building, _hitPointDamageValues];
	private _tmpStr = [endl, "[", endl] joinString "";
	_tmpStr = [_tmpStr, "    ", _data, ",", endl] joinString "";

	private _centerPosWorld = getPosWorld _building;
	private _centerVecDir = vectorDir _building;
	private _centerVecUp =  vectorUp _building;
	private _centerVecPer = _centerVecDir vectorCrossProduct _centerVecUp;
	private _standard_to_internal = [_centerVecDir, _centerVecUp, _centerVecPer];
	private _hasFurniture = false;
	{
		private _type = typeOf _x;
		if (_x != _building and not (_type in ["","HouseFly","HoneyBee","ButterFly_random"]) and (_type select [0,1 ] != "#") and not (_x isKindOf "Animal") and not (_x isKindOf "Man") and not (_x isKindOf "Module_f")) then
		{
			private _isInsideDetectionBox = true;
			private _posWorld = getPosWorld _x;
			{if (_x < (_detectionBox select 0 select _forEachIndex) or _x > (_detectionBox select 1 select _forEachIndex)) exitWith {_isInsideDetectionBox = false}} forEach (_building worldToModel getPosATL _x);
			if (_isInsideDetectionBox) then
			{
				private _relPos = [_standard_to_internal, _posWorld vectorDiff _centerPosWorld] call Achilles_fnc_vectorMap;
				private _relVecDir = [_standard_to_internal, vectorDir _x] call Achilles_fnc_vectorMap;
				private _relVecUp = [_standard_to_internal, vectorUp _x] call Achilles_fnc_vectorMap;
				private _textures = getObjectTextures _x;
				private _materials = getObjectMaterials _x;
				if (isNil "_textures") then {_textures = []};
				if (isNil "_materials") then {_materials = []};
				private _data = [_type, _relPos, _relVecDir, _relVecUp, _textures, _materials];
				_tmpStr = [_tmpStr, "    ", _data, ",", endl] joinString "";
				_hasFurniture = true;
			};
		};
	} forEach _furniture;
	if (_hasFurniture) then
	{
		_clipboard = [_clipboard, _tmpStr select [0, count _tmpStr - 3], endl, "]", endl] joinString "";
	};
} forEach _buildings;

copyToClipboard _clipboard;
uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", _clipboard];
private _dialog = createDialog "Ares_CopyPaste_Dialog";

#include "\achilles\modules_f_ares\module_footer.hpp"