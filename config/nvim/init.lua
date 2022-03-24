-- region Lua helpers
local initlua = vim.env.HOME .. '/.config/nvim/init.lua' 
local venv = vim.env.HOME .. '/.local/venv/nvim'
local M = {}

function M.create_augroup(autocmds, name)
  vim.cmd('augroup filetype_' .. name)
  vim.cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  vim.cmd('augroup END')
end
-- endregion

vim.cmd("syntax enable")
vim.opt.background = 'light'
vim.cmd("colorscheme solarized")  -- change to brutal once I'm used to using Lua.

-- region Options

vim.g.mapleader = ' '
vim.g.python3_host_prog = venv .. "/bin/python"

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = 'region,endregion'
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.modelines = 0
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.showcmd = true


-- Word wrap
vim.opt.wrap = true
vim.opt.linebreak = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- endregion

-- region Keybindings
local keymap = vim.api.nvim_set_keymap

-- Never let Q be used as a keybinding.
keymap('n', 'Q', '<Nop>', {})

-- Edit vimrc quickly
keymap('n', '<Leader>ev', ':e ' .. initlua .. '<CR>', {noremap=true})
keymap('n', '<Leader>sv', ':source ' .. initlua .. '<CR>', {noremap=true})

-- I don't like o/O leaving me in insert mode.
keymap('n', 'o', 'o<esc>', {noremap=true})
keymap('n', 'O', 'O<esc>', {noremap=true})

-- Make it easier to navigate within vim windows.
keymap('n', '<C-J>', '<C-W><C-J>', {noremap=true})
keymap('n', '<C-K>', '<C-W><C-K>', {noremap=true})
keymap('n', '<C-L>', '<C-W><C-L>', {noremap=true})
keymap('n', '<C-H>', '<C-W><C-H>', {noremap=true})

-- I originally added this as a hack because <C-^> never worked in vim, and now I only know <C-E> as a keystroke to go back to the previous buffer. (:
keymap('n', '<C-E>', '<C-^>', {noremap=true})

-- Turn off highlighting when I need.
keymap('n', '<leader><CR>', ':nohlsearch<CR>', {noremap=True})

-- Use CTRL-J and CTRL-K as CTRL-P and CTRL-N in general (telescope, autocomplete, etc.)
keymap('i', '<C-J>', '<C-N>', {noremap=true})
keymap('i', '<C-K>', '<C-P>', {noremap=true})

-- endregion

-- region Plugins
require "paq" {
  "savq/paq-nvim";
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
  "numToStr/Comment.nvim";
  "averms/black-nvim";
  "neovim/nvim-lspconfig";
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
}

-- Comment.nvim
require('Comment').setup { 
  ignore = '^%s*$',
}
 
-- telescope.nvim
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = "close",
        ["<C-J>"] = "move_selection_next",
        ["<C-K>"] = "move_selection_previous",
      },
    },
  },
}
require'telescope'.load_extension('fzf')

keymap('n', '<C-P>', "<cmd> lua require('telescope.builtin').find_files()<CR>", {noremap=true})
keymap('n', '<Leader>/', "<cmd> lua require('telescope.builtin').live_grep()<CR>", {noremap=true})

M.create_augroup({
  { 'User TelescopePreviewerLoaded', 'unmap!', '<C-K>' },
  { 'User TelescopePreviewerLoaded', 'unmap!', '<C-J>' },
}, 'telescope')

-- LSP

local on_attach = function(client, bufnr)
  local opts = { noremap=true }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

require'lspconfig'.pylsp.setup{ 
  cmd = { venv .. "/bin/pylsp" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}

-- endregion

-- region Language-specific stuff

M.create_augroup({
  { 'Filetype', 'python', 'setlocal', 'tabstop=4', 'shiftwidth=4', 'softtabstop=4' },
  { 'Filetype', 'python', 'nnoremap', '<buffer>', '<leader>f', '<cmd>call Black()<CR>' },
}, 'python')

-- endregion
