
#define CHAIRS_CLASS_NAMES ["Land_CampingChair_V2_F", "Land_CampingChair_V1_F", "Land_Chair_EP1", "Land_RattanChair_01_F", "Land_Bench_F", "Land_ChairWood_F", "Land_OfficeChair_01_F"]

#include "\ares_zeusExtensions\Ares\module_header.hpp"



if (isNil "Achilles_var_compositions") then
{
	Achilles_var_compositions =
	[
		["Camping",
		[
			["Dining Table Large 1",
			[
				["Land_CampingTable_F", [0,0,0], 26.5588, false],
				["Land_MobilePhone_smart_F", [-0.868164,-0.40625,0.7939], 212.257, false],
				["Land_CampingChair_V2_F", [-0.248047,0.636719,0.0038681], 19.7121, false],
				["Land_Can_Rusty_F", [-0.374023,0.211914,0.805359], 17.5588, false],
				["Land_Canteen_F", [-0.65332,-0.422852,0.802429], 214.257, false],
				["Land_CampingChair_V2_F", [-0.994141,-1.72949,0.000686646], 178.681, false],
				["Land_CampingTable_F", [-0.362305,-0.725586,0.000267029], 206.257, false],
				["Land_Can_V1_F", [0.0927734,-0.889648,0.822166], 204.257, false],
				["Land_BottlePlastic_V2_F", [0.485352,-0.160156,0.820984], 16.5588, false],
				["Land_CampingChair_V2_F", [0.832031,0.379883,3.8147e-005], 44.9264, false],
				["Land_CampingChair_V2_F", [-0.0917969,-1.45605,0.002388], 213.011, false]
			]],
			["Field Kitchen",
			[
				["Land_CampingTable_F", [0,0,0], 125.918, false],
				["Land_GasCooker_F", [-0.0644531,-0.177734,0.813007], 359.929, false],
				["Land_FireExtinguisher_F", [-0.641602,-0.958984,0], 359.929, false],
				["Land_GasCooker_F", [0.323242,0.414063,0.813007], 359.929, false],
				["Land_FoodContainer_01_F", [0.200195,0.439453,0], 57.9244, false],
				["Land_BakedBeans_F", [-0.245117,-0.798828,0.813007], 359.052, false],
				["Land_RiceBox_F", [-0.423828,-0.621094,0.813007], 130.855, false],
				["Land_CanOpener_F", [-0.199219,-0.662109,0.813007], 0.0137846, false]
			]],
			["Field Sink",
			[		
				["Land_WaterBarrel_F", [0,0,0], 355.441, false],
				["Land_Sink_F", [1.43457,-0.836914,0], 30.3627, false],
				["Land_Pallet_F", [1.75,-0.0205078,0], 29.5636, false],
				["Land_Pallet_F", [0.961914,-1.5625,0], 29.5636, false],
				["Land_BarrelEmpty_F", [-0.0478516,-0.99707,-7.62939e-006], 355.437, false],
				["Land_Sink_F", [-1.40137,0.866211,0], 210.258, false],
				["Land_Pallet_F", [-1.03027,1.61719,0], 29.5636, false],
				["Land_Pallet_F", [-1.80566,0.163086,0], 29.5636, false]
			]],
			["Sleeping Bags",
			[		
				["Land_Sleeping_bag_blue_F", [0,0,0], 45.4872, false],
				["Land_Sleeping_bag_brown_folded_F", [1.75732,-1.70313,-0.00148106], 0.00283047, false],
				["Land_Ground_sheet_khaki_F", [0.968018,-1.55859,-0.00144958], 48.929, false],
				["Land_Ground_sheet_khaki_F", [0.634033,-1.19141,-0.00144958], 48.929, false],
				["Land_Pillow_camouflage_F", [1.88867,-1.04688,-0.00426006], 0.00515475, false],
				["Land_Camping_Light_off_F", [1.15088,0.113281,-0.00177479], 359.977, false],
				["Land_ClutterCutter_large_F", [-0.428467,0.251953,-0.00144768], 0, false],
				["Land_Pillow_grey_F", [-0.307861,0.728516,-0.0040369], 0.0121512, false],
				["Land_Ground_sheet_khaki_F", [-1.13696,0.914063,-0.00145054], 30.8373, false],
				["Land_Sleeping_bag_brown_folded_F", [0.115967,1.00781,-0.001194], 9.81901, false],
				["Land_Ground_sheet_khaki_F", [-1.56348,1.17578,-0.00145054], 30.8373, false],
				["Land_Sleeping_bag_brown_folded_F", [-0.486084,1.41797,-0.00152779], 284.837, false]
			]]
		]],
		["Large Compositions",
		[
			["Offices",
			[		
				["Land_MilOffices_V1_F", [0,0,0], 134.98, false],
				["Land_File1_F", [-0.714844,-13.1621,1.29101], 359.988, false],
				["Land_MapBoard_F", [4.20605,-10.5605,0.475807], 180.149, false],
				["Land_TableDesk_F", [7.68262,13.0898,0.478001], 316.575, false],
				["Land_OfficeChair_01_F", [7.09766,13.6563,0.478046], 316.819, false],
				["Land_File2_F", [8.05371,13.3691,1.29823], 316.837, false],
				["Land_PCSet_01_mouse_F", [7.0293,12.8418,1.30072], 139.129, false],
				["Land_PCSet_01_screen_F", [7.4248,12.7734,1.30049], 175.411, false],
				["Land_PCSet_01_keyboard_F", [7.39941,13.1328,1.30018], 147.551, false],
				["Land_Tableware_01_cup_F", [8.06934,13.6953,1.29847], 188.376, false],
				["OfficeTable_01_new_F", [-0.481445,7.20117,0.478004], 317.104, false],
				["Land_OfficeCabinet_01_F", [-1.30762,6.375,0.478083], 315.565, false],
				["Land_OfficeChair_01_F", [-0.183594,6.6543,0.478031], 102.484, false],
				["Land_FilePhotos_F", [-0.696289,6.90039,1.32281], 317.073, false],
				["Land_Laptop_F", [-0.375,7.3125,1.32279], 317.073, false],
				["Land_TableDesk_F", [-4.28223,0.716797,0.477995], 44.3111, false],
				["Land_Laptop_unfolded_scripted_F", [-4.22949,0.785156,1.30004], 44.4901, false],
				["Land_OfficeChair_01_F", [-3.73926,1.32422,0.477751], 44.5551, false],
				["Land_File2_F", [-4.69336,1.17188,1.3007], 72.766, false],
				["Land_Tableware_01_cup_F", [-4.37012,1.11719,1.30066], 276.083, false],
				["Land_BottlePlastic_V1_F", [-4.59082,0.808594,1.30079], 42.9361, false],
				["OfficeTable_01_new_F", [0.708008,2.17773,0.478004], 135.731, false],
				["Land_OfficeChair_01_F", [0.333008,2.91797,0.478035], 313.54, false],
				["Land_PensAndPencils_F", [0.219727,2.00586,1.30337], 138.569, false],
				["Land_PCSet_01_mouse_F", [0.550781,2.14453,1.3228], 118.965, false],
				["Land_PCSet_01_screen_F", [0.925781,2.23828,1.32281], 124.152, false],
				["Land_PCSet_01_keyboard_F", [0.78125,2.39844,1.30072], 127.387, false],
				["Land_Notepad_F", [0.396484,1.99414,1.30151], 63.5705, false],
				["Land_CampingTable_F", [7.25195,-7.98047,0.477995], 315.838, false],
				["Land_CampingChair_V1_F", [6.73047,-7.0918,0.48119], 69.3195, false],
				["Land_TinContainer_F", [6.25879,-8.76172,1.28854], 314.527, false],
				["Land_File1_F", [6.06348,-9.01953,1.28812], 314.527, false],
				["Land_CampingTable_F", [5.83887,-9.33594,0.474659], 315.527, false],
				["Land_Laptop_F", [5.46875,-9.70898,1.28712], 317.527, false],
				["Land_Laptop_unfolded_F", [7.50098,-7.7207,1.29098], 309.837, false],
				["Land_CampingChair_V1_F", [5.77051,-8.57813,0.481134], 284.222, false],
				["Land_CampingChair_V1_F", [5.15625,-9.32031,0.481146], 337.011, false],
				["Land_CampingTable_F", [3.52051,-5.9082,0.478004], 132.822, false],
				["Land_CampingChair_V1_F", [3.92871,-6.85938,0.454632], 132.439, false],
				["Land_CampingChair_V1_F", [4.38574,-6.00781,0.454634], 128.217, false],
				["Land_CampingChair_V1_F", [2.99316,-7.43555,0.454636], 128.217, false],
				["Land_CampingChair_V1_F", [2.52734,-8.11133,0.454636], 104.64, false],
				["Land_BottlePlastic_V2_F", [3.19238,-6.68945,1.29099], 126.822, false],
				["Land_FilePhotos_F", [3.2002,-6.375,1.29101], 128.822, false],
				["Land_CampingTable_F", [2.17969,-7.33398,0.478006], 132.822, false],
				["Land_Rack_F", [13.3154,-2.09766,0.478096], 220.877, false],
				["Land_Printer_01_F", [14.1172,-1.09961,1.46768], 128.779, false],
				["Land_Suitcase_F", [12.7588,-2.66406,0.478037], 221.802, false],
				["Land_ShelvesWooden_F", [14.1338,-1.16992,0.48568], 223.087, false],
				["Land_File_research_F", [13.9912,-1.30273,1.1074], 301.194, false],
				["Land_File1_F", [14.1025,-0.957031,1.10737], 222.266, false],
				["OfficeTable_01_new_F", [10.8701,-4.76758,0.478004], 134.6, false],
				["Land_OfficeCabinet_01_F", [11.6592,-3.90625,0.478083], 133.061, false],
				["Land_OfficeChair_01_F", [10.5488,-4.23438,0.478031], 279.98, false],
				["Land_FilePhotos_F", [11.0713,-4.45703,1.32281], 134.569, false],
				["Land_Laptop_F", [10.7686,-4.88477,1.32279], 134.569, false],
				["OfficeTable_01_new_F", [8.50879,-0.789063,0.478004], 314.982, false],
				["Land_OfficeChair_01_F", [8.89355,-1.52344,0.478035], 132.791, false],
				["Land_PensAndPencils_F", [8.99512,-0.611328,1.30337], 317.82, false],
				["Land_PCSet_01_mouse_F", [8.66602,-0.753906,1.3228], 298.216, false],
				["Land_PCSet_01_screen_F", [8.29199,-0.851563,1.32281], 303.403, false],
				["Land_PCSet_01_keyboard_F", [8.43848,-1.01172,1.30072], 306.638, false],
				["Land_Notepad_F", [8.81836,-0.601563,1.30151], 242.822, false],
				["Land_TableDesk_F", [11.2158,1.26953,0.482405], 225.627, false],
				["Land_OfficeChair_01_F", [10.6602,0.673828,0.482035], 225.871, false],
				["Land_File2_F", [10.9316,1.63477,1.3057], 225.889, false],
				["Land_PCSet_01_mouse_F", [11.4775,0.619141,1.30075], 48.1805, false],
				["Land_PCSet_01_screen_F", [11.5391,1.01367,1.30219], 84.462, false],
				["Land_PCSet_01_keyboard_F", [11.1807,0.984375,1.30334], 56.6024, false],
				["Land_Tableware_01_cup_F", [10.6055,1.64258,1.30746], 97.4269, false],
				["Land_CampingTable_F", [-0.607422,-14.2598,0.478006], 134.765, false],
				["Land_CampingChair_V2_F", [0.401367,-14.4395,0.478003], 121.022, false],
				["Land_CampingChair_V2_F", [-0.338867,-15.1758,0.478016], 126.54, false],
				["Land_Map_F", [-1.47461,-15.3301,1.29102], 0.0985563, false],
				["Land_Camera_01_F", [-1.83887,-15.4551,1.29101], 0.0985563, false],
				["Land_CampingTable_F", [-1.98242,-15.6406,0.478006], 134.765, false],
				["Land_PensAndPencils_F", [-2.2041,-16.0313,1.29101], 304.951, false],
				["Land_Map_altis_F", [-2.31543,-15.959,1.29101], 43.1089, false],
				["Land_CampingChair_V2_F", [-1.00586,-15.9102,0.478001], 126.54, false],
				["Land_CampingChair_V2_F", [-1.6582,-16.5762,0.477985], 134.605, false],
				["Land_Can_V3_F", [-0.239258,-14.0234,1.29103], 113.114, false],
				["Land_CampingChair_V2_F", [-2.57813,-11.293,0.477985], 320.288, false],
				["Land_CampingChair_V2_F", [-3.38379,-12.1172,0.477983], 336.868, false],
				["Land_CampingTable_F", [-2.49219,-12.2539,0.477999], 314.667, false],
				["Land_Tablet_02_F", [-2.93555,-12.6211,1.29099], 0.0353787, false],
				["Land_CampingChair_V2_F", [-4.10156,-12.8184,0.477982], 317.332, false],
				["Land_File1_F", [-3.58398,-13.4121,1.29099], 285.407, false],
				["Land_CampingChair_V2_F", [-4.76465,-13.4316,0.478025], 317.332, false],
				["Land_CampingTable_F", [-3.86426,-13.6504,0.47801], 314.667, false],
				["Land_PenBlack_F", [-4.19824,-13.9082,1.28581], 111.63, false],
				["Land_Notepad_F", [-4.30859,-14.0195,1.29099], 57.1743, false],
				["Land_Can_Rusty_F", [-2.66992,-12.3809,1.29102], 358.9, false],
				["Land_CampingTable_F", [-1.1543,-12.8457,0.478003], 46.7127, false],
				["Land_CampingChair_V2_F", [-0.941406,-11.8438,0.477991], 32.9697, false],
				["Land_CampingChair_V2_F", [-0.229492,-12.6094,0.478024], 38.4877, false],
				["Land_Can_V3_F", [-1.37793,-12.4707,1.29102], 25.0617, false],
				["Land_MapBoard_F", [-3.87109,-18.3516,0.475809], 180.106, false],
				["Land_Tablet_01_F", [-1.47949,-12.2676,1.29101], 217.131, false]
			]],
			["Food Storage",
			[		
				["Land_i_Stone_Shed_V1_F", [0,0,0], 304.151, false],
				["Land_Sacks_goods_F", [-0.0898438,-4.08008,-0.000774384], 132.394, false],
				["Land_Basket_F", [1.72949,-2.44336,0], 359.913, false],
				["Fridge_01_closed_F", [-1.94141,-2.51758,0.259247], 209.07, false],
				["Land_Canteen_F", [-3.04004,-2.16992,0.690737], 72.1223, false],
				["Land_Rack_F", [-3.07422,-2.0957,0.259998], 303.213, false],
				["Land_Sacks_heap_F", [0.510742,-2.7793,0], 218.169, false],
				["Land_TinContainer_F", [-3.27734,-1.89648,1.04799], 168.381, false],
				["Land_cargo_addon01_V1_F", [0.869141,-3.08008,-0.00154495], 303.426, false],
				["Land_BottlePlastic_V1_F", [-4.08398,-1.35156,0.696472], 359.918, false],
				["Land_BottlePlastic_V1_F", [-4.15918,-1.17383,0.693632], 180.364, false],
				["Land_Rack_F", [-4.48633,-1.125,0.259998], 303.179, false],
				["Land_Can_V3_F", [-4.3252,-1.15234,1.04398], 118.943, false],
				["Land_Can_V1_F", [-4.60449,-1.08398,1.04395], 140.376, false],
				["Land_Can_V2_F", [-4.64453,-0.984375,1.04418], 134.168, false],
				["Land_Sack_F", [0.944336,-1.68164,0], 190.92, false],
				["Land_BakedBeans_F", [-1.68359,0.0410156,0.845337], 359.918, false],
				["Land_BakedBeans_F", [-1.79199,0.171875,0.859659], 98.9619, false],
				["Land_Metal_wooden_rack_F", [-1.79883,0.203125,0.259998], 305.938, false],
				["Land_BakedBeans_F", [-1.59961,0.240234,0.847084], 242.263, false],
				["Land_CerealsBox_F", [-1.15234,0.851563,1.34623], 300.724, false],
				["Land_RiceBox_F", [-0.952148,1.00781,0.842901], 230.824, false],
				["Land_Metal_wooden_rack_F", [-1.09961,1.125,0.259998], 305.938, false],
				["Land_RiceBox_F", [-0.827148,1.14844,0.849003], 359.913, false],
				["Land_PowderedMilk_F", [-0.881836,1.42383,0.3577], 359.918, false],
				["Land_Icebox_F", [-2.94238,2.25195,0.259998], 308.05, false],
				["Land_Notepad_F", [-1.44531,3.34766,1.12459], 209.826, false],
				["Land_ChairWood_F", [-0.775391,3.22852,0], 107.215, false],
				["Land_PenRed_F", [-1.40723,3.48633,1.10795], 271.565, false],
				["Land_WoodenTable_small_F", [-1.57422,3.62109,0.259998], 33.4342, false]
			]],	
			["Vet Clinic",
			[		
				["Land_i_House_Big_01_V2_F", [0,0,0], 31.8091, false],
				["Land_CampingChair_V2_F", [-2.86426,-5.54883,0.493786], 212.902, false],
				["Land_CampingChair_V1_F", [-2.45996,-5.93164,3.91384], 290.266, false],
				["Land_CampingChair_V2_F", [-2.20313,-5.96094,0.49445], 212.927, false],
				["Land_Bucket_clean_F", [-4.7627,-3.45313,3.91431], 0.252847, false],
				["Land_CampingChair_V1_F", [-5.99414,-3.62695,3.91056], 221.335, false],
				["Land_CampingChair_V1_F", [-1.77051,-5.16797,3.91772], 314.136, false],
				["Land_TableDesk_F", [-5.68945,-2.70508,3.91384], 211.862, false],
				["Land_Bandage_F", [-4.45313,-2.45898,3.86048], 187.236, false],
				["Land_TableDesk_F", [-1.08398,-6.42383,3.9162], 121.459, false],
				["Land_Notepad_F", [-4.7334,-2.23438,3.89617], 157.264, false],
				["Land_CampingTable_F", [-0.981445,-4.57031,0.5], 212.304, false],
				["Land_CampingChair_V2_F", [-0.786133,-6.91016,0.495701], 212.919, false],
				["Land_Bucket_clean_F", [-0.426758,-5.26172,3.92], 0.031465, false],
				["Land_FilePhotos_F", [-1.06738,-4.29102,1.33169], 94.5044, false],
				["Land_CampingChair_V1_F", [-5.19141,-1.68945,3.91787], 355.42, false],
				["Land_PencilBlue_F", [-0.148438,-4.51563,4.45585], 7.46367, false],
				["Land_CampingChair_V1_F", [-0.0898438,-6.83789,3.91775], 116.911, false],
				["Land_File1_F", [0.150391,-4.68945,4.45585], 88.6647, false],
				["Land_Camping_Light_F", [-7.08008,-1.86719,0.32276], 0.524316, true],
				["Land_CampingTable_small_F", [0.274414,-4.5293,3.64284], 212.07, false],
				["Land_BottlePlastic_V2_F", [-0.283203,-2.70313,3.92], 221.478, false],
				["Land_BakedBeans_F", [-0.761719,-2.10156,3.92], 309.53, false],
				["Land_BakedBeans_F", [-0.630859,-2.20117,3.92], 137.929, false],
				["Land_CampingChair_V2_F", [0.960938,-5.94727,0.5], 119.453, false],
				["Land_BottlePlastic_V2_F", [-0.0810547,-2.80273,3.92], 114.196, false],
				["Land_File1_F", [-0.558594,-4.83984,1.31301], 243.283, false],
				["Land_CanOpener_F", [-0.700195,-1.90625,3.92], 182.482, false],
				["Land_CampingChair_V2_F", [1.35547,-5.26758,0.5], 126.045, false],
				["Land_PainKillers_F", [0.27832,-1.54688,3.92], 175.527, false],
				["Land_Sleeping_bag_brown_F", [1.36426,-3.08984,3.88052], 125, false],
				["Land_Matches_F", [0.128906,-1.14648,3.89339], 281.257, false],
				["Land_GasCooker_F", [0.685547,-0.863281,3.92], 247.953, false],
				["Land_FMradio_F", [2.52344,-3.67383,3.92], 66.939, false],
				["Land_Antibiotic_F", [1.08594,-0.5625,3.92], 33.4977, false],
				["Land_Bucket_F", [2.68652,-8.98047,0.311838], 0.0286168, false],
				["Land_Sleeping_bag_blue_F", [1.62793,-1.13281,3.92], 35, false],
				["MapBoard_altis_F", [3.58203,-6.71484,0.315647], 316.307, false],
				["Land_FireExtinguisher_F", [2.33105,-1.4043,0.5], 168.244, false],
				["Land_CampingChair_V2_F", [-5.35059,2.53516,0.316442], 90.5272, false],
				["Land_TableDesk_F", [3.77148,-9.80664,0.209225], 30.5166, false],
				["Land_ChairWood_F", [4.21289,-9.04492,0.270399], 7.33224, false],
				["Land_i_Addon_04_V1_F", [-8.67676,2.43945,-0.583975], 121.933, false],
				["Land_CampingChair_V2_F", [-9.37988,2.54688,0.314444], 116.621, false],
				["Land_CampingChair_V2_F", [-5.51563,4.43555,0.316442], 206.439, false],
				["Land_BottlePlastic_V2_F", [-10.1689,2.88867,1.12657], 111.663, false],
				["Land_CampingTable_small_F", [-10.1895,3.0293,0.31357], 118.661, false],
				["Land_HandyCam_F", [-10.207,3.07227,1.12657], 125.663, false],
				["Land_Sunshade_F", [-7.87988,4.16016,0.316442], 1.25574, false],
				["Land_ChairWood_F", [6.32617,-5.85352,0], 220.218, false],
				["Land_CampingTable_small_F", [-5.36816,5.04297,0.316442], 210.163, false],
				["Land_TableDesk_F", [6.5459,-5.37109,0.281172], 210.99, false],
				["Land_CampingChair_V2_F", [-7.79492,5.29883,0.316442], 125.661, false],
				["Land_Cages_F", [0.283203,5.01953,0.5], 301.328, false],
				["Land_File1_F", [-0.545898,5.74414,4.73965], 306.244, false],
				["Land_CampingTable_F", [5.02246,1.30469,3.92], 32.1415, false],
				["Land_PenBlack_F", [-0.0429688,6.26172,4.74178], 319.531, false],
				["Land_ChairWood_F", [7.46777,-8.00781,0.278381], 307.826, false],
				["Land_Bucket_clean_F", [7.78613,-6.35156,0.289898], 359.982, false],
				["Land_CampingTable_small_F", [-8.31152,5.88867,0.316442], 136.05, false],
				["Land_CampingChair_V1_F", [0.635742,5.81836,3.92], 120.228, false],
				["Land_Notepad_F", [-0.0742188,6.43555,4.74274], 87.9161, false],
				["Land_TableDesk_F", [-0.255859,6.29297,3.92], 120.935, false],
				["Land_File1_F", [5.97363,2.02344,4.73301], 204.962, false],
				["Land_TableDesk_F", [8.22559,-8.48828,0.277224], 302.704, false],
				["Land_Sun_chair_green_F", [4.15332,3.90039,3.92], 302.088, false],
				["Land_CampingTable_F", [6.16895,2.27539,3.92], 301.939, false],
				["Land_WaterPurificationTablets_F", [2.0752,5.94531,3.87921], 50.3419, false],
				["Land_FilePhotos_F", [0.286133,6.80273,4.74274], 227.135, false],
				["Land_Bench_F", [3.84863,5.26953,0.5], 297.786, false],
				["Land_i_House_Small_02_V3_F", [8.99023,-10.293,-0.140181], 211.539, false],
				["Land_Metal_wooden_rack_F", [9.65527,-8.63477,0.260609], 122.844, false],
				["Land_Bucket_F", [0.136719,7.47656,3.92], 44.0684, false],
				["Land_Tyre_F", [10.4834,-9.0625,0.248898], 0.0035517, false],
				["Land_Metal_wooden_rack_F", [11.0859,-8.26172,0.256382], 211.571, false],
				["Land_GarbageContainer_open_F", [14.79,-8.13867,0], 120.947, false]
			]],
			["Hideout 1",
			[		
				["Land_i_Stone_HouseSmall_V3_F", [0,0,0], 31.0184, false],
				["Land_WoodenTable_large_F", [-0.904297,0.908203,1.33418], 114.466, false],
				["I_supplyCrate_F", [1.19531,3.83984,1.34049], 82.373, false],
				["Box_NATO_Ammo_F", [-2.40625,1.72656,1.48241], 231.272, false],
				["Land_Bucket_F", [-3.48242,1.54688,1.28662], 359.862, false],
				["Land_WoodenTable_small_F", [-1.73047,5.78906,1.33959], 297.518, false],
				["Box_IND_WpsSpecial_F", [-4.59375,2.84766,1.33186], 13.1694, false],
				["Land_HumanSkull_F", [7.93555,-0.408203,1.34026], 88.9982, false],
				["Land_BagFence_Long_F", [7.66113,-2.04688,1.33809], 32.7873, false],
				["Land_BagFence_Long_F", [7.88965,-1.73242,1.33849], 32.343, false],
				["Box_IND_AmmoOrd_F", [8.46191,-0.642578,1.33994], 359.912, false],
				["Land_Pallets_F", [-4.49023,7.73047,1.34181], 208.601, false],
				["Land_Metal_wooden_rack_F", [-6.3584,6.38672,1.3342], 302.903, false],
				["Land_Stone_pillar_F", [6.93066,-5.9082,0.421814], 302.383, false],
				["Land_Stone_pillar_F", [-6.08691,9.95117,-0.00274467], 28.6835, false],
				["Land_CampingTable_small_F", [2.52539,-9.53125,-0.00277138], 274.011, false],
				["Land_MobilePhone_old_F", [2.54004,-9.5293,0.862875], 282.03, false],
				["Land_Can_V3_F", [2.51367,-9.72852,0.810236], 265.03, false],
				["Land_Stone_8m_F", [4.47559,-9.38867,-0.00273705], 124.239, false],
				["Land_FMradio_F", [2.16113,-11.0762,0.810236], 305.271, false],
				["Land_TinContainer_F", [2.08594,-11.2383,0.810236], 304.271, false],
				["Land_CampingChair_V1_F", [0.898438,-11.6064,-0.00276947], 298.283, false],
				["Land_CampingTable_F", [1.84375,-11.6152,-0.00277138], 301.262, false],
				["Land_CampingChair_V1_F", [-5.26953,-10.3203,-0.00276947], 309.958, false],
				["Land_Canteen_F", [1.58594,-12.0498,0.810236], 304.271, false],
				["Campfire_burning_F", [-3.93262,-12.2217,-0.00276947], 359.901, true],
				["Land_Stone_pillar_F", [2.03809,-12.9854,-0.00281525], 302.383, false],
				["Land_CampingChair_V1_F", [-0.947266,-13.0811,-0.00276947], 101.08, false],
				["Land_Stone_8m_F", [-9.8291,12.0488,-0.00275803], 210.54, false],
				["Land_Stone_pillar_F", [-7.66797,-12.0361,-0.00274277], 30.2507, false],
				["Land_Stone_8mD_F", [-10.7197,-9.57227,-0.0027771], 218.654, false],
				["Land_Stone_4m_F", [0.782227,-14.8545,-0.00277138], 122.386, false],
				["Land_CampingChair_V1_F", [-2.12402,-14.6494,-0.00276947], 144.264, false],
				["Land_Stone_8m_F", [-3.96484,-14.3408,-0.00275612], 212.107, false],
				["Land_Stone_pillar_F", [-0.317383,-16.5371,-0.00281525], 302.383, false],
				["Land_FieldToilet_F", [-13.748,12.4707,-0.00276375], 30.8602, false],
				["MetalBarrel_burning_F", [-15.1631,7.73438,-0.00276947], 359.905, true],
				["Land_Stone_pillar_F", [-13.4023,14.1973,-0.00274277], 28.6835, false],
				["Land_Stone_pillar_F", [-18.8389,-1.58594,-0.00280762], 226.241, false],
				["Land_CampingTable_F", [-15.4463,13.3457,3.97589], 302.938, false],
				["Land_TableDesk_F", [-16.3154,12.7051,1.0976], 31.3403, false],
				["Land_CampingChair_V1_F", [-15.4756,14.1035,3.96917], 311.646, false],
				["Land_ChairWood_F", [-16.0186,13.4551,1.0987], 29.1968, false],
				["Land_Stone_4m_F", [-20.2354,-0.130859,-0.00276756], 46.2438, false],
				["Land_CerealsBox_F", [-19.9668,6.19727,1.3926], 50.6619, false],
				["Land_CerealsBox_F", [-20.123,6.08789,1.39319], 10.735, false],
				["Land_BakedBeans_F", [-20.1895,5.98242,1.39373], 359.801, false],
				["Land_BakedBeans_F", [-20.3164,5.80469,1.39465], 359.804, false],
				["Land_BakedBeans_F", [-20.3643,5.63672,1.39548], 0.0246041, false],
				["Land_CampingChair_V1_F", [-17.8799,12.1602,3.98348], 35.2809, false],
				["Land_RiceBox_F", [-20.5303,5.34766,1.39696], 0.000346632, false],
				["Land_i_Stone_HouseBig_V1_F", [-16.7217,14.334,0.90839], 212.06, false],
				["Land_i_Stone_Shed_V3_F", [-20.6436,5.47461,1.13357], 302.392, false],
				["Land_Rack_F", [-16.0967,15.2559,3.95914], 124.761, false],
				["Land_CampingTable_F", [-18.4971,11.75,3.986], 32.2554, false],
				["Land_CanisterPlastic_F", [-21.002,4.63477,1.40064], 19.7895, false],
				["Land_RiceBox_F", [-21.3291,4.31641,1.40338], 293.472, false],
				["Land_CampingChair_V1_F", [-18.6309,12.6094,3.97935], 32.9821, false],
				["Land_Stone_pillar_F", [-21.7217,1.55273,-0.00280762], 226.241, false],
				["Land_Camping_Light_F", [-21.9844,5.51367,1.42913], 359.841, true],
				["Land_Sleeping_bag_blue_F", [-22.5596,3.52734,1.41225], 207.91, false],
				["Land_Can_Rusty_F", [-17.6816,15.9883,4.60077], 6.90893, false],
				["Land_Sleeping_bag_blue_F", [-21.7119,8.69727,1.37973], 301.899, false],
				["Land_FMradio_F", [-17.8711,16.2109,4.57615], 359.903, false],
				["Land_ShelvesWooden_khaki_F", [-17.916,16.2598,3.94995], 301.191, false],
				["Land_Sleeping_bag_brown_F", [-22.3711,7.74219,1.38465], 301.587, false],
				["Land_Bandage_F", [-23.043,5.45313,1.48089], 300.637, false],
				["Land_Pillow_F", [-23.4258,3.58008,1.38762], 298.669, false],
				["Land_Canteen_F", [-17.9658,16.2891,1.88744], 214.901, false],
				["Land_Bandage_F", [-23.2002,5.55664,1.50511], 322.049, false],
				["Land_Can_V3_F", [-18.0146,16.3633,1.51456], 206.9, false],
				["Land_Sleeping_bag_brown_F", [-23.082,6.45117,1.3907], 301.748, false],
				["Land_Rack_F", [-18.2451,16.502,1.10639], 116.697, false],
				["Land_BakedBeans_F", [-22.9131,8.99609,1.38003], 0.0076908, false],
				["Land_HandyCam_F", [-18.5898,16.5137,1.58429], 207.9, false],
				["Land_Sleeping_bag_F", [-23.9209,4.53711,1.40895], 216.899, false],
				["Land_VitaminBottle_F", [-23.3701,7.53125,1.38736], 359.823, false],
				["Land_MobilePhone_old_F", [-18.7021,16.5664,1.58407], 214.901, false],
				["Land_BakedBeans_F", [-23.8809,5.69922,1.40125], 359.894, false],
				["Land_Pillow_grey_F", [-23.8682,6.06445,1.39795], 20.2584, false],
				["Land_Sleeping_bag_blue_F", [-25.0293,5.01758,1.40974], 210.764, false],
				["Land_PortableLongRangeRadio_F", [-20.6318,16.7832,5.24516], 293.659, false],
				["Land_TinContainer_F", [-20.377,17.2676,4.80629], 127.659, false],
				["Land_PortableLongRangeRadio_F", [-20.7432,16.834,4.89483], 301.659, false],
				["Land_Can_V2_F", [-20.3857,17.3652,4.44796], 125.659, false]
			]]
		]],	
		["CIV Furniture",
		[
			["Dining Table Large 1",
			[
				["Land_WoodenTable_large_F", [0,0,0], 217.287, false],
				["Land_Bench_F", [0.886719,-0.740234,-0.00202942], 217.287, false],
				["Land_Tableware_01_cup_F", [-0.365234,-0.191406,0.864601], 217.285, false],
				["Land_MobilePhone_smart_F", [0.585938,0.261719,0.849783], 133.51, false],
				["Land_BottlePlastic_V2_F", [0.0488281,0.117188,0.864586], 217.285, false],
				["Land_Bench_F", [-0.861328,0.697266,0.00156784], 37.742, false]
			]],
			["Dining Table Large 2",
			[	
				["Land_WoodenTable_large_F", [0,0,0], 227.29, false],
				["Land_PortableLongRangeRadio_F", [0.563965,0.0800781,0.863516], 287.789, false],
				["Land_Canteen_F", [-0.0895996,0.341797,0.873188], 330.782, false],
				["Land_ChairPlastic_F", [-0.366455,1.33984,0.000759125], 78.1733, false],
				["Land_ChairPlastic_F", [1.32202,1.23828,0.00417137], 149.103, false],
				["Land_Camping_Light_off_F", [-0.638672,-0.0449219,0.866898], 227.29, false],
				["Land_Bench_F", [0.986084,-0.988281,0.0066967], 231.103, false],
				["Land_ChairPlastic_F", [-1.2666,-1.33398,0.000236511], 289.772, false]
			]],
			["Dining Table Small 1",
			[		
				["Land_WoodenTable_small_F", [0,0,0], 43.4638, true],
				["Land_ChairWood_F", [-0.605469,0.541016,0], 278.989, false],
				["Land_Tableware_01_fork_F", [-0.0410156,0.404297,0.848419], 216.493, false],
				["Land_Tableware_01_knife_F", [-0.164063,0.275391,0.852144], 194.655, false],
				["Land_SurvivalRadio_F", [-0.204102,-0.171875,0.854589], 359.988, false],
				["Land_CanOpener_F", [0.390625,0.03125,0.86459], 55.0992, false],
				["Land_ChairWood_F", [-0.720703,-0.816406,0], 218.049, true],
				["Land_ChairWood_F", [0.576172,-0.791016,0], 131.445, true]
			]],
			["Garden Table",
			[		
				["Land_TablePlastic_01_F", [0,0,0], 262.773, false],
				["Land_Sunshade_02_F", [-0.0229492,0.0722656,0.191671], 0.0692516, false],
				["Land_ChairPlastic_F", [-1.2478,0.875,0.00020504], 31.4989, false],
				["Land_ChairPlastic_F", [-0.15918,-1.9043,0.000154495], 280.431, false],
				["Land_ChairPlastic_F", [1.07446,0.0703125,0.000175476], 171.871, false]
			]],
			["Rattan Table",
			[		
				["Land_RattanTable_01_F", [0,0,0], 354.625, false],
				["Land_RattanChair_01_F", [-0.220459,1.25391,8.58307e-005], 7.01828, false],
				["Land_Sunshade_04_F", [-0.729004,0.19043,0.00049305], 0.0484414, false],
				["Land_RattanChair_01_F", [-0.780273,-0.826172,9.15527e-005], 228.255, false]
			]],
			["Food Storage Table 1",
			[	
				["Land_CampingTable_F", [0,0,0], 294.078, false],
				["Land_Bucket_F", [1.79199,2.40332,4.95911e-005], 359.846, false],
				["Land_Sack_F", [0.0244141,-1.50586,-1.14441e-005], 277.993, false],
				["Land_Sacks_heap_F", [-1.05957,-1.31055,-5.72205e-006], 209.283, false],
				["Land_FMradio_F", [1.00684,2.33105,0.813007], 286.259, false],
				["Land_TinContainer_F", [0.898438,2.2168,0.813002], 290.259, false],
				["Land_CampingTable_F", [0.814453,1.78613,-1.90735e-006], 294.259, false],
				["Land_BottlePlastic_V2_F", [0.582031,1.33789,0.813007], 290.259, false],
				["Land_Camping_Light_off_F", [0.688477,0.745117,0.813007], 294.258, false],
				["Land_Can_V2_F", [0.331055,0.487305,0.813005], 299.078, false],
				["Land_CratesPlastic_F", [-0.0751953,-0.259766,0.813009], 306.034, false]
			]],
			["Food Storage Shelf 1",
			[	
				["Land_Metal_rack_Tall_F", [0,0,0], 221.774, false],
				["Land_CerealsBox_F", [-0.0776367,0.1875,0.482567], 42.774, false],
				["Land_BakedBeans_F", [-0.216797,0.177734,1.24625], 38.774, false],
				["Land_CerealsBox_F", [-0.196777,0.111328,0.105547], 36.774, false],
				["Land_CanOpener_F", [0.0947266,-0.046875,0.477346], 35.774, false],
				["Land_RiceBox_F", [0.152588,-0.144531,0.0955448], 45.774, false],
				["Land_CerealsBox_F", [0.2146,-0.191406,0.853769], 35.774, false],
				["Land_PowderedMilk_F", [0.151611,-0.230469,1.23534], 34.774, false],
				["Land_BarrelEmpty_grey_F", [0.694092,-0.40625,0.00038147], 0.00892538, false],
				["Land_BarrelTrash_grey_F", [0.979492,-0.976563,0.000432968], 0.0146461, false]
			]],
			["Food Storage Shelf 2",
			[
				["Land_Metal_wooden_rack_F", [0,0,0], 46.0737, false],
				["Land_Metal_wooden_rack_F", [-0.810547,0.861328,1.90735e-006], 46.0737, false],
				["Land_PowderedMilk_F", [-0.874023,0.796875,1.58417], 56.0737, false],
				["Land_RiceBox_F", [-0.761963,0.738281,0.59741], 52.0737, false],
				["Land_CerealsBox_F", [-0.0144043,0.101563,0.598349], 55.0737, false],
				["Land_PowderedMilk_F", [0.00341797,-0.0410156,0.104872], 53.0737, false],
				["Land_CanOpener_F", [0.0544434,-0.0878906,1.09047], 39.0737, false]
			]],
			["Food Storage Shelf 3",
			[
				["Land_Metal_rack_Tall_F", [0,0,0], 290.909, false],
				["Land_Can_V3_F", [0.0917969,0.148438,1.62], 111.909, false],
				["Land_Can_Rusty_F", [-0.0078125,0.114258,0.860001], 111.909, false],
				["Land_MobilePhone_smart_F", [-0.00488281,-0.198242,1.24], 112.909, false],
				["Land_TinContainer_F", [-0.117188,-0.1875,1.62], 102.909, false],
				["Land_Canteen_F", [-0.165039,-0.185547,0.860001], 116.909, false],
				["Land_MobilePhone_smart_F", [-0.183594,-0.226563,0.0999985], 120.909, false],
				["Land_BottlePlastic_V2_F", [-0.266602,-0.452148,0.480003], 107.909, false],
				["Land_MobilePhone_smart_F", [-0.279297,-0.466797,0.0999985], 118.909, false],
				["Land_BottlePlastic_V2_F", [-0.279297,-0.568359,0.860001], 110.909, false],
				["Land_Metal_rack_Tall_F", [-0.287109,-0.749023,0], 290.909, false]
			]],
			["Shop",
			[
				["Land_CashDesk_F", [0,0,0], 268.97, false],
				["Land_Icebox_F", [0.0273438,-1.8418,0.00248528], 272.711, false],
				["Land_Metal_rack_F", [3.73926,-4.79297,0.002285], 94.533, false],
				["Land_ShelvesMetal_F", [1.90039,-4.67969,-0.00103951], 1.7247, false],
				["Land_Metal_rack_F", [3.82617,-3.27539,0.00332451], 94.4806, false],
				["Land_Metal_wooden_rack_F", [-0.108398,-5.45508,0.00264168], 92.8054, false],
				["Land_Metal_wooden_rack_F", [-0.0390625,-4.29102,0.00259399], 92.7748, false]
			]]
		]],
		["Office Furniture",
		[
			["Office Desk Chief",
			[
				["Land_TableDesk_F", [0,0,0], 359.737, false],
				["Land_OfficeChair_01_F", [-0.0390625,0.813477,-1.33514e-005], 359.981, false],
				["Land_File2_F", [0.461914,-0.0498047,0.820234], 359.999, false],
				["Land_PCSet_01_mouse_F", [-0.646484,0.265625,0.822691], 182.291, false],
				["Land_PCSet_01_screen_F", [-0.404297,-0.0546875,0.822477], 218.573, false],
				["Land_PCSet_01_keyboard_F", [-0.177734,0.224609,0.822157], 190.713, false],
				["Land_Tableware_01_cup_F", [0.696289,0.177734,0.820471], 231.538, false]
			]],
			["Office Desk 1",
			[
				["OfficeTable_01_new_F", [0,0,0], 0.0308688, false],
				["Land_OfficeCabinet_01_F", [-1.16797,-0.0429688,8.01086e-005], 358.492, false],
				["Land_OfficeChair_01_F", [-0.154297,-0.603516,9.53674e-006], 145.411, false],
				["Land_FilePhotos_F", [-0.362305,-0.0742188,0.844797], 360, false],
				["Land_Laptop_F", [0.154297,0.00976563,0.844809], 360, false]
			]],
			["Office Desk 2",
			[
				["Land_TableDesk_F", [0,0,0], 359.816, false],
				["Land_Laptop_unfolded_scripted_F", [-0.0107422,0.0859375,0.822056], 359.995, false],
				["Land_OfficeChair_01_F", [-0.0380859,0.813477,-0.000198364], 0.0599838, false],
				["Land_File2_F", [-0.612305,0.0371094,0.822718], 28.2709, false],
				["Land_Tableware_01_cup_F", [-0.34375,0.224609,0.822683], 231.588, false],
				["Land_BottlePlastic_V1_F", [-0.28418,-0.151367,0.822781], 358.441, false]
			]],
			["Office Desk 3",
			[
				["OfficeTable_01_new_F", [0,0,0], 355.197, false],
				["Land_OfficeCabinet_01_F", [-1.18262,-0.121094,7.82013e-005], 357.433, false],
				["Land_OfficeChair_01_F", [-0.180664,-0.80957,1.52588e-005], 173.006, false],
				["Land_PensAndPencils_F", [0.486328,-0.177734,0.825361], 358.035, false],
				["Land_PCSet_01_mouse_F", [0.142578,-0.0742188,0.844809], 338.431, false],
				["Land_PCSet_01_screen_F", [-0.206055,0.0917969,0.844803], 343.618, false],
				["Land_PCSet_01_keyboard_F", [-0.197266,-0.124023,0.822725], 346.853, false],
				["Land_Notepad_F", [0.357422,-0.0566406,0.823517], 283.037, false]
			]],
			["Shelves with files",
			[
				["Land_Metal_rack_Tall_F", [0,0,0], 122.79, false],
				["Land_Map_F", [-0.208984,-0.194336,0.104439], 217.79, false],
				["Land_FilePhotos_F", [-0.106445,-0.12793,0.863365], 298.79, false],
				["Land_FilePhotos_F", [0.171875,0.231445,0.473572], 307.79, false],
				["Land_File2_F", [0.170898,0.119141,1.2379], 310.79, false],
				["Land_Map_F", [0.180664,0.117188,1.61813], 208.79, false],
				["Land_File1_F", [0.322266,0.49707,0.867012], 308.79, false],
				["Land_File1_F", [0.373047,0.517578,0.0954819], 296.79, false],
				["Land_Notepad_F", [0.391602,0.536133,0.486519], 40.7901, false],
				["Land_Metal_rack_Tall_F", [0.448242,0.699219,-0.378952], 122.79, false],
				["Land_Map_unfolded_F", [0.485352,0.806641,0.857445], 113.79, false],
				["Land_FilePhotos_F", [0.522461,0.817383,0.110878], 312.79, false],
				["Land_File1_F", [0.526367,0.799805,1.2383], 300.79, false],
				["Land_Map_F", [0.541992,0.786133,0.479057], 204.79, false]
			]],
			["Shelves with printer",
			[
				["Land_Rack_F", [0,0,0], 358.606, false],
				["Land_Printer_01_F", [0.0771484,-1.27734,0.989531], 266.508, false],
				["Land_Suitcase_F", [0.0302734,0.793945,9.53674e-006], 359.531, false],
				["Land_ShelvesWooden_F", [0.0195313,-1.2373,0.00753021], 0.815455, false],
				["Land_File_research_F", [0.0351563,-1.04297,0.629259], 78.9232, false],
				["Land_File1_F", [0.185547,-1.37402,0.629259], 359.995, false]
			]]
		]],
		["GUER Furniture",
		[
			["Conference Table",
			[
				["Land_CampingTable_F", [0,0,0], 134.815, false],
				["Land_CampingChair_V2_F", [-0.652344,1.53516,0], 320.401, false],
				["Land_CampingChair_V2_F", [-1.45996,0.710938,0], 336.981, false],
				["Land_CampingTable_F", [-0.568359,0.574219,0], 314.78, false],
				["Land_Tablet_02_F", [-1.0127,0.207031,0.813007], 0.148611, false],
				["Land_CampingChair_V2_F", [-2.17871,0.0117188,0], 317.445, false],
				["Land_CampingChair_V2_F", [1.00879,-0.179688,0], 121.072, false],
				["Land_File1_F", [-1.66211,-0.582031,0.813007], 285.52, false],
				["Land_CampingChair_V2_F", [-2.84277,-0.599609,0], 317.445, false],
				["Land_CampingTable_F", [-1.94336,-0.820313,0], 314.78, false],
				["Land_PenBlack_F", [-2.27734,-1.07813,0.807806], 111.743, false],
				["Land_CampingChair_V2_F", [0.267578,-0.916016,0], 126.59, false],
				["Land_Notepad_F", [-2.3877,-1.18945,0.813007], 57.2875, false],
				["Land_Map_F", [-0.868164,-1.07031,0.813007], 0.148611, false],
				["Land_Camera_01_F", [-1.23242,-1.19336,0.813007], 0.148611, false],
				["Land_CampingTable_F", [-1.37598,-1.37891,0], 134.815, false],
				["Land_PensAndPencils_F", [-1.59863,-1.76953,0.813007], 305.001, false],
				["Land_Map_altis_F", [-1.70996,-1.69727,0.813007], 43.1589, false],
				["Land_CampingChair_V2_F", [-0.399414,-1.65039,0], 126.59, false],
				["Land_CampingChair_V2_F", [-1.05273,-2.31641,0], 134.655, false],
				["Land_Can_V3_F", [0.368164,0.236328,0.813007], 113.164, false],
				["Land_Can_Rusty_F", [-0.746094,0.447266,0.813007], 359.013, false]
			]],
			["Desk 1",
			[
				["Land_TableDesk_F", [0,0,0], 317.394, false],
				["Land_Suitcase_F", [0.797852,0.591797,0], 44.8343, false],
				["Land_ChairWood_F", [-0.56543,0.603516,0], 276.998, false],
				["Land_Laptop_unfolded_F", [0.328125,0.314453,0.819803], 292.976, false],
				["Land_SatellitePhone_F", [-0.31543,-0.306641,0.822741], 154.453, false]
			]],
			["Desk 2",
			[
				["Land_TableDesk_F", [0,0,0], 232.726, false],
				["Land_ChairWood_F", [-0.783203,-0.171875,1.71661e-005], 265.487, false],
				["Land_File2_F", [-0.0537109,-0.137695,0.822235], 228.726, false],
				["Land_Canteen_F", [-0.234375,0.0800781,0.820297], 240.726, false],
				["Land_Camping_Light_off_F", [-0.143555,0.519531,0], 232.726, false],
				["Land_File1_F", [-0.782227,1.06348,0.61735], 228.73, false],
				["Land_File2_F", [-0.799805,1.16602,0.312305], 233.73, false],
				["Land_ShelvesWooden_F", [-0.816406,1.15527,0], 143.73, false],
				["Land_File1_F", [-0.963867,1.2627,0.61735], 237.73, false]
			]],
			["Line of Tables 1",
			[		
				["Land_CampingTable_F", [0,0,0], 12.4811, false],
				["Land_CampingChair_V1_F", [0.455078,0.923828,0.00320053], 125.963, false],
				["Land_TinContainer_F", [-1.19824,0.400391,0.810526], 11.1705, false],
				["Land_File1_F", [-1.52148,0.420898,0.810123], 11.1705, false],
				["Land_CampingTable_F", [-1.90918,0.43457,-0.00336266], 12.1706, false],
				["Land_Laptop_F", [-2.4248,0.539063,0.809105], 14.1705, false],
				["Land_Laptop_unfolded_F", [0.354492,-0.0644531,0.813007], 6.48104, false],
				["Land_CampingChair_V1_F", [-1.31445,0.908203,0.00312424], 340.866, false],
				["Land_CampingChair_V1_F", [-2.27246,1.01367,0.00312424], 33.6548, false]
			]],
			["Line of Tables 2",
			[
				["Land_CampingTable_F", [0,0,0], 12.3179, false],
				["Land_CampingChair_V1_F", [0.612793,0.834473,-0.0233641], 11.9348, false],
				["Land_CampingChair_V1_F", [-0.352783,0.796875,-0.0233641], 7.71292, false],
				["Land_CampingChair_V1_F", [1.58374,0.320801,-0.0233641], 7.71278, false],
				["Land_CampingChair_V1_F", [2.40259,0.262695,-0.0233641], 344.136, false],
				["Land_BottlePlastic_V2_F", [0.838623,0.11377,0.813005], 6.31783, false],
				["Land_FilePhotos_F", [0.56543,-0.0390625,0.813005], 8.31782, false],
				["Land_CampingTable_F", [1.90918,-0.431641,0], 12.3179, false]
			]],
			["Line of Tables 3",
			[
				["Land_CampingTable_F", [0,0,0], 282.421, false],
				["Land_CampingChair_V2_F", [-0.552734,0.726074,-0.0264521], 304.676, false],
				["Land_CampingChair_V2_F", [-0.273926,1.62842,-0.0264511], 281.347, false],
				["Land_CampingChair_V2_F", [-0.789063,-0.365234,-0.0264511], 281.347, false],
				["Land_PencilYellow_F", [-0.142334,0.208496,0.813005], 278.421, false],
				["Land_FilePhotos_F", [0.0576172,0.448242,0.813005], 291.421, false],
				["Land_BottlePlastic_V2_F", [-0.172119,-0.285645,0.813005], 291.421, false],
				["Land_Map_unfolded_F", [-0.124023,-0.543457,0.813005], 101.421, false],
				["Land_CampingTable_F", [0.415039,1.89844,0], 282.63, false],
				["Land_File2_F", [0.562012,2.46826,0.813005], 274.63, false],
				["Land_Can_V3_F", [0.565186,2.7417,0.813005], 282.63, false],
				["Land_CampingChair_V2_F", [-0.0437012,3.72754,-0.0264502], 27.4196, false]
			]],
			["Line of Tables 4",
			[
				["Land_CampingTable_F", [0,0,0], 20.2355, false],
				["Land_CampingChair_V2_F", [1.96484,-2.09961,-0.00266457], 212.705, false],
				["Land_PensAndPencils_F", [2.31445,-1.08984,0.813623], 269.675, false],
				["Land_Notepad_F", [2.31445,-1.08984,0.805441], 269.675, false],
				["Land_CampingChair_V2_F", [1.26855,-1.35156,-0.00266647], 202.946, false],
				["Land_CampingTable_F", [1.81641,-0.700195,5.72205e-006], 19.6745, false],
				["Land_Compass_F", [1.83691,-0.494141,0.811226], 359.674, false],
				["Land_Map_unfolded_F", [1.60156,-0.410156,0.811308], 219.675, false],
				["Land_CampingChair_V2_F", [-0.0947266,-1.20898,9.53674e-006], 188.294, false],
				["Land_Laptop_unfolded_F", [0.371094,-0.295898,0.810432], 220.236, false],
				["Land_BottlePlastic_V1_F", [0.175781,0.0429688,0.811563], 100.236, false],
				["Land_File1_F", [-0.0341797,-0.09375,0.812878], 160.236, false]

			]],
			["Small Table 1",
			[
				["Land_CampingTable_small_F", [0,0,0], 0.317196, false],
				["Land_CampingChair_V2_F", [-0.162109,0.806641,2.47955e-005], 334.25, false],
				["Land_Camping_Light_F", [-0.144531,0.100586,0.813], 358.471, true],
				["Land_Map_unfolded_F", [0.123047,-0.169922,0.813017], 134.239, false],
				["Land_Tablet_02_F", [0.228516,0.192383,0.813019], 20.4466, false],
				["Land_BottlePlastic_V2_F", [-0.310547,-0.0566406,0.812996], 358.606, false],
				["Land_PortableLongRangeRadio_F", [-0.258789,0.205078,0.812958], 175.625, false],
				["Land_PortableLongRangeRadio_F", [-0.104492,0.251953,0.813004], 134.644, false],
				["Land_CampingChair_V2_F", [1.1084,0.553711,2.67029e-005], 56.2712, false]
			]]
		]]
	];
	// sort array
	Achilles_var_compositions = [Achilles_var_compositions,[],{_x select 0}] call BIS_fnc_sortBy;
	{
		_category_items = _x select 1;
		_category_items = [_category_items,[],{_x select 0}] call BIS_fnc_sortBy;
		Achilles_var_compositions set [_forEachIndex, [_x select 0, _category_items]];
	} forEach Achilles_var_compositions;
};

private '_center_object';
_spawn_pos = position _logic;

_dialogResult =
[
	localize "STR_ADVANCED_COMPOSITION",
	[
		[localize "STR_AUTHOR",[localize "STR_DEFAULT", name player]],
		[localize "STR_CATEGORY", [localize "STR_LOADING_"]],
		[localize "STR_NAME", [localize "STR_LOADING_"]]
	],
	"Ares_fnc_RscDisplayAttributes_SpawnAdvancedComposition"
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

// provisional!!!!!!!
if (_dialogResult select 0 == 1) exitWith {};
// provisional!!!!!!!

_category_id = _dialogResult select 1;
_object_id = _dialogResult select 2;

_objects_info = Ares_var_current_composition;
if (isNil "_objects_info") exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
_center_object_info = _objects_info select 0;
_objects_info = _objects_info - [_center_object_info];

_type = _center_object_info select 0;
_center_dir = _center_object_info select 2;
_allow_sim = _center_object_info select 3;

_center_object = _type createVehicle [0,0,0];
_center_object setPosATL [-500,-500,0];
_center_object setDir _center_dir;

[[_center_object], true] call Ares_fnc_AddUnitsToCurator;
_attached_objects = [];
{
	_object_info = _x;
	
	_type = _object_info select 0;
	_pos = _object_info select 1;
	_dir = _object_info select 2;
	_pos = _pos vectorAdd (getPosATL _center_object);
	_dir = _dir - (getDir _center_object);
	_allow_sim = _object_info select 3;
	
	_object = _type createVehicle [0,0,0];
	_object enableSimulationGlobal _allow_sim;
	_object setPosATL _pos;
	_object attachTo [_center_object];
	[_object, _dir] remoteExec ['setDir',0,true];
	_attached_objects pushBack _object;
	/*
	if (_type in CHAIRS_CLASS_NAMES) then
	{
		[[_object], true] call Ares_fnc_AddUnitsToCurator;
	};
	*/
} forEach _objects_info;
_center_object setPos _spawn_pos;
_center_object setVariable ["ACS_attached_objects",_attached_objects];
[_center_object, _attached_objects] spawn {waitUntil {sleep 1; isNull (_this select 0)}; {deleteVehicle _x} forEach (_this select 1)};


#include "\ares_zeusExtensions\Ares\module_footer.hpp"
