/*
	safe conversion from string to array which prevents code injection
	makes use of parseSimpleArray
	parseSimpleArray has a very strict format:
	1) no spaces allowed
	2) only double quotes for strings
	The function takes care of 1) and 2)
*/

params [["_string", "[]", [""]]];

private _charArray = toArray _string;
private _isInsideQuote = false;
private _isApostrophQuote = false;
for "_i" from (count _charArray -1) to 0 step -1 do
{
	private _char = _charArray select _i;
	switch (true) do
	{
		// remove whitespace outside strings
		case (_char in [0x09, 0x0A, 0x0D, 0x20] && {!_isInsideQuote}): 
		{
			_charArray deleteAt _i;
		};
		// handle apostrophe
		case (_char isEqualTo 0x27 && {!_isInsideQuote || _isApostrophQuote}):
		{
			// replace apostroph with quotation mark
			// enter/exit quote
			_isInsideQuote = !_isInsideQuote;
			_isApostrophQuote = !_isApostrophQuote;
			_charArray set [_i, 0x22];
		};
		// handle quotation marks
		case (_char isEqualTo 0x22):
		{
			if (_isApostrophQuote) then
			{
				// duplicate the quotation mark
				_charArray = (_charArray select [0, _i + 1]) + (_charArray select [_i, count _charArray - _i]);
			}
			else
			{
				// enter/exit quote
				_isInsideQuote = !_isInsideQuote;
			};
		};
	};
};
// return
parseSimpleArray (toString _charArray);
