-- Source Settings and Functions
vim.cmd('source ~/.config/nvim/vimscript/settings.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

-- Source keymappings
require('keymappings')

-- Set Colorscheme
vim.cmd('colorscheme nord')
--vim.cmd('set background=dark')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE') -- enable transparency

-- Source Plugins
require('plugins')
require('configs.nvimtree')
require('configs.gitsigns')
