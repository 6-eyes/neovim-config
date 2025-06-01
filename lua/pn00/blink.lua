local status_ok, blink = pcall(require, 'blink.cmp')
if not status_ok then
	return
end

blink.setup({
	keymap = {
      preset = 'none',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
    },
    
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    
    sources = {
      default = { 'lsp', 'path' },
    },
    
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        auto_show = true,
        border = 'rounded',
        draw = {
          columns = { { "label"  }, { "kind_icon", "kind" } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },
})
