return function()
  return {
    ensure_installed = {
      -- "dart",
      "bash",
      "fish",
      "yaml",
      "vim",
      "vimdoc",
      "lua",
      "luadoc",
      "luap",
      "json",
      "html",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "markdown",
      "markdown_inline",
      "rust",
    },
    highlight = { enable = true },
    indent = {
      enable = true,
      -- disable = {
      --   "dart",
      -- },
    },
    matchup = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]["] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
    },
  }
end
