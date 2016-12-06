class ACE_Settings {
    class EGVAR(medical,allowLitterCreation) {
        category = ECSTRING(medical,Category_Medical);
        displayName = CSTRING(allowLitterCreation);
        description = CSTRING(allowLitterCreation_Description);
        typeName = "BOOL";
        value = 1;
    };
    class EGVAR(medical,litterSimulationDetail) {
        category = ECSTRING(medical,Category_Medical);
        displayName = CSTRING(litterSimulationDetail);
        description = CSTRING(litterSimulationDetail_Description);
        typeName = "SCALAR";

        value = 3;
        values[] = {"Off", "Low", "Medium", "High", "Ultra"};
        _values[] = { 0, 50, 100, 1000, 5000 };
    };
    class EGVAR(medical,litterCleanUpDelay) {
        category = ECSTRING(medical,Category_Medical);
        displayName = CSTRING(litterCleanUpDelay);
        description = CSTRING(litterCleanUpDelay_Description);
        typeName = "SCALAR";
        value = 0;
    };
};