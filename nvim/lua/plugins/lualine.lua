return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },  -- If you want icons
  config = function()
    -- Lualine Setup
    require('lualine').setup {
      options = {
        theme = 'dracula',  -- Choose a theme like 'gruvbox', 'onedark', 'nord', etc.
        section_separators = {'', ''},  -- Remove section separators
        component_separators = {'', ''}, -- Remove component separators
        icons_enabled = true,  -- Enable icons for filetypes and other sections
      },
      sections = {
        lualine_a = {'mode'},           -- Current mode (INSERT, NORMAL, etc.)
        lualine_b = {'branch'},         -- Git branch
        lualine_c = {'filename'},       -- Current filename
        lualine_x = {},  -- File info
        lualine_y = {'filetype'},      -- Progress percentage
        lualine_z = {'location'},       -- Cursor location (line:column)
      },
      -- inactive_sections = {
      --   lualine_a = {'mode'},           -- Same as active sections for inactive buffers
      --   lualine_b = {'branch'},
      --   lualine_c = {'filename'},
      --   lualine_x = {}, 
      --   lualine_y = {'filetype'},
      --   lualine_z = {'location'},
      -- },
      tabline = {},  -- Optionally configure the tabline here
      extensions = {},  -- Add extensions (Git, File Explorer, etc.)
    }
  end
}
