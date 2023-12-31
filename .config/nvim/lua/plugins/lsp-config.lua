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
      ensure_installed = {
        "lua_ls",
        "eslint",
        "tsserver",
        "tailwindcss",
        "pylsp",
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.lua_ls.setup({capabilities = capabilities})
      lspconfig.eslint.setup({capabilities = capabilities})
      lspconfig.tsserver.setup({capabilities = capabilities})
      lspconfig.tailwindcss.setup({capabilities = capabilities})
      lspconfig.pylsp.setup({capabilities = capabilities})
    end
  }
}
