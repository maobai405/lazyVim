-- https://prettier.io/docs/en/configuration.html
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
}

local function biome_or_prettier(bufnr)
  local has_biome_lsp = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "biome",
  })[1]
  if has_biome_lsp then
    return {}
  end
  local has_prettier = vim.fs.find(config_files, { upward = true })[1]
  if has_prettier then
    return { "prettier" }
  end
  return { "biome" }
end

return {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    fish = { "shfmt" },
    rust = { "rustfmt" },
    markdown = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    vue = { "prettier" },
    json = { "prettier" },
    javascript = biome_or_prettier,
    typescript = biome_or_prettier,
    javascriptreact = biome_or_prettier,
    typescriptreact = biome_or_prettier,
  },

  formatters = {
    injected = { options = { ignore_errors = true } },
    prettier = {
      condition = function(ctx)
        return vim.fs.find(config_files, { upward = true, path = ctx.dirname })[1] ~= nil
      end,
    },
    biome = {
      args = { "check", "--write", "$FILENAME" },
      stdin = false,
      append_args = function(self, ctx)
        local config_file = vim.fs.find({ "biome.json" }, { upward = true, path = ctx.dirname })[1]
        if config_file then
          return {} -- 使用项目内的配置
        else
          return { "format", "--config-path=" .. vim.fn.expand("~/.config/nvim") } -- 使用全局配置
        end
      end,
    },
  },
}
