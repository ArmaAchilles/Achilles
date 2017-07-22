#define IDC_RSCATTRIBUTEAMMO_VALUE	14375

//Broadcast set ammo function
if (isNil "Achilles_var_setammo_init_done") then {
	publicVariable "Achilles_fnc_setUnitAmmoDef";
	publicVariable "Achilles_fnc_setVehicleAmmoDef";
	Achilles_var_setammo_init_done = true;
};

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		_ammo = if (_unit isKindOf "Man") then {_unit call Achilles_fnc_getUnitAmmoDef} else {_unit call Achilles_fnc_getVehicleAmmoDef};
		_ctrlSlider slidersetposition (_ammo * 10);
		_ctrlSlider ctrlEnable alive _unit;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		_ammo = sliderposition _ctrlSlider * 0.1;
		if (_unit isKindOf "Man") then {
			_previousAmmo = _unit call Achilles_fnc_getUnitAmmoDef;
			if (abs(_previousAmmo - _ammo) < 0.01) exitWith {};
			_curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
			{
				if (local _x) then {
					[_x, _ammo] call Achilles_fnc_setUnitAmmoDef;
				} else {
					[_x, _ammo] remoteExecCall ["Achilles_fnc_setUnitAmmoDef", _x];
				};
			} forEach _curatorSelected;
		} else {
			_previousAmmo = _unit call Achilles_fnc_getVehicleAmmoDef;
			if (abs(_previousAmmo - _ammo) < 0.01) exitWith {};
			_curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
			{
				if (local _x) then {
					[_x, _ammo] call Achilles_fnc_setVehicleAmmoDef;
				} else {
					[_x, _ammo] remoteExecCall ["Achilles_fnc_setVehicleAmmoDef", _x];
				};
			} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};