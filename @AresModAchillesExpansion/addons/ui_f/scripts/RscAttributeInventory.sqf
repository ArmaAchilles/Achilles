#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#define VALUE_NUMBER	"#(argb,1,1,1)color(0,0,0,0)"

#define IDC_RSCATTRIBUTEINVENTORY_FILTER13		24081
#define IDC_RSCATTRIBUTEINVENTORY_BUTTON_VA		24470

params["_mode", "_params", "_entity"];

private _filterIDCs = [
	IDC_RSCATTRIBUTEINVENTORY_FILTER0,
	IDC_RSCATTRIBUTEINVENTORY_FILTER1,
	IDC_RSCATTRIBUTEINVENTORY_FILTER2,
	IDC_RSCATTRIBUTEINVENTORY_FILTER3,
	IDC_RSCATTRIBUTEINVENTORY_FILTER4,
	IDC_RSCATTRIBUTEINVENTORY_FILTER5,
	IDC_RSCATTRIBUTEINVENTORY_FILTER6,
	IDC_RSCATTRIBUTEINVENTORY_FILTER7,
	IDC_RSCATTRIBUTEINVENTORY_FILTER8,
	IDC_RSCATTRIBUTEINVENTORY_FILTER9,
	IDC_RSCATTRIBUTEINVENTORY_FILTER10,
	IDC_RSCATTRIBUTEINVENTORY_FILTER11,
	IDC_RSCATTRIBUTEINVENTORY_FILTER12
];

switch _mode do {
	case "onLoad": {
		if (isNil "RscAttributeInventory_list") then
		{
			//--- Get weapons and magazines from curator addons
			private _curator = getassignedcuratorlogic player;
			private _weaponAddons = missionnamespace getvariable ["RscAttrbuteInventory_weaponAddons",[]];
			private _types = [
				["AssaultRifle","Shotgun","Rifle","SubmachineGun"],
				["MachineGun"],
				["SniperRifle"],
				["Launcher","MissileLauncher","RocketLauncher"],
				["Handgun"],
				["UnknownWeapon"],
				["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"],
				["Uniform"],
				["Vest"],
				["Backpack"],
				["Headgear","Glasses"],
				["Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal"]
			];
			private _typeMagazine = _types find "Magazine";
			private _list = [[],[],[],[],[],[],[],[],[],[],[],[]];
			private _magazines = []; //--- Store magazines in an array and mark duplicates, so nthey don't appear in the list of all items
			{
				private _addon = tolower _x;
				private _addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
				private _addonID = _weaponAddons find _addon;
				if (_addonID < 0) then {
					{
						private _weapon = tolower _x;
						private _weaponType = (_weapon call bis_fnc_itemType);
						private _weaponTypeCategory = _weaponType select 0;
						private _weaponTypeSpecific = _weaponType select 1;
						private _weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						//_weaponTypeID = _types find (_weaponType select 0);
						if (_weaponTypeCategory != "VehicleWeapon" and _weaponTypeID >= 0 and (_weapon == [_weapon] call bis_fnc_baseWeapon)) then {
							private _weaponCfg = configfile >> "cfgweapons" >> _weapon;
							private _weaponPublic = getnumber (_weaponCfg >> "scope") == 2;
							private _addonListType = _addonList select _weaponTypeID;
							if (_weaponPublic) then {
								private _displayName = gettext (_weaponCfg >> "displayName");
								private _picture = gettext (_weaponCfg >> "picture");
								{
									private _item = gettext (_x >> "item");
									private _itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
									_displayName = _displayName + " + " + _itemName;
								} foreach ((_weaponCfg >> "linkeditems") call Achilles_fnc_returnChildren);
								private _displayNameShort = _displayName;
								private _displayNameShortArray = toarray _displayNameShort;
								if (count _displayNameShortArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
									_displayNameShortArray resize 41;
									_displayNameShort = tostring _displayNameShortArray + "...";
								};
								private _type = [0, 1] select (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096, 131072]);
								_addonListType pushback [_displayName, _displayNameShort, _weapon, _picture, _type, false];
							};
							//--- Add magazines compatible with the weapon
							if (_weaponPublic || _weapon in ["throw","put"]) then {
								//_addonListType = _addonList select _typeMagazine;
								{
									private _muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};

									_magazinesList = getArray (_muzzle >> "magazines");
									// Add magazines from magazine wells
									{
										{
											_magazinesList append (getArray _x);
										} foreach  configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
									} foreach getArray (_muzzle >> "magazineWell");

									{
										private _mag = tolower _x;
										if (_addonListType findIf {(_x select 2) isEqualTo _mag} == -1) then
										{
											private _magCfg = configfile >> "cfgmagazines" >> _mag;
											if (getnumber (_magCfg >> "scope") == 2) then {
												private _displayName = gettext (_magCfg >> "displayName");
												private _displayNameArray = toarray _displayName;
												if (count _displayNameArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
													_displayNameArray resize 41;
													_displayName = tostring _displayNameArray + "...";
												};
												private _picture = gettext (_magCfg >> "picture");
												_addonListType pushback [_displayName, _displayName, _mag, _picture, 2, _mag in _magazines];
												_magazines pushback _mag;
											};
										};
									} foreach _magazinesList;
								} foreach getarray (_weaponCfg >> "muzzles");
							};
						};
					} foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
					{
						private _weapon = tolower _x;
						private _weaponType = _weapon call bis_fnc_itemType;
						private _weaponTypeSpecific = _weaponType select 1;
						private _weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						//_weaponTypeID = _types find (_weaponType select 0);
						if (_weaponTypeID >= 0) then {
							private _weaponCfg = configfile >> "cfgvehicles" >> _weapon;
							if (getnumber (_weaponCfg >> "scope") == 2) then {
								private _displayName = gettext (_weaponCfg >> "displayName");
								private _picture = gettext (_weaponCfg >> "picture");
								private _addonListType = _addonList select _weaponTypeID;
								_addonListType pushback [_displayName, _displayName, _weapon, _picture, 3, false];
							};
						};
					} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");

					private _weaponTypeID = -1;
					{
						if ("Glasses" in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;
					{
						private _glassesCfg = _x;
						private _glasses = configName _glassesCfg;
						private _displayName = gettext (_glassesCfg >> "displayName");
						private _picture = gettext (_glassesCfg >> "picture");
						private _addonListType = _addonList select _weaponTypeID;
						_addonListType pushback [_displayName, _displayName, _glasses, _picture, 1, false];
					} forEach configProperties [configfile >> "CfgGlasses", "isClass _x"];
					_weaponAddons pushBack _addon;
					_weaponAddons pushBack _addonList;
				}
				else
				{
					_addonList = _weaponAddons select (_addonID + 1);
				};
				{
					private _current = _list select _foreachindex;
					_list set [_foreachindex,_current + (_x - _current)];
				} foreach _addonList;
			} foreach curatoraddons _curator;
			missionnamespace setvariable ["RscAttrbuteInventory_weaponAddons", _weaponAddons];
			_list = _list apply {[_x, [], {_x select 0}] call BIS_fnc_sortBy};
			RscAttributeInventory_list = _list;
		};

		//--- Get current cargo
		private _cargo = [
			getitemcargo _entity,
			getweaponcargo _entity,
			getmagazinecargo _entity,
			getbackpackcargo _entity
		];
		private _virtualCargo = [_entity] call Achilles_fnc_getVirtualArsenal;
		
		RscAttributeInventory_cargoVirtual = [];
		{
			private _xCargo = _cargo select _foreachindex;
			{
				private _index = (_xCargo select 0) find _x;
				if (_index < 0) then {
					(_xCargo select 0) pushBack (tolower _x);
					(_xCargo select 1) pushBack 0;
				};
				RscAttributeInventory_cargoVirtual pushBack (if (isClass (configfile >> "CfgGlasses" >> _x)) then {_x} else {toLower _x});
			} foreach _x;
		} foreach _virtualCargo;

		RscAttributeInventory_cargo = [[],[]];
		{
			RscAttributeInventory_cargo set [0,(RscAttributeInventory_cargo select 0) + (_x select 0)];
			RscAttributeInventory_cargo set [1,(RscAttributeInventory_cargo select 1) + (_x select 1)];
		} foreach _cargo;

		RscAttributeInventory_cargo = [(RscAttributeInventory_cargo select 0) apply {toLower _x}, RscAttributeInventory_cargo select 1];

		//--- Get limits
		private _cfgEntity = configfile >> "cfgvehicles" >> typeof _entity;
		RscAttributeInventory_Capacity = [_cfgEntity,"maximumLoad",1e10] call BIS_fnc_returnConfigEntry;

		//--- Init UI
		private _display = _params select 0;

		{
			private _ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler [
				"buttonclick",
				format ["with uinamespace do {['filterChanged',[ctrlparent (_this select 0),%1],objnull] call RscAttributeInventory;};",_foreachindex]
			];
		} foreach _filterIDCs;
		RscAttributeInventory_selected = 0;
		["filterChanged",[_display],objnull] call RscAttributeInventory;

		private _ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlList ctrladdeventhandler ["lbselchanged",{with uinamespace do {["listSelect",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];
		_ctrlList ctrladdeventhandler ["lbdblclick",{with uinamespace do {["toggleWeaponSpecific",[ctrlparent (_this select 0), _this select 0],objnull] call RscAttributeInventory}}];
		_ctrlList ctrladdeventhandler ["keyDown",{with uinamespace do {["keyDown",_this,objnull] call RscAttributeInventory}; true}];

		private _ctrlButtonVA = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_BUTTON_VA;
		_ctrlButtonVA ctrladdeventhandler ["buttonclick",{with uinamespace do {["virutalArsenal",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];

		private _ctrlArrowLeft = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWLEFT;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),-1],objnull] call RscAttributeInventory}}];
		private _ctrlArrowRight = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWRIGHT;
		_ctrlArrowRight ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),+1],objnull] call RscAttributeInventory}}];

		private _ctrlButtonCustom = _Display displayctrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_ctrlButtonCustom ctrlsettext localize "STR_disp_arcmap_clear";
		_ctrlButtonCustom ctrladdeventhandler ["buttonclick",{with uinamespace do {["clear",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];
	};
	case "filterChanged": {
		private _display = _params select 0;
		private _ctrlLable = _display displayCtrl IDC_RSCATTRIBUTEINVENTORY_FILTER13;
		_ctrlLable ctrlSetText "";
		//_ctrlFilter = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTER;
		//_cursel = lbcursel _ctrlFilter;
		private _cursel = if (count _params > 1) then {_params select 1} else {RscAttributeInventory_selected};
		RscAttributeInventory_selected = _cursel;
		private _ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlList setVariable ["WeaponSpecific",nil];
		private _ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		private _ctrlFilterBackground = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTERBACKGROUND;
		private _list = uinamespace getvariable ["RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		private _items = [];

		if (_cursel > 0) then {
			_items = _list select (_cursel - 1);
		} else {
			_ctrlLoad progresssetposition 0;
			{_items = _items + _x;} foreach _list;
		};

		lnbclear _ctrlList;
		{
			private _types = _x;
			{
				_x params ["_displayName", "_displayNameShort", "_class", "_picture", "_type", "_isDuplicate"];
				// all classes are already in lower case except faceware which must not be lowered for virtual arsenal
				private _classLowered = tolower _class;

				if (_type in _types && (!_isDuplicate || _cursel > 0)) then {

					private _classes = RscAttributeInventory_cargo select 0;
					private _values = RscAttributeInventory_cargo select 1;
					private _index = _classes find _classLowered;
					private _value = if (_index < 0) then {
						_index = count _classes;
						_classes set [_index,_classLowered];
						_values set [_index,0];
						0
					} else {
						_values select _index
					};
					private _arsenal = _class in RscAttributeInventory_cargoVirtual;

					if ((_cursel == 0 and (_value != 0 or _arsenal)) or (_cursel > 0)) then {
						private _lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,str _value,""];
						_ctrlList lnbsetdata [[_lnbAdd,0],_class];
						_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
						_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
						_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
						private _alpha = [0.5, 1] select (_value != 0 or _arsenal);
						_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
						_ctrlList lnbsetcolor [[_lnbAdd,2],[1,1,1,_alpha]];
						_ctrlList lnbsetcolor [[_lnbAdd,3],[1,1,1,_alpha]];
						if (_arsenal) then
						{
							_ctrlList lnbsettext [[_lnbAdd,3],"VA"];
							_ctrlList lnbsetvalue [[_lnbAdd,3],1];
						};
						_ctrlList lbsettooltip [_lnbAdd,_displayName];

						if (_cursel == 0 && _value != 0) then {
							private _coef = switch _type do {
								case 0: {[configfile >> "cfgweapons" >> _class >> "WeaponSlotsInfo","mass",0] call BIS_fnc_returnConfigEntry};
								case 1: {[configfile >> "cfgweapons" >> _class >> "ItemInfo","mass",0] call BIS_fnc_returnConfigEntry};
								case 2: {[configfile >> "cfgmagazines" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
								case 3: {[configfile >> "cfgvehicles" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
								default {0};
							};
							_ctrlLoad progresssetposition (progressposition _ctrlLoad + (_value max 0) * _coef / RscAttributeInventory_Capacity);
						};
					};
				};
			} foreach _items;
		} foreach [[0,1,3],[2]];
		private _prevSelRow = _params param [2,0,[0]];
		_ctrlList lnbsetcurselrow _prevSelRow;
		["listSelect",[_display],objnull] call RscAttributeInventory;

		//--- Update UI
		private _delay = [0, 0.1] select (isnil "_curator");
		{
			private _ctrl = _display displayctrl _x;
			private _color = [1,1,1,0.5];
			private _scale = 0.75;
			if (_foreachindex == _cursel) then {
				_color = [1,1,1,1];
				_scale = 1;
			};
			_ctrl ctrlsettextcolor _color;
			private _pos = [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;

			if (_foreachindex == _cursel) then {
				_ctrlFilterBackground ctrlsetposition _pos;
				_ctrlFilterBackground ctrlcommit 0;
			};
		} foreach _filterIDCs;
	};
	case "listModify": {
		_params params ["_display", "_add"];
		private _ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		private _ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		private _cursel = lnbcurselrow _ctrlList;
		private _class = _ctrlList lnbdata [_cursel,0];
		private _classLowered = tolower _class;
		private _value = _ctrlList lnbvalue [_cursel,0];
		private _type = _ctrlList lnbvalue [_cursel,1];

		private _classes = RscAttributeInventory_cargo select 0;
		private _values = RscAttributeInventory_cargo select 1;
		private _index = _classes find _classLowered;
		if (_index >= 0) then {
			private _coef = switch _type do {
				case 0: {[configfile >> "cfgweapons" >> _class >> "WeaponSlotsInfo","mass",0] call BIS_fnc_returnConfigEntry};
				case 1: {[configfile >> "cfgweapons" >> _class >> "ItemInfo","mass",0] call BIS_fnc_returnConfigEntry};
				case 2: {[configfile >> "cfgmagazines" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
				case 3: {[configfile >> "cfgvehicles" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
				default {0};
			};

			_value = _value + _add;
			//if (_value < 0 || (_value == 0 && _add > 0)) then {_add = -_add;};
			private _load = progressposition _ctrlLoad + _add * _coef / RscAttributeInventory_Capacity;
			if ((_load <= 1 and _value > 0) || _value == 0) then {
				if (_value > 0 || (_value == 0 && _add < 0)) then {_ctrlLoad progresssetposition _load};
				_values set [_index,_value];
				_ctrlList lnbsetvalue [[_cursel,0],_value];
				_ctrlList lnbsettext [[_cursel,2], [str _value, ""] select (_value < 0)];
				private _arsenal = _class in RscAttributeInventory_cargoVirtual;
				private _alpha = [0.5, 1] select (_value != 0 or _arsenal);
				_ctrlList lnbsetcolor [[_cursel,1],[1,1,1,_alpha]];
				_ctrlList lnbsetcolor [[_cursel,2],[1,1,1,_alpha]];
				_ctrlList lnbsetcolor [[_cursel,3],[1,1,1,_alpha]];
				["listSelect",[_display],objnull] call RscAttributeInventory;
			};
		};
	};
	case "listSelect": {
		private ["_display","_ctrlList","_cursel","_value","_ctrlArrowLeft"];
		_display = _params select 0;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_cursel = lnbcurselrow _ctrlList;
		_value = _ctrlList lnbvalue [_cursel,0];

		_ctrlArrowLeft = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWLEFT;
		_ctrlArrowLeft ctrlenable (_value > 0);
	};

	case "virutalArsenal": {
		private _display = _params select 0;
		private _ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;

		private _cursel = lnbcurselrow _ctrlList;
		private _arsenal = _ctrlList lnbvalue [_cursel,3];
		private _value = _ctrlList lnbvalue [_cursel,0];
		_arsenal = 1 - _arsenal;
		_ctrlList lnbsetvalue [[_cursel,3], _arsenal];
		private _alpha = [0.5, 1] select (_arsenal == 1 or _value > 0);
		_ctrlList lnbsetcolor [[_cursel,1],[1,1,1,_alpha]];
		_ctrlList lnbsetcolor [[_cursel,2],[1,1,1,_alpha]];
		_ctrlList lnbsetcolor [[_cursel,3],[1,1,1,_alpha]];
		private _class = _ctrlList lnbdata [_cursel,0];
		private _text = if (_arsenal == 1) then
		{
			RscAttributeInventory_cargoVirtual pushBack _class;
			"VA"
		} else
		{
			RscAttributeInventory_cargoVirtual = RscAttributeInventory_cargoVirtual - [_class];
			""
		};
		_ctrlList lnbsettext [[_cursel,3], _text];
	};

	case "keyDown":	{
		_params params ["_ctrlList", "_key"];
		switch true do
		{
			case (_key == DIK_MULTIPLY):
			{
				["virutalArsenal",[ctrlparent _ctrlList],objnull] call RscAttributeInventory;
			};
			case (_key == DIK_DIVIDE):
			{
				["toggleWeaponSpecific",[ctrlparent _ctrlList, _ctrlList],objnull] call RscAttributeInventory;
			};
			case (_key == DIK_ADD):
			{
				["listModify",[ctrlparent _ctrlList,+1],objnull] call RscAttributeInventory;
			};
			case (_key == DIK_SUBTRACT):
			{
				["listModify",[ctrlparent _ctrlList,-1],objnull] call RscAttributeInventory;
			};
			default
			{
				private _letter = [_key] call Achilles_fnc_dikToLetter;
				if (_letter != "") then
				{
					for "_i" from 0 to ((lnbSize _ctrlList select 0) - 1) do
					{
						private _displayName = _ctrlList lnbText [_i,1];
						if (toupper (_displayName select [0,1]) == _letter) exitWith
						{
							_ctrlList lnbSetCurSelRow _i;
						};
					};
				};
			};
		};
	};
	case "toggleWeaponSpecific": {
		_params params ["_display", "_ctrlList"];

		private _classes = RscAttributeInventory_cargo select 0;
		private _values = RscAttributeInventory_cargo select 1;

		private _cursel = _ctrlList getVariable ["WeaponSpecific",nil];
		if (!isNil "_cursel") exitWith
		{
			["filterChanged",[_display,RscAttributeInventory_selected,_cursel],objnull] call RscAttributeInventory;
		};

		_cursel = lnbCurSelRow _ctrlList;
		private _weapon = _ctrlList lnbdata [_cursel,0];

		if (!isclass (configfile >> "cfgweapons" >> _weapon)) exitWith {};
		if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) exitWith {};

		_ctrlList setVariable ["WeaponSpecific",_cursel];
		private _ctrlLable = _display displayCtrl IDC_RSCATTRIBUTEINVENTORY_FILTER13;
		_ctrlLable ctrlSetText (localize "STR_AMAE_WEAPON_SPECIFIC");

		private _reducedClasses = [_weapon];
		private _index = _classes find _weapon;
		private _reducedValues = [_values select _index];
		private _weaponCfg = configfile >> "cfgweapons" >> _weapon;
		private _magazines = [];

		{
			private _muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};

			_magazinesList = getArray (_muzzle >> "magazines");
			// Add magazines from magazine wells
			{
				{
					_magazinesList append (getArray _x);
				} foreach  configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
			} foreach getArray (_muzzle >> "magazineWell");

			{
				private _mag = tolower _x;
				if (getnumber (configfile >> "cfgmagazines" >> _mag >> "scope") == 2) then {
					_index = _classes find _mag;
					if (_index != -1) then
					{
						_reducedClasses pushBack _mag;
						_reducedValues pushBack (_values select _index);
					};
				};
			} foreach _magazinesList;
		} foreach getarray (_weaponCfg >> "muzzles");

		private _list = uinamespace getvariable ["RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		private _items = [];
		{_items append _x} foreach _list;

		lnbclear _ctrlList;
		{
			private _types = _x;
			{
				_x params ["_displayName", "_displayNameShort", "_class", "_picture", "_type", "_isDuplicate"];

				if (_type in _types && (!_isDuplicate or (RscAttributeInventory_selected > 0))) then {

					_index = _reducedClasses find _class;
					if (_index == -1) exitWith {};

					private _value = _reducedValues select _index;
					private _arsenal = _class in RscAttributeInventory_cargoVirtual;

					private _lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,str _value,""];
					_ctrlList lnbsetdata [[_lnbAdd,0],_class];
					_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
					_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
					_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
					private _alpha = [0.5, 1] select (_value != 0 or _arsenal);
					_ctrlList lnbsetcolor [[_lnbAdd,1],[1,1,1,_alpha]];
					_ctrlList lnbsetcolor [[_lnbAdd,2],[1,1,1,_alpha]];
					_ctrlList lnbsetcolor [[_lnbAdd,3],[1,1,1,_alpha]];
					if (_arsenal) then
					{
						_ctrlList lnbsettext [[_lnbAdd,3],"VA"];
						_ctrlList lnbsetvalue [[_lnbAdd,3],1];
					};
					_ctrlList lbsettooltip [_lnbAdd,_displayName];
				};
			} foreach _items;
		} foreach [[0,1,3],[2]];
		_ctrlList lnbsetcurselrow 0;
		["listSelect",[_display],objnull] call RscAttributeInventory;
	};


	case "clear": {
		private _values = RscAttributeInventory_cargo select 1;
		{
			_values set [_foreachindex,0];
		} foreach _values;
		RscAttributeInventory_cargoVirtual = [];
		["filterChanged",_params,objnull] call RscAttributeInventory;

		private _display = _params select 0;
		private _ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_ctrlLoad progresssetposition 0;
	};

	case "confirmed": {
		private _display = _params select 0;

		private _classes = RscAttributeInventory_cargo select 0;
		private _values = RscAttributeInventory_cargo select 1;

		private _items = [];
		private _weapons = [];
		private _magazines = [];
		private _backpacks = [];

		{
			if (_x != 0) then {
				private _class = _classes select _foreachindex;
				switch true do {
					case (getnumber (configfile >> "cfgweapons" >> _class >> "type") in [4096,131072] or isClass (configfile >> "CfgGlasses" >> _class)): {
						_items pushBack [_class,abs _x];
					};
					case (isclass (configfile >> "cfgweapons" >> _class)): {
						_weapons pushBack [_class,abs _x];
					};
					case (isclass (configfile >> "cfgmagazines" >> _class)): {
						_magazines pushBack [_class,abs _x];
					};
					case (isclass (configfile >> "cfgvehicles" >> _class)): {
						_backpacks pushBack [_class,abs _x];
					};
				};
			};
		} foreach _values;

		private _curatorSelected = ["cargo"] call Achilles_fnc_getCuratorSelected;
		// Add the target object to the list of selected objects if it is not yet there.
		_curatorSelected pushBackUnique (missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull]);
		{
			private _box = _x;

			clearitemcargoglobal _box;
			clearweaponcargoglobal _box;
			clearmagazinecargoglobal _box;
			clearbackpackcargoglobal _box;
			
			{_box additemcargoglobal _x} forEach _items;
			{_box addweaponcargoglobal _x} forEach _weapons;
			{_box addmagazinecargoglobal _x} forEach _magazines;
			{_box addbackpackcargoglobal _x} forEach _backpacks;
			
			with missionNamespace do {[_box, uiNamespace getVariable ["RscAttributeInventory_cargoVirtual", []], true] call Achilles_fnc_updateVirtualArsenal};
		} forEach _curatorSelected;
	};
	case "onUnload": {
		//RscAttributeInventory_list = nil;
		RscAttributeInventory_cargo = nil;
		RscAttributeInventory_cargoVirtual = nil;
		RscAttributeInventory_selected = nil;
		RscAttributeInventory_Capacity = nil;
	};
};
