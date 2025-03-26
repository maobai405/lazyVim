local M = {}

M.keys = {
  { "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "LSP 修复" } },
  { "gk", "<cmd>Lspsaga hover_doc<cr>" },
  { "gh", "<cmd>Lspsaga finder<cr>", desc = "LSP 显示当前字词的引用" },
  { "gp", "<cmd>Lspsaga peek_definition<cr>", desc = "LSP 预览当前位置代码详情" },
  -- 跳转到定义
  { "gd", "<cmd>Lspsaga goto_definition<cr>" },
  -- 跳转下一条诊断
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
  -- 跳转上一条诊断
  { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
}

M.config = {
  ui = {
    code_action = "🐼",
  },
  lightbulb = {
    enable = false,
  },
}

return M
