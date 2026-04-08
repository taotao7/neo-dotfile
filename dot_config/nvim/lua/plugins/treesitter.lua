-- v6 handles treesitter main branch natively, just ensure parsers
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
}
