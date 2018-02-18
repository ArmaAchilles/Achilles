disableSerialization;
private _password = "12345678";
private _nchar = count _password;
createDialog "RscDisplayEmpty";
private _dialog = findDisplay -1;
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
				if (ctrlText _ctrlEdit == """, _password, """) then
				{
					_ctrlLock ctrlSetText ""\a3\Modules_f\data\iconUnlock_ca.paa"";
					_ctrlLock ctrlSetTextColor [0,1,0,1];
					uiSleep 1;
					closeDialog 1;
				}
				else
				{
					private _ctrlLock = _dialog displayCtrl 2000;
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
				};
			};
		"] joinString ""
	] select _i;
	_ctrlButton ctrlAddEventHandler ["ButtonClick",  _event];
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


params ["_","_intelObject"];
_intelObject setObjectTexture [0, "#(rgb,8,8,3)color(0,0,0,0)"];