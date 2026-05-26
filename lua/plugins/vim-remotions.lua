return {
  "vds2212/vim-remotions",
  event = { "BufRead", "BufWinEnter", "BufNewFile" },
  config = function()
    -- Configure which motions should be repeatable.
    -- "forward" values like "^", "^^", "^w" are intentional non-motion placeholders:
    -- vim-remotions requires both directions, so these disable forward-repeat for line/word/char.
    vim.g.remotions_motions = {
      -- Line motions (j/k) - only repeatable with count > 1 (e.g., 10k, 5j)
      line = {
        backward = "k",  -- Keep natural direction
        forward = "^",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },

      line2 = {
        backward = "j",  -- Keep natural direction
        forward = "^^",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },
      -- Word motions - only repeatable with count > 1
      word = {
        backward = "b",  -- Keep natural direction
        forward = "^^^",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },

      word2 = {
        backward = "w",  -- Keep natural direction
        forward = "^^^^^",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },

      -- Character motions (h/l) - only repeatable with count > 1
      char = {
        backward = "l",  -- Keep natural direction
        forward = "^w",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },
      
      char2 = {
        backward = "h",  -- Keep natural direction
        forward = "^e",   -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },
      
      -- End of word motion
      wordend = {
        backward = "e",  -- Keep natural direction
        forward = "ge",    -- Keep natural direction
        repeat_if_count = 1,
        repeat_count = 1,
      },
      
      -- Paragraph motions (always repeatable)
      para = { backward = "}", forward = "{" },  -- Swapped
      
      -- Sentence motions (always repeatable)
      sentence = { backward = ")", forward = "(" },  -- Swapped
      
      -- Page motions
      page = { backward = "<C-d>", forward = "<C-u>" },  -- Swapped
      
      -- Method jumps (useful for code navigation)
      method = { backward = "]m", forward = "[m" },  -- Swapped
    }
    
    -- Optional: Set direction to document flow (forward = down/right)
    -- If not set, direction follows the initial motion (Vim default)
    vim.g.remotions_direction = 1
  end,
}
