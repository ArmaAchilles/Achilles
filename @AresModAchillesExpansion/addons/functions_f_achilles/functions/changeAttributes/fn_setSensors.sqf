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

_vehicle setVehicleRadar (_dialogResult select 0);
_vehicle setVehicleReportRemoteTargets ((_dialogResult select 1) == 1);
_vehicle setVehicleReceiveRemoteTargets ((_dialogResult select 2) == 1);
_vehicle setVehicleReportOwnPosition ((_dialogResult select 3) == 1);
