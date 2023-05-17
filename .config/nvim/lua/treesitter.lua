require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    auto_install = true,
    ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = { "phpdoc", "tree-sitter-phpdoc", "lua" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
}
