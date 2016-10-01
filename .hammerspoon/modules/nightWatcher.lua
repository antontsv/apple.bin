function NightWatcher (
    nightDisplayTemperature,
    nightStart,
    nightEnd
)
    local self = {
        nightDisplayTemperature = nightDisplayTemperature or 2800,
        nightStart = nightStart or '21:00',
        nightEnd = nightEnd or '7:00'
    }

    -- redshift for default values:
    -- 2800K from 20:30->21:30
    -- and back to standard 6:30->7:30
    hs.redshift.start(self.nightDisplayTemperature,self.nightStart,self.nightEnd,'1h')

    return self
end
