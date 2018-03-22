#include "\achilles\modules_f_ares\module_header.hpp"

private _ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (!isnull _ammoBox) then
{
	private _virtualBackpacks = [_ammoBox] call BIS_fnc_getVirtualBackpackCargo;
	private _virtualItems = [_ammoBox] call BIS_fnc_getVirtualItemCargo;
	private _virtualMagazines = [_ammoBox] call BIS_fnc_getVirtualMagazineCargo;
	private _virtualWeapons = [_ammoBox] call BIS_fnc_getVirtualWeaponCargo;

	private _backpacks = getBackpackCargo _ammoBox;
	private _items = getItemCargo _ammoBox;
	private _magazines = getMagazineCargo _ammoBox;
	private _weapons = getWeaponCargo _ammoBox;
	private _stringData = format [
"[%1,
%2,
%3,
%4,
%5,
%6,
%7,
%8]",
	str(_virtualBackpacks), str(_virtualItems), str(_virtualMagazines), str(_virtualWeapons), str(_backpacks), str(_items), str(_magazines), str(_weapons)];

	// Don't do this anytime since it doesn't work on dedicated servers.
	//copyToClipboard _stringData;

	uiNamespace setVariable ['Ares_CopyPaste_Dialog_Text', _stringData];
	private _dialog = createDialog "Ares_CopyPaste_Dialog";

	[objNull, "Copied items from arsenal to clipboard."] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\achilles\modules_f_ares\module_footer.hpp"
