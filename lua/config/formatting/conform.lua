return function()
  return {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      -- sh = { "fish_indent" },
      sh = { "shfmt" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      vue = { "prettier" },
      json = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      -- rust = { "rustfmt" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      prettier = {
        prepend_args = { "--config=" .. vim.fn.expand("~/.config/formatter/prettierrc.json") },
      },
      biome = {
        prepend_args = { "format", "--config-path=" .. vim.fn.expand("~/.config/formatter") },
      },
    },
  }
end
