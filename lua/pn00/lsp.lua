local M = {}

function M.setup()
    --  This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
		callback = function(event)
		  -- In this case, we create a function that lets us more easily define mappings specific
		  -- for LSP related items. It sets the mode, buffer and description for us each time.
			local map = function(keys, func, desc, mode)
				mode = mode or 'n'
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
			end

			-- Execute a code action, usually your cursor needs to be on top of an error
			-- or a suggestion from your LSP for this to activate.
			map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

			-- Find references for the word under your cursor.
			map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

			-- Jump to the implementation of the word under your cursor.
			--  Useful when your language has ways of declaring types without an actual implementation.
			map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

			-- Jump to the definition of the word under your cursor.
			--  This is where a variable was first declared, or where a function is defined, etc.
			map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

		  -- WARN: This is not Goto Definition, this is Goto Declaration.
		  --  For example, in C this would take you to the header.
			map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

		  -- Fuzzy find all the symbols in your current document.
		  --  Symbols are things like variables, functions, types, etc.
		  map('go', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

		  -- Jump to the type of the word under your cursor.
		  --  Useful when you're not sure what type a variable is and you want to see
		  --  the definition of its *type*, not where it was *defined*.
		  -- map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

		  vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover { border = "rounded" }
		  end, { buffer = event.buf, silent = true })
		end,
	})
	-- diagnostic config
    vim.diagnostic.config({
		severity_sort = true,
		float = { border = 'rounded' },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = vim.g.have_nerd_font and {
		  text = {
			  [vim.diagnostic.severity.ERROR] = '󰅚 ',
			  [vim.diagnostic.severity.WARN] = '󰀪 ',
			  [vim.diagnostic.severity.INFO] = '󰋽 ',
			  [vim.diagnostic.severity.HINT] = '󰌶 ',
		  },
		} or {},
		virtual_text = {
		  source = 'if_many',
		  spacing = 2,
		  format = function(diagnostic)
		  local diagnostic_message = {
			[vim.diagnostic.severity.ERROR] = diagnostic.message,
			[vim.diagnostic.severity.WARN] = diagnostic.message,
			[vim.diagnostic.severity.INFO] = diagnostic.message,
			[vim.diagnostic.severity.HINT] = diagnostic.message,
		  }
		  return diagnostic_message[diagnostic.severity]
		  end,
		},
	  })

	local servers = {
		clangd = {},
		rust_analyzer = {},
		bashls = {},
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = 'Replace' }
				}
			}
		},
	}

	local ensure_installed = vim.tbl_keys(servers or {})
	local capabilities = require('blink.cmp').get_lsp_capabilities()

	require('mason-tool-installer').setup { ensure_installed = ensure_installed }
	require('mason-lspconfig').setup({
		ensure_installed = {},
		automatic_enable = true,
		handlers = {
			function(server_name)
				local on_attach = function(client, bufnr)
					if client.server_capabilities.semanticTokensProvider then
						vim.lsp.semantic_tokens.start(buf, client.id)
					end
				end
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
				server.on_attach = on_attach
				server.handlers = {
					["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					  border = "rounded"
    }),
				}
				require('lspconfig')[server_name].setup(server)
			end
		},
	})
end
		
return M
-- end
