vim.cmd('highlight clear')
vim.cmd('syntax reset')
vim.o.background = 'dark'
vim.g.colors_name = 'colors'

local set = vim.api.nvim_set_hl

local bg = '#1a173a'

set(0, "Normal", {bg = bg, fg = '#bebec8'})
set(0, "CursorLine", {bg = '#292c4e'})
set(0, "Comment", {bg = bg, fg = '#808099'})
set(0, "String", {bg = bg, fg = '#bbe09f'})
set(0, "Function", {bg = bg, fg = '#e6d08a'})
set(0, "@keyword", {bg = bg, fg = '#eb81d5'})
set(0, "@keyword.modifier", {bg = bg, fg = '#ca93e2'})
set(0, "Number", {bg = bg, fg = '#85d9bb'})
set(0, "@type", {bg = bg, fg = '#6be2c0'})
set(0, "@type.builtin", {bg = bg, fg = '#15d3c4'})
set(0, "@variable", {bg = bg, fg = '#a8afd2'})
set(0, "@variable.parameter", {bg = bg, fg = '#7d88bf'})
set(0, "@constant", {bg = bg, fg = '#d1d5ec'})
set(0, "@operator", {bg = bg, fg = '#bebec8'})
set(0, "@attribute", {bg = bg, fg = '#eb81d5'})
set(0, "@attribute.builtin", {bg = bg, fg = '#eb81d5'})

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
