return function()
  return {
    lsp = {
      color = {
        enabled = true,
        background = true,
        background_color = { r = 19, g = 17, b = 24 },
        foreground = false,
        virtual_text = true,
        virtual_text_str = '■',
      },
      settings = {
        showTodos = true,
        renameFilesWithClasses = "always",
        updateImportsOnRename = true,
        completeFunctionCalls = true,
        lineLength = 100,
      },
    },
  }
end
