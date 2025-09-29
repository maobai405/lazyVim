return {
  -- 主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = require("config.ui.catppuccin"),
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto",
      dark_variant = "moon",
      styles = {
        transparency = false,
      },
    },
  },
  {
    "sainnhe/everforest",
    init = function()
      vim.g.everforest_background = "soft"
      -- vim.g.everforest_transparent_background = 1
    end,
  },
}
