return {
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "fish-lsp",
        "biome",
        "rustfmt",
        "prisma-language-server",
        "tailwindcss-language-server",
        "svelte-language-server",
        "vue-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dart" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        -- TypeScript LSP with relative imports preference
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "shortest", -- 智能选择最短路径
                includePackageJsonAutoImports = "auto",
                importModuleSpecifierEnding = "minimal", -- 不包含文件扩展名
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifier = "shortest",
                includePackageJsonAutoImports = "auto",
                importModuleSpecifierEnding = "minimal", -- 不包含文件扩展名
              },
            },
          },
        },
      })

      opts.servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "<C-k>", false, mode = { "i" } },
            { "gd", false },
            { "gh", false },
            { "<leader>ca", false },
          },
        },
      }
    end,
  },

  -- lsp 操作增强 https://github.com/nvimdev/lspsaga.nvim
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
    keys = require("config.lsp.lspsage").keys,
    opts = require("config.lsp.lspsage").config,
  },
}
