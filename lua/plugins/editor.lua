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
}
