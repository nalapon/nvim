return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { 'BufReadPost', "BufNewFile" },
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",

  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    require("nvim-autopairs").setup()

    -- Integrate nvim-autopairs with cmp
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    require('luasnip.loaders.from_vscode').lazy_load()

    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp",               group_index = 1 },                     -- lsp
        { name = "buffer",                 max_item_count = 5, group_index = 2 }, -- text within current buffer
        { name = "path",                   max_item_count = 3, group_index = 3 }, -- file system paths
        { name = "luasnip",                max_item_count = 3, group_index = 5 }, -- snippets
        { name = "nvim-lsp-signature-help" },
      }),
      formatting = {
        expandable_indicator = true,
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[PATH]",
            luasnip = "[LuaSnip]",
          },
        }),
      },
    }
  end,
}
