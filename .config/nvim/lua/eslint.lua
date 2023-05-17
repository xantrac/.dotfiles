local M = {}

-- Auto-install

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local ok, eslint = lsp_installer_servers.get_server("eslint")
if ok then
    if not eslint:is_installed() then
        eslint:install()
    end
end

-- Settings

M.settings = {
    enable = true,
    format = { enable = true }, 
    autoFixOnSave = true,
    codeActionsOnSave = {
        mode = "all",
        rules = { "!debugger", "!no-only-tests/*" },
    },
    lintTask = {
        enable = true,
    },
}

return M
