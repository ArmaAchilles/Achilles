#define COMPONENT ui
#include "\z\achilles\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_UI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_UI
#endif

#include "\z\achilles\addons\main\script_macros.hpp"

// BI GUI includes
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

// Achilles GUI grids
#define GUI_GRID_X          (0.294 * safeZoneW + safeZoneX)
#define GUI_GRID_Y          (0.177 * safeZoneH + safeZoneY)
#define GUI_GRID_W          (0.010 * safeZoneW)
#define GUI_GRID_W_FIX      (0.025)
#define GUI_GRID_H          (0.022 * safeZoneH)
#define GUI_GRID_H_FIX      (0.04)
#define TITLE_FONT_SIZE     (1.2 * GUI_GRID_H_FIX)
#define DEFAULT_FONT_SIZE   (1.0 * GUI_GRID_H_FIX)

// Converts from Achilles GUI grid space to actual positions
#define GUI_POS_X(N)        ((N) * GUI_GRID_W + GUI_GRID_X)
#define GUI_POS_Y(N)        ((N) * GUI_GRID_H + GUI_GRID_Y)
#define GUI_POS_W(N)        ((N) * GUI_GRID_W)
#define GUI_POS_H(N)        ((N) * GUI_GRID_H)
#define GUI_POS_H_FIX(N)    ((N) * GUI_GRID_H_FIX)

// Dynamic Dialog macros
#define IDD_DD              133798
#define IDC_DD_TITLE        1000
#define IDC_DD_BG           2000
#define IDC_DD_CTRL_GROUP   7000
#define IDC_DD_LIST_BOTTOM  [2010, 3000, 3010]

#define DD_BG_WIDTH			GUI_POS_W(40)
#define DD_MAX_ALL_ROWS_H   GUI_POS_H(29.4)

// BI GUI grids
#define BIGUI_GRID_W_FIX	(((safezoneW / safezoneH) min 1.2) / 40)
#define BIGUI_GRID_W_DYN	((safeZoneW / 2.42424) * BIGUI_GRID_W_FIX)
#define BIGUI_GRID_H_FIX	((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define BIGUI_GRID_H_DYN	((safeZoneH / 1.81818) * BIGUI_GRID_H_FIX)
