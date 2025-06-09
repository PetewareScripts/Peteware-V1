--[[
PLEASE READ - IMPORTANT

© 2025 Peteware
This project is part of Peteware V1, an open-source Roblox script collection.

Licensed under the MIT License.  
See the full license at:  
https://github.com/PetewareScripts/Peteware-V1/blob/main/LICENSE

**Attribution required:** You must give proper credit to Peteware when using or redistributing this project or its derivatives.

This software is provided "AS IS" without warranties of any kind.  
Violations of license terms may result in legal action.

Thank you for respecting the license and supporting open source software!

Peteware Development Team
]]

_G.Debug = false -- set to true for debugging

--// Loading Handler
if not game:IsLoaded() then
    game.Loaded:Wait()
    task.wait(1)
end

--// Execution Handler
if _G.Execution then
    pcall(function()
        game:GetService("starterGui"):SetCore("DevConsoleVisible", true)
        warn("[Peteware]: Already Executed, Destroy the UI via the settings tab first if you want to execute again.")
    end)
    return
else
    _G.Execution = true
end
local execution = true

--// Services & Setup
queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
setclip = setclipboard or (syn and syn.setclipboard) or (Clipboard and Clipboard.set)

local players = game:GetService("Players")
local player = players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService") 
local uis = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")
local virtualUser = game:GetService("VirtualUser")

--// Anti-AFK
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    wait(2)
end)

--// Device Detection
local deviceUser        
if not uis.MouseEnabled and not uis.KeyboardEnabled and uis.TouchEnabled then
    deviceUser = "Mobile"
elseif uis.MouseEnabled and uis.KeyboardEnabled and not uis.TouchEnabled then
    deviceUser = "PC"
else
    deviceUser = "Unknown"
end

local function OpenDevConsole()
    starterGui:SetCore("DevConsoleVisible", true)
end

--// Character Auto Setup
local char, humanoid, hrp

local function GetCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function SetupCharacter()
    char = GetCharacter()
    humanoid = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
end

SetupCharacter()
player.CharacterAdded:Connect(function()
    SetupCharacter()
end)

local function rejoinServer()
    teleportService:TeleportToPlaceInstance(game.placeId, game.jobId)
end

local function serverHop()
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.placeId)})
        local body = httpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.jobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            teleportService:TeleportToPlaceInstance(game.placeId, servers[math.random(1, #servers)], player)
        else
            return Rayfield:Notify({
                Title = "Serverhop Failed",
                Content = "Couldnt find a available server.",
                Duration = 3.5,
                Image = "bell-ring",
            })
        end
    else
        Rayfield:Notify({
                Title = "Incompatible Exploit",
                Content = "Your exploit does not support this command (missing request).",
                Duration = 3,
                Image = "bell-ring",
            })
    end
end

local PetewareOverlay = {}

local PetewareOverlayUI = coreGui:FindFirstChild("PetewareOverlay")
if PetewareOverlayUI then
    PetewareOverlayUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetewareOverlay"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = coreGui

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.Name = "Overlay"
overlay.Parent = screenGui

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 256, 0, 256)
icon.Position = UDim2.new(0.5, 0, 0.5, 0)  
icon.Image = "rbxthumb://type=Asset&id=126732855832692&w=420&h=420"
icon.BackgroundTransparency = 1
icon.ImageTransparency = 0
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.Parent = overlay

local circle = Instance.new("UICorner")
circle.CornerRadius = UDim.new(1, 0)
circle.Parent = icon

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 50)
label.Position = UDim2.new(0, 0, 0.75, 0)
label.Text = "Peteware in action..."
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255, 110, 0)
label.TextTransparency = 1
label.TextScaled = true
label.BackgroundTransparency = 1
label.Parent = overlay

function PetewareOverlay.Show()
    screenGui.Enabled = true

    tweenService:Create(overlay, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        BackgroundTransparency = 0
    }):Play()

    tweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        TextTransparency = 0
    }):Play()

local rotationSpeed = 20 
local currentRotation = 0

runService.RenderStepped:Connect(function(deltaTime)
	currentRotation = (currentRotation + rotationSpeed * deltaTime) % 360
	icon.Rotation = currentRotation
end)
end

function PetewareOverlay.Hide()
    tweenService:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        BackgroundTransparency = 1
    }):Play()

    tweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        TextTransparency = 1
    }):Play()

    task.delay(0.5, function()
        screenGui.Enabled = false
    end)
end

local PetewarePlatform = {}

local PetewarePlatformPart = workspace:FindFirstChild("PetewarePlatform")
if PetewarePlatformPart then
    PetewarePlatformPart:Destroy()
end

local platformPart = Instance.new("Part")
platformPart.Name = "PetewarePlatform"
platformPart.Anchored = true
platformPart.Size = Vector3.new(20, 1, 20)
platformPart.Position = hrp.CFrame.Position
platformPart.Material = Enum.Material.Neon
platformPart.Transparency = 1
platformPart.CanCollide = false
platformPart.Color = Color3.fromRGB(230, 90, 10)
platformPart.TopSurface = Enum.SurfaceType.Smooth
platformPart.BottomSurface = Enum.SurfaceType.Smooth

local decal = Instance.new("Decal")
decal.Texture = "rbxassetid://126732855832692"
decal.Face = Enum.NormalId.Top
decal.Transparency = 1
decal.Parent = platformPart

platformPart.Parent = workspace

function PetewarePlatform.Show()
platformPart.Transparency = 0
platformPart.CanCollide = true
decal.Transparency = 0
end

function PetewarePlatform.Hide()
platformPart.Transparency = 1
platformPart.CanCollide = false
decal.Transparency = 1
end

--// In-Game Setup
local autoSprint = false

--// Teleports
local function SpawnLocation(location)
    local args = {
	location
}
replicatedStorage:WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end

--// Silent Aim
local silentAim = false
local friendCheck = false
local teamCheck = false

local friendsList = {}

for _, v in pairs(players:GetPlayers()) do
    if v ~= player then
        local success, isFriend = pcall(function()
            return player:IsFriendsWith(v.UserId)
        end)
        if success then
            friendsList[v.UserId] = isFriend
        end
    end
end

local camera = game:GetService("Workspace").CurrentCamera

local function PlayerChecks()
   local target = nil
   local farthestDistance = math.huge

   for i, v in pairs(players.GetPlayers(players)) do
       if v ~= player and v.Character and v.Character.FindFirstChild(v.Character, "HumanoidRootPart") then
           if player.Team ~= "Civilians" then
               if v.Team ~= "Civilians" then
                   if player.Team == "Cowboys" and v.Team ~= player.Team then
                   end
                   if (not friendCheck or not friendsList[v.UserId]) then
                       if (not teamCheck or v.Team ~= player.Team) then
                           local distanceFromPlayer = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                           if distanceFromPlayer < farthestDistance then
                               farthestDistance = distanceFromPlayer
                               target = v
                           end
                       end
                   end
               end
           end
       end
   end

   if target then
       if _G.Debug then
           print("Current team:", player.Team)
           print("Target player:", target.Name)
           print("Target team:", target.Team)
       end
       return target
   end
end

local targetDebug = PlayerChecks()

if _G.Debug and silentAim and targetDebug then
    print("Current team:", player.Team)
    print("Target player:", targetDebug.Name)
    print("Target team:", targetDebug.Team)
end

local gameMetaTable = getrawmetatable(game)
local oldGameMetaTableNamecall = gameMetaTable.__namecall
setreadonly(gameMetaTable, false)

gameMetaTable.__namecall = newcclosure(function(object, ...)
   local namecallMethod = getnamecallmethod()
   local args = {...}

   if silentAim and tostring(namecallMethod) == "FindPartOnRayWithIgnoreList" then
       local target = PlayerChecks()
       
       if target and target.Character then
           args[1] = Ray.new(camera.CFrame.Position, (target.Character.Head.Position - camera.CFrame.Position).Unit * (camera.CFrame.Position - target.Character.Head.Position).Magnitude)
       end
   end

   return oldGameMetaTableNamecall(object, unpack(args))
end)

setreadonly(gameMetaTable, true)

--// Autofarm
local farmActive = false

local inventory = player:WaitForChild("States"):WaitForChild("Bag")
local maxBag = player:WaitForChild("Stats"):WaitForChild("BagSizeLevel"):WaitForChild("CurrentAmount")
local robRemote = replicatedStorage:WaitForChild("GeneralEvents"):WaitForChild("Rob")
local depositPoint = CFrame.new(1636.62537, 104.349976, -1736.184)

--// Humanoid Clone
local clonedStatus
local function CloneHumanoid()
    if humanoid then
        local humanoidClone = humanoid:Clone()
        humanoidClone.Parent = char
        player.Character = nil
        humanoidClone:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoidClone:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoidClone:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        humanoid:Destroy()
        player.Character = char
        workspace.CurrentCamera.CameraSubject = humanoidClone
        humanoidClone.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local anim = char:FindFirstChild("Animate")
        if anim then anim.Disabled = true task.wait() anim.Disabled = false end
        humanoidClone.Health = humanoidClone.MaxHealth
        humanoid = humanoidClone
        hrp = char:WaitForChild("HumanoidRootPart")
        clonedStatus = true
    end
end

local function DepositLoot()
    if hrp then hrp.CFrame = depositPoint end
end

local function LootRegister()
    for _, obj in ipairs(workspace:GetChildren()) do
        if inventory.Value >= maxBag.Value then DepositLoot() break end
        if obj:IsA("Model") and obj.Name == "CashRegister" then
            local openPart = obj:FindFirstChild("Open")
            if openPart then
                hrp.CFrame = openPart.CFrame
                robRemote:FireServer("Register", {
                    Part = obj:FindFirstChild("Union"),
                    OpenPart = openPart,
                    ActiveValue = obj:FindFirstChild("Active"),
                    Active = true
                })
                return true
            end
        end
    end
    return false
end

local function LootSafe()
    for _, safe in ipairs(workspace:GetChildren()) do
        if inventory.Value >= maxBag.Value then DepositLoot() break end
        if safe:IsA("Model") and safe.Name == "Safe" and safe:FindFirstChild("Amount") and safe.Amount.Value > 0 then
            local body = safe:FindFirstChild("Safe")
            if body then
                hrp.CFrame = body.CFrame
                local flag = safe:FindFirstChild("Open")
                if flag and flag.Value then
                    robRemote:FireServer("Safe", safe)
                else
                    local remote = safe:FindFirstChild("OpenSafe")
                    if remote then remote:FireServer("Completed") end
                    robRemote:FireServer("Safe", safe)
                end
                return true
            end
        end
    end
    return false
end

--// Autofarm Stats
local cashStats = "Earnings: $0"
local pingStats = "Ping: Calculating..."
local fpsStats = "FPS: Loading..."
local timerStats = "Elapsed Time: 00:00:00"

local startCash = player:WaitForChild("leaderstats"):WaitForChild("$$").Value
local seconds, minutes, hours = 0, 0, 0
local function Format(n)
    return tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

--// Visuals
local enemyESP = false
local teamESP = false
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/PetewareScripts/Peteware-V1/refs/heads/main/Other/Sense.lua'))()

--// Settings Configuration
Sense.sharedSettings.limitDistance = true
Sense.sharedSettings.maxDistance = 600
Sense.sharedSettings.useTeamColor = true

--// Enemy ESP
Sense.teamSettings.enemy.enabled = enemyESP
Sense.teamSettings.enemy.chams = true
Sense.teamSettings.enemy.chamsOutlineColor = { Color3.new(1,0,0), 0 }
Sense.teamSettings.enemy.chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 }

--// Team ESP
Sense.teamSettings.friendly.enabled = teamESP
Sense.teamSettings.friendly.chams = true
Sense.teamSettings.friendly.chamsOutlineColor = { Color3.new(1,0,0), 0 }
Sense.teamSettings.friendly.chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 }

--// ESP Load
task.wait(1)
Sense.Load()

--// UI locals
local rayfieldOptimisation = false
local keepPeteware = true
local teleportConnection = false
local confirmDestroy = false

--// Main UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Westbound Peteware v1.0.0",
   Icon = 0, 
   LoadingTitle = "Westbound | Peteware",
   LoadingSubtitle = "Developed by Peteware",
   Theme = {
    TextColor = Color3.fromRGB(235, 235, 235),

    Background = Color3.fromRGB(18, 18, 18),
    Topbar = Color3.fromRGB(28, 28, 30),
    Shadow = Color3.fromRGB(10, 10, 10),

    NotificationBackground = Color3.fromRGB(24, 24, 24),
    NotificationActionsBackground = Color3.fromRGB(50, 50, 50),

    TabBackground = Color3.fromRGB(45, 45, 45),
    TabStroke = Color3.fromRGB(60, 60, 60),
    TabBackgroundSelected = Color3.fromRGB(255, 140, 0), 
    TabTextColor = Color3.fromRGB(200, 200, 200),
    SelectedTabTextColor = Color3.fromRGB(15, 15, 15),

    ElementBackground = Color3.fromRGB(28, 28, 28),
    ElementBackgroundHover = Color3.fromRGB(38, 38, 38),
    SecondaryElementBackground = Color3.fromRGB(20, 20, 20),
    ElementStroke = Color3.fromRGB(55, 55, 55),
    SecondaryElementStroke = Color3.fromRGB(45, 45, 45),

    SliderBackground = Color3.fromRGB(255, 120, 0),
    SliderProgress = Color3.fromRGB(255, 140, 0),
    SliderStroke = Color3.fromRGB(255, 160, 40),

    ToggleBackground = Color3.fromRGB(22, 22, 22),
    ToggleEnabled = Color3.fromRGB(255, 140, 0),
    ToggleDisabled = Color3.fromRGB(90, 90, 90),
    ToggleEnabledStroke = Color3.fromRGB(255, 160, 40),
    ToggleDisabledStroke = Color3.fromRGB(110, 110, 110),
    ToggleEnabledOuterStroke = Color3.fromRGB(100, 60, 0),
    ToggleDisabledOuterStroke = Color3.fromRGB(50, 50, 50),

    DropdownSelected = Color3.fromRGB(36, 36, 36),
    DropdownUnselected = Color3.fromRGB(26, 26, 26),

    InputBackground = Color3.fromRGB(30, 30, 30),
    InputStroke = Color3.fromRGB(60, 60, 60),
    PlaceholderColor = Color3.fromRGB(170, 130, 100)
},

   DisableRayfieldPrompts = true,
   DisableBuildWarnings = true, 

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, 
      FileName = nil
   },

   Discord = {
      Enabled = true, 
      Invite = "4UjSNcPCdh", 
      RememberJoins = true 
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Peteware Key System",
      Subtitle = "Complete the key system for access",
      Note = "Discord copied to clipboard, ", 
      FileName = "PetewareKey", 
      SaveKey = false, 
      GrabKeyFromSite = false, 
      Key = {"PetewareOnTop"}
   }
})

if deviceUser == "PC" then
Rayfield:Notify({
   Title = "IMPORTANT",
   Content = "When you destroy the UI destroy it via the settings tab.",
   Duration = 10,
   Image = "bell-ring",
})
else
Rayfield:Notify({
   Title = "IMPORTANT",
   Content = "When you destroy the UI destroy it via the settings tab.",
   Duration = 3,
   Image = "bell-ring",
})    
end

local Tab = Window:CreateTab("Home", "layout-dashboard")

local Section = Tab:CreateSection("Welcome!")

--[[
[/] feature
[+] feature
[-] feature
]]

local Paragraph = Tab:CreateParagraph({Title = "What's new and improved", Content = [[
    Westbound Peteware Release
    [+] Silent Aim
    [+] Silent Aim Checks
    [+] Chams
    [+] Autofarm
    [+] Teleports
    [+] Auto Sprint
    Please consider joining the server and suggesting more features.
    Please report any bugs to our discord server by creating a ticket.]]})

local JoinDiscordButton = Tab:CreateButton({
   Name = "Join Discord",
   Callback = function()
       if setclip then
   setclip("https://discord.gg/4UjSNcPCdh")
       Rayfield:Notify({
   Title = "Copied to Clipboard!",
   Content = "Discord Server Copied to Clipboard.",
   Duration = 1.5,
   Image = "bell-ring",
       })
   else
       Rayfield:Notify({
   Title = "Unsupported Executor",
   Content = "Your executor doesnt support setclipboard().",
   Duration = 2.5,
   Image = "bell-ring",
       })
   end
   end,
})

local Tab = Window:CreateTab("Main", "gem")

local Section = Tab:CreateSection("Combat")

local SilentAimToggle = Tab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Flag = "SilentAimToggle", 
   Callback = function(Value)
       silentAim = Value
       if silentAim then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Silent Aim Enabled.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Silent Aim Disabled.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local Section = Tab:CreateSection("Silent Aim Checks")

local TeamCheckToggle = Tab:CreateToggle({
   Name = "Team Check",
   CurrentValue = false,
   Flag = "TeamCheckToggle", 
   Callback = function(Value)
       teamCheck = Value
       if teamCheck then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Friend Check Enabled. Silent aim will ignore team.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Friend Check Disabled. Silent aim will target team.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local FriendCheckToggle = Tab:CreateToggle({
   Name = "Friend Check",
   CurrentValue = false,
   Flag = "FriendCheckToggle", 
   Callback = function(Value)
       friendCheck = Value
       if friendCheck then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Friend Check Enabled. Silent aim will ignore friends.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Friend Check Disabled. Silent aim will target friends.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local Section = Tab:CreateSection("Visuals")

local EnemyESPToggle = Tab:CreateToggle({
   Name = "Enemy ESP",
   CurrentValue = false,
   Flag = "EnemyESPToggle", 
   Callback = function(Value)
       enemyESP = Value
       if enemyESP then
           task.wait()
           Sense.teamSettings.enemy.enabled = enemyESP
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Enemy ESP Enabled. Highlights all enemies in a 600 studs radius.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    task.wait()
    Sense.teamSettings.enemy.enabled = enemyESP
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Enemy ESP Enabled.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local TeamESPToggle = Tab:CreateToggle({
   Name = "Team ESP",
   CurrentValue = false,
   Flag = "TeamESPToggle", 
   Callback = function(Value)
       teamESP = Value
       if teamESP then
           task.wait()
           Sense.teamSettings.friendly.enabled = teamESP
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Team ESP Enabled. Highlights all teamates in a 600 studs radius.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    task.wait()
    Sense.teamSettings.friendly.enabled = teamESP
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Team ESP Disabled.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local Tab = Window:CreateTab("Autofarm", "dollar-sign")

local CasbAutofarmToggle = Tab:CreateToggle({
   Name = "Cash Autofarm",
   CurrentValue = false,
   Flag = "CashAutofarmToggle", 
   Callback = function(Value)
       farmActive = Value
       if farmActive then
           SpawnLocation("RedRocks")
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Cash Autofarm Enabled.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    SpawnLocation("RedRocks")
    clonedStatus = false
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Cash Autofarm Disabled.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local AutofarmStatistics = Tab:CreateParagraph({
    Title = "Statistics",
    Content = cashStats .. "\n" .. pingStats .. "\n" .. fpsStats .. "\n" .. timerStats
})

local Tab = Window:CreateTab("Teleports", "user")

local Section = Tab:CreateSection("Cowboys")

local TumbleweedTPButton = Tab:CreateButton({
   Name = "Tumbleweed",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Tumbleweed",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("Tumbleweed")
   end,
})

local GrayridgeTPButton = Tab:CreateButton({
   Name = "Grayridge",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Grayridge",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("Grayridge")
   end,
})

local StoneCreekTPButton = Tab:CreateButton({
   Name = "Stone Creek",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Stone Creek",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("StoneCreek")
   end,
})

local QuarryTPButton = Tab:CreateButton({
   Name = "Rust Ridge Quarry",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Rust Ridge Quarry",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("Quarry")
   end,
})

local Section = Tab:CreateSection("Outlaws")

local FortCassidyTPButton = Tab:CreateButton({
   Name = "Fort Cassidy",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Fort Cassidy",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("FortCassidy")
   end,
})

local FortArthurTPButton = Tab:CreateButton({
   Name = "Fort Arthur",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Fort Arthur",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("FortArthur")
   end,
})

local RedRocksTPButton = Tab:CreateButton({
   Name = "Red Rocks Camp",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Spawning at Red Rocks Camp",
   Duration = 2.5,
   Image = "bell-ring",
})
       SpawnLocation("RedRocks")
   end,
})

local Tab = Window:CreateTab("Misc", "circle-ellipsis")

local Section = Tab:CreateSection("In-Game")

local AutoSprintToggle = Tab:CreateToggle({
   Name = "Auto Sprint",
   CurrentValue = false,
   Flag = "AutoSprintToggle", 
   Callback = function(Value)
       autoSprint = Value
       if autoSprint then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Auto Sprint Enabled.",
   Duration = 2.5,
   Image = "bell-ring",
})
else
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Auto Sprint Disabled.",
   Duration = 1.5,
   Image = "bell-ring",
})
end
   end,
})

local Section = Tab:CreateSection("Character")

local jpUpdate = true
local defaultJP = humanoid.JumpPower
local customJP = false
local currentJP = humanoid.JumpPower

local jpSlider = Tab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "JumpPower",
   CurrentValue = defaultJP,
   Flag = "JumpPowerSlider", 
   Callback = function(Value)
       if Value ~= defaultJP then
            jpUpdate = false
            customJP = true
            if humanoid.JumpPower ~= Value then
                humanoid.JumpPower = Value
                currentJP = Value
            end
        end
    end,
})

local ResetStatsButton = Tab:CreateButton({
    Name = "Reset JumpPower",
    Callback = function()
        customJP = false
        jpUpdate = true
        currentJP = defaultJP

        humanoid.JumpPower = defaultJP
        jpSlider:Set(defaultJP)        
    end,
})

local Divider = Tab:CreateDivider()

local Section = Tab:CreateSection("Other Scripts")

local FPSBoosterButton = Tab:CreateButton({
    Name = "FPS Booster",
    Callback = function()
        -- Made by RIP#6666
_G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
    ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
    ["No Explosions"] = true, -- Makes Explosion's invisible
    ["No Clothes"] = true, -- Removes Clothing from the game
    ["Low Water Graphics"] = true, -- Removes Water Quality
    ["No Shadows"] = true, -- Remove Shadows
    ["Low Rendering"] = true, -- Lower Rendering
    ["Low Quality Parts"] = true -- Lower quality parts
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
    end,
})

local InfYieldAdminButton = Tab:CreateButton({
   Name = "Infinite Yield Admin",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

local PetewareToolboxButton = Tab:CreateButton({
    Name = "Developers Toolbox",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PetewareScripts/Developers-Toolbox-Peteware/refs/heads/main/main.lua",true))()
    end,
})

local Tab = Window:CreateTab("Background Tasks", "clipboard-list")

local Paragraph = Tab:CreateParagraph({Title = "Background Tasks", Content = [[
    Anti-AFK]]})

local Tab = Window:CreateTab("Settings", "settings")

local RejoinButton = Tab:CreateButton({
   Name = "Rejoin",
   Callback = function()
Rayfield:Notify({
   Title = "Rejoining Server...",
   Content = "Attemping to Rejoin Server.",
   Duration = 3.5,
   Image = "bell-ring",
})
task.wait(1)
       rejoinServer()
   end,
})

local ServerHopButton = Tab:CreateButton({
   Name = "Server Hop",
   Callback = function()
Rayfield:Notify({
   Title = "Server Hopping...",
   Content = "Attemping to Server Hop.",
   Duration = 3.5,
   Image = "bell-ring",
})
task.wait(1)
       serverHop()
   end,
})

local KeepPetewareToggle = Tab:CreateToggle({
    Name = "Keep Peteware On Server Hop/Rejoin",
    CurrentValue = false,
    Flag = "keepPetewareToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "Peteware on Rejoin / Server Hop On",
                Content = "Whenever you rejoin or serverhop the script will automatically execute aswel.",
                Duration = 3.5,
                Image = "bell-ring",
            })

            keepPeteware = true
            teleportCheck = false

            player.OnTeleport:Connect(function(State)
                if keepPeteware and not teleportCheck and queueteleport then
                    teleportCheck = true
                    queueteleport([[
                    if not game:IsLoaded() then
                        game.Loaded:Wait()
                        task.wait(1)
                    end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PetewareScripts/Peteware-V1/refs/heads/main/Loader",true))()
]])
                end
            end)
        elseif not Value then
            Rayfield:Notify({
                Title = "Peteware on Rejoin / Server Hop Off",
                Content = "The script now wont automatically execute on serverhop or rejoin.",
                Duration = 2,
                Image = "bell-ring",
            })

            keepPeteware = false
            teleportCheck = false
        end
    end,
})

KeepPetewareToggle:Set(true)

local function StopRayfieldOptimisation()
    Rayfield:Notify({
   Title = "Stopped Rayfield Optimisation",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})  
    RayfieldOptimisation = false
end

local RayfieldOptimisationToggle = Tab:CreateToggle({
   Name = "Rayfield Optimisation (Recommended)",
   CurrentValue = false,
   Flag = "RayfieldOptimisationToggle",
   Callback = function(Value)
       if Value then
Rayfield:Notify({
   Title = "Started Rayfield Optimisation",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})         
           RayfieldOptimisation = true
elseif not Value then
    if RayfieldOptimisation then
        StopRayfieldOptimisation()
    end
    end
   end,
})

local OpenConsoleButton = Tab:CreateButton({
   Name = "Open Console",
   Callback = function()
       OpenDevConsole()
   end,
})

local renderConnection

local function RenderConnectionDisconnect()
    if renderConnection and renderConnection.Connected then
        renderConnection:Disconnect()
    end
end

local function FarmEnd()
    if farmActive then
        SpawnLocation("RedRocks")
        farmActive = false
    end
end

local DestroyUIButton = Tab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        if not confirmDestroy then
            confirmDestroy = true
            Rayfield:Notify({
                Title = "Confirm UI Destruction",
                Content = "Click 'Destroy UI' again to confirm.",
                Duration = 3,
                Image = "bell-ring",
            })
            task.delay(3.5, function()
                confirmDestroy = false
            end)
        else
             silentAim = false
             autoSprint = false
             keepPeteware = false
             teleportCheck = false
             FarmEnd()
             task.wait()
             _G.Execution = false
             execution = false
             RenderConnectionDisconnect()
             Sense.Unload()
            Rayfield:Destroy()
        end
    end,
})

--// Timestamp Handler
local timers = {}

local function ShouldRun(id, interval)
    local timestamp = tick()
    local oldTimestamp = timers[id]

    if (not oldTimestamp) or ((timestamp - oldTimestamp) > interval) then
        timers[id] = timestamp
        return true
    end
    return false
end

--// Loops
renderConnection = runService.RenderStepped:Connect(function(dt)
    if ShouldRun("jpUpdate", 0.2) then
        if jpUpdate and not customJP then
            defaultJP = humanoid.JumpPower
            jpSlider:Set(defaultJP)
        end
    end
    if rayfieldOptimisation and ShouldRun("rayfieldOptimisation", 1) then
        local OldRayfieldPath = coreGui:FindFirstChild("Rayfield-Old")
        if OldRayfieldPath then
            OldRayfieldPath:Destroy()
        end
    end
    if autoSprint and ShouldRun("autoSprint", 0.1) then
        local walkState = char.WalkState
        if walkState.Value ~= "Sprinting" then
            walkState.Value = "Sprinting"
        end
    end
    if farmActive then
        if not clonedStatus then 
            CloneHumanoid()
            task.wait(1)
        end
        if not LootRegister() then
            LootSafe()
        end
    end
    if ShouldRun("performanceStats", 1) then
        if farmActive then
            seconds += 1
            if seconds >= 60 then seconds = 0 minutes += 1 end
            if minutes >= 60 then minutes = 0 hours += 1 end
            timerStats = string.format("Elapsed Time: %02d:%02d:%02d", hours, minutes, seconds)
            local currentCash = player.leaderstats["$$"].Value
            cashStats = "Earnings: $" .. Format(currentCash - startCash)
        end
        local ping = game:GetService("Stats"):FindFirstChild("PerformanceStats") and game.Stats.PerformanceStats:FindFirstChild("Ping")
        pingStats = ping and ("Ping: " .. math.floor(ping:GetValue()) .. "ms") or "Ping: N/A"
        fpsStats = "FPS: " .. math.floor(1 / dt)
        AutofarmStatistics:Set({
            Title = "Statistics",
            Content = cashStats .. "\n" .. pingStats .. "\n" .. fpsStats .. "\n" .. timerStats
        })
    end
end)

--// Events
player.CharacterAdded:Connect(function()
    if not execution then
        return
    end
    task.wait(1)
    humanoid.JumpPower = currentJP
end)
game:GetService("FriendService").FriendsUpdated:Connect(function(friendData)
    if not execution then
        return
    end
    for _, v in pairs(players:GetPlayers()) do
        if v ~= player then
            local success, isFriend = pcall(function()
                return player:IsFriendsWith(v.UserId)
            end)
            if success then
                friendsList[v.UserId] = isFriend
            end
        end
    end
end)
players.PlayerAdded:Connect(function(v)
    if not execution then
        return
    end
    task.delay(1, function()
        local success, isFriend = pcall(function()
            return player:IsFriendsWith(v.UserId)
        end)
        if success then
            friendsList[v.UserId] = isFriend
        end
    end)
end)
players.PlayerRemoving:Connect(function(v)
    if not execution then
        return
    end
    friendsList[v.UserId] = nil
end)
humanoid.Died:Connect(function()
    if not farmActive and not execution then
        return
    end
    clonedStatus = false
    task.wait(6)
    SpawnLocation("RedRocks")
    task.wait(2.5)
    if not clonedStatus then
        CloneHumanoid()
    end
end)

--[[// Credits
Infinite Yield: Server Hop and Anti-AFK
Infinite Yield Discord Server: https://discord.gg/78ZuWSq
RIP#6666: FPS Booster
RIP#6666 Discord Server: https://discord.gg/rips
]]
