local M = {}

M.keys = {
  { "<leader>sa", false },
}

M.config = {
  winopts = {
    backdrop = 100,
  },
  keymap = {
    fzf = {
      ["tab"] = "down",
      ["shift-tab"] = "up",
    },
  },
}

return M
