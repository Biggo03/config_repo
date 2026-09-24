local parsers = {
  "c",
  "cpp",
  "lua",
  "python",
  "systemverilog",
  "perl",
  "vhdl",
}

local treesitter_filetypes = {
  "c",
  "cpp",
  "lua",
  "python",
  "verilog",
  "perl",
  "vhdl",
}

-- Treesitter indentation is not currently provided for every parser above.
local indent_filetypes = {
  c = true,
  cpp = true,
  lua = true,
  python = true,
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      -- Default install location/settings are fine.
      ts.setup({})

      -- Install any parsers that are missing.
      local installed = ts.get_installed("parsers")

      local missing = vim.tbl_filter(function(parser)
        return not vim.list_contains(installed, parser)
      end, parsers)

      if #missing > 0 then
        ts.install(missing):wait(300000)
      end

      -- Treesitter features are now enabled through Neovim itself.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = treesitter_filetypes,

        callback = function(args)
          -- Preserve your old "disable Treesitter for >100 KB files" behavior.
          local filename = vim.api.nvim_buf_get_name(args.buf)

          if filename ~= "" then
            local stats = vim.uv.fs_stat(filename)

            if stats and stats.size > 100 * 1024 then
              vim.notify(
                "File larger than 100KB — Treesitter disabled for performance",
                vim.log.levels.WARN,
                { title = "Treesitter" }
              )
              return
            end
          end

          -- Syntax highlighting.
          vim.treesitter.start(args.buf)

          -- Treesitter indentation where the parser currently supports it.
          local filetype = vim.bo[args.buf].filetype

          if indent_filetypes[filetype] then
            vim.bo[args.buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- Sticky function/class/module context at top of screen.
  {
    "nvim-treesitter/nvim-treesitter-context",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      require("treesitter-context").setup({
        enable = true,
        line_numbers = true,
        mode = "cursor",
        multiline_threshold = 20,
        trim_scope = "outer",
        zindex = 20,
        max_lines = 0,
        separator = nil,
      })
    end,
  },
}
