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

-- Always show the sign column (left of the line numbers),
-- used for LSP diagnostics, Git signs, breakpoints, etc.,
-- to prevent the text from shifting when signs appear or disappear.
vim.opt.signcolumn = "yes"

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

  -- LSP
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig"
    },
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

-- ----------------------------------------------------------------
-- LSP config
-- ----------------------------------------------------------------
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

-- Settings for lua_ls in Neovim from nvim-lspconfig (see `:h lspconfig-all`).
vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          "${3rd}/luv/library",
          -- "${3rd}/busted/library",
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
