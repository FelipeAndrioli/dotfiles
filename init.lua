vim.pack.add({
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',

	'https://github.com/mason-org/mason.nvim',

    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/nvim-mini/mini.icons',                          -- for work properly, mini.icons need a modern font such as JetBrainsMono, FiraCode, or Hack Nerd Font

	-- colorschemes
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/ellisonleao/gruvbox.nvim',
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/catppuccin/nvim',
	-- colorschemes
})

vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1"),
        build = "cargo build --release",
    },
})

vim.cmd('packadd blink.cmp')

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

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

--[[
    - menu:     Uses a popup menu to show the possible completions.
    - menuone:  Forces the popup menu to show up even if there is only a single match.
    - noselect: Do not select a match from the menu automatically. It forces you to manually pick an option before inserting, stopping the editor from aggressively modifying text while you type.
    - noinsert: Do not insert any text into the buffer until you actively select a match from the menu.
    - longest:  Only inserts the longest common text of all matches.
    - preview:  Shows extra information about the currently selected completion item in a separate preview window.
    - popup:    Used in newer nvim versions to display the completion preview information inside a floating popup window next to the menu, instead of opening a split scratch buffer.
    - fuzzy:    Enables fuzzy matching behavios for native completion engines.
]]

vim.opt.autocomplete = false                        -- enable native insert-mode auto-completion
vim.opt.pumheight = 10                                -- limit max items shown
vim.opt.completeopt = "menu,menuone,noinsert,noselect,popup,fuzzy"  -- completion options
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
vim.opt.selection = "inclusive"						-- Selection behavior, 'exclusive' leaves the last character of a function signature after accepting a suggestion and filling it, 'inclusive' doesn't.
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

vim.g.mapleader = " "

-- Open :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

-- Move cursor x lines up/down
vim.keymap.set("n", "<C-j>", "10j", { desc = "move cursor x lines down" })
vim.keymap.set("n", "<C-k>", "10k", { desc = "move cursor x lines up" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "p", "p`[h", { noremap = true, desc = "Move the cursor to the beginning of buffer after pasting some text" })


-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- terminal
local terminal_state = {
	buf = nil,
	win = nil,
	is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end

-- Key mappings
vim.keymap.set("n", "p", "p`[h", { noremap = true, desc = "Move the cursor to the beginning of buffer after pasting some text" })
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'python', 'lua', 'go' },
    callback = function() vim.treesitter.start() end,
})

