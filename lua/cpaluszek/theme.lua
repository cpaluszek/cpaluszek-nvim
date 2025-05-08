local comment = require 'Comment'
local gitsigns = require 'gitsigns'
local lualine = require 'lualine'
local tokyonight = require 'tokyonight'
local catppuccin = require 'catppuccin'
local gruvbox = require 'gruvbox'
local themery = require 'themery'

local function init()
  comment.setup {}

  gitsigns.setup {}
  
  lualine.setup({
    options = {
      extensions = { "quickfix", "trouble", "fzf" },
      theme = "auto",
    },
  })


  -- Themes
  catppuccin.setup({
    flavour = "mocha",
    -- TODO: integrations
    transparent_background = true,
    term_colors = true,
  })

  tokyonight.setup({
    opts = {
      transparent = true,
    },
  })

  gruvbox.setup({
    transparent_mode = true,
  })

  themery.setup({
    livePreview = true,
    themes = {
      {
        name = "Catppuccin Mocha",
        colorscheme = "catppuccin-mocha",
        before = [[
          vim.opt.background = "dark"
        ]]
      },
      {
        name = "Tokyonight",
        colorscheme = "tokyonight",
        before = [[
          vim.opt.background = "dark"  
        ]]
      },
      {
        name = "Gruvbox Dark",
        colorscheme = "gruvbox",
        before = [[
          vim.opt.background = "dark"  
        ]]
      },
      {
        name = "Gruvbox Light",
        colorscheme = "gruvbox",
        before = [[
          vim.opt.background = "light"  
        ]]
      },
    }
  })
  
  -- TODO: notify
end

return {
  init = init,
}
