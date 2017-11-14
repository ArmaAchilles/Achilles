#define IDD_DYNAMIC_GUI		133798
#define IDC_MODE_COMBO		20000
#define IDC_SELECTION_COMBO	20001
#define IDC_SELECTION_LABLE 10001
#define IDC_SIDE_LABLE		[10002,20002]
#define IDC_SIDE_ICONS		[12000,12010,12020,12030,12040]
/*
IDD_DYNAMIC_GUI		=133798;
IDC_MODE_COMBO		=20000;
IDC_SELECTION_COMBO	=20001;
IDC_SELECTION_LABLE =10001;
IDC_SIDE_LABLE		=[10002,20002];
IDC_SIDE_ICONS		=[12000,12010,12020,12030,12040];
*/
private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

private _dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		{
			_ctrl = _dialog displayCtrl (IDC_MODE_COMBO + _x);
			if (not isNull _ctrl) then
			{
				_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
				_last_choice = if (_last_choice isEqualType) then {_last_choice} else {0};
				_last_choice = if (_last_choice < lbSize _ctrl) then {_last_choice} else {(lbSize _ctrl) - 1};
				_ctrl lbSetCurSel _last_choice;
				if (_x == 0) then
				{
					[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_selectPlayers;
				};
			};
		} forEach [0,3];
	};
	case "0":
	{
		switch true do
		{
			case (_comboIndex < 3):
			{
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0.8;
					_ctrl ctrlEnable false;
					_ctrl ctrlCommit 0;
				} forEach ([IDC_SELECTION_COMBO,IDC_SELECTION_LABLE] + IDC_SIDE_LABLE + IDC_SIDE_ICONS);
			};
			case (_comboIndex == 3):
			{
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0;
					if (_x in IDC_SIDE_ICONS) then {_ctrl ctrlEnable true};
					_ctrl ctrlCommit 0;
				} forEach (IDC_SIDE_LABLE + IDC_SIDE_ICONS);
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0.8;
					_ctrl ctrlEnable false;
					_ctrl ctrlCommit 0;
				} forEach [IDC_SELECTION_COMBO,IDC_SELECTION_LABLE];
			};
			case (_comboIndex > 3):
			{
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0;
					if (_x == IDC_SELECTION_COMBO) then {_ctrl ctrlEnable true};
					_ctrl ctrlCommit 0;
				} forEach [IDC_SELECTION_COMBO,IDC_SELECTION_LABLE];
				{
					_ctrl = _dialog displayCtrl _x;
					_ctrl ctrlSetFade 0.8;
					_ctrl ctrlEnable false;
					_ctrl ctrlCommit 0;
				} forEach (IDC_SIDE_LABLE + IDC_SIDE_ICONS);

				_selection_ctrl = _dialog displayCtrl IDC_SELECTION_COMBO;
				_selection_lable = _dialog displayCtrl IDC_SELECTION_LABLE;
				lbClear _selection_ctrl;

				_selection_list = [];
				if (_comboIndex == 4) then
				{
					_selection_list = (allplayers - entities "HeadlessClient_F");
					_selection_list = [_selection_list,[],{name _x},"ASCEND"] call BIS_fnc_sortBy;
					{_selection_ctrl lbAdd name _x} forEach _selection_list;
					_dialog setVariable ["selection_mode","player"];
					_selection_lable ctrlSetText (localize "STR_PLAYER");
				} else
				{
					_selection_list = allGroups select {count ((units _x) select {isPlayer _x}) > 0};
					_selection_list = [_selection_list,[],{groupId _x},"ASCEND"] call BIS_fnc_sortBy;
					{_selection_ctrl lbAdd groupId _x} forEach _selection_list;
					_dialog setVariable ["selection_mode","group"];
					_selection_lable ctrlSetText (localize "STR_GROUP");
				};
				_dialog setVariable ["selection_list",_selection_list];

				_selection_ctrl lbSetCurSel 0;

				[1,_selection_ctrl,0] call Achilles_fnc_RscDisplayAttributes_selectPlayers;
			};
		};

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
	};
	case "1":
	{
		_selection_list = _dialog getVariable ["selection_list",[]];
		_selection_mode = _dialog getVariable ["selection_mode",""];
		if (_selection_mode == "" or _selection_list isEqualTo []) exitWith {Ares_var_selectPlayers = nil};

		_selection = _selection_list select _comboIndex;

		Ares_var_selectPlayers = if (_selection_mode == "player") then
		{
			[_selection];
		} else
		{
			units _selection;
		};
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
	};
	case "UNLOAD": {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
