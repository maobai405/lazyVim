return {
  formatters_by_ft = {
    lua = { "stylua" },
    fish = { "fish_indent" },
    sh = { "shfmt" },
    markdown = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    vue = { "prettier" },
    json = { "prettier" },
    javascript = { "prettier", lsp_format = "fallback" },
    typescript = { "prettier", lsp_format = "fallback" },
    javascriptreact = { "prettier", lsp_format = "fallback" },
    typescriptreact = { "prettier", lsp_format = "fallback" },
    rust = { "rustfmt" },
    -- dart = { "dart_format" },
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
    prettier = {
      prepend_args = function(self, ctx)
        local config_files = {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yml",
          ".prettierrc.yaml",
          ".prettierrc.json5",
          ".prettierrc.js",
          ".prettierrc.cjs",
          ".prettierrc.mjs",
          ".prettierrc.toml",
          "prettier.config.js",
          "prettier.config.cjs",
          "prettier.config.mjs",
          "package.json",
        }
        local config_file = vim.fs.find(config_files, { upward = true, path = ctx.dirname })[1]
        if config_file then
          return {} -- don't need to return anything because it will pick up the file from the cwd
        else
          return { "--config=" .. vim.fn.expand("~/.config/nvim/.prettierrc") }
        end
      end,
    },
    biome = {
      prepend_args = function(self, ctx)
        local config_file = vim.fs.find({ "biome.json" }, { upward = true, path = ctx.dirname })[1]
        if config_file then
          return {} -- don't need to return anything because it will pick up the file from the cwd
        else
          return { "format", "--config-path=" .. vim.fn.expand("~/.config/nvim") }
        end
      end,
    },
  },
}
