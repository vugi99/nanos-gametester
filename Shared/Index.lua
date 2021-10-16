
local Current_Tests_Failed_ALL = 0

Current_Tests = {}
local Current_Tests_Set_Count = 0
local Current_Tests_Set_id = 0
local Current_Tests_Failed = 0
local Current_Tests_Required_Values = {}

local Current_Test_id = 0
local Current_Test_Timeout = 0

local NewTestTimeout = false


Package.Require("Global_Config.lua")

local Require_File_Prefix = ""
if Server then
    Require_File_Prefix = "Server/"
    Package.Require("Server/Config.lua")
else
    Require_File_Prefix = "Client/"
    Package.Require("Client/Config.lua")
end

Package.Require("Base_Actor_Tests.lua")


function table_count(ta)
    local count = 0
    for k, v in pairs(ta) do count = count + 1 end
    return count
end

function NewSetOfTests()
    if Current_Tests_Set_id > 0 then
        Package.Log(tostring(Current_Tests_Set_Count - Current_Tests_Failed) .. "/" .. Current_Tests_Set_Count .. " " .. Tests_To_Do[Current_Tests_Set_id] .. " Tests were succeded")
        Package.Log("--------------------- TEST SET FINISHED ---------------------\n\n")
    end
    Current_Tests_Set_id = Current_Tests_Set_id + 1
    if Tests_To_Do[Current_Tests_Set_id] then
        Package.Require(Require_File_Prefix .. "Tests/" .. Tests_To_Do[Current_Tests_Set_id] .. ".lua")
        Current_Tests_Set_Count = table_count(Current_Tests)
        Current_Tests_Failed = 0
        Current_Test_id = 1
        Current_Tests_Required_Values = {}
        Run_Test()
    else
        if Current_Tests_Failed_ALL > 0 then
            Package.Warn(tostring(Current_Tests_Failed_ALL) .. " Tests were failed")
        else
            Package.Log("No Test was failed")
        end
    end
end

function NextTest(test_success, required_failed)
    if test_success then
        Package.Log(Tests_To_Do[Current_Tests_Set_id] .. " Test '" .. Current_Tests[Current_Test_id].Test_name .. "' (" .. tostring(Current_Test_id) .. "/" .. Current_Tests_Set_Count .. ") Successful")
    else
        Package.Warn(Tests_To_Do[Current_Tests_Set_id] .. " Test '" .. Current_Tests[Current_Test_id].Test_name .. "' (" .. tostring(Current_Test_id) .. "/" .. Current_Tests_Set_Count .. ") Failed")
        Current_Tests_Failed = Current_Tests_Failed + 1
        Current_Tests_Failed_ALL = Current_Tests_Failed_ALL + 1
        if required_failed then
            Package.Error("'" .. Current_Tests[Current_Test_id].Test_name .. "' Test was required for the next ones, next tests of " .. Tests_To_Do[Current_Tests_Set_id] .. " skipped")
        end
    end

    NewTestTimeout = true
    Timer.SetTimeout(function()
        NewTestTimeout = false
        if (Current_Test_id >= Current_Tests_Set_Count or required_failed) then
            NewSetOfTests()
        else
            Current_Test_id = Current_Test_id + 1
            Run_Test()
        end
    end, Delay_Between_Tests_ms)
end

function Run_Test()
    local test = Current_Tests[Current_Test_id]
    if test.Test_type == "Return" then
        local success, tbl_repair = test.Test_func(table.unpack(Current_Tests_Required_Values))
        if test.Test_Repair then
            test.Test_Repair(tbl_repair)
        end
        NextTest(success)
    elseif test.Test_type == "WaitForCallBack" then

        Current_Test_Timeout = Timer.SetTimeout(function()
            if test.Test_Repair then
                test.Test_Repair()
            end
            NextTest(false)
        end, test.WaitForCallBack_Failed_After_ms)

        function for_callback(success, test_id, tbl_repair)
            if (not NewTestTimeout and test_id and test_id == Current_Test_id) then
                Timer.ClearTimeout(Current_Test_Timeout)
                Current_Test_Timeout = 0
                if test.Test_Repair then
                    test.Test_Repair(tbl_repair)
                end
                NextTest(success)
            end
        end

        if #Current_Tests_Required_Values > 0 then
            test.Test_func(table.unpack(Current_Tests_Required_Values), for_callback, Current_Test_id)
        else
            test.Test_func(for_callback, Current_Test_id)
        end
    elseif test.Test_type == "ReturnValuePassedInNextTests" then
        local value_returned = test.Test_func(table.unpack(Current_Tests_Required_Values))
        if (value_returned ~= nil) then
            table.insert(Current_Tests_Required_Values, value_returned)
            NextTest(true)
        else
            NextTest(false, true)
        end
    end
end

if Server then
    Package.Subscribe("Load", function()
        NewSetOfTests()
    end)
else
    Client.Subscribe("SpawnLocalPlayer", function()
        NewSetOfTests()
    end)
end
