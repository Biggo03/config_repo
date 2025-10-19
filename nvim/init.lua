require("wozniak.remap")
require("wozniak.settings")
require("wozniak.lazy_init")

-- ==========================
--  Custom filetypes
-- ==========================
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sv",
  command = "set filetype=verilog",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.v",
  command = "set filetype=verilog",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.vhd", "*.vhdl" },
  command = "set filetype=vhdl",
})
