#define COLOR_NAMES ["white","blue","red","green","yellow"]
#define COLOR_RGB	[[1,1,1],[0,0,1],[1,0,0],[0,1,0],[1,1,0]]

params ["_mode", "_params"];
private _logic = _params select 0;

switch _mode do {
	//--- Some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";

	//--- Added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		private _colorName = _logic getVariable ["type",getText (configfile >> "cfgvehicles" >> typeof _logic >> "color")];
		private _colorIndex = COLOR_NAMES find _colorName;
		if (_colorIndex != -1) then
		{

			//--- Delete previous light source
			private _source = _logic getvariable ["bis_fnc_moduleLightSource_source",objnull];
			deletevehicle _source;

			//--- Create new light source
			private _pos = getposatl _logic;
			_source = "#lightpoint" createVehicle _pos;
			_source setLightBrightness 1.0;
			private _color = COLOR_RGB select _colorIndex;
			_source setLightAmbient  _color;
			_source setLightColor _color;
			_source setposatl _pos;

			if (is3DEN) then {
				//--- Save light source for other use in 3DEN
				_logic setvariable ["bis_fnc_moduleLightSource_source",_source];
			} else {
				//--- Attach to logic, so it moves together with it
				_source lightAttachObject [_logic,[0,0,0]];

				//--- Wait until either logic or light source disappears
				waituntil {
					sleep 1;
					isnull _source || isnull _logic
				};

				deletevehicle _source;
				deletevehicle _logic;
			};
		} else {
			["Cannot create light source, 'color' config attribute is missing in %1",typeof _logic] call bis_fnc_error;
		};
	};

	//--- Removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
		private _source = _logic getvariable ["bis_fnc_moduleLightSource_source",objnull];
		deletevehicle _source;
	};

	//--- Default object init
	case "init": {
		private _activated = _params select 1;
		private _isCuratorPlaced = _params select 2;
		private _pos = position _logic;

		//--- Terminate on all machines where the module is not local
		if !(local _logic) exitwith {};

		private _sourceObject = "Land_ClutterCutter_small_F" createVehicle _pos;
		_sourceObject setPos _pos;
		private _colorName = _logic getVariable ["type",getText (configfile >> "cfgvehicles" >> typeof _logic >> "color")];
		private _colorIndex = COLOR_NAMES find _colorName;
		private _color = COLOR_RGB select _colorIndex;

		private _source = "#lightpoint" createVehicle [0,0,0];
		_source lightAttachObject [_sourceObject,[0,0,0]];
		[[_source,_color],
		{
			params ["_source","_color"];
			_source setLightBrightness 1.0;
			_source setLightAmbient  _color;
			_source setLightColor _color;
		},0,_source] call Achilles_fnc_spawn;
		_sourceObject setVariable ["LightAttributes",[_color, [1,1,1,1]],true];
		[[_sourceObject], true] call Ares_fnc_AddUnitsToCurator;
		deleteVehicle _logic;

		_sourceObject setVariable ["source", _source];
		_sourceObject addEventHandler ["Deleted", {_source = (_this select 0) getVariable "source"; deletevehicle _source}];

		[_sourceObject] call Achilles_fnc_lightSourceAttributes;
	};
};

//_effect_logic = (createGroup sideLogic) createUnit ["Ares_Module_Hint",(_this select 0), [], 0, "NONE"];
//["init",[_effect_logic,true,true]] call Achilles_fnc_moduleLightSource
