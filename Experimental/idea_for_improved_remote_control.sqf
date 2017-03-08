//["onUnload",[]]execVM "A3\ui_f_curator\UI\displays\RscDisplayCurator.sqf";

[_this select 1] spawn
{
	_unit = _this select 0;
	_vehicle = vehicle _unit;
	_cam = "camera" camcreate getposatl curatorcamera;
	_cam cameraeffect ["internal","back"];
	_cam campreparetarget (screentoworld [0.5,0.5]);
	_cam camcommitprepared 0;
	_cam campreparetarget _unit;
	_cam campreparefov 0.1;
	_cam camcommitprepared 1;
	sleep 0.75;

	("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black out",0.25];
	sleep 0.25;

	player remotecontrol _unit;
	
	if (cameraon != _vehicle) then {
		_vehicle switchcamera cameraview;
		_vehicle cameraeffect ["terminate","back"];
	};

	_cam cameraeffect ["terminate","back"];
	camdestroy _cam;
	
	_curator = getassignedcuratorlogic player;
	[_curator,"curatorObjectRemoteControlled",[_curator,player,_unit,true]] call bis_fnc_callScriptedEventHandler;
	[["Curator","RemoteControl"],nil,nil,nil,nil,nil,nil,true] call bis_fnc_advHint;
	("bis_fnc_moduleRemoteCurator" call bis_fnc_rscLayer) cuttext ["","black in",0.5];

	hint "remote camera";
	
	_eh_id = (findDisplay 312) displayAddEventHandler ["KeyDown",
	{
		_handled = false;
		switch (_this select 1) do
		{
			case 14: {(findDisplay 312) createDisplay "RscDisplayMission"; _handled = true};
			case 21: {Achilles_var_exitRemote = true; _handled = true};
		};
		_handled;
	}];
	
	_vehicle = vehicle _unit;
	_vehicleRole = str assignedvehiclerole _unit;
	_rating = rating player;
	_time = time;
	_delay = 5;
	Achilles_var_exitRemote = false;
	waituntil 
	{
		if ((vehicle _unit != _vehicle || str assignedvehiclerole _unit != _vehicleRole) && {alive _unit}) then {
			player remotecontrol _unit;
			_vehicle = vehicle _unit;
			_vehicleRole = str assignedvehiclerole _unit;
		};
		if (rating player < _rating) then {
			player addrating (-rating player + _rating);
		};
		sleep 0.01;
		(cameraon == vehicle player)
		||
		{!alive _unit}
		||
		{!alive player}
		||
		{isnull getassignedcuratorlogic player}
		||
		{Achilles_var_exitRemote}
	};
	
	(findDisplay 312) displayRemoveEventHandler ["keyDown",_eh_id];
	hint "curator camera";
	player addrating (-rating player + _rating);
	ObjNull remotecontrol _unit;
	_unit setvariable ["bis_fnc_moduleRemoteControl_owner",nil,true];
	[_curator,"curatorObjectRemoteControlled",[_curator,player,_unit,false]] call bis_fnc_callScriptedEventHandler;

	curatorCamera switchcamera cameraview;
	curatorCamera cameraEffect ["internal", "BACK"];
};
/*
	_unit = (allunits select 1);
	_curator = getassignedcuratorlogic player;
	_rating = rating player;
	hint "curator camera";
	player addrating (-rating player + _rating);
	ObjNull remotecontrol _unit;
	_unit setvariable ["bis_fnc_moduleRemoteControl_owner",nil,true];
	[_curator,"curatorObjectRemoteControlled",[_curator,player,_unit,false]] call bis_fnc_callScriptedEventHandler;

	curatorCamera switchcamera cameraview;
	curatorCamera cameraeffect ["terminate","external"];
*/