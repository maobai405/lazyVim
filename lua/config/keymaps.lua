-- Keymaps are automatically loaded on the VeryLazy event
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

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- 配置ranger快捷键
map("n", "<leader>rr", function()
  require("tui-nvim"):new({
    cmd = "ranger --choosefiles=/tmp/tui-nvim --selectfile=" .. vim.fn.fnameescape(vim.fn.expand("%:p")),
  })
end, { desc = "打开ranger" })
