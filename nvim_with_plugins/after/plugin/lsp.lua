vim.lsp.enable('clangd')

vim.lsp.config['clangd'] = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
    settings = {
        offsetEncoding = { "utf-8", "utf-16" },
        textDocument = {
          completion = {
            editsNearCursor = true
          }
        }
    }
}

vim.lsp.enable('java-language-server')

vim.lsp.config['java-language-server'] = {
    cmd = { "java-language-server" },
    filetypes = { "java" },
    root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", ".git"  },  
    settings = {}
}

vim.lsp.enable('gopls')

vim.lsp.config['gopls'] = {
    cmd = { 'gopls' },
    filetypes = { "go" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true,
            gofumpt = true
        },
    },
}

vim.keymap.set("i", "<C-o>", "<C-x><C-o>", { silent = true, noremap = true})

-- In your on_attach function (or a separate keymap setup)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Open diagnostic floating window" })

-- To make the floating window focusable (allowing scrolling/copying with Ctrl-W w)
vim.keymap.set("n", "<leader>D", function()
  vim.diagnostic.open_float()
  -- Move focus to the floating window
  vim.cmd("wincmd w")
end, { buffer = bufnr, desc = "Open diagnostic float and focus it" })

vim.keymap.set('i', '<C-k>', function()
  vim.lsp.buf.signature_help()
end, {buffer=true, desc="LSP Signature Help"})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true})
        end
    end,
})

vim.cmd("set completeopt+=noselect")
