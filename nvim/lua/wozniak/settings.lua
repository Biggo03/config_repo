vim.opt.number = true              -- Show absolute line numbers on the left
vim.opt.relativenumber = true      -- Show relative numbers for easier motion commands
vim.opt.cursorline = true          -- Highlight the line where the cursor is located
vim.opt.scrolloff = 8              -- Keep 8 lines of context visible above/below the cursor
vim.opt.colorcolumn = "125"        -- Draw a vertical guide at column 125 (e.g., long line warning)
vim.opt.showmatch = true           -- Briefly jump to matching bracket or parenthesis

vim.opt.ignorecase = true          -- Make searches case-insensitive by default
vim.opt.smartcase = true           -- But if the search includes uppercase letters, make it case-sensitive
vim.opt.hlsearch = true            -- Highlight all matches of the last search
vim.opt.incsearch = true           -- Show partial matches as you type your search pattern

vim.opt.tabstop = 4                -- Display width of a tab character
vim.opt.shiftwidth = 4             -- Number of spaces used for each step of indentation
vim.opt.softtabstop = 4            -- How many spaces <Tab> and <Backspace> insert/delete
vim.opt.expandtab = true           -- Converts <Tab> key presses into spaces
vim.opt.smartindent = true         -- Automatically indent new lines smartly based on context

vim.opt.swapfile = false           -- Disable swap files (temporary recovery files)
vim.opt.backup = false             -- Disable backup files (~filename)

vim.opt.updatetime = 50            -- Reduce time (ms) before CursorHold and diagnostics updates
vim.opt.timeoutlen = 500           -- Time (ms) to wait for mapped sequence completion
vim.opt.termguicolors = true       -- Enable full 24-bit RGB colors in the terminal

vim.opt.signcolumn = "yes"         -- Always show the sign column (prevents text shifting)
vim.opt.wrap = false               -- Disable line wrapping
vim.opt.undofile = true            -- Persistent undo across sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
