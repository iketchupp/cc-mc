--
-- Refined Storage
--

require("/initenv").init_env()

local crash = require("common.crash")
local log = require("common.log")
local util = require("common.util")

local config = require("rs.config")

local RS_VERSION = "v0.0.1"

local println = util.println
local println_ts = util.println_ts

-----------------------------------------
-- config validation
-----------------------------------------

local cfv = util.new_validator()

cfv.assert_type_str(config.LOG_PATH)
cfv.assert_type_int(config.LOG_MODE)
assert(cfv.valid(), "bad config file: missing/invalid fields")

-----------------------------------------
-- log init
-----------------------------------------

log.init(config.LOG_PATH, config.LOG_MODE, config.LOG_DEBUG == true)

log.info("==================================")
log.info("BOOTING rs.startup " .. RS_VERSION)
log.info("==================================")
println(">> REFINED STORAGE " .. RS_VERSION .. " <<")

crash.set_env("rs", RS_VERSION)

-----------------------------------------
-- main application
-----------------------------------------

local function main()
  local bridge = peripherial.find("rsBridge")
  local monitor = peripherial.find("monitor")

  local craftableItems = bridge.listCraftableItems()

  for _, item in pairs(craftableItems) do
    monitor.write("Craftable: " .. item)
  end
end

if not xpcall(main, crash.handler) then
  crash.exit()
else
  log.close()
end