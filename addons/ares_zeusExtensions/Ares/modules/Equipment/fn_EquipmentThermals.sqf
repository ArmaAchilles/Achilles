#include "\ares_zeusExtensions\Ares\module_header.hpp"

_unit = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

_vehicles = [];
_shouldThermalsBeEnabled = false;
if (isNull _unit) then
{
	_dialogResult = [
		"Disable/Enable Thermals",
		[
			["Set thermals to:", ["Enabled", "Disabled"], 1],
			["Change thermals for:", ["All Units On Map (including empty)", "All West (NATO) units", "All Independent/Resistance (AAF) units", "All East (CSAT) units", "All Empty + Civilian vehicles"]]
		]
	] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult > 0) then
	{
		_dialogSetting = _dialogResult select 0;
		_dialogUnitsToAffect = _dialogResult select 1;
		
		_shouldThermalsBeEnabled = (_dialogSetting == 0);
		if (_dialogUnitsToAffect == 0) then
		{
			_vehicles = vehicles;
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
					_vehicles pushBack _x;
				};
			} forEach vehicles;
		};
	};
}
else
{
	_dialogResult =
		[
			"Disable/Enable thermals for group",
			[
				["Set thermals to:", ["Enabled", "Disabled"], 1]
			]
		] call Ares_fnc_ShowChooseDialog;
	if (count _dialogResult > 0) then
	{
		_shouldThermalsBeEnabled = ((_dialogResult select 0) == 0);
		_vehicles = [];
		{
			_vehicles pushBack (vehicle _unit);
		} forEach (units (group _unit));
	};
};

if (count _vehicles > 0) then
{
	{
		_x disableTIEquipment (!_shouldThermalsBeEnabled);
	} forEach _vehicles;
	[objnull, format ["Changed thermal settings on %1 objects.", count _vehicles]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
