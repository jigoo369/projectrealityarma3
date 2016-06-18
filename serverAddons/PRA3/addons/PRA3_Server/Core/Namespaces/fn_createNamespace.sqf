#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Create a Location

    Parameter(s):
    None

    Returns:
    Namespace <Location>

    Example:
    -
*/

#define pos [-100000,-100000,-100000]

params [["_isGlobal", false]];

private _ret = if (_isLogic) then {
    private _grp = call CFUNC(getLogicGroup);
    _grp createUnit ["Logic", pos, [], 0, "NONE"];
} else {
    createLocation ["fakeTown", pos, 0, 0];
};


if (isNil QGVAR(allCustomNamespaces)) then {
    GVAR(allCustomNamespaces) = [];
};

GVAR(allCustomNamespaces) pushBack _ret;

_ret
