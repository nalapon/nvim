return { -- Autoformat
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  lazy = true,
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer with injected Langs',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      fish = { 'fish_indent' },
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt', 'goimports-reviser' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      vue = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      less = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      jsonc = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      ['markdown.mdx'] = { { 'prettierd', 'prettier' } },
      graphql = { { 'prettierd', 'prettier' } },
      handlebars = { { 'prettierd', 'prettier' } },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
}
