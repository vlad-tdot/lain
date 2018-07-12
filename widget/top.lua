local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local open     = io.open
local tonumber = tonumber

-- top process by cpu info
-- lain.widget.top

local function factory(args)
    local top 	     = { widget = wibox.widget.textbox() }
    local args	     = args or {}
    local timeout    = args.timeout or 5
    local topcommand = args.topcommand or "top -b -n 1 | awk 'NR>7 && NR<9' | awk '{print $12}'"
    local settings   = args.settings or function() end
	
    function top.update()
        helpers.async({"bash", "-c", "top -b -n 1 | awk 'NR>7 && NR<9' | awk '{print $12, $9}'"}, 
            function (top_result1)
                print(top_result1)
                topresult = top_result1 or "--"
            end
        )
    

        top_result = topresult or "--"
        print(topresult)
	    widget = top.widget
	    settings()
    end
	
    helpers.newtimer("top", timeout, top.update)
    
    return top

end -- function factory

return factory
