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
	format [localize "STR_X_SENSORS", getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")],
	[
		[localize "STR_3DEN_Object_Attribute_Radar_displayName", [localize "STR_3DEN_Attributes_Radar_Default_text", localize "STR_3DEN_Attributes_Radar_RadarOn_text", localize "STR_3DEN_Attributes_Radar_RadarOff_text"], 0, true],
		[localize "STR_3DEN_Object_Attribute_ReportRemoteTargets_displayName", [localize "STR_NO", localize "STR_YES"], parseNumber (vehicleReportRemoteTargets _vehicle), true],
		[localize "STR_3DEN_Object_Attribute_ReceiveRemoteTargets_displayName", [localize "STR_NO", localize "STR_YES"], parseNumber (vehicleReceiveRemoteTargets _vehicle), true],
		[localize "STR_3DEN_Object_Attribute_ReportOwnPosition_displayName", [localize "STR_NO", localize "STR_YES"], parseNumber (vehicleReportOwnPosition _vehicle), true]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_vehicle setVehicleRadar (_dialogResult select 0);
_vehicle setVehicleReportRemoteTargets ([_dialogResult select 1] call Achilles_fnc_parseBool);
_vehicle setVehicleReceiveRemoteTargets ([_dialogResult select 2] call Achilles_fnc_parseBool);
_vehicle setVehicleReportOwnPosition ([_dialogResult select 3] call Achilles_fnc_parseBool);