#define IDC_RSCATTRIBUTEYEAR_VALUE				101
#define IDC_RSCATTRIBUTEMONTH_VALUE				102
#define IDC_RSCATTRIBUTEDAY_VALUE				103
#define IDC_RSCATTRIBUTETIMESLIDER_VALUE		104
#define IDC_RSCATTRIBUTEHOUR_VALUE				105
#define IDC_RSCATTRIBUTEMINUTE_VALUE			106
#define IDC_RSCATTRIBUTESECOND_VALUE			107
#define IDC_RSCATTRIBUTEPREVIEWGROUP_VALUE		110
#define IDC_RSCATTRIBUTEPREVIEWNIGHT1_VALUE		111
#define IDC_RSCATTRIBUTEPREVIEWNIGHT2_VALUE		112
#define IDC_RSCATTRIBUTEPREVIEWDAY_VALUE		113
#define IDC_RSCATTRIBUTEPREVIEWSUNRISE_VALUE	114
#define IDC_RSCATTRIBUTEPREVIEWSUNSET_VALUE		115
#define IDC_RSCATTRIBUTEPREVIEWSUN_VALUE		116
#define IDC_RSCATTRIBUTEDIALOGTITLE_VALUE		30002
#define IDC_RSCATTRIBUTEPREVIEWBUTTON_VALUE		30004

#define FIRST_YEAR		1982
#define LAST_YEAR		2050



_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		_date = date;
		_currentYear = _date select 0;
		_currentMonth = _date select 1;
		_currentDay = _date select 2;
		_currentHour = _date select 3;
		_currentMinute = _date select 4;

		_display = _params select 0;
		_ctrlTitle = _display displayCtrl IDC_RSCATTRIBUTEDIALOGTITLE_VALUE;
		_ctrlTitle ctrlSetText localize "STR_SET_DATE";
		
		// set year
		_ctrlYear = _display displayctrl IDC_RSCATTRIBUTEYEAR_VALUE;
		_ctrlYear ctrladdeventhandler ["LbSelChanged","with uinamespace do {['changedYearOrMonth',[ctrlParent (_this select 0)],objnull] call RscAttributeDate};"];
		for '_y' from FIRST_YEAR to LAST_YEAR do
		{
			_lbadd = _ctrlYear lbadd str _y;
			_ctrlYear lbsetvalue [_lbadd,_y];
		};
		_ctrlYear lbsetcursel (_currentYear - FIRST_YEAR);
		
		// set month
		_ctrlMonth = _display displayctrl IDC_RSCATTRIBUTEMONTH_VALUE;
		_ctrlMonth ctrladdeventhandler ["LbSelChanged","with uinamespace do {['changedYearOrMonth',[ctrlParent (_this select 0)],objnull] call RscAttributeDate};"];
		_ctrlMonth lbsetcursel (_currentMonth - 1);
		
		["changedYearOrMonth",[ctrlParent _ctrlMonth],objnull] call RscAttributeDate;
		
		// set day
		_ctrlDay = _display displayctrl IDC_RSCATTRIBUTEDAY_VALUE;
		_ctrlDay ctrladdeventhandler ["LbSelChanged","with uinamespace do {['changedDay',[ctrlParent (_this select 0)],objnull] call RscAttributeDate};"];
		_ctrlDay lbsetcursel (_currentDay - 1);
		
		["changedDay",[ctrlParent _ctrlDay],objnull] call RscAttributeDate;
		
		// set day time
		_ctrlHour = _display displayctrl IDC_RSCATTRIBUTEHOUR_VALUE;
		_ctrlHour ctrladdeventhandler ["KillFocus","with uinamespace do {['changedHHMMSS',[_this select 0],objnull] call RscAttributeDate};"];
		_ctrlMinute = _display displayctrl IDC_RSCATTRIBUTEMINUTE_VALUE;
		_ctrlMinute ctrladdeventhandler ["KillFocus","with uinamespace do {['changedHHMMSS',[_this select 0],objnull] call RscAttributeDate};"];
		_ctrlSecond = _display displayctrl IDC_RSCATTRIBUTESECOND_VALUE;
		_ctrlSecond ctrladdeventhandler ["KillFocus","with uinamespace do {['changedHHMMSS',[_this select 0],objnull] call RscAttributeDate};"];
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTETIMESLIDER_VALUE;
		_ctrlSlider ctrladdeventhandler ["SliderPosChanged","with uinamespace do {['changedTimeSlider',[ctrlParent (_this select 0)],objnull] call RscAttributeDate};"];
		_ctrlSlider sliderSetPosition (_currentHour * 60 + _currentMinute);
		
		["changedTimeSlider",[ctrlParent _ctrlSlider],objnull] call RscAttributeDate;
		
	};
	case "changedYearOrMonth":
	{
		_display = _params select 0;
		_ctrlYear = _display displayctrl IDC_RSCATTRIBUTEYEAR_VALUE;
		_ctrlMonth = _display displayctrl IDC_RSCATTRIBUTEMONTH_VALUE;
		_ctrlDay = _display displayctrl IDC_RSCATTRIBUTEDAY_VALUE;
		_year = _ctrlYear lbvalue lbcursel _ctrlYear;
		_month = _ctrlMonth lbvalue lbcursel _ctrlMonth;
		_isLeapYear = false;
		_days = switch _month do {
			case 1: {31};
			case 2: {
				if ((_year % 4 == 0 && _year % 100 != 0) || (_year % 400 == 0)) then {_isLeapYear = true; 29} else {28};
			};
			case 3: {31};
			case 4: {30};
			case 5: {31};
			case 6: {30};
			case 7: {31};
			case 8: {31};
			case 9: {30};
			case 10: {31};
			case 11: {30};
			case 12: {31};
			default {0};
		};
		if (_days == 0) exitwith {};
		_yearID = _year % 100;
		_monthID = [if (_isLeapYear) then {6} else {0},if (_isLeapYear) then {2} else {3},3,6,1,4,6,2,5,0,3,5] select (_month - 1);
		_centuryID = [6,4,2,0] select (((_year - _yearID) / 100) % 4);
		_dayID = 1;
		_weekDay = floor (_dayID + _monthID + _yearID + _yearID / 4 + _centuryID) % 7;
		_dayNames = [
			'str_sunday',
			'str_monday',
			'str_tuesday',
			'str_wednesday',
			'str_thursday',
			'str_friday',
			'str_saturday'
		];
		
		_cursel = lbcursel _ctrlDay;
		lbclear _ctrlDay;
		_dPicture = -100;
		for '_d' from 1 to _days do {
			_weekDayID = round ((_weekDay + _d - 1) % 7);
			_lbadd = _ctrlDay lbadd str _d;
			_ctrlDay lbsetvalue [_lbadd,_d];
			_ctrlDay lbsettextright [_lbadd,localize (_dayNames select _weekDayID)];
			_pictureRight = '#(argb,8,8,3)color(0,0,0,0)';
			if !(_weekDayID in [0,6]) then {_ctrlDay lbsetcolorright [_lbadd,[1,1,1,0.25]];};
			if (([_year,_month,_d] distance [2013,9,12]) == 0) then {_RC = [_lbadd,[1,0.75,0,1]]; _ctrlDay lbsetcolor _RC; _ctrlDay lbsetcolorright _RC; _ctrlDay lbsetpicturerightcolor _RC; _ctrlDay lbsettooltip [_lbadd,localize 'STR_A3_cfgmods_a32_rc']; _pictureRight = gettext (configfile >> 'Cfg3DEN' >> 'Favorites' >> 'Mode' >> 'texture');};
			_moonPhase = moonphase [_year,_month,_d,0,0];
			if ((_d - _dPicture) > 5 && _moonPhase > 0.964) then {_pictureRight = '\a3\3DEN\Data\Attributes\Date\moon_full_ca.paa'; _dPicture = _d;};
			if ((_d - _dPicture) > 5 && _moonPhase < 0.036) then {_pictureRight = '\a3\3DEN\Data\Attributes\Date\moon_new_ca.paa'; _dPicture = _d;};
			_ctrlDay lbsetpictureright [_lbadd,_pictureRight];
		};
		_ctrlDay lbsetcursel (_cursel min (lbsize _ctrlDay - 1));		
	};
	case "changedDay":
	{
		_display = _params select 0;
		
		_ctrlYear = _display displayCtrl IDC_RSCATTRIBUTEYEAR_VALUE;
		_ctrlMonth = _display displayCtrl IDC_RSCATTRIBUTEMONTH_VALUE;
		_ctrlDay = _display displayCtrl IDC_RSCATTRIBUTEDAY_VALUE;
		_date = [_ctrlYear lbvalue lbcursel _ctrlYear,_ctrlMonth lbvalue lbcursel _ctrlMonth,_ctrlDay lbvalue lbcursel _ctrlDay,12,0]; 
		_sunriseSunsetTime = _date call bis_fnc_sunriseSunsetTime; 
		_sunriseTime = _sunriseSunsetTime select 0; 
		_sunsetTime = _sunriseSunsetTime select 1;
		
		_ctrlPreviewGroup = _display displayCtrl IDC_RSCATTRIBUTEPREVIEWGROUP_VALUE;
		_ctrlPreviewNight1 = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWNIGHT1_VALUE;
		_ctrlPreviewNight2 = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWNIGHT2_VALUE;
		_ctrlPreviewDay = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWDAY_VALUE;
		_ctrlPreviewSunrise = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWSUNRISE_VALUE;
		_ctrlPreviewSunset = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWSUNSET_VALUE;
		_ctrlPreviewSun = _ctrlPreviewGroup controlsGroupCtrl IDC_RSCATTRIBUTEPREVIEWSUN_VALUE;
		_ctrlPreviewSunrisePos = ctrlposition _ctrlPreviewSunrise; 
		_ctrlPreviewSunsetPos = ctrlposition _ctrlPreviewSunset; 
		_ctrlPreviewNight1Pos = ctrlposition _ctrlPreviewNight1; 
		_ctrlPreviewNight2Pos = ctrlposition _ctrlPreviewNight2; 
		_ctrlPreviewDayPos = ctrlposition _ctrlPreviewDay; 
		_w = ctrlposition _ctrlPreviewGroup select 2; 
		_ww = (ctrlposition _ctrlPreviewSunrise select 2) * 0.5; 
		if (_sunriseTime >= 0 && _sunsetTime >= 0) then { 
			_ctrlPreviewSunrisePos set [0,(_sunriseTime / 24) * _w - _ww]; 
			_ctrlPreviewSunsetPos set [0,(_sunsetTime / 24) * _w - _ww]; 
			_ctrlPreviewNight1Pos set [2,_ctrlPreviewSunrisePos select 0]; 
			_ctrlPreviewNight2Pos set [0,(_ctrlPreviewSunsetPos select 0) + (_ctrlPreviewSunsetPos select 2)]; 
			_ctrlPreviewNight2Pos set [2,_w - (_ctrlPreviewNight2Pos select 0)]; 
			_ctrlPreviewDayPos set [0,(_ctrlPreviewSunrisePos select 0) + (_ctrlPreviewSunrisePos select 2)]; 
			_ctrlPreviewDayPos set [2,(_ctrlPreviewSunsetPos select 0) - (_ctrlPreviewSunrisePos select 0) - (_ctrlPreviewSunrisePos select 2)]; 
			_ctrlPreviewSun ctrlshow true; 
		} else { 
			_ctrlPreviewSunrisePos set [0,-1]; 
			_ctrlPreviewSunsetPos set [0,-1]; 
			_ctrlPreviewNight2Pos set [2,0]; 
			if (_sunriseTime < 0) then { 
				_ctrlPreviewNight1Pos set [2,_w]; 
				_ctrlPreviewDayPos set [2,0]; 
				_ctrlPreviewSun ctrlshow false; 
			} else { 
				_ctrlPreviewNight1Pos set [2,0]; 
				_ctrlPreviewDayPos set [0,0]; 
				_ctrlPreviewDayPos set [2,_w]; 
				_ctrlPreviewSun ctrlshow true; 
			}; 
		}; 
		_ctrlPreviewSunrise ctrlsetposition _ctrlPreviewSunrisePos; 
		_ctrlPreviewSunrise ctrlcommit 0; 
		_ctrlPreviewSunset ctrlsetposition _ctrlPreviewSunsetPos; 
		_ctrlPreviewSunset ctrlcommit 0; 
		_ctrlPreviewNight1 ctrlsetposition _ctrlPreviewNight1Pos; 
		_ctrlPreviewNight1 ctrlcommit 0; 
		_ctrlPreviewNight2 ctrlsetposition _ctrlPreviewNight2Pos; 
		_ctrlPreviewNight2 ctrlcommit 0; 
		_ctrlPreviewDay ctrlsetposition _ctrlPreviewDayPos; 
		_ctrlPreviewDay ctrlcommit 0;
	};
	case "changedTimeSlider":
	{
		_display = _params select 0;
		_ctrlSlider = _display displayCtrl IDC_RSCATTRIBUTETIMESLIDER_VALUE;
		_ctrlHour = _display displayCtrl IDC_RSCATTRIBUTEHOUR_VALUE;
		_ctrlMinute = _display displayCtrl IDC_RSCATTRIBUTEMINUTE_VALUE;
		_ctrlSecond = _display displayCtrl IDC_RSCATTRIBUTESECOND_VALUE;
		_value = sliderPosition _ctrlSlider;
		_valueHour = floor (_value / 60);
		_valueMinute = floor (_value % 60);
		_textHour = if (_valueHour < 10) then {'0' + str _valueHour} else {str _valueHour};
		_textMinute = if (_valueMinute < 10) then {'0' + str _valueMinute} else {str _valueMinute};
		_ctrlHour ctrlsettext _textHour;
		_ctrlMinute ctrlsettext _textMinute;
		_ctrlSecond ctrlsettext '00';
	};
	case "changedHHMMSS":
	{
		_ctrl = _params select 0;
		_display = ctrlParent _ctrl;
		_ctrlSlider = _display displayCtrl IDC_RSCATTRIBUTETIMESLIDER_VALUE;
		_ctrlHour = _display displayCtrl IDC_RSCATTRIBUTEHOUR_VALUE;
		_ctrlMinute = _display displayCtrl IDC_RSCATTRIBUTEMINUTE_VALUE;
		_ctrlSecond = _display displayCtrl IDC_RSCATTRIBUTESECOND_VALUE;
		
		_valueHour = round (parsenumber ctrltext _ctrlHour);
		_valueMinute = round (parsenumber ctrltext _ctrlMinute);
		_valueSecond = round (parsenumber ctrltext _ctrlSecond);
		
		switch (_ctrl) do
		{
			case (_ctrlHour):
			{
				if (_valueHour > 23) then {_valueHour = 23};
				_textHour = if (_valueHour < 10) then {'0' + str _valueHour} else {str _valueHour};
				_ctrlHour ctrlsettext _textHour;				
			};
			case (_ctrlMinute):
			{
				if (_valueMinute > 59) then {_valueMinute = 59};
				_textMinute = if (_valueMinute < 10) then {'0' + str _valueMinute} else {str _valueMinute};
				_ctrlMinute ctrlsettext _textMinute;				
			};
			case (_ctrlSecond):
			{
				if (_valueSecond > 59) then {_valueSecond = 59};
				_textSecond = if (_valueSecond < 10) then {'0' + str _valueSecond} else {str _valueSecond};
				_ctrlSecond ctrlsettext _textSecond;				
			};
		};
		
		_value = ((_valueHour * 60) + _valueMinute);
		_ctrlSlider slidersetposition _value;
	};
	case "preview":
	{
		if (isServer) exitWith {["CANNOT PREVIEW AS SERVER HOST!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
		_display = _params select 0;
		
		if (_display getVariable ["preview", false]) exitWith  {_display setVariable ["preview", nil]};
		_display setVariable ["preview", true];
		
		
		[_date, _display] spawn 
		{
			disableSerialization;
			params ["_newDate", "_display"];
			
			_ctrlYear = _display displayctrl IDC_RSCATTRIBUTEYEAR_VALUE;
			_ctrlMonth = _display displayctrl IDC_RSCATTRIBUTEMONTH_VALUE;
			_ctrlDay = _display displayctrl IDC_RSCATTRIBUTEDAY_VALUE;
			_ctrlHour = _display displayCtrl IDC_RSCATTRIBUTEHOUR_VALUE;
			_ctrlMinute = _display displayCtrl IDC_RSCATTRIBUTEMINUTE_VALUE;
			_ctrlSecond = _display displayCtrl IDC_RSCATTRIBUTESECOND_VALUE;
			_ctrlPreview = _display displayctrl IDC_RSCATTRIBUTEPREVIEWBUTTON_VALUE;
			_ctrlPreview ctrlSetBackgroundColor [0.016,0.518,0,0.8];
			_curDate = date;
			
			while {_display getVariable ["preview", false]} do
			{
				_newDate = [_ctrlYear lbvalue lbcursel _ctrlYear, _ctrlMonth lbvalue lbcursel _ctrlMonth, _ctrlDay lbvalue lbcursel _ctrlDay, round (parsenumber ctrltext _ctrlHour), round (parsenumber ctrltext _ctrlMinute)];
				setDate _newDate;
				uiSleep 0.01;
			};
			setDate _curDate;
			_ctrlPreview ctrlSetBackgroundColor [0.518,0.016,0,0.8];
		};
	};
	case "confirmed":
	{
		_display = _params select 0;
		
		_ctrlYear = _display displayctrl IDC_RSCATTRIBUTEYEAR_VALUE;
		_ctrlMonth = _display displayctrl IDC_RSCATTRIBUTEMONTH_VALUE;
		_ctrlDay = _display displayctrl IDC_RSCATTRIBUTEDAY_VALUE;
		_ctrlHour = _display displayCtrl IDC_RSCATTRIBUTEHOUR_VALUE;
		_ctrlMinute = _display displayCtrl IDC_RSCATTRIBUTEMINUTE_VALUE;
		_ctrlSecond = _display displayCtrl IDC_RSCATTRIBUTESECOND_VALUE;
		
		_date = [_ctrlYear lbvalue lbcursel _ctrlYear, _ctrlMonth lbvalue lbcursel _ctrlMonth, _ctrlDay lbvalue lbcursel _ctrlDay, round (parsenumber ctrltext _ctrlHour), round (parsenumber ctrltext _ctrlMinute)];
		
		_display setVariable ["preview", nil];
		
		[[_date], 
		{
			params ["_newDate"];
			_isNotZeus = isNull (findDisplay 312);
			
			1 fadesound 0;
			1 fademusic 0;
			if(_isNotZeus and hasInterface) then {cuttext ["","black out",1.5]};
			uiSleep 2;
			// if(_isNotZeus and hasInterface) then {[0,0] call BIS_fnc_cinemaBorder};
			if(isServer) then 
			{
				setDate _newDate;
				[[_newDate], {setDate (_this select 0)}] remoteExec ["call", -2, "JIP_id_setDate"];
				forceWeatherChange;
			};
			if(not hasInterface) exitWith {};
			
			_newDateNumber = [dateToNumber _newDate + (_newDate select 0), 6] call BIS_fnc_cutDecimals;
			_curDateNumber = [dateToNumber date + (date select 0), 6] call BIS_fnc_cutDecimals;
			
			_isDateSynced = compile ("[dateToNumber date + (date select 0), 6] call BIS_fnc_cutDecimals" + (if (_newDateNumber - _curDateNumber >= 0) then {">= _newDateNumber"} else {"< _curDateNumber"}));
			if(_isNotZeus) then {["\A3\missions_f_epa\video\C_out2_sometime_later.ogv"] call BIS_fnc_playVideo};
			waitUntil {sleep 0.1; call _isDateSynced};
			1 fadesound 1;
			1 fademusic 1;
			if(_isNotZeus) then {cuttext ["","black in",1.5]};
			uiSleep 3;
			
			_year = _newDate select 0;
			_month = _newDate select 1;
			if (_month < 10) then {_month = format["0%1",_month]};
			_day = _newDate select 2;
			if (_day < 10) then {_day = format["0%1",_day]};
			_hour = _newDate select 3;
			if (_hour < 10) then {_hour = format["0%1",_hour]};
			_min = _newDate select 4;
			if (_min < 10) then {_min = format["0%1",_min]};
			_date = format ["%1-%2-%3 ",_year,_month,_day];
			_time = format ["%1:%2",_hour,_min];
			
			_output =
			[
				[_date,"size='1.1' font='PuristaMedium'"],
				[_time,"size='1.1' font='PuristaBold'"],
				["","<br/>"],
				[ toUpper ((position player) call bis_fnc_locationDescription),"size='1.1' font='PuristaBold'"],
				["","<br/>"],
				[worldname,"size='1.1' font='PuristaMedium'"],
				["","<br/>"]
			];
			_handle = [_output,safezoneX - 0.01,safeZoneY + (1 - 0.125) * safeZoneH,true,"<t align='right' size=1,1' >%1</t>"] call BIS_fnc_typeText2;
			// if(_isNotZeus) then {[1] call BIS_fnc_cinemaBorder};
		}] remoteExec ["spawn",0];
	};
	case "onUnload": {};
};