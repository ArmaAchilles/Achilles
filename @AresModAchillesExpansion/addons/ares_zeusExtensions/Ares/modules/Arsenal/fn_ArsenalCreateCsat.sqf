#include "\ares_zeusExtensions\Ares\module_header.hpp"

// Create the ammo box
_ammoBox = "Box_East_Wps_F" createVehicle (getPos _logic);
[[_ammoBox]] call Ares_fnc_AddUnitsToCurator;

// Add arsenal to the box
_data = 
	[
		["B_AssaultPack_khk","B_FieldPack_oli","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_ocamo","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_cbr","B_Carryall_oli","B_FieldPack_khk","B_FieldPack_blk","B_FieldPack_cbr","B_Carryall_khk","B_Carryall_cbr","B_TacticalPack_oli","B_TacticalPack_blk","B_TacticalPack_rgr","B_AssaultPack_dgtl","B_AssaultPack_mcamo","B_FieldPack_ocamo","B_FieldPack_oucamo","B_Carryall_ocamo","B_Carryall_oucamo","B_TacticalPack_ocamo"],
		["optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight_smg","optic_Yorris","optic_MRD","acc_flashlight","acc_pointer_IR","V_TacVest_blk","H_Beret_blk","H_Watchcap_blk","H_Booniehat_khk_hs","H_Bandanna_khk_hs","H_Cap_oli_hs","ItemWatch","ItemCompass","ItemRadio","ItemMap","Binocular","NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","FirstAidKit","Medikit","ToolKit","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_SpecopsUniform_ocamo","U_O_OfficerUniform_ocamo","V_Chestrig_khk","V_TacVest_khk","V_TacVest_brn","V_HarnessO_brn","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","H_HelmetCrew_O","H_Cap_brn_SPECOPS","H_PilotHelmetFighter_O","H_PilotHelmetHeli_O","H_CrewHelmetHeli_O","H_HelmetO_ocamo","H_HelmetO_oucamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk","H_MilCap_ocamo","H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"],
		["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_9x21_Mag","16Rnd_9x21_Mag","9Rnd_45ACP_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","HandGrenade","MiniGrenade","SmokeShell","SmokeShellYellow","SmokeShellGreen","SmokeShellRed","SmokeShellPurple","SmokeShellOrange","SmokeShellBlue","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","1Rnd_HE_Grenade_shell","UGL_FlareWhite_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareCIR_F","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","150Rnd_762x51_Box","150Rnd_762x51_Box_Tracer","10Rnd_762x51_Mag","O_IR_Grenade"],
		["hgun_P07_F","hgun_Rook40_F","hgun_ACPC2_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","MineDetector","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","LMG_Zafir_F","srifle_DMR_01_F","launch_RPG32_F","launch_O_Titan_F","launch_O_Titan_short_F"]
	];

[_ammoBox, _data, true, true] call Ares_fnc_ArsenalSetup;

[objNull, "Created basic arsenal ammo box."] call bis_fnc_showCuratorFeedbackMessage;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
