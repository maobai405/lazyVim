return {
  -- tui-nvim 直接在Neovim内部支持任何TUI https://github.com/is0n/tui-nvim
  {
    "is0n/tui-nvim",
    opts = require("config.tool.tui-nvim"),
  },

  -- 项目管理 https://github.com/ahmedkhalf/project.nvim
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
  },

  -- 终端 https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
      "ToggleTermSendVisualLines",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualSelection",
    },
    opts = require("config.tool.toggleterm"),
  },

  -- 显示代码错误 https://github.com/abecodes/tabout.nvim
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    opts = require("config.tool.trouble"),
  },

  -- 搜索提示栏 https://github.com/gelguy/wilder.nvim
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    opts = require("config.tool.wilder"),
    dependencies = { "romgrk/fzy-lua-native" },
  },

  -- 快捷打开yazi https://github.com/DreamMaoMao/yazi.nvim
  {
    "DreamMaoMao/yazi.nvim",
    keys = {
      { "<leader>yy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- ChatGPT.nvim https://github.com/jackMort/ChatGPT.nvim
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   opts = require("config.tool.chatgpt"),
  -- },

  ----------------------------------------------------------------------
  --                           DAP Plugins                            --
  ----------------------------------------------------------------------
  -- {
  --   "mfussenegger/nvim-dap",
  --   lazy = true,
  --   cmd = {
  --     "DapSetLogLevel",
  --     "DapShowLog",
  --     "DapContinue",
  --     "DapToggleBreakpoint",
  --     "DapToggleRepl",
  --     "DapStepOver",
  --     "DapStepInto",
  --     "DapStepOut",
  --     "DapTerminate",
  --   },
  --   dependencies = {
  --     {
  --       "rcarriga/nvim-dap-ui",
  --       keys = require("config.tool.dap.dap-ui").keys,
  --       config = require("config.tool.dap.dap-ui").config,
  --     },
  --     { "jay-babu/mason-nvim-dap.nvim" },
  --   },
  --   keys = require("config.tool.dap.nvim-dap").keys,
  --   config = require("config.tool.dap.nvim-dap").config,
  -- },

  ----------------------------------------------------------------------
  --                           Flutter Plugins                        --
  ----------------------------------------------------------------------
  -- https://github.com/akinsho/flutter-tools.nvim
  {
    "akinsho/flutter-tools.nvim",
    event = "BufReadPost",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
      "RobertBrunhage/flutter-riverpod-snippets",
    },
    lazy = false,
    opts = require("config.tool.flutter-tools"),
  },

  -- 运行代码插件 https://github.com/CRAG666/code_runner.nvim
  {
    "CRAG666/code_runner.nvim",
    event = "BufRead",
    keys = {
      { "<leader>rc", ":RunCode<CR>", desc = "运行代码" },
    },
    opts = require("config.tool.code-runner"),
  },

  ----------------------------------------------------------------------
  --                           Rust Plugins                           --
  ----------------------------------------------------------------------
  -- {
  --   "simrat39/rust-tools.nvim",
  --   keys = {
  --     { "<leader>rsc", "<cmd>RustRun<cr>", desc = "运行Rust代码" },
  --   },
  --   opts = require("config.tool.rust-tools"),
  -- },
}
