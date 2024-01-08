local M = {}

M["keys"] = {
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "Breakpoint Condition",
  },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "Toggle Breakpoint",
  },
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "Continue",
  },
  {
    "<leader>dC",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "Run to Cursor",
  },
  {
    "<leader>dg",
    function()
      require("dap").goto_()
    end,
    desc = "Go to line (no execute)",
  },
  {
    "<leader>di",
    function()
      require("dap").step_into()
    end,
    desc = "Step Into",
  },
  {
    "<leader>dj",
    function()
      require("dap").down()
    end,
    desc = "Down",
  },
  {
    "<leader>dk",
    function()
      require("dap").up()
    end,
    desc = "Up",
  },
  {
    "<leader>dl",
    function()
      require("dap").run_last()
    end,
    desc = "Run Last",
  },
  {
    "<leader>do",
    function()
      require("dap").step_out()
    end,
    desc = "Step Out",
  },
  {
    "<leader>dO",
    function()
      require("dap").step_over()
    end,
    desc = "Step Over",
  },
  {
    "<leader>dp",
    function()
      require("dap").pause()
    end,
    desc = "Pause",
  },
  {
    "<leader>dr",
    function()
      require("dap").repl.toggle()
    end,
    desc = "Toggle REPL",
  },
  {
    "<leader>ds",
    function()
      require("dap").session()
    end,
    desc = "Session",
  },
  {
    "<leader>dt",
    function()
      require("dap").terminate()
    end,
    desc = "Terminate",
  },
  {
    "<leader>dw",
    function()
      require("dap.ui.widgets").hover()
    end,
    desc = "Widgets",
  },
}

M["config"] = function()
  local dap = require("dap")
  local dapui = require("dapui")
  local mason_dap = require("mason-nvim-dap")

  local icons = require("utils.icons").get("dap")
  local colors = require("utils").get_palette()
  -- local mappings = require("tool.dap.dap-keymap")

  -- dap.listeners.after.event_initialized["dapui_config"] = debug_init_cb
  -- dap.listeners.before.event_terminated["dapui_config"] = debug_terminate_cb
  -- dap.listeners.before.event_exited["dapui_config"] = debug_terminate_cb
  -- dap.listeners.before.disconnect["dapui_config"] = debug_terminate_cb

  -- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
  vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

  vim.fn.sign_define("DapBreakpoint", { text = icons.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = icons.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = icons.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = icons.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = icons.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

  ---A handler to setup all clients defined under `tool/dap/clients/*.lua`
  ---@param config table
  local function mason_dap_handler(config)
    local dap_name = config.name
    local ok, custom_handler = pcall(require, "user.configs.dap-clients." .. dap_name)
    if not ok then
      -- Use preset if there is no user definition
      ok, custom_handler = pcall(require, "tool.dap.clients." .. dap_name)
    end
    if not ok then
      -- Default to use factory config for clients(s) that doesn't include a spec
      mason_dap.default_setup(config)
      return
    elseif type(custom_handler) == "function" then
      -- Case where the protocol requires its own setup
      -- Make sure to set
      -- * dap.adpaters.<dap_name> = { your config }
      -- * dap.configurations.<lang> = { your config }
      -- See `codelldb.lua` for a concrete example.
      custom_handler(config)
    else
      vim.notify(string.format("Failed to setup [%s].\n\nClient definition under `tool/dap/clients` must return\na fun(opts) (got '%s' instead)", config.name, type(custom_handler)), vim.log.levels.ERROR, { title = "nvim-dap" })
    end
  end

  mason_dap.setup({
    ensure_installed = require("config.settings").dap_deps,
    automatic_installation = true,
    handlers = { mason_dap_handler },
  })
end

return M
