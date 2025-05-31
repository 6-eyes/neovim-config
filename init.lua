local packages = {
    "options",
	"keymaps",
	"setup",
	"telescope",
	"lsp"
}

local user = 'pn00'

for _, package in ipairs(packages) do
    require(user .. '.' .. package)
end
