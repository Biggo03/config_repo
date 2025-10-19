return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        -- v3 options (see README)
        auto_preview = true,
        auto_refresh = true,
        focus = false,
        restore = true,
        follow = true,
        indent_guides = true, -- renamed from indent_lines
        icons = { -- keep defaults or tweak here
          -- leave empty to use theme defaults
        },
      })

      -- Keymaps for the new API / command
      -- Toggle ALL diagnostics (workspace-ish; see note below)
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle("diagnostics")
      end, { desc = "Trouble: Diagnostics (toggle)" })

      -- Current buffer diagnostics only
      vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>",
        { desc = "Trouble: Buffer Diagnostics" })

      -- Quickfix & Loclist views (handy with test/build tools)
      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Trouble: Quickfix" })
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Trouble: Loclist" })
    end,
  }
}
