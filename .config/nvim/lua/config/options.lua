vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.cmd("au ColorScheme * hi Comment cterm=italic gui=italic") -- This fixed the italics not showing up for some reason
