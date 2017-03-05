/*
	Author: Karel Moricky, modified by Kex in order to prevent opening of ammo box inventory on spawning

	Description:
	Code executed when curator object is placed.

	Parameter(s):
		0: OBJECT - curator module
		1: OBJECT - edited object

	Returns:
	BOOL
*/

//--- Simplified argument loading to save performance
_object = _this select 1;
_group = group _object;

_object call bis_fnc_curatorAttachObject;
if (!isnull _group && side _group in [east,west,resistance,civilian]) then {[effectivecommander _object,"CuratorObjectPlaced"] call bis_fnc_curatorSayMessage;};

bis_fnc_curatorObjectPlaced_mouseOver = curatormouseover;

true