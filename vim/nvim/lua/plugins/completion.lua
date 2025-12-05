return {

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		-- NOTE: the minuuet source requires minuet
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saghen/blink.cmp",
			"fang2hou/blink-copilot",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)

			-- enabled = function()
			--   return true
			-- end,
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "none",
				-- ["<A-y>"] = require("minuet").make_blink_map(),
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				-- ["<Tab>"] = { "accept" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },

			-- snippets = { preset = "luasnip" },

			-- (Default) Only show the documentation popup when manually triggered
			-- completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },

				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			completion = {
				keyword = {
					range = "prefix",
				},

				ghost_text = {
					enabled = true,
				},

				documentation = {
					auto_show = true,
					auto_show_delay = 500,
				},

				trigger = {
					prefetch_on_insert = true,
				},

				menu = {

					draw = {
						treesitter = { "lsp" },

						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
						padding = { 0, 1 }, -- padding only on right side
						components = {
							kind_icon = {
								text = function(ctx)
									return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
								end,
							},
							source_name = {
								width = { max = 30 },
								text = function(ctx)
									return "[" .. ctx.source_name .. "]"
								end,
								highlight = "BlinkCmpSource",
							},
						},
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			-- fuzzy = { implementation = "lua" },
		},
		opts_extend = { "sources.default" },
	},
}
