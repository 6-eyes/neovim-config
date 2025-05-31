local function keymap(mode, new, map, desc)
	vim.keymap.set(mode, new, map, { desc = desc, noremap = true })
end

if vim.g.neovide then
	--  See `:help wincmd` for a list of all window commands
	keymap('n', '<A-h>', '<C-w><C-h>', 'Move focus to the left window')
	keymap('n', '<A-l>', '<C-w><C-l>', 'Move focus to the right window')
	keymap('n', '<A-j>', '<C-w><C-j>', 'Move focus to the lower window')
	keymap('n', '<A-k>', '<C-w><C-k>', 'Move focus to the upper window')
end

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', 'remove highlighting')
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode') -- escape terminal mode

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

