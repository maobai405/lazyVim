return {
  -- 主题 https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = require("config.ui.catppuccin"),
  },

  -- 主题 https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    opts = require("config.ui.tokyonight"),
  },

  -- 主题 https://github.com/LunarVim/synthwave84.nvim
  {
    "lunarvim/synthwave84.nvim",
    opts = {},
  },

  -- 配置框架插件!!! https://github.com/LazyVim/LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = require("config.settings").theme,
    },
  },

  -- 启动页面
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = require("config.ui.dashboard"),
  },

  -- 消息通知 https://github.com/rcarriga/nvim-notify
  {
    "rcarriga/nvim-notify",
    opts = require("config.ui.notify"),
  },

  -- 消息、命令行和弹出菜单的UI https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    opts = require("config.ui.noice"),
  },

  -- buffer栏 https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    after = "catppuccin",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "固定buffer" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "清除所有buffer" },
      { "<A-,>", "<Cmd>BufferLineMovePrev<CR>", desc = "buffer左移" },
      { "<A-.>", "<Cmd>BufferLineMoveNext<CR>", desc = "buffer左移" },
    },
    opts = require("config.ui.bufferline"),
  },

  -- lualine 底部状态栏 https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = require("config.ui.lualine"),
  },

  -- fidget nvim-lsp进度的独立UI https://github.com/j-hui/fidget.nvim
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    event = "LspAttach",
    opts = require("config.ui.fidget"),
  },

  -- 缓冲区的Git集成 https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "CursorHold", "CursorHoldI" },
    opts = require("config.ui.gitsigns"),
  },

  -- 跳转平滑滚动 https://github.com/karb94/neoscroll.nvim
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    opts = require("config.ui.neoscroll"),
  },

  -- 作用域范围 https://github.com/echasnovski/mini.indentscope
  {
    "echasnovski/mini.indentscope",
    event = "LazyFile",
    opts = {
      symbol = "╎",
      draw = {
        animation = function()
          return 40
        end,
      },
    },
  },
}
