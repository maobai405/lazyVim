-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local utils = require("utils")
local map = LazyVim.safe_keymap_set

-- 调用easydict翻译快捷键
map({ "n", "v" }, "<leader>mm", function()
  local mode = vim.fn.mode()
  local selected_text = utils.get_text(mode)
  selected_text = utils.encodeURL(selected_text)
  os.execute("open easydict://" .. selected_text)
  vim.api.nvim_input("<Esc>")
end, { desc = "翻译" })

-- 快速查询单词
map("n", "?", "*")

-- 替代^ 跳转到行首
map("n", "<leader>h", "^", { desc = "跳转到行首" })
map("v", "<leader>h", "^", { desc = "跳转到行首" })
-- 替代$ 跳转到行尾
map("n", "<leader>l", "$", { desc = "跳转到行尾" })
map("v", "<leader>l", "$", { desc = "跳转到行尾" })

-- 保存文件
map("n", "<leader>sa", "<cmd>:w<cr>", { desc = "保存文件" })

-- accelerated-jk 加速jk移动
map("n", "j", "<Plug>(accelerated_jk_gj)")
map("n", "k", "<Plug>(accelerated_jk_gk)")

-- 插入模式下移动光标
map("i", "<C-a>", "<End>")
map("i", "<C-i>", "<ESC>^i")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- 插入模式快速退出
map("i", "jk", "<Esc>")
