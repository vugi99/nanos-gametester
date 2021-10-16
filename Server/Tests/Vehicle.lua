
Current_Tests = {
    {
        Test_name = "Vehicle create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local veh = Vehicle(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SK_SUV",
                CollisionType.Normal,
                true,
                false,
                false,
                "nanos-world::A_Vehicle_Engine_14"
            )
            local veh2 = Vehicle(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SK_SUV",
                CollisionType.Normal,
                true,
                false,
                false,
                "nanos-world::A_Vehicle_Engine_14"
            )
            local veh3 = Vehicle(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SK_SUV",
                CollisionType.Normal,
                true,
                false,
                false,
                "nanos-world::A_Vehicle_Engine_14"
            )
            if veh then
                if veh:IsValid() then
                    return {
                        actor = veh,
                        actor2 = veh2,
                        actor3 = veh3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Vehicle",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Vehicle Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAssetName() == "nanos-world::SK_SUV"
        end,
    },
    {
        Test_name = "Vehicle Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Vehicle.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Vehicle Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Vehicle.GetPairs()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
}

for i, v in ipairs(Base_Actor_Tests) do
    table.insert(Current_Tests, v)
end