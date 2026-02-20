-- Fat cursor in insert mode
vim.opt.guicursor = ""

vim.opt.cursorline = true							-- highlight current line

-- Line numbers
vim.opt.nu = true

-- Line relative number
vim.opt.relativenumber = true

-- Tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true							-- case insensitive search
vim.opt.smartcase = true							-- case sensitive if uppercase in search
vim.opt.hlsearch = true								-- don't highlight search results
vim.opt.incsearch = true							-- show matches as you type

vim.opt.termguicolors = true

vim.opt.sidescrolloff = 8							
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.showmatch = true							-- highlight matchint brackets
vim.opt.matchtime = 2								-- how long to show matching bracket
vim.opt.cmdheight = 1								-- command line height
vim.opt.completeopt = "menuone,noinsert,noselect"	-- completion options
vim.opt.showmode = false							-- don't show mode in command line
vim.opt.pumheight = 10								-- popup menu height
vim.opt.pumblend = 10								-- popup menu transparency
vim.opt.winblend = 0								-- floating window transparency 
vim.opt.conceallevel = 0							-- don't hide markup 
vim.opt.concealcursor = ""							-- don't hide cursor line markup
vim.opt.lazyredraw = true							-- don't redraw during macros
vim.opt.synmaxcol = 300								-- syntax highlighting limit

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Behavior Settings
vim.opt.hidden = true								-- Allow hidden buffers
vim.opt.errorbells = false							-- No error bells
vim.opt.backspace = "indent,eol,start"				-- Better backspace behavior
vim.opt.autochdir = false							-- Don't auto change directory
vim.opt.iskeyword:append("-")						-- Treat dash as part of word
vim.opt.path:append("**")							-- Include subdirectories in search
vim.opt.selection = "exclusive"						-- Selection behavior
vim.opt.mouse = "a"									-- Enable mouse support
vim.opt.clipboard:append("unnamedplus")				-- Use system clipboard
vim.opt.modifiable = true							-- Allow buffer modifications
vim.opt.encoding = "UTF-8"							-- Set encoding

-- File Explorer
vim.g.netrw_hide = 0								-- Show all files
vim.g.netrw_list_hide = ""							-- Don't hide any files
vim.g.netrw_banner = 1								-- 0 -> Disable banner for cleaner view


-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class" })

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

vim.g.mapleader = " "

