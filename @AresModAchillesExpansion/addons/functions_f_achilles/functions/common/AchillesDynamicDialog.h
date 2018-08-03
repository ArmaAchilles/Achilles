// Define some constants for us to use when laying things out.
#define GUI_GRID_X		(0.294 * safeZoneW + safeZoneX)
#define GUI_GRID_Y		(0.177 * safeZoneH + safeZoneY)
#define GUI_GRID_W		(0.010 * safeZoneW)
#define GUI_GRID_H		(0.022 * safeZoneH)
#define GUI_GRID_H_FIX	(0.04)

//converts GUI grid to GUI coordinates
#define GtC_X(GRID)				(GRID) * GUI_GRID_W + GUI_GRID_X
#define GtC_Y(GRID)				(GRID) * GUI_GRID_H + GUI_GRID_Y
#define GtC_W(GRID)				(GRID) * GUI_GRID_W
#define GtC_H(GRID)				(GRID) * GUI_GRID_H
#define GtC_H_FIX(GRID)			GRID * GUI_GRID_H_FIX

#define DYNAMIC_GUI_IDD			133798
#define DYNAMIC_TITLE_IDC		1000
#define DYNAMIC_BG_IDC			2000
#define DYNAMIC_CTRL_GROUP		7000
#define	DYNAMIC_BOTTOM_IDCs		[2010,3000,3010]

#define BG_WIDTH				(40 * GUI_GRID_W)
#define START_ROW_Y				(0)
#define MAX_ALL_ROWS_H			(29.4 * GUI_GRID_H)
#define LABEL_COMBO_H			(0.5 * GUI_GRID_H_FIX)
#define LABEL_COLUMN_X			(0.5 * GUI_GRID_W)
#define LABEL_WIDTH				(39 * GUI_GRID_W)
#define LABEL_HEIGHT			(2 * GUI_GRID_H_FIX)
#define LABEL_BG_COLOR			[0,0,0,0.6]

#define COMBO_COLUMN_X			(16 * GUI_GRID_W)
#define COMBO_WIDTH				(22.5 * GUI_GRID_W)
#define COMBO_HEIGHT			(1 * GUI_GRID_H_FIX)
#define OK_BUTTON_X				(29.5 * GUI_GRID_W)
#define OK_BUTTON_WIDTH			(4 * GUI_GRID_W)
#define OK_BUTTON_HEIGHT		(1.5 * GUI_GRID_H_FIX)
#define CANCEL_BUTTON_X			(34 * GUI_GRID_W)
#define CANCEL_BUTTON_WIDTH		(4.5 * GUI_GRID_W)
#define CANCEL_BUTTON_HEIGHT	(1.5 * GUI_GRID_H_FIX)
#define TOTAL_ROW_HEIGHT		(2.1 * GUI_GRID_H_FIX)

#define DEFAULT_FONT_SIZE		(GUI_GRID_H_FIX)

#define BASE_IDC_LABEL			(10000)
#define BASE_IDC_CTRL			(20000)
#define BASE_IDC_ADDITONAL		(30000)
#define SIDE_BASE_IDC			(12000)
