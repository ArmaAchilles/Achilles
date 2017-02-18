#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#define DIK_LETTERS  	[DIK_A, DIK_B, DIK_C, DIK_D, DIK_E, DIK_F, DIK_G, DIK_H, DIK_I, DIK_J, DIK_K, DIK_L, DIK_M, DIK_N, DIK_O, DIK_P, DIK_Q, DIK_R, DIK_S, DIK_T, DIK_U, DIK_V, DIK_W, DIK_X, DIK_Y, DIK_Z, DIK_0, DIK_1, DIK_2, DIK_3, DIK_4, DIK_5, DIK_6, DIK_7, DIK_8, DIK_9]
#define STR_LETTERS		[  "A",   "B",   "C",   "D",   "E",   "F",   "G",   "H",   "I",   "J",   "K",   "L",   "M",   "N",   "O",   "P",   "Q",   "R",   "S",   "T",   "U",   "V",   "W",   "X",   "Y",   "Z",   "0",   "1",   "2",   "3",   "4",   "5",   "6",   "7",   "8",   "9"]

params ["_dikKey"];

_index = DIK_LETTERS find _dikKey;

if (_index == -1) then
{
	""
} else
{
	STR_LETTERS select _index
};