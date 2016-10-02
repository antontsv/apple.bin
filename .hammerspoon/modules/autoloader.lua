function Autoloader()
    local self={}

    local config_dir = os.getenv('HOME') .. '/.homesick/repos/apple.bin/.hammerspoon/'

    function self.reload()
        hs.reload()
    end

    function self.addWatcher(file_path)
        hs.pathwatcher.new(config_dir .. file_path, self.reloadConfig):start()
    end

    function self.loadModule(name, params)
       require ('modules.' .. name)
       self.addWatcher('modules/' .. name .. '.lua')
       return _G[(name:gsub('^%l', string.upper))](params)
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

    hs.hotkey.bind({"ctrl","alt","cmd"}, "R", self.reload)
    self.addWatcher('init.lua')

    return self
end
