return {
  completion = {
    ghost_text = {
      enabled = true,
    },
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
      "select_next",
      function(cmp)
        if cmp.snippet_active() then
          return cmp.snippet_forward()
        end
      end,
      "fallback",
    },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
}
