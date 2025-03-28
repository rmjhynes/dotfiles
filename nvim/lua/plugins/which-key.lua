return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Load plugin lazily after the editor UI starts
  config = function()
    local wk = require("which-key")
    -- Register keymaps
    wk.add({
      { "<leader>f", group = "File" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },

      { "<leader>g", group = "Comment" },
      { "<leader>g<space>", "<cmd>lua require('Comment.api').toggle_linewise_op()<CR>", desc = "Toggle linewise comment" },
      { "<leader>gC", "<cmd>lua require('Comment.api').toggle_block_comment()<CR>", desc = "Toggle block comment" },
      { "<leader>ga", "<cmd>lua require('Comment.api').toggle_current_word()<CR>", desc = "Toggle comment on current word" },
      { "<leader>gc", "<cmd>lua require('Comment.api').toggle_current_line_comment()<CR>", desc = "Toggle comment on current line" },

      { "<leader>b", group = "Buffer" },
      { "<leader>ba", "<cmd>buffers<CR>", desc = "List buffers" },
      { "<leader>bn", "<cmd>bnext<CR>", desc = "Go to next buffer" },
      { "<leader>bp", "<cmd>bprev<CR>", desc = "Go to previous buffer" },
      { "<leader>bf", "<cmd>bfirst<CR>", desc = "Go to the first buffer" },
      { "<leader>bl", "<cmd>blast<CR>", desc = "Go to the last buffer" },
      { "<leader>bo", "<cmd>b#<CR>", desc = "Go to last visited buffer" },
      { "<leader>b <number>", "test", desc = "Go to buffer <id>" }
    })
  end
}

