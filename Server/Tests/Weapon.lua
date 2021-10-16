
Current_Tests = {
    {
        Test_name = "Weapon create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local weap = Weapon(Vector(-100, 100, 100.5), Rotator(-90, 153, 24.5), "nanos-world::SK_AK47", CollisionType.Normal, true)
                
            local weap2 = Weapon(Vector(200, 200, 200), Rotator(0, 0, 0), "nanos-world::SK_AK47", CollisionType.Normal, true)
            local weap3 = Weapon(Vector(200, 200, 200), Rotator(0, 0, 0), "nanos-world::SK_AK47", CollisionType.Normal, true)
            if weap then
                if weap:IsValid() then
                    return {
                        actor = weap,
                        actor2 = weap2,
                        actor3 = weap3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Weapon",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Weapon Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAssetName() == "nanos-world::SK_AK47"
        end,
    },
    {
        Test_name = "Weapon Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Weapon.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Weapon Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Weapon.GetPairs()) do
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