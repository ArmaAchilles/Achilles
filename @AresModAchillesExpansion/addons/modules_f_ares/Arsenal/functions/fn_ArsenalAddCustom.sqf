#include "\achilles\modules_f_ares\module_header.hpp"

private _ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (!isnull _ammoBox) then
{
	private _dialogResult =
		[
			localize "STR_AMAE_FILTER_OBJECTS",
			[
				[localize "STR_AMAE_COMBINE_REPLACE", [localize "STR_AMAE_COMBINE", localize "STR_AMAE_REPLACE"], 1],
				[localize "STR_AMAE_LIMIT_SIDE", [localize "STR_AMAE_ALL", (localize "STR_AMAE_ONLY") + " " + (localize "STR_AMAE_BLUFOR", (localize "STR_AMAE_ONLY") + " " + (localize "STR_AMAE_OPFOR"), (localize "STR_AMAE_ONLY") + " " + (localize "STR_AMAE_GREENFOR"), localize "STR_AMAE_NONE_EQUIPMENT"], 1],
				[localize "STR_AMAE_ADD_GPS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
				[localize "STR_AMAE_ADD_THERMALS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
				[localize "STR_AMAE_ADD_NVGS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
				[localize "STR_AMAE_STATIC_BACKPACKS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
				[localize "STR_AMAE_UAV_BACKPACKS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1],
				[localize "STR_AMAE_AUTOMATED_BACKPACKS", [localize "STR_AMAE_YES", localize "STR_AMAE_NO"], 1]
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
		[localize "STR_AMAE_ARSENAL_ADDED"] call Ares_fnc_ShowZeusMessage;
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
