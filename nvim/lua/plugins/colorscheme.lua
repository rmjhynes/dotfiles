return {
  -- add dracula
  { "Mofiqul/dracula.nvim" },

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
