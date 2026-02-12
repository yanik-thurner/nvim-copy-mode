local script_dir = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
package.path = script_dir .. "?.lua;" .. package.path

require("lua.copy-mode")
require("lua.nvim-config")
require("lua.key-bindings")
