
class RscDisplayAttributesGroup: RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesGroup";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesGroup"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesGroup"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	
	class Controls : Controls 
	{
		class Content: Content 
		{
			class Controls: controls 
			{
				delete SpeedMode;
				delete UnitPos;
				delete RespawnPosition;
				
				class CombatMode2: RscAttributeCombatMode {};
				class SpeedMode2: RscAttributeSpeedMode {};
				class UnitPos2: RscAttributeUnitPos {};
				class RespawnPosition2: RscAttributeRespawnPosition 
				{
					class Controls: controls 
					{
						class Title: Title 
						{
							text = "$STR_A3_RscAttributeRespawnPosition_TitleGroup";
						};

						class Background: Background {};
						class West: West {};
						class East: East {};
						class Guer: Guer {};
						class Civ: Civ {};
						class Disabled: Disabled {};
					};
				};
			};
		};
		
		class ButtonBehaviour : ButtonCustom 
		{
			text = "$STR_SKILL";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_changeSkills";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		
		class ButtonSide : ButtonCustomLeft 
		{
			text = "$STR_SIDE";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_changeSideAttribute";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
	};
};