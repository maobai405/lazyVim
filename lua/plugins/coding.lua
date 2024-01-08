return {

  -- 代码提示插件 https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
      {
        "L3MON4D3/LuaSnip",
        opts = require("config.coding.luasnip"),
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      { "onsails/lspkind.nvim" },
      { "lukas-reineke/cmp-under-comparator" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "andersevenrud/cmp-tmux" },
      { "hrsh7th/cmp-path" },
      { "f3fora/cmp-spell" },
      { "hrsh7th/cmp-buffer" },
      { "kdheepak/cmp-latex-symbols" },
      { "ray-x/cmp-treesitter" },
    },
    opts = require("config.coding.cmp"),
  },

  -- 代码大纲code outline https://github.com/stevearc/aerial.nvim
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = require("config.coding.aerial").keys,
    opts = require("config.coding.aerial").config,
  },

  -- 功能齐全且增强的copilot.vim替代品，包含用于与Github Copilot交互的API https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = require("config.coding.copilot-cmp"),
      },
    },
    opts = require("config.coding.copilot"),
  },
}
