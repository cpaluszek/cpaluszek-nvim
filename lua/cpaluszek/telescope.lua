local telescope = require 'telescope'

local function init()
  telescope.setup = {
    pickers = {
      find_files = {
        find_command = {
          'rg', '--files', '-L', '--hidden', '--glob', '!**.git/*'
        },
      },
    }
  }

  -- Builtin
  vim.keymap.set('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files{ hidden = true }')
  vim.keymap.set('n', '<leader>fs', '<CMD>lua require("telescope.builtin").grep_string')
  vim.keymap.set('n', '<leader>fl', '<CMD>lua require("telescope.builtin").live_grep')
end

return {
  init = init,
}
