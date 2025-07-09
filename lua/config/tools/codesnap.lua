return function()
  -- 设置一个不同的种子值
  math.randomseed(os.time())

  -- 定义一个背景色数组
  local bg_theme = { "bamboo", "sea", "peach", "grape", "dusk", "summer" }

  -- 生成一个随机索引
  local randomIndex = math.random(1, #bg_theme)

  -- 获取数组中的随机项值
  local random_bg_theme = bg_theme[randomIndex]

  return {
    mac_window_bar = true, -- macos 圆点
    has_breadcrumbs = true, -- 面包屑
    -- breadcrumbs_separator = "" -- 面包屑间隔符
    has_line_number = true, -- 行号
    bg_theme = random_bg_theme, -- 背景色
    watermark = "maobai", -- 水印
  }
end
