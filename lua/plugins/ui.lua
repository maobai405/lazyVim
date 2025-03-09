return {
  -- 主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
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
      variant = "auto",
      dark_variant = "moon",
      styles = {
        transparency = true,
      },
    },
  },

  -- 光标动画 https://github.com/sphamba/smear-cursor.nvim
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      distance_stop_animating = 0.5,
      cursor_color = "#f5c2e7",
      -- cursor_color = "#89dceb",
      stiffness = 0.3,
      trailing_stiffness = 0.1,
      trailing_exponent = 5,
      hide_target_hack = true,
      gamma = 1,
    },
  },
}
