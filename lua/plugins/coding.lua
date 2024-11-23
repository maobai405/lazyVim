return {
  {
    "hrsh7th/nvim-cmp",
    opts = require("config.coding.nvim-cmp"),
  },

  -- yank upt improve https://github.com/gbprod/yanky.nvim
  {
    "gbprod/yanky.nvim",
    keys = {
      { "gp", mode = { "n", "x" }, false },
    },
  },
}
