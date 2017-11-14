private _mode = _this select 0;
private _params = _this select 1;
private _logic = _params select 0;

switch _mode do
{
	//--- Some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";

	//--- Added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN":
	{
		private _smokeType = _logic getVariable ["type",getNumber (configfile >> "cfgvehicles" >> typeof _logic >> "smokeType")];
		if (_smokeType isEqualType 0) then 
		{
			//--- Delete previous light source
			private _sources = _logic getvariable ["bis_fnc_moduleSmokeSource_source",[objnull]];
			{deletevehicle _x} forEach _sources;

			//--- Create new smoke source
			_sources = [_smokeType, _logic] call Achilles_fnc_spawnSmoke;

			if (is3DEN) then {
				//--- Save smoke source for other use in 3DEN
				_logic setvariable ["bis_fnc_moduleSmokeSource_source",_sources];
			} else {
				//--- Wait until either logic or smoke source disappears
				waituntil {
					sleep 1;
					isnull _logic
				};

				deletevehicle _logic;
			};
		} else {
			["Cannot create smoke source, 'smokeType' config attribute is missing in %1",typeof _logic] call bis_fnc_error;
		};
	};

	//--- Removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN":
	{
		private _sources = _logic getvariable ["bis_fnc_moduleSmokeSource_source",[objNull]];
		{deletevehicle _x} forEach _sources;
	};

	//--- Default object init
	case "init":
	{
		private _activated = _params select 1;
		private _isCuratorPlaced = _params select 2;
		private _pos = position _logic;

		//--- Terminate on all machines where the module is not local
		if !(local _logic) exitwith {};

		private _sourceObject = "Land_ClutterCutter_small_F" createVehicle _pos;
		_sourceObject setPos _pos;
		private _smokeType = _logic getVariable ["type",getNumber (configfile >> "cfgvehicles" >> typeof _logic >> "smokeType")];
		private _sources = [_smokeType, _sourceObject] call Achilles_fnc_spawnSmoke;
		[[_sourceObject], true] call Ares_fnc_AddUnitsToCurator;
		deleteVehicle _logic;
	};
};

//_effect_logic = (createGroup sideLogic) createUnit ["Ares_Module_Hint",(_this select 0), [], 0, "NONE"];
//["init",[_effect_logic,true,true]] call Achilles_fnc_modulesmokeSource
