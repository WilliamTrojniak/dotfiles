return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim"
    },
    opts = {
      -- ensure_installed = lspServers,
      automatic_installation = true,
      handlers = {
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig")[server_name].setup({capabilities = capabilities})
        end
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "folke/neodev.nvim"
    },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      }
    },
    config = function()
      local wk = require("which-key")
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          wk.register({
            K = {vim.lsp.buf.hover, "hover", buffer = ev.buf},
            g = {
              D = {vim.lsp.buf.declaration, "Go to declaration", buffer = ev.buf},
              d = {vim.lsp.buf.definition, "Go to definition", buffer = ev.buf},
              i = {vim.lsp.buf.implementation, "Go to implemention", buffer = ev.buf},
              t = {vim.lsp.buf.type_definition, "Go to type definition", buffer = ev.buf},
            },
            ['<leader>ca'] = {vim.lsp.buf.code_action, "View actions", buffer = ev.buf},
            ['<leader>co'] = {vim.diagnostic.open_float, "Open float", buffer = ev.buf}
          })
        end,
      })
    end
  }
}
