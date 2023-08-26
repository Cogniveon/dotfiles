vim.g.mapleader = " "

local keymap = vim.keymap

-- general
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>")

-- Do not copy to register for 'c' or 'x', only for 'd'
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set({ "n", "v" }, "c", '"_c')

keymap.set("n", "y", '"+y')
keymap.set("v", "y", '"+y')
-- Yank till line end
keymap.set("n", "Y", '"+yg_')

-- Do not exit visual mode after indenting
keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")

-- Fix accidental line joining during visual block selection
keymap.set("v", "J", "j")
keymap.set("v", "K", "k")

-- Up/Down with Alt+j/k
keymap.set("", "<A-j>", ":m .+1<CR>==")
keymap.set("", "<A-k>", ":m .-2<CR>==")

-- Up/Down with Alt+Arrow keys
keymap.set("", "<A-Down>", ":m .+1<CR>==")
keymap.set("", "<A-UP>", ":m .-2<CR>==")

keymap.set("n", "<S-Tab>", ":bprevious<CR>")
keymap.set("n", "<Tab>", ":bnext<CR>")

-- split pane vertically
keymap.set("n", "<leader>v", "<C-w>v")
-- split pane horizontally
keymap.set("n", "<leader>h", "<C-w>s")
-- close current pane
keymap.set("n", "<leader>x", "<cmd>close<CR>")

-- open new tab
keymap.set("n", "<leader>to", ":tabnew<CR>")
-- close current tab
keymap.set("n", "<leader>tx", ":tabclose<CR>")
-- go to next tab
keymap.set("n", "<leader>tn", ":tabn<CR>")
-- go to previous tab
keymap.set("n", "<leader>tp", ":tabp<CR>")

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>f", "<cmd>lua require('alqaholic.fuzzy_finder').find_files_dropdown()<cr>")
keymap.set("n", "<leader>g", ":Telescope live_grep<CR>")
keymap.set("i", "<C-j>", "<cmd>lua require('alqaholic.snippet').jump_to_next_field()<CR>")
keymap.set("s", "<C-j>", "<cmd>lua require('alqaholic.snippet').jump_to_next_field()<CR>")
keymap.set("i", "<C-k>", "<cmd>lua require('alqaholic.snippet').jump_to_previous_field()<CR>")
keymap.set("s", "<C-k>", "<cmd>lua require('alqaholic.snippet').jump_to_previous_field()<CR>")

-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- keymap.set("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
-- support tagstack C-t jump back
-- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
-- keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
-- keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")

-- Diagnsotic jump can use `<c-o>` to jump back
-- keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Only jump to error
-- keymap.set("n", "[E", "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })")
-- keymap.set("n", "]E", "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })")

-- Outline
-- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>")

-- Hover Doc
-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- GitSigns preview hunk
-- keymap.set("n", "<leader>gh", "<cmd>GitSigns preview_hunk_inline<CR>")

