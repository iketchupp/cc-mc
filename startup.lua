local util = require("common.util")

local BOOTLOADER_VERSION = "0.2"

local println = util.println
local println_ts = util.println_ts

println("MC BOOTLOADER V" .. BOOTLOADER_VERSION)

local exit_code ---@type boolean

println_ts("BOOT> SCANNING FOR APPLICATIONS...")

if fs.exists("rs/startup.lua") then
    -- found reactor-plc application
    println("BOOT> FOUND REFINED STORAGE APPLICATION")
    println("BOOT> EXEC STARTUP")
    exit_code = shell.execute("rs/startup")
else
    -- no known applications found
    println("BOOT> NO MC STARTUP APPLICATION FOUND")
    println("BOOT> EXIT")
    return false
end

if not exit_code then
    println_ts("BOOT> APPLICATION CRASHED")
end

return exit_code
