local M = {}

M.keys = {
  { "<leader>cp", mode = { "n" }, "<cmd>ClaudeCode<cr>", desc = "切换Claude Code" },
}

M.config = {
  window = {
    position = "vertical",
  },
}

return M
