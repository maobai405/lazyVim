return {
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "rustfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- local nvim_lsp = require("lspconfig")
      --
      -- opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      --   -- whatever servers and settings you want here
      --   biome = {
      --     enabled = false,
      --     cmd = { "biome", "lsp-proxy" },
      --     filetypes = {
      --       "astro",
      --       "css",
      --       "graphql",
      --       "javascript",
      --       "javascriptreact",
      --       "json",
      --       "jsonc",
      --       "svelte",
      --       "typescript",
      --       "typescript.tsx",
      --       "typescriptreact",
      --       "vue",
      --     },
      --     root_markers = { "biome.json", "biome.jsonc" },
      --     root_dir = function(...)
      --       return nvim_lsp.util.root_pattern("biome.json", "biome.jsonc", "package.json")(...)
      --     end,
      --   },
      --   vtsls = {
      --     enabled = true,
      --   },
      -- })
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
