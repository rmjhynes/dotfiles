return {
  {
    "Mofiqul/dracula.nvim",
    -- Priority ensures it loads the colour scheme first
    -- before anything else
    priority = 1000,
    config = function()
      -- Configure dracula theme after it's loaded
      require("dracula").setup({
        transparent_bg = true,
      })
      vim.cmd.colorscheme("dracula")
    end,
  },
}
