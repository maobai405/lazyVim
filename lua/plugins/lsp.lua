return {
  -- lsp,dap,linter,formatter 管理工具 https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- lua
        "shfmt", -- bash, shell
        "css-lsp", -- css 语言服务器
        "html-lsp", -- html 语言服务器
        "prettier", -- html, js, css 格式化
        "biome", -- javascript, javascriptreact, typescript, typescriptreact
        "dart-debug-adapter", -- flutter,dart调试dap
        "unocss-language-server",
        "rust-analyzer",
        "codelldb",
      },
    },
  },

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

  -- 查看函数引用 https://github.com/DNLHC/glance.nvim
  {
    "dnlhc/glance.nvim",
    lazy = true,
    event = "LspAttach",
    opts = require("config.coding.glance"),
  },
}
