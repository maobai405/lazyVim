return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gd", false }
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
