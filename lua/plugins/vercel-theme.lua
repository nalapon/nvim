return {
  'tiesen243/vercel.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('vercel').setup({
      theme = 'dark',
      transparent = false,
      italics = {
        comments = true,
        keywords = true,
        functions = true,
        strings = true,
        variables = true,
        bufferline = false
      },
      overrides = {}
    })
    vim.cmd.colorscheme('vercel')
  end
}
