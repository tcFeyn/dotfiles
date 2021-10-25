local opt = { noremap = true, silent = true }

-- Set leader key to space
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', opt)
vim.g.mapleader = ' '

-- Remove highlighting from search
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', opt)

-- Better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true })

-- Better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', opt)
vim.api.nvim_set_keymap('v', '>', '>gv', opt)

-- Toogle auto comment
--vim.api.nvim_set_keymap('n', '<Leader>c', ':setlocal formatoptions-=cro<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<Leader>C', ':setlocal formatoptions=cro<CR>', { noremap = true })

-- Toogle auto indent
vim.api.nvim_set_keymap('n', '<Leader>i', ':setlocal autoindent<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>I', ':setlocal noautoindent<CR>', { noremap = true })

-- Toogle wrap
vim.api.nvim_set_keymap('n', '<Leader>w', ':setlocal wrap<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>W', ':setlocal nowrap<CR>', { noremap = true })

-- Find and replace text
vim.api.nvim_set_keymap('n', '<Leader>r', ':%s//<left>', { noremap = true })

-- Move in buffer
vim.api.nvim_set_keymap('n', '<C-j>f', ':bnext<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-k>f', ':bprevious<CR>', opt)

-- Rezise
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -5<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +5<CR>', opt)
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -5', opt)
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +5', opt)

-- SLIPTS
vim.api.nvim_set_keymap('n', '<Leader>hs', ':split<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>vs', ':vsplit<CR>', opt)
--vim.api.nvim_set_keymap('n', '<Leader>t<CR>', ':split term://zsh<CR>', opt )

-- Move selected line of text in visual mode
vim.api.nvim_set_keymap('v', 'J', ':m \'>+1<CR>gv=gv', opt)
vim.api.nvim_set_keymap('v', 'K', ':m \'<-2<CR>gv=gv', opt)

-- Tabs
vim.api.nvim_set_keymap('n', '<TAB>', ':tabnew<CR>', opt)
vim.api.nvim_set_keymap('n', '<A-l>', ':tabn<CR>', opt)
vim.api.nvim_set_keymap('n', '<A-h>', ':tabp<CR>', opt)
vim.api.nvim_set_keymap('n', '<A-k>', ':tabmove + <CR>', opt)
vim.api.nvim_set_keymap('n', '<A-j>', ':tabmove - <CR>', opt)
