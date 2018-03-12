// -- to do:
// MAKE SURE ONLY A SINGLE USER CAN DO IT!
// CLOSE THE DIALOG WHEN THE PLAYER DIES!
// HANLDE DIFFERENT ELECTRONIC DEVICES!
// Handle successful exit status.
// Add an animation for the user.
// Make sure that the intel has blackscreen when the intel is placed.
param[1] addAction ["Open tablet", Achilles_fnc_passwordProtectedIntelAction, "12345678", 20, true, false, "", "", 2];

Achilles_fnc_passwordProtectedIntelAction =
{
	params ["_intelObject","_player","_id","_password"];
	private _oldCamView = cameraView;
	_player switchCamera "Internal";
	_player action ["SwitchWeapon", _player, _player, 100];
	uiSleep 2;
	_player hideObject true;
	private _intelVecDir = vectorDir _intelObject;
	private _intelVecUp = vectorUp _intelObject;
	private _camStartPos = ATLToASL positionCameraToWorld [0,0,0];
	private _camStartVecDir = getCameraViewDirection _player;
	private _camEndPos = (getPosASL _intelObject) vectorAdd (_intelVecUp vectorMultiply 0.25);
	private _camEndVecDir = _intelVecUp vectorMultiply -1;
	private _camEndVecUp = _intelVecDir vectorMultiply -1;
	private _cam = "camera" camCreate _camStartPos;
	_cam camSetDir _camStartVecDir;
	_cam camCommit 0;
	private _camStartVecUp = vectorUp _cam;
	_cam cameraEffect ["internal","back"];
	for "_i" from 0 to 50 do
	{
		_cam setVelocityTransformation [_camStartPos, _camEndPos, [0,0,0], [0,0,0], _camStartVecDir, _camEndVecDir, _camStartVecUp, _camEndVecUp, _i/50];
		_cam camCommit 0;
		uiSleep 0.01;
	};
	uiSleep 0.5;
	_intelObject setObjectTextureGlobal [0, "\a3\ui_f_curator\Data\CfgDiaryImages\Altis\Zaros_ca.paa"];
	_password call Achilles_fnc_tabletLockScreen;
	private _dialog = findDisplay -1;
	_dialog setVariable ["params", [_intelObject,_cam,_camStartPos,_camStartVecDir,_oldCamView]];
	_dialog displayAddEventHandler ["unload",
	{
		params ["_dialog","_exitStatus"];
		(_dialog getVariable "params") params ["_intelObject","_cam","_camStartPos","_camStartVecDir","_oldCamView"];
		[_intelObject,_cam,_camStartPos,_camStartVecDir,_oldCamView,_exitStatus] spawn
		{
			params ["_intelObject","_cam","_camStartPos","_camStartVecDir","_oldCamView","_exitStatus"];
			systemChat str _exitStatus;
			private _player = player;
			if (_exitStatus == 2) then
			{
				_intelObject setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0,0,0,0)"];
			};
			uiSleep 0.5;
			_cam camSetPos ASLToATL _camStartPos;
			_cam camSetDir _camStartVecDir;
			_cam camCommit 0.5;
			uiSleep 0.5;
			_cam cameraeffect ["terminate","back"];
			camDestroy _cam;
			_player hideObject false;
			_player action ["SwitchWeapon", _player, _player, 1];
			_player switchCamera _oldCamView;
		};
	}];
};

Achilles_fnc_tabletLockScreen =
{
	disableSerialization;
	params ["_password"];
	private _nchar = count _password;
	createDialog "RscDisplayEmpty";
	private _dialog = findDisplay -1;
	_dialog ctrlCreate ["RscPicture", 2001];
	private _ctrlLock = _dialog displayCtrl 2001;
	_ctrlLock ctrlSetText "\a3\Modules_f\data\iconLock_ca.paa";
	_ctrlLock ctrlSetTextColor [0,0,0,1];
	_ctrlLock ctrlSetPosition [0.4225,0.1975,0.155,0.155];
	_ctrlLock ctrlCommit 0;
	_dialog ctrlCreate ["RscPicture", 2002];
	private _ctrlLock = _dialog displayCtrl 2002;
	_ctrlLock ctrlSetText "\a3\Modules_f\data\iconLock_ca.paa";
	_ctrlLock ctrlSetTextColor [0,0,0,1];
	_ctrlLock ctrlSetPosition [0.4275,0.2025,0.145,0.145];
	_ctrlLock ctrlCommit 0;
	_dialog ctrlCreate ["RscPicture", 2000];
	private _ctrlLock = _dialog displayCtrl 2000;
	_ctrlLock ctrlSetText "\a3\Modules_f\data\iconLock_ca.paa";
	_ctrlLock ctrlSetTextColor [1,1,1,1];
	_ctrlLock ctrlSetPosition [0.425,0.2,0.15,0.15];
	_ctrlLock ctrlCommit 0;
	_dialog ctrlCreate ["RscEdit", 1000];
	private _ctrlEdit = _dialog displayCtrl 1000;
	_ctrlEdit ctrlSetText "";
	_ctrlEdit ctrlSetFont "EtelkaMonospacePro";
	_ctrlEdit ctrlSetFontHeight 0.1;
	_ctrlEdit ctrlSetText "*";
	private _ctrlWidth = 0.018 + ctrlTextWidth _ctrlEdit * _nchar;
	_ctrlEdit ctrlSetPosition [0.5 - _ctrlWidth/2, 0.4, _ctrlWidth,0.1];
	_ctrlEdit ctrlSetText "";
	_ctrlEdit ctrlSetBackgroundColor [0.4,0.4,0.4,0.6];
	_ctrlEdit ctrlCommit 0;
	_ctrlEdit ctrlAddEventHandler ["KeyDown", 
	["
		params[""_ctrlEdit""];
		private _text = toString ((toArray (ctrlText _ctrlEdit)) select {48 <= _x and _x <= 57});
		_ctrlEdit ctrlSetText (_text select [0,", _nchar, "]);
	"] joinString ""];

	for "_i" from 1 to 9 do
	{
		private _idc = 3000 + _i;
		_dialog ctrlCreate ["RscButton", _idc];
		private _ctrlButton = _dialog displayCtrl _idc;
		_ctrlButton ctrlSetFont "EtelkaMonospacePro";
		_ctrlButton ctrlSetFontHeight 0.1;
		_ctrlButton ctrlSetText str _i;
		_ctrlButton ctrlSetPosition [0.35 + 0.1*((_i-1) mod 3),0.55 + 0.1*floor((_i-1)/3),0.095,0.095];
		_ctrlButton ctrlCommit 0;
		_ctrlButton ctrlAddEventHandler ["ButtonClick", 
		["
			private _ctrlEdit = ctrlParent param[0] displayCtrl 1000;
			private _text = ((ctrlText _ctrlEdit) + str ", _i, ") select [0,", _nchar, "];
			_ctrlEdit ctrlSetText _text
		"] joinString ""];
	};
	for "_i" from 0 to 2 do
	{
		private _idc = 3010 + _i;
		_dialog ctrlCreate ["RscButton", _idc];
		private _ctrlButton = _dialog displayCtrl _idc;
		_ctrlButton ctrlSetFont "EtelkaMonospacePro";
		_ctrlButton ctrlSetFontHeight 0.1;
		_ctrlButton ctrlSetText (["C","0","OK"] select _i);
		_ctrlButton ctrlSetPosition [0.35 + 0.1*(_i mod 3),0.85,0.095,0.095];
		_ctrlButton ctrlCommit 0;
		private _event = 
		[
			["
				private _ctrlEdit = ctrlParent param[0] displayCtrl 1000;
				_ctrlEdit ctrlSetText """"
			"] joinString "",
			["
				private _ctrlEdit = ctrlParent param[0] displayCtrl 1000;
				private _text = ((ctrlText _ctrlEdit) + str 0) select [0,", _nchar, "];
				private _ctrlEdit = _dialog displayCtrl 2000;
				_ctrlEdit ctrlSetText _text
			"] joinString "",
			["
				_this spawn
				{
					disableSerialization;
					private _dialog = ctrlParent param[0];
					private _ctrlEdit = _dialog displayCtrl 1000;
					private _ctrlLock = _dialog displayCtrl 2000;
					private _ctrlLockShadows = [_dialog displayCtrl 2001, _dialog displayCtrl 2002];
					if (ctrlText _ctrlEdit == """, _password, """) then
					{
						{_x ctrlSetText ""\a3\Modules_f\data\iconUnlock_ca.paa""} forEach _ctrlLockShadows;
						_ctrlLock ctrlSetText ""\a3\Modules_f\data\iconUnlock_ca.paa"";
						_ctrlLock ctrlSetTextColor [0,1,0,1];
						uiSleep 1;
						closeDialog 1;
					}
					else
					{
						{_x ctrlShow false} forEach _ctrlLockShadows;
						_ctrlLock ctrlSetTextColor [1,0,0,1];
						for ""_"" from 0 to 2 do
						{
							 _ctrlLock ctrlSetPosition [0.43,0.2];
							 _ctrlLock ctrlCommit 0.03;
							 uiSleep 0.03;
							 _ctrlLock ctrlSetPosition [0.42,0.2];
							 _ctrlLock ctrlCommit 0.04;
							 uiSleep 0.04;
							 _ctrlLock ctrlSetPosition [0.425,0.2];
							 _ctrlLock ctrlCommit 0.03;
							 uiSleep 0.03;
						};
						_ctrlLock ctrlSetTextColor [1,1,1,1];
						{_x ctrlShow true} forEach _ctrlLockShadows;
					};
				};
			"] joinString ""
		] select _i;
		_ctrlButton ctrlAddEventHandler ["ButtonClick",  _event];
	};
};


// RuggedTablet
params ["_","_intelObject"];
private _pos = getPosWorld _intelObject;
private _vecDir = vectorDir _intelObject;
private _vecUp = vectorUp _intelObject;
curatorCamera setPosWorld (_pos vectorAdd (_vecUp vectorMultiply 0.25));
curatorCamera setVectorDirAndUp [_vecUp vectorMultiply -1, _vecDir vectorMultiply -1];

// Tablet
params ["_","_intelObject"];
private _pos = getPosWorld _intelObject;
private _vecDir = vectorDir _intelObject;
private _vecUp = vectorUp _intelObject;
curatorCamera setPosWorld (_pos vectorAdd (_vecUp vectorMultiply 0.25));
curatorCamera setVectorDirAndUp [_vecUp vectorMultiply -1, _vecDir];

// Laptop
params ["_","_intelObject"];
private _pos = getPosWorld _intelObject;
private _vecDir = vectorDir _intelObject;
private _vecUp = vectorUp _intelObject;
curatorCamera setPosWorld (_pos vectorAdd (_vecDir vectorMultiply 0.25));
curatorCamera setVectorDirAndUp [_vecDir vectorMultiply -1, _vecUp];

// SmartPhone
params ["_","_intelObject"];
private _pos = getPosWorld _intelObject;
private _vecDir = vectorDir _intelObject;
private _vecUp = vectorUp _intelObject;
curatorCamera setPosWorld (_pos vectorAdd (_vecUp vectorMultiply 0.15));
curatorCamera setVectorDirAndUp [_vecUp vectorMultiply -1, _vecDir vectorMultiply -1];

// set screen texture
params ["_","_intelObject"];
_intelObject setObjectTexture [0, "#(rgb,8,8,3)color(0,0,0,0)"];
_intelObject setObjectTexture [0, "\a3\ui_f_curator\Data\CfgDiaryImages\Altis\Zaros_ca.paa"];
