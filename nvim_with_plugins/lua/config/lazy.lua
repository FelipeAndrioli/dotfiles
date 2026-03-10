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

        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
            dependencies = { 'rafamadriz/friendly-snippets' },

            -- use a release tag to download pre-built binaries
            version = '1.*',
            -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
            -- build = 'cargo build --release',
            -- If you use nix, you can build from source using latest nightly rust with:
            -- build = 'nix run .#build-plugin',

            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
                -- 'super-tab' for mappings similar to vscode (tab to accept)
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- All presets have the following mappings:
                -- C-space: Open menu or open docs if already open
                -- C-n/C-p or Up/Down: Select next/previous item
                -- C-e: Hide menu
                -- C-k: Toggle signature help (if signature.enabled = true)
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                keymap = { 
                    preset = 'default',
                    ['<C-space>'] = { 
                        function(cmp) 
                            cmp.show({ providers = { 'snippets' }})
                        end, 
                    },
                },

                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono'
                },

                cmdline = {
                    keymap = {
                        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                        ['<Tab>'] = { 'show', 'accept' },
                    },
                    completion = { menu = { auto_show = true }},
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = { 
                    accept = { auto_brackets = { enabled = true }},

                    documentation = { 
                        auto_show = true,
                        auto_show_delay_ms = 250,
                        treesitter_highlighting = true,
                        window = { border = "rounded" },
                    },

                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        },
                    },

                    trigger = {
                        show_on_trigger_character = true,
                        show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
                    },
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`

                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                    providers = {
                        lsp = {
                            min_keyword_length = 2,
                            score_offset = 0,
                        },
                        path = {
                            min_keyword_length = 0,
                        },
                        snippets = {
                            min_keyword_length = 2,
                        },
                        buffer = {
                            min_keyword_length = 5,
                            max_items = 5,
                        },
                    },
                },

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = { 
                    implementation = "prefer_rust_with_warning",
                    sorts = {
                        'score',
                        'sort_text',
                        'label',
                    }
                }
            },
            opts_extend = { "sources.default" }
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
