return {
  -- Add the Dracula colorscheme plugin
  {
    "Mofiqul/dracula.nvim",
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      -- Enable the colorscheme
      vim.cmd("colorscheme dracula")
    end,
  },
}
