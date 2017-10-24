/*
	Author: Karel Moricky

	Description:
	Code executed when curator object is placed.

	Parameter(s):
		0: OBJECT - curator module
		1: OBJECT - edited object

	Returns:
	BOOL
*/

//--- Simplified argument loading to save performance
private _object = _this select 1;
private _group = group _object;

_object call bis_fnc_curatorAttachObject;
if (!isnull _group && side _group in [east,west,resistance,civilian]) then {[effectivecommander _object,"CuratorObjectPlaced"] call bis_fnc_curatorSayMessage;};

bis_fnc_curatorObjectPlaced_mouseOver = curatormouseover;

private _curatorInfoType = gettext (configfile >> "cfgvehicles" >> typeof _object >> "curatorInfoType");
private _filterAttributes = getnumber (configfile >> _curatorInfoType >> "filterAttributes");

if (_filterAttributes == 0 and ([configfile >> "CfgVehicles" >> typeOf _object, "transportMaxMagazines", 0] call BIS_fnc_returnConfigEntry == 0)) then {_object call bis_fnc_showCuratorAttributes;};

true
