

Current_Tests = {
    {
        Test_name = "Sub Event and call",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            Events.Subscribe("TestEvent", function(str, nb, tbl, func)
                Events.Unsubscribe("TestEvent")
                if (str == "hello" and nb == 123 and tbl[1] == "G" and func() == "ghez") then
                    callback(true, test_id)
                else
                    callback(false, test_id)
                end
            end)
            Events.Call("TestEvent", "hello", 123, {"G"}, function() return "ghez" end)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Unsub event and call",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            Events.Subscribe("TestEvent2", function()
                callback(false, test_id)
            end)
            Events.Unsubscribe("TestEvent2")
            Events.Call("TestEvent2")
            Timer.SetTimeout(function()
                callback(true, test_id)
            end, 500)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
}