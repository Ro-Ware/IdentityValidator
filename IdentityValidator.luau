-- aaa 2024 @ discord.gg/t3MFQPdA5g | discord handle: @dijg
-- please dont skid :rawr:
-- sorry for 🍝 code!!
--
-- credits:
--	- UNC Test: UNCCheckEnv @ https://github.com/unified-naming-convention/NamingStandard/blob/main/UNCCheckEnv.lua
--  - MoreUNC v2.0.0, @ https://rawscripts.net/raw/Universal-Script-MoreUNC-V2-15902
--

local getthreadidentity = getthreadidentity or getidentity or getthreadcontext or nil
local iscclosure = iscclosure or function(f) return debug.info(f, "s") == "[C]" end

-- vv printidentity lvl
local PrintidentityLevel = 0

local LogConn = game:GetService("LogService").MessageOut:Connect(function(msg)
    if msg:split("Current identity is ")[2] == nil then return end
    PrintidentityLevel = tonumber(msg:split("Current identity is ")[2])
end)

printidentity();task.wait(0.2);
LogConn:Disconnect()
-- ^^ printidentity lvl

-- vv https://github.com/unified-naming-convention/NamingStandard/blob/main/UNCCheckEnv.lua#L16
local passes, fails, unsupported = 0, 0, 0
local running = 0
local not_supported = "Unsupported"

local function test(method, callback)
	running += 1

	task.spawn(function()
		if not callback then
			print("⏺️ " .. method)
		else
			local success: boolean, message: string = pcall(callback)

			if success then
				passes += 1
				print("✅ " .. method)
			elseif message == not_supported then
				unsupported += 1
                print("⏺️ " .. method .. " is not supported")
            else
				fails += 1
				warn("⛔ " .. method .. " • " .. message)
			end
		end

		running -= 1
	end)
end

print("\n")

print("IdentityValidator | Credits to UNCCheckEnv")
print("✅ - Pass, ⛔ - Fail, ⏺️ - Unsupported\n")

task.defer(function()
	task.wait(0.5) -- bru-

	local rate = math.round(passes / (passes + fails) * 100)
	local outOf = passes .. " out of " .. (passes + fails)

	print("\n")

	print("UNC Summary")
	print("✅ Tested with a " .. rate .. "% success rate (" .. outOf .. ")")
	print("⛔ " .. fails .. " tests failed")
	print("⏺️ " .. unsupported .. " unsupported functions")
end)
-- ^^ https://github.com/unified-naming-convention/NamingStandard/blob/main/UNCCheckEnv.lua#L16

-- printidentitylowargs
test("printidentitylowargs", function()
	local success = false 

	local LogConn = game:GetService("LogService").MessageOut:Connect(function(msg)
        if msg:match("IdentityValidator\|(.*)") then
			success = true
		end
    end)
    
    printidentity("IdentityValidator|");task.wait(0.05);
    LogConn:Disconnect()

	if not success then return error("printidentity is missing prefix argument") end
end)

-- prntidentityclosure	
test("printidentitycclosure", function()
	if not iscclosure(printidentity) then
		return error("printidentity is not a cclosure")
	end
end)

-- getthreadidentity
test("getthreadidentitynotequal", function()
	if not getthreadidentity then return error(not_supported) end

	local identity = getthreadidentity()
	
	if PrintidentityLevel ~= getthreadidentity() then
		return error("printidentity doesnt match getthreadidentity (getidentity=" .. identity .. " print="..PrintidentityLevel..")")
	end
end)

-- invalididentity
test("invalididentity", function()
	if not getthreadidentity then return error(not_supported) end

	local identity = getthreadidentity()

	if PrintidentityLevel > 8 or PrintidentityLevel < 0 then return error("[printidentity] Your executor's spoofed identity is invalid.") end
	if identity > 8 or identity < 0 then return error("[getthreadidentity] Your executor's spoofed identity is invalid.") end
end)

-- identitycheck
test("identitycheck", function()
	local Identity = 0
	local IdentityTable = { -- MoreUNC v2.0.0, @ https://rawscripts.net/raw/Universal-Script-MoreUNC-V2-15902
		{
			lv = 1,
			obtained = pcall(function() return game:GetService("CoreGui").Name end)
		},
		{
			lv = 2,
			obtained = pcall(function() return game.Players["LocalPlayer"].Name end)
		},
		{
			lv = 3,
			obtained = pcall(function() return game.DataCost end)
		},
		{
			lv = 4,
			obtained = pcall(Instance.new, "Player")
		},
		{
			lv = 5,
			obtained = pcall(function() return game:GetService("CorePackages").Name end)
		},
		{
			lv = 6,
			obtained = pcall(function() return Instance.new("SurfaceAppearance").TexturePack end)
		},
		{
			lv = 7,
			obtained = pcall(function() Instance.new("MeshPart").MeshId = "" end)
		} -- there might be a issue with level 8
	}
	
	for i, identity in pairs(IdentityTable) do
		if identity.obtained then
			Identity = identity.lv
		end
	end

	if getthreadidentity then
		local lv = getthreadidentity()

		if lv ~= Identity then
			if lv == 8 and Identity == 7 then return end -- they r the same...
			error("[getthreadidentity] Your executor is claiming to be level " .. lv .. " (expected " .. Identity .. ")")
		end
	end

	if PrintidentityLevel ~= Identity then
		error("[printidentity] Your executor is claiming to be level " .. PrintidentityLevel .. " (expected " .. Identity .. ")")
	end
end)
