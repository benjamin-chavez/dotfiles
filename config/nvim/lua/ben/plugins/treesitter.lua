return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure nvim-ts-autotag FIRST
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_renamce = true,
        enable_close_on_slash = false,
      }, 
    })

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },

      -- enable indentation
      indent = { enable = true },

      -- enable autotagging (w/ nvim-ts-autotag plugin)
      -- autotag = {
      --  enable = true,
      -- },

      -- ensure these language parsers are installed
      ensure_installed = {
        -- Web Development
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",

        -- Programming Languages
        "python",
        "c",
        "c_sharp",
        "java",
        "lua",
        "bash",

        -- Configuration & Data
        "json",
        "yaml",
        "toml",
        "xml",
        "ini",

        -- Python Ecosystem
        "requirements",
        "rst",

        -- Infrastructure & DevOps
        "dockerfile",
        "terraform",
        "bicep",
        "make",

        -- Database
        "sql",

        -- Git
        "diff",
        "git_config",
        "git_rebase",
        "gitignore",

        -- Documentation
        "markdown",
        "markdown_inline",
        "jsdoc",

        -- Neovim
        "vim",
        "vimdoc",
        "query",

        -- Utilities
        "comment",
        "regex",
      },

      -- automatically install missing parsers when entering buffer
      auto_install = true, 
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}

