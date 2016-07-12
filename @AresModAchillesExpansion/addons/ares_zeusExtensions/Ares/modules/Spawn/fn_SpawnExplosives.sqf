#include "\ares_zeusExtensions\Ares\module_header.hpp"

_offset = position _logic;

_dialogResult = [
	localize "STR_MINES_EXPLOSIVES",
	[
		[localize "STR_CATEGORY",[localize "STR_MINEFIELD", localize "STR_EXPLOSIVE"]],
		[localize "STR_TYPE", [localize "STR_LOADING_"]],
		[localize "STR_NUMBER_OF_MINES", "","30"],
		[localize "STR_RADIUS", "","50"],
		[localize "STR_WARNING_SIGNS", [localize "STR_TRUE", localize "STR_FALSE"]]
	],
	"Ares_fnc_RscDisplayAttributes_SpawnExplosives"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_explosive_type = Ares_var_explosive_type;

if (_dialogResult select 0 == 0) then
{
	_number_of_mines = parseNumber (_dialogResult select 2);
	_radius = parseNumber (_dialogResult select 3);
	_warning = if (_dialogResult select 4 == 0) then {true} else {false};
	
	_x_offset = _offset select 0;
	_y_offset = _offset select 1;
	
	for "_" from 1 to _number_of_mines do
	{	_rho = _radius * (random 1)^(0.5);
		_theta = random 360;
		_pos = [_rho * cos _theta + _x_offset, _rho * sin _theta + _y_offset, 0];
		_mine = _explosive_type createVehicle _pos;
		_mine setPos _pos;
		[[_mine], true] call Ares_fnc_AddUnitsToCurator;
	};
	if (_warning) then
	{
		_circumference = 2*Pi * _radius;
		_number_of_signs = floor (_circumference / 10);
		for "_i" from 1 to _number_of_signs do
		{
			_theta = _i * 360 / _number_of_signs;
			_pos = [_radius * cos _theta + _x_offset, _radius * sin _theta + _y_offset, 0];
			_sign = "Land_Sign_Mines_F" createVehicle _pos;
			_sign setPos _pos;
			_sign setDir -(_theta + 90);
			[[_sign], true] call Ares_fnc_AddUnitsToCurator;
		};
	};
} else
{
	_mine = _explosive_type createVehicle _offset;
	_mine setPos _offset;
	[[_mine], true] call Ares_fnc_AddUnitsToCurator;		
};


#include "\ares_zeusExtensions\Ares\module_footer.hpp"