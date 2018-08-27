class ACE_ZeusActions
{
	class ZeusUnits
	{
		class switchUnit
		{
			displayName = "$STR_AMAE_SWITCH_UNIT";
			icon = "\achilles\data_f_achilles\icons\icon_unit.paa";
			statement = "_unit = objNull; { if ((side _x in [east,west,resistance,civilian]) && !(isPlayer _x)) exitWith { _unit = _x; }; } forEach (curatorSelected select 0); bis_fnc_curatorObjectPlaced_mouseOver = ['OBJECT',_unit]; [Achilles_fnc_switchUnit_start, [_unit]] call CBA_fnc_directCall;";
		};
	};
};