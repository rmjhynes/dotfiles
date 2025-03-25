return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "bash",
            "csv",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "gpg",
            "jq",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "nix",
            "python",
            "query",
            "sql",
            "terraform",
            "tmux",
            "vim",
            "vimdoc",
            "xml",
            "yaml"
          },
          -- Install parsers synchronously
          sync_install = false,

          -- Consistent syntax highlighting
          highlight = {
            enable = true
          },

          -- Indentation based on treesitter for the = operator
          indent = {
            enable = true
          },  
        })
    end
 }
