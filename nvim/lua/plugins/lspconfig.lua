return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Servers to install via Mason and enable via lspconfig.
      -- Add or remove entries here; the rest of the file picks them up automatically.
      local servers = {
        -- Lua: tuned for editing this Neovim config (recognises `vim` global)
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        gopls = {},
        pyright = {},
        terraformls = {},
      }

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- Tell each server what completion features the editor supports,
      -- so cmp can request them. Without this, LSP completion is degraded.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Neovim 0.11+ API: register per-server settings, then enable them.
      -- nvim-lspconfig still ships the defaults (cmd, filetypes, root_dir);
      -- vim.lsp.config() merges our overrides on top.
      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        vim.lsp.config(name, opts)
      end
      vim.lsp.enable(vim.tbl_keys(servers))

      -- How diagnostics (errors/warnings) are rendered in the buffer
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        signs = true,
      })

      -- Keymaps that should only exist when a language server is attached
      -- to the current buffer. Triggered per-buffer on attach.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "Find references")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })
    end,
  },
}
