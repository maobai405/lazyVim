local M = {}

--- @type string # 默认适配器名称，可选值为"siliconflow"或其他支持的适配器
-- byte_dance | siliconflow
-- 默认适配器配置字符串
-- 用于指定系统默认使用的AI模型适配器，当前默认值为"siliconflow"
-- 该值会在未显式指定适配器时作为后备选项使用
local defaultAdapters = "siliconflow"

M.keys = {
  { "<leader>ap", "<cmd>CodeCompanionChat Toggle<cr>", desc = "切换CodeCompanionChat聊天面板" },
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
  },
  -- 适配器
  adapters = {
    -- 火山引擎
    byte_dance = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "byte_dance",
        url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
        env = {
          api_key = function()
            return os.getenv("BYTEDABCE_API_KEY")
          end,
        },
        schema = {
          model = {
            default = "deepseek-v3-250324",
            choices = {
              ["deepseek-r1-250120"] = { opts = { can_reason = true } },
              "deepseek-v3-250324",
            },
          },
        },
      })
    end,

    -- 硅基流动
    siliconflow = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow",
        url = "https://api.siliconflow.cn/v1/chat/completions",
        env = {
          api_key = function()
            return os.getenv("SILICONFLOW_API_KEY")
          end,
        },
        schema = {
          model = {
            -- deepseek-ai/DeepSeek-R1
            -- deepseek-ai/DeepSeek-V3
            default = "deepseek-ai/DeepSeek-V3",
            choices = {
              ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
              "deepseek-ai/DeepSeek-V3",
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
        ]],
        },
      },
    },
  },
}

return M
