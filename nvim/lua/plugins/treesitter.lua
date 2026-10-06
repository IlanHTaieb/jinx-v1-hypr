return {
  -- Pin pour éviter le bug "invalid node type 'tab'"
  -- https://github.com/nvim-treesitter/nvim-treesitter/issues/8369
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "d0bf5ff",
  },
}
