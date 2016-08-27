#include "\achilles\modules_f_ares\module_header.hpp"

_unitUnderCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

if (isNil "Ares_ChangeLightsCodeBlock") then
{
	Ares_ChangeLightsCodeBlock =
	{
		_unitsToModify = _this select 0;
		_lightsSetting = _this select 1;
		{
			_unit = _x;
			if (local _unit && not (isPlayer _unit)) then
			{
				switch (_lightsSetting) do
				{
					case 0: // Force Off
					{
						_unit enableGunLights "forceOff";
						_unit enableIRLasers false;
					};
					case 1: // Force On
					{
						_unit enableGunLights "forceOn";
						_unit enableIRLasers true;
					};
					case 2: // Auto
					{
						_unit enableGunLights "AUTO";
						_unit enableIRLasers false; //Units never use lasers by default.
					};
				};
			};
		} forEach _unitsToModify;
	};
	publicVariable "Ares_ChangeLightsCodeBlock";
};

_units = [];
_lightsSetting = 0;
if (isNull _unitUnderCursor) then
{
	_dialogResult = [
		"Disable/Enable Lights's",
		[
			["Set Lights to:", ["Disabled", "Enabled", "Auto"]],
			["Change Lights for:", ["All Units On Map (including empty)", "All West (NATO) units", "All Independent/Resistance (AAF) units", "All East (CSAT) units", "Civilian units"]]
		]
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult > 0) then
	{
		_lightsSetting = _dialogResult select 0;
		_dialogUnitsToAffect = _dialogResult select 1;
		
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
			"Disable/Enable Lights for group",
			[
				["Set Lights to:", ["Disabled", "Enabled", "Auto"]]
			]
		] call Ares_fnc_ShowChooseDialog;
		
	if (count _dialogResult > 0) then
	{
		_lightsSetting = _dialogResult select 0;
		_units = units (group _unitUnderCursor);
	};
};

if (count _units > 0) then
{
	[[_units, _lightsSetting], "Ares_ChangeLightsCodeBlock", true, true] call BIS_fnc_MP;
	[objnull, format ["Changed light settings on %1 objects.", (count _units)]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
