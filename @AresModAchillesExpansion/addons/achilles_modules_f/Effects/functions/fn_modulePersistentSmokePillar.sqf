_mode = _this select 0;
_params = _this select 1;
_logic = _params select 0;

switch _mode do 
{
	//--- Some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";

	//--- Added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": 
	{
		_smokeType = _logic getVariable ["type",getNumber (configfile >> "cfgvehicles" >> typeof _logic >> "smokeType")];
		if (typeName _smokeType == "SCALAR") then 
		{
			//--- Delete previous light source
			_sources = _logic getvariable ["bis_fnc_moduleSmokeSource_source",[objnull]];
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
		_sources = _logic getvariable ["bis_fnc_moduleSmokeSource_source",[objNull]];
		{deletevehicle _x} forEach _sources;
	};

	//--- Default object init
	case "init": 
	{
		_activated = _params select 1;
		_isCuratorPlaced = _params select 2;

		//--- Terminate on all machines where the module is not local
		if !(local _logic) exitwith {};
		
		_sourceObject = "Land_ClutterCutter_small_F" createVehicle (position _logic);
		_smokeType = _logic getVariable ["type",getNumber (configfile >> "cfgvehicles" >> typeof _logic >> "smokeType")];
		_sources = [_smokeType, _sourceObject] call Achilles_fnc_spawnSmoke;
		[[_sourceObject], true] call Ares_fnc_AddUnitsToCurator;
		deleteVehicle _logic;	
	};
};

//_effect_logic = (createGroup sideLogic) createUnit ["Ares_Module_Hint",(_this select 0), [], 0, "NONE"];
//["init",[_effect_logic,true,true]] call Achilles_fnc_modulesmokeSource