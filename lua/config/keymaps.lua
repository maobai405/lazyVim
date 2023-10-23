-- Keymaps are automatically loaded on the VeryLazy event
-- 默认映射列表查看 https://www.lazyvim.org/keymaps
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Utils = require("utils")
local lazyUtil = require("lazyvim.util")
local map = lazyUtil.safe_keymap_set

-- 调用pot翻译快捷键
map({ "n", "v" }, "<leader>mm", function()
  local mode = vim.fn.mode()
  local selected_text = Utils.get_text(mode)
  -- 替换双引号为转义字符
  selected_text = string.gsub(selected_text, '"', '\\"')
  -- 构建 curl 命令并将输出重定向到/dev/null 避免返回信息干扰
  local curl_command = string.format('curl -X POST -d "%s" 127.0.0.1:60828 > /dev/null 2>&1', selected_text)
  -- 执行 curl 命令
  os.execute(curl_command)
  -- 退出visual模式
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

-- control + shift + h/l 移动tab
map("n", "<leader>bh", "<cmd>BufferLineMovePrev<cr>")
map("n", "<leader>bl", "<cmd>BufferLineMoveNext<cr>")
map("n", "<C-S-H>", "<cmd>BufferLineMovePrev<cr>")
map("n", "<C-S-L>", "<cmd>BufferLineMoveNext<cr>")

-- 禁用默认打开终端快捷键
map("n", "<leader>ft", "")
map("n", "<leader>fT", "")
-- ToggleTerm 终端快捷指令
map("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "打开终端" })
map("i", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "打开终端" })
map("t", "<C-\\>", "<Esc><cmd>ToggleTerm direction=horizontal<cr>", { desc = "关闭终端" })

-- accelerated-jk 加速jk移动
map("n", "j", "<Plug>(accelerated_jk_gj)")
map("n", "k", "<Plug>(accelerated_jk_gk)")

-- 启用基于telescope的flutter指令显示
map("n", "<leader>fl", "<cmd>Telescope flutter commands<cr>", { desc = "显示flutter命令" })
-- 启用基于telescope的fvm指令显示
map("n", "<leader>fvm", "<cmd>Telescope flutter fvm<cr>", { desc = "切换flutter版本" })

-- 配置yazi快捷键
map("n", "<leader>yy", function()
  require("tui-nvim"):new({
    cmd = "yazi --chooser-file=/tmp/tui-nvim --cwd=" .. vim.fn.fnameescape(vim.fn.expand("%:p")),
  })
end, { desc = "打开yazi-dir" })

map("n", "<leader>yz", function()
  require("tui-nvim"):new({
    cmd = "yazi --chooser-file=/tmp/tui-nvim --cwd=" .. vim.fn.fnameescape(vim.fn.expand("%:p:h")),
  })
end, { desc = "打开yazi-当前路径" })

-- lsp相关快捷键
-- vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>", { remap = true, silent = true, desc = "跳转代码定义" })
-- map('n', "gd", "<cmd>Glance definitions<cr>", { desc = "跳转代码定义" })
map("n", "gh", "<cmd>Glance references<cr>", { desc = "显示引用" })


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
