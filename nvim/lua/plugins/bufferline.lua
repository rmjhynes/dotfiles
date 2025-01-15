return {
  'akinsho/bufferline.nvim',
  config = function()
    require("bufferline").setup {
      options = {
        sort_by = 'extension',
        indicator = {
          style = 'icon' -- Display a '|' to indicate current tab (more obvious than using underline)
        },
        buffer_close_icon = '󰅖',
        offsets = {
          {
            filetype = "neo-tree",  -- I currently use neo-tree
            text = "Neo-tree File Explorer",  -- Text that is displayed as the file explorer window heading
            text_align = "center",  -- Alignment of the above text
            highlight = "Directory",
            separator = true,  -- Adds a separator between the bufferline and the sidebar
          },
        },
        numbers = function(opts)
          return string.format('%s', opts.id) -- Prefix buffer name with its id (used to switch between buffers)
        end,
      }
    }
  end,
  version = "*",
  dependencies = {'nvim-tree/nvim-web-devicons'},
}
