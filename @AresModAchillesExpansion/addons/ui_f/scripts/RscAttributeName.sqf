#define IDC_RSCATTRIBUTENAME_VALUE	118379

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTENAME_VALUE;
		_ctrlValue ctrlsettext name _entity;
	};
	case "confirmed": 
	{
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTENAME_VALUE;
		_text = ctrltext _ctrlValue;
		if (_text != name _entity) then
		{
			_curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
			{
				if (alive _x) then 
				{
					[_x, _text] remoteExecCall ["setName", 0, _x];
				};
			} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};