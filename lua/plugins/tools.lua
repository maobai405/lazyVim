return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("config.tools.snacks"),
  },
  -- 代码截图
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    opts = require("config.tools.codesnap"),
    keys = {
      { "<leader>cp", "<cmd>CodeSnap<cr>", mode = { "v" }, desc = "代码截图" },
    },
  },

  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    opts = {},
  },

  -- tailwind-tools.nvim https://github.com/luckasRanarison/tailwind-tools.nvim
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    keys = require("config.tools.tailwind-tools").keys,
    opts = require("config.tools.tailwind-tools").config,
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    keys = {
      { "<leader>fp", "<cmd>Telescope flutter commands<cr>", desc = "显示flutter命令面板" },
      { "<leader>flt", "<cmd>FlutterLogToggle<cr>", desc = "切换flutter日志显示" },
      { "<leader>flc", "<cmd>FlutterLogClear<cr>", desc = "清除flutter日志" },
    },
    config = true,
  },
  {
    "NeogitOrg/neogit",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "nvim-mini/mini.pick", -- optional
      "folke/snacks.nvim", -- optional
    },
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },
}
