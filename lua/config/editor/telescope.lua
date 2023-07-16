return function()
  return {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
      initial_mode = "insert",
      selection_strategy = "reset",
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
end
