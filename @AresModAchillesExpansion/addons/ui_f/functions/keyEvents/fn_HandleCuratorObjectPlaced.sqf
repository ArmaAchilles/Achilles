private ["_curator","_placedObject"];
_curator = _this select 0;
_placedObject = _this select 1;
if (local _placedObject) then
{
	Ares_CuratorObjectPlaced_UnitUnderCursor = curatorMouseOver;
	Ares_CuratorObjectPlaces_LastPlacedObjectPosition = position _placedObject;
	[format ["Placed Object %1 with %2 under mouse at position %3", _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition)]] call Ares_fnc_LogMessage;
}
else
{
	[format ["NON-LOCAL Placed Object %1 with %2 under mouse at position %3", _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition)]] call Ares_fnc_LogMessage;
};
