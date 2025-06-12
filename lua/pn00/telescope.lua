local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')

local extensions = {
	'file_browser',
	'media_files',
	'fzf'
}

for _, extension in ipairs(extensions) do
      pcall(telescope.load_extension, extension)
end

telescope.setup({
	-- You can put your default mappings / updates / etc. in here
	--  All the info you're looking for is in `:help telescope.setup()`

	defaults = {
		initial_mode = "normal",
	},
	pickers = {
		buffers = {
			attach_mappings = function(prompt_bufnr, map)
				local delete_buf = function()
					local selection = actions_state.get_selected_entry()
					actions.close(prompt_bufnr)
					vim.api.nvim_buf_delete(selection.bufnr, { force = false })
				end
				map('n', 'dd', delete_buf)
				return true
			end
		}
	},
})


local function keymap(mode, new, map, desc)
	vim.keymap.set(mode, new, map, { desc = desc, noremap = true })
end

local status_ok, builtin = pcall(require, "telescope.builtin")
if status_ok then
	keymap('n', '<leader>fh', builtin.help_tags, '[F]ind [H]elp')
	keymap('n', '<leader>fk', builtin.keymaps, '[F]ind [K]eymaps')
	keymap('n', '<leader>ff', function()
		builtin.find_files({ hidden = true, file_ignore_patterns = { "%.git/" } })
	end, '[F]ind [F]iles')
	keymap('n', '<leader>ft', builtin.builtin, '[F]ind [T]elescope')
	keymap('n', '<leader>fw', builtin.grep_string, '[F]ind current [W]ord')
	keymap('n', '<leader>fg', builtin.live_grep, '[F]ind by [G]rep')
	keymap('n', '<leader>fd', builtin.diagnostics, '[F]ind [D]iagnostics')
	-- keymap('n', '<leader>sr', builtin.resume, '[S]earch [R]esume')
	keymap('n', '<leader>f.', builtin.oldfiles, '[F]ind in Recent Files')
	keymap('n', '<leader>fb', builtin.buffers, '[ ] Find existing buffers')

	-- live grep
	keymap('n', '<leader>f/', function()
	builtin.live_grep {
	  grep_open_files = true,
	  prompt_title = 'Live Grep in Open Files',
	}
	end, '[F]ind in Open Files [/]')
end
