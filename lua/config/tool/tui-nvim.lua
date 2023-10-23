return function()
  return {
    -- File that is read from
    -- useful for file managers
    temp = "/tmp/tui-nvim",

    -- Command used to open files
    method = "edit",

    -- Example of a mapping
    mappings = {
      -- { "<ESC>", "<cmd>q<cr>" },
    },

    -- Execute functions
    -- upon open/exit
    on_open = {},
    on_exit = {},

    -- Window border (see ':h nvim_open_win')
    border = "rounded",

    -- Highlight group for window/border (see ':h winhl')
    borderhl = "Normal",
    winhl = "Normal",

    -- Window transparency (see ':h winblend')
    winblend = 0,

    -- Num from '0 - 1' for measurements
    height = 0.8,
    width = 0.8,
    y = 0.5,
    x = 0.5,
  }
end
