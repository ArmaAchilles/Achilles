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

+-------+--------------+----------+-------------+
| Index | Name         | Type     | Default     |
+=======+==============+==========+=============+
| 0     | Dialog title | `STRING` | Required    |
+-------+--------------+----------+-------------+
| 1     | Controls     | `ARRAY`  | Required    |
+-------+--------------+----------+-------------+
| 2     | On Confirm   | `CODE`   | Required    |
+-------+--------------+----------+-------------+
| 3     | On Cancel    | `CODE`   | :code:`{}`  |
+-------+--------------+----------+-------------+
| 4     | Arguments    | `ANY`    | :code:`[]`  |
+-------+--------------+----------+-------------+

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

+-------+----------------------+-------------------------------+-------------------------------+----------------------------------------------------------------------------------+---------------+
| Index | Name                 | Type                          | Allowed Values                | Description                                                                      | Default       |
+=======+======================+===============================+===============================+==================================================================================+===============+
| 0     | Control              | :code:`STRING`                | :code:`COLOR`                 | Display a checkbox type control.                                                 | Required      |
+-------+----------------------+-------------------------------+-------------------------------+----------------------------------------------------------------------------------+---------------+
| 1     | Display Name         | :code:`STRING`                | Any string.                   | What does the control represent?                                                 | Required      |
+-------+----------------------+-------------------------------+-------------------------------+----------------------------------------------------------------------------------+---------------+
| 2     | Is checked?          | :code:`true` or :code:`false` | :code:`true` or :code:`false` | Should the checkbox be checked?                                                  | :code:`false` |
+-------+----------------------+-------------------------------+-------------------------------+----------------------------------------------------------------------------------+---------------+
| 3     | Force default value? | :code:`BOOL`                  | :code:`true` or :code:`false` | Should the given default value be forced? Should we ignore the last saved value? | :code:`false` |
+-------+----------------------+-------------------------------+-------------------------------+----------------------------------------------------------------------------------+---------------+

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

+-------+----------------------+----------------+-------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| Index | Name                 | Type           | Allowed Values                            | Description                                                                                                    | Default           |
+=======+======================+================+===========================================+================================================================================================================+===================+
| 0     | Control              | :code:`STRING` | :code:`COLOR`                             | Display a color type control.                                                                                  | Required          |
+-------+----------------------+----------------+-------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| 1     | Display Name         | :code:`STRING` | Any string.                               | What does the control represent?                                                                               | Required          |
+-------+----------------------+----------------+-------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| 2     | Default color data   | :code:`ARRAY`  | :code:`[1, 1, 1]` or :code:`[1, 1, 1, 1]` | What should the default color data be? If 4 arguments provided in the array, then it displays an RGBA control. | :code:`[1, 1, 1]` |
+-------+----------------------+----------------+-------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+
| 3     | Force default value? | :code:`BOOL`   | :code:`true` or :code:`false`             | Should the given default value be forced? Should we ignore the last saved value?                               | :code:`false`     |
+-------+----------------------+----------------+-------------------------------------------+----------------------------------------------------------------------------------------------------------------+-------------------+

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

4. On Confirm
-------------

ToDo: Arguments passed to the script onConfirm

5. On Cancel
------------
