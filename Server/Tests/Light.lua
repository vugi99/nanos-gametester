Current_Tests = {
    {
        Test_name = "Light create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local li = Light(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                Color(1, 0, 0),
                LightType.Point,
                100,
                250,
                44,
                0,
                5000,
                true,
                true,
                true
            )
            local li2 = Light(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                Color(1, 0, 0),
                LightType.Point,
                100,
                250,
                44,
                0,
                5000,
                true,
                true,
                true
            )
            local li3 = Light(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                Color(1, 0, 0),
                LightType.Point,
                100,
                250,
                44,
                0,
                5000,
                true,
                true,
                true
            )
            if li then
                if li:IsValid() then
                    return {
                        actor = li,
                        actor2 = li2,
                        actor3 = li3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Light",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Light Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Light.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Light Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Light.GetPairs()) do
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