return {
  -- 主题
  {
    "catppuccin/nvim",
    opts = require("config.ui.catppuccin"),
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "main",
      styles = {
        transparency = true,
      },
    },
  },
}
