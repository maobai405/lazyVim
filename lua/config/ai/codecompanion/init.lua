local M = {}

--- @type string # 默认适配器名称，可选值为"siliconflow"或其他支持的适配器
-- codeplan
local defaultAdapters = "codeplan"
local models = {
  "XAIO-C-4-5-Sonnet",
  "XAIO-C-4-5-Haiku",
  "XAIO-C-4-5-Opus",
  "DeepSeek-V3.2",
  "GLM-4.7",
  "MiniMax-M2.1",
}
local defaultModel = "XAIO-C-4-5-Sonnet"
local secondaryModel = "GLM-4.7"

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
          -- url = "https://code-api.x-aio.com/v1/chat/completions",
          env = {
            api_key = function()
              return os.getenv("CODEPLAN_API_KEY")
            end,
          },
          schema = {
            model = {
              choices = models,
              default = defaultModel,
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
      variables = {
        opts = {
          default_variables = { "mcp:neovim://buffer" },
        },
      },
      tools = {
        opts = {
          -- default_tools = { "neovim", "memory", "full_stack_dev" },
          default_tools = { "neovim", "memory" },
        },
        ["insert_edit_into_file"] = {
          opts = {
            require_approval_before = false,
            require_confirmation_after = false,
          },
        },
        ["cmd_runner"] = {
          opts = {
            require_approval_before = false,
            require_cmd_approval = false,
          },
        },
        ["create_file"] = {
          opts = {
            require_approval_before = false,
            require_cmd_approval = false,
          },
        },
        ["file_search"] = {
          opts = {
            require_cmd_approval = false,
          },
        },
        ["grep_search"] = {
          opts = {
            require_approval_before = false,
            require_cmd_approval = false,
          },
        },
        ["read_file"] = {
          opts = {
            require_approval_before = false,
            require_cmd_approval = false,
          },
        },
      },
    },
  },
  prompt_library = {
    markdown = {
      dirs = {
        "~/.config/opencode/command",
      },
    },
  },

  -- 规则
  rules = {},

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
        -- 聊天记录自动删除的天数（0表示禁用该功能）
        expiration_days = 1,
        -- 选择器界面（自动解析为有效的选择器）
        picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
        -- 可选的过滤功能，用于控制浏览时显示的聊天记录。
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
          adapter = defaultAdapters, -- "copilot"
          ---Model for generating titles (defaults to current chat model)
          model = secondaryModel, -- "gpt-4o"
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
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        show_result_in_chat = true, -- Show tool results directly in chat buffer
        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
        -- MCP Resources
        make_vars = true, -- Convert MCP resources to #variables for prompts
        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
    spinner = {},
  },
}

local context_list = {
  "#{mcp:neovim://buffer}",
  "#{mcp:neovim://diagnostics/buffer}",
}

-- Function to insert all stickies after the last "> - " line
local function insert_stickies(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- 从后往前查找最后一个包含 "> - " 的行
  local insert_line = line_count
  for i = #lines, 1, -1 do
    if lines[i]:match("^>%s*%-%s") then
      -- 找到最后一个 "> - " 行,在其下方第二行插入(即跳过一行)
      insert_line = i + 1
      break
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, insert_line, insert_line, false, context_list)
end

local group = vim.api.nvim_create_augroup("CodeCompanionAutoVariables", {})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionChatCreated",
  group = group,
  callback = function(request)
    insert_stickies(request.buf)
  end,
})

return M
