return function()
  return {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      -- sh = { "fish_indent" },
      -- sh = { "shfmt" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      -- rust = { "rustfmt" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      biome = {
        prepend_args = { "format", "--config-path=" .. vim.fn.expand("~/.config/nvim/lua/config/formatting") },
      },
    },
  }
end
