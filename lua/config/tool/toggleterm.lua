return function()
  local colors = require("utils").get_palette()
  local lazyUtil = require("lazyvim.util")
  local map = lazyUtil.safe_keymap_set

  return {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.25
      end
    end,
    open_mapping = [[<C-\>]],
    -- direction = "horizontal",
    direction = "float",
    shade_filetypes = {},
    hide_numbers = true,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
    highlights = {
      FloatBorder = {
        guifg = colors.blue,
      },
    },
    float_opts = {
      border = "curved",
    },
  }
end
