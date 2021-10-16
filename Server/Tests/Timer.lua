

Current_Tests = {
    {
        Test_name = "Timeout",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            local start_time = os.clock()
            Timer.SetTimeout(function(str, nb, tbl, func)
                local ds = os.clock() - start_time
                if (str == "hello" and nb == 123 and tbl[1] == "G" and func() == "ghez" and ds > 0.4 and ds < 0.6) then
                    callback(true, test_id)
                else
                    callback(false, test_id)
                end
            end, 500, "hello", 123, {"G"}, function() return "ghez" end)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Timeout Stop",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            local timeout = Timer.SetTimeout(function()
                callback(false, test_id)
            end, 500)
            Timer.ClearTimeout(timeout)
            Timer.SetTimeout(function()
                callback(true, test_id)
            end, 1000)
        end,

        WaitForCallBack_Failed_After_ms = 2000,
    },
    {
        Test_name = "callback test",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            callback(true, test_id)
            Timer.SetTimeout(function()
                callback(false, test_id)
            end, Delay_Between_Tests_ms * 3)
        end,

        WaitForCallBack_Failed_After_ms = Delay_Between_Tests_ms * 3 + 500,
    },
    {
        Test_name = "callback test part 2",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            Timer.SetTimeout(function()
                callback(true, test_id)
            end, Delay_Between_Tests_ms * 3 + 500)
        end,

        WaitForCallBack_Failed_After_ms = Delay_Between_Tests_ms * 3 + 1000,
    },

    {
        Test_name = "Timeout id, interval id",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            local timeout = Timer.SetTimeout(function()
                
            end, 250)
            local interval = Timer.SetInterval(function()
                
            end, 250)
            Timer.ClearTimeout(timeout)
            Timer.ClearInterval(interval)
            if timeout == interval then
                callback(false, test_id)
            else
                callback(true, test_id)
            end
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Timer.IsValid Timeout",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            local timeout = Timer.SetTimeout(function()
                callback(false, test_id)
            end, 250)
            if not Timer.IsValid(timeout) then
                callback(false, test_id)
            end
            Timer.ClearTimeout(timeout)
            if Timer.IsValid(timeout) then
                callback(false, test_id)
            end
            Timer.SetTimeout(function()
                callback(true, test_id)
            end, 600)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
    {
        Test_name = "Timer.IsValid Interval",
        Test_type = "WaitForCallBack",
        Test_func = function(callback, test_id)
            local interval = Timer.SetInterval(function()
                callback(false, test_id)
            end, 250)
            if not Timer.IsValid(interval) then
                callback(false, test_id)
            end
            Timer.ClearInterval(interval)
            if Timer.IsValid(interval) then
                callback(false, test_id)
            end
            Timer.SetTimeout(function()
                callback(true, test_id)
            end, 600)
        end,

        WaitForCallBack_Failed_After_ms = 1000,
    },
}