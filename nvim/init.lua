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
