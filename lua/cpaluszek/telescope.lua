local telescope = require 'telescope'

local function init()
  local trouble = require('trouble.sources.telescope')

  telescope.setup = {
    pickers = {
      find_files = {
        find_command = {
          'rg', '--files', '-L', '--hidden', '--glob', '!**.git/*'
        },
      },
    },
    default = {
      mappings = {
        i = {
          ["<C-x>"] = trouble.open,
        },
        n = {
          ["<C-x>"] = trouble.open,
        },
      },
    },
  }

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
