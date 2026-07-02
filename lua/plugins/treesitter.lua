return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- lazy.nvim calls require(main).setup(opts). On the `master` branch the
    -- setup entrypoint lives in `nvim-treesitter.configs`, not the top-level
    -- module.
    main = "nvim-treesitter.configs",
    opts = {
      -- `markdown` + `markdown_inline` are required for LSP hover (K): Neovim
      -- renders the doc float as markdown and highlights it with Treesitter.
      -- Without them, hover throws "Parser could not be created ... markdown".
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "c",
        "c_sharp",
        "fsharp",
        "python",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        -- Use only Treesitter; don't also run the old Vim regex highlighter.
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },
}
