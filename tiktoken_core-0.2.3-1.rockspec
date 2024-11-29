package = "tiktoken_core"
version = "0.2.3-1"

source = {
	url = "git+https://github.com/gptlang/lua-tiktoken",
	tag = "v0.2.3",
}

description = {
	summary = "An experimental port of OpenAI's Tokenizer to lua",
	detailed = [[
        The Lua module written in Rust that provides Tiktoken support for Lua.
    ]],
	homepage = "https://github.com/gptlang/lua-tiktoken",
	license = "MIT",
}

dependencies = {
	"lua >= 5.1",
	"luarocks-build-rust-mlua",
}

build = {
	type = "rust-mlua",
	modules = {
		"tiktoken_core",
	},
}
