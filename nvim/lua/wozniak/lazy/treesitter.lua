return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Prefer git for fetching parsers, and use standard C compilers
      local ts_install = require("nvim-treesitter.install")
      ts_install.prefer_git = true
      ts_install.compilers = { "gcc", "clang" }

      -- Main Treesitter configuration
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "lua", "python", "verilog", "vhdl" },
        sync_install = false,
        auto_install = true,

        indent = {
          enable = true,
        },

        highlight = {
          enable = true,

          -- Disable Treesitter dynamically for large files or certain languages
          disable = function(lang, buf)

            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              vim.notify(
                "File larger than 100KB — Treesitter disabled for performance",
                vim.log.levels.WARN,
                { title = "Treesitter" }
              )
              return true
            end
          end,

          -- Keep legacy regex highlighting for Markdown
          additional_vim_regex_highlighting = { "markdown" },
        },

        rainbow = {
            enable = true, 
            extended_mode = true 
        },
      })
    end,
  },

  -- Context plugin (shows sticky function/class headers)
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        line_numbers = true,
        mode = "cursor",
        multiline_threshold = 20,
        trim_scope = "outer",
        zindex = 20,
        max_lines = 0, -- no limit
        separator = nil,
      })
    end,
  },
}
