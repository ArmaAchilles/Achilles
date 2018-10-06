#include "macros.hpp"

class cfgFunctions
{
	class Achilles
	{
		class common
		{
			DEF_FUNC_ACHIL_1(common,printZeusError);
			DEF_FUNC_ACHIL_1(common,printZeusMessage);
		};
		class module
		{
			DEF_FUNC_ACHIL_1(module,appendToMethod);
			DEF_FUNC_ACHIL_1(module,callMethod);
			DEF_FUNC_ACHIL_1(module,getAttribute);
			DEF_FUNC_ACHIL_1(module,getSelectedEntities);
			DEF_FUNC_ACHIL_1(module,preinit);
			DEF_FUNC_ACHIL_2(module,preinit,modifier);
			DEF_FUNC_ACHIL_2(module,preinit,placeable);
			DEF_FUNC_ACHIL_2(module,preinit,placeableHelper);
			DEF_FUNC_ACHIL_1(module,openDialog);
			DEF_FUNC_ACHIL_1(module,runInit);
			DEF_FUNC_ACHIL_1(module,setAttribute);
			DEF_FUNC_ACHIL_1(module,setMethod);
		};
	};
	class Ares
	{
	};
};
