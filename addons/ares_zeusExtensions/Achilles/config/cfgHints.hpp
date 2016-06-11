
class Ares 
{
	displayName = "Ares";
	
	class PlacingModules
	{
		arguments[] = {};
		description = "The Ares Modules have informative icons in the module tree.%1The most common are described here:<br /><br /><img image='\ares_zeusExtensions\Ares\data\icon_default.paa' size='1.5' shadow='0' /> This module can be placed anywhere.%1<img image='\ares_zeusExtensions\Achilles\data\icon_unit.paa' size='1.5' shadow='0' /> This modul has to be placed on units.%1<img image='\ares_zeusExtensions\Achilles\data\icon_default_unit.paa' size='1.5' shadow='0' /> This can be placed either on a unit or anywhere. The module options aviable depend on the choice!%1<img image='\ares_zeusExtensions\Achilles\data\icon_object.paa' size='1.5' shadow='0' /> This module has to be placed on an object but can often also include units.%1<img image='\ares_zeusExtensions\Achilles\data\icon_default_object.paa' size='1.5' shadow='0' /> This can be placed either on an object or anywhere. The module options aviable depend on the choice!%1<img image='\ares_zeusExtensions\Achilles\data\icon_position.paa' size='1.5' shadow='0' /> The module is activated at the selected position.";
		displayName = "Placing Modules";
		image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
		tip = "For modules applied on objects or units it is often the case that you can either place it on one unit or place it elsewhere to apply it to multiple units.";
	};
	class SelectionOption
	{
		arguments[] = {};
		description = "Some modules have the option to select objects on which it is apply to.%1Whenever you hear this sound you can select objects and submit the selection by pressing %3[ENTER]%4.%1You can cancle the selection mode with %3[ESCAPE]%4.";
		displayName = "Selection Option";
		image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
		tip = "You can read on top what the module want you to select.";
	};
	class KeyAssignment
	{
		arguments[] = {};
		description = "Additional key assignments aviable:<br /><br />%2Press %3[Left Ctrl]%4 + 2x %3[RMB]%4 in order to remote control the AI.%1%2Press %3[Left Shift]%4 + %3[G]%4 to force passengers (including players) of a vehicle to eject (para drop for aircrafts).%1%2Press %3[Left Ctrl]%4 + %3[G]%4 in order to group selected objects.%1%2Ungroup selected objects with %3[Left Ctrl]%4 + %3[Left Shift]%4 + %3[G]%4.";
		displayName = "Additional Key Assignment";
		image = "\ares_zeusExtensions\Achilles\data\icon_achilles_hint.paa";
		tip = "";
	};
};