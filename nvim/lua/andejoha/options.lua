local opt = vim.opt

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Line numbers
opt.nu = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- GUI
opt.termguicolors = true
opt.cursorline = true

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Slip windows
opt.splitright = true
opt.splitbelow = true
