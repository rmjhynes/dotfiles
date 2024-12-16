return {
  'akinsho/bufferline.nvim',
  config = function()
    require("bufferline").setup {
      options = {
        sort_by = 'extension',
        indicator = {
          style = 'underline'
        },
        buffer_close_icon = '󰅖',
        offsets = {
          {
            filetype = "Neotree",  -- Change this to the correct sidebar filetype
            text = "File Explorer",  -- This should be a string, or a function that returns a string
            text_align = "center",  -- This can be "left", "center", or "right"
            separator = true,  -- Adds a separator between the bufferline and the sidebar
          },
        },
      }
    }
  end,
  version = "*",
  dependencies = {'nvim-tree/nvim-web-devicons'},  -- Corrected this to be in a table
}
