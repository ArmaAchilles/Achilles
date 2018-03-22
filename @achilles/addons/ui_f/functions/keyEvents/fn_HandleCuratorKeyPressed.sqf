private _key = _this select 1;
private _handled = false;
if (_key in actionKeys "CuratorLevelObject") then // align up-vector with z-axis (default: X)
{
	private _curatorSelected = ["object"] call Achilles_fnc_getCuratorSelected;
	{
		[getAssignedCuratorLogic player, _x] call Achilles_fnc_HandleCuratorObjectEdited;
	} forEach _curatorSelected;
};
_handled
