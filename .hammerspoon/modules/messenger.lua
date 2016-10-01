function Messenger()
    local self={}

    self.message = hs.alert.show
 
    -- Simple short-cut to display alerts:
    -- open -g 'hammerspoon://show_alert?text=Nice one!'
    hs.urlevent.bind("show_alert", function(eventName, params)
      if params["text"] then
        self.message(params["text"])
      end
    end)

    return self
end
