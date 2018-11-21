function ModuleLoader(dir)
    local self={}

    local config_dir = os.getenv('HOME') .. '/.homesick/repos/apple.bin/.hammerspoon/'
    self.module_dir = dir

    function self.reload()
        hs.reload()
    end

    -- watch & reload config fully or partically if something changed
    function self.addWatcher(file_path, callback)
        if callback == nil then
            hs.pathwatcher.new(config_dir .. file_path, self.reload):start()
        else
            hs.pathwatcher.new(config_dir .. file_path, callback):start()
        end
    end

    local loaded_modules = {}

    function self.loadModule(name, params)
        if loaded_modules[name] then
            return loaded_modules[name].instance
        end
        require (self.module_dir .. '.' .. name)
        loaded_module = _G[(name:gsub('^%l', string.upper))](params)
        self.addWatcher(self.module_dir .. '/' .. name .. '.lua', function() reloadModule(name) end)
        loaded_modules[name] = {instance = loaded_module, init_params = params}
        return loaded_module
    end

    function reloadModule(name)
        if loaded_modules[name] and loaded_modules[name].instance.destroy then
            loaded_modules[name].instance.destroy()
        end
        cur_dir = hs.fs.currentDir()
        hs.fs.chdir(config_dir)
        combined_name = self.module_dir .. '.' .. name
        package.loaded[combined_name] = nil
        require (combined_name)
        loaded_module = _G[(name:gsub('^%l', string.upper))](loaded_modules[name].init_params)
        loaded_modules[name].instance = loaded_module
        hs.alert.show ('Reloaded ' .. name)
        hs.fs.chdir(cur_dir)
    end

    hs.hotkey.bind({'ctrl','alt','cmd'}, 'R', self.reload)
    self.addWatcher('init.lua')

    return self
end
