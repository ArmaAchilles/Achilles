#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "The Achilles Dev Team";
        authors[] = {"The Achilles Dev Team"};
        authorUrl = "https://github.com/ArmaAchilles/Achilles";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgModuleCategories.hpp"
#include "CfgSettings.hpp"
