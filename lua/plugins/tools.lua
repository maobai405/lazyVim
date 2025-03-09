return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("config.tools.snacks"),
  },
  -- 代码截图
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    opts = require("config.tools.codesnap"),
    keys = {
      { "<leader>cp", "<cmd>CodeSnap<cr>", mode = { "v" }, desc = "代码截图" },
    },
  },

  -- tailwind-tools.nvim https://github.com/luckasRanarison/tailwind-tools.nvim
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = require("config.tools.tailwind-tools").keys,
    opts = require("config.tools.tailwind-tools").config,
  },
}
