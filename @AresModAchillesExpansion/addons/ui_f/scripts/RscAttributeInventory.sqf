#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#define VALUE_NUMBER	"#(argb,1,1,1)color(0,0,0,0)"

#define IDC_RSCATTRIBUTEINVENTORY_FILTER13		24081
#define IDC_RSCATTRIBUTEINVENTORY_BUTTON_VA		24470

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

_filterIDCs = [
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
			_curator = getassignedcuratorlogic player;
			_weaponAddons = missionnamespace getvariable ["RscAttrbuteInventory_weaponAddons",[]];
			_types = [
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
			_typeMagazine = _types find "Magazine";
			_list = [[],[],[],[],[],[],[],[],[],[],[],[]];
			_magazines = []; //--- Store magazines in an array and mark duplicates, so nthey don't appear in the list of all items
			{
				_addon = tolower _x;
				_addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
				_addonID = _weaponAddons find _addon;
				if (_addonID < 0) then {
					{
						_weapon = tolower _x;
						_weaponType = (_weapon call bis_fnc_itemType);
						_weaponTypeCategory = _weaponType select 0;
						_weaponTypeSpecific = _weaponType select 1;
						_weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						//_weaponTypeID = _types find (_weaponType select 0);
						if (_weaponTypeCategory != "VehicleWeapon" and _weaponTypeID >= 0 and (_weapon == [_weapon] call bis_fnc_baseWeapon)) then {
							_weaponCfg = configfile >> "cfgweapons" >> _weapon;
							_weaponPublic = getnumber (_weaponCfg >> "scope") == 2;
							_addonListType = _addonList select _weaponTypeID;
							if (_weaponPublic) then {
								_displayName = gettext (_weaponCfg >> "displayName");
								_picture = gettext (_weaponCfg >> "picture");
								{
									_item = gettext (_x >> "item");
									_itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
									_displayName = _displayName + " + " + _itemName;
								} foreach ((_weaponCfg >> "linkeditems") call bis_fnc_returnchildren);
								_displayNameShort = _displayName;
								_displayNameShortArray = toarray _displayNameShort;
								if (count _displayNameShortArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
									_displayNameShortArray resize 41;
									_displayNameShort = tostring _displayNameShortArray + "...";
								};
								_type = if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) then {1} else {0};
								_addonListType pushback [_weapon,_displayName,_displayNameShort,_picture,_type,false];
							};
							//--- Add magazines compatible with the weapon
							if (_weaponPublic || _weapon in ["throw","put"]) then {
								//_addonListType = _addonList select _typeMagazine;
								{
									_muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
									{
										_mag = tolower _x;
										if ({(_x select 0) == _mag} count _addonListType == 0) then {
											_magCfg = configfile >> "cfgmagazines" >> _mag;
											if (getnumber (_magCfg >> "scope") == 2) then {
												_displayName = gettext (_magCfg >> "displayName");
												_displayNameArray = toarray _displayName;
												if (count _displayNameArray > 41) then { //--- Cut when the name is too long (41 chars is approximate)
													_displayNameArray resize 41;
													_displayName = tostring _displayNameArray + "...";
												};
												_picture = gettext (_magCfg >> "picture");
												_addonListType pushback [_mag,_displayName,_displayName,_picture,2,_mag in _magazines];
												_magazines pushback _mag;
											};
										};
									} foreach getarray (_muzzle >> "magazines");
								} foreach getarray (_weaponCfg >> "muzzles");
							};
						};
					} foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
					{
						_weapon = tolower _x;
						_weaponType = _weapon call bis_fnc_itemType;
						_weaponTypeSpecific = _weaponType select 1;
						_weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						//_weaponTypeID = _types find (_weaponType select 0);
						if (_weaponTypeID >= 0) then {
							_weaponCfg = configfile >> "cfgvehicles" >> _weapon;
							if (getnumber (_weaponCfg >> "scope") == 2) then {
								_displayName = gettext (_weaponCfg >> "displayName");
								_picture = gettext (_weaponCfg >> "picture");
								_addonListType = _addonList select _weaponTypeID;
								_addonListType pushback [_weapon,_displayName,_displayName,_picture,3,false];
							};
						};
					} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
					
					_weaponTypeID = -1;
					{
						if ("Glasses" in _x) exitwith {_weaponTypeID = _foreachindex;};
					} foreach _types;
					{
						_glassesCfg = _x;
						_glasses = configName _glassesCfg;
						_displayName = gettext (_glassesCfg >> "displayName");
						_picture = gettext (_glassesCfg >> "picture");
						_addonListType = _addonList select _weaponTypeID;
						_addonListType pushback [_glasses,_displayName,_displayName,_picture,1,false];
					} forEach ([configfile >> "CfgGlasses", 0, true] call BIS_fnc_returnChildren);
					_weaponAddons set [count _weaponAddons,_addon];
					_weaponAddons set [count _weaponAddons,_addonList];
				} else {
					_addonList = _weaponAddons select (_addonID + 1);
				};
				{
					_current = _list select _foreachindex;
					_list set [_foreachindex,_current + (_x - _current)];
				} foreach _addonList;
			} foreach (curatoraddons _curator);
			missionnamespace setvariable ["RscAttrbuteInventory_weaponAddons",_weaponAddons];
			_list = _list apply {[_x,[],{_x select 1}] call BIS_fnc_sortBy};
			RscAttributeInventory_list = _list;
		};

		//--- Get current cargo
		_cargo = [
			getitemcargo _entity,
			getweaponcargo _entity,
			getmagazinecargo _entity,
			getbackpackcargo _entity
		];
		_virtualCargo = [
			_entity call bis_fnc_getVirtualItemCargo,
			_entity call bis_fnc_getVirtualWeaponCargo,
			_entity call bis_fnc_getVirtualMagazineCargo,
			_entity call bis_fnc_getVirtualBackpackCargo
		];
		RscAttributeInventory_cargoVirtual = [];
		{
			_xCargo = _cargo select _foreachindex;
			{
				_index = (_xCargo select 0) find _x;
				if (_index < 0) then {
					(_xCargo select 0) pushBack (tolower _x);
					(_xCargo select 1) pushBack 0;
				};
				if (isClass (configfile >> "CfgGlasses" >> _x)) then 
				{
					RscAttributeInventory_cargoVirtual pushBack _x;
				} else
				{
					RscAttributeInventory_cargoVirtual pushBack (tolower _x);
				};
			} foreach _x;
		} foreach _virtualCargo;

		RscAttributeInventory_cargo = [[],[]];
		{
			RscAttributeInventory_cargo set [0,(RscAttributeInventory_cargo select 0) + (_x select 0)];
			RscAttributeInventory_cargo set [1,(RscAttributeInventory_cargo select 1) + (_x select 1)];
		} foreach _cargo;

		_classes = RscAttributeInventory_cargo select 0;
		{_classes set [_foreachindex,tolower _x];} foreach _classes;

		//--- Get limits
		_cfgEntity = configfile >> "cfgvehicles" >> typeof _entity;
		RscAttributeInventory_Capacity = [_cfgEntity,"maximumLoad",1e10] call BIS_fnc_returnConfigEntry;

		//--- Init UI
		_display = _params select 0;

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrladdeventhandler [
				"buttonclick",
				format ["with uinamespace do {['filterChanged',[ctrlparent (_this select 0),%1],objnull] call RscAttributeInventory;};",_foreachindex]
			];
		} foreach _filterIDCs;
		RscAttributeInventory_selected = 0;
		["filterChanged",[_display],objnull] call RscAttributeInventory;

		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlList ctrladdeventhandler ["lbselchanged",{with uinamespace do {["listSelect",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];
		_ctrlList ctrladdeventhandler ["lbdblclick",{with uinamespace do {["toggleWeaponSpecific",[ctrlparent (_this select 0), _this select 0],objnull] call RscAttributeInventory}}];
		_ctrlList ctrladdeventhandler ["keyDown",{with uinamespace do {["keyDown",_this,objnull] call RscAttributeInventory} true}];

		_ctrlButtonVA = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_BUTTON_VA;
		_ctrlButtonVA ctrladdeventhandler ["buttonclick",{with uinamespace do {["virutalArsenal",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];
		
		_ctrlArrowLeft = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWLEFT;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),-1],objnull] call RscAttributeInventory}}];
		_ctrlArrowRight = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_ARROWRIGHT;
		_ctrlArrowRight ctrladdeventhandler ["buttonclick",{with uinamespace do {["listModify",[ctrlparent (_this select 0),+1],objnull] call RscAttributeInventory}}];

		_ctrlButtonCustom = _Display displayctrl IDC_RSCDISPLAYATTRIBUTES_BUTTONCUSTOM;
		_ctrlButtonCustom ctrlsettext localize "str_disp_arcmap_clear";
		_ctrlButtonCustom ctrladdeventhandler ["buttonclick",{with uinamespace do {["clear",[ctrlparent (_this select 0)],objnull] call RscAttributeInventory}}];
	};
	case "filterChanged": {
		_display = _params select 0;
		_ctrlLable = _display displayCtrl IDC_RSCATTRIBUTEINVENTORY_FILTER13;
		_ctrlLable ctrlSetText "";
		//_ctrlFilter = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTER;
		//_cursel = lbcursel _ctrlFilter;
		_cursel = if (count _params > 1) then {_params select 1} else {RscAttributeInventory_selected};
		RscAttributeInventory_selected = _cursel;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlList setVariable ["WeaponSpecific",nil];
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_ctrlFilterBackground = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_FILTERBACKGROUND;
		_list = uinamespace getvariable ["RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		_items = [];

		if (_cursel > 0) then {
			_items = _list select (_cursel - 1);
		} else {
			_ctrlLoad progresssetposition 0;
			{_items = _items + _x;} foreach _list;
		};

		lnbclear _ctrlList;
		{
			_types = _x;
			{
				_class = _x select 0;			// all classes are already in lower case except faceware which must not be lowered for virtual arsenal
				_classLowered = tolower _class;
				_displayName = _x select 1;
				_displayNameShort = _x select 2;
				_picture = _x select 3;
				_type = _x select 4;
				_isDuplicate = _x select 5;

				if (_type in _types && (!_isDuplicate || _cursel > 0)) then {

					_classes = RscAttributeInventory_cargo select 0;
					_values = RscAttributeInventory_cargo select 1;
					_index = _classes find _classLowered;
					_value = if (_index < 0) then {
						_index = count _classes;
						_classes set [_index,_classLowered];
						_values set [_index,0];
						0
					} else {
						_values select _index
					};
					_arsenal = if (_class in RscAttributeInventory_cargoVirtual) then {true} else {false};

					if ((_cursel == 0 and (_value != 0 or _arsenal)) or (_cursel > 0)) then {
						_lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,str _value,""];
						_ctrlList lnbsetdata [[_lnbAdd,0],_class];
						_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
						_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
						_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
						_alpha = if (_value != 0 or _arsenal) then {1} else {0.5};
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
							_coef = switch _type do {
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
		_prevSelRow = _params param [2,0,[0]];
		_ctrlList lnbsetcurselrow _prevSelRow;
		["listSelect",[_display],objnull] call RscAttributeInventory;

		//--- Update UI
		_delay = if (isnil "_curator") then {0.1} else {0};
		{
			_ctrl = _display displayctrl _x;
			_color = [1,1,1,0.5];
			_scale = 0.75;
			if (_foreachindex == _cursel) then {
				_color = [1,1,1,1];
				_scale = 1;
			};
			_ctrl ctrlsettextcolor _color;
			_pos = [_ctrl,_scale,_delay] call bis_fnc_ctrlsetscale;

			if (_foreachindex == _cursel) then {
				_ctrlFilterBackground ctrlsetposition _pos;
				_ctrlFilterBackground ctrlcommit 0;
			};
		} foreach _filterIDCs;
	};
	case "listModify": {
		_display = _params select 0;
		_add = _params select 1;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_cursel = lnbcurselrow _ctrlList;
		_class = _ctrlList lnbdata [_cursel,0];
		_classLowered = tolower _class;
		_value = _ctrlList lnbvalue [_cursel,0]; 
		_type = _ctrlList lnbvalue [_cursel,1];

		_classes = RscAttributeInventory_cargo select 0;
		_values = RscAttributeInventory_cargo select 1;
		_index = _classes find _classLowered;
		if (_index >= 0) then {
			_coef = switch _type do {
				case 0: {[configfile >> "cfgweapons" >> _class >> "WeaponSlotsInfo","mass",0] call BIS_fnc_returnConfigEntry};
				case 1: {[configfile >> "cfgweapons" >> _class >> "ItemInfo","mass",0] call BIS_fnc_returnConfigEntry};
				case 2: {[configfile >> "cfgmagazines" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
				case 3: {[configfile >> "cfgvehicles" >> _class,"mass",0] call BIS_fnc_returnConfigEntry};
				default {0};
			};

			_value = _value + _add;
			//if (_value < 0 || (_value == 0 && _add > 0)) then {_add = -_add;};
			_load = progressposition _ctrlLoad + _add * _coef / RscAttributeInventory_Capacity;
			if ((_load <= 1 and _value > 0) || _value == 0) then {
				if (_value > 0 || (_value == 0 && _add < 0)) then {_ctrlLoad progresssetposition _load};
				_values set [_index,_value];
				_ctrlList lnbsetvalue [[_cursel,0],_value];
				_ctrlList lnbsettext [[_cursel,2],if (_value < 0) then {""} else {str _value}];
				_arsenal = if (_class in RscAttributeInventory_cargoVirtual) then {true} else {false};
				_alpha = if (_value != 0 or _arsenal) then {1} else {0.5};
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
		_display = _params select 0;
		_ctrlList = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LIST;
		
		_cursel = lnbcurselrow _ctrlList;
		_arsenal = _ctrlList lnbvalue [_cursel,3];
		_value = _ctrlList lnbvalue [_cursel,0];
		_arsenal = 1 - _arsenal;
		_ctrlList lnbsetvalue [[_cursel,3], _arsenal];
		_alpha = if (_arsenal == 1 or _value > 0) then {1} else {0.5};
		_ctrlList lnbsetcolor [[_cursel,1],[1,1,1,_alpha]];
		_ctrlList lnbsetcolor [[_cursel,2],[1,1,1,_alpha]];
		_ctrlList lnbsetcolor [[_cursel,3],[1,1,1,_alpha]];
		_class = _ctrlList lnbdata [_cursel,0];
		_text = if (_arsenal == 1) then 
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
		_ctrlList = _params select 0;
		_key = _params select 1;
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
				_letter = [_key] call Achilles_fnc_dikToLetter;
				if (_letter != "") then
				{
					for "_i" from 0 to ((lnbSize _ctrlList select 0) - 1) do
					{
						_displayName = _ctrlList lnbText [_i,1];
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
		_display = _params select 0;
		_ctrlList = _params select 1;
		
		_classes = RscAttributeInventory_cargo select 0;
		_values = RscAttributeInventory_cargo select 1;
		
		_cursel = _ctrlList getVariable ["WeaponSpecific",nil];
		if (not isNil "_cursel") exitWith 
		{
			["filterChanged",[_display,RscAttributeInventory_selected,_cursel],objnull] call RscAttributeInventory;
		};
		
		_cursel = lnbCurSelRow _ctrlList;
		_weapon = _ctrlList lnbdata [_cursel,0];
		
		if (not isclass (configfile >> "cfgweapons" >> _weapon)) exitWith {};
		if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) exitWith {};
		
		_ctrlList setVariable ["WeaponSpecific",_cursel];
		_ctrlLable = _display displayCtrl IDC_RSCATTRIBUTEINVENTORY_FILTER13;
		_ctrlLable ctrlSetText (localize "STR_WEAPON_SPECIFIC");
		
		_reducedClasses = [_weapon];
		_index = _classes find _weapon;
		_reducedValues = [_values select _index];
		_weaponCfg = configfile >> "cfgweapons" >> _weapon;
		_magazines = [];

		{
			_muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
			{
				_mag = tolower _x;
				if (getnumber (configfile >> "cfgmagazines" >> _mag >> "scope") == 2) then {
					_index = _classes find _mag;
					if (_index != -1) then
					{
						_reducedClasses pushBack _mag;
						_reducedValues pushBack (_values select _index);
					};
				};
			} foreach getarray (_muzzle >> "magazines");
		} foreach getarray (_weaponCfg >> "muzzles");
		
		_list = uinamespace getvariable ["RscAttributeInventory_list",[[],[],[],[],[],[],[],[],[],[],[],[]]];
		_items = [];
		{_items = _items + _x;} foreach _list;
		
		lnbclear _ctrlList;
		{
			_types = _x;
			{
				_class = _x select 0;
				_displayName = _x select 1;
				_displayNameShort = _x select 2;
				_picture = _x select 3;
				_type = _x select 4;
				_isDuplicate = _x select 5;

				if (_type in _types && (!_isDuplicate or (RscAttributeInventory_selected > 0))) then {

					_index = _reducedClasses find _class;
					if (_index == -1) exitWith {}; 
					
					_value = _reducedValues select _index;
					_arsenal = if (_class in RscAttributeInventory_cargoVirtual) then {true} else {false};

					_lnbAdd = _ctrlList lnbaddrow ["",_displayNameShort,str _value,""];
					_ctrlList lnbsetdata [[_lnbAdd,0],_class];
					_ctrlList lnbsetvalue [[_lnbAdd,0],_value];
					_ctrlList lnbsetvalue [[_lnbAdd,1],_type];
					_ctrlList lnbsetpicture [[_lnbAdd,0],_picture];
					_alpha = if (_value != 0 or _arsenal) then {1} else {0.5};
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
		_values = RscAttributeInventory_cargo select 1;
		{
			_values set [_foreachindex,0];
		} foreach _values;
		RscAttributeInventory_cargoVirtual = [];
		["filterChanged",_params,objnull] call RscAttributeInventory;

		_display = _params select 0;
		_ctrlLoad = _display displayctrl IDC_RSCATTRIBUTEINVENTORY_LOAD;
		_ctrlLoad progresssetposition 0;
	};

	case "confirmed": {
		_display = _params select 0;

		_classes = RscAttributeInventory_cargo select 0;
		_values = RscAttributeInventory_cargo select 1;
		
		_items = [];
		_weapons = [];
		_magazines = [];
		_backpacks = [];
		
		{
			if (_x != 0) then {
				_class = _classes select _foreachindex;
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
		
		_virtual_items = [];
		_virtual_weapons = [];
		_virtual_magazines = [];
		_virtual_backpacks = [];

		{
			switch true do {
				case (getnumber (configfile >> "cfgweapons" >> _x >> "type") in [4096,131072] or isClass (configfile >> "CfgGlasses" >> _x)): {
					_virtual_items pushBack _x;
				};
				case (isclass (configfile >> "cfgweapons" >> _x)): {
					_virtual_weapons pushBack _x;
				};
				case (isclass (configfile >> "cfgmagazines" >> _x)): {
					_virtual_magazines pushBack _x;
				};
				case (isclass (configfile >> "cfgvehicles" >> _x)): {
					_virtual_backpacks pushBack _x;
				};
			};
		} forEach RscAttributeInventory_cargoVirtual;
		
		_curatorSelected = ["cargo"] call Achilles_fnc_getCuratorSelected;
		{
			_box = _x;
			
			clearitemcargoglobal _box;
			clearweaponcargoglobal _box;
			clearmagazinecargoglobal _box;
			clearbackpackcargoglobal _box;

			_box call bis_fnc_removeVirtualItemCargo;
			_box call bis_fnc_removeVirtualWeaponCargo;
			_box call bis_fnc_removeVirtualMagazineCargo;
			_box call bis_fnc_removeVirtualBackpackCargo;
			
			{_box additemcargoglobal _x} forEach _items;
			{_box addweaponcargoglobal _x} forEach _weapons;
			{_box addmagazinecargoglobal _x} forEach _magazines;
			{_box addbackpackcargoglobal _x} forEach _backpacks;
			[_box, _virtual_items,true] call bis_fnc_addVirtualItemCargo;
			[_box, _virtual_weapons,true] call bis_fnc_addVirtualWeaponCargo;
			[_box, _virtual_magazines,true] call bis_fnc_addVirtualMagazineCargo;
			[_box, _virtual_backpacks,true] call bis_fnc_addVirtualBackpackCargo;
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