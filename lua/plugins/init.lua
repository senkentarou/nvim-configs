local load_plugins = function(path)
  local loaded = {}
  local basename = vim.fs.basename(path)

  for file, _ in vim.fs.dir(path) do
    if vim.fn.empty(file:match('%.lua$')) == 0 then
      vim.list_extend(loaded, {
        require('plugins/' .. basename .. '/' .. file:gsub('%.lua$', '')),
      })
    end
  end

  return loaded
end

local plugins_path = vim.fn.stdpath('config') .. '/lua/plugins'

return {
  load_plugins(plugins_path .. '/individuals'),
  load_plugins(plugins_path .. '/categories'),
}
