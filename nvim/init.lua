-- ----------------------------------------------------------------
-- General configuration
-- ----------------------------------------------------------------
-- Use hybrid line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse in normal, visual, insert, and command-line modes.
vim.opt.mouse = "a"

-- Highlight the line of the cursor.
vim.opt.cursorline = true

-- Disable text wrapping.
vim.opt.wrap = false

-- Use spaces.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Split windows to the right and below of the current one.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable list mode for tabs and trailing spaces.
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
}
vim.opt.list = true

-- Disable built-in mode (use lualine instead).
vim.opt.showmode = false

-- ----------------------------------------------------------------
-- Keymap settings
-- ----------------------------------------------------------------
vim.g.mapleader = " "

-- Faster commands.
vim.keymap.set("n", ";", ":")

-- Open this file.
vim.keymap.set("n", "<leader>ec", "<Cmd>edit $MYVIMRC<CR>")

-- Open netrw.
vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")

-- Write current buffer.
vim.keymap.set("n", "<leader>w", "<Cmd>write<CR>")

-- ----------------------------------------------------------------
-- Plugin list
-- ----------------------------------------------------------------
local plugins = {
  -- Git commands.
  { "tpope/vim-fugitive" },

  -- Colorscheme with tree-sitter support.
  { "EdenEast/nightfox.nvim" },

  -- Status line at the bottom.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}

-- ----------------------------------------------------------------
-- Plugin manager installation
-- ----------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)

-- ----------------------------------------------------------------
-- Plugin config
-- ----------------------------------------------------------------
vim.cmd.colorscheme("carbonfox")

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
