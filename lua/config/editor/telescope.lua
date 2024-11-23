local M = {}

M.keys = {
  { "<leader>sa", false },
  {
    "<leader>fp",
    function()
      require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
    end,
    desc = "查找插件文件",
  },
}

M.config = {
  defaults = {
    initial_mode = "insert",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
    },
  },
}

return M
