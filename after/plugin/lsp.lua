local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

-- CLANGD (C/C++)
vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = { 
        "clangd",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--background-index",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
    settings = {
        offsetEncoding = { "utf-8", "utf-16" },
        textDocument = {
            completion = { editsNearCursor = true }
        }
    }
})

vim.lsp.enable('clangd')

-- JDTLS (Java)
vim.lsp.config('jdtls', {
    capabilities = capabilities,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                -- stops Java from adding massive import paths while typing
                guessMethodArguments = false, 
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                },
            },
        },
    },
})
vim.lsp.enable('jdtls')

-- JEDI LANGUAGE SERVER (Python)
vim.lsp.config('jedi_language_server', {
    capabilities = capabilities,
    cmd = { 'jedi-language-server' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    init_options = {
        completion = {
            disableSnippets = true, 
            resolveEagerly = true,
        },
        diagnostics = {
            enable = true,
        },
    },
})
vim.lsp.enable('jedi_language_server')

vim.keymap.set("i", "<C-o>", "<C-x><C-o>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic floating window" })

vim.keymap.set("n", "<leader>D", function()
  vim.diagnostic.open_float()
  vim.cmd("wincmd w")
end, { desc = "Open diagnostic float and focus it" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_signature_keymap", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client.name == "clangd" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        if client and client.name == "jedi_language_server" then
            client.server_capabilities.workspace = {
                didChangeWatchedFiles = { dynamicRegistration = false }
            }
        end

        vim.keymap.set('i', '<C-k>', function()
            vim.lsp.buf.signature_help()
        end, { buffer = args.buf, desc = "LSP Signature Help" })
    end,
})

