Current_Tests = {
    {
        Test_name = "Character create and valid",
        Test_type = "ReturnValuePassedInNextTests",
        Test_func = function()
            local ch = Character(
                Vector(-100, 100, 100.5),
                Rotator(-90, 153, 24.5),
                "nanos-world::SK_Male"
            )
            local ch2 = Character(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SK_Male"
            )
            local ch3 = Character(
                Vector(200, 200, 200),
                Rotator(0, 0, 0),
                "nanos-world::SK_Male"
            )
            if ch then
                if ch:IsValid() then
                    return {
                        actor = ch,
                        actor2 = ch2,
                        actor3 = ch3,
                        Location = Vector(-100, 100, 100.5),
                        Rotation = Rotator(-90, 153, 24.5),
                        a_type = "Character",
                        Scale = Vector(1, 1, 1),
                    }
                end
            end
        end,
    },
    {
        Test_name = "Character Asset Name",
        Test_type = "Return",
        Test_func = function(tbl)
            return tbl.actor:GetMesh() == "nanos-world::SK_Male"
        end,
    },
    {
        Test_name = "Character Is In GetAll",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Character.GetAll()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Character Is In GetPairs",
        Test_type = "Return",
        Test_func = function(tbl)
            for k, v in pairs(Character.GetPairs()) do
                if v == tbl.actor then
                    return true
                end
            end
        end,
    },
    {
        Test_name = "Character Hide Bone",
        Test_type = "Return",
        Test_func = function(tbl)
            local hid = tbl.actor:IsBoneHidden("spine_03")
            tbl.actor:HideBone("spine_03")
            local hid2 = tbl.actor:IsBoneHidden("spine_03")
            tbl.actor:UnHideBone("spine_03")
            local hid3 = tbl.actor:IsBoneHidden("spine_03")
            return (not hid and hid2 and not hid3)
        end,
    },
    {
        Test_name = "Character SetCameraMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local mode = tbl.actor:GetCameraMode()
            tbl.actor:SetCameraMode(CameraMode.FPSOnly)
            local mode2 = tbl.actor:GetCameraMode()
            tbl.actor:SetCameraMode(CameraMode.TPSOnly)
            local mode3 = tbl.actor:GetCameraMode()
            tbl.actor:SetCameraMode(CameraMode.FPSTPS)
            local mode4 = tbl.actor:GetCameraMode()
            return (mode == CameraMode.FPSTPS and mode2 == CameraMode.FPSOnly and mode3 == CameraMode.TPSOnly and mode4 == CameraMode.FPSTPS)
        end,
    },
    {
        Test_name = "Character SetCanCrouch",
        Test_type = "Return",
        Test_func = function(tbl)
            local can_c = tbl.actor:GetCanCrouch()
            tbl.actor:SetCanCrouch(false)
            local can_c2 = tbl.actor:GetCanCrouch()
            tbl.actor:SetCanCrouch(true)
            local can_c3 = tbl.actor:GetCanCrouch()
            return (can_c == true and can_c2 == false and can_c3 == true)
        end,
    },
    {
        Test_name = "Character SetCanAim",
        Test_type = "Return",
        Test_func = function(tbl)
            local can_a = tbl.actor:GetCanAim()
            tbl.actor:SetCanAim(false)
            local can_a2 = tbl.actor:GetCanAim()
            tbl.actor:SetCanAim(true)
            local can_a3 = tbl.actor:GetCanAim()
            return (can_a == true and can_a2 == false and can_a3 == true)
        end,
    },
    {
        Test_name = "Character SetCanSprint",
        Test_type = "Return",
        Test_func = function(tbl)
            local can = tbl.actor:GetCanSprint()
            tbl.actor:SetCanSprint(false)
            local can2 = tbl.actor:GetCanSprint()
            tbl.actor:SetCanSprint(true)
            local can3 = tbl.actor:GetCanSprint()
            return (can == true and can2 == false and can3 == true)
        end,
    },
    {
        Test_name = "Character SetCanGrabProps",
        Test_type = "Return",
        Test_func = function(tbl)
            local can = tbl.actor:GetCanGrabProps()
            tbl.actor:SetCanGrabProps(false)
            local can2 = tbl.actor:GetCanGrabProps()
            tbl.actor:SetCanGrabProps(true)
            local can3 = tbl.actor:GetCanGrabProps()
            return (can == true and can2 == false and can3 == true)
        end,
    },
    {
        Test_name = "Character SetCanPickupPickables",
        Test_type = "Return",
        Test_func = function(tbl)
            local can = tbl.actor:GetCanPickupPickables()
            tbl.actor:SetCanPickupPickables(false)
            local can2 = tbl.actor:GetCanPickupPickables()
            tbl.actor:SetCanPickupPickables(true)
            local can3 = tbl.actor:GetCanPickupPickables()
            return (can == true and can2 == false and can3 == true)
        end,
    },
    {
        Test_name = "Character SetCanPunch",
        Test_type = "Return",
        Test_func = function(tbl)
            local can = tbl.actor:GetCanPunch()
            tbl.actor:SetCanPunch(false)
            local can2 = tbl.actor:GetCanPunch()
            tbl.actor:SetCanPunch(true)
            local can3 = tbl.actor:GetCanPunch()
            return (can == true and can2 == false and can3 == true)
        end,
    },
    {
        Test_name = "Character SetCanDrop",
        Test_type = "Return",
        Test_func = function(tbl)
            local can = tbl.actor:GetCanDrop()
            tbl.actor:SetCanDrop(false)
            local can2 = tbl.actor:GetCanDrop()
            tbl.actor:SetCanDrop(true)
            local can3 = tbl.actor:GetCanDrop()
            return (can == true and can2 == false and can3 == true)
        end,
    },
    {
        Test_name = "Character SetDamageMultiplier",
        Test_type = "Return",
        Test_func = function(tbl)
            tbl.actor:SetDamageMultiplier("spine_03", 5.5)
            local dam = tbl.actor:GetDamageMultiplier("spine_03")
            return (dam == 5.5)
        end,
    },
    {
        Test_name = "Character SetDamageMultiplier",
        Test_type = "Return",
        Test_func = function(tbl)
            tbl.actor:SetDamageMultiplier("spine_03", 5.5)
            local dam = tbl.actor:GetDamageMultiplier("spine_03")
            return (dam == 5.5)
        end,
    },
    {
        Test_name = "Character SetFallDamageTaken",
        Test_type = "Return",
        Test_func = function(tbl)
            local fall = tbl.actor:GetFallDamageTaken()
            tbl.actor:SetFallDamageTaken(6.5)
            local fall2 = tbl.actor:GetFallDamageTaken()
            return (fall == 10 and fall2 == 6.5)
        end,
    },
    {
        Test_name = "Character SetFlyingMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local fl = tbl.actor:GetFlyingMode()
            tbl.actor:SetFlyingMode(true)
            local fl2 = tbl.actor:GetFlyingMode()
            tbl.actor:SetFlyingMode(false)
            local fl3 = tbl.actor:GetFlyingMode()
            return (fl == false and fl2 == true and fl3 == false)
        end,
    },
    {
        Test_name = "Character SetGaitMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local mode = tbl.actor:GetGaitMode()
            tbl.actor:SetGaitMode(GaitMode.Walking)
            local mode2 = tbl.actor:GetGaitMode()
            tbl.actor:SetGaitMode(GaitMode.Sprinting)
            local mode3 = tbl.actor:GetGaitMode()
            tbl.actor:SetGaitMode(GaitMode.None)
            local mode4 = tbl.actor:GetGaitMode()
            return (mode == GaitMode.None and mode2 == GaitMode.Walking and mode3 == GaitMode.Sprinting and mode4 == GaitMode.None)
        end,
    },
    {
        Test_name = "Character SetGravityScale",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetGravityScale()
            tbl.actor:SetGravityScale(-2)
            local g2 = tbl.actor:GetGravityScale()
            return (g == 1 and g2 == -2)
        end,
    },
    {
        Test_name = "Character SetHealth",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetHealth()
            tbl.actor:SetHealth(50)
            local g2 = tbl.actor:GetHealth()
            tbl.actor:SetHealth(100)
            local g3 = tbl.actor:GetHealth()
            return (g == 100 and g2 == 50 and g3 == 100)
        end,
    },
    {
        Test_name = "Character ApplyDamage, Damage multiplier check, event damage",
        Test_type = "WaitForCallBack",
        Test_func = function(tbl, callback, test_id)
            Character.Subscribe("TakeDamage", function(char, damage, bone, dtype, from_direction, instigator, causer)
                Character.Unsubscribe("TakeDamage")
                if (char == tbl.actor) then
                    --print(damage, bone, dtype, from_direction, instigator, tbl.actor:GetHealth())
                    if (damage == 10 and bone == "index_01_r" and dtype == DamageType.Shot and from_direction == Vector(300, 310, -220) and instigator == nil and tbl.actor:GetHealth() == 100) then
                        callback(true, test_id)
                    else
                        callback(false, test_id)
                    end
                else
                    callback(false, test_id)
                end
            end)
            tbl.actor:SetDamageMultiplier("index_01_r", 0.5)
            tbl.actor:ApplyDamage(20, "index_01_r", DamageType.Shot, Vector(300, 310, -220))
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Character SetImpactDamageTaken",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetImpactDamageTaken()
            tbl.actor:SetImpactDamageTaken(46)
            local g2 = tbl.actor:GetImpactDamageTaken()
            return (g == 10 and g2 == 46)
        end,
    },
    {
        Test_name = "Character SetMaxHealth",
        Test_type = "Return",
        Test_func = function(tbl)
            -- Max health means Initial health
            local g = tbl.actor:GetMaxHealth()
            tbl.actor:SetMaxHealth(450)
            local g2 = tbl.actor:GetMaxHealth()
            tbl.actor:SetHealth(100)
            return (g == 100 and g2 == 450)
        end,
    },
    {
        Test_name = "Character GetMovingTo 0,0,0",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetMovingTo()
            return (g == Vector(0, 0, 0))
        end,
    },
    {
        Test_name = "Character GetPlayer nil",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetPlayer()
            return (g == nil)
        end,
    },
    {
        Test_name = "Character SetPunchDamage",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetPunchDamage()
            tbl.actor:SetPunchDamage(43)
            local g2 = tbl.actor:GetPunchDamage()
            return (g == 15 and g2 == 43)
        end,
    },
    {
        Test_name = "Character SetSpeedMultiplier",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetSpeedMultiplier()
            tbl.actor:SetSpeedMultiplier(6)
            local g2 = tbl.actor:GetSpeedMultiplier()
            return (g == 1 and g2 == 6)
        end,
    },
    {
        Test_name = "Character SetStanceMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetStanceMode()
            tbl.actor:SetStanceMode(StanceMode.Proning)
            local g2 = tbl.actor:GetStanceMode()
            return (g == StanceMode.Standing and g2 == StanceMode.Proning)
        end,
    },
    {
        Test_name = "Character GetVehicle nil",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetVehicle()
            return (g == nil)
        end,
    },
    {
        Test_name = "Character SetTeam",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:GetTeam()
            tbl.actor:SetTeam(1)
            local g2 = tbl.actor:GetTeam()
            --print(g, g2)
            return (g == 0 and g2 == 1)
        end,
    },
    {
        Test_name = "Character SetViewMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local mode = tbl.actor:GetViewMode()
            tbl.actor:SetViewMode(ViewMode.FPS)
            local mode2 = tbl.actor:GetViewMode()
            tbl.actor:SetViewMode(ViewMode.TPS1)
            local mode3 = tbl.actor:GetViewMode()
            tbl.actor:SetViewMode(ViewMode.TPS3)
            local mode4 = tbl.actor:GetViewMode()
            tbl.actor:SetViewMode(ViewMode.TPS2)
            local mode5 = tbl.actor:GetViewMode()
            return (mode == ViewMode.TPS2 and mode2 == ViewMode.FPS and mode3 == ViewMode.TPS1 and mode4 == ViewMode.TPS3 and mode5 == ViewMode.TPS2)
        end,
    },
    {
        Test_name = "Character SetWeaponAimMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local mode = tbl.actor:GetWeaponAimMode()
            tbl.actor:SetWeaponAimMode(AimMode.ADS)
            local mode2 = tbl.actor:GetWeaponAimMode()
            tbl.actor:SetWeaponAimMode(AimMode.ZoomedZoom)
            local mode3 = tbl.actor:GetWeaponAimMode()
            tbl.actor:SetWeaponAimMode(AimMode.Zoomed)
            local mode4 = tbl.actor:GetWeaponAimMode()
            tbl.actor:SetWeaponAimMode(AimMode.ZoomedFar)
            local mode5 = tbl.actor:GetWeaponAimMode()
            tbl.actor:SetWeaponAimMode(AimMode.None)
            local mode6 = tbl.actor:GetWeaponAimMode()
            return (mode == AimMode.None and mode2 == AimMode.ADS and mode3 == AimMode.ZoomedZoom and mode4 == AimMode.Zoomed and mode5 == AimMode.ZoomedFar and mode6 == AimMode.None)
        end,
    },
    {
        Test_name = "Character SetRagdollMode",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:IsInRagdollMode()
            tbl.actor:SetRagdollMode(true)
            local g2 = tbl.actor:IsInRagdollMode()
            tbl.actor:SetRagdollMode(false)
            local g3 = tbl.actor:IsInRagdollMode()
            return (g == false and g2 == true and g3 == false)
        end,
    },
    {
        Test_name = "Character SetInvulnerable",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:IsInvulnerable()
            tbl.actor:SetInvulnerable(true)
            local g2 = tbl.actor:IsInvulnerable()
            tbl.actor:SetInvulnerable(false)
            local g3 = tbl.actor:IsInvulnerable()
            return (g == false and g2 == true and g3 == false)
        end,
    },
    {
        Test_name = "Character SetMovementEnabled",
        Test_type = "Return",
        Test_func = function(tbl)
            local g = tbl.actor:IsMovementEnabled()
            tbl.actor:SetMovementEnabled(false)
            local g2 = tbl.actor:IsMovementEnabled()
            tbl.actor:SetMovementEnabled(true)
            local g3 = tbl.actor:IsMovementEnabled()
            return (g == true and g2 == false and g3 == true)
        end,
    },
    

}

for i, v in ipairs(Base_Actor_Tests) do
    if v.Test_name ~= "Actor Gravity" then
        table.insert(Current_Tests, v)
    end
end