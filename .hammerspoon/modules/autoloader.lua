function Autoloader()
    local self={}

    function self.reload()
        hs.reload()
    end

    -- watch & reload config automatically if changed
    function self.reloadConfig(files)
        doReload = false
        for _,file in pairs(files) do
            if file:sub(-4) == ".lua" then
                doReload = true
            end
        end
        if doReload then
            self.reload()
        end
    end
    hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", self.reloadConfig):start()
    hs.pathwatcher.new(os.getenv("HOME") .. "/.homesick/repos/apple.bin/.hammerspoon/", self.reloadConfig):start()

    hs.hotkey.bind({"ctrl","alt","cmd"}, "R", self.reload)

    return self
end
