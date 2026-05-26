return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "c", "c_sharp", "fsharp" },
      highlight = {
        enable = true,
        -- This ensures we only use Treesitter and don't wait for old Vim regex
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- MODERN SYNTAX: No '.configs' anymore
      require("nvim-treesitter").setup(opts)
    end,
  },
}
