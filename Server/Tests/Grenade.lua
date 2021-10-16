Current_Tests = {
    {
        Test_name = "Grenade create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local gr = Grenade(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SM_Grenade_G67",
                "nanos-world::P_Grenade_Special",
                "nanos-world::A_Explosion_Large"
            )
            local gr2 = Grenade(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_Grenade_G67",
                "nanos-world::P_Grenade_Special",
                "nanos-world::A_Explosion_Large"
            )
            local gr3 = Grenade(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_Grenade_G67",
                "nanos-world::P_Grenade_Special",
                "nanos-world::A_Explosion_Large"
            )
            if gr then
                if gr:IsValid() then
                    return {
                        actor = gr,
                        actor2 = gr2,
                        actor3 = gr3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Grenade",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Grenade Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAssetName() == "nanos-world::SM_Grenade_G67"
        end,
    },
    {
        Test_name = "Grenade Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Grenade.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Grenade Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Grenade.GetPairs()) do
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