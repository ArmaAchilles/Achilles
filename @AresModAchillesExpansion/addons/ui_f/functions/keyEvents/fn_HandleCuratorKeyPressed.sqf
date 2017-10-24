private ["_key","_handled"];
_key = _this select 1;
_handled = false;
switch (true) do
{
	case (_key in actionKeys  "CuratorLevelObject"): // align up-vector with z-axis (default: X)
	{
		private _curatorSelected = ["object"] call Achilles_fnc_getCuratorSelected;
		{
			[getAssignedCuratorLogic player, _x] call Achilles_fnc_HandleCuratorObjectEdited;
		} forEach _curatorSelected;
	};
};
_handled
