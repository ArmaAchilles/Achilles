#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

IDD_DIALOG					= 133798;
IDC_COMBO_SIDE				= 20000;
IDC_COMBO_VEHICLE_FACTION	= 20001;
IDC_COMBO_VEHICLE_CATEGORY	= 20002;
IDC_COMBO_VEHICLE			= 20003;
IDC_COMBO_LZDZ				= 20005;
IDC_COMBO_WP_TYPE			= 20006;
IDC_COMBO_WP_TYPE_LABEL		= 10006;
IDC_COMBO_GROUP_FACTION	 	= 20007;
IDC_COMBO_GROUP				= 20008;

disableSerialization;
private _dialog = findDisplay IDD_DIALOG;

params["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

switch (_mode) do
{
	case "LOADED":
	{
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
	};
	case "0":
	{
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION; 
		private _ctrl_grp_fac = _dialog displayCtrl IDC_COMBO_GROUP_FACTION;
				
		lbClear _ctrl_veh_fac;
		{
			_ctrl_veh_fac lbAdd getText (configfile >> "CfgFactionClasses" >> _x >> "displayName");
		} forEach (Achilles_var_nestedList_vehicleFactions select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = [(lbSize _ctrl_veh_fac) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh_fac);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh_fac lbSetCurSel _last_choice;
		
		lbClear _ctrl_grp_fac;
		{
			_ctrl_grp_fac lbAdd getText (configfile >> "CfgFactionClasses" >> _x >> "displayName");
		} forEach (Achilles_var_nestedList_groupFactions select _comboIndex);
		_last_choice = [(lbSize _ctrl_grp_fac) - 1, _last_choice] select (_last_choice < lbSize _ctrl_grp_fac);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_grp_fac lbSetCurSel _last_choice;
	};
	case "1":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_veh_cat = _dialog displayCtrl IDC_COMBO_VEHICLE_CATEGORY;
				
		lbClear _ctrl_veh_cat;
		{
			_ctrl_veh_cat lbAdd getText (configfile >> "CfgEditorCategories" >> _x >> "displayName");
		} forEach (Achilles_var_nestedList_vehicleCategories select _side_id select select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_last_choice = [(lbSize _ctrl_veh_cat) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh_cat);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh_cat lbSetCurSel _last_choice;
	};
	case "2":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION;
		private _faction_id = lbCurSel _ctrl_veh_fac;
		
		private _ctrl_veh = _dialog displayCtrl IDC_COMBO_VEHICLE;
				
		lbClear _ctrl_veh;
		{
			_ctrl_veh lbAdd getText (configfile >> "CfgVehicles" >> _x >> "displayName");
		} forEach (Achilles_var_nestedList_vehicles select _side_id select _faction_id select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", 0];
		_last_choice = [(lbSize _ctrl_veh) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh lbSetCurSel _last_choice;
	};
	case "3":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION;
		private _faction_id = lbCurSel _ctrl_veh_fac;
		private _ctrl_veh_cat = _dialog displayCtrl IDC_COMBO_VEHICLE_CATEGORY;
		private _vehicle_category_id = lbCurSel _ctrl_veh_cat;
		
		
		Ares_var_reinforcement_vehicle_class = Achilles_var_nestedList_vehicles select _side_id select _faction_id select _vehicle_category_id select _comboIndex;

		if (Ares_var_reinforcement_vehicle_class isKindOf "Air") then
		{

			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_C;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlEnable true;
			_ctrl ctrlCommit 0;

			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_L;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;

			_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_WP_TYPE_C;
			_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_6", 0];
			_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
			_last_choice = [(lbSize _ctrl) - 1, _last_choice] select (_last_choice < lbSize _ctrl);
			_ctrl lbSetCurSel _last_choice;
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach [IDC_SPAWN_REINFORCEMENT_WP_TYPE_C,IDC_SPAWN_REINFORCEMENT_WP_TYPE_L];
		};

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_3", _comboIndex];
	};
	case "7":
	{
		_faction_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_FACTION;
		_current_faction = lbCurSel _faction_ctrl;
		_side_ctrl = _dialog displayCtrl IDC_SPAWN_REINFORCEMENT_SIDE;
		_current_side = lbCurSel _side_ctrl;

		_infantry_groups = _dialog getVariable ["infantry_groups",[]];
		if (_infantry_groups isEqualTo []) exitWith {};
		Ares_var_reinforcement_infantry_group =  _infantry_groups select _current_side select _current_faction select _comboIndex;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_7", _comboIndex];
	};
	case "UNLOAD" : {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
