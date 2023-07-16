return function()
  return {
    focus = false,
    filetype = {
      -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      -- python = "python3 -u",
      -- typescript = "deno run",
      -- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
      dart = "dart $dir/$fileName",
      excluded_buftypes = { "message" },
    },
    mode = "float",
    float = {
      close_key = "q",
      border = "rounded",
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,
      -- Highlight group for floating window/border (see ':h winhl')
      border_hl = "FloatBorder",
      float_hl = "Normal",
      -- Transparency (see ':h winblend')
      blend = 0,
    },
  }
end
