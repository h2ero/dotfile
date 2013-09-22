function runCmd(cmd)
        local handle = io.popen(cmd)
        local content = handle:read("*a")
        handle:close()
        return content
end

function getVolume()
    return  runCmd("amixer get Master  | sed -n 's/.*P.*\\[\\(.*\\)%\\].*/\\1%/p'")
end

function getIp()
    return runCmd("ifconfig | sed -n  /Bcast/p | awk -F : '{ sub(\"  Bcast\",\"\", $2); print $2 }'")
end
function setVolume(arg)
    os.execute("amixer set Master $(($(amixer get Master  | sed -n 's/.*P.*\\[\\(.*\\)%\\].*/\\1/p')"..arg.."))%")
end
