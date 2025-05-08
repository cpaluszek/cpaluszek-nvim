local lspconfig = require 'lspconfig'
local treesitter = require 'nvim-treesitter.configs'

local function ini()
    treesitter.setup {
        auto_install = false,
        insure_installed = {},
        ignore_install = {},
        modules = {},
        sync_install = false,
    }
end

return {
    init = init,
}
