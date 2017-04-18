function Caffeinator(initial_state)
    local self={}

    function self.reload()
        hs.reload()
    end

    -- menu icon to access Mac's caffeine functions
    local caffeine = hs.menubar.new()
    local modes = {'displayIdle'}
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
        new_state=hs.caffeinate.toggle(modes[1])
        setCaffeineState(new_state)
        setCaffeineDisplay(new_state)
    end

    function setCaffeineState(state)
        for i=1,#modes do
            hs.caffeinate.set(modes[i], state, state)
        end
    end

    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        setCaffeineState(requested_state)
        setCaffeineDisplay(hs.caffeinate.get(modes[1]))
    end

    function self.destroy()
        if caffeine then
            caffeine:delete()
            setCaffeineState(false)
        end
    end

    return self
end
