return {
  'rose-pine/neovim',
  priority = 1000,
  name = 'rose-pine',
  init = function()
    vim.cmd.colorscheme 'rose-pine'
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  end,
  config = function()
    require('rose-pine').setup {
      disable_background = true,
      styles = {
        italic = false,
      },
    }
  end,
}
