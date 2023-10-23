return function()
  return {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  }
end
