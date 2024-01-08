-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 自动将 .es6 文件识别为 JavaScript 文件类型
vim.api.nvim_exec(
  [[
		augroup filetypedetect
			au BufNewFile,BufRead *.es6 setfiletype javascript
		augroup END
	]],
  false
)

-- 开启treesitter语法折叠
vim.api.nvim_set_option_value("foldmethod", "expr", {})
vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
