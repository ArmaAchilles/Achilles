params["_logic", "_units", "_activated"];

if (_activated) then {
	private _explosive = gettext (configfile >> "cfgvehicles" >> typeof _logic >> "explosive");
	if (_explosive != "") then {
		_explosive = createvehicle [_explosive,position _logic,[],0,"none"];
		_explosive attachto [_logic];

		//--- Show hint to curator who placed the object
		[[["Curator","PlaceMines"],nil,nil,nil,nil,nil,nil,true],"bis_fnc_advHint",_logic] call bis_fnc_mp;

		waituntil {sleep 0.1; isnull _explosive || isnull _logic || !alive _logic};
		if (isnull _logic) then {deletevehicle _explosive;} else {_explosive setdamage 1;};
		deletevehicle _logic;
	};
};
