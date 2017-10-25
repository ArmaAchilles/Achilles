#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_entity"];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTEGROUPID_VALUE;
		_ctrlValue ctrlsettext groupid _entity;
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTEGROUPID_VALUE;
		private _text = ctrltext _ctrlValue;
		if (_text != groupID _entity) then {
			_entity setGroupIdGlobal [_text];
		};
	};
	case "onUnload": {
	};
};
