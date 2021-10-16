
Base_Actor_Tests = {
    {
        Test_name = "Actor GetID",
        Test_type = "Return",
        Test_func = function(tbl)
            local id = tbl.actor:GetID()
            return (id and id > 0 and type(id) == "number")
        end,
    },
    {
        Test_name = "Actor GetLocation",
        Test_type = "Return",
        Test_func = function(tbl)
            local loc = tbl.actor:GetLocation()
            return loc == Vector(-100, 100, 100.5)
        end,
    },
    {
        Test_name = "Actor SetLocation",
        Test_type = "Return",
        Test_func = function(tbl)
            local newloc = Vector(100, 399, 100)
            tbl.actor:SetLocation(newloc)
            local loc = tbl.actor:GetLocation()
            tbl.actor:SetLocation(tbl.Location)
            return loc == newloc
        end,
    },
    {
        Test_name = "Actor GetRotation",
        Test_type = "Return",
        Test_func = function(tbl)
            local rot = tbl.actor:GetRotation()
            return (rot.Pitch -90 and rot.Yaw == 153 and rot.Roll == 24.5)
        end,
    },
    {
        Test_name = "Actor SetRotation",
        Test_type = "Return",
        Test_func = function(tbl)
            local newrot = Rotator(100, -100, 125)
            tbl.actor:SetRotation(newrot)
            local rot = tbl.actor:GetRotation()
            tbl.actor:SetRotation(tbl.Rotation)
            return (rot.Pitch == newrot.Pitch and rot.Yaw == newrot.Yaw and rot.Roll == newrot.Roll)
        end,
    },
    {
        Test_name = "Actor GetScale",
        Test_type = "Return",
        Test_func = function(tbl)
            local scale = tbl.actor:GetScale()
            return scale == tbl.Scale
        end,
    },
    {
        Test_name = "Actor SetScale",
        Test_type = "Return",
        Test_func = function(tbl)
            local newscale = Vector(2, 3, 2.5)
            tbl.actor:SetScale(newscale)
            local scale = tbl.actor:GetScale()
            tbl.actor:SetScale(tbl.Scale)
            return scale == newscale
        end,
    },
    {
        Test_name = "Actor Gravity",
        Test_type = "Return",
        Test_func = function(tbl)
            tbl.actor:SetGravityEnabled(true)
            local is_1 = tbl.actor:IsGravityEnabled()
            tbl.actor:SetGravityEnabled(false)
            local is_2 = tbl.actor:IsGravityEnabled()
            return (is_1 and not is_2)
        end,
    },
    {
        Test_name = "Actor GetAttachedTo nil",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetAttachedTo() == nil
        end,
    },
    {
        Test_name = "Actor GetAttachedEntities nil",
        Test_type = "Return",
        Test_func = function(tbl)
            return #tbl.actor:GetAttachedEntities() == 0
        end,
    },
    {
        Test_name = "Actor Collision",
        Test_type = "Return",
        Test_func = function(tbl)
            local col_base = tbl.actor:GetCollision()
            tbl.actor:SetCollision(CollisionType.Normal)
            local col0 = tbl.actor:GetCollision()
            tbl.actor:SetCollision(CollisionType.StaticOnly)
            local col1 = tbl.actor:GetCollision()
            tbl.actor:SetCollision(CollisionType.NoCollision)
            local col2 = tbl.actor:GetCollision()
            tbl.actor:SetCollision(col_base)
            return (col0 == CollisionType.Normal and col1 == CollisionType.StaticOnly and col2 == CollisionType.NoCollision)
        end,
    },
    {
        Test_name = "Actor GetType",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.a_type == tbl.actor:GetType()
        end,
    },
    {
        Test_name = "Actor SetValue/GetValue",
        Test_type = "Return",
        Test_func = function(tbl)
            local val = tbl.actor:GetValue("tvalnb")
            tbl.actor:SetValue("tvalnb", 25.5)
            tbl.actor:SetValue("tvalstr", "t")
            tbl.actor:SetValue("tvaltbl", {"t"})
            tbl.actor:SetValue("tvalbool", true)

            local valnb = tbl.actor:GetValue("tvalnb")
            local valstr = tbl.actor:GetValue("tvalstr")
            local valtbl = tbl.actor:GetValue("tvaltbl")
            local valbool = tbl.actor:GetValue("tvalbool")
            return (val == nil and valnb and valnb == 25.5 and valstr == "t" and valtbl and valtbl[1] == "t" and valbool == true)
        end,
    },
    {
        Test_name = "Actor ValueChange",
        Test_type = "WaitForCallBack",
        Test_func = function(tbl, callback, test_id)
            _ENV[tbl.a_type].Subscribe("ValueChange", function(actor, key, value)
                if actor == tbl.actor then
                    _ENV[tbl.a_type].Unsubscribe("ValueChange")
                    if (key == "tvalnbValueChange" and value and value == 25.5) then
                        callback(true, test_id)
                    else
                        callback(false, test_id)
                    end
                    
                end
            end)
            tbl.actor:SetValue("tvalnbValueChange", 25.5)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Actor Attach SnapToTarget Check, Detach Check",
        Test_type = "Return",
        Test_func = function(tbl)
            tbl.actor2:AttachTo(tbl.actor, AttachmentRule.SnapToTarget)
            local loc = tbl.actor2:GetLocation()
            local rot = tbl.actor2:GetRotation()
            local attached_to = tbl.actor2:GetAttachedTo()
            local attached_entities = tbl.actor:GetAttachedEntities()

            tbl.actor2:Detach()
            local attached_to2 = tbl.actor2:GetAttachedTo()
            local attached_entities2 = tbl.actor:GetAttachedEntities()
            return (loc == tbl.Location and rot.Pitch == tbl.Rotation.Pitch and rot.Yaw == tbl.Rotation.Yaw and rot.Roll == tbl.Rotation.Roll and attached_to and attached_to == tbl.actor and attached_entities and #attached_entities == 1 and attached_entities[1] == tbl.actor2 and attached_to2 == nil and #attached_entities2 == 0)
        end,
    },
    {
        Test_name = "Actor Attach, Detach Destroy, Destroy Event",
        Test_type = "WaitForCallBack",
        Test_func = function(tbl, callback, test_id)
            _ENV[tbl.a_type].Subscribe("Destroy", function(actor)
                if actor == tbl.actor2 then
                    _ENV[tbl.a_type].Unsubscribe("Destroy")
                    if actor:IsValid() then
                        callback(true, test_id)
                    else
                        callback(false, test_id)
                    end
                end
            end)
            tbl.actor2:AttachTo(tbl.actor, AttachmentRule.SnapToTarget, "", 1)
            tbl.actor2:Detach()
        end,

        WaitForCallBack_Failed_After_ms = 2000,
    },
    {
        Test_name = "Actor Lifespan, Destroy Event",
        Test_type = "WaitForCallBack",
        Test_func = function(tbl, callback, test_id)
            _ENV[tbl.a_type].Subscribe("Destroy", function(actor)
                if actor == tbl.actor3 then
                    _ENV[tbl.a_type].Unsubscribe("Destroy")
                    if actor:IsValid() then
                        callback(true, test_id)
                    else
                        callback(false, test_id)
                    end
                end
            end)
            tbl.actor3:SetLifeSpan(1)
        end,

        WaitForCallBack_Failed_After_ms = 2000,
    },
    {
        Test_name = "Actor Destroy, Destroy Event",
        Test_type = "WaitForCallBack",
        Test_func = function(tbl, callback, test_id)
            _ENV[tbl.a_type].Subscribe("Destroy", function(actor)
                if actor == tbl.actor then
                    _ENV[tbl.a_type].Unsubscribe("Destroy")
                    if actor:IsValid() then
                        callback(true, test_id)
                    else
                        callback(false, test_id)
                    end
                end
            end)
            tbl.actor:Destroy()
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
}