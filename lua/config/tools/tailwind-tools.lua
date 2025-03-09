local M = {}

M.keys = {
  { "<leader>tt", "<cmd>TailwindConcealToggle<cr>", { desc = "Tailwindcss 切换Tailwindcss隐藏" } },
  { "<leader>ts", "<cmd>TailwindSort<cr>", { desc = "Tailwindcss 排序" } },
  { "<leader>tj", "<cmd>TailwindNextClass<cr>", { desc = "Tailwindcss 将光标移动到下一个类点" } },
  { "<leader>tk", "<cmd>TailwindPrevClass<cr>", { desc = "Tailwindcss 将光标移动到下一个类点" } },
}

M.config = {
  document_color = {
    enabled = true, -- can be toggled by commands
    kind = "background", -- "inline" | "foreground" | "background"
    inline_symbol = "󰝤 ", -- only used in inline mode
    debounce = 200, -- in milliseconds, only applied in insert mode
  },
  conceal = {
    enabled = false, -- can be toggled by commands
    symbol = "󱏿", -- only a single character is allowed
    highlight = { -- extmark highlight options, see :h 'highlight'
      fg = "#38BDF8",
    },
  },
  custom_filetypes = {}, -- see the extension section to learn how it works
}

return M
