return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
      vim.notify("File harpooned!!", vim.log.levels.INFO, { title = "Harpoon" })
    end, { desc = 'Add to harpoon' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "List all files in Harpoon" })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<space>%d', idx), function()
        harpoon:list():select(idx)
      end, { desc = 'Select between harpooned files' })
    end
  end,
}
