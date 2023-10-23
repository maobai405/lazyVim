return function()
  local icons = require("lazyvim.config").icons
  local Util = require("lazyvim.util")
  local settings = require("config.settings")

  local function renderOptions()
    if settings.theme == "catppuccin" then
      local catppuccin = require("lualine.themes.catppuccin")
      catppuccin.normal.a.bg = settings.catppuccinPalette.pink

      return {
        theme = catppuccin,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        component_separators = "|",
        section_separators = { left = "", right = "" },
      }
    else
      return {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      }
    end
  end

  return {
    options = renderOptions(),
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "", right = "" },
        },
      },
      lualine_b = {
        {
          "branch",
          separator = { right = "" },
          color = {
            bg = settings.catppuccinPalette.red,
            fg = settings.catppuccinPalette.base,
          },
        },
      },
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        {
          function()
            return require("nvim-navic").get_location()
          end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        },
      },
      lualine_x = {
        {
          function()
            return require("noice").api.status.command.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.command.has()
          end,
          color = Util.ui.fg("Statement"),
        },
        {
          function()
            return require("noice").api.status.mode.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.mode.has()
          end,
          color = Util.ui.fg("Constant"),
        },
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
          end,
          color = Util.ui.fg("Debug"),
        },
        { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.ui.fg("Special") },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
        },
      },
      lualine_y = {
        {
          "progress",
          separator = { left = "" },
          padding = { left = 1, right = 1 },
          color = {
            bg = settings.catppuccinPalette.red,
            fg = settings.catppuccinPalette.base,
          },
        },
        {
          "location",
          separator = { left = "" },
          padding = { left = 1, right = 1 },
          color = {
            bg = settings.catppuccinPalette.red,
            fg = settings.catppuccinPalette.base,
          },
        },
      },
      lualine_z = {
        {
          function()
            return " " .. os.date("%R")
          end,
          separator = { left = "", right = "" },
        },
      },
    },
    extensions = { "neo-tree", "lazy" },
  }
end
