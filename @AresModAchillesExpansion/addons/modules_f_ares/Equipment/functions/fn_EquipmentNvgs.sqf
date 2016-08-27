#include "\achilles\modules_f_ares\module_header.hpp"
_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNil "Ares_ChangeNvgCodeBlock") then
{
	Ares_ChangeNvgCodeBlock =
	{
		_unitsToModify = _this select 0;
		_enableNvgs = _this select 1;
		{
			_unit = _x;
			if (local _unit && not (isPlayer _unit)) then
			{
				if (_enableNvgs) then
				{
					_goggles = "NVGoggles";
					switch (side _unit) do
					{
						case east: { _goggles = "NVGoggles_OPFOR"; };
						case independent: { _goggles = "NVGoggles_INDEP"; };
					};
					_unit linkItem _goggles;
					_unit removePrimaryWeaponItem "acc_flashlight";
					_unit addPrimaryWeaponItem "acc_pointer_IR";
				}
				else
				{
					{
						_unit unassignItem _x;
						_unit removeItem _x;
					} forEach ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP"];
					_unit removePrimaryWeaponItem "acc_pointer_IR";
					_unit addPrimaryWeaponItem "acc_flashlight";
				};
			};
		} forEach _unitsToModify;
	};
	publicVariable "Ares_ChangeNvgCodeBlock";
};

_units = [];
_enableNvgs = false;
if (isNull _unitUnderCursor) then
{
	_dialogResult = [
		"Disable/Enable NVG's",
		[
			["Set NVG's to:", ["Enabled", "Disabled"], 1],
			["Change NVG's for:", ["All Units On Map (including empty)", "All West (NATO) units", "All Independent/Resistance (AAF) units", "All East (CSAT) units", "Civilian units"]]
		]
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult > 0) then
	{
		_dialogSetting = _dialogResult select 0;
		_dialogUnitsToAffect = _dialogResult select 1;
		
		_enableNvgs = (_dialogSetting == 0);
		if (_dialogUnitsToAffect == 0) then
		{
			_units = allUnits;
		}
		else
		{
			private ["_desiredSide"];
			
			switch (_dialogUnitsToAffect) do
			{
				case 1: { _desiredSide = west; };
				case 2: { _desiredSide = independent; };
				case 3: { _desiredSide = east; };
				case 4: { _desiredSide = civilian; };
			};
			
			{
				if (side _x == _desiredSide) then
				{
					_units pushBack _x;
				};
			} forEach allUnits;
		};
	};
}
else
{
	_dialogResult =
		[
			"Disable/Enable NVG's for group",
			[
				["Set NVG's to:", ["Enabled", "Disabled"], 1]
			]
		] call Ares_fnc_ShowChooseDialog;
		
	if (count _dialogResult > 0) then
	{
		_enableNvgs = ((_dialogResult select 0) == 0);
		_units = units (group _unitUnderCursor);
	};
};

if (count _units > 0) then
{
	[[_units, _enableNvgs], "Ares_ChangeNvgCodeBlock", true, true] call BIS_fnc_MP;
	[objnull, format ["Changed NVG settings on %1 objects.", (count _units)]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
