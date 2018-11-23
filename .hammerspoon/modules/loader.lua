
local loaded_modules = {}

function ModuleLoader(dir)
    local self = {}

    local config_dir = os.getenv('HOME') .. '/.hammerspoon/'

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

    function self.loadModule(name, params)
        local module_dir = dir
        local combined_name = module_dir .. '.' .. name
        if loaded_modules[combined_name] then
            return loaded_modules[combined_name].instance
        end
        require (combined_name)
        local loaded_module = _G[(name:gsub('^%l', string.upper))](params)
        self.addWatcher(module_dir .. '/' .. name .. '.lua', function() reloadModule(combined_name) end)
        loaded_modules[combined_name] = {instance = loaded_module, init_params = params, name = name, dir = module_dir}
        return loaded_module
    end

    function reloadModule(combined_name)
        if not loaded_modules[combined_name] then
            hs.alert.show(combined_name)
            return
        end
        if loaded_modules[combined_name].instance.destroy then
            loaded_modules[combined_name].instance.destroy()
        end
        cur_dir = hs.fs.currentDir()
        hs.fs.chdir(config_dir)
        package.loaded[combined_name] = nil
        require (combined_name)
        name = loaded_modules[combined_name].name
        loaded_module = _G[(name:gsub('^%l', string.upper))](loaded_modules[combined_name].init_params)
        loaded_modules[combined_name].instance = loaded_module
        hs.alert.show ('Reloaded ' .. name)
        hs.fs.chdir(cur_dir)
    end

    return self
end
