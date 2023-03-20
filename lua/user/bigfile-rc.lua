local status_ok, bigfile = pcall(require, 'bigfile')
if not status_ok then
  return
end

bigfile.setup {
  filesize = 0.1,
}
