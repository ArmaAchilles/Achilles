#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_common",
            "cba_main",
            "cba_xeh"
        };
        author = AUTHOR_NAME;
        authors[] = {AUTHOR_NAME};
        authorUrl = AUTHOR_URL;
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        dir = PROJECT_DIR;
        name = PROJECT_NAME;
        author = AUTHOR_NAME;
        picture = "\z\achilles\main\data\icon_achilles.paa";
        logo = "\z\achilles\main\data\icon_achilles.paa";
        logoOver = "\z\achilles\main\data\icon_achilles.paa";
        logoSmall = "\z\achilles\main\data\icon_achilles_small.paa";
        hidePicture = 0;
        hideName = 1;
        actionName = "Website";
        action = AUTHOR_URL;
        description = ""; // -- To Do: Localized description
        overview = ""; // -- To Do: Localized description
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgModuleCategories.hpp"
