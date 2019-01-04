/*
	Author: Kex

	Description:
		Draws an arrow on the local machine
		Intended to be used within the code of an onEachFrame event handler

	Parameters:
    	ARRAY - The base position of the arrow
		ARRAY - The direction vector 
		ARRAY - The up vector
    	SCALAR - (Default: DEFAULT_BASE_LENGTH) of the base
    	SCALAR - (Default: DEFAULT_ARROW_LENGTH) Length of the arrow
    	SCALAR - (Default: DEFAULT_ARROW_WIDTH) Width of the arrow
		ARRAY - (Default: DEFAULT_LINE_RGBA) The color of the lines based on RGBA
		
	Returns:
		Nothing
*/

#define DEFAULT_BASE_LENGTH		30
#define DEFAULT_ARROW_LENGTH	10
#define DEFAULT_ARROW_WIDTH		20
#define DEFAULT_LINE_RGBA		[1,1,0,1]

params
[
	"_basePos",
	"_vecDir",
	"_vecUp",
	["_baseLength", DEFAULT_BASE_LENGTH, [0]],
	["_arrowLength", DEFAULT_ARROW_LENGTH, [0]],
	["_arrowWidth", DEFAULT_ARROW_WIDTH, [0]],
	["_rgba", DEFAULT_LINE_RGBA, [[]], 4]
];

private _halfArrowWidth = _arrowWidth/2;
private _baseMinusArrowLength = _baseLength - _arrowLength;
// correct order for a right-handed coordinate system, where _vecDir is x, _vecPerp is y and _vecUp is z
private _vecPerp = _vecUp vectorCrossProduct _vecDir;
// draw projection of the bounding box on the model XY plane
drawLine3D [_basePos, _basePos vectorAdd (_vecDir vectorMultiply _baseLength), _rgba];
drawLine3D [_basePos vectorAdd (_vecDir vectorMultiply _baseLength), _basePos vectorAdd (_vecDir vectorMultiply _baseMinusArrowLength) vectorAdd (_vecPerp vectorMultiply _halfArrowWidth), _rgba];
drawLine3D [_basePos vectorAdd (_vecDir vectorMultiply _baseLength), _basePos vectorAdd (_vecDir vectorMultiply _baseMinusArrowLength) vectorAdd (_vecPerp vectorMultiply -_halfArrowWidth), _rgba];
