local function set_vim_opt()
  local settings = {
    number = true,
    relative_number = true,
    
    scrolloff = 4,
    
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    list = true,

    wrap = false,

    swapfile = false,
    backup = false,

    termguicolors = true,
  }

  for k, v in pairs(settings) do
    vim.opt[k] = v
  end
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
