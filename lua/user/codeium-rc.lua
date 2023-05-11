local status, codeium = pcall(require, "codeium")
if not status then
  return
end

codeium.setup()
