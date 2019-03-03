Coding Guidelines
=================

.. note::
    The coding guidelines are adopted from `ACE3 <https://ace3mod.com/wiki/development/coding-guidelines.html>`_ but are not completely equal. Warning messages indicate which portions have been changed to fit Achilles.

.. contents::

1. Naming conventions
---------------------

1.1. Variable names
^^^^^^^^^^^^^^^^^^^

1.1.1. Global variable naming
"""""""""""""""""""""""""""""

All global variables must start with the Achilles prefix followed by the component, separated by underscores.
Global variables may not contain the :code:`fnc_` prefix if the value is not callable code.

Example: :code:`achilles_component_myVariableName`

*For Achilles this is done automatically through the usage of the* :code:`GVAR` *macro family.*

1.1.2. Private variable naming
""""""""""""""""""""""""""""""

To make code as readable as possible, try to use self-explanatory variable names and avoid using single character variable names.

Example: :code:`_velocity` instead of :code:`_v`

1.1.3. Function naming
""""""""""""""""""""""

All functions shall use Achilles and the component name as a prefix, as well as the :code:`fnc_` prefix behind the component name.

Example: :code:`PREFIX_COMPONENT_fnc_functionName`

*For Achilles this is done automatically through the usage of the* :code:`PREP` *macro.*

1.1.4. Name case
"""""""""""""""""""""""""

The only allowed case is camel case.

**Correct:**
::

    private _myVeryLongVariable = "is long";

**Incorrect:**
::

    private _MyVerylongVaRiAbLe = "is long";

1.2. Files & config
^^^^^^^^^^^^^^^^^^^

1.2.1. SQF files
""""""""""""""""

Files containing SQF scripts shall have a file name extension of :code:`.sqf`.

1.2.2. Header files
"""""""""""""""""""

All header files shall have the file name extension of :code:`.hpp`. 

1.2.3. Own SQF file
"""""""""""""""""""

All functions shall be put in their own :code:`.sqf` file.

1.2.4. Config elements
""""""""""""""""""""""

Config files shall be split up into different header files, each with the name of the config and be included in the :code:`config.cpp` of the component.

Example:
::

    #include "Achilles_Settings.hpp"

Add in :code:`Achilles_Settings.hpp`:
::

    class Achilles_Settings
    {
        // Content
    };

1.3. Stringtable
^^^^^^^^^^^^^^^^

All text that shall be displayed to a user shall be defined in a :code:`stringtable.xml` file for multi-language support.

- There shall be no empty stringtable language values.
- All stringtables shall follow the format as a specified by `Tabler <https://github.com/bux/tabler>`_ and the `translation guidelines <localization.html>`_ form.

2. Macro usage
--------------

2.1. Module/PBO specific macro usage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The family of :code:`GVAR` macros define global variable strings or constants for use within a module.
Please use these to make sure we follow naming conventions across all modules and also prevent duplicate/overwriting between variables in different modules.
The macro family expands as follows, for the example of the module 'balls'.

+---------------------------+------------------------------------------------------------------------------------------------------+
|       Macros              |          Expands to                                                                                  |
+===========================+======================================================================================================+
| :code:`GVAR(face)`        | :code:`achilles_balls_face`                                                                          |
+---------------------------+------------------------------------------------------------------------------------------------------+
| :code:`QGVAR(face)`       | :code:`"achilles_balls_face"`                                                                        |
+---------------------------+------------------------------------------------------------------------------------------------------+
| :code:`QQGVAR(face)`      | :code:`""achilles_balls_face""` used inside :code:`QUOTE` macros where double quotation is required. |
+---------------------------+------------------------------------------------------------------------------------------------------+
| :code:`EGVAR(leg,face)`   | :code:`achilles_leg_face`                                                                            |
+---------------------------+------------------------------------------------------------------------------------------------------+
| :code:`QEGVAR(leg,face)`  | :code:`"achilles_leg_face"`                                                                          |
+---------------------------+------------------------------------------------------------------------------------------------------+
| :code:`QQEGVAR(leg,face)` | :code:`""achilles_leg_face""` used inside :code:`QUOTE` macros where double quotation is required.   |
+---------------------------+------------------------------------------------------------------------------------------------------+

There also exists the :code:`FUNC` family of macros.

+---------------------------+----------------------------------------------------------------------------------------------------------+
|       Macros              |          Expands to                                                                                      |
+===========================+==========================================================================================================+
| :code:`FUNC(face)`        | :code:`achilles_balls_fnc_face` or the call trace wrapper for that function.                             |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`EFUNC(leg,face)`   | :code:`achilles_leg_fnc_face` or the call trace wrapper for that function.                               |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`DFUNC(leg,face)`   | :code:`achilles_balls_fnc_face` and will **always** be the function global variable.                     |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`LINKFUNC(face)`    | :code:`FUNC(face)` or *"pass by reference"* :code:`{_this call FUNC(face)}`                              |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`QFUNC(face)`       | :code:`"achilles_balls_fnc_face"`                                                                        |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`QEFUNC(leg,face)`  | :code:`"achilles_leg_fnc_face"`                                                                          |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`QQFUNC(face)`      | :code:`""achilles_balls_fnc_face""` used inside :code:`QUOTE` macros where double quotation is required. |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| :code:`QQEFUNC(leg,face)` | :code:`""achilles_leg_fnc_face""` used inside :code:`QUOTE` macros where double quotation is required.   |
+---------------------------+----------------------------------------------------------------------------------------------------------+

The :code:`FUNC` and :code:`EFUNC` macros shall **not** be used inside :code:`QUOTE` macros if the intention is to get the function name or assumed to be the function variable due to call tracing (see below).
If you need to 100% always be sure that you are getting the function name or variable use the :code:`DFUNC` or :code:`DEFUNC` macros.
For example :code:`QUOTE(FUNC(face)) == "achilles_balls_fnc_face"` would be an illegal use of :code:`FUNC` inside :code:`QUOTE`.

Using :code:`FUNC` or :code:`EFUNC` inside a :code:`QUOTE` macro is fine if the intention is for it to be executed as a function.

:code:`LINKFUNC` macro allows to recompile function used in event handler code when function cache is disabled, e.g. :code:`player addEventHandler ["Fired", LINKFUNC(firedEH)];` will run updated code after each recompile.

2.1.1. :code:`FUNC` macros, call tracing and non-Achilles/anonymous functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Achilles implements a basic call tracing system that can dump the call stack on errors or wherever you want.
To do this the :code:`FUNC` macros in debug mode will expand out to include metadata about the call including line numbers and files.
This functionality is automatic with the use of calls via :code:`FUNC` and :code:`EFUNC`, but any calls to other functions need to use the following macros.

+------------------------------------------------+------------------------------------------------------------------------------+
| Macros                                         | Expands to                                                                   |
+================================================+==============================================================================+
| :code:`CALLSTACK(functionName)`                | :code:`[] call CALLSTACK(cba_fnc_someFunction)`                              |
+------------------------------------------------+------------------------------------------------------------------------------+
| :code:`CALLSTACK_NAMED(function,functionName)` | :code:`[] call CALLSTACK_NAMED(_anonymousFunction,'My anonymous function!')` |
+------------------------------------------------+------------------------------------------------------------------------------+

These macros will call these functions with the appropriate wrappers and enable call logging into them (but to no further calls inside obviously).

2.2. General purpose macros
^^^^^^^^^^^^^^^^^^^^^^^^^^^

`CBA script_macros_common.hpp <https://github.com/CBATeam/CBA_A3/blob/master/addons/main/script_macros_common.hpp>`_

:code:`QUOTE` is utilized within configuration files for bypassing the quote issues in configuration macros.
So, all code segments inside a given config should utilize wrapping in the :code:`QUOTE` macro instead of direct strings.
This allows us to use our macros inside the string segments, such as :code:`QUOTE(_this call FUNC(balls))`.

2.2.1. :code:`setVariable`, :code:`getVariable` family macros
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. note::
    These macros are allowed but are not enforced.

+----------------------------------------+-------------------------------------------------------------+
|       Macros                           |          Expands to                                         |
+========================================+=============================================================+
| :code:`GETVAR(player,MyVarName,false)` | :code:`player getVariable ["MyVarName", false]`             |
+----------------------------------------+-------------------------------------------------------------+
| :code:`GETMVAR(MyVarName,objNull)`     | :code:`missionNamespace getVariable ["MyVarName", objNull]` |
+----------------------------------------+-------------------------------------------------------------+
| :code:`GETUVAR(MyVarName,displayNull)` | :code:`uiNamespace getVariable ["MyVarName", displayNull]`  |
+----------------------------------------+-------------------------------------------------------------+
| :code:`SETVAR(player,MyVarName,127)`   | :code:`player setVariable ["MyVarName", 127]`               |
+----------------------------------------+-------------------------------------------------------------+
| :code:`SETPVAR(player,MyVarName,127)`  | :code:`player setVariable ["MyVarNae", 127, true]`          |
+----------------------------------------+-------------------------------------------------------------+
| :code:`SETMVAR(MyVarName,player)`      | :code:`missionNamespace setVariable ["MyVarName", player]`  |
+----------------------------------------+-------------------------------------------------------------+
| :code:`SETUVAR(MyVarName,_control)`    | :code:`uiNamespace setVariable ["MyVarName", _control]`     |
+----------------------------------------+-------------------------------------------------------------+

2.2.2 :code:`STRING` family macros
""""""""""""""""""""""""""""""""""

Note that you need the strings in module :code:`stringtable.xml` in the correct format:
::

    STR_Achilles_<module>_<string>

Example: :code:`STR_Achilles_Balls_Banana`

Script strings (still requires :code:`localize` to localize the string).

+------------------------------+----------------------------------------+
| Macros                       | Expands to                             |
+==============================+========================================+
| :code:`LSTRING(banana)`      | :code:`"STR_Achilles_balls_banana"`    |
+------------------------------+----------------------------------------+
| :code:`ELSTRING(leg,banana)` | :code:`"STR_Achilles_leg_banana"`      |
+------------------------------+----------------------------------------+

Config strings (requires :code:`$` as the first character):

+------------------------------+----------------------------------------+
| Macros                       | Expands to                             |
+==============================+========================================+
| :code:`CSTRING(banana)`      | :code:`"$STR_Achilles_balls_banana"`   |
+------------------------------+----------------------------------------+
| :code:`ECSTRING(leg,banana)` | :code:`"$STR_Achilles_leg_banana"`     |
+------------------------------+----------------------------------------+

2.2.3. :code:`PATH` family macros
"""""""""""""""""""""""""""""""""

The family of path macros define global paths to files for use within a module.
Please use these to reference files in Achilles.
The macro family expands as follows, for the example of the module 'balls'.

+---------------------------------------+----------------------------------------------------+
| Macros                                | Expands to                                         |
+=======================================+====================================================+
| :code:`PATHOF(data\banana.p3d)`       | :code:`\z\achilles\addons\balls\data\banana.p3d`   |
+---------------------------------------+----------------------------------------------------+
| :code:`QPATHOF(data\banana.p3d)`      | :code:`"\z\achilles\addons\balls\data\banana.p3d"` |
+---------------------------------------+----------------------------------------------------+
| :code:`PATHOEF(leg,data\banana.p3d)`  | :code:`\z\achilles\addons\leg\data\banana.p3d`     |
+---------------------------------------+----------------------------------------------------+
| :code:`QPATHOEF(leg,data\banana.p3d)` | :code:`"\z\achilles\addons\leg\data\banana.p3d"`   |
+---------------------------------------+----------------------------------------------------+

3. Functions
------------

Functions shall be created in the :code:`functions/` subdirectory, named :code:`fnc_functionName.sqf`.
They shall then be indexed via the :code:`PREP(functionName)` macro in the :code:`XEH_preInit.sqf` file.

The :code:`PREP` macro allows for CBA function caching, which drastically speeds up load times.

.. note::
    Beware through that function caching is enabled by default and as such to disable it you need to :code:`#define DISABLE_COMPILE_CACHE` above your :code:`#include "script_components.hpp"` include.

3.1. Headers
^^^^^^^^^^^^

Every function should have a header of the following format as the start of their function file:
::

    /*
    * Author: [Name of Author(s)]
    * [Description]
    *
    * Arguments:
    * 0: The first argument <STRING>
    * 1: The second argument <OBJECT>
    * 2: Multiple input types <STRING|ARRAY|CODE>
    * 3: Optional input <BOOL> (default: true)
    * 4: Optional input with multiple types <CODE|STRING> (default: {true})
    * 5: Not mandatory input <STRING> (default: nil)
    *
    * Return Value:
    * The return value <BOOL>
    *
    * Example:
    * ["something", player] call achilles_common_fnc_myFunction
    *
    * Public: [Yes/No]
    */

.. note::
    This is not the case for inline functions or functions not containing their own file.

3.2. Includes
^^^^^^^^^^^^^

Every function includes the :code:`script_component.hpp` file just below the function header.
Any additional includes or defines must be below this include.

All scripts written must be below this include and any potential additional includes or defines.

3.2.1. Reasoning
""""""""""""""""

This ensures every function starts of in an unfirom way and enforces function documentation.

4. Global variables
-------------------

All global variables are defined in the :code:`XEH_preInit.sqf` file of the component they will be used in with an initial default value.

.. note::
    Exceptions:
        - Dynamically generated global variables.
        - Variables that do not origin from Achilles, such as BI global variables or third party such as CBA.

5. Code style
-------------

To help with some parts of the coding style we commend you get the plugin `EditorConfig <https://editorconfig.org/#download>`_ for your editor.
It will help with correct indentations and deleting trailing spaces.

5.1. Curly bracket placement
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. warning::
    Brace placement is different from the ACE3 standard.

Curly brackets (:code:`{ }`) which enclose a code block will have the first bracket placed a line below the statement in case of :code:`if`, :code:`switch` statements or :code:`while`, :code:`waitUntil` and :code:`for` loops.
The second brace will be placed on the same column as the statement and on a separate line.

- **Opening brace in own line**, same level of identation as keyword.
- Closing brace in own line, same level of identation as keyword.

**Correct:**
::

    class Something : Or
    {
        class Other
        {
            foo = "bar";
        };
    };

**Incorrect:**
::

    class Something: Or {
        class Other {
            foo = "bar";
        };
    };

**Incorrect:**
::

    class Something : Or 
    {
        class Other 
        {
            foo = "bar";
            };
        };

When using :code:`if`/:code:`else`, it is recommended to put :code:`else` on a new line without any brackets:
::

    if (alive player) then
    {
        player setDamage 1;
    }
    else
    {
        hint ":(";
    };

5.1.2. Reasoning
""""""""""""""""

Putting the opening brace on a new line improves readability, even more if it's nested in various levels.
However, it trades code space for better readability which we consider to be a better trade-off.

5.2. Indents
^^^^^^^^^^^^

.. note::
    Indentations consist of 4 spaces. Tabs are not allowed.

Every new scope should be on a new indent.
This will make the code easier to understand and read.
Spaces are not allowed to trial on a line, last character needs to be non-blank.

**Correct:**
::

    call {
        call {
            if (/* condition */) then
            {
                /* code */
            };
        };
    };

**Incorrect:**
::

    call {
            call {
            if (/* condition */) then
            {
                /* code */
            };  
            };
    };

5.3. Inline comments
^^^^^^^^^^^^^^^^^^^^

Inline comments should use :code:`//`.
Usage of :code:`/* */` is allowed for larger comment blocks.

Example:
::

    //// Comment   // < incorrect
    // Comment     // < correct
    /* Comment */  // < correct

5.4. Comments in code
^^^^^^^^^^^^^^^^^^^^^

.. note::
    All code shall be documented by comments that describe what is being done.

This can be doone through the function header and/or inline comments.

Comments within the code shall be used when they are describing a complex and critical section of code or if the subject code does something a certain way because of a specific reason.
Unnecessary comments in the code are not allowed.

**Correct:**
::

    // find the object with the most blood loss
    _highestObject = objNull;
    _highestLoss = -1;
    {
        if ([_x] call EFUNC(medical,getBloodLoss) > _highestLoss) then {
            _highestLoss = [_x] call EFUNC(medical,getBloodLoss);
            _highestObject = _x;
        };
    } foreach _units;

**Correct:**
::

    // Check if the unit is an engineer
    (_object getvariable [QGVAR(engineerSkill), 0] >= 1);

**Incorrect:**
::

    // Get the engineer skill and check if it is above 1
    (_object getvariable [QGVAR(engineerSkill), 0] >= 1);

**Incorrect:**
::

    // Get the variable myValue from the object
    _myValue = _object getvariable [QGVAR(myValue), 0];

**Incorrect:**
::

    // Loop through all units to increase the myvalue variable
    {
        _x setvariable [QGVAR(myValue), (_x getvariable [QGVAR(myValue), 0]) + 1];
    } forEach _units;

5.5. Parentheses around code
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When making use of parentheses (:code:`( )`), use few as possible, if not doing so, you decrease the readability of the code.
Avoid statements such as:
::

    if (! ((_value))) then { };

However, the following is allowed:
::
    
    _value = (_array select 0) select 1;

Any conditions in statements shall always be wrapped around brackets.
::

    if (! _value) then { };
    if (_value) then { };

5.6. Negation operator
^^^^^^^^^^^^^^^^^^^^^^

When using conditions with the negation operator (:code:`!`), we recommend using a space between the value and the operator.

Example:
::

    if (! _myVariable) then { };

This does not affect the comparision operator:
::
    
    if (_myVariable != _myOtherVariable) then { };

5.7. Magic numbers
^^^^^^^^^^^^^^^^^^

There shall be no magic numbers. Any magic number shall be put in a :code:`#define` either at the top of the :code:`.sqf` file (below the header) or in the :code:`script_component.hpp` file in the root directory of the component (recommended) in case it is used in multiple locations.

Magic numbers are any of the following:
    - A constant numerical or text value used to identify a file format or protocol.
    - Distinctive unique values that are unlikely to be mistaken for other meanings.
    - Unique values with unexplained meaning or multiple occurrences which could (preferably) be replaced with named constants.

6. Code standards
-----------------

6.1. Error testing
^^^^^^^^^^^^^^^^^^

If a function returns error information, then that error information will be tested.

6.2. Unreachable code
^^^^^^^^^^^^^^^^^^^^^

There shall be no unreachable code.

6.3. Function parameters
^^^^^^^^^^^^^^^^^^^^^^^^

Parameters of functions must be retrieved through the user of :code:`param` or :code:`params` commands.
If the function is part of the public API, parameters must be checked on allowed data types and values through the usage of above mentioned commands.

Usage of the CBA macro :code:`PARAM_x` or :code:`BIS_fnc_param` is deprecated and not allowed within Achilles.

6.4. Return values
^^^^^^^^^^^^^^^^^^

Functions and code blocks that have a specific return value must be a meaningful return value.
If it has no meaningful return value, then the function should return :code:`nil`.

6.5. Private variables
^^^^^^^^^^^^^^^^^^^^^^

All private variables shall make use of the :code:`private` keyword on initalization.
When declaring a private variable before initalization, usage of the :code:`private ARRAY` syntax is allowed.

Exceptions to this rule are variables obtained from an array, which shall be done with the usage of the :code:`params` command family, which ensures the variable is declared as private.

**Correct:**
::

    private _myVariable = "hello world";

**Correct:**
::

    _myArray params ["_elementOne", "_elementTwo"];

**Incorrect:**
::

    _elementOne = _myArray select 0;
    _elementTwo = _myArray select 1;

6.6. Lines of code
^^^^^^^^^^^^^^^^^^

Any function shall contain no more that 250 lines of code, excluding the function header and any includes.

6.7. Variable declarations
^^^^^^^^^^^^^^^^^^^^^^^^^^

Declarations should be at the smallest feasible scope.

**Correct:**
::

    if (call FUNC(myCondition)) then
    {
        private _areAllAboveTen = true; // <- smallest feasable scope

        {
            if (_x >= 10) then
            {
                _areAllAboveTen = false;
            };
        } forEach _anArray;

        if (_areAllAboveTen) then
        {
            hint "all values are above ten!";
        };
    };

**Incorrect:**
::

    private _areAllAboveTen = true; // <- this is bad, because it can be initialized in the if statement
    if (call FUNC(myCondition)) then
    {
        {
            if (_x >= 10) then
            {
                _areAllAboveTen = false;
            };
        } forEach _anArray;

        if (_areAllAboveTen) then
        {
            hint "all values are above ten!";
        };
    };

6.8. Variable initalization
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Private variables will not be introduced until they can be initalized with meaningful values.

**Correct:**
::

    private _myVariable = [1, 2] select _condition;

**Correct:**
::

    private _myVariable = 0; // good because the value will be used
    {
        _x params ["_value", "_amount"];
        if (_value > 0) then
        {
            _myVariable = _myVariable + _amount;
        };
    } forEach _array;

**Incorrect:**
::

    private _myvariable = 0; // Bad because it is initialized with a zero, but this value does not mean anything
    if (_condition) then
    {
        _myVariable = 1;
    }
    else
    {
        _myvariable = 2;
    };

6.9. Initialization expression in :code:`for` loops
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The initialization expression in a :code:`for` loop shall perform no actions other than to initalize the value of a single :code:`for` loop parameter.

6.10. Increment expression in :code:`for` loops
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The increment expression in a :code:`for` loop shall perform no action other than to change a single loop parameter to the next value for the loop.

6.11. Usage of :code:`getVariable`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When using :code:`getVariable`, there shall either be a default value given in the statement or the return value shall be checked for correct data type as well as the return value.
A default value may not be given after a :code:`nil` check.

**Correct:**
::

    _return = object getVariable ["varName", 0];

**Correct:**
::

    _return = object getVariable "varName";
    if (isNil "_return") exitWith {};

**Incorrect:**
::

    _return = _obj getVariable "varName";
    if (isNil "_return") then { _return = 0; };

6.12. Global variables
^^^^^^^^^^^^^^^^^^^^^^

Global variables should not be used to pass along information from one function to another.
Use arguments instead.

**Correct:**
::

    fnc_example =
    {
        params ["_content"];
        hint _content;
    };

    ["hello my variable"] call fnc_example;

**Incorrect:**
::

    fnc_example =
    {
        hint GVAR(myVariable);
    };

    GVAR(myVariable) = "hello my variable";
    call fnc_example;

6.13. Temporary objects and variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Unnecessary temporary objects or variables should be avoided.

6.14. Commented out code
^^^^^^^^^^^^^^^^^^^^^^^^

Code that is not used (commented out) shall be removed.

6.15. Constant global variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There shall be no constant global variables, constants shall be put in a :code:`#define`.

6.16. Logging
^^^^^^^^^^^^^

Functions shall whenever possible and logical, make use of logging functionality through the logging and debugging macros from CBA and Achilles.

6.17. Constant private variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Constant private variables that are used more than once shall be put in a :code:`#define`.

6.18. Code used more than once
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Any piece of code that could/is used more than once, shall be put in a function and it's separate :code:`.sqf` file, unless this code is less as 5 lines and used only in a `per-frame handler <waitUntil_>`_.

7. Design considerations
------------------------

7.1. Readability vs performance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is a open source project that will have different maintainers over its lifespan.
When writing code, keep in mind that other developers will also need to understand your code.
Balancing readability and performance is a non-black and white subject.

The rule of thumb is:
    - When improving performance of code that sacrifices readability (or vice-versa), first see if the design of the implementation is done in the best way possible.
    - Document that change with the reasoning in the code.

7.2. Scheduled vs unscheduled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note::
    Avoid the usage of scheduled space as much as possible and stay in unscheduled.


This is to provide a smooth experience to the user by guaranteeing code to run when we want it.
See `Performance condsiderations, spawn and execVM <avoid-spawn-exec_>`_ for more information.

This also helps avoid various bugs as a result of unguaranteed execution sequences when running multiple scripts.

7.3. Event driven
^^^^^^^^^^^^^^^^^

All Achilles components shall be implemented in a event driven fashion.
This is done to ensure code only runs when it is required and allows for modularity through low coupling components.

Event handlers in Achilles are implemented through the CBA event system.
They should be used to trigger or allow triggering of specific functionality.

More information on the `CBA events system <https://github.com/CBATeam/CBA_A3/wiki/Custom-Events-System>`_ and `CBA player events <https://github.com/CBATeam/CBA_A3/wiki/Player-Events>`_ pages.

.. warning::
    BI's event handlers (:code:`addEventHandler`, :code:`addMissionEventHandler`) are slow when passing a large code variable.
    Use a short code block that calls the function you want.
    ::

        player addEventHandler ["Fired", FUNC(handleFired)]; // bad
        player addEventHandler ["Fired", {call FUNC(handleFired)}]; // good

7.4. Hashes
^^^^^^^^^^^

When a key value pair is required, make use of the hash implementation from Achilles.

Hashes are a variable type that store key value pairs.
They are not implemented natively in SQF, so there are a number of macros and functions for their usage in Achilles.
If you are unfamiliar with the idea, they are similar in function to :code:`getVariable` / :code:`setVariable` but do not require an object to use.

The following example is a simple usage using our macros which will be explained further below.
::

    _hash = HASHCREATE;
    HASH_SET(_hash,"key","value");

    if (HASH_HASKEY(_hash,"key")) then
    {
        player sideChat format ["val: %1", HASH_GET(_hash,"key"); // will print out "val: value"
    };

    HASH_REM(_hash,"key");

    if (HASH_HASKEY(_hash,"key")) then
    {
        // this will never execute because we removed the hash key/val pair "key"
    };

A description of the above macros is below.

+--------------------------------+---------------------------------------------------------------------------+
| Macros                         | Usage                                                                     |
+================================+===========================================================================+
| :code:`HASHCREATE`             | Used to create an empty hash.                                             |
+--------------------------------+---------------------------------------------------------------------------+
| :code:`HASH_SET(hash,key,val)` | Will set the hash key to that value, a key can be anything, even objects. |
+--------------------------------+---------------------------------------------------------------------------+
| :code:`HASH_GET(hash,key)`     | Will return the value of that key (or :code:`nil` if it doesn't exist).   |
+--------------------------------+---------------------------------------------------------------------------+
| :code:`HASH_HASKEY(hash,key)`  | Will return :code:`true`/:code:`false` if that key exists in the hash.    |
+--------------------------------+---------------------------------------------------------------------------+
| :code:`HASH_REM(hash,key)`     | Will remove that hash key.                                                |
+--------------------------------+---------------------------------------------------------------------------+

7.4.1. Hashlists
""""""""""""""""

A hashlist is an extension of a hash.
It is a list of hashes!

The reason for having this special type of storage container rather than using a normal array is that an array of normal hashes that are similar, will duplicate a large amount of data in their storage of keys.
A hashlist on the other hand, uses a common list of keys and an array of unique value containers.

The following will demonstrate their usage.
::

    _defaultKeys = ["key1", "key2", "key3"];
    // create a new hashlist using the above keys as default
    _hashList = HASHLIST_CREATELIST(_defaultKeys);

    //lets get a blank hash template out of this hashlist
    _hash = HASHLIST_CREATEHASH(_hashList);

    //_hash is now a standard hash...
    HASH_SET(_hash,"key1","1");

    //to store it to the list we need to push it to the list
    HASHLIST_PUSH(_hashList, _hash);

    //now lets get it out and store it in something else for fun
    //it was pushed to an empty list, so it's index is 0
    _anotherHash = HASHLIST_SELECT(_hashList,0);

    // this should print "val: 1"
    player sideChat format["val: %1", HASH_GET(_anotherHash,"key1")];

    //Say we need to add a new key to the hashlist
    //that we didn't initialize it with? We can simply
    //set a new key using the standard HASH_SET macro
    HASH_SET(_anotherHash,"anotherKey","another value");

As you can see above, working with hashlists is fairly simple, a more in depth explanation of the macros is below.

+-------------------------------------------+-----------------------------------------------------------------------------------+
| Macros                                    | Usage                                                                             |
+===========================================+===================================================================================+
| :code:`HASHLIST_CREATELIST(keys)`         | Creats a new hashlist with the default keys, pass :code:`[]` for no default keys. |
+-------------------------------------------+-----------------------------------------------------------------------------------+
| :code:`HASHLIST_CREATEHASH(hashlist)`     | Returns a blank hash template from a hashlist.                                    |
+-------------------------------------------+-----------------------------------------------------------------------------------+
| :code:`HASHLIST_PUSH(hashlist,hash)`      | Pushes a new hash into the end of the list.                                       |
+-------------------------------------------+-----------------------------------------------------------------------------------+
| :code:`HASHLIST_SELECT(hashlist,index)`   | Returns the hash at that index in the list.                                       |
+-------------------------------------------+-----------------------------------------------------------------------------------+
| :code:`HASHLIST_SET(hashlist,index,hash)` | Sets a specific index to that hash.                                               |
+-------------------------------------------+-----------------------------------------------------------------------------------+

.. note::
    Hashes and hashlists are implemented with SQF arrays, and as such, they are passed by reference to other functions.
    Remember to make copies (using the :code:`+` operator) if you intend for the hash or hashlist to be modified with out the need for changing the original value.

8. Performance considerations
-----------------------------

8.1. Adding elements to arrays
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When adding new elements to an array, :code:`pushBack` shall be used instead of the binary addition or :code:`set`.
When adding multiple elements to an array :code:`append` may be used instead.

**Correct:**
::

    _array pushBack _value;

**Correct:**
::

    _array append [1, 2, 3];

**Incorrect:**
::

    _array set [count _array, _value];
    _array = _array + [_value];

When adding an new element to a dynamic location in an array or when the index is pre-calculated, :code:`set` may be used.

When adding multiple elements to an array, the binary addition may be used for the entire addition.

8.2. :code:`createVehicle`
^^^^^^^^^^^^^^^^^^^^^^^^^^

:code:`createVehicle` array shall be used.

8.3. :code:`createVehicle(local)` position
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:code:`createVehicle(local)` used with a non-:code:`[0, 0, 0]` position shall be used, except on :code:`#` objects (e.g. :code:`#lightsource`, :code:`#soundsource`) where empty position search is not performed.

This code requires :math:`\approx 1.00` ms and will be higher with more objects near wanted position:
::

    _vehicle = _type createVehicleLocal _posATL;
    _vehicle setPosATL _posATL;

While this one requires :math:`\approx 0.04` ms:
::

    _vehicle = _type createVehicleLocal [0, 0, 0];
    _vehicle setPosATL _posATL;

8.4. Unscheduled vs scheduled
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All code that has a visible effect for the user or requires time specific guaranteed execution shall be written in unscheduled space.

.. _avoid-spawn-exec:

8.5. Avoid :code:`spawn` and :code:`execVM`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:code:`execVM` and :code:`spawn` are to be avoided wherever possible.

8.6. Empty arrays
^^^^^^^^^^^^^^^^^

When checking if an array is empty :code:`isEqualTo` shall be used.

8.7. :code:`for` loops
^^^^^^^^^^^^^^^^^^^^^^

::

    for "_y" from # to # step # do { ... }

shall be used instead of

::

    for [{ ... }, { ... }, { ... }] do { ... };

whenever possible.

8.8. :code:`while` loops
^^^^^^^^^^^^^^^^^^^^^^^^

While is only allowed when used to preform a unknown finite amount of steps with unknown or variable increments.
Infinite :code:`while` loops are not allowed.

**Correct:**
::

    _original = _object getvariable [QGVAR(value), 0];

    while {_original < _weaponThreshold} do
    {
        _original = [_original, _weaponClass] call FUNC(getNewValue);
    }

**Incorrect:**
::

    while {true} do
    {
        // anything
    };


.. _waituntil:

8.9. :code:`waitUntil`
^^^^^^^^^^^^^^^^^^^^^^

The :code:`waitUntil` command shall not be used. Instead, make use of CBA's :code:`CBA_fnc_waitUntilAndExecute`.
::

    [{
    params ["_unit"];
    _unit getVariable [QGVAR(myVariable), false]
    },
    {
        params ["_unit"];
        // Execute any code
    }, [_unit]] call CBA_fnc_waitUntilAndExecute;