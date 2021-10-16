Current_Tests = {
    {
        Test_name = "StaticMesh create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local sm = StaticMesh(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SM_None"
            )
            local sm2 = StaticMesh(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_None"
            )
            local sm3 = StaticMesh(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_None"
            )
            if sm then
                if sm:IsValid() then
                    return {
                        actor = sm,
                        actor2 = sm2,
                        actor3 = sm3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "StaticMesh",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "StaticMesh Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetMesh() == "nanos-world::SM_None"
        end,
    },
    {
        Test_name = "StaticMesh Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(StaticMesh.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "StaticMesh Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(StaticMesh.GetPairs()) do
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