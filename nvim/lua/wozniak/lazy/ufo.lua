return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        require("ufo").setup({
            provider_selector = function(_, filetype, _)
                -- Use LSP folding if available, else fallback to Treesitter
                return { "lsp", "treesitter" }
            end,

            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                -- Optional: customize how folded text looks
                return virtText
            end,
        })

        -- General fold options
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 1
        vim.o.foldenable = true

        -- Keymaps
        vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
        vim.keymap.set("n", "za", "zA", { desc = "Recursive fold toggle" })
        vim.keymap.set("n", "zA", "za", { desc = "Single-level fold toggle" })
    end,
}
