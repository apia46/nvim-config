
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ','

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.wrap = false

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

require('colors.init')

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
  -- Quickstart configs for LSP
  'https://github.com/neovim/nvim-lspconfig',
  -- Fuzzy picker
  'https://github.com/ibhagwan/fzf-lua',
  -- Enhanced quickfix/loclist
  'https://github.com/stevearc/quicker.nvim',
  -- Git integration
  'https://github.com/lewis6991/gitsigns.nvim',
  -- Treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- File explorering
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-neo-tree/neo-tree.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  -- Color picker
  'https://github.com/uga-rosa/ccc.nvim',
  -- Window management
  'https://github.com/sindrets/winshift.nvim',
  -- Inline errors
  'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
  -- Git integration
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/m00qek/baleia.nvim',
  -- Live server
  'https://git.barrettruth.com/barrettruth/live-server.nvim',
  -- Code actions
  'https://github.com/rachartier/tiny-code-action.nvim',
  -- Lsp autocomplete
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/onsails/lspkind-nvim',
})

require('fzf-lua').setup { fzf_colors = true }
require('quicker').setup {}
require('gitsigns').setup {}

require('nvim-treesitter').install({ 'rust', 'tera', 'html', 'css', 'javascript', 'lua', 'sql' }):wait(300000)

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({virtual_text = false})

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set({'n', 'x'}, '<leader>a', function() require("tiny-code-action").code_action() end, {noremap=true, silent=true})
vim.keymap.set('n', '<leader>c', ':CccPick<cr>', { desc = 'Pick color' })
vim.keymap.set('n', '<leader>n', ':Neotree<cr>', { desc = 'Neotree' })
vim.keymap.set('n', '<leader>g', ':Neogit<cr>', { desc = 'Neogit' })

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = require('lspkind').cmp_format(),
  },
  experimental = {
    ghost_text = true,
  },
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('rust_analyzer', {capabilities = capabilities})
vim.lsp.config('cssls', {capabilities = capabilities})
vim.lsp.config('quick_lint_js', {capabilities = capabilities})
vim.lsp.config('ts_ls', {capabilities = capabilities})

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('cssls')
vim.lsp.enable('quick_lint_js')
vim.lsp.enable('ts_ls')

vim.opt.termguicolors = true
local ccc = require("ccc")
local mapping = ccc.mapping

ccc.setup({
    highlighter = {
	auto_enable = true,
	lsp = true,
    },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust', 'tera', 'html', 'css', 'javascript', 'lua', 'sql' },
    callback = function() vim.treesitter.start() end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

