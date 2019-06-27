class RscText;
class RscEdit;
class RscCheckBox;
class ctrlToolbox;
class ctrlXSliderH;
class RscActivePicture;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButton;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscCombo {
    class ComboScrollBar;
};

class GVAR(rscEdit): RscEdit {
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(rscCheckbox): RscCheckBox {
    soundEnter[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
    soundPush[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.09, 1};
    soundClick[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.09, 1};
    soundEscape[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
};

class GVAR(rscCombo): RscCombo {
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

class GVAR(display) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_ACHILLES_TITLE;
            x = POS_X(6.5);
            y = POS_TITLE_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = THEME_COLORS;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_ACHILLES_BACKGROUND;
            x = POS_X(6.5);
            y = POS_BACKGROUND_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_BACKGROUND_H(MIN_HEIGHT);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroup {
            idc = IDC_ACHILLES_CONTENT;
            x = POS_X(7);
            y = POS_CONTENT_Y(MIN_HEIGHT);
            w = POS_W(26);
            h = MIN_HEIGHT;
        };
        class ButtonOK: RscButtonMenuOK {
            idc = IDC_ACHILLES_BTN_OK;
            x = POS_X(28.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = IDC_ACHILLES_BTN_CANCEL;
            x = POS_X(6.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

class GVAR(row_base): RscControlsGroupNoScrollbars {
    GVAR(script) = "";
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Name: RscText {
            idc = IDC_ACHILLES_ROW_NAME;
            x = 0;
            y = 0;
            w = POS_W(10);
            h = POS_H(1);
            colorBackground[] = {0, 0, 0, 0.5};
        };
    };
};

class GVAR(row_checkbox): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_checkbox);
    class controls: controls {
        class Name: Name {};
        class Checkbox: GVAR(rscCheckbox) {
            idc = IDC_ACHILLES_ROW_CHECKBOX;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
        };
    };
};

class GVAR(row_text): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_text);
    class controls: controls {
        class Name: Name {};
        class Edit: GVAR(rscEdit) {
            idc = IDC_ACHILLES_ROW_TEXT;
            x = POS_W(10.1);
            y = pixelH;
            w = POS_W(15.9);
            h = POS_H(1) - pixelH;
        };
    };
};

class GVAR(row_select): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_select);
    class controls: controls {
        class Name: Name {};
        class Combo: GVAR(rscCombo) {
            idc = IDC_ACHILLES_ROW_SELECT;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(1);
        };
    };
};

class GVAR(row_block2): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_block);
    class controls: controls {
        class Name: Name {};
        class Toolbox: ctrlToolbox {
            idc = IDC_ACHILLES_ROW_BLOCK;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(1);
            rows = 1;
            columns = 2;
        };
    };
};

class GVAR(row_block3): GVAR(row_block2) {
    class controls: controls {
        class Name: Name {};
        class Toolbox: Toolbox {
            columns = 3;
        };
    };
};

class GVAR(row_block4): GVAR(row_block2) {
    class controls: controls {
        class Name: Name {};
        class Toolbox: Toolbox {
            columns = 4;
        };
    };
};

class GVAR(row_block5): GVAR(row_block2) {
    class controls: controls {
        class Name: Name {};
        class Toolbox: Toolbox {
            columns = 5;
        };
    };
};

class GVAR(row_slider): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_slider);
    class controls: controls {
        class Name: Name {};
        class Slider: ctrlXSliderH {
            idc = IDC_ACHILLES_ROW_SLIDER;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.8);
            h = POS_H(1);
        };
        class Edit: GVAR(rscEdit) {
            idc = IDC_ACHILLES_ROW_SLIDER_EDIT;
            x = POS_W(24);
            y = pixelH;
            w = POS_W(2);
            h = POS_H(1) - pixelH;
        };
    };
};

class GVAR(row_sides): GVAR(row_base_sides) {
    GVAR(script) = QFUNC(dynamic_sides);
    h = POS_H(2.5);
    class controls: controls {
        class Name: Name {
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class BLUFOR: RscActivePicture {
            idc = IDC_ACHILLES_ROW_SIDES_BLUFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
            tooltip = "$STR_WEST";
            x = POS_W(12.5);
            y = POS_H(0.25);
            w = POS_W(2);
            h = POS_H(2);
        };
        class OPFOR: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_OPFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
            tooltip = "$STR_EAST";
            x = POS_W(15.5);
        };
        class Independent: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_INDEPENDENT;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = POS_W(18.5);
        };
        class Civilian: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_CIVILIAN;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
            tooltip = "$STR_civilian";
            x = POS_W(21.5);
        };
    };
};

class GVAR(row_colorRGB): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_color);
    h = POS_H(3);
    class controls: controls {
        class Name: Name {
            h = POS_H(3);
        };
        class Preview: RscText {
            idc = IDC_ACHILLES_ROW_COLOR_PREVIEW;
            x = POS_W(6.5);
            y = POS_H(0.5);
            w = POS_W(3);
            h = POS_H(2);
        };
        class Red: ctrlXSliderH {
            idc = IDC_ACHILLES_ROW_COLOR_RED;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.8);
            h = POS_H(1);
            color[] = {1, 0, 0, 0.6};
            colorActive[] = {1, 0, 0, 1};
        };
        class Red_Edit: GVAR(rscEdit) {
            idc = IDC_ACHILLES_ROW_COLOR_RED_EDIT;
            x = POS_W(24);
            y = 0;
            w = POS_W(2);
            h = POS_H(1);
        };
        class Green: Red {
            idc = IDC_ACHILLES_ROW_COLOR_GREEN;
            y = POS_H(1);
            color[] = {0, 1, 0, 0.6};
            colorActive[] = {0, 1, 0, 1};
        };
        class Green_Edit: Red_Edit {
            idc = IDC_ACHILLES_ROW_COLOR_GREEN_EDIT;
            y = POS_H(1);
        };
        class Blue: Red {
            idc = IDC_ACHILLES_ROW_COLOR_BLUE;
            y = POS_H(2);
            color[] = {0, 0, 1, 0.6};
            colorActive[] = {0, 0, 1, 1};
        };
        class Blue_Edit: Red_Edit {
            idc = IDC_ACHILLES_ROW_COLOR_BLUE_EDIT;
            y = POS_H(2);
        };
    };
};

class GVAR(row_colorRGBA): GVAR(row_colorRGB) {
    h = POS_H(4);
    class controls: controls {
        class Name: Name {
            h = POS_H(4);
        };
        class Preview: Preview {
            h = POS_H(3);
        };
        class Red: Red {};
        class Red_Edit: Red_Edit {};
        class Green: Green {};
        class Green_Edit: Green_Edit {};
        class Blue: Blue {};
        class Blue_Edit: Blue_Edit {};
        class Alpha: Red {
            idc = IDC_ACHILLES_ROW_COLOR_ALPHA;
            y = POS_H(3);
            color[] = {1, 1, 1, 0.6};
            colorActive[] = {1, 1, 1, 1};
        };
        class Alpha_Edit: Red_Edit {
            idc = IDC_ACHILLES_ROW_COLOR_ALPHA_EDIT;
            y = POS_H(3);
        };
    };
};

class GVAR(row_vectorXY): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_vector);
    class controls: controls {
        class Name: Name {};
        class IconX: RscText {
            idc = -1;
            style = ST_CENTER;
            text = "$STR_3DEN_Axis_X";
            x = POS_W(10.1);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
            font = "RobotoCondensedLight";
            colorBackground[] = {0.77, 0.18, 0.1, 1};
            shadow = 0;
        };
        class EditX: GVAR(rscEdit) {
            idc = IDC_ACHILLES_ROW_VECTOR_X;
            x = POS_W(11.2);
            y = pixelH;
            w = POS_W(6.8);
            h = POS_H(1) - pixelH;
        };
        class IconY: IconX {
            text = "$STR_3DEN_Axis_Y";
            x = POS_W(18.1);
            colorBackground[] = {0.58, 0.82, 0.22, 1};
        };
        class EditY: EditX {
            idc = IDC_ACHILLES_ROW_VECTOR_Y;
            x = POS_W(19.2);
        };
    };
};

class GVAR(row_vectorXYZ): GVAR(row_vectorXY) {
    class controls: controls {
        class Name: Name {};
        class IconX: IconX {};
        class EditX: EditX {
            w = POS_W(12.4/3);
        };
        class IconY: IconY {
            x = POS_W(11.3 + 12.4/3);
        };
        class EditY: EditY {
            x = POS_W(12.4 + 12.4/3);
            w = POS_W(12.4/3);
        };
        class IconZ: IconX {
            text = "$STR_3DEN_Axis_Z";
            x = POS_W(12.5 + 2 * 12.4/3);
            colorBackground[] = {0.26, 0.52, 0.92, 1};
        };
        class EditZ: EditX {
            idc = IDC_ACHILLES_ROW_VECTOR_Z;
            x = POS_W(13.6 + 2 * 12.4/3);
            w = POS_W(12.4/3);
        };
    };
};

class GVAR(row_owners): GVAR(row_base) {
    GVAR(script) = QFUNC(dynamic_owners);
    w = POS_W(26);
    h = POS_H(5);
    class controls: controls {
        class Name: Name {
            y = pixelH;
            w = POS_W(26);
            h = POS_H(1) - pixelH;
        };
        class Background: RscText {
            idc = -1;
            x = 0;
            y = POS_Y(2);
            w = POS_W(26);
            h = POS_H(3);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class TabSide: RscButton {
            idc = IDC_ACHILLES_ROW_TAB_SIDE;
            colorDisabled[] = {1, 1, 1, 1};
            colorFocused[] = {1, 1, 1, 0.1};
            colorBackground[] = {1, 1, 1, 0};
            colorBackgroundActive[] = {1, 1, 1, 0.3};
            colorBackgroundDisabled[] = {1, 1, 1, 0.1};
            shadow = 0;
            period = 0;
            periodFocus = 0;
            periodOver = 0;
            text = "$STR_Achilles_Common_Upper_Sides";
            x = 0;
            y = POS_Y(1);
            w = POS_W(8.5);
            h = POS_H(1);
        };
        class TabGroup: TabSide {
            idc = IDC_ACHILLES_ROW_TAB_GROUP;
            text = "$STR_Achilles_Common_Upper_Groups";
            x = POS_W(8.5);
            y = POS_Y(1);
            w = POS_W(9);
            h = POS_H(1);
        };
        class TabPlayer: TabSide {
            idc = IDC_ACHILLES_ROW_TAB_PLAYER;
            text = "$STR_Achilles_Common_Upper_Players";
            x = POS_W(17.47);
            y = POS_Y(1);
            w = POS_W(8.52);
            h = POS_H(1);
        };
        class BLUFOR: RscActivePicture {
            idc = IDC_ACHILLES_ROW_SIDES_BLUFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
            tooltip = "$STR_WEST";
            x = POS_W(8.2);
            y = POS_H(2.5);
            w = POS_W(2);
            h = POS_H(2);
        };
        class OPFOR: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_OPFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
            tooltip = "$STR_EAST";
            x = POS_W(11.2);
        };
        class Independent: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_INDEPENDENT;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = POS_W(14.2);
        };
        class Civilian: BLUFOR {
            idc = IDC_ACHILLES_ROW_SIDES_CIVILIAN;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
            tooltip = "$STR_civilian";
            x = POS_W(17.2);
        };
        class GroupList: GVAR(rscCombo) {
            idc = IDC_ACHILLES_ROW_TAB_GROUP_SELECT;
            x = POS_W(2.1);
            y = POS_Y(3);
            w = POS_W(22);
            h = POS_H(1);
        };
        class UnitList: GroupList {
            idc = IDC_ACHILLES_ROW_TAB_PLAYER_SELECT;
        };
    };
};
