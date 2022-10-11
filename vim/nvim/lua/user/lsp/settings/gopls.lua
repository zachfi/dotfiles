local opts = {
	settings = {
		gopls = {
			buildFlags = { "-tags=requires_docker" }, -- custom build flags
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		usePlaceholders = true,
	},
}

return opts
