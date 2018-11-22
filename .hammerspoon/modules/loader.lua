function ModuleLoader(dir)
    local self={}

    local config_dir = os.getenv('HOME') .. '/.hammerspoon/'
    local module_dir = dir

    function self.reload()
        hs.reload()
    end

    -- watch & reload config fully or partically if something changed
    function self.addWatcher(file_path, callback)
        path = hs.fs.pathToAbsolute(config_dir .. file_path)
        if callback == nil then
            hs.pathwatcher.new(path, self.reload):start()
        else
            hs.pathwatcher.new(path, callback):start()
        end
    end

    local loaded_modules = {}
    local _ = {}

    function self.loadModule(name, params)
        if loaded_modules[name] then
            return loaded_modules[name].instance
        end
        require (module_dir .. '.' .. name)
        loaded_module = _G[(name:gsub('^%l', string.upper))](params)
        self.addWatcher(module_dir .. '/' .. name .. '.lua', function() _.reloadModule(name) end)
        loaded_modules[name] = {instance = loaded_module, init_params = params}
        return loaded_module
    end

    function _.reloadModule(name)
        if loaded_modules[name] and loaded_modules[name].instance.destroy then
            loaded_modules[name].instance.destroy()
        end
        cur_dir = hs.fs.currentDir()
        hs.fs.chdir(config_dir)
        combined_name = module_dir .. '.' .. name
        package.loaded[combined_name] = nil
        require (combined_name)
        loaded_module = _G[(name:gsub('^%l', string.upper))](loaded_modules[name].init_params)
        loaded_modules[name].instance = loaded_module
        hs.alert.show ('Reloaded ' .. name)
        hs.fs.chdir(cur_dir)
    end

    hs.hotkey.bind({'ctrl','alt','cmd'}, 'R', self.reload)

    return self
end
