#define IDC_RSCATTRIBUTEAMMO_VALUE	14375

//Broadcast set ammo function
if (isNil "Achilles_var_setammo_init_done") then {
	publicVariable "Achilles_fnc_setUnitAmmoDef";
	publicVariable "Achilles_fnc_setVehicleAmmo";
	publicVariable "Achilles_fnc_setVehicleMags";
	Achilles_var_setammo_init_done = true;
};

params["_mode", "_params", "_unit"];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		private _ammo = if (_unit isKindOf "Man") then {_unit call Achilles_fnc_getUnitAmmoDef} else {_unit call Achilles_fnc_getVehicleAmmo};
		_ctrlSlider sliderSetRange [0, 1];
		_ctrlSlider sliderSetSpeed [0.1, 0.3];
		_ctrlSlider slidersetposition _ammo;
		_ctrlSlider ctrlSetTooltip str _ammo;
		_ctrlSlider ctrlSetEventHandler ["SliderPosChanged", "params [""_ctrl"", ""_value""]; _ctrl ctrlSetTooltip str _value;"];
		_ctrlSlider ctrlEnable alive _unit;
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		private _ammo = sliderposition _ctrlSlider;
		if (_unit isKindOf "Man") then {
			private _previousAmmo = _unit call Achilles_fnc_getUnitAmmoDef;
			if (abs(_previousAmmo - _ammo) < 0.01) exitWith {};
			private _curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
			{
				if (local _x) then {
					[_x, _ammo] call Achilles_fnc_setUnitAmmoDef;
				} else {
					[_x, _ammo] remoteExecCall ["Achilles_fnc_setUnitAmmoDef", _x];
				};
			} forEach _curatorSelected;
		} else {
			private _previousAmmo = _unit call Achilles_fnc_getVehicleAmmo;
			if (abs(_previousAmmo - _ammo) < 0.01) exitWith {};
			private _curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
			{
				if (local _x) then {
					[_x, _ammo] call Achilles_fnc_setVehicleAmmo;
				} else {
					[_x, _ammo] remoteExecCall ["Achilles_fnc_setVehicleAmmo", _x];
				};
			} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};
