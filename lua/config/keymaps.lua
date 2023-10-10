-- Keymaps are automatically loaded on the VeryLazy event
-- 默认映射列表查看 https://www.lazyvim.org/keymaps
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

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
-- map("n", "<leader>bh", "<cmd>BufferLineMovePrev<cr>")
-- map("n", "<leader>bl", "<cmd>BufferLineMoveNext<cr>")
map("n", "<C-S-H>", "<cmd>BufferLineMovePrev<cr>")
map("n", "<C-S-L>", "<cmd>BufferLineMoveNext<cr>")

-- 禁用默认打开终端快捷键
map("n", "<leader>ft", "")
map("n", "<leader>fT", "")
-- ToggleTerm 终端快捷指令
map("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "打开终端" })
map("i", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "打开终端" })
map("t", "<C-\\>", "<Esc><cmd>ToggleTerm direction=horizontal<cr>", { desc = "关闭终端" })

-- 修改lazygit显示大小
map("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, {
    size = {
      width = 1,
      height = 1,
    },
  })
end, { desc = "Lazygit (root dir)" })

-- accelerated-jk 加速jk移动
map("n", "j", "<Plug>(accelerated_jk_gj)")
map("n", "k", "<Plug>(accelerated_jk_gk)")

-- 启用基于telescope的flutter指令显示
map("n", "<leader>fl", "<cmd>Telescope flutter commands<cr>", { desc = "显示flutter命令" })
-- 启用基于telescope的fvm指令显示
map("n", "<leader>fvm", "<cmd>Telescope flutter fvm<cr>", { desc = "切换flutter版本" })

-- 配置ranger快捷键
map("n", "<leader>rr", function()
  require("tui-nvim"):new({
    cmd = "ranger --choosefiles=/tmp/tui-nvim --selectfile=" .. vim.fn.fnameescape(vim.fn.expand("%:p")),
  })
end, { desc = "打开ranger" })

if vim.g.vscode then
  -- 禁用LazyGit
  vim.api.nvim_set_keymap("n", "<leader>gg", "<Nop>", { noremap = true })

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
