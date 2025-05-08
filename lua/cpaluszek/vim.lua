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

local function init()
  vim.g.mapleader = " "
  set_vim_opt()
end

return {
  init = init,
}
