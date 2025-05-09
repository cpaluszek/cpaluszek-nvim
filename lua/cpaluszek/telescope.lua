local telescope = require 'telescope'

local function init()
  local trouble_open = require('trouble.sources.telescope').open
  -- local trouble_add = require('trouble.sources.telescope').add

  telescope.setup = ({
    defaults = {
      mappings = {
        i = {
          ["<C-t>"] = trouble_open,
        },
        n = {
          ["<C-t>"] = trouble_open,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
          'rg', '--files', '-L', '--hidden', '--glob', '!**.git/*'
        },
      },
    },
  })

  telescope.load_extension('notify')

  local options = { noremap = true, silent = true }

  -- Builtin
  vim.keymap.set('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
  vim.keymap.set('n', '<leader>fs', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
  vim.keymap.set('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
  vim.keymap.set('n', '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', options)
  vim.keymap.set('n', '<leader>fd', '<CMD>lua require("telescope.builtin").diagnostics()<CR>', options)

  -- Language servers
  vim.keymap.set('n', '<leader>lsd', '<CMD>lua require("telescope.builtin").lsp_definitions{}<CR>', options)
  vim.keymap.set('n', '<leader>lsi', '<CMD>lua require("telescope.builtin").lsp_implementations{}<CR>', options)
  vim.keymap.set('n', '<leader>lsl', '<CMD>lua require("telescope.builtin").lsp_code_actions{}<CR>', options)
  vim.keymap.set('n', '<leader>lst', '<CMD>lua require("telescope.builtin").lsp_type_definitions{}<CR>', options)

  -- Extensions
  vim.keymap.set('n', '<leader>fn', '<CMD>lua require("telescope").extensions.notify.notify()<CR>', options)
end

return {
  init = init,
}
