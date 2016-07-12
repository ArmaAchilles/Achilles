
#define COLOR_NAMES ["white","blue","red","green","yellow"]
#define COLOR_RGB	[[1,1,1],[0,0,1],[1,0,0],[0,1,0],[1,1,0]]

_mode = _this select 0;
_params = _this select 1;
_logic = _params select 0;

switch _mode do {
	//--- Some attributes were changed (including position and rotation)
	case "attributesChanged3DEN";

	//--- Added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		_colorName = _logic getVariable ["type",getText (configfile >> "cfgvehicles" >> typeof _logic >> "color")];
		_colorIndex = COLOR_NAMES find _colorName;
		if (_colorIndex != -1) then 
		{

			//--- Delete previous light source
			_source = _logic getvariable ["bis_fnc_moduleLightSource_source",objnull];
			deletevehicle _source;

			//--- Create new light source
			_pos = getposatl _logic;
			_source = "#lightpoint" createVehicle _pos;
			_source setLightBrightness 1.0;
			_color = COLOR_RGB select _colorIndex;
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
		_source = _logic getvariable ["bis_fnc_moduleLightSource_source",objnull];
		deletevehicle _source;
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
			["registeredToWorld3DEN",[_logic]] spawn Achilles_fnc_moduleLightSource;
		};
	};
};

//_effect_logic = (createGroup sideLogic) createUnit ["Ares_Module_Hint",(_this select 0), [], 0, "NONE"];
//["init",[_effect_logic,true,true]] call Achilles_fnc_moduleLightSource