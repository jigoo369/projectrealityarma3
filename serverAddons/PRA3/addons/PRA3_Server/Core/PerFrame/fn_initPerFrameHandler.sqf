#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for PFH

    Parameter(s):
    None

    Returns:
    None
*/
if (isNil GVAR(waitArray)) then {
    GVAR(waitArray) = [];
};
if (isNil QGVAR(waitUntilArray)) then {
    GVAR(waitUntilArray) = [];
};
if (isNil QGVAR(perFrameHandlerArray)) then {
    GVAR(perFrameHandlerArray) = [];
};
if (isNil QGVAR(PFHhandles)) then {
    GVAR(PFHhandles) = []
};
if (isNil QGVAR(nextFrameBufferA)) then {
    GVAR(nextFrameBufferA) = [];
};
if (isNil QGVAR(nextFrameBufferB)) then {
    GVAR(nextFrameBufferB) = [];
};
if (isNil QGVAR(nextFrameNo)) then {
    GVAR(nextFrameNo) = diag_frameno;
};
GVAR(deltaTime) = 0;
GVAR(lastFrameTime) = diag_tickTime;
GVAR(OnEachFrameID) = addMissionEventHandler ["EachFrame", {
    PERFORMANCECOUNTER_START(PFHCounter)

    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            if (_function isEqualType "") then {
                _function = (parsingNamespace getVariable [_function, {}]);
            };
            [_args, _handle] call _function;
        };
        nil
    } count GVAR(perFrameHandlerArray);


    // Code Ported from ACE changed by joko // Jonas
    while {!(GVAR(waitArray) isEqualTo []) && {GVAR(waitArray) select 0 select 0 <= time}} do {
        private _entry = GVAR(waitArray) deleteAt 0;
        (_entry select 2) call (_entry select 1);
    };

     {
        if ((_x select 2) call (_x select 1)) then {
            (_x select 2) call (_x select 0);
            GVAR(waitUntilArray) deleteAt (GVAR(waitUntilArray) find _x);
        };
        nil
    } count +GVAR(waitUntilArray);

    //Handle the execNextFrame array:
    {
        (_x select 0) call (_x select 1);
        nil
    } count GVAR(nextFrameBufferA);

    //Swap double-buffer:
    GVAR(nextFrameBufferA) = +GVAR(nextFrameBufferB);
    GVAR(nextFrameBufferB) = [];
    GVAR(nextFrameNo) = diag_frameno + 1;

    // Delta time Describe the time that the last Frame needed to calculate this is required for some One Each Frame Balance Math Calculations
    GVAR(deltaTime) = diag_tickTime - GVAR(lastFrameTime);
    GVAR(lastFrameTime) = diag_tickTime;

    if (getClientState == "GAME FINISHED") then {
        removeMissionEventHandler ["EachFrame", GVAR(OnEachFrameID)];
    };

    PERFORMANCECOUNTER_END(PFHCounter)
}];
