return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Define the on_attach function to handle custom mappings
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mapping: l acts like edit (Enter)
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach, -- Register the mappings
      view = {
        width = 30,
        side = "left",
      },
      actions = {
        open_file = {
          window_picker = {
            chars = "ASDFHJKL",
          },
        },
      },
    })
  end,
  keys = {
    { "<leader><leader>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
  },
}
