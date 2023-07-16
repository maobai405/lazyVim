return function()
  local icons = {
    diagnostics = require("utils.icons").get("diagnostics"),
    documents = require("utils.icons").get("documents"),
    git = require("utils.icons").get("git"),
    ui = require("utils.icons").get("ui"),
  }

  return {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
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
