/*
	Author: CreepPork_LV

	Description:
	 Select the vehicle's active sensors and radar emissions.

  Parameters:
    _this select: 0 - OBJECT - Vehicle it was activated on

  Returns:
    Nothing
*/

params["_vehicle"];

private _dialogResult =
[
	format [localize "STR_AMAE_X_SENSORS", getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")],
	[
		[localize "STR_3DEN_Object_Attribute_Radar_displayName", [localize "STR_3DEN_Attributes_Radar_Default_text", localize "STR_3DEN_Attributes_Radar_RadarOn_text", localize "STR_3DEN_Attributes_Radar_RadarOff_text"], (if (isVehicleRadarOn _vehicle) then {1} else {2}), true],
		[localize "STR_3DEN_Object_Attribute_ReportRemoteTargets_displayName", [localize "STR_AMAE_NO", localize "STR_AMAE_YES"], parseNumber (vehicleReportRemoteTargets _vehicle), true],
		[localize "STR_3DEN_Object_Attribute_ReceiveRemoteTargets_displayName", [localize "STR_AMAE_NO", localize "STR_AMAE_YES"], parseNumber (vehicleReceiveRemoteTargets _vehicle), true],
		[localize "STR_3DEN_Object_Attribute_ReportOwnPosition_displayName", [localize "STR_AMAE_NO", localize "STR_AMAE_YES"], parseNumber (vehicleReportOwnPosition _vehicle), true]
	]
] call Ares_fnc_ShowChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

_dialogResult params ["_radar", "_reportTarget", "_receiveTarget", "_reportOwnPos"];
_reportTarget = (_reportTarget == 1);
_receiveTarget = (_receiveTarget == 1);
_reportOwnPos = (_reportOwnPos == 1);
private _curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
{
	if (local _x) then
	{
		_x setVehicleRadar _radar;
		_x setVehicleReportRemoteTargets _reportTarget;
		_x setVehicleReceiveRemoteTargets _receiveTarget;
		_x setVehicleReportOwnPosition _reportOwnPos;
	}
	else
	{
		[_x, _radar] remoteExecCall ["setVehicleRadar", _x];
		[_x, _reportTarget] remoteExecCall ["setVehicleReportRemoteTargets", _x];
		[_x, _receiveTarget] remoteExecCall ["setVehicleReceiveRemoteTargets", _x];
		[_x, _reportOwnPos] remoteExecCall ["setVehicleReportOwnPosition", _x];
	};
} forEach _curatorSelected;
