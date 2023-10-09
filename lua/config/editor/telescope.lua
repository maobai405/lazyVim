return function()
  return {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
      initial_mode = "insert",
      sorting_strategy = "ascending",
      selection_strategy = "reset",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
      },
    },
    -- 设置插件配置
    extensions = {
      -- -- 配置查看图片的插件: nvim-telescope/telescope-media-files.nvim
      -- media_files = {
      --   -- filetypes whitelist
      --   -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      --   filetypes = { "png", "webp", "jpg", "jpeg" },
      --   -- find command (defaults to `fd`)
      --   find_cmd = "rg",
      -- },
    },
  }
end
