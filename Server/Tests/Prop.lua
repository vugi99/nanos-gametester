Current_Tests = {
    {
        Test_name = "Prop create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local prop = Prop(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SM_None"
            )
            local prop2 = Prop(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_None"
            )
            local prop3 = Prop(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_None"
            )
            if prop then
                if prop:IsValid() then
                    return {
                        actor = prop,
                        actor2 = prop2,
                        actor3 = prop3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Prop",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Prop Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAssetName() == "nanos-world::SM_None"
        end,
    },
    {
        Test_name = "Prop Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Prop.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Prop Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Prop.GetPairs()) do
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