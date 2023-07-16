local settings = {}

-- 主题 catppuccin tokyonight synthwave84
settings["theme"] = "catppuccin"
-- 主题风格 latte, frappe, macchiato, mocha
settings["flavour"] = "mocha"
-- 主题背景透明
settings["transparent_background"] = true
-- catppuccin主题调色板
settings["catppuccinPalette"] = require("catppuccin.palettes").get_palette(settings["flavour"])

return settings
