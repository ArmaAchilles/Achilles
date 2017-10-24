#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private _mode = _this select 0;
private _params = _this select 1;
private _unit = _this select 2;

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMUSIC_VALUE;
		_ctrlValue ctrladdeventhandler ["treeselchanged","with uinamespace do {['treeSelChanged',_this,objnull] call RscAttributeMusic};"];
		private _musicClasses = [];
		private _textRandom = format ["<%1>",localize "str_a3_bis_fnc_respawnmenuposition_random"];
		{
			private _tvClass = _ctrlValue tvadd [[],gettext (_x >> "displayName")];
			_musicClasses set [count _musicClasses,tolower configname _x];

			private _tvMusicClass = _ctrlValue tvadd [[_tvClass],_textRandom];
			_ctrlValue tvsetdata [[_tvClass,_tvMusicClass],configname _x];
			_ctrlValue tvsetvalue [[_tvClass,_tvMusicClass],-1];
		} foreach ((configfile >> "cfgMusicClasses") call bis_fnc_returnchildren);

		{
			private _name = gettext (_x >> "name");
			private _tvClass = _musicClasses find (tolower gettext (_x >> "musicClass"));
			if (_name != "" && _tvClass >= 0) then {
				private _duration = getnumber (_x >> "duration");
				private _durationText = [_duration / 60,"HH:MM"] call bis_fnc_timetostring;
				private _tvMusic = _ctrlValue tvadd [[_tvClass],format ["(%2) %1",_name,_durationText]];
				_ctrlValue tvsetdata [[_tvClass,_tvMusic],configname _x];
				_ctrlValue tvsetvalue [[_tvClass,_tvMusic],_duration];
			};
		} foreach (((configfile >> "cfgMusic") call bis_fnc_returnchildren) +  ((missionConfigFile >> "cfgMusic") call bis_fnc_returnchildren));

		for "_i" from 0 to (count _musicClasses - 1) do {
			_ctrlValue tvsortbyvalue [[_i],true];
		};

		_ctrlValue tvsetcursel (uinamespace getvariable ["RscAttributeMusic_selected",[]]);
		_unit setvariable ["RscAttributeMusic",nil];
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTEMUSIC_VALUE;
		private _music = _ctrlValue tvdata tvcursel _ctrlValue;
		//playmusic _music;
		_unit setvariable ["RscAttributeMusic",_music,true];
	};
	case "onUnload": {
		if (isnil {_unit getvariable "RscAttributeMusic"}) then {
			playmusic "";
		};
	};
	case "treeSelChanged": {
		private _ctrlValue = _params select 0;
		private _cursel = _params select 1;
		if (count _cursel == 2) then {
			private _duration = _ctrlValue tvvalue _cursel;
			if (_duration < 0) then {
				private _musicClass = _cursel select 0;
				_ctrlValue tvsetcursel [_musicClass,1 + floor random ((_ctrlValue tvcount [_musicClass]) - 1)];
			} else {
				private _music = _ctrlValue tvdata _cursel;
				playMusic _music;
				RscAttributeMusic_selected = _cursel;
			};
		};
	};
};
