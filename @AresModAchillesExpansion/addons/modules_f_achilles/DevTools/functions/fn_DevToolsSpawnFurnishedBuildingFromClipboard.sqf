#include "\achilles\modules_f_ares\module_header.hpp"

private _centerPos = position _logic;
private _toAddToCurator = [];

uiNamespace setVariable ["Ares_CopyPaste_Dialog_Result", -1];
createDialog "Ares_CopyPaste_Dialog";
private _dialog = findDisplay 123;
waitUntil { dialog };
waitUntil { !dialog };
private _dialogResult = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Result", -1];
if (_dialogResult == -1) exitWith {};
private _pastedText = uiNamespace getVariable ["Ares_CopyPaste_Dialog_Text", ""];

private _dataList = [];
private _startIdx = 0; 
private _bracketLevel = 0;
private _textAsArray = toArray _pastedText;
{
	switch (_x) do
	{
		case 91:
		{
			_bracketLevel = _bracketLevel + 1;
		};
		case 93:
		{
			_bracketLevel = _bracketLevel - 1;
			if (_bracketLevel isEqualTo 0) then
			{
				_dataList pushBack toString (_textAsArray select [_startIdx, _forEachIndex - _startIdx + 1]);
				_startIdx = _forEachIndex + 1;
			};
		};
	};
} forEach _textAsArray;


private _tmp_var_getSpawnPos = [50];
private _tmp_fnc_getSpawnPos =
{
	params [["_inc",1,[1]], ["_x",0,[0]], ["_y",0,[0]], ["_max",0,[0]], ["_phase",0,[0]]];
	switch (_phase) do
	{
		case 0:
		{
			_x = _x + _inc;
			_max = _max + _inc;
			_phase = 1;
		};
		case 1:
		{
			_y = _y + _inc;
			if (_y isEqualTo _max) then
			{
				_phase = 2;
			};
		};
		case 2:
		{
			_x = _x - _inc;
			if (_x isEqualTo 0) then
			{
				_phase = 3;
			};
		};
		case 3:
		{
			_y = _y + _inc;
			_max = _max + _inc;
			_phase = 4;
		};
		case 4:
		{
			_x = _x + _inc;
			if (_x isEqualTo _max) then
			{
				_phase = 5;
			};
		};
		case 5:
		{
			_y = _y - _inc;
			if (_y isEqualTo 0) then
			{
				_phase = 0;
			};
		};
	};
	[_inc, _x, _y, _max, _phase];
};

{
	copyToClipboard _x;
	private _data = call compile _x;
	if (not isNil "_data" and {_data isEqualType []}) then
	{
		(_data select 0) params ["_","_type","_hitPointDamageList"];
		private _building = _type createVehicle [0,0,0];
		_toAddToCurator pushBack _building;
		_tmp_var_getSpawnPos = _tmp_var_getSpawnPos call _tmp_fnc_getSpawnPos;
		_building setPos (_centerPos vectorAdd ((_tmp_var_getSpawnPos select [1,2]) + [0]));
		{_building setHitIndex [_forEachIndex, _x]} forEach _hitPointDamageList;
		private _centerPosWorld = getPosWorld _building;
		private _centerVecDir = vectorDir _building;
		private _centerVecUp =  vectorUp _building;
		private _centerVecPer = _centerVecDir vectorCrossProduct _centerVecUp;
		private _standard_to_internal = [_centerVecDir, _centerVecUp, _centerVecPer];
		private _internal_to_standard = [_standard_to_internal] call Achilles_fnc_matrixTranspose;

		for "_i" from 1 to (count _data - 1) do
		{
			(_data select _i) params ["_type", "_relPos", "_relVecDir", "_relVecUp", "_textures", "_materials"];
			private _furniture = _type createVehicle [0,0,0];
			_toAddToCurator pushBack _furniture;
			if (not (_furniture isKindOf "AllVehicles")) then
			{
				[_furniture, false] remoteExecCall ["enableSimulationGlobal", 2];
			};
			_furniture setPosWorld (([_internal_to_standard, _relPos] call Achilles_fnc_vectorMap) vectorAdd _centerPosWorld);
			_relVecDir = [_internal_to_standard, _relVecDir] call Achilles_fnc_vectorMap;
			_relVecUp = [_internal_to_standard, _relVecUp] call Achilles_fnc_vectorMap;
			_furniture setVectorDirAndUp [_relVecDir, _relVecUp];
			{_furniture setObjectTextureGlobal [_forEachIndex, _x]} forEach _textures;
			{_furniture setObjectMaterialGlobal [_forEachIndex, _x]} forEach _materials;
		};
	};
} forEach _dataList;

[_toAddToCurator] call Ares_fnc_AddUnitsToCurator;



#include "\achilles\modules_f_ares\module_footer.hpp"