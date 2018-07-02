local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local naughty  = require("naughty")
local open     = io.open
local tonumber = tonumber

-- xautolock status info
-- lain.widget.xautolock

local function factory(args)
    local xautolock	  = { widget = wibox.widget.textbox() }
    local args	      = args or {}
    local timeout     = args.timeout or 1
    local lockchecker = args.lockchecker or "~/.config/wesome/checklocker.sh"
    local settings    = args.settings or function() end


    function xautolock.update()
      helpers.async("/home/ubuntu/kvantum/.config/checklocker.sh -status", 
        function (pid)
            print("function pid")
            print(pid)
            if pid > 0 then
                xautolock_status = "pid"
            else
                xautolock_status = "NL"
            end
            widget = xautolock.widget
	        settings()
        end
      )
      print("function xautolock.update ")
        xautolock_status = "blah"
    end	-- function xautolock.update()

    helpers.newtimer("xautolock", 1, xautolock.update)
    
    return xautolock

end -- function factory

return factory

