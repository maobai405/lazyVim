return {
  -- Neovim的本地LSP配置 https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf" },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          local success, util = pcall(require, "lazyvim.util")
          return success and util.has("nvim-cmp")
        end,
      },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   opts = require("config.coding.lsp_signature"),
      -- },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "nvimdev/lspsaga.nvim",
        opts = require("config.coding.lspsaga"),
      },
    },
  },

  -- 通过Lua使用Neovim作为语言服务器 https://github.com/nvimtools/none-ls.nvim
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    opts = function()
      local nulls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nulls.builtins.formatting.stylua.with({
            condition = function(utils)
              return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
          }),
          nulls.builtins.formatting.prettierd.with({
            timeout = 50000,
            env = {
              PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/prettierrc.json"),
            },
          }),
        },
      }
    end,
  },

  -- 代码提示插件 https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = require("config.coding.cmp"),
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
  },

  -- 功能齐全且增强的copilot.vim替代品，包含用于与Github Copilot交互的API https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = require("config.coding.copilot"),
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = require("config.coding.copilot-cmp"),
      },
    },
  },
}
