local function init()
  require 'cpaluszek.vim'.init()
  require 'cpaluszek.telescope'.init()
end

return {
  init = init,
}
