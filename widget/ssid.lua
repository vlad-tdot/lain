local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local open     = io.open
local tonumber = tonumber

-- ssid link info
-- lain.widget.ssid

local function factory(args)
    local ssid	      = { widget = wibox.widget.textbox() }
    local args	      = args or {}
    local timeout     =  args.timeout or 2
    local ssidcommand = args.ssidcommand or "iwgetid -r"
    local settings    = args.settings or function() end
	
    function ssid.update()
        helpers.async("iwgetid -r", 
            function (iwgetid_result)
                result = iwgetid_result or "--"
            end
        )
    

        ssid_result = result or "--"
	    widget = ssid.widget
	    settings()
    end
	
    helpers.newtimer("ssid", timeout, ssid.update)
    
    return ssid

end -- function factory

return factory
