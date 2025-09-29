return {
  -- 代码伴侣 https://codecompanion.olimorris.dev
  {
    "olimorris/codecompanion.nvim",
    -- enabled = false,
    lazy = false,
    keys = require("config.ai.codecompanion.init").keys,
    opts = require("config.ai.codecompanion.init").config,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
          experimental = { check_rtp_message = false },
          preview = {
            filetypes = { "markdown", "codecompanion" },
            ignore_buftypes = {},
          },
        },
      },
      -- 使用内联助手或 @editor 工具时，使用 mini.diff 获得更清晰的差异
      {
        "nvim-mini/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
      -- 使用 img-clip.nvim 通过 :PasteImage 将图像从系统剪贴板复制到聊天缓冲区
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
      {
        "ravitemer/mcphub.nvim",
        build = "pnpm add -g mcp-hub@latest",
        opts = {
          auto_approve = true,
        },
      },
    },
    init = function()
      require("config.ai.codecompanion.fidget-spinner"):init()
    end,
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    keys = require("config.ai.claude-code").keys,
    opts = require("config.ai.claude-code").config,
  },
}
