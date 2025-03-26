return {
  -- 侧边文件列表🌳 https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = require("config.editor.neo-tree"),
  },

  -- 望远镜
  {
    "nvim-telescope/telescope.nvim",
    opts = require("config.editor.telescope").config,
    keys = require("config.editor.telescope").keys,
  },
  {
    "ibhagwan/fzf-lua",
    keys = require("config.editor.fzf").keys,
    opts = require("config.editor.fzf").config,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier", lsp_format = "fallback" },
        typescript = { "prettier", lsp_format = "fallback" },
        javascriptreact = { "prettier", lsp_format = "fallback" },
        typescriptreact = { "prettier", lsp_format = "fallback" },
        rust = { "rustfmt" },
        -- dart = { "dart_format" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        prettier = {
          prepend_args = function(self, ctx)
            -- local util = require("conform.util")
            -- you may want to include all the possible config file names
            -- see https://github.com/stevearc/conform.nvim/blob/46c107ad0e7d83b5a7091112ec2994c847577d32/lua/conform/formatters/prettier.lua#L64-L77
            local config_file = vim.fs.find({ ".prettierrc" }, { upward = true, path = ctx.dirname })[1]
            if config_file then
              return {} -- don't need to return anything because it will pick up the file from the cwd
            else
              return { "--config=" .. vim.fn.expand("~/.config/nvim/.prettierrc") }
            end
          end,
        },
        biome = {
          prepend_args = function(self, ctx)
            local config_file = vim.fs.find({ "biome.json" }, { upward = true, path = ctx.dirname })[1]
            if config_file then
              return {} -- don't need to return anything because it will pick up the file from the cwd
            else
              return { "format", "--config-path=" .. vim.fn.expand("~/.config/nvim") }
            end
          end,
        },
      },
    },
  },

  -- 加速jk移动 https://github.com/rainbowhxch/accelerated-jk.nvim
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = false,
    opts = require("config.editor.accelerated-jk"),
  },

  -- 多光标插件 https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  -- 布尔切换
  {
    "nguyenvukhang/nvim-toggler",
    keys = {
      {
        "<leader>i",
        function()
          require("nvim-toggler").toggle()
        end,
        desc = "切换布尔值",
      },
    },
    opts = {},
  },

  -- 终端 https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    keys = { { "n", "i", "t" }, "<C-\\>", "<cmd>ToggleTerm<cr>" },
    opts = require("config.editor.toggleterm"),
  },

  -- 快捷打开yazi https://github.com/DreamMaoMao/yazi.nvim
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>yz",
        "<cmd>Yazi<cr>",
        desc = "切换布尔值",
      },
    },
  },
}
