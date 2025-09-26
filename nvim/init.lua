vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.incsearch = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.winborder = "rounded"
vim.o.ignorecase = true
vim.o.cursorcolumn = false
vim.o.smartindent = true

local map = vim.keymap.set

vim.g.mapleader = " "
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map('n', '<leader>s', ':split<CR> :Oil<CR>')
map('n', '<leader>v', ':vsplit<CR> :Oil<CR>')

-- plugins (native)
vim.pack.add({
	{ src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
	-- { src = "https://github.com/OXY2DEV/markview.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, 
	{ src = "https://github.com/ej-shafran/compile-mode.nvim" },
})

map('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("set completeopt+=noselect")

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm completion
    ["<C-Space>"] = cmp.mapping.complete(),           -- manually trigger
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { 
  "texlab", "lua_ls", 
  "ruff", "clangd", "jdtls", "tinymist", "gopls","ocamllsp",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

require("oil").setup()
require("mini.pick").setup()

map('n', '<leader>e', ':Oil<CR>')
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")

vim.g.vimtex_view_method = 'zathura'
map('n', '<leader>k', vim.diagnostic.open_float)

vim.cmd.colorscheme "oxocarbon"

