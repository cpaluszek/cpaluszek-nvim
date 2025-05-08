local function set_vim_opt()
  vim.opt.number = true,
  vim.opt.relative_number = true,
  vim.opt.scrolloff = 4,
  vim.opt.tabstop = 4,
  vim.opt.shiftwidth = 4,
  vim.opt.expandtab = true,
  vim.opt.list = true,
  vim.opt.wrap = false,
  vim.opt.swapfile = false,
  vim.opt.backup = false,
  vim.opt.termguicolors = true,
end

local function set_vim_keys()
  vim.keymap.set('n', '<C-h>', '<CMD>wincmd h<CR>', {desc = 'Wincmd left', silent = true})
  vim.keymap.set('n', '<C-j>', '<CMD>wincmd j<CR>', {desc = 'Wincmd down', silent = true})
  vim.keymap.set('n', '<C-k>', '<CMD>wincmd k<CR>', {desc = 'Wincmd up', silent = true})
  vim.keymap.set('n', '<C-l>', '<CMD>wincmd l<CR>', {desc = 'Wincmd right', silent = true})

  vim.keymap.set('x', '<leader>p', '\"_dP', {desc = 'Paste selection without adding to buffer', silent = true})

  -- copy to sys clipboard
  vim.keymap.set('n', '<leader>y', '\"+y', {desc = 'Copy to sys clipboard'})
  vim.keymap.set('v', '<leader>y', '\"+y', {desc = 'Copy to sys clipboard'})
  vim.keymap.set('n', '<leader>Y', '\"+Y', {desc = 'Copy to sys clipboard'})

  vim.keymap.set('n', '<leader>d', '\"_d', {desc = 'Delete and copy to sys clipboard'})
  vim.keymap.set('v', '<leader>d', '\"_d', {desc = 'Delete and copy to sys clipboard'})

  -- search and replace
  vim.keymap.set('n', '<leader>s', ':%s/\\<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>', {descr = 'Search and replace', silent = true})
end

local function init()
  vim.g.mapleader = " "
  set_vim_opt()
  set_vim_keys()
end

return {
  init = init,
}
