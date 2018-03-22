/*
    Author:
        CreepPork_LV
    
    Description:
        Checks if specified ACE 3 PBO is loaded.

    Parameters:
        _this select 0: STRING - CfgPatches ACE 3 module to check.
    
    Returns:
        BOOL - is it loaded?
*/

params [["_name", "main", [""]]];

isClass (configFile >> "CfgPatches" >> format ["ace_%1", _name]);