return function()
  return {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["S"] = "show_fs_stat",
        },
      },
      commands = {
        show_fs_stat = function(state)
          local node = state.tree:get_node()
          local command = "open " .. "-R " .. node.path
          os.execute(command)
        end,
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["<Tab>"] = "open",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  }
end
