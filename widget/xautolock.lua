local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local open     = io.open
local tonumber = tonumber

-- xautolock link info
-- lain.widget.xautolock

local function factory(args)
    local xautolock	   = { widget = wibox.widget.textbox() }
    local args	   = args or {}
    local timeout  = args.timeout or 1
    local wififile = args.wififile or "/proc/net/wireless"
    local settings = args.settings or function() end
	
    function xautolock.update()
        helpers.async("ps -C xautolock -o pid=", 
            function (locker)
                pid = locker
            end
        )

        xautolock_status = pid or ""
	    widget = xautolock.widget
	    settings()
    end
	
    helpers.newtimer("xautolock", timeout, xautolock.update)
    
    return xautolock

end -- function factory

return factory
