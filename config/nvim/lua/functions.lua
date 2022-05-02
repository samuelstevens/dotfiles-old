local M = {}

function M.addFileToSuffixesAdd()
  -- Adds the current file's extension to suffixesadd so you can go to other files with the same extension.

  -- Get file extension
  local ext = '.' .. vim.fn.expand('%:e')
  -- Add it to suffixesadd
  if vim.bo.suffixesadd == nil or vim.bo.suffixesadd == '' then
    vim.bo.suffixesadd = ext
  elseif not vim.bo.suffixesadd:match(ext) then
    vim.bo.suffixesadd = vim.bo.suffixesadd .. ',' .. ext
  end
end

function M.create_augroup(autocmds, name)
  vim.cmd('augroup filetype_' .. name)
  vim.cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  vim.cmd('augroup END')
end

return M
