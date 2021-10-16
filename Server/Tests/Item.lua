Current_Tests = {
    {
        Test_name = "Item create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local it = Item(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SM_Torch",
                CollisionType.Normal,
                true,
                HandlingMode.SingleHandedMelee,
                ""
            )
            local it2 = Item(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_Torch",
                CollisionType.Normal,
                true,
                HandlingMode.SingleHandedMelee,
                ""
            )
            local it3 = Item(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SM_Torch",
                CollisionType.Normal,
                true,
                HandlingMode.SingleHandedMelee,
                ""
            )
            if it then
                if it:IsValid() then
                    return {
                        actor = it,
                        actor2 = it2,
                        actor3 = it3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Item",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Item Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAssetName() == "nanos-world::SM_Torch"
        end,
    },
    {
        Test_name = "Item Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Item.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Item Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Item.GetPairs()) do
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