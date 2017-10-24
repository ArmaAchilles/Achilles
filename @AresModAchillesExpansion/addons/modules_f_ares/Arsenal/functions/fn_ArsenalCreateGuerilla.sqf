#include "\achilles\modules_f_ares\module_header.hpp"

// Create the ammo box
private _ammoBox = "Box_Wps_F" createVehicle (getPos _logic);
[[_ammoBox]] call Ares_fnc_AddUnitsToCurator;

// Add arsenal to the box
private _data = 
	[
		["B_AssaultPack_khk","B_FieldPack_oli","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_blk","B_AssaultPack_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_cbr","B_Carryall_oli","B_FieldPack_khk","B_FieldPack_blk","B_FieldPack_cbr","B_Carryall_khk","B_Carryall_cbr","B_Kitbag_rgr","B_TacticalPack_oli","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_rgr","B_AssaultPack_dgtl"],
		["optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight_smg","optic_Yorris","optic_MRD","acc_flashlight","acc_pointer_IR","V_TacVest_blk","V_TacVest_camo","V_TacVestIR_blk","H_Booniehat_khk","H_Booniehat_tan","H_MilCap_gry","H_Bandanna_khk","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_gry","H_Bandanna_camo","H_Bandanna_mcamo","H_Beret_blk","H_Watchcap_blk","H_Watchcap_khk","H_Watchcap_camo","H_Cap_oli","ItemWatch","ItemCompass","ItemRadio","ItemMap","Binocular","NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","FirstAidKit","Medikit","ToolKit","V_Chestrig_khk","V_TacVest_khk","V_TacVest_brn","V_TacVest_oli","V_Chestrig_rgr","H_Booniehat_dgtl","H_MilCap_dgtl","U_C_HunterBody_grn","U_BG_leader","U_BG_Guerilla3_1","U_BG_Guerilla2_3","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla1_1","U_BG_Guerrilla_6_1","V_BandollierB_khk","V_BandollierB_rgr","V_BandollierB_cbr","V_BandollierB_blk","V_Chestrig_blk","V_BandollierB_oli","V_Chestrig_oli","H_Cap_tan","H_Cap_blk","H_Cap_brn_SPECOPS","H_MilCap_blue","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Shemag_olive","H_Shemag_olive_hs","H_Bandanna_sand","H_Watchcap_cbr"],
		["30Rnd_9x21_Mag","16Rnd_9x21_Mag","20Rnd_762x51_Mag","9Rnd_45ACP_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","HandGrenade","MiniGrenade","SmokeShell","SmokeShellYellow","SmokeShellGreen","SmokeShellRed","SmokeShellPurple","SmokeShellOrange","SmokeShellBlue","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","I_IR_Grenade","1Rnd_HE_Grenade_shell","UGL_FlareWhite_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareCIR_F","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_Tracer_Green"],
		["srifle_EBR_F","launch_NLAW_F","hgun_P07_F","hgun_Rook40_F","hgun_ACPC2_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","MineDetector","LMG_Mk200_F","launch_I_Titan_F","launch_I_Titan_short_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F","LMG_Zafir_F","launch_RPG32_F"]
	];

[_ammoBox, _data, true, true] call Ares_fnc_ArsenalSetup;

[objNull, "Created basic arsenal ammo box."] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
