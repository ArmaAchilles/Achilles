/*
    Author:
        CreepPork_LV

    Description:
        Creates a cargo box from the selection and applies Arsenal items to it.

    Parameters:
        None

    Returns:
        Nothing
*/

#include "\achilles\modules_f_ares\module_header.inc"

#include "\achilles\data_f_achilles\Arsenal\arsenalItems.sqf"

// TODO: Add supply boxes too.
#define AMMO_CRATES     ["B_CargoNet_01_ammo_F", "O_CargoNet_01_ammo_F", "I_CargoNet_01_ammo_F", "C_IDAP_CargoNet_01_supplies_F"]
#define YES_NO          [localize "STR_AMAE_YES", localize "STR_AMAE_NO"]
#define SIDE_EQUIPMENT  [localize "STR_AMAE_ALL", "BLUFOR", "OPFOR", localize "STR_AMAE_INDEPENDENT"]
#define GPS             "ItemGPS"

private _ammoCrateDisplayNames = AMMO_CRATES apply {getText (configFile >> "CfgVehicles" >> _x >> "displayName")};

private _dialogResult =
[
    localize "STR_AMAE_ARSENAL_CREATE_CUSTOM",
    [
        [localize "STR_AMAE_AMMUNITION_CRATE", _ammoCrateDisplayNames],
        [localize "STR_AMAE_DEFAULT_INVENTORY", YES_NO]
    ]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_ammoCrate", "_defaultInventory"];
_defaultInventory = _defaultInventory == 0;

private _selectedCrate = AMMO_CRATES select _ammoCrate;

private _object = _selectedCrate createVehicle (getPos _logic);

[[_object]] call Ares_fnc_AddUnitsToCurator;

if (_defaultInventory) exitWith
{
    // Get current cargo from the new box and set it all to be virtual.
	[_object, [(getItemCargo _object) select 0, (getWeaponCargo _object) select 0, (getMagazineCargo _object) select 0, (getBackpackCargo _object) select 0], true] call Achilles_fnc_updateVirtualArsenal;
	// clear inventory
	clearitemcargoglobal _object;
	clearweaponcargoglobal _object;
	clearmagazinecargoglobal _object;
	clearbackpackcargoglobal _object;
	[localize "STR_AMAE_ARSENAL_ADDED"] call Ares_fnc_ShowZeusMessage;
};

private _dialogResult =
[
    localize "STR_AMAE_ARSENAL_CREATE_CUSTOM",
    [
        [localize "STR_AMAE_ARSENAL_SIDE_EQUIPMENT", SIDE_EQUIPMENT, 1],
        [localize "STR_AMAE_ARSENAL_ADD_GPS", YES_NO],
        [localize "STR_AMAE_ARSENAL_ADD_NVGS", YES_NO],
        [localize "STR_AMAE_ARSENAL_ADD_THERMALS", YES_NO, 1],
        [localize "STR_AMAE_ARSENAL_ADD_STATIC_WEAPONS", YES_NO, 1],
        [localize "STR_AMAE_ARSENAL_ADD_AUTOMATED_WEAPONS", YES_NO, 1],
        [localize "STR_AMAE_ARSENAL_ADD_TENTS", YES_NO, 1],
        [localize "STR_AMAE_ARSENAL_ADD_UAVS", YES_NO, 1]
    ]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params
[
    "_sideEquipment",
    "_gps",
    "_nvgs",
    "_thermals",
    "_staticWeapons",
    "_automatedWeapons",
    "_tents",
    "_uavs"
];

// Convert numbers to booleans.
_gps = _gps == 0;
_nvgs = _nvgs == 0;
_thermals = _thermals == 0;
_staticWeapons = _staticWeapons == 0;
_automatedWeapons = _automatedWeapons == 0;
_tents = _tents == 0;
_uavs = _uavs == 0;

// Data array consiting of [<weapons>, <magazines>, <items>, <backpacks>]. All virtual.
private _data = [[], [], [], []];
_data params ["_dataWeapons", "_dataMagazines", "_dataItems", "_dataBackpacks"];

if (_sideEquipment == 0) then
{
    {
        // Get available items from that side.
        private _sideArray = Achilles_var_arsenal_arsenalItems select _x;

        _sideArray params 
        [
            "_arsenalWeapons",
            "_arsenalMagazines",
            "_arsenalItems",
            "_arsenalBackpacks",
            "_arsenalNVGs",
            "_arsenalThermals",
            "_arsenalStaticWeapons",
            "_arsenalAutomatedStaticWeapons",
            "_arsenalTents",
            "_arsenalUAVs",
            "_arsenalUAVController"
        ];

        {
            // Get the currently place that we should put in the current passing data (weapons, magazines, etc.)
            private _selectedData = _data select _forEachIndex;

            {
                // This should always be unique, but just in case.
                _selectedData pushBackUnique _x;
            } forEach _x; // every single weapon or magazine, or item or backpack.
        } forEach [_arsenalWeapons, _arsenalMagazines, _arsenalItems, _arsenalBackpacks];

        // Add the specific items if selected so.
        if (_gps) then {_dataItems pushBackUnique GPS};
        if (_nvgs) then {{_dataItems pushBackUnique _x} forEach _arsenalNVGs};
        if (_thermals) then {{_dataItems pushBackUnique _x} forEach _arsenalThermals};
        if (_staticWeapons) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalStaticWeapons};
        if (_automatedWeapons) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalAutomatedStaticWeapons};
        if (_tents) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalTents};
        if (_uavs) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalUAVs; {_dataItems pushBackUnique _x} forEach _arsenalUAVController};
    } forEach [0,1,2]; // representing sides.
}
else
{
    // We subtract one to remove the count of the All selection here.
    private _sideArray = Achilles_var_arsenal_arsenalItems select (_sideEquipment - 1);

    _sideArray params 
    [
        "_arsenalWeapons",
        "_arsenalMagazines",
        "_arsenalItems",
        "_arsenalBackpacks",
        "_arsenalNVGs",
        "_arsenalThermals",
        "_arsenalStaticWeapons",
        "_arsenalAutomatedStaticWeapons",
        "_arsenalTents",
        "_arsenalUAVs",
        "_arsenalUAVController"
    ];

    {
        private _selectedData = _data select _forEachIndex;
        {
            _selectedData pushBackUnique _x;
        } forEach _x;
    } forEach [_arsenalWeapons, _arsenalMagazines, _arsenalItems, _arsenalBackpacks];

    // Add the specific items if selected so.
    if (_gps) then {_dataItems pushBackUnique GPS};
    if (_nvgs) then {{_dataItems pushBackUnique _x} forEach _arsenalNVGs};
    if (_thermals) then {{_dataItems pushBackUnique _x} forEach _arsenalThermals};
    if (_staticWeapons) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalStaticWeapons};
    if (_automatedWeapons) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalAutomatedStaticWeapons};
    if (_tents) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalTents};
    if (_uavs) then {{_dataBackpacks pushBackUnique _x} forEach _arsenalUAVs; {_dataItems pushBackUnique _x} forEach _arsenalUAVController};
};

// clear inventory
clearitemcargoglobal _object;
clearweaponcargoglobal _object;
clearmagazinecargoglobal _object;
clearbackpackcargoglobal _object;

[_object, _data, true] call Achilles_fnc_updateVirtualArsenal;

[localize "STR_AMAE_ARSENAL_ADDED"] call Ares_fnc_ShowZeusMessage;

#include "\achilles\modules_f_ares\module_footer.inc"