vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })  Need to look into this plugin

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a") -- formats around a paragraph without moving the cursor
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>") Need to look into lsp plugin for this to be uesful

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- retains pasted value when pasting over selection

-- options to use the OS clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard (safe)" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard before cursor (safe)" })
vim.keymap.set("x", "p", '"_dP', { desc = "Paste over selection without yanking replaced text" })

vim.keymap.set("n", "<leader>rw", [["_diwP]], { desc = "Replace word with default buffer" })
vim.keymap.set("n", "<leader>rW", [["_diw"+P]], { desc = "Replace word with system clipboard" })

-- Delete without affecting registers
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set("n", "X", '"_X', { desc = "Delete character before cursor without yanking" })

-- Keep visual selection after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d") -- deletes text without copying to clipboard

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- sets up replacement for word selected in visual mode
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })              -- makes the current file executable

vim.keymap.set("n", "<leader><leader>", function() -- sources current file
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>*", function() -- Highlight current word and jump to next occurance
  local word = vim.fn.expand("<cword>")
  vim.cmd("silent! /\\V\\<" .. word .. "\\>")
end, { desc = "Search for word under cursor" })

vim.keymap.set("n", "<leader>8", function() -- Highlight current word without moving
  local word = vim.fn.expand("<cword>")
  vim.fn.setreg("/", "\\V\\<" .. word .. "\\>")
  vim.opt.hlsearch = true
end, { desc = "Highlight word under cursor" })

vim.keymap.set("n", "<leader><C-v>", function()
  local clip = vim.fn.getreg("+")
  vim.api.nvim_feedkeys(":" .. clip, "n", false)
end, { desc = "Paste clipboard into command line" })

vim.keymap.set("n", "<leader><C-f>", function()
  local clip = vim.fn.getreg("+")               -- get system clipboard text
  vim.fn.setreg("/", "\\V" .. vim.fn.escape(clip, "\\/"))  -- set search register (very nomagic)
  vim.opt.hlsearch = true                       -- highlight matches
  vim.cmd("normal! n")                          -- jump to next match
end, { desc = "Search for clipboard contents" })
