#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Register a Display to Use the Keyhandler
    (this is just a small Wraper to Make it Easyer to use this System)

    Parameter(s):
    0: Display IDD <Number>

    Returns:
    None
*/

params [["_idd", -1, [0, displayNull]]];
if (_idd isEqualType displayNull || {!isNull (findDisplay _idd)}) then {
    _this call FUNC(addDisplayEventHandler);
} else {
    [{
        _this call FUNC(addDisplayEventHandler);
    }, {
        !(isNull (findDisplay _this))
    }, _idd] call CFUNC(waitUntil);
};
