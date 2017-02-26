function Caffeinator(initial_state)
    local self={}

    function self.reload()
        hs.reload()
    end

    -- menu icon to access Mac's caffeine functions
    local caffeine = hs.menubar.new()
    local requested_state = initial_state == nil or initial_state

    function setCaffeineDisplay(state)
        local result
        requested_state = state
        if state then
            result = caffeine:setIcon("assets/stay-awake.pdf")
            caffeine:setTooltip("Caffeine is on - Mac won't sleep")
        else
            result = caffeine:setIcon("assets/can-sleep.pdf")
            caffeine:setTooltip("Caffeine is off - Mac is allowed to sleep")
        end
    end

    function caffeineClicked()
        setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
    end

    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        hs.caffeinate.set("displayIdle", requested_state, requested_state)
        setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
    end

    function self.destroy()
        if caffeine then
            caffeine:delete()
            hs.caffeinate.set("displayIdle", false, false)
        end
    end

    return self
end
