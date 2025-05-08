local function init()
  vim.g.mapleader = " "

  vim.opt.number = true;
  vim.opt.relativenumber = true;
end

return {
  init = init,
}
