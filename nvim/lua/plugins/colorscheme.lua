return {
  -- add dracula
  {
    "Mofiqul/dracula.nvim",
        config = function()
      -- Configure dracula theme after it's loaded
      require("dracula").setup({
        transparent_bg = true
      })
    end
  },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    -- Priority ensures it loads the colour scheme first
    -- before anything else
    priority = 1000,
    opts = {
      colorscheme = "dracula",
    },
  },
}
