#include "script_component.hpp"

["ace_settingsInitialized", {
    if (!GVAR(enabled)) exitWith {};

    private _filter = "isClass (_x >> 'Components' >> 'TransportPylonsComponent')";
    GVAR(aircraftWithPylons) = (_filter configClasses (configFile >> "CfgVehicles")) apply {configName _x};
    {
        [_x, "init", {
            params ["_aircraft"];

            private _loadoutAction = [
                QGVAR(loadoutAction),
                localize LSTRING(ConfigurePylons),
                "",
                {[_target] call FUNC(showDialog)},
                {
                    private _vehicles = _target nearObjects ["LandVehicle", GVAR(searchDistance) + 10];
                    private _filter = ["transportAmmo", QEGVAR(rearm,defaultSupply)] select (["ace_rearm"] call EFUNC(common,isModLoaded));
                    private _rearmVehicles = {([configFile >> "CfgVehicles" >> typeOf _x >> _filter, "number", 0] call CBA_fnc_getConfigEntry) > 0} count _vehicles;

                    (_rearmVehicles > 0 && {[ace_player, _target] call FUNC(canConfigurePylons)})
                }
            ] call EFUNC(interact_menu,createAction);

            [_aircraft, 0, ["ACE_MainActions"], _loadoutAction] call EFUNC(interact_menu,addActionToObject);
        }, false, [], true] call CBA_fnc_addClassEventHandler;
    } forEach GVAR(aircraftWithPylons);

    [QGVAR(setPylonLoadOutEvent), {
        params ["_aircraft", "_pylonIndex", "_pylon"];
        _aircraft setPylonLoadOut [_pylonIndex, _pylon];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setAmmoOnPylonEvent), {
        params ["_aircraft", "_pylonIndex", "_count"];
        _aircraft setAmmoOnPylon [_pylonIndex, _count];
    }] call CBA_fnc_addEventHandler;

    if (isServer) then {
        GVAR(currentAircraftNamespace) = true call CBA_fnc_createNamespace;
        publicVariable QGVAR(currentAircraftNamespace);

        addMissionEventHandler ["HandleDisconnect", LINKFUNC(handleDisconnect)];
    };
}] call CBA_fnc_addEventHandler;