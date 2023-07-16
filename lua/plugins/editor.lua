return {
  -- 文件系统 https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = require("config.editor.neo-tree"),
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = require("config.editor.telescope"),
  },

  -- 语法高亮 https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- {
      --   -- 显示代码上下文 https://github.com/nvim-treesitter/nvim-treesitter-context
      --   "nvim-treesitter/nvim-treesitter-context",
      --   opts = require("config.editor.treesitter-context"),
      -- },
      { "p00f/nvim-ts-rainbow" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "mfussenegger/nvim-ts-hint-textobject" },
      { "andymass/vim-matchup" },
      {
        "windwp/nvim-ts-autotag",
        opts = require("config.editor.autotag"),
      },
      {
        "NvChad/nvim-colorizer.lua",
        opts = {},
      },
      {
        "abecodes/tabout.nvim",
        opts = require("config.editor.tabout"),
      },
    },
    opts = require("config.editor.treesitter"),
  },

  -- 加速jk移动 https://github.com/rainbowhxch/accelerated-jk.nvim
  {
    "rainbowhxch/accelerated-jk.nvim",
    -- event = "VeryLazy",
    opts = require("config.editor.accelerated-jk"),
  },

  -- 重命名插件 https://github.com/smjonas/inc-rename.nvim
  -- 需要在noice插件中配置presets = { inc_rename = true }
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },

  -- 多光标插件 https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
}
