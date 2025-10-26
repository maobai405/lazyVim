local M = {}

--- @type string # 默认适配器名称，可选值为"siliconflow"或其他支持的适配器
-- byte_dance | siliconflow
-- 默认适配器配置字符串
-- 用于指定系统默认使用的AI模型适配器，当前默认值为"siliconflow"
-- 该值会在未显式指定适配器时作为后备选项使用
local defaultAdapters = "byte_dance"

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
  opts = {
    language = "Chinese",
    system_prompt = [[请遵循以下步骤：
    1. 回答使用中文。
    2. 尽可能简洁的回答我的问题, 但关键内容不能缺少, 特别是代码相关的回答一定要将问题相关的完整的代码块进行返回。
    3. 与答案不相关的内容都不需要输出。
    4. 特别注意!!!如果需要输出代码, 需要注意代码的类型不能出现不安全的类型定义,如:typeScript中的any
  ]],
  },
  -- 适配器
  adapters = {
    -- 火山引擎
    byte_dance = function()
      -- openai_compatible
      -- deepseek
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "byte_dance",
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
          api_key = function()
            return os.getenv("BYTEDABCE_API_KEY")
          end,
        },
        schema = {
          model = {
            -- deepseek-r1-250528
            -- deepseek-v3-1-250821
            -- kimi-k2-250905
            default = "deepseek-v3-1-terminus",
            choices = {
              ["deepseek-r1-250528"] = { opts = { can_reason = true } },
              "deepseek-v3-1-terminus",
              "kimi-k2-250905",
            },
          },
        },
      })
    end,

    claude = function()
      return require("codecompanion.adapters").extend("claude_code", {
        name = "claude",
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
          api_key = function()
            return os.getenv("BYTEDABCE_API_KEY")
          end,
        },
        schema = {
          model = {
            default = "deepseek-v3-1-terminus",
            choices = {
              "deepseek-v3-1-terminus",
            },
          },
        },
      })
    end,

    -- v3api
    v3api = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "v3api",
        url = "https://api.gpt.ge/v1/chat/completions",
        env = {
          api_key = "sk-HDilxHT3viL4T5mC4690107cAa794015Aa86Ee321b9830E1",
        },
        schema = {
          model = {
            default = "claude-sonnet-4-20250514",
            choices = {
              "claude-sonnet-4-20250514",
              "gpt-5-mini",
            },
          },
        },
      })
    end,
  },

  -- 策略 - 配置操作使用的适配器
  strategies = {
    chat = {
      adapter = defaultAdapters,
      keymaps = {
        clear = {
          modes = { n = "gca" },
          index = 6,
          callback = "keymaps.clear",
          description = "Clear chat",
        },
      },
    },
    inline = {
      adapter = defaultAdapters,
    },
    cmd = {
      adapter = defaultAdapters,
    },
  },

  prompt_library = {
    ["Chinese explain"] = {
      strategy = "chat",
      description = "中文解释代码",
      opts = {
        short_name = "explain in chinese",
        modes = { "v" },
        index = 5,
        is_default = true,
        is_slash_cmd = false,
        auto_submit = true,
        user_prompt = false,
        stop_context_insertion = true,
      },
      prompts = {
        {
          role = "system",
          content = [[当被要求解释代码时，请遵循以下步骤：
            1. 识别编程语言。
            2. 描述代码的目的，并引用该编程语言的核心概念。
            3. 解释每个函数或重要的代码块，包括参数和返回值。
            4. 突出说明使用的任何特定函数或方法及其作用。
            5. 如果适用，提供该代码如何融入更大应用程序的上下文。
          ]],
          opts = {
            visible = false,
          },
        },
        {
          role = "user",
          content = function(context)
            local input = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

            return string.format(
              [[请解释 buffer %d 中的这段代码:
              ```%s
              %s
              ```
              ]],
              context.bufnr,
              context.filetype,
              input
            )
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
    ["Code Format"] = {
      strategy = "inline",
      description = "代码格式化",
      opts = {
        short_name = "code format",
        modes = { "v" },
      },
      prompts = {
        {
          role = "system",
          content = [[当被要求格式化代码时，请遵循以下步骤：
            1. 识别编程语言。
            2. 按照编程语言的格式化要求进行格式化。
          ]],
        },
      },
    },
    ["Chinese add comments"] = {
      strategy = "inline",
      description = "添加中文注释",
      opts = {
        short_name = "add chinese comments",
        modes = { "v" },
      },
      prompts = {
        {
          role = "system",
          content = [[当被要求添加代码注释时，请添加中文注释并遵循以下步骤：
            1. 识别编程语言及其注释语法规范
              - 明确单行注释(如// # --)和多行注释(如/* */ ''' """)的语法
              - 注意不同语言的文档注释规范

            2. 分析代码功能与结构
              - 在文件/模块顶部添加整体功能描述注释
              - 为每个类/结构体添加设计意图说明
              - 对复杂算法添加工作原理注释

            3. 编写规范化注释内容
              - 函数注释需包含：
                * 功能描述
                * @param参数说明(类型+用途)
                * @return返回值说明
                * @throws可能抛出的异常
              - 关键变量注释应说明：
                * 用途约束
                * 特殊取值范围
                * 计量单位(如ms/kB)

            4. 保持注释风格一致
              - 统一注释符号与缩进风格
              - 专业术语保持前后一致
              - 注释需符合技术写作规范

            5. 特殊注意事项
              - 对hack/临时代码添加显式标记(TODO/FIXME)
              - 敏感代码需添加安全警告注释
              - 性能关键代码标注复杂度分析(O(n)等)
              - 函数名上面一定要添加注释注明函数用意
        ]],
        },
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
        -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
        picker = "snacks",
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to active chat's adapter)
          adapter = nil, -- e.g "copilot"
          ---Model for generating titles (defaults to active chat's model)
          model = nil, -- e.g "gpt-4o"
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        ---Enable detailed logging for history extension
        enable_logging = false,
      },
    },
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        show_result_in_chat = true, -- 在聊天中显示麦克风工具的结果
        make_vars = true, -- 将资源转换为#变量
        make_slash_commands = true, -- 将提示添加为 /slash 命令
      },
    },
  },
}

return M
