local M = {}

--- @type string # 默认适配器名称，可选值为"siliconflow"或其他支持的适配器
-- codeplan | yunyi | MiniMax | byte_dance
local defaultAdapters = "codeplan"

M.keys = {
  {
    "<leader>cp",
    mode = { "n", "v" },
    "<cmd>CodeCompanionChat Toggle<cr>",
    desc = "切换CodeCompanionChat聊天面板",
  },
  {
    "<leader>ae",
    mode = { "n", "v" },
    "<cmd>CodeCompanionActions<cr>",
    desc = "打开CodeCompanionChat操作面板",
  },
}

M.config = {
  -- 配置
  opts = {
    language = "Chinese",
  },

  -- 适配器
  adapters = {
    http = {
      -- codeplan
      codeplan = function()
        return require("codecompanion.adapters").extend("anthropic", {
          name = "codeplan",
          url = "https://code-api.x-aio.com/anthropic/v1/messages",
          env = {
            api_key = function()
              return os.getenv("CODEPLAN_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "DeepSeek-V3.2",
              choices = {
                "DeepSeek-V3.2",
                "XAIO-G-3-Pro-Preview",
                "XAIO-C-4-5-Sonnet",
              },
            },
          },
        })
      end,
      -- yunyi
      yunyi = function()
        return require("codecompanion.adapters").extend("openai_responses", {
          name = "yunyi",
          url = "https://yunyi.cfd/codex/responses",
          env = {
            api_key = function()
              return os.getenv("YUNYI_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "gpt-5.1-codex-max",
              choices = {
                "gpt-5.2",
                "gpt-5.1-codex-max",
              },
            },
          },
        })
      end,
    },
  },

  -- 交互行为 - 配置操作使用的适配器
  interactions = {
    chat = {
      adapter = defaultAdapters,
      tools = {
        opts = {
          default_tools = { "full_stack_dev" },
        },
        ["cmd_runner"] = {
          opts = {
            require_approval_before = false,
          },
        },
        ["file_search"] = {
          opts = {
            require_approval_before = false,
          },
        },
        ["grep_search"] = {
          opts = {
            require_approval_before = false,
          },
        },
        ["insert_edit_into_file"] = {
          opts = {
            require_approval_before = false,
          },
        },
        ["read_file"] = {
          opts = {
            require_approval_before = false,
          },
        },
      },
    },
    inline = {
      adapter = defaultAdapters,
      tools = {
        opts = {
          default_tools = { "full_stack_dev" },
        },
      },
    },
    cmd = {
      adapter = defaultAdapters,
      tools = {
        opts = {
          default_tools = { "full_stack_dev" },
        },
      },
    },
  },
  prompt_library = {
    markdown = {
      dirs = {
        vim.fn.getcwd() .. "/.prompts",
        "~/.config/nvim/lua/config/ai/codecompanion/prompts",
      },
    },
  },

  -- 规则
  rules = {
    default = {
      description = "Collection of common files for all projects",
      files = {
        ".clinerules",
        ".cursorrules",
        ".goosehints",
        ".rules",
        ".windsurfrules",
        ".github/copilot-instructions.md",
        "AGENT.md",
        "AGENTS.md",
        { path = "CLAUDE.md", parser = "claude" },
        { path = "CLAUDE.local.md", parser = "claude" },
        { path = "~/.claude/CLAUDE.md", parser = "claude" },
        { path = "~/.config/nvim/lua/config/ai/codecompanion/rules", files = "*.md", parser = "claude" },
      },
      is_preset = true,
    },
    opts = {
      chat = {
        enabled = true,
        default_rules = "default", -- The rule groups to load
      },
    },
  },

  -- 扩展
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = "gh",
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = "sc",
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = true,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface (auto resolved to a valid picker)
        picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
        ---Optional filter function to control which chats are shown when browsing
        chat_filter = nil, -- function(chat_data) return boolean end
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = "r", i = "<M-r>" },
          delete = { n = "d", i = "<M-d>" },
          duplicate = { n = "<C-y>", i = "<C-y>" },
        },
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to current chat adapter)
          adapter = nil, -- "copilot"
          ---Model for generating titles (defaults to current chat model)
          model = nil, -- "gpt-4o"
          ---Number of user prompts after which to refresh the title (0 to disable)
          refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
          ---Maximum number of times to refresh the title (default: 3)
          max_refreshes = 3,
          format_title = function(original_title)
            -- this can be a custom function that applies some custom
            -- formatting to the title.
            return original_title
          end,
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        ---Enable detailed logging for history extension
        enable_logging = false,

        -- Summary system
        summary = {
          -- Keymap to generate summary for current chat (default: "gcs")
          create_summary_keymap = "gcs",
          -- Keymap to browse summaries (default: "gbs")
          browse_summaries_keymap = "gbs",

          generation_opts = {
            adapter = nil, -- defaults to current chat adapter
            model = nil, -- defaults to current chat model
            context_size = 90000, -- max tokens that the model supports
            include_references = true, -- include slash command content
            include_tool_outputs = true, -- include tool execution results
            system_prompt = nil, -- custom system prompt (string or function)
            format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
          },
        },
      },
    },
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true,
      },
    },
    spinner = {},
  },
}

return M
