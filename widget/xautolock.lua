local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local open     = io.open
local tonumber = tonumber

-- xautolock link info
-- lain.widget.xautolock

local function factory(args)
    local xautolock	   = { widget = wibox.widget.textbox() }
    local args	   = args or {}
    local timeout  = args.timeout or 2
    local wififile = args.wififile or "/proc/net/wireless"
    local settings = args.settings or function() end
	
    function xautolock.update()
	local f = open(wififile)
	local wcontent
	if f then
	    wcontent = f:read("*all")
	    f:close()
	end

	local pattern = " (%-%d+)%."

	
	xautolock_status = wcontent:match(pattern) or "--"
	widget = xautolock.widget
	settings()
    end
	
    helpers.newtimer("xautolock", timeout, xautolock.update)
    
    return xautolock

end -- function factory

return factory
