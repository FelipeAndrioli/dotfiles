local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true 

-- CLANGD (C/C++)
vim.lsp.config['clangd'] = {
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
}
vim.lsp.enable('clangd')

-- JDTLS (Java)
local home = vim.fn.expand('~')
local root_markers = { 'pom.xml', 'build.gradle', 'mvnw', 'gradlew', '.git' }

--local raw_jdtls_bin = home .. '/AppData/Local/nvim-data/mason/packages/jdtls/bin/jdtls.cmd'
local raw_jdtls_bin = home .. '/AppData/Local/nvim-data/mason/packages/jdtls/bin/jdtls'
local current_file = vim.api.nvim_buf_get_name(0)
local root_dir = vim.fs.root(0, root_markers)

if (not root_dir or root_dir == "") and current_file ~= "" then
    root_dir = vim.fs.dirname(current_file)
end
if not root_dir or root_dir == "" then
    root_dir = vim.fn.getcwd()
end

local project_name = vim.fs.basename(root_dir)
if project_name == "" or project_name == nil then
    project_name = "standalone-" .. vim.fn.sha256(root_dir):sub(1, 8)
end
local raw_workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

local jdtls_bin = vim.fs.normalize(raw_jdtls_bin):gsub("/", "\\")
local workspace_dir = vim.fs.normalize(raw_workspace_dir):gsub("/", "\\")

vim.lsp.config('jdtls', {
    capabilities = capabilities, 
    cmd = { jdtls_bin, "-data", workspace_dir },
    filetypes = { "java" },
    root_markers = root_markers,
    single_file_support = true,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
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
