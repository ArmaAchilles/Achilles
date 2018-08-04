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
		private _ctrlSide = _dialog displayCtrl IDC_COMBO_SIDE;
		_ctrlSide lbSetCurSel lbCurSel _ctrlSide;
	};
	case "SIDE":
	{
		private _ctrlVehFac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION; 
				
		lbClear _ctrlVehFac;
		{
			_ctrlVehFac lbAdd _x;
		} forEach (Achilles_var_nestedList_vehicleFactions select _comboIndex);
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_lastChoice = [(lbSize _ctrlVehFac) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlVehFac);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlVehFac lbSetCurSel _lastChoice;
	};
	case "VEHICLE_FACTION":
	{
		private _ctrlSide = _dialog displayCtrl IDC_COMBO_SIDE;
		private _sideId = lbCurSel _ctrlSide;
		private _ctrlVehCat = _dialog displayCtrl IDC_COMBO_VEHICLE_CATEGORY;
		private _ctrlVehFac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION; 
		private _ctrlGrpFac = _dialog displayCtrl IDC_COMBO_GROUP_FACTION;
		
		lbClear _ctrlVehCat;
		{
			_ctrlVehCat lbAdd _x;
		} forEach (Achilles_var_nestedList_vehicleCategories select _sideId select _comboIndex);
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_lastChoice = [(lbSize _ctrlVehCat) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlVehCat);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlVehCat lbSetCurSel _lastChoice;
		
		if (_ctrlGrpFac getVariable ["first_time", true]) then
		{
			_lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_7", ""];
			_ctrlGrpFac setVariable ["first_time", false];
		} else
		{
			_lastChoice = "";
		};
		
		lbClear _ctrlGrpFac;
		if (_lastChoice isEqualTo "") then
		{
			private _ref_name = _ctrlVehFac lbText _comboIndex;
			_lastChoice = 0;
			{
				_ctrlGrpFac lbAdd _x;
				if (_ref_name == _x) then
				{
					_lastChoice = _forEachIndex;
				};
			} forEach (Achilles_var_nestedList_groupFactions select _sideId);
		} else
		{
			{
				_ctrlGrpFac lbAdd _x;
			} forEach (Achilles_var_nestedList_groupFactions select _sideId);
			_lastChoice = [(lbSize _ctrlGrpFac) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlGrpFac);
			_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		};
		_ctrlGrpFac lbSetCurSel _lastChoice;
	};
	case "VEHICLE_CATEGORY":
	{
		private _ctrlSide = _dialog displayCtrl IDC_COMBO_SIDE;
		private _sideId = lbCurSel _ctrlSide;
		private _ctrlVehFac = _dialog displayCtrl IDC_COMBO_VEHICLE_FACTION;
		private _faction_id = lbCurSel _ctrlVehFac;
		
		private _ctrlVeh = _dialog displayCtrl IDC_COMBO_VEHICLE;
		lbClear _ctrlVeh;
		{
			private _lb_id = _ctrlVeh lbAdd getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_ctrlVeh lbSetData [_lb_id, _x];
			_ctrlVeh lbSetTextRight [_lb_id, ["(", (([_x, true] call BIS_fnc_crewCount) - ([_x, false] call BIS_fnc_crewCount)), ") "] joinString ""];
		} forEach (Achilles_var_nestedList_vehicles select _sideId select _faction_id select _comboIndex);
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_3", ""];
		_lastChoice = [(lbSize _ctrlVeh) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlVeh);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlVeh lbSetCurSel _lastChoice;
	};
	case "VEHICLE":
	{
		private _vehicleClass = _ctrl lbData _comboIndex;
		if (_vehicleClass isKindOf "Air") then
		{
			private _ctrlWpTypeLabel = _dialog displayCtrl IDC_COMBO_WP_TYPE_LABEL;
			_ctrlWpTypeLabel ctrlSetFade 0;
			_ctrlWpTypeLabel ctrlCommit 0;
		
			private _ctrlWpType = _dialog displayCtrl IDC_COMBO_WP_TYPE;
			_ctrlWpType ctrlSetFade 0;
			_ctrlWpType ctrlEnable true;
			_ctrlWpType ctrlCommit 0;
			
			// Add/remove HALO option
			if (_vehicleClass isKindOf "Plane") then
			{
				if (lbSize _ctrlWpType == 3) then {_ctrlWpType lbAdd localize "STR_AMAE_HALO"};
			}
			else
			{
				if (lbSize _ctrlWpType == 4) then {_ctrlWpType lbDelete 3};
			};

			_lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_6", 0];
			_lastChoice = [0, _lastChoice] select (_lastChoice isEqualType 0);
			_lastChoice = [(lbSize _ctrlWpType) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlWpType);
			_ctrlWpType lbSetCurSel _lastChoice;
		} else
		{
			{
				private _ctrlWpType = _dialog displayCtrl _x;
				_ctrlWpType ctrlSetFade 0.8;
				_ctrlWpType ctrlEnable false;
				_ctrlWpType ctrlCommit 0;
			} forEach [IDC_COMBO_WP_TYPE,IDC_COMBO_WP_TYPE_LABEL];
		};
	};
	case "GROUP_FACTION":
	{
		private _ctrlSide = _dialog displayCtrl IDC_COMBO_SIDE;
		private _sideId = lbCurSel _ctrlSide;
		private _ctrlGrp = _dialog displayCtrl IDC_COMBO_GROUP;
				
		lbClear _ctrlGrp;
		{
			private _lb_id = _ctrlGrp lbAdd getText (_x >> "Name");
			_ctrlGrp lbSetTextRight [_lb_id, "(" + str count (_x call Achilles_fnc_returnChildren) + ") "];
		} forEach (Achilles_var_nestedList_groups select _sideId select _comboIndex);
		private _lastChoice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_8", 0];
		_lastChoice = [(lbSize _ctrlGrp) - 1, _lastChoice] select (_lastChoice < lbSize _ctrlGrp);
		_lastChoice = [0,_lastChoice] select (_lastChoice isEqualType 0);
		_ctrlGrp lbSetCurSel _lastChoice;
	};
	case "GROUP":
	{
	};
};