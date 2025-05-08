local function set_vim_opt()
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 4
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.list = true
  vim.opt.wrap = false
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.termguicolors = true
  vim.opt.signcolumn = "yes"
end

local function set_vim_keys()
  vim.keymap.set('x', '<leader>p', '\"_dP', {desc = 'Paste selection without adding to buffer', silent = true})

  -- copy to sys clipboard
  vim.keymap.set('n', '<leader>y', '\"+y', {desc = 'Copy to sys clipboard'})
  vim.keymap.set('v', '<leader>y', '\"+y', {desc = 'Copy to sys clipboard'})
  vim.keymap.set('n', '<leader>Y', '\"+Y', {desc = 'Copy to sys clipboard'})

  vim.keymap.set('n', '<leader>d', '\"_d', {desc = 'Delete and copy to sys clipboard'})
  vim.keymap.set('v', '<leader>d', '\"_d', {desc = 'Delete and copy to sys clipboard'})

  -- search and replace
  vim.keymap.set('n', '<leader>s', ':%s/\\<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>', {desc = 'Search and replace', silent = true})
end

local function init()
  vim.g.mapleader = " "
  set_vim_opt()
  set_vim_keys()
end

return {
  init = init,
}
