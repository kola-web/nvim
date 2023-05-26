local M = {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy"
}

M.config = function()
  local status, colorizer = pcall(require, "colorizer")
  if not status then
    return
  end

  colorizer.setup()
end
return M
