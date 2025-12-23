return {
  status = function()
    local result = vim.system({ "git", "status", "--short" }, { text = true }):wait()
    return result.stdout
  end,
  
  diff_staged = function()
    local result = vim.system({ "git", "diff", "--no-ext-diff", "--staged" }, { text = true }):wait()
    return result.stdout
  end,
  
  diff_unstaged = function()
    local result = vim.system({ "git", "diff", "--no-ext-diff" }, { text = true }):wait()
    return result.stdout
  end,
}

