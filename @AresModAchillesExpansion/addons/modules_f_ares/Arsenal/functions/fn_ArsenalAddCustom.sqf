#include "\achilles\modules_f_ares\module_header.hpp"

private _ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (!isnull _ammoBox) then
{
	private _dialogResult =
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
		_dialogResult params
		[
			"_dialogCombineOrReplace",
			"_dialogLimitEquipmentToSide",
			"_dialogAddGps",
			"_dialogAddThermals",
			"_dialogAddNvg",
			"_dialogAddStaticWeapons",
			"_dialogAddUav",
			"_dialogAddAutomated"
		];

		// Get the setting for the side-specific items
		private _filterChoices = ["All", "Blufor", "Opfor", "Greenfor", "None"];
		private _sideSpecificEquipmentFilter = _filterChoices select _dialogLimitEquipmentToSide;

		// Apply the side-specific item filters to equipment to include
		private _filterChoicesNone = _filterChoices select 4;
		private _staticWeaponFilter = _filterChoicesNone;
		private _uavFilter = _filterChoicesNone;
		private _automatedFilter = _filterChoicesNone;
		if (_dialogAddStaticWeapons == 0) then { _staticWeaponFilter = _sideSpecificEquipmentFilter; };
		if (_dialogAddUav == 0) then { _uavFilter = _sideSpecificEquipmentFilter; };
		if (_dialogAddAutomated == 0) then { _automatedFilter = _sideSpecificEquipmentFilter; };

		private _blacklist =
			[
				(_dialogAddGps == 0),
				(_dialogAddThermals == 0),
				(_dialogAddNvg == 0),
				_staticWeaponFilter,
				_uavFilter,
				_automatedFilter,
				False
			] call Ares_fnc_GenerateArsenalBlacklist;

		private _arsenalData = [_blacklist, _sideSpecificEquipmentFilter] call Ares_fnc_GenerateArsenalDataList;

		[_ammoBox, _arsenalData, (_dialogCombineOrReplace == 1)] call Ares_fnc_ArsenalSetup;
		[objNull, "Arsenal objects added."] call bis_fnc_showCuratorFeedbackMessage;
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
