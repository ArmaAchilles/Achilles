////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on KRON_Replace by Kronzky)
//	DATE: 6/8/16
//	VERSION: 1.0
//	FILE: Achilles\functions\events\fn_TextToVariableName.sqf
//  DESCRIPTION: replaces invalid letters in order to get a valid variable name
//
//	ARGUMENTS:
//	_this					STRING	- Any kind of text
//
//	RETURNS:
//	_this					STRING	- processed text
//
//	Example:
//	_variable_name  = "myni variablä" call Achilles_fnc_TextToVariableName;
//	systemChat _variable_name; //"myni_variabla"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


if (isNil "Achilles_var_old_special_char_unicode") then
{
	Achilles_var_old_special_char_unicode = [];
	Achilles_var_new_special_char_unicode = [];

	private _old_letters = [" ",":","(",")","[","]"];
	private _new_letters = ["_","_","_","_","_","_"];

	switch (language) do
	{
		case "German":
		{
			_old_letters append ["Ä","ä","Ö","ö","Ü","ü"];
			_new_letters append ["A","a","O","o","U","u"];
		};
		case "French":
		{
			_old_letters append ["é","è","à","ç","î","ë","ê","ù","û","ô","â","ï","ÿ"];
			_new_letters append ["e","e","a","c","i","e","e","u","u","o","a","i","y"];
		};
		case "Russian":
		{
			_old_letters append ["А","а","Б","б","В","в","Г","г","Д","д","Е","е","Ё","ё","Ж","ж","З","з","И","и","Й","й","К","к","Л","л","М","м","Н","н","О","о","П","п","Р","р","С","с","Т","т","У","у","Ф","ф","Х","х","Ц","ц","Ч","ч","Ш","ш","Щ","щ","Ъ","ъ","Ы","ы","Ь","ь","Э","э","Ю","ю","Я","я"];
			_new_letters append ["A","a","B","b","V","v","G","g","D","d","E","e","E","e","Z","z","Z","z","I","i","J","j","K","k","L","l","M","m","N","n","O","o","P","p","R","r","S","s","T","t","U","u","F","f","C","c","C","c","C","c","S","s","S","s","_","_","Y","y","_","_","E","e","U","u","J","j"];
		};
	};

	for "_i" from 0 to ((count _old_letters) - 1) do
	{
		Achilles_var_old_special_char_unicode append (toArray (_old_letters select _i));
		Achilles_var_new_special_char_unicode append (toArray (_new_letters select _i));
	};
};

private _input_unicode = toArray _this;

for "_i" from 0 to ((count _input_unicode) - 1) do
{
	private _letter_index = Achilles_var_old_special_char_unicode find (_input_unicode select _i);
	if (_letter_index != -1) then
	{
		_input_unicode set [_i,Achilles_var_new_special_char_unicode select _letter_index];
	};
};
toString _input_unicode
