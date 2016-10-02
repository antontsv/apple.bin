function NightWatcher (params)

    if params == nil then params = {} end

    local self = {
        nightDisplayTemperature = params.nightDisplayTemperature or 2800,
        nightStart = params.nightStart or '21:00',
        nightEnd = params.nightEnd or '7:00'
    }

    -- redshift for default values:
    -- 2800K from 20:30->21:30
    -- and back to standard 6:30->7:30
    hs.redshift.start(self.nightDisplayTemperature,self.nightStart,self.nightEnd,'1h')

    return self
end
