#define IDC_RSCATTRIBUTENAME_VALUE	118379

private _mode = _this select 0;
private _params = _this select 1;
private _entity = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTENAME_VALUE;
		_ctrlValue ctrlsettext name _entity;
	};
	case "confirmed": 
	{
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTENAME_VALUE;
		private _text = ctrltext _ctrlValue;
		if (_text != name _entity) then
		{
			private _curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
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
