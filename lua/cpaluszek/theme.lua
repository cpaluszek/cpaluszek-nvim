local comment = require 'comment'
local gitsigns = require 'gitsigns'
local lualine = require 'lualine'
local function init()
  comment.setup {}

  gitsigns.setup {}
  
  lualine.setup({
    options = {
      extensions = { "quickfix", "trouble", "fzf" },
      theme = "auto",
    },
  })

  -- TODO: notify

  
end

return {
  init = init,
}
