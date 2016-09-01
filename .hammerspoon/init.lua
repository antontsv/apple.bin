
-- redshift to 2800K from 20:30->21:30
-- and back to standard 6:30->7:30
hs.redshift.start(2800,'21:00','7:00','1h')

function reloadPlusAlert()
    hs.reload()
    hs.alert.show("Hammerspoon config has been reloaded")
end

--config reloading. manual (from getting started guide):
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    reloadPlusAlert()
end)

-- watch & reload config automatically if changed
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        reloadPlusAlert()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
