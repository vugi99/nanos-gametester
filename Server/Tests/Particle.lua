Current_Tests = {
    {
        Test_name = "Particle create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local pa = Particle(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::P_Explosion",
                false,
                true
            )
            local pa2 = Particle(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::P_Explosion",
                false,
                true
            )
            local pa3 = Particle(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::P_Explosion",
                false,
                true
            )
            if pa then
                if pa:IsValid() then
                    return {
                        actor = pa,
                        actor2 = pa2,
                        actor3 = pa3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Particle",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Particle Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Particle.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Particle Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Particle.GetPairs()) do
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