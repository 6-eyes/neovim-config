local options = {
	shiftwidth = 4, -- shift the text
	tabstop = 4, -- default tabspace
	number = true,
	relativenumber = true,
	mouse = "a",
	smarttab = true,
	autoindent = true,
	softtabstop = 4,
	cursorline = true,
	titlestring = "ati-neovide",
	title = true,
	splitbelow = true,
	splitright = true,
	splitkeep = "cursor",
	ignorecase = true,
	numberwidth = 4,
	termguicolors = true,
	textwidth = 0,
	linespace = 3,
	scrolloff = 3,
	mousemoveevent = false,
	signcolumn = "yes:1"
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

if vim.g.neovide then
  vim.o.guifont = "Fira Code:h10"

  local neovide_options = {
	neovide_opacity = 0.85,
	neovide_scroll_animation_length = 0.2,
	neovide_hide_mouse_when_typing = true,
	neovide_theme = "dark",
	neovide_unlink_border_highlights = true,
	neovide_remember_window_size = true,
	neovide_cursor_animation_length = 0.06,
	neovide_cursor_trail_size = 0.7,
	neovide_cursor_unfocused_outline_width = 0.125,
	neovide_cursor_vfx_mode = "railgun",
	neovide_cursor_vfx_particle_density = 10.0,
  }

  for k, v in pairs(neovide_options) do
	vim.g[k] = v
  end
end
