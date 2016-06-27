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

#define OLD_LETTERS	[" ",":","ä","ö","ü","é","è","à","ç","î","ë","ê","ù","û","ô","â","ï","ÿ","(",")","[","]"]
#define NEW_LETTERS	["_","_","a","o","u","e","e","a","c","i","e","e","u","u","o","a","i","y","_","_","_","_"]

if (isNil "Achilles_var_old_special_char") then
{
	Achilles_var_old_special_char = [];
	Achilles_var_new_special_char = [];
	
	for "_i" from 0 to ((count OLD_LETTERS) - 1) do
	{
		Achilles_var_old_special_char append (toArray (OLD_LETTERS select _i));
		Achilles_var_new_special_char append (toArray (NEW_LETTERS select _i));
	};
};

private["_str","_old","_new","_out","_tmp","_jm","_la","_lo","_ln","_i"];

_input_unicode = toArray _this;

for "_i" from 0 to ((count _input_unicode) - 1) do
{
	_letter_index = Achilles_var_old_special_char find (_input_unicode select _i);
	if (_letter_index != -1) then
	{
		_input_unicode set [_i,Achilles_var_new_special_char select _letter_index];
	};
};

_output = toString _input_unicode;
_output;