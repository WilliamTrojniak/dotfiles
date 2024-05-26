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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts);
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts);
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts);
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts);
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts);
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts);
          vim.keymap.set('n', '<leader>co', vim.diagnostic.open_float, opts);

        end,
      })
    end
  }
}
