local base64 = require('base64')
local tiktoken_core = require('tiktoken_core')
local dkjson = require('dkjson')

---Get tiktoken data from cache or download it
-- see if the file exists
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then f:close() end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
	if not file_exists(file) then return {} end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end
local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function load_tiktoken_bpe()
	local tiktoken_data = lines_from('/tmp/cl100k_base.tiktoken')
	if not tiktoken_data then
		return nil
	end
	local bpe = {}
	-- Split tiktoken_data by newline
	for _, line in ipairs(tiktoken_data) do
		local parts = split(line, ' ')
		local token = base64.decode(parts[1])
		local rank = tonumber(parts[2])
		bpe[token] = rank
	end
	return bpe
end

local bpe = load_tiktoken_bpe()
if not bpe then
	print('Failed to load bpe')
	return
end
local special_tokens = {}
special_tokens['<|endoftext|>'] = 100257
special_tokens['<|fim_prefix|>'] = 100258
special_tokens['<|fim_middle|>'] = 100259
special_tokens['<|fim_suffix|>'] = 100260
special_tokens['<|endofprompt|>'] = 100276
local pat_str =
"(?i:'s|'t|'re|'ve|'m|'ll|'d)|[^\\r\\n\\p{L}\\p{N}]?\\p{L}+|\\p{N}{1,3}| ?[^\\s\\p{L}\\p{N}]+[\\r\\n]*|\\s*[\\r\\n]+|\\s+(?!\\S)|\\s+"
tiktoken_core.new(bpe, special_tokens, pat_str)

local result = tiktoken_core.encode('Hello, world!')
print(dkjson.encode(result))
