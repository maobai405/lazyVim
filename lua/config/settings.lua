local settings = {}

-- 主题 catppuccin tokyonight synthwave84
settings["theme"] = "catppuccin"
-- 主题风格 latte, frappe, macchiato, mocha
settings["flavour"] = "mocha"
-- 主题背景透明
settings["transparent_background"] = true
-- catppuccin主题调色板
settings["catppuccinPalette"] = require("catppuccin.palettes").get_palette(settings["flavour"])

--在此处设置将在引导过程中安装和配置的调试适配器协议（DAP）客户端。
--检查以下链接以获取所有支持的DAP：
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
---@type string[]
settings["dap_deps"] = {
  "codelldb", -- Rust
}

return settings
