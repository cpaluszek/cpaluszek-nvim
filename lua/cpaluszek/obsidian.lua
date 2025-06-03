local obsidian = require 'obsidian'

local function init()
  vim.opt.conceallevel=1

  obsidian.setup({
    workspaces = {
      {
        name = "MyObsidian",
        path = "~/Documents/MyObsidian",
      },
    },

    daily_notes = {
      folder = "Daily Notes",
      template = nil,
    },

    completion = {
      vim_cmp = true,
      min_chars = 2,
    },

    templates = {
      folder = "Templates",
    },

    ui = {
      enable = true,
    },

    attachments = {
      img_folder = "Ressources/Attachments",
    },
  })
end

return {
  init = init,
}
