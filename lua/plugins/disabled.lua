-- 统一管理 禁用插件
-- 在vscode模式下对以下插件进行禁用
if vim.g.vscode then
  return {
    -- !!!coding目录
    -- Neovim的本地化LSP配置
    { "neovim/nvim-lspconfig", enabled = false },
    -- 通过Lua使用Neovim作为语言服务器
    { "jose-elias-alvarez/null-ls.nvim", enabled = false },
    -- 代码提示插件
    { "hrsh7th/nvim-cmp", enabled = false },
    -- 功能齐全且增强的copilot.vim替代品
    { "zbirenbaum/copilot.lua", enabled = false },
    
    -- !!! editor目录
    -- 文件树插件
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    -- 文件查找插件
    { "nvim-telescope/telescope.nvim", enabled = false },
    -- 语法高亮
    { "nvim-treesitter/nvim-treesitter", enabled = false },
    -- 重命名插件
    { "smjonas/inc-rename.nvim", enabled = false },
    -- 多光标插件
    { "mg979/vim-visual-multi", enabled = false },
    
    -- !!! tool目录
    -- 显示ranger等tui插件
    { "is0n/tui-nvim", enabled = false },
    -- 项目管理插件
    { "ahmedkhalf/project.nvim", enabled = false },
    -- 终端插件
    { "akinsho/toggleterm.nvim", enabled = false },
    -- 显示代码错误插件插件
    { "folke/trouble.nvim", enabled = false },
    -- 搜索提示栏插件
    { "gelguy/wilder.nvim", enabled = false },
    -- flutter-tools插件
    { "akinsho/flutter-tools.nvim", enabled = false },
    -- run-code插件
    { "CRAG666/code_runner.nvim", enabled = false },
    -- dap插件
    { "mfussenegger/nvim-dap", enabled = false },
    
    -- !!! ui目录
    -- buffer
    { "akinsho/bufferline.nvim", enabled = false },
    -- 底部状态栏
    { "nvim-lualine/lualine.nvi", enabled = false },
    -- lsp渲染进度
    { "j-hui/fidget.nvim", enabled = false },
    
    -- lazyVim自带插件
    -- nvim-spectre 在多个文件中搜索/替换
    { "nvim-pack/nvim-spectre", enabled = false },
      -- nvim-pack/nvim-spectre 自动高亮显示光标下的单词的其他实例。它使用LSP、Treesitter和regexp匹配来查找其他实例。
    { "RRethy/vim-illuminate", enabled = false },
    -- nvim-lspconfig
    { "neovim/nvim-lspconfig", enabled = false },
  }
else
  return {}
end
