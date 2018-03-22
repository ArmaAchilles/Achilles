#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_entity"];

private _idcs = [
	IDC_RSCATTRIBUTERESPAWNPOSITION_EAST,
	IDC_RSCATTRIBUTERESPAWNPOSITION_WEST,
	IDC_RSCATTRIBUTERESPAWNPOSITION_GUER,
	IDC_RSCATTRIBUTERESPAWNPOSITION_CIV,
	IDC_RSCATTRIBUTERESPAWNPOSITION_DISABLED
];
private _colorsActive = [
	east call bis_fnc_sidecolor,
	west call bis_fnc_sidecolor,
	resistance call bis_fnc_sidecolor,
	civilian call bis_fnc_sidecolor,
	[1,1,1,1]
];
private _colorsText = +_colorsActive;
{_x set [3,0.5];} foreach _colorsText;

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _IDs = _entity getvariable ["RscAttributeRespawnPosition_ids",[[],[],[],[],[]]];
		if (_entity isEqualType grpnull) then {_entity = leader _entity;};

		//--- Not available for destroyed object
		if (!alive _entity || !canmove _entity) exitwith {
			{
				private _ctrl = _display displayctrl _x;
				_ctrl ctrlenable false;
				_ctrl ctrlshow false;
			} foreach _idcs;
			private _ctrlBackground = _display displayctrl IDC_RSCATTRIBUTERESPAWNPOSITION_BACKGROUND;
			_ctrlBackground ctrlsettext localize "STR_lib_info_na";
		};

		//--- Add handlers to all buttons
		private _playerside = player call bis_fnc_objectside;
		private _selected = 4;
		{
			private _ctrl = _display displayctrl _x;
			private _side = _foreachindex call bis_fnc_sideType;
			if (([_side,_playerside] call bis_fnc_arefriendly && playableslotsnumber _side > 0) || _foreachindex == 4) then {
				_ctrl ctrladdeventhandler ["buttonclick","with uinamespace do {['onButtonClick',[_this select 0,0.1]] call RscAttributeRespawnPosition};"];
				_ctrl ctrlsetactivecolor (_colorsActive select _foreachindex);
				_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
				_ctrl ctrlcommit 0;
				if (count (_IDs select _foreachindex) > 0) then {_selected = _foreachindex;};
			} else {
				_ctrl ctrlshow false;
			};
		} foreach _idcs;

		RscAttributeRespawnPosition_selected = _selected;
		private _selectedIdc = _idcs select _selected;
		['onButtonClick',[_display displayctrl _selectedIdc,0]] call RscAttributeRespawnPosition;
		_selected = 4;
	};
	case "onButtonClick": {
		private _ctrlSelected = _params select 0;
		private _delay = _params select 1;
		private _display = ctrlparent _ctrlSelected;
		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrlsettextcolor (_colorsText select _foreachindex);
			[_ctrl,1,_delay] call bis_fnc_ctrlsetscale;
		} foreach _idcs;

		RscAttributeRespawnPosition_selected = _idcs find (ctrlidc _ctrlSelected);
		_ctrlSelected ctrlsettextcolor (_colorsActive select RscAttributeRespawnPosition_selected);
		[_ctrlSelected,1.25,_delay] call bis_fnc_ctrlsetscale;
	};
	case "confirmed": {
		private _display = _params select 0;
		private _selected = uinamespace getvariable ["RscAttributeRespawnPosition_selected",4];

		private _mode = switch true do {
			case (_entity isEqualType grpNull): {
				"group"
			};
			case (_entity isKindOf "Man"): {
				"man"
			};
			default {
				"vehicle"
			};
		};
		private _curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
		{
			private _IDs = _x getvariable ["RscAttributeRespawnPosition_ids",[]];

			//--- Remove
			{_x call bis_fnc_removerespawnposition;} foreach _IDs;
			_IDs = [[],[],[],[],[]];

			if (_selected != 4) then {
				//--- Add
				private _side = _selected call bis_fnc_sideType;
				private _respawnID = [_side,_x] call bis_fnc_addrespawnposition;
				_IDs set [_selected,_respawnID];
				_x setvariable ["RscAttributeRespawnPosition_ids",_IDs,true];
			} else {
				_x setvariable ["RscAttributeRespawnPosition_ids",nil,true];
			};
		} forEach _curatorSelected;
		_entity setvariable ["updated",true,true];
		false
	};
	case "onUnload": {
		RscAttributeRespawnPosition_selected = nil;
	};
};
