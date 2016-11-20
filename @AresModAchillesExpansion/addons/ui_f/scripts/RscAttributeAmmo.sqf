#define IDC_RSCATTRIBUTEAMMO_VALUE	14375

//Broadcast set ammo function
if (isNil "Achilles_var_setammo_init_done") then
{
	publicVariable "Achilles_fnc_setUnitAmmoDef";
	Achilles_var_setammo_init_done = true;
};

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		_ammo = if (_unit isKindOf "Man") then {_unit call Achilles_fnc_getUnitAmmoDef} else {_unit call Achilles_fnc_getVehicleAmmoDef};
		_ctrlSlider slidersetposition (_ammo * 10);
		_ctrlSlider ctrlEnable alive _unit;
	};
	case "confirmed": 
	{
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEAMMO_VALUE;
		_ammo = sliderposition _ctrlSlider * 0.1;
		_previousAmmo = if (_unit isKindOf "Man") then {_unit call Achilles_fnc_getUnitAmmoDef} else {_unit call Achilles_fnc_getVehicleAmmoDef};
		if (abs(_previousAmmo - _ammo) < 0.01) exitwith {};
		
		if (local _unit) then {
			if (_unit isKindOf "Man") then {[_unit, _ammo] call Achilles_fnc_setUnitAmmoDef} else {_unit setVehicleAmmoDef _ammo};
		} else {
			if (_unit isKindOf "Man") then {[_unit,_ammo] remoteExec ["Achilles_fnc_setUnitAmmoDef",_unit]} else {[_unit,_ammo] remoteExec ["setVehicleAmmoDef",_unit]};
		};
	};
	case "onUnload": {};
};