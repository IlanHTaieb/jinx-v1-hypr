return {
  -- Theme: Tokyo Night avec transparence
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Désactivation des plugins UI non utilisés
  { "akinsho/bufferline.nvim", enabled = false },
}
