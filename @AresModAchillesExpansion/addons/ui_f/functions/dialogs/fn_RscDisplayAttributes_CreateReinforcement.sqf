#define IDD_DIALOG					133798
#define IDC_COMBO_SIDE				20000
#define IDC_COMBO_VEHICLE_FACTION	20001
#define IDC_COMBO_VEHICLE_CATEGORY	20002
#define IDC_COMBO_VEHICLE			20003
#define IDC_COMBO_LZDZ				20005
#define IDC_COMBO_WP_TYPE			20006
#define IDC_COMBO_WP_TYPE_LABEL		10006
#define IDC_COMBO_GROUP_FACTION	 	20007
#define IDC_COMBO_GROUP				20008

disableSerialization;
private _dialog = findDisplay IDD_DIALOG;

params["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

switch (_mode) do
{
	case "LOADED":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		_ctrl_side lbSetCurSel lbCurSel _ctrl_side;
	};
	case "SIDE":
	{
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION; 
				
		lbClear _ctrl_veh_fac;
		{
			_ctrl_veh_fac lbAdd _x;
		} forEach (Achilles_var_nestedList_vehicleFactions select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = [(lbSize _ctrl_veh_fac) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh_fac);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh_fac lbSetCurSel _last_choice;
	};
	case "VEHICLE_FACTION":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_veh_cat = _dialog displayCtrl IDC_COMBO_VEHICLE_CATEGORY;
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION; 
		private _ctrl_grp_fac = _dialog displayCtrl IDC_COMBO_GROUP_FACTION;
				
		lbClear _ctrl_veh_cat;
		{
			_ctrl_veh_cat lbAdd _x;
		} forEach (Achilles_var_nestedList_vehicleCategories select _side_id select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_last_choice = [(lbSize _ctrl_veh_cat) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh_cat);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh_cat lbSetCurSel _last_choice;
		
		if (_ctrl_grp_fac getVariable ["first_time", true]) then
		{
			_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_7", ""];
			_ctrl_grp_fac setVariable ["first_time", false];
		} else
		{
			_last_choice = "";
		};
		
		lbClear _ctrl_grp_fac;
		if (_last_choice isEqualTo "") then
		{
			private _ref_name = _ctrl_veh_fac lbText _comboIndex;
			_last_choice = 0;
			{
				_ctrl_grp_fac lbAdd _x;
				if (_ref_name == _x) then
				{
					_last_choice = _forEachIndex;
				};
			} forEach (Achilles_var_nestedList_groupFactions select _side_id);
		} else
		{
			{
				_ctrl_grp_fac lbAdd _x;
			} forEach (Achilles_var_nestedList_groupFactions select _side_id);
			_last_choice = [(lbSize _ctrl_grp_fac) - 1, _last_choice] select (_last_choice < lbSize _ctrl_grp_fac);
			_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		};
		_ctrl_grp_fac lbSetCurSel _last_choice;
	};
	case "VEHICLE_CATEGORY":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_veh_fac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION;
		private _faction_id = lbCurSel _ctrl_veh_fac;
		
		private _ctrl_veh = _dialog displayCtrl IDC_COMBO_VEHICLE;
		lbClear _ctrl_veh;
		{
			private _lb_id = _ctrl_veh lbAdd getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_ctrl_veh lbSetData [_lb_id, _x];
			_ctrl_veh lbSetTextRight [_lb_id, "(" + str (([_x, true] call BIS_fnc_crewCount) - ([_x, false] call BIS_fnc_crewCount)) + ") "];
		} forEach (Achilles_var_nestedList_vehicles select _side_id select _faction_id select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", ""];
		_last_choice = [(lbSize _ctrl_veh) - 1, _last_choice] select (_last_choice < lbSize _ctrl_veh);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_veh lbSetCurSel _last_choice;
	};
	case "VEHICLE":
	{
		if ((_ctrl lbData _comboIndex) isKindOf "Air") then
		{
			_ctrl = _dialog displayCtrl IDC_COMBO_WP_TYPE;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlEnable true;
			_ctrl ctrlCommit 0;

			_ctrl = _dialog displayCtrl IDC_COMBO_WP_TYPE_LABEL;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;

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
			} forEach [IDC_COMBO_WP_TYPE,IDC_COMBO_WP_TYPE_LABEL];
		};
	};
	case "GROUP_FACTION":
	{
		private _ctrl_side = _dialog displayCtrl IDC_COMBO_SIDE;
		private _side_id = lbCurSel _ctrl_side;
		private _ctrl_grp = _dialog displayCtrl IDC_COMBO_GROUP;
				
		lbClear _ctrl_grp;
		{
			private _lb_id = _ctrl_grp lbAdd getText (_x >> "Name");
			_ctrl_grp lbSetTextRight [_lb_id, "(" + str count (_x call Achilles_fnc_returnChildren) + ") "];
		} forEach (Achilles_var_nestedList_groups select _side_id select _comboIndex);
		private _last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_8", 0];
		_last_choice = [(lbSize _ctrl_grp) - 1, _last_choice] select (_last_choice < lbSize _ctrl_grp);
		_last_choice = [0,_last_choice] select (_last_choice isEqualType 0);
		_ctrl_grp lbSetCurSel _last_choice;
	};
	case "GROUP":
	{
	};
};