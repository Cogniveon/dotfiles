return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    -- enable syntax highlighting
    highlight = {
      enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },
    -- ensure these language parsers are installed
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
    },
    -- auto install above language parsers
    auto_install = true,
    incremental_selection = {
      enable = true,
      keymaps = {
        -- TODO: Adjust keymaps
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
