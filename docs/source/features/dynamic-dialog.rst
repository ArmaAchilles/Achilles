Dynamic Dialog
==============

.. contents::

A good module needs a GUI. For this purpose we provide a simple to use, but powerful dynamic dialog system.

1. Creating the dialog
----------------------

All dynamic dialogs are created using the :code:`achilles_dialog_fnc_create` function.

Here's an example dialog:

.. code-block:: js
    :linenos:

    [
        "My awesome dialog",
        [
            ["CHECKBOX", "My Checkbox", true],
            ["COLOR", "Red Color", [1, 0, 0]],
            ["COLOR", "Faded Green", [0, 1, 0, 0.5]],
            ["SELECT", ["My Select", "With tooltip!"], [
                ["this", "my", true, "values"],
                [
                    ["My basic thing"],
                    ["This", "fancy tooltip", "\A3\Data_F\Flags\Flag_AAF_CO.paa", [0, 1, 0, 1]],
                    ["Something else"],
                    ["Other values"]
                ],
                1
            ]],
            ["TEXT", "Text Input", ["Default string", {params ["_notSanitized"]; _notSanitized}]],
            ["SIDES", "Your allegiance", east],
            ["SLIDER", "Awesomeness", [0, 10, 5, 2]],
            ["BLOCK:YESNO", "Is Demo?", true],
            ["BLOCK:ENABLED", "Internet status"],
            ["BLOCK", "Fine", [1, ["Dining", "Wine", "Arma"]]],
            ["VECTOR", "What's your", [5, 25]],
            ["VECTOR", "Vector, Victor?", [15, 30, -5]]
        ],
        {
            // On success
            systemChat str _this;
            diag_log _this;
        },
        {
            // On cancel
            systemChat str _this;
            diag_log _this;
        }
    ] call achilles_dialog_fnc_create;

Produces the following dialog:

.. image:: dynamic-dialog-images/1.png
    :alt: Example dialog

2. Function Arguments
---------------------

The arguments for the actual dialog function is pretty simple, however, it can scale up to suit most of your needs.

+--------------+----------------+-------------+
| Name         | Type           | Default     |
+==============+================+=============+
| Dialog title | :code:`STRING` | Required    |
+--------------+----------------+-------------+
| Controls     | :code:`ARRAY`  | Required    |
+--------------+----------------+-------------+
| On Confirm   | :code:`CODE`   | Required    |
+--------------+----------------+-------------+
| On Cancel    | :code:`CODE`   | :code:`{}`  |
+--------------+----------------+-------------+
| Arguments    | :code:`ANY`    | :code:`[]`  |
+--------------+----------------+-------------+

3. Control Arguments
--------------------

Currently, there are 8 different controls for the dynamic dialog.

+----------------------+------------------+--------------------------------------------+
| Name                 | Control Type     | Alternative Control Types                  |
+======================+==================+============================================+
| Checkbox             | :code:`CHECKBOX` | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Color (RGB or RGBA)  | :code:`COLOR`    | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Select dropdown      | :code:`SELECT`   | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Text                 | :code:`TEXT`     | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Side selection       | :code:`SIDES`    | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Slider               | :code:`SLIDER`   | N/A                                        |
+----------------------+------------------+--------------------------------------------+
| Block selection      | :code:`BLOCK`    | :code:`BLOCK:YESNO`, :code:`BLOCK:ENABLED` |
+----------------------+------------------+--------------------------------------------+
| Vector (2 or 3 axis) | :code:`VECTOR`   | N/A                                        |
+----------------------+------------------+--------------------------------------------+

3.1. Checkbox control
^^^^^^^^^^^^^^^^^^^^^

The checkbox control is simple to use and doesn't have a lot of options.

**Arguments:**

+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Name                 | Type                            | Allowed Values                                        | Description                                                                      | Default       |
+======================+=================================+=======================================================+==================================================================================+===============+
| Control              | :code:`STRING`                  | :code:`CHECKBOX`                                      | Display a checkbox type control.                                                 | Required      |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Display Name         | :code:`STRING` or :code:`ARRAY` | :code:`STRING` or :code:`["Display Name", "Tooltip"]` | What does the control represent?                                                 | Required      |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Is checked?          | :code:`BOOL`                    | :code:`BOOL`                                          | Should the checkbox be checked?                                                  | :code:`false` |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Force default value? | :code:`BOOL`                    | :code:`BOOL`                                          | Should the given default value be forced? Should we ignore the last saved value? | :code:`false` |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+

**Example:**

.. code-block:: js
    :linenos:

    ["My Dialog", [
        [
            "CHECKBOX",
            "Is Achilles?",
            true
        ]
    ], {}] call achilles_dialog_fnc_create;

**Result:**

.. image:: dynamic-dialog-images/2.png
    :alt: Checkbox dialog

3.2. Color control
^^^^^^^^^^^^^^^^^^

The color control supports two different types.
RGB *(red-green-blue)* or RGBA *(red-green-blue-alpha)*

There is no specific flag to set.
The dynamic dialog system will automatically set the type depending on the value data array length.

**Arguments:**

+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| Name                 | Type                            | Allowed Values                                        | Description                                                                                                    | Default           |
+======================+=================================+=======================================================+================================================================================================================+===================+
| Control              | :code:`STRING`                  | :code:`COLOR`                                         | Display a color type control.                                                                                  | Required          |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| Display Name         | :code:`STRING` or :code:`ARRAY` | :code:`STRING` or :code:`["Display Name", "Tooltip"]` | What does the control represent?                                                                               | Required          |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| Default color data   | :code:`ARRAY`                   | :code:`[1, 1, 1]` or :code:`[1, 1, 1, 1]`             | What should the default color data be? If 4 arguments provided in the array, then it displays an RGBA control. | :code:`[1, 1, 1]` |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| Force default value? | :code:`BOOL`                    | :code:`BOOL`                                          | Should the given default value be forced? Should we ignore the last saved value?                               | :code:`false`     |
+----------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+

3.2.1. Color RGB
""""""""""""""""

**Example:**

.. code-block:: js
    :linenos:

    ["My Dialog", [
        [
            "COLOR",
            "Blue color",
            [0, 0, 1]
        ]
    ], {}] call achilles_dialog_fnc_create;

**Result:**

.. image:: dynamic-dialog-images/3.png
    :alt: RGB control dialog

3.2.2. Color RGBA
"""""""""""""""""

**Example:**

.. code-block:: js
    :linenos:

    ["My Dialog", [
        [
            "COLOR",
            "Faded Dark Purple",
            [0.5, 0, 0.8, 0.25]
        ]
    ], {}] call achilles_dialog_fnc_create;

**Result:**

.. image:: dynamic-dialog-images/4.png
    :alt: RGBA control dialog

3.3. Select dropdown control
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Select dropdown is a dropdown list control that is very powerful.
It allows for you to set tooltips, images, text colors, etc.

**Arguments:**

+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Name                      | Type                            | Allowed Values                                        | Description                                                                      | Default       |
+===========================+=================================+=======================================================+==================================================================================+===============+
| Control                   | :code:`STRING`                  | :code:`SELECT`                                        | Display a select type control.                                                   | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Display Name              | :code:`STRING` or :code:`ARRAY` | :code:`STRING` or :code:`["Display Name", "Tooltip"]` | What does the control represent?                                                 | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Array of selectable items | :code:`ARRAY`                   | See "`3.3.1. Allowed values`_"                        | Array of selectable elements that will be displayed to the user.                 | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Force default value?      | :code:`BOOL`                    | :code:`BOOL`                                          | Should the given default value be forced? Should we ignore the last saved value? | :code:`false` |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+

**Example:**

.. code-block:: js
    :linenos:

    ["My Dialog", [
        [
            "SELECT",
            [
                "What should we eat tonight?",
                "Pick something delicious!"
            ],
            [
                [
                    ["Flour", "Cheese", "Magic"], "Find it!", false
                ],
                [
                    ["Pizza", "Delicious?"],
                    ["An apple", "Easy!", "\A3\Data_F\Flags\Flag_green_CO.paa", [0, 1, 0, 1]],
                    ["Steak"]
                ],
                1
            ]
        ]
    ], {}] call achilles_dialog_fnc_create;

**Result:**

.. image:: dynamic-dialog-images/5.png
    :alt: Select dropdown control dialog

3.3.1. Allowed values
"""""""""""""""""""""

+-------------------------+---------------------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------+
| Name                    | Type                                                                | Default   | Description                                                                                                                     |
+=========================+=====================================================================+===========+=================================================================================================================================+
| Value array of anything | :code:`ARRAY`                                                       | Required  | Once the user selects an item from the dialog and closes it (OK or Cancel) the selected value will be returned from this array. |
+-------------------------+---------------------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------+
| Array of display values | :code:`ARRAY` (See `display arguments <arguments-for-display_>`_)   | Required  | An array of values that will be displayed to the user.                                                                          |
+-------------------------+---------------------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------+
| Default selected value  | :code:`SCALAR`                                                      | :code:`0` | Allows to select which element will be the default selected one.                                                                |
+-------------------------+---------------------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------+

.. _arguments-for-display:

**Display text arguments:**

Below is a table with arguments for the display content of one element.

+--------------+----------------+----------------------+--------------------------------------------------------------------------+
| Name         | Type           | Default              | Description                                                              |
+==============+================+======================+==========================================================================+
| Display Name | :code:`STRING` | Required             | Dropdown item name to be displayed to the user.                          |
+--------------+----------------+----------------------+--------------------------------------------------------------------------+
| Tooltip Name | :code:`STRING` | :code:`""`           | Tooltip to display when the user moves his mouse over the dropdown item. |
+--------------+----------------+----------------------+--------------------------------------------------------------------------+
| Picture Path | :code:`STRING` | :code:`""`           | Path to the image to be displayed to the left of the display name.       |
+--------------+----------------+----------------------+--------------------------------------------------------------------------+
| Text Color   | :code:`ARRAY`  | :code:`[1, 1, 1, 1]` | The text color for that one dropdown item. **Requires color RGBA**.      |
+--------------+----------------+----------------------+--------------------------------------------------------------------------+

3.4. Text control
^^^^^^^^^^^^^^^^^

The text control is a simple text box that allows users to input data into the box.

**Arguments:**

+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Name                      | Type                            | Allowed Values                                        | Description                                                                      | Default       |
+===========================+=================================+=======================================================+==================================================================================+===============+
| Control                   | :code:`STRING`                  | :code:`TEXT`                                          | Display a select type control.                                                   | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Display Name              | :code:`STRING` or :code:`ARRAY` | :code:`STRING` or :code:`["Display Name", "Tooltip"]` | What does the control represent?                                                 | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Default string to display | :code:`STRING` or :code:`ARRAY` | :code:`STRING` or :code:`["Default Text", {_this}]`   | The default text what should be displayed when the control is first displayed.   | Required      |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+
| Force default value?      | :code:`BOOL`                    | :code:`BOOL`                                          | Should the given default value be forced? Should we ignore the last saved value? | :code:`false` |
+---------------------------+---------------------------------+-------------------------------------------------------+----------------------------------------------------------------------------------+---------------+

Default text has two options:

- Any string.
- Array of default text to display and the sanitize function or code to call.

This sanitize function receives the text the user is currently entering in :code:`_this` variable.
This function is called on each key press in the unscheduled enviornment.

.. warning::
    As this function is called on each key press, it has to be very quick.

**Example:**

.. code-block:: js
    :linenos:

    ["My Dialog", [
        [
            "TEXT",
            "What's the year?",
            "20"
        ]
    ], {}] call achilles_dialog_fnc_create;

**Result:**

.. image:: dynamic-dialog-images/6.png
    :alt: Text control dialog

3.5. Side select control
^^^^^^^^^^^^^^^^^^^^^^^^

3.6. Slider control
^^^^^^^^^^^^^^^^^^^

3.7. Block selection control
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.8. Vector control
^^^^^^^^^^^^^^^^^^^

4. On Confirm and On Cancel
---------------------------

On confirm and on cancel are two different scripts that will be executed depending on the following conditions:

- If the user presses the OK or Cancel buttons.
- If the user presses the Escape key.

When these scripts are called, data is passed in the :code:`_this` variable.

+---------------------------------------------------------+---------------+------------+
| Name                                                    | Type          | Default    |
+=========================================================+===============+============+
| Array of selected values                                | :code:`ARRAY` | N/A        |
+---------------------------------------------------------+---------------+------------+
| Array of arguments (provided when calling the function) | :code:`ARRAY` | :code:`[]` |
+---------------------------------------------------------+---------------+------------+
