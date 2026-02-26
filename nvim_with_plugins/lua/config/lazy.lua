-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
          'nvim-telescope/telescope.nvim', version = '*',
          dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
          }
        },

        -- colorschemes
        {
        { "ellisonleao/gruvbox.nvim" },	
        },
        {
          "folke/tokyonight.nvim",
          lazy = false,
          priority = 1000,
          opts = {},
        },
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
        { "rebelot/kanagawa.nvim", priority = 1000 },
        -- colorschemes

        -- treesitter
        {
          'nvim-treesitter/nvim-treesitter',
          lazy = false,
          run = ':TSUpdate',
          ensure_installed = { "c", "cpp", "java", "python", "lua", "go" },
          sync_install = false,
          auto_install = true,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        }, 
        -- treesitter

        -- mason for lsp
        {
            "mason-org/mason.nvim",
            opts = {}
        },
        -- mason for lsp

        {
            "neovim/nvim-lspconfig",
            config = function()

            end,
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
