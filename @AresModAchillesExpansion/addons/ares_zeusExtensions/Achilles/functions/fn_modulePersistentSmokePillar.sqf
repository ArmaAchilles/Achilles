_mode = _this select 0;
_params = _this select 1;
_logic = _params select 0;

switch _mode do {
	//--- Some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";

	//--- Added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
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
	case "unregisteredFromWorld3DEN": {
		_sources = _logic getvariable ["bis_fnc_moduleSmokeSource_source",[objNull]];
		{deletevehicle _x} forEach _sources;
	};

	//--- Default object init
	case "init": {
		_activated = _params select 1;
		_isCuratorPlaced = _params select 2;

		//--- Local to curator who placed the module
		if (_isCuratorPlaced && {local _x} count (objectcurators _logic) > 0) then {
			//--- Reveal the circle to curators
			_logic hideobject false;
			_logic setpos position _logic;
		};

		//--- Terminate on client, all effects are handled by server
		//if !(isserver) exitwith {};

		//--- Call effects (not in 3DEN, "registeredToWorld3DEN" handler is called automatically)
		if (_activated && !is3DEN) then {
			["registeredToWorld3DEN",[_logic]] spawn Achilles_fnc_modulePersistentSmokePillar;
		};
	};
};

//_effect_logic = (createGroup sideLogic) createUnit ["Ares_Module_Hint",(_this select 0), [], 0, "NONE"];
//["init",[_effect_logic,true,true]] call Achilles_fnc_modulesmokeSource