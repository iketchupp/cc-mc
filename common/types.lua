--
-- Global Types
--

---@class types
local types = {}

-- CLASSES --
---@class coordinate_2d
---@field x number
---@field y number

---@class coordinate
---@field x number
---@field y number
---@field z number

-- create a new coordinate
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return coordinate
function types.new_coordinate(x, y, z) return { x = x, y = y, z = z } end

-- create a new zero coordinate
---@nodiscard
---@return coordinate
function types.new_zero_coordinate() return { x = 0, y = 0, z = 0 } end

-- ALIASES --

---@alias color number

-- STRING TYPES --
--#region

---@alias os_event
---| "alarm"
---| "char"
---| "computer_command"
---| "disk"
---| "disk_eject"
---| "http_check"
---| "http_failure"
---| "http_success"
---| "key"
---| "key_up"
---| "modem_message"
---| "monitor_resize"
---| "monitor_touch"
---| "mouse_click"
---| "mouse_drag"
---| "mouse_scroll"
---| "mouse_up"
---| "paste"
---| "peripheral"
---| "peripheral_detach"
---| "rednet_message"
---| "redstone"
---| "speaker_audio_empty"
---| "task_complete"
---| "term_resize"
---| "terminate"
---| "timer"
---| "turtle_inventory"
---| "websocket_closed"
---| "websocket_failure"
---| "websocket_message"
---| "websocket_success"

--#endregion

return types
