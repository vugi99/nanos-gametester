
Current_Tests = {
    {
        Test_name = "TextRender create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local tr = TextRender(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "My Awesome Text",
                Vector(1, 1, 1),
                Color(1, 0, 0),
                FontType.OpenSans,
                TextRenderAlignCamera.FaceCamera
            )
            local tr2 = TextRender(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "My Awesome Text",
                Vector(1, 1, 1),
                Color(1, 0, 0),
                FontType.OpenSans,
                TextRenderAlignCamera.FaceCamera
            )
            local tr3 = TextRender(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "My Awesome Text",
                Vector(1, 1, 1),
                Color(1, 0, 0),
                FontType.OpenSans,
                TextRenderAlignCamera.FaceCamera
            )
            if tr then
                if tr:IsValid() then
                    return {
                        actor = tr,
                        actor2 = tr2,
                        actor3 = tr3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "TextRender",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "TextRender Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            print(tbl.actor:GetAssetName())
            return tbl.actor:GetAssetName() == "nanos-world::SK_SUV"
        end,
    },
    {
        Test_name = "TextRender Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(TextRender.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "TextRender Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(TextRender.GetPairs()) do
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