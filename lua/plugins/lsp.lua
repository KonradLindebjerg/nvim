return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "clangd", "omnisharp", "fsautocomplete" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- 1. DIAGNOSTICS: Clean underlines with bordered floating windows
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = true,
        float = {
          border = "rounded", -- Makes the error window look cleaner
          source = "always",  -- Shows which LSP (e.g., lua_ls) the error is from
        },
      })

      -- Filter out "Parentheses can be removed" noise from fsautocomplete
      local orig_publish = vim.lsp.handlers["textDocument/publishDiagnostics"]
      vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          if client and client.name == "fsautocomplete" then
            result.diagnostics = vim.tbl_filter(function(d)
              if d.message and d.message:lower():match("parentheses can be removed") then
                return false
              end
              if d.code == 3583 or d.code == "3583" then
                return false
              end
              return true
            end, result.diagnostics)
          end
        end
        return orig_publish(err, result, ctx, config)
      end

      -- 2. KEYMAPS & CAPABILITIES
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- NAVIGATION & INFO
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- NEW: Error Handling Helpers
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Jump to previous error
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Jump to next error
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- Show error details
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- Fix the error
        end,
      })

      -- 3. THE 0.11+ SERVER SETUP
      local servers = { "lua_ls", "clangd", "fsautocomplete", "omnisharp" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = {
            textDocument = {
              semanticTokens = nil,
            },
          },
        })
        vim.lsp.enable(server)
      end
    end,
  },
}
