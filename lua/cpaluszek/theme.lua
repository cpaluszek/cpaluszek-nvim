local colorizer = require 'colorizer'
local comment = require 'Comment'
local gitsigns = require 'gitsigns'
local lualine = require 'lualine'
local tokyonight = require 'tokyonight'
local catppuccin = require 'catppuccin'
local gruvbox = require 'gruvbox'
local themery = require 'themery'
local render_markdown = require 'render-markdown'
local notify = require 'notify'
local mini_pairs = require 'mini.pairs'
local trouble = require 'trouble'
local neo_tree = require 'neo-tree'

local function init()
  colorizer.setup {}

  comment.setup {}

  gitsigns.setup {}

  lualine.setup({
    options = {
      extensions = { "quickfix", "trouble", "fzf" },
      theme = "auto",
    },
  })

  trouble.setup {}

  notify.setup({
    render = "wrapped-compact",
        timeout = 2500,
  })

  mini_pairs.setup {}

  render_markdown.setup {}

  vim.keymap.set('n', '<C-b>', '<CMD>Neotree toggle<CR>', {desc = 'Neotree'})
  neo_tree.setup({
    close_if_last_window = true,
    enable_diagnostics = true,
    enable_git_status = true,
    filesystem = {
      hijack_netrw_behavior = "open_current",
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
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
    transparent = true,
  })

  gruvbox.setup({
    terminal_colors = true,
    transparent_mode = true,
  })

  vim.keymap.set('n', '<leader>tm', '<CMD>Themery<CR>', {desc = 'Themery'})
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
  vim.cmd [[colorscheme gruvbox]]
end

return {
  init = init,
}
