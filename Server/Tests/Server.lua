
Current_Tests = {
    {
        Test_name = "Server Version",
        Test_type = "Return",
        Test_func = function()
            local v = Server.GetVersion()
            if (type(v) == "string" and v ~= "") then
                return true
            end
        end,
    },
    {
        Test_name = "Tick Event",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            Server.Subscribe("Tick", function(ds)
                Server.Unsubscribe("Tick")
                if (type(ds) == "number" and ds > 0) then
                    callback(true, test_id)
                else
                    callback(false, test_id)
                end
            end)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
}