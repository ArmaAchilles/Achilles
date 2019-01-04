// Achilles GUI grids
#define GUI_GRID_X		(0.294 * safeZoneW + safeZoneX)
#define GUI_GRID_Y		(0.177 * safeZoneH + safeZoneY)
#define GUI_GRID_W		(0.010 * safeZoneW)
#define GUI_GRID_W_FIX	(0.025)
#define GUI_GRID_H		(0.022 * safeZoneH)
#define GUI_GRID_H_FIX	(0.04)
#define TITLE_FONT_SIZE			(1.2 * GUI_GRID_H_FIX)
#define DEFAULT_FONT_SIZE		(1.0 * GUI_GRID_H_FIX)

//converts Achilles GUI grid to GUI coordinates
#define GtC_X(GRID)				((GRID) * GUI_GRID_W + GUI_GRID_X)
#define GtC_Y(GRID)				((GRID) * GUI_GRID_H + GUI_GRID_Y)
#define GtC_W(GRID)				((GRID) * GUI_GRID_W)
#define GtC_H(GRID)				((GRID) * GUI_GRID_H)
#define GtC_H_FIX(GRID)			((GRID) * GUI_GRID_H_FIX)

// BI GUI grids
#define BIGUI_GRID_W_FIX	(((safezoneW / safezoneH) min 1.2) / 40)
#define BIGUI_GRID_W_DYN	((safeZoneW / 2.42424) * BIGUI_GRID_W_FIX)
#define BIGUI_GRID_H_FIX	((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
#define BIGUI_GRID_H_DYN	((safeZoneH / 1.81818) * BIGUI_GRID_H_FIX)
