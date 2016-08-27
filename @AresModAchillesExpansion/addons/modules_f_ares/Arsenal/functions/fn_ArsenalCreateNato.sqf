#include "\achilles\modules_f_ares\module_header.hpp"

// Create the ammo box
_ammoBox = "Box_NATO_Wps_F" createVehicle (getPos _logic);
[[_ammoBox]] call Ares_fnc_AddUnitsToCurator;

// Add arsenal to the box
_data = 
	[
		["B_AssaultPack_khk","B_FieldPack_oli","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_ocamo","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_cbr","B_Carryall_oli","B_FieldPack_khk","B_FieldPack_blk","B_FieldPack_cbr","B_Carryall_khk","B_Carryall_cbr","B_Kitbag_rgr","B_TacticalPack_oli","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_rgr"],
		["optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight_smg","optic_Yorris","optic_MRD","acc_flashlight","acc_pointer_IR","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_worn","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_HeliPilotCoveralls","U_B_PilotCoveralls","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","V_PlateCarrier1_rgr","V_PlateCarrier1_blk","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_rgr","V_TacVest_blk","V_TacVest_camo","V_TacVestIR_blk","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","H_HelmetB","H_Booniehat_khk","H_Booniehat_mcamo","H_Booniehat_tan","H_HelmetB_paint","H_HelmetB_light","H_HelmetB_plain_mcamo","H_HelmetB_plain_blk","H_HelmetCrew_B","H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK","H_Cap_grn","H_PilotHelmetFighter_B","H_PilotHelmetHeli_B","H_CrewHelmetHeli_B","H_MilCap_mcamo","H_MilCap_gry","H_Bandanna_khk","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_mcamo","H_Beret_blk","H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","H_HelmetB_camo","H_Cap_oli","H_HelmetB_light_sand","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_snakeskin","H_HelmetB_light_grass","H_HelmetB_sand","H_HelmetB_black","H_HelmetB_desert","H_HelmetB_snakeskin","H_HelmetB_grass","H_Booniehat_khk_hs","H_Bandanna_khk_hs","H_Cap_oli_hs","H_Beret_02","H_Beret_Colonel","H_Booniehat_oli","H_Bandanna_sand","H_Watchcap_cbr","H_Cap_usblack","ItemWatch","ItemCompass","ItemRadio","ItemMap","Binocular","NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","FirstAidKit","Medikit","ToolKit"],
		["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","3Rnd_HE_Grenade_shell","3Rnd_UGL_FlareWhite_F","3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","3Rnd_UGL_FlareCIR_F","3Rnd_Smoke_Grenade_shell","3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","30Rnd_9x21_Mag","16Rnd_9x21_Mag","100Rnd_65x39_caseless_mag_Tracer","100Rnd_65x39_caseless_mag","20Rnd_762x51_Mag","9Rnd_45ACP_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","HandGrenade","MiniGrenade","SmokeShell","SmokeShellYellow","SmokeShellGreen","SmokeShellRed","SmokeShellPurple","SmokeShellOrange","SmokeShellBlue","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag"],
		["arifle_MXC_F","arifle_MX_F","arifle_MXM_Black_F","arifle_MX_GL_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MX_SW_F","srifle_EBR_F","launch_NLAW_F","launch_B_Titan_F","launch_B_Titan_short_F","hgun_P07_F","hgun_Rook40_F","hgun_ACPC2_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","MineDetector"]
	];

[_ammoBox, _data, true, true] call Ares_fnc_ArsenalSetup;

[objNull, "Created basic arsenal ammo box."] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
