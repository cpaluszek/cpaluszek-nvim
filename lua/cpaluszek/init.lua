local function init()
  require 'cpaluszek.vim'.init()
  require 'cpaluszek.telescope'.init()
  require 'cpaluszek.theme'.init()
end

return {
  init = init,
}
