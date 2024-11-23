return {
  sources = { "filesystem" },
  source_selector = {
    winbar = false,
  },
  filesystem = {
    window = {
      mappings = {
        ["S"] = "open_system_file_manager",
      },
    },
    commands = {
      open_system_file_manager = function(state)
        local node = state.tree:get_node()
        local command = "open " .. "-R " .. node.path
        os.execute(command)
      end,
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<Tab>"] = "open",
      ["<Space>"] = false, -- disable space until we figure out which-key disabling
      ["[b"] = "prev_source",
      ["]b"] = "next_source",
      P = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      s = "open_split",
      v = "open_vsplit",
    },
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<C-J>"] = "move_cursor_down",
      ["<C-K>"] = "move_cursor_up",
    },
  },
}
