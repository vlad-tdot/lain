local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local naughty  = require("naughty")
local open     = io.open
local tonumber = tonumber

-- wifi link info
-- lain.widget.wifi

local function factory(args)
    local wifi	   = { widget = wibox.widget.textbox() }
    local args	   = args or {}
    local timeout  = args.timeout or 1
    local wififile = args.wififile or "/proc/net/wireless"
    local settings = args.settings or function() end
    local showpopup= args.showpopup or "on"
    local notify   = args.notify or "on"
    wifi.notification_preset = args.notification_preset or {
	    fg = white, 
	    bg = 060606, 
	    font = "MonospaceTypewriter 8" 
    }

    function wifi.hide()
	    if not wifi.notification then return end
	    naughty.destroy(wifi.notification)
    end

    function wifi.show(seconds, scr)
        wifi.update()
    	wifi.hide()
        wifi.notification_preset.screen = scr or 1
        
        wifi.notification = naughty.notify({
	    text    = wifi.notification_preset.text,
	    preset  = wifi.nitification_preset,
	    timeout = seconds or 5
        })
    end



    function wifi.update()
      helpers.async("iwgetid -r", 
       function (ssid)
	    local file = open(wififile)
	    local wcontent
	    if file then
	        wcontent = file:read("*all")
	        file:close()
	    end

	    local pattern = " (%-%d+)%."
	    wifi_link = wcontent:match(pattern) or "--"
	    widget = wifi.widget
	    settings()
    	 wifi.notification_preset.text = ssid
       end  -- function (ssid)
      )     -- end helpers.async
     end	-- function wifi.update()
    
    if showpopup == "on" then
        wifi.widget:connect_signal('mouse::enter', function () wifi.show(0) end)
	wifi.widget:connect_signal('mouse::leave', function () wifi.hide() end)
    end		-- if showpopup
    

    helpers.newtimer("wifi", timeout, wifi.update)
    
    return wifi

end -- function factory

return factory

