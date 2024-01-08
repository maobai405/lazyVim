-- Keymaps are automatically loaded on the VeryLazy "event"
-- 默认映射列表查看 https://www.lazyvim.org/keymaps
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Utils = require("utils")
local lazyUtil = require("lazyvim.util")
local map = lazyUtil.safe_keymap_set

function encodeURL(s)
  s = string.gsub(s, "%.", "-")
  s = string.gsub(s, "([^%w%.%- ])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  return string.gsub(s, " ", "+")
end

-- 调用pot翻译快捷键
map({ "n", "v" }, "<leader>mm", function()
  local mode = vim.fn.mode()
  local selected_text = Utils.get_text(mode)
  selected_text = encodeURL(selected_text)
  os.execute("open easydict://" .. selected_text)
  vim.api.nvim_input("<Esc>")
end, { desc = "翻译" })

-- 快速查询单词
map("n", "?", "*")

-- 打开lazy插件管理面板
map("n", "<leader>l", "")
map("n", "<leader>n", "<cmd>Lazy<cr>", { desc = "打开Lazy面板" })

-- 替代^ 跳转到行首
map("n", "<leader>h", "^", { desc = "跳转到行首" })
map("v", "<leader>h", "^", { desc = "跳转到行首" })
-- 替代$ 跳转到行尾
map("n", "<leader>l", "$", { desc = "跳转到行尾" })
map("v", "<leader>l", "$", { desc = "跳转到行尾" })

-- 禁用默认打开终端快捷键
map("n", "<leader>ft", "")
map("n", "<leader>fT", "")
-- ToggleTerm 终端快捷指令
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "打开终端" })
map("i", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "打开终端" })
map("t", "<C-\\>", "<Esc><cmd>ToggleTerm<cr>", { desc = "关闭终端" })

-- accelerated-jk 加速jk移动
map("n", "j", "<Plug>(accelerated_jk_gj)")
map("n", "k", "<Plug>(accelerated_jk_gk)")

-- 启用基于telescope的flutter指令显示
map("n", "<leader>fl", "<cmd>Telescope flutter commands<cr>", { desc = "显示flutter命令" })
-- 启用基于telescope的fvm指令显示
map("n", "<leader>fvm", "<cmd>Telescope flutter fvm<cr>", { desc = "切换flutter版本" })

-- lsp相关快捷键
-- vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>", { remap = true, silent = true, desc = "跳转代码定义" })
-- map('n', "gd", "<cmd>Glance definitions<cr>", { desc = "跳转代码定义" })
map("n", "gh", "<cmd>Glance references<cr>", { desc = "显示引用" })

-- Code Outline
-- map("n", "<leader>cs", "<cmd>AerialToggle!<cr>", { desc = "启用Code Outline" })

--- Rust 相关快捷键
map("n", "<leader>rcs", "<cmd>RustRun<cr>", { desc = "运行Rust代码" })

if vim.g.vscode then
  -- !!! 调用vscode命令
  -- 打开文件查询面板
  map("n", "<leader>f", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
  map("n", "<leader><leader>", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
  -- 打开lazygit面板
  map("n", "<leader>gg", "<Cmd>call VSCodeNotify('lazygit.openLazygit')<CR>")
  -- 在侧边栏显示当前文件
  map("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<CR>")
  -- 折叠代码
  map("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")
  -- 当前光标word查询
  map("n", "?", "<Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>")

  -- 切换上一个tab
  map("n", "<S-H>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
  -- 切换下一个tab
  map("n", "<S-L>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

  -- run_code
  map("n", "<leader>rc", "<Cmd>call VSCodeNotify('code-runner.run')<CR>")
end
