require('mini.icons').setup()

require("blink.cmp").setup({
    keymap = {
        preset = 'default',
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },

    appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            lsp = { name = 'LSP', score_offset = 1000 },
            path = { name = 'Path', score_offset = 500 },
            snippets = { name = 'Snippets', score_offset = 300 },
            buffer = { name = 'Buffer', score_offset = 100 },
        },
    },

    completion = {
        menu = {
            draw = {
                components = {
                    kind_icon = {
                        ellipsis = false,
                        text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                        highlight = function(ctx) return ctx.kind_hl_group end,
                    },
                },
            },
        },
        list = {
            selection = {
                preselect = false,
                auto_insert = false,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = 'rounded',
            },
        },
        accept = {
            auto_brackets = { enabled = true },
        },
    },

    signature = {
        enabled = true,
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning"
    },
})
