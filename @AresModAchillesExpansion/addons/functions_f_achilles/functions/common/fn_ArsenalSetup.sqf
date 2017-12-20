/*
    Authors:
        CreepPork_LV,
        Anton Stryuk
    
    Description:
        Sets up any object to be Arsenal but with specific set of objects added.

    Parameters:
        _this select 0: OBJECT - Object to add Arsenal to.
        _this select 1: ARRAY of ARRAYs - Array of data to add ([<weapons>, <magazines>, <items>, <backpacks>]), 2 pieces (one virtual, one "real").
        _this select 2: BOOL (Optional), default: true - True to replace items already in the Arsenal box.

    Returns:
        Nothing
*/

params [["_object", objNull, [objNull]], ["_items", [], [[]]], ["_replaceItems", true, [true]]];

// Get the items from the items passed
_items params 
[
    // Virtual
    ["_itemVRWeapons", [], [[]]],
    ["_itemVRMagazines", [], [[]]],
    ["_itemVRItems", [], [[]]],
    ["_itemVRBackpacks", [], [[]]],
    
    // "Real"
    ["_itemCargoWeapons", [], [[]]],
    ["_itemCargoMagazines", [], [[]]],
    ["_itemCargoItems", [], [[]]],
    ["_itemCargoBackpacks", [], [[]]]
];

// Should we replace all items?
if (_replaceItems) then
{
    // "Real"
    clearWeaponCargoGlobal _object;
    clearMagazineCargoGlobal _object;
    clearItemCargoGlobal _object;
    clearBackpackCargoGlobal _object;

    // Virtual
    [_object, (_object call BIS_fnc_getVirtualWeaponCargo), true] call BIS_fnc_removeVirtualWeaponCargo;
    [_object, (_object call BIS_fnc_getVirtualMagazineCargo), true] call BIS_fnc_removeVirtualMagazineCargo;
    [_object, (_object call BIS_fnc_getVirtualItemCargo), true] call BIS_fnc_removeVirtualItemCargo;
    [_object, (_object call BIS_fnc_getVirtualBackpackCargo), true] call BIS_fnc_removeVirtualBackpackCargo;
};

// Add the Virtual items
[_object, _itemVRWeapons, true] call BIS_fnc_addVirtualWeaponCargo;
[_object, _itemVRMagazines, true] call BIS_fnc_addVirtualMagazineCargo;
[_object, _itemVRItems, true] call BIS_fnc_addVirtualItemCargo;
[_object, _itemVRBackpacks, true] call BIS_fnc_addVirtualBackpackCargo;

{
    if (count _x > 0) then
    {
        _x params ["_item", "_amount"];

        switch (_forEachIndex) do
        {
            case 0:
            {
                {_object addWeaponCargoGlobal [_x, (_amount select _forEachIndex)]} forEach _item;
            };
            case 1:
            {
                {_object addMagazineCargoGlobal [_x, (_amount select _forEachIndex)]} forEach _item;
            };
            case 2:
            {
                {_object addItemCargoGlobal [_x, (_amount select _forEachIndex)]} forEach _item;
            };
            case 3:
            {
                {_object addBackpackCargoGlobal [_x, (_amount select _forEachIndex)]} forEach _item;
            };
        };
    };
} forEach [
    _itemCargoWeapons,
    _itemCargoMagazines,
    _itemCargoItems,
    _itemCargoBackpacks
];

["AmmoboxInit", [_object, false]] spawn BIS_fnc_Arsenal;