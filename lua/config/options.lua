-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- opt.background = "light"
opt.background = "dark"
opt.pumblend = 0 -- !!! 补全菜单的透明度
opt.winblend = 0
opt.winborder = "rounded"
opt.autoindent = true -- 自动缩进
opt.autoread = true -- 当文件在外部被修改时，自动重新读取文件
opt.autowrite = true -- 当切换到其他文件或退出vim时，自动保存文件
opt.backspace = "indent,eol,start" -- 定义backspace键的行为
opt.backup = false -- 不自动生成备份文件
opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim" --  不需要备份的文件或文件夹
opt.breakat = [[\ \	;:,!?]] -- 可以用于断行的字符
opt.breakindentopt = "shift:2,min:20" -- 定义缩进时的行为
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- 定义剪贴板使用的寄存器
opt.cmdheight = 2 -- 定义命令行窗口的高度
opt.cmdwinheight = 5 -- 定义命令行窗口的高度
opt.complete = ".,w,b,k" -- 定义补全时的搜索范围
opt.completeopt = "menu,menuone,noselect" -- 定义补全时的选项
opt.concealcursor = "niv" -- 定义隐藏文本时光标的行为
opt.conceallevel = 0 -- 定义隐藏文本的级别
opt.cursorcolumn = false -- 是否高亮显示当前列
opt.cursorline = false -- 是否高亮显示当前行
opt.diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience" -- 定义diff时的选项
opt.display = "lastline" -- 定义底行显示的内容
opt.encoding = "utf-8" -- 定义文件编码
opt.equalalways = true -- 当窗口大小改变时，是否重新分配窗口大小
opt.errorbells = true -- 是否在错误时响铃
opt.visualbell = true -- 是否使用可视化的方式显示响铃
opt.expandtab = true -- 是否将tab键转换为空格
opt.fileformat = "unix" -- 控制当前缓冲区的换行符类型
opt.fileformats = "unix" -- 定义自动检测换行符时的优先级列表
opt.foldenable = true -- 是否启用折叠
opt.foldlevelstart = 99 -- 定义打开文件时的折叠级别
opt.formatoptions = "1jcroql" -- 定义格式化时的选项
opt.grepformat = "%f:%l:%c:%m" -- 定义grep的格式
opt.grepprg = "rg --hidden --vimgrep --smart-case --" -- 定义grep时使用的命令
opt.helpheight = 12 -- 定义help窗口的高度
opt.hidden = true -- 是否允许隐藏文件
opt.history = 2000 -- 命令历史记录的长度
opt.ignorecase = true -- 是否忽略大小写
opt.inccommand = "nosplit" -- 定义增量替换时的行为
opt.incsearch = true -- 实时搜索
opt.infercase = true -- 是否根据输入的大小写进行匹配
opt.jumpoptions = "stack" -- 跳转命令的选项
opt.laststatus = 3 -- 定义状态栏的显示方式
opt.linebreak = true -- 是否在单词内换行
opt.list = false -- 是否显示不可见字符
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←" -- 定义不可见字符的显示方式
opt.magic = true -- 开启魔术符号
opt.mousescroll = "ver:3,hor:6"
opt.number = true -- 是否显示行号
opt.previewheight = 12 -- 预览窗口的高度
opt.pumheight = 15 -- 补全菜单的高度
opt.redrawtime = 1500 -- 自动重绘的时间间隔
opt.relativenumber = false -- 是否显示相对行号
opt.ruler = true -- 是否显示光标位置信息
opt.scrolloff = 4 -- 光标距离窗口顶部和底部的行数
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } --  保存会话的选项
opt.shada = "!,'300,<50,@100,s10,h" -- 定义viminfo文件的保存方式
opt.shiftround = true -- 是否对缩进进行四舍五入
opt.shiftwidth = 2 -- 定义缩进的宽度
opt.shortmess = "aoOTIcF" -- 定义错误信息的显示方式
opt.showbreak = "↳  " -- 定义换行符的显示方式
opt.showcmd = false -- 是否在命令行中显示已输入的命令
opt.showmode = false -- 是否在底部状态栏定义tab中显示当前模式
opt.showtabline = 2 -- 定义tab栏的显示方式
opt.sidescrolloff = 5 -- 定义侧边滚动条离屏幕边缘的距离
opt.signcolumn = "yes" -- 定义是否显示符号列
opt.smartcase = true -- 是否自动判断大小写
opt.smarttab = true -- 是否智能缩进
opt.softtabstop = 2 -- 定义tab键的宽度
opt.splitbelow = true -- 新建窗口时是否在下方打开
opt.splitkeep = "cursor" -- 在关闭窗口时光标位置的行为
opt.splitright = true -- 新建窗口时是否在右侧打开
opt.startofline = false -- 光标移动到行首时的行为
opt.switchbuf = "usetab,uselast" -- 定义在不同缓冲区之间切换的行为
opt.synmaxcol = 2500 -- 定义语法高亮的最大列数
opt.tabstop = 2 -- 定义tab键的宽度
opt.termguicolors = true -- 是否启用真彩色
opt.timeout = true -- 是否启用超时检测
opt.timeoutlen = 300 -- 定义超时时间
opt.ttimeout = true -- 是否启用键盘超时检测
opt.ttimeoutlen = 50 -- 定义键盘超时时间
opt.undofile = true -- 是否生成撤销文件
opt.undolevels = 10000 -- 撤销历史记录的最大步数
opt.updatetime = 500 -- 定义更新时间间隔
opt.viewoptions = "folds,cursor,curdir,slash,unix" -- 定义打开文件时的选项
opt.virtualedit = "block" -- 定义虚拟编辑模式的行为
opt.whichwrap = "h,l,<,>,[,],~" -- 定义在哪些字符处换行
opt.wildignore =
  ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**" -- 定义忽略的文件
opt.wildignorecase = true -- 是否忽略大小写
opt.winminwidth = 10 -- 定义窗口的最小宽度
opt.winwidth = 30 -- 定义新窗口的默认宽度
opt.wrap = false -- 是否自动换行
opt.wrapscan = true -- 是否在搜索时循环到文件开头或结尾
opt.swapfile = false -- 是否生成交换文件
opt.writebackup = false -- 是否在保存文件时生成备份文件
opt.paste = false
opt.mousemoveevent = true -- 相应悬停事件
opt.guicursor = "n-v:block-blinkon500-blinkoff500,i:ver25-blinkon500-blinkoff500" -- 控制光标的外观和行为
-- opt.guicursor = "n-v-c:block-blinkon500-blinkoff500-blinkwait500"
