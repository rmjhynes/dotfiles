return {
  "lewis6991/gitsigns.nvim",
  -- Load when a real file buffer is opened, not on every Neovim launch
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- on_attach runs once per buffer that gitsigns activates on.
    -- Buffer-local keymaps go here so they only exist where they make sense.
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Jump between changed hunks in the current buffer
      map("]c", function() gs.nav_hunk("next") end, "Next git hunk")
      map("[c", function() gs.nav_hunk("prev") end, "Previous git hunk")

      -- Hunk actions under <leader>g
      map("<leader>gp", gs.preview_hunk, "Preview hunk")
      map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("<leader>gs", gs.stage_hunk, "Stage hunk")
      map("<leader>gr", gs.reset_hunk, "Reset hunk")
    end,
  },
}
