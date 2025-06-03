local function init()
  require 'cpaluszek.vim'.init()
  require 'cpaluszek.telescope'.init()
  require 'cpaluszek.theme'.init()
  require 'cpaluszek.languages'.init()
  require 'cpaluszek.obsidian'.init()
end

return {
  init = init,
}
