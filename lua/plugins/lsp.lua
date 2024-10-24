return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      -- Plugin(s) and UI to automatically install LSPs to stdpath
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Install lsp autocompletions
      "hrsh7th/cmp-nvim-lsp",

      -- Progress/Status update for LSP
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      local M = {}
      M.map_lsp_keybinds = function(buffer_name)
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {desc = "LSP: Hover", buffer = buffer_name})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_name })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
          { desc = "LSP: [C]ode [A]ction", buffer = buffer_name })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_name })
        vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references,
          { desc = "LSP: [G]oto [R]eferences", buffer = buffer_name })
        vim.keymap.set('n', 'gi', require("telescope.builtin").lsp_implementations,
          { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_name })
        vim.keymap.set('n', '<leader>bs', require("telescope.builtin").lsp_document_symbols,
          { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_name })
        vim.keymap.set('n', '<leader>ps', require("telescope.builtin").lsp_workspace_symbols,
          { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_name })
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help,
          { desc = "LSP: Signature Documentation", buffer = buffer_name })
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help,
          { desc = "LSP: Signature Documentation", buffer = buffer_name })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_name })
        vim.keymap.set('n', 'td', vim.lsp.buf.type_definition,
          { desc = "LSP: [T]ype [D]efinition", buffer = buffer_name })
      end


      local default_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      local ts_ls_inlay_hints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      }
      local map_lsp_keybinds = M.map_lsp_keybinds

      -- Function to run when neovim connects to a Lsp client
      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(_client, buffer_number)
        -- Pass the current buffer to map lsp keybinds
        map_lsp_keybinds(buffer_number)
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- LSP Servers
        bashls = {},
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        biome = {},
        eslint = {
          autostart = false,
          cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
          settings = {
            format = false,
          },
        },
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        marksman = {},
        pyright = {},
        ts_ls = {
          settings = {
            maxTsServerMemory = 12288,
            typescript = {
              inlayHints = ts_ls_inlay_hints,
            },
            javascript = {
              inlayHints = ts_ls_inlay_hints,
            },
          },
        },
        yamlls = {},
      }

      local formatters = {
        prettierd = {},
        stylua = {},
        goimports = {},
        goimports_reviser = {},
        golines = {},
      }

      local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

     local ensure_installed = vim.tbl_filter(function(name)
    if manually_installed_servers and #manually_installed_servers > 0 then
        return not vim.tbl_contains(manually_installed_servers, name)
    else
        return true
    end
end, mason_tools_to_install)

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = ensure_installed,
      })

      -- Iterate over our servers and set them up
      for name, config in pairs(servers) do
        require("lspconfig")[name].setup({
          autostart = config.autostart,
          cmd = config.cmd,
          capabilities = capabilities,
          filetypes = config.filetypes,
          handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
          on_attach = on_attach,
          settings = config.settings,
          root_dir = config.root_dir,
        })
      end


      -- Setup mason so it can manage 3rd party LSP servers
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      require("mason-lspconfig").setup()

      -- Configure borderd for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Configure diagnostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end
  }
}

