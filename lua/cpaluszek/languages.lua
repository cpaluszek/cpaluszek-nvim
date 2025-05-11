local lspconfig = require 'lspconfig'
local treesitter = require 'nvim-treesitter.configs'
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local fidget = require 'fidget'

local function autocmd(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
  })
end

local function on_attach(client, buffer)
  local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
  local autocmd_clear = vim.api.nvim_clear_autocmds

  local opts = { buffer = buffer, remap = false }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wl', function()
  -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, opts)

  if client.server_capabilities.documentHighlightProvider then
    autocmd_clear { group = augroup_highlight, buffer = buffer }
    autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer }
    autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer }
  end
end

local function init()
  local indent_group = vim.api.nvim_create_augroup("custom_indent_settings", {clear = true})

  vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = {"nix", "yaml", "yml", "dockerfile", "docker-compose"},
    callback = function()
       vim.opt_local.tabstop = 2
       vim.opt_local.shiftwidth = 2
       vim.opt_local.expandtab = true
    end
  })

  fidget.setup{}

  -- Completions
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true}),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
        { name = 'buffer' },
      }),
  })

  vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })

  treesitter.setup {
    auto_install = false,
    ensure_installed = {},
    ignore_install = {},
    modules = {},
    sync_install = false,
    highlight = { enabled = true },
    indent = { enable = true },
    rainbow = { enable = true },
  }

  local language_servers = {
    bashls = {},
    dockerls = {},
    gopls = {
      settings = {
        gopls = {
          gofumpt = true,
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    nil_ls = {
      settings = {
        ['nil'] = {
          formatting = { command = { 'alejandra' } },
        },
      },
    },
  }

  local capabilities = cmp_nvim_lsp.default_capabilities()

  for server, server_config in pairs(language_servers) do
    local config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if server_config then
      for k, v in pairs(server_config) do
        config[k] = v
      end
    end

    lspconfig[server].setup(config)
  end

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
end


return {
  init = init,
}
