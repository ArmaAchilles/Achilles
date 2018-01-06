#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_class"];

switch _mode do
{
	case "onLoad":
	{
		private _display = _params select 0;
		private _displayConfig = configfile >> _class;

		private _ctrlBackground = _display displayctrl IDC_RSCDISPLAYATTRIBUTES_BACKGROUND;
		private _ctrlTitle = _display displayctrl IDC_RSCDISPLAYATTRIBUTES_TITLE;
		private _ctrlContent = _display displayctrl IDC_RSCDISPLAYATTRIBUTES_CONTENT;
		private _ctrlButtonOK = _display displayctrl IDC_OK;
		private _ctrlButtonCancel = _display displayctrl IDC_CANCEL;
		private _ctrlButtonCustom = _display displayctrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;

		private _ctrlBackgroundPos = ctrlposition _ctrlBackground;
		private _ctrlTitlePos = ctrlposition _ctrlTitle;
		private _ctrlContentPos = ctrlposition _ctrlContent;
		private _ctrlButtonOKPos = ctrlposition _ctrlButtonOK;
		private _ctrlButtonCancelPos = ctrlposition _ctrlButtonCancel;
		private _ctrlButtonCustomPos = ctrlposition _ctrlButtonCustom;

		private _ctrlTitleOffsetY = (_ctrlBackgroundPos select 1) - (_ctrlTitlePos select 1) - (_ctrlTitlePos select 3);
		private _ctrlContentOffsetY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);

		//--- Show fake map in the background
		private _ctrlMap = _display displayctrl IDC_RSCDISPLAYCURATOR_MAINMAP;
		_ctrlMap ctrlenable false;
		if (visiblemap) then
		{
			private _ctrlCuratorMap = (finddisplay IDD_RSCDISPLAYCURATOR) displayctrl IDC_RSCDISPLAYCURATOR_MAINMAP;
			_ctrlMap ctrlmapanimadd [0,ctrlmapscale _ctrlCuratorMap,_ctrlCuratorMap ctrlmapscreentoworld [0.5,0.5]];
			ctrlmapanimcommit _ctrlMap;
		} else {
			_ctrlMap ctrlshow false;
		};

		//--- Load default attributes
		private _attributes = if (getnumber (_displayConfig >> "filterAttributes") > 0) then {missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_attributes",[]]} else {["%ALL"]};
		private _allAttributes = "%ALL" in _attributes;

		//--- Initialize attributes
		private _posY = _ctrlContentOffsetY;
		private _contentControls = _displayConfig >> "Controls" >> "Content" >> "Controls";
		private _curatorUID = getPlayerUID player;
		private _enableDebugConsole = getMissionConfigValue ["enableDebugConsole", "DebugConsole" call BIS_fnc_getParamValue];
		private _enableAdmin = false;
		if (_enableDebugConsole isEqualType []) then
		{
			_enableAdmin = ((_enableDebugConsole find _curatorUID) != -1) || isServer || !isMultiplayer || (call BIS_fnc_admin) > 0;
		};
		
		if (_enableDebugConsole isEqualType 0) then
		{
			_enableAdmin = (_enableDebugConsole == 1 && (call BIS_fnc_admin > 0 || isServer)) || !isMultiplayer || _enableDebugConsole == 2;
		};
		for "_i" from 0 to (count _contentControls - 1) do {
			private _cfgControl = _contentControls select _i;
			if (isclass _cfgControl) then {
				private _idc = getnumber (_cfgControl >> "idc");
				private _control = _display displayctrl _idc;

				//--- Admin specific attribute
				private _show = [true, _enableAdmin] select (getnumber (_cfgControl >> "adminOnly") > 0);

				if ((_allAttributes || {_x == configname _cfgControl} count _attributes > 0) && _show) then {
					private _controlPos = ctrlposition _control;
					_controlPos set [0,0];
					_controlPos set [1,_posY];
					_control ctrlsetposition _controlPos;
					_control ctrlcommit 0;
					_posY = _posY + (_controlPos select 3) + 0.005;
					ctrlsetfocus _control;
				} else {
					_control ctrlsetposition [0,0,0,0];
					_control ctrlcommit 0;
					_control ctrlshow false;
				};
			};
		};
		private _posH = ((_posY + _ctrlContentOffsetY) min 1.5) * 0.5;

		private _target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
		private _name = switch (typename _target) do {
            case (typename objnull): {gettext (configfile >> "cfgvehicles" >> typeof _target >> "displayname")};
			case (typename grpnull): {groupid _target};
			case (typename []): {format ["%1: %3 #%2",groupid (_target select 0),_target select 1,localize "str_a3_cfgmarkers_waypoint_0"]};
			case (typename ""): {markertext _target};
		};
		_ctrlTitle ctrlsettext format [ctrltext _ctrlTitle,toupper _name];

		_ctrlTitlePos set [1,(0.5 - _posH) - (_ctrlTitlePos select 3) - _ctrlTitleOffsetY];
		_ctrlTitle ctrlsetposition _ctrlTitlePos;
		_ctrlTitle ctrlcommit 0;

		_ctrlContentPos set [1,0.5 - _posH];
		_ctrlContentPos set [3,_posH * 2];
		_ctrlContent ctrlsetposition _ctrlContentPos;
		_ctrlContent ctrlcommit 0;

		_ctrlBackgroundPos set [1,0.5 - _posH];
		_ctrlBackgroundPos set [3,_posH * 2];
		_ctrlBackground ctrlsetposition _ctrlBackgroundPos;
		_ctrlBackground ctrlcommit 0;

		_ctrlButtonOKPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonOK ctrlsetposition _ctrlButtonOKPos;
		_ctrlButtonOK ctrlcommit 0;
		ctrlsetfocus _ctrlButtonOK;

		_ctrlButtonCancelPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonCancel ctrlsetposition _ctrlButtonCancelPos;
		_ctrlButtonCancel ctrlcommit 0;

		_ctrlButtonCustomPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonCustom ctrlsetposition _ctrlButtonCustomPos;
		_ctrlButtonCustom ctrlcommit 0;

		private _y_offset = ((ctrlposition _ctrlButtonCustom) select 1) - 16.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) -	(safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2);
		{
			private _idc = _x;
			private _ctrlButtonCustomPlus = _display displayctrl _idc;
			private _ctrlButtonCustomPlusPos = ctrlposition _ctrlButtonCustomPlus;
			_ctrlButtonCustomPlusPos set [1,(_ctrlButtonCustomPlusPos select 1) + _y_offset];
			_ctrlButtonCustomPlus ctrlsetposition _ctrlButtonCustomPlusPos;
			_ctrlButtonCustomPlus ctrlcommit 0;
		} forEach [30005,30006,30007,30008,30009];

		//--- Close the display when entity is altered
		[_display] spawn
		{
			disableserialization;
			_display = _this select 0;
			_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
			switch (typename _target) do {
				case (typename objnull): {
					private _isAlive = alive _target;
					waituntil {isnull _display || (_isAlive && !alive _target)};
				};
				case (typename grpnull): {
					waituntil {isnull _display || isnull _target};
				};
				case (typename []): {
					private _grp = _target select 0;
					private _wpCount = count waypoints _grp;
					waituntil {isnull _display || (count waypoints _grp != _wpCount)};
				};
				case (typename ""): {
					waituntil {isnull _display || markertype _target == ""};
				};
			};
			_display closedisplay 2;
		};
	};
	case "onUnload": {};
};
