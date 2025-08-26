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
        transparency = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
}
