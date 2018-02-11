Achilles_var_furnitureVersion = "1.0.2";

[
	"Development Tools",
	"Copy Furniture",
	{
		 FURNITURE_CATEGORY_LABELS=	["STR_AMAE_CIVILIANS", "STR_AMAE_ABANDONED", "STR_AMAE_FORTIFIED", "STR_AMAE_MILITARY_BASE", "STR_AMAE_INSURGENT_HIDEOUT"];
		 FURNITURE_CATEGORIES=		["civilian", "abandoned", "fortified", "base", "hideout"];

		private _centerPos = param[0];

		private _dialogResult =
		[
			localize "STR_AMAE_COPY_FURNITURE_TO_CLIPBOARD",
			[
				[localize "STR_AMAE_SELECTION", [localize "STR_AMAE_NEAREST", localize "STR_AMAE_RANGE_NO_SI"]],
				[localize "STR_AMAE_RANGE","","100"],
				[localize "STR_AMAE_CATEGORY", FURNITURE_CATEGORY_LABELS],
				[[localize "STR_AMAE_NAME"] joinString "", [name player, "'s design X"] joinString " ", ""]
			],
			"Achilles_fnc_RscDisplayAttributes_LockDoors"
		] call Ares_fnc_ShowChooseDialog;

		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_selectionMode", "_strRadius", "_categoryIdx", "_name"];
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
			private _tmpStr = [endl, "[", endl] joinString "";
			private _data = [Achilles_var_furnitureVersion, _category, _name, name player, ""];
			_tmpStr = [_tmpStr, "    ", _data, ",", endl] joinString "";
			private _building = _x;
			private _detectionBox = boundingBoxReal _building;
			_detectionBox params ["_p1", "_p2"];
			private _detectionRadius = vectorMagnitude (_p1 vectorDiff _p2);
			systemChat str _detectionBox;
			private _furniture = nearestObjects [position _building, [], _detectionRadius];
			private _allHitPointsDamage = getAllHitPointsDamage _building;
			_hitPointDamageValues = if (count _allHitPointsDamage == 3) then {_allHitPointsDamage select 2} else {[]};
			_data = [typeOf _building, _hitPointDamageValues, []];
			_tmpStr = [_tmpStr, "    ", _data, ",", endl] joinString "";

			private _centerPosWorld = getPosWorld _building;
			private _centerVecDir = vectorDir _building;
			private _centerVecUp =  vectorUp _building;
			private _centerVecPer = _centerVecDir vectorCrossProduct _centerVecUp;
			private _standard_to_internal = [_centerVecDir, _centerVecUp, _centerVecPer];
			private _hasFurniture = false;
			{
				private _type = typeOf _x;
				if (_x != _building and not (isObjectHidden _x) and not (_type in ["","HouseFly","HoneyBee","ButterFly_random","Mosquito"]) and (_type select [0,1 ] != "#") and not (_x isKindOf "Animal") and not (_x isKindOf "Man") and not (_x isKindOf "Module_f")) then
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
				_clipboard = [_clipboard, _tmpStr select [0, count _tmpStr - 3], endl, "];", endl] joinString "";
			};
		} forEach _buildings;

		copyToClipboard _clipboard;
		uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", _clipboard];
		private _dialog = createDialog "Ares_CopyPaste_Dialog";
	}
] call Ares_fnc_RegisterCustomModule;

[
	"Development Tools",
	"Paste Furniture",
	{
		private _centerPos = param[0];
		private _toAddToCurator = [];

		disableSerialization;
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
				(_data select 1) params ["_type","_hitPointDamageList"];
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

				for "_i" from 2 to (count _data - 1) do
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
	}
] call Ares_fnc_RegisterCustomModule;