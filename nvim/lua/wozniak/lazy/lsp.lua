return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Core LSP and tooling management
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",

    -- Completion engine and sources
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- Snippet support
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Formatting
    "stevearc/conform.nvim",
  },

  config = function()
    -- =====================================================
    --  General Formatting (via Conform)
    -- =====================================================
    require("conform").setup({
        formatters_by_ft = {
            verilog = { "verible-verilog-format" },
            sh = { "shfmt" },
        },
    })

    -- =====================================================
    --  Setup capabilities for autocompletion
    -- =====================================================
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- =====================================================
    --  UI Feedback (progress notifications)
    -- =====================================================
    require("fidget").setup({})

    -- =====================================================
    --  Mason setup: server installation and management
    -- =====================================================
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "verible",        -- SystemVerilog/Verilog formatter/linter
        "lua_ls",         -- Lua (for your Neovim config)
      },
      handlers = {
        -- Default handler (for servers not customized below)
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Python: Pyright
        ["pyright"] = function()
          require("lspconfig").pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoImportCompletions = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,

        -- Bash: bash-language-server
        ["bashls"] = function()
          require("lspconfig").bashls.setup({
            capabilities = capabilities,
            filetypes = { "sh", "bash" },
          })
        end,

        -- Lua (Neovim config)
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,
      },
    })

    -- =====================================================
    --  Completion engine setup (nvim-cmp)
    -- =====================================================
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })

    -- =====================================================
    --  Diagnostic UI configuration
    -- =====================================================
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      virtual_text = {
        spacing = 2,
        prefix = "●",
      },
      severity_sort = true,
    })
  end,
}
