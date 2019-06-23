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
                    ["This", "fancy tooltip", "\A3\Data_F\Flags\Flag_AAF_CO.paa", [0, 1, 0, 1]],
                    ["My basic thing"],
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

+----------------------+------------------+--------------------------------------------+-------+
| Name                 | Control Type     | Alternative Control Types                  | Image |
+======================+==================+============================================+=======+
| Checkbox             | :code:`CHECKBOX` | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Color (RGB or RGBA)  | :code:`COLOR`    | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Select dropdown      | :code:`SELECT`   | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Text                 | :code:`TEXT`     | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Side selection       | :code:`SIDES`    | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Slider               | :code:`SLIDER`   | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+
| Block selection      | :code:`BLOCK`    | :code:`BLOCK:YESNO`, :code:`BLOCK:ENABLED` |       |
+----------------------+------------------+--------------------------------------------+-------+
| Vector (2 or 3 axis) | :code:`VECTOR`   | N/A                                        |       |
+----------------------+------------------+--------------------------------------------+-------+

ToDo: Examples for each control and their types

4. On Confirm
-------------

ToDo: Arguments passed to the script onConfirm

5. On Cancel
------------
