local packages = {
    "options",
	"keymaps",
	"setup",
	"telescope",
	"lsp",
	"blink",
}

local user = 'pn00'

for _, package in ipairs(packages) do
    require(user .. '.' .. package)
end
