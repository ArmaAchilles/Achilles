
// assign custom buttons in vehicle edit interface
class RscDisplayAttributesVehicle : RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";

	class Controls : Controls 
	{
		class Content: Content 
		{

			class Controls: controls 
			{
				// Trick to get attributes in the right order
				delete Skill;
				delete Lock;
				delete RespawnVehicle;
				delete RespawnPosition;
				delete Exec;
				
				class Ammo: RscAttributeAmmo {};
				class Skill2: RscAttributeSkill {};
				class Lock2: RscAttributeLock {};
				class Headlight: RscAttributeHeadlight {};
				class RespawnVehicle2: RscAttributeRespawnVehicle {};
				class RespawnPosition2: RscAttributeRespawnPosition {};
				class Exec2: RscAttributeExec {};
			};
		};
		class ButtonBehaviour : ButtonCustom 
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo : ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createdialog 'RscDisplayAttributesInventory'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonAmmo : ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "[localize 'STR_NOT_IMPLEMENTED_AT_THE_MOMENT'] call Ares_fnc_ShowZeusMessage; playSound 'FD_Start_F'";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonDamage : ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_damageComponents";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};

// assign custom buttons in empty vehicle edit interface
class RscDisplayAttributesVehicleEmpty : RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesVehicle";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesVehicle"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";

	class Controls : Controls 
	{
		class Content: Content 
		{
			class Controls: controls 
			{
				// Trick to get attributes in the right order
				delete Lock;
				delete RespawnVehicle;
				delete RespawnPosition;
				delete Exec;
				
				class Ammo: RscAttributeAmmo {};
				class Lock2: RscAttributeLock {};
				class Headlight: RscAttributeHeadlight {};
				class RespawnVehicle2: RscAttributeRespawnVehicle {};
				class RespawnPosition2: RscAttributeRespawnPosition {};
				class Exec2: RscAttributeExec {};
			};
		};
		class ButtonBehaviour : ButtonCustom 
		{
			text = "BEHAVIOUR";
			onMouseButtonClick = "[localize ""STR_NOT_IMPLEMENTED_AT_THE_MOMENT""] call Ares_fnc_ShowZeusMessage; playSound ""FD_Start_F""";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo : ButtonCustomLeft
		{
			text = "CARGO";
			onMouseButtonClick = "createDialog ""RscDisplayAttributesInventory""";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonAmmo : ButtonCustomLeftBelow
		{
			text = "AMMO";
			onMouseButtonClick = "[localize ""STR_NOT_IMPLEMENTED_AT_THE_MOMENT""] call Ares_fnc_ShowZeusMessage; playSound ""FD_Start_F""";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
		class ButtonDamage : ButtonCustomBelow
		{
			text = "DAMAGE";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_damageComponents";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};