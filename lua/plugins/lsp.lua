return {
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "rustfmt",
        "prisma-language-server",
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
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "<C-k>", false, mode = { "i" } }
      keys[#keys + 1] = { "<leader>ca", false }
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
