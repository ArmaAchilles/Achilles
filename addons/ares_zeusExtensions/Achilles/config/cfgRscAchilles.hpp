
class RscAchillesModuleTeleport : RscDisplayAttributes 
{
	onLoad = "['onLoad',_this,'RscAchillesModuleTeleport'] call Achilles_fnc_RscDisplayAttributes";
	onUnload = "['onUnload',_this,'RscAchillesModuleTeleport'] call Achilles_fnc_RscDisplayAttributes";
	
	class Controls : Controls 
	{
		class Background : Background {};
		
		class Title : Title {};
		
		class Content : Content 
		{
			class Controls : controls 
			{
				class Owners : RscAttributeOwners {};
			};
		};
		
		class ButtonOK : ButtonOK {};
		
		class ButtonCancel : ButtonCancel {};
	};
};