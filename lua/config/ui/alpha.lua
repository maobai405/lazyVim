return function()
  local status_ok, alpha = pcall(require, "alpha")
  local dashboard = require("alpha.themes.dashboard")
  require("alpha.term")

  if not status_ok then
    return
  end

  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  local header = {
    type = "terminal",
    command = "cmatrix -ba",
    width = 80,
    height = 20,
    opts = {
      position = "center",
      redraw = true,
      window_config = {},
    },
  }

  local buttons = {
    type = "group",
    val = {
      dashboard.button("f", " " .. " find file", "<cmd> telescope find_files <cr>"),
      dashboard.button("n", " " .. " new file", "<cmd> ene <bar> startinsert <cr>"),
      dashboard.button("r", " " .. " recent files", "<cmd> telescope oldfiles <cr>"),
      dashboard.button("g", " " .. " find text", "<cmd> telescope live_grep <cr>"),
      dashboard.button("c", " " .. " config", "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
      dashboard.button("s", " " .. " restore session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("x", " " .. " lazy extras", "<cmd> lazyextras <cr>"),
      dashboard.button("l", "󰒲 " .. " lazy", "<cmd> lazy <cr>"),
      dashboard.button("q", " " .. " quit", "<cmd> qa <cr>"),
    },
    opts = {
      spacing = 1,
    },
  }

  local footer = {
    type = "text",
    val = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
    end,
    opts = {
      position = "center",
      hl = "Number",
    },
  }

  local opts = {
    layout = {
      { type = "padding", val = 5 },
      header,
      { type = "padding", val = 1 },
      buttons,
      { type = "padding", val = 1 },
      footer,
    },
    opts = {
      noautocmd = true,
      redraw_on_resize = true,
    },
  }

  dashboard.opts = opts

  alpha.setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end
