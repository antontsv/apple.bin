function ScreenLockWatcher()
    local self={}

    -- Do some actions upon screen lock/unlock
    -- (including screen saver with password)
    local caffeineUnmute=false
    local caffeineItunesPlayPause=false
    function caffeinateCallback(eventType)
        if (eventType == hs.caffeinate.watcher.screensDidLock) then
            caffeineItunesPlayPause = hs.itunes.isPlaying()
            if caffeineItunesPlayPause then
                hs.itunes.playpause() -- pause playing
            end
            local audioOutput = hs.audiodevice.defaultOutputDevice()
            caffeineUnmute = not audioOutput:muted()
            audioOutput:setMuted(true)
            local sshMgr = os.getenv("HOME") .. "/bin/ssh-agent-ctrl"
            local attr = hs.fs.attributes(sshMgr,"mode")
            if attr == "file" then
                -- remove all keys from ssh-agent
                hs.task.new(sshMgr,
                    function() end,
                    function() return false end,
                    {"-d"}):start()
            end
        elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
            if caffeineUnmute then
                hs.audiodevice.defaultOutputDevice():setMuted(false)
            end
            if caffeineItunesPlayPause then
                hs.itunes.playpause() -- resume playing
            end
        end
    end

    caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
    caffeinateWatcher:start()

    return self
end
