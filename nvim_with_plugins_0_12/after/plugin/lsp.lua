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

vim.lsp.enable('clangd')

vim.lsp.config('jdtls', {
})

vim.lsp.enable('jdtls')

vim.lsp.config('jedi_language_server', {
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
  init_options = { ... },
})

vim.lsp.enable('jedi_language_server')

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
