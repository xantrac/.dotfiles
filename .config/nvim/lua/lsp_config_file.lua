require("mason").setup()
require("mason-lspconfig").setup()
-- Add additional capabilities supported by nvim-cmp

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'tsserver', 'elixirls', 'lua_ls', 'tailwindcss', 'eslint', 'solargraph' }

function format()
    local filetype = vim.bo.filetype
    if filetype == "eruby" then
        local command = "bundle exec erblint -a " .. vim.fn.expand("%")
        vim.fn.jobstart(command, {
            on_exit = function(_, _)
                vim.schedule(function()
                    vim.cmd("checktime")
                end)
            end
        })
    else
        vim.lsp.buf.format()
    end
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.cmd [[autocmd BufWritePre * lua format()]]
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
    }
end

lspconfig.ltex.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        ltex = {
            additionalRules = {
                languageModel = '~/ngrams/',
            },
        },
    },
}

lspconfig.tailwindcss.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    init_options = {
        userLanguages = {
            eelixir = "phoenix-heex",
            elixir = "phoenix-heex",
            eruby = "erb",
            heex = "phoenix-heex",
        },
    },
    handlers = {
        ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
            lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
            P("tailwindcss getConfiguration callback")
        end,
    },
    settings = {
        includeLanguages = {
            typescript = "javascript",
            typescriptreact = "javascript",
            ["html-eex"] = "html",
            ["phoenix-heex"] = "html",
            elixir = "html",
            heex = "html",
            elm = "html",
            erb = "html",
        },
        tailwindCSS = {
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            experimental = {
                classRegex = {
                    [[class= "([^"]*)]],
                    [[class: "([^"]*)]],
                    "~H\"\"\".*class=\"([^\"]*)\".*\"\"\"",
                },
            },
            validate = true,
        },
    },
    filetypes = {
        "css",
        "scss",
        "sass",
        "html",
        "heex",
        "elixir",
        "eelixir",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
}

lspconfig.eslint.setup = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        bin = 'eslint',
        format = { enable = true },
        autoFixOnSave = true,
        codeActionsOnSave = {
            mode = "all",
            rules = { "!debugger", "!no-only-tests/*" },
        },
        code_actions = {
            enable = true,
            apply_on_save = {
                enable = true,
                types = { "directive", "problem", "suggestion", "layout" },
            },
            disable_rule_comment = {
                enable = true,
                location = "separate_line", -- or `same_line`
            },
        },
        diagnostics = {
            enable = true,
            report_unused_disable_directives = false,
            run_on = "type", -- or `save`
        },
    },
}

require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}

require 'lspconfig'.standardrb.setup {}
local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    border = "single",
    sources = {
        null_ls.builtins.diagnostics.erb_lint.with({}),
    },
})
