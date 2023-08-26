local o = vim.opt
local g = vim.g

o.fileencoding = "utf-8"

-- line numbers
-- o.relativenumber = true
o.number = true

-- tabs & indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- line wrapping
o.wrap = false

-- search settings
o.ignorecase = true
o.smartcase = true

-- appearance
o.termguicolors = true
o.background = "dark"
o.cursorline = true
o.cursorlineopt = "line"
o.colorcolumn = "120"
o.signcolumn = "yes"
o.laststatus = 3
o.cmdheight = 0
o.scrolloff = 10
o.pumheight = 10

-- backspace
o.backspace = "indent,eol,start"

-- clipboard
o.clipboard:append("unnamedplus")

-- undo dir
-- Undo dir (persistent undo's)
local undodir = vim.env.HOME .. [[/.cache/nvim/undo]]
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir)
end
g.undodir = undodir
g.undofile = true

-- Nerd tree options
g.loaded = 1
g.loaded_netrwPlugin = 1

-- split windows
o.splitright = true
o.splitbelow = true

-- treat 'a-word' as a single word
o.iskeyword:append("-")
