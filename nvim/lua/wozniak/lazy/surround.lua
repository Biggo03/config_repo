return {
    "kylechui/nvim-surround",

    config = function()
        require("nvim-surround").setup({})

        -- Visual mode mappings so both sides wrap selections
        vim.keymap.set("x", "(", "S(", { desc = "Surround selection with ( )" })
        vim.keymap.set("x", ")", "S(", { desc = "Surround selection with ( )" })

        vim.keymap.set("x", "[", "S[", { desc = "Surround selection with [ ]" })
        vim.keymap.set("x", "]", "S[", { desc = "Surround selection with [ ]" })

        vim.keymap.set("x", "{", "S{", { desc = "Surround selection with { }" })
        vim.keymap.set("x", "}", "S{", { desc = "Surround selection with { }" })

        vim.keymap.set("x", "\"", "S\"", { desc = "Surround selection with \"" })
        vim.keymap.set("x", "'", "S'", { desc = "Surround selection with '" })
    end
}


