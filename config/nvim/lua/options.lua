-- config/nvim/init.lua

-- Set Neovim options
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.smartindent = true
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.termguicolors = true

-- To show absolute Line numbers
vim.opt.number = true

-- To show relative Line numbers
vim.opt.relativenumber = true

-- Persistent undo (survives closing nvim)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(vim.fn.stdpath("state") .. "/undo", "p")

