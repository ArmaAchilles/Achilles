
#define 

class RscDisplayAttributesMan: RscDisplayAttributes 
{
	scriptName = "RscDisplayAttributesMan";
	scriptPath = "AresDisplays";
	onLoad = "[""onLoad"",_this,""RscDisplayAttributesMan"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	onUnload = "[""onUnload"",_this,""RscDisplayAttributesMan"",'AresDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
	
	class Controls: Controls 
	{
		class Content: Content 
		{

			class Controls: controls 
			{
				delete Rank;
				delete UnitPos;
				delete Damage;
				delete Skill;
				delete RespawnPosition;
				delete Exec;
				
				class Name:	RscAttributeName {};
				class Rank2: RscAttributeRank {};
				class UnitPos2: RscAttributeUnitPos {};
				class Damage2: RscAttributeDamage {};
				class Ammo: RscAttributeAmmo {};
				class Skill2: RscAttributeSkill {};
				class RespawnPosition2: RscAttributeRespawnPosition {};
				class Exec2: RscAttributeExec {};
			};
		};
		
		class ButtonBehaviour : ButtonCustom 
		{
			text = "$STR_AMAE_SKILL";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_changeSkills";
			colorBackground[] = {0.518,0.016,0,0.8};
		};
		class ButtonCargo : ButtonCustomLeft
		{
			text = "$STR_AMAE_ARSENAL";
			onMouseButtonClick = "(findDisplay -1) closeDisplay 1; \
								[""Open"",[true,nil,BIS_fnc_initCuratorAttributes_target]] call bis_fnc_arsenal; \
								[BIS_fnc_initCuratorAttributes_target] spawn { \
									waitUntil { sleep 1; isnull ( uinamespace getvariable ""RSCDisplayArsenal"" ) }; \
									params [""_template_unit""]; \
									_loadout = getUnitLoadout _template_unit; \
									_curatorSelected = [""man""] call Achilles_fnc_getCuratorSelected; \
									{_x setUnitLoadout _loadout} forEach _curatorSelected; \
								}";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
        class ButtonFlag : ButtonCustomLeft2
		{
			text = "$STR_AMAE_FLAG";
			onMouseButtonClick = "[BIS_fnc_initCuratorAttributes_target] spawn Achilles_fnc_setFlag";
			colorBackground[] = {0.518,0.016,0,0.8};			
		};
	};
};