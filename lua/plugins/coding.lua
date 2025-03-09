return {
  -- yank upt improve https://github.com/gbprod/yanky.nvim
  {
    "gbprod/yanky.nvim",
    keys = {
      { "gp", mode = { "n", "x" }, false },
    },
  },

  -- 补全 https://github.com/saghen/blink.cmp
  {
    "saghen/blink.cmp",
    opts = require("config.coding.blink"),
  },
}
