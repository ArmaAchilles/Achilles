
#define IDD_DYNAMIC_GUI		133798
#define IDC_CATEGORY		20000
#define IDC_TYPE			20001
#define OTHER_LABEL_IDCs	[10002,10003,10004]
#define OTHER_CTRL_IDCs		[20002,20003,20004]
/*
 IDD_DYNAMIC_GUI	=	133798;
 IDC_CATEGORY		=20000;
 IDC_TYPE			=20001;
 OTHER_LABEL_IDCs	=[10002,10003,10004];
 OTHER_CTRL_IDCs	=	[20002,20003,20004];
*/
private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = _this select 0;
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

_dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		{
			_ctrl = _dialog displayCtrl (IDC_CATEGORY + _x);
			_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _x], 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_last_choice = if (_last_choice < lbSize _ctrl) then {_last_choice} else {(lbSize _ctrl) - 1};
			_ctrl lbSetCurSel _last_choice;
			if (_x == 0) then
			{
				[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_SpawnExplosives;
			};
		} forEach [0,4];
	};
	case "0": 
	{
		_category_ctrl = _ctrl;	
		_type_ctrl = _dialog displayCtrl IDC_TYPE;
		
		_explosive_types = (configfile >> "CfgVehicles" >> "ModuleMine_F") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
		_explosive_types = _explosive_types - ["ModuleExplosive_F"];
		
		if (_comboIndex == 0) then
		{
			// "Mines" selected
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				if (_x in OTHER_CTRL_IDCs) then {_ctrl ctrlShow true};
				_ctrl ctrlCommit 0;
			} forEach (OTHER_LABEL_IDCs + OTHER_CTRL_IDCs);
			
			_mine_types = _explosive_types select {not (_x isKindOf "ModuleExplosive_F")};
			lbClear _type_ctrl;
			{_type_ctrl lbAdd (getText (configfile >> "CfgVehicles" >> _x >> "displayName"))} forEach _mine_types;
			_dialog setVariable ["type_list", _mine_types];
		} else
		{
			// "Explosives" selected
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				if (_x in OTHER_CTRL_IDCs) then {_ctrl ctrlShow false};
				_ctrl ctrlCommit 0;
			} forEach (OTHER_LABEL_IDCs + OTHER_CTRL_IDCs);
			
			lbClear _type_ctrl;
			{_type_ctrl lbAdd (getText (configfile >> "CfgVehicles" >> _x >> "displayName"))} forEach _explosive_types;
			_dialog setVariable ["type_list", _explosive_types];
		};
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = if (_last_choice < lbSize _type_ctrl) then {_last_choice} else {(lbSize _type_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_type_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
		[1,_type_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_SpawnExplosives;	
	};
	case "1":
	{
		_type_list = _dialog getVariable ["type_list",[]];
		Ares_var_explosive_type = _type_list select _comboIndex;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};