return function()
  local icons = require("utils.icons").get("ui")

  return {
    text = {
      done = icons.Check, -- character shown when all tasks are complete
    },
    window = { blend = 0 },
    sources = {
      -- ["null-ls"] = { ignore = true },
    },
  }
end
