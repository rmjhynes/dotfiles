return {
  "stevearc/conform.nvim",
  -- Load on first format invocation (or when inspecting setup)
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        -- async = true returns immediately; the buffer updates when done.
        -- lsp_fallback = true means: if no formatter is configured for this
        -- filetype but the attached language server can format, use that.
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- Map filetype -> list of formatters to run, in order.
    -- Each formatter is a CLI binary that conform shells out to;
    -- if the binary isn't installed, conform silently skips it.
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      python = { "black" },
      terraform = { "terraform_fmt" },
      json = { "jq" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
