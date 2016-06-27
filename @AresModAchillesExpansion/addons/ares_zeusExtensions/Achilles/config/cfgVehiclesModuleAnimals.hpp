/////////////////////////////////////////////////////////////////////////////////////////////
// 	AUTHOR: Kex
// 	DATE: 6/15/16
//	VERSION: 1.0
//	FILE: Achilles\config\cfgVehiclesModuleAnimals.hpp
//  DESCRIPTION: Add new Animal modules
//	NOTE: The classes defined here are children of cfgVehicles
/////////////////////////////////////////////////////////////////////////////////////////////

class ModuleAnimals_F : Module_F
{
	class Arguments 
	{
		class Type 
		{
			
			class values 
			{
				class Turtles
				{
					name = "Turtles";
					value = "Turtle_F";
				};
				
				class Snakes 
				{
					name = "Snakes";
					value = "Snake_random_F";
				};
				
				class Rabbits 
				{
					name = "Rabbits";
					value = "Rabbit_F";
				};
				
				class CatSharks 
				{
					name = "$STR_RED_LIGHT";
					value = "red";
				};
				
				class Tunas 
				{
					name = "Tunas";
					value = "yellow";
				};
			};
		};
	};
};