package = "tiktoken_core"
version = "0.1.0-1"

source = {
    url = "git+https://github.com/gptlang/tiktoken.lua",
    tag = "v0.1.0",
}

description = {
    summary = "An experimental port of OpenAI's Tokenizer to lua",
    detailed = [[
        The Lua module written in Rust that provides Tiktoken support for Lua.
    ]],
    homepage = "https://github.com/gptlang/tiktoken.lua",
    license = "MIT"
}

dependencies = {
    "lua >= 5.4",
    "luarocks-build-rust-mlua",
}

build = {
    type = "rust-mlua",
    modules = {
        "tiktoken_core"
    },
}
