#include "\ares_zeusExtensions\Ares\module_header.hpp"

_ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (not isnull _ammoBox) then
{
	_dialogResult =
		[
			"Filter Objects",
			[
				["Combine or Replace?", ["Combine with existing items", "Replace existing items"], 1],
				["Limit side-specific equip. to", ["All", "Blufor Only", "Opfor Only", "Greenfor Only", "None"], 1],
				["Add GPS?", ["Yes", "No"]],
				["Add thermals?", ["Yes", "No"], 1],
				["Add NVG's?", ["Yes", "No"]],
				["Static weapon backpacks", ["Yes", "No"], 1],
				["UAV items & backpacks", ["Yes", "No"], 1],
				["Automated weapon backpacks", ["Yes", "No"], 1]
				// Don't ask about tents. No one cares about tents.
			]
		] call Ares_fnc_ShowChooseDialog;
	
	if (count _dialogResult > 0) then
	{
		_dialogCombineOrReplace = _dialogResult select 0;
		_dialogLimitEquipmentToSide = _dialogResult select 1;
		_dialogAddGps = _dialogResult select 2;
		_dialogAddThermals = _dialogResult select 3;
		_dialogAddNvg = _dialogResult select 4;
		_dialogAddStaticWeapons = _dialogResult select 5;
		_dialogAddUav = _dialogResult select 6;
		_dialogAddAutomated = _dialogResult select 7;
		
		// Get the setting for the side-specific items
		_filterChoices = ["All", "Blufor", "Opfor", "Greenfor", "None"];
		_sideSpecificEquipmentFilter = _filterChoices select _dialogLimitEquipmentToSide;
		
		// Apply the side-specific item filters to equipment to include
		_staticWeaponFilter = _filterChoices select 4;
		_uavFilter = _filterChoices select 4;
		_automatedFilter = _filterChoices select 4;
		if (_dialogAddStaticWeapons == 0) then { _staticWeaponFilter = _sideSpecificEquipmentFilter; };
		if (_dialogAddUav == 0) then { _uavFilter = _sideSpecificEquipmentFilter; };
		if (_dialogAddAutomated == 0) then { _automatedFilter = _sideSpecificEquipmentFilter; };
		
		_blacklist =
			[
				(_dialogAddGps == 0), 
				(_dialogAddThermals == 0),
				(_dialogAddNvg == 0),
				_staticWeaponFilter,
				_uavFilter,
				_automatedFilter,
				False
			] call Ares_fnc_GenerateArsenalBlacklist;

		_arsenalData = [_blacklist, _sideSpecificEquipmentFilter] call Ares_fnc_GenerateArsenalDataList;
		
		[_ammoBox, _arsenalData, (_dialogCombineOrReplace == 1)] call Ares_fnc_ArsenalSetup;
		[objNull, "Arsenal objects added."] call bis_fnc_showCuratorFeedbackMessage;
	};
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
