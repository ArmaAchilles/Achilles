/*
	Author: Kex

	Description:
		Draws a rectangle on the local machine
		Intended to be used within the code of an onEachFrame event handler

	Parameters:
    	ARRAY - The center position of the rectangle
		ARRAY - The direction vector 
		ARRAY - The up vector
		SCALAR - The length of the rectangle in vector dir direction
		SCALAR - The length of the rectangle in the perpendicular direction
		ARRAY - (Default: DEFAULT_LINE_RGBA) The color of the lines based on RGBA
		
	Returns:
		Nothing
*/

#define DEFAULT_LINE_RGBA	[1,1,0,1]

params
[
	"_centerPos",
	"_vecDir",
	"_vecUp",
	"_len_x",
	"_len_y",
	["_rgba", DEFAULT_LINE_RGBA, [[]], 4]
];

private _half_len_x = _len_x/2;
private _half_len_y = _len_y/2;
// correct order for a right-handed coordinate system, where _vecDir is x, _vecPerp is y and _vecUp is z
private _vecPerp = _vecUp vectorCrossProduct _vecDir;
// draw projection of the bounding box on the model XY plane
drawLine3D [_centerPos vectorAdd (_vecDir vectorMultiply _half_len_x) vectorAdd (_vecPerp vectorMultiply _half_len_y), _centerPos vectorAdd (_vecDir vectorMultiply _half_len_x) vectorAdd (_vecPerp vectorMultiply -_half_len_y), _rgba];
drawLine3D [_centerPos vectorAdd (_vecDir vectorMultiply -_half_len_x) vectorAdd (_vecPerp vectorMultiply _half_len_y), _centerPos vectorAdd (_vecDir vectorMultiply -_half_len_x) vectorAdd (_vecPerp vectorMultiply -_half_len_y), _rgba];
drawLine3D [_centerPos vectorAdd (_vecDir vectorMultiply _half_len_x) vectorAdd (_vecPerp vectorMultiply _half_len_y), _centerPos vectorAdd (_vecDir vectorMultiply -_half_len_x) vectorAdd (_vecPerp vectorMultiply _half_len_y), _rgba];
drawLine3D [_centerPos vectorAdd (_vecDir vectorMultiply _half_len_x) vectorAdd (_vecPerp vectorMultiply -_half_len_y), _centerPos vectorAdd (_vecDir vectorMultiply -_half_len_x) vectorAdd (_vecPerp vectorMultiply -_half_len_y), _rgba];
