#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for keyEventhandler

    Parameter(s):
    0: KeyDown Code <Code, String>
    1: KeyDownLoop Code <Code, String>
    2: KeyUp Code <Code, String>
    1: KeyCode <Number> (Ref: https://community.bistudio.com/wiki/ListOfKeyCodes)
    2: Key Attributes <Array>
        0: ctrl <Bool>
        1: alt <Bool>
        2: shift <Bool>

    Returns:
    None
*/
params [
    ["_keyDownCode", "", [{},""]],
    ["_keyDownLoopCode", "", [{},""]],
    ["_keyUpCode", "", [{},""]],

    ["_keyCode", -1, [0]],
    ["_keyAttributes", [false,false,false], [[]], [3]]
];

private _varNameCode = format [QGVAR(keyCode_%1), _keyCode];
private _varNameIDs = format [QGVAR(keyCodeIDs_%1), _keyCode];
private _keyCodes = [GVAR(keyHandler), _varNameCode, []] call CFUNC(getVariableLoc);
private _keyCodeIDs =  [GVAR(keyHandler), _varNameIDs, []] call CFUNC(getVariableLoc);
private _id = _keyCodes pushBack [_keyAttributes, [_keyDownCode, _keyDownLoopCode, _keyUpCode]];
private _publicUID = _keyCodeIDs pushBack _id;

GVAR(keyHandler) setVariable [_varNameCode, _keyCodes];
GVAR(keyHandler) setVariable [_varNameIDs, _keyCodeIDs];

_publicUID
