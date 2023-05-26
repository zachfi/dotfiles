local opts = {
	settings = {
		gopls = {
			-- buildFlags = { "-tags=requires_docker" }, -- custom build flags
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			staticcheck = true,
			codelenses = {
				upgrade_dependency = true,
				run_govulncheck = true,
				tidy = true,
				vendor = true,
			},

			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},

			gofumpt = true,
		},
	},
	init_options = {
		usePlaceholders = true,
	},
}

return opts
