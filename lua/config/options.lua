local opt = vim.opt

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

opt.number         = true           -- Show line numbers
opt.relativenumber = true   -- Relative line numbers
opt.clipboard  = "unnamedplus"
opt.shiftwidth     = 4          -- Size of an indent
opt.tabstop        = 4             -- Number of spaces tabs count for
opt.expandtab      = true        -- Use spaces instead of tabs
opt.smartindent    = true      -- Insert indents automatically
opt.ignorecase     = true       -- Ignore case in search patterns
opt.smartcase      = true        -- Unless search has a capital letter
opt.termguicolors  = true    -- True color support
opt.autoread       = true

-- Force Neovim to recognize F# extensions
vim.filetype.add({
  extension  = {
    fs       = "fsharp",
    fsi      = "fsharp",
    fsx      = "fsharp",
    fsscript = "fsharp",
  },
})



