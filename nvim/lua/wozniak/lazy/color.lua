return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        integrations = {
          treesitter = true,
          ts_rainbow = true,
          context = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
        custom_highlights = function(colors)
          return {
            ["@keyword"] = { fg = colors.mauve, style = { "bold" } },
            ["@keyword.function"] = { fg = colors.mauve, style = { "bold" } },
            ["@conditional"] = { fg = colors.mauve, style = { "bold" } },
            ["@repeat"] = { fg = colors.mauve, style = { "bold" } },
            ["@operator"] = { fg = colors.red },
            ["@function"] = { fg = colors.blue, style = { "bold" } },
            ["@function.call"] = { fg = colors.blue },
            ["@type"] = { fg = colors.yellow, style = { "bold" } },
            ["@type.definition"] = { fg = colors.yellow, style = { "bold" } },
            ["@variable"] = { fg = colors.sky },
            ["@variable.builtin"] = { fg = colors.teal, style = { "italic" } },
            ["@field"] = { fg = colors.sky },
            ["@property"] = { fg = colors.sky },
            ["@constant"] = { fg = colors.peach, style = { "bold" } },
            ["@constant.builtin"] = { fg = colors.peach, style = { "italic" } },
            ["@constant.macro"] = { fg = colors.peach, style = { "bold" } },
            ["@define"] = { fg = colors.peach, style = { "bold" } },
            ["@number"] = { fg = colors.green },
            ["@float"] = { fg = colors.green },
            ["@string"] = { fg = colors.green },
            ["@comment"] = { fg = colors.overlay1, style = { "italic" } },
            ["@preproc"] = { fg = colors.peach, style = { "bold" } },
            ["@include"] = { fg = colors.peach, style = { "bold" } },
            ["@punctuation.delimiter"] = { fg = colors.text },
            ["@punctuation.bracket"] = { fg = colors.text },
            ["@punctuation.special"] = { fg = colors.text },
            ["@label"] = { fg = colors.flamingo },
            ["@namespace"] = { fg = colors.yellow },
            ["@attribute"] = { fg = colors.teal },
          }
        end,
      })

      -- Apply the theme
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
