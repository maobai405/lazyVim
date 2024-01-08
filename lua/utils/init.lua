local M = {}

---@class palette
---@field rosewater string
---@field flamingo string
---@field mauve string
---@field pink string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field sapphire string
---@field blue string
---@field sky string
---@field teal string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field none "NONE"

---@type palette
local palette = nil

---Initialize the palette
---@return palette
local function init_palette()
  if not palette then
    palette = vim.g.colors_name:find("catppuccin") and require("catppuccin.palettes").get_palette()
      or {
        rosewater = "#DC8A78",
        flamingo = "#DD7878",
        mauve = "#CBA6F7",
        pink = "#F5C2E7",
        red = "#E95678",
        maroon = "#B33076",
        peach = "#FF8700",
        yellow = "#F7BB3B",
        green = "#AFD700",
        sapphire = "#36D0E0",
        blue = "#61AFEF",
        sky = "#04A5E5",
        teal = "#B5E8E0",
        lavender = "#7287FD",
        text = "#F2F2BF",
        subtext1 = "#BAC2DE",
        subtext0 = "#A6ADC8",
        overlay2 = "#C3BAC6",
        overlay1 = "#988BA2",
        overlay0 = "#6E6B6B",
        surface2 = "#6E6C7E",
        surface1 = "#575268",
        surface0 = "#302D41",
        base = "#1D1536",
        mantle = "#1C1C19",
        crust = "#161320",
      }

    palette = vim.tbl_extend("force", { none = "NONE" }, palette, {})
  end

  return palette
end

---@param c string @The color in hexadecimal.
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---Blend foreground with background
---@param foreground string @The foreground color
---@param background string @The background color to blend with
---@param alpha number|string @Number between 0 and 1 for blending amount.
function M.blend(foreground, background, alpha)
  ---@diagnostic disable-next-line: cast-local-type
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---Get RGB highlight by highlight group
---@param hl_group string @Highlight group name
---@param use_bg boolean @Returns background or not
---@param fallback_hl? string @Fallback value if the hl group is not defined
---@return string
function M.hl_to_rgb(hl_group, use_bg, fallback_hl)
  local hex = fallback_hl or "#000000"
  local hlexists = pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = false })

  if hlexists then
    local result = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
    if use_bg then
      hex = result.bg and result.bg or "NONE"
    else
      hex = result.fg and result.fg or "NONE"
    end
  end

  return hex
end

---Extend a highlight group
---@param name string @Target highlight group name
---@param def table @Attributes to be extended
function M.extend_hl(name, def)
  local hlexists = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not hlexists then
    -- Do nothing if highlight group not found
    return
  end
  local current_def = vim.api.nvim_get_hl(0, { name = name, link = false })
  local combined_def = vim.tbl_deep_extend("force", current_def, def)

  vim.api.nvim_set_hl(0, name, combined_def)
end

---Generate universal highlight groups
---@param overwrite palette? @The color to be overwritten | highest priority
---@return palette
function M.get_palette(overwrite)
  if not overwrite then
    return init_palette()
  else
    return vim.tbl_extend("force", init_palette(), overwrite)
  end
end

-- Generate highlight groups for lspsaga. Existing attributes will NOT be overwritten
function M.gen_lspkind_hl()
  local colors = M.get_palette()
  local dat = {
    Class = colors.yellow,
    Constant = colors.peach,
    Constructor = colors.sapphire,
    Enum = colors.yellow,
    EnumMember = colors.teal,
    Event = colors.yellow,
    Field = colors.teal,
    File = colors.rosewater,
    Function = colors.blue,
    Interface = colors.yellow,
    Key = colors.red,
    Method = colors.blue,
    Module = colors.blue,
    Namespace = colors.blue,
    Number = colors.peach,
    Operator = colors.sky,
    Package = colors.blue,
    Property = colors.teal,
    Struct = colors.yellow,
    TypeParameter = colors.maroon,
    Variable = colors.peach,
    Array = colors.peach,
    Boolean = colors.peach,
    Null = colors.yellow,
    Object = colors.yellow,
    String = colors.green,
    TypeAlias = colors.green,
    Parameter = colors.blue,
    StaticMethod = colors.peach,
    Text = colors.green,
    Snippet = colors.mauve,
    Folder = colors.blue,
    Unit = colors.green,
    Value = colors.peach,
  }

  for kind, color in pairs(dat) do
    vim.api.nvim_set_hl(0, "LspKind" .. kind, { fg = color, default = true })
  end
end

-- Generate highlight groups for alpha. Existing attributes will NOT be overwritten
function M.gen_alpha_hl()
  local colors = M.get_palette()

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.blue, default = true })
  vim.api.nvim_set_hl(0, "AlphaButton", { fg = colors.green, default = true })
  vim.api.nvim_set_hl(0, "AlphaAttr", { fg = colors.pink, italic = true, default = true })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.yellow, default = true })
end

---Convert number (0/1) to boolean
---@param value number @The value to check
---@return boolean|nil @Returns nil if failed
function M.tobool(value)
  if value == 0 then
    return false
  elseif value == 1 then
    return true
  else
    vim.notify("Attempting to convert data of type '" .. type(value) .. "' [other than 0 or 1] to boolean", vim.log.levels.ERROR, { title = "[utils] Runtime error" })
    return nil
  end
end

---获取视觉模式范围
---@return table
function M.get_range()
  local _start = vim.fn.getpos("v")
  local _end = vim.fn.getpos(".")

  local s_row, e_row = math.min(_start[2], _end[2]), math.max(_start[2], _end[2])
  local s_col, e_col = math.min(_start[3], _end[3]), math.max(_start[3], _end[3])

  return { s_row, e_row, s_col, e_col }
end

---获取v 模式下选中的文本
---@return string
function M.get_select()
  local s_row, e_row, s_col, e_col = unpack(M.get_range())

  ---@type string
  ---@diagnostic disable-next-line: assign-type-mismatch
  local line = vim.fn.getline(e_row)
  local uidx = vim.str_utfindex(line, math.min(#line, e_col))
  ---@diagnostic disable-next-line: param-type-mismatch
  e_col = vim.str_byteindex(line, uidx)

  if s_row == e_row then
    return line:sub(s_col, e_col)
  else
    local lines = vim.fn.getline(s_row, e_row)
    local e = #lines
    lines[1] = lines[1]:sub(s_col)
    lines[e] = line:sub(1, e_col)
    return table.concat(lines, " ")
  end
end

---获取V 模式下选中的行文本
---@return string
function M.get_lines()
  local s_row, e_row = unpack(M.get_range())

  if s_row == e_row then
    return vim.fn.getline(s_row)
  else
    local lines = vim.fn.getline(s_row, e_row)
    return table.concat(lines, "\n")
  end
end

---获取需要选择的文本
---@param mode string
---@return string
function M.get_text(mode)
  return ({
    n = function()
      return vim.fn.expand("<cword>")
    end,
    v = function()
      return M.get_select()
    end,
    V = function()
      return M.get_lines()
    end,
  })[mode]():match("^%s*(.-)%s*$")
end

return M
