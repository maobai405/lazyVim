return {
  completion = {
    menu = {
      border = {
        { "󱐋", "WarningMsg" },
        "─",
        "╮",
        "│",
        "╯",
        "─",
        "╰",
        "│",
      },
    },
    documentation = {
      auto_show = true,
      window = {
        border = {
          { "", "DiagnosticHint" },
          "─",
          "╮",
          "│",
          "╯",
          "─",
          "╰",
          "│",
        },
      },
    },
  },

  keymap = {
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.snippet_forward()
        end
      end,
      "select_next",
      "fallback",
    },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
}
