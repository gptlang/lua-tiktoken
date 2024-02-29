local tiktoken_core = require('tiktoken_core')
local dkjson = require('json')

local special_tokens = {}
special_tokens['<|endoftext|>'] = 100257
special_tokens['<|fim_prefix|>'] = 100258
special_tokens['<|fim_middle|>'] = 100259
special_tokens['<|fim_suffix|>'] = 100260
special_tokens['<|endofprompt|>'] = 100276
local pat_str =
"(?i:'s|'t|'re|'ve|'m|'ll|'d)|[^\\r\\n\\p{L}\\p{N}]?\\p{L}+|\\p{N}{1,3}| ?[^\\s\\p{L}\\p{N}]+[\\r\\n]*|\\s*[\\r\\n]+|\\s+(?!\\S)|\\s+"
tiktoken_core.new("/tmp/cl100k_base.tiktoken", special_tokens, pat_str)

local result = tiktoken_core.encode('Hello, world!')
print(dkjson.encode(result))
