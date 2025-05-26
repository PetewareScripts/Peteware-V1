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
    
local startTime = os.clock()
local endTime = os.clock()
local finalTime = endTime - startTime

startTime = os.clock()

if not game:IsLoaded() then
repeat task.wait() until game:IsLoaded()
task.wait(1)
end

if _G.Execution then
    pcall(function()
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
        warn("[Peteware]: Already Executed, Destroy the UI via the settings tab first if you want to execute again.")
        end)
    return
    else
        _G.Execution = true
end

local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local hwidPaste = {
    hwid,
    "ABC123-HWID-EXAMPLE",
    "DEF456-HWID-EXAMPLE",
    "GHI789-HWID-EXAMPLE"
}
print("HWID Paste:", hwidPaste)
print("Client HWID:", hwid)

local StarterGui = game:GetService("StarterGui")
local function openDevConsole()
    StarterGui:SetCore("DevConsoleVisible", true)
end
openDevConsole()

print("[Peteware]: [1/3] Starting authentication")
print("[Peteware]: [2/3] Authentication in progress")

local isWhitelisted = false
for i, v in pairs(hwidPaste) do
    if v == hwid then
        isWhitelisted = true
        break
    end
end

if isWhitelisted then
    print("[Peteware]: [3/3] Whitelisted, Loading Peteware")
    print([[ 
 _______  _______ _________ _______           _______  _______  _______ 
(  ____ )(  ____ \\__   __/(  ____ \|\     /|(  ___  )(  ____ )(  ____ \
| (    )|| (    \/   ) (   | (    \/| )   ( || (   ) || (    )|| (    \/
| (____)|| (__       | |   | (__    | | _ | || (___) || (____)|| (__    
|  _____)|  __)      | |   |  __)   | |( )| ||  ___  ||     __)|  __)   
| (      | (         | |   | (      | || || || (   ) || (\ (   | (      
| )      | (____/\   | |   | (____/\| () () || )   ( || ) \ \__| (____/\
|/       (_______/   )_(   (_______/(_______)|/     \||/   \__/(_______/
                                                                        
    ]])
    
    endTime = os.clock()
    finalTime = endTime - startTime
    
    print(string.format("Intialised in %.4f seconds.", finalTime))
    
    task.wait(2)

    local function closeDevConsole()
        StarterGui:SetCore("DevConsoleVisible", false)
    end
    closeDevConsole()

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
setclip = setclipboard or (syn and syn.setclipboard) or (Clipboard and Clipboard.set)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService") 
local uis = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    wait(2)
end)

local Humanoid
local function GetHumanoid()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local function SetupHumanoid()
    Humanoid = GetHumanoid()
end

SetupHumanoid()
Player.CharacterAdded:Connect(function()
    SetupHumanoid()
end)

local DeviceUser

if not _G.ExecutionLogged then
    _G.ExecutionLogged = true

    local function LogExecution()
        local webhookUrl = ""
        
        local jobId = game.JobId
        local placeId = game.PlaceId
        local gameName = MarketplaceService:GetProductInfo(placeId).Name
        local time = os.date("!*t")

local function isDST(year, month, day)
    local startDST = os.time({year = year, month = 3, day = 31, hour = 1, min = 0, sec = 0})
    while os.date("*t", startDST).wday ~= 1 do
        startDST = startDST - 86400
    end

    local endDST = os.time({year = year, month = 10, day = 31, hour = 1, min = 0, sec = 0})
    while os.date("*t", endDST).wday ~= 1 do
        endDST = endDST - 86400
    end

    local currentTime = os.time({year = year, month = month, day = day, hour = 0, min = 0, sec = 0})
    return currentTime >= startDST and currentTime < endDST
end

if isDST(time.year, time.month, time.day) then
    time.hour = time.hour + 1
end

local formattedTime = string.format("%04d-%02d-%02d %02d:%02d", time.year, time.month, time.day, time.hour, time.min)

        if not uis.MouseEnabled and not uis.KeyboardEnabled and uis.TouchEnabled then
    DeviceUser = "Mobile"
elseif uis.MouseEnabled and uis.KeyboardEnabled and not uis.TouchEnabled then
    DeviceUser = "PC"
    else
    DeviceUser = "Unknown"
end

local ExecutorUsed = identifyexecutor()

local deviceEmoji = "[💻]" 
if DeviceUser == "Mobile" then
    deviceEmoji = "[📱]"
elseif DeviceUser == "Unknown" then
    deviceEmoji = "[❓]"
end

        local githubBase = "https://petewarescripts.github.io/Roblox-Joiner/"
        local githubJoinLink = string.format("%s/?placeId=%d&jobId=%s", githubBase, placeId, jobId)
        local playerProfileLink = string.format("https://www.roblox.com/users/%d/profile", Player.UserId)
        local joinScript = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s")', placeId, jobId)
        local usedScript = "FE2 Retro Peteware v1.1.0"

        local jsonData = HttpService:JSONEncode({
            content = "",
            embeds = {{
                title = "Execution Log",
                color = 16740099,
                thumbnail = {
                    url = string.format("https://media.discordapp.net/attachments/1276618605215219722/1370449278857641994/peteware.png?ex=68203299&is=681ee119&hm=b3b9e1caf3824fd08598ede191cea7c2b5a45788d25aa8b389a5f8e51053fcba&=&format=webp&quality=lossless&width=537&height=602")
                },
                fields = {
                    {name = "**Script Ran:**", value = usedScript},
                    {name = "**[👤] Username:**", value = Player.Name},
                    {name = "**[👤] Display Name:**", value = Player.DisplayName},
                    {name = "**[🪪] UserID:**", value = tostring(Player.UserId)},
                    {name = "**[📷] Profile:**", value = string.format("[Click here to view profile](%s)", playerProfileLink)},
                    {name = "**[🌎] Game Name:**", value = string.format("[**%s**](https://www.roblox.com/games/%d)", gameName, placeId)},
                    {name = "**[:link:] Join Server (URL):**", value = string.format("[Click here to join](%s)", githubJoinLink)},
                    {name = "**[:file_folder:] Join Server (Script):**", value = string.format("```lua\n%s```", joinScript)},
                    {name = "**[🧠] Device Info:**", value = string.format("%s Device: %s\n[🛠️] Executor: %s", deviceEmoji, DeviceUser, ExecutorUsed)},
                    {name = "**[🕒] Timestamp**", value = formattedTime}
                }
            }}
        })

        if httprequest then
            pcall(function()
                httprequest({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = jsonData
                })
            end)
        end
    end

    LogExecution()
end

local mapHistory = {} 
isFarming= Value 
isAir= Value
local lastMapName = nil 

local function getMapName()
    local MapSettings = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Settings")
    if MapSettings then
        local mapNameObj = MapSettings:FindFirstChild("MapName")
        if mapNameObj and mapNameObj:IsA("StringValue") then
            local currentMapName = mapNameObj.Value
            if currentMapName ~= lastMapName then
                mapHistory = {} 
                lastMapName = currentMapName
            end
            return currentMapName
        end
    end
    return nil 
end

local function rejoinServer()
    TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId)
end

local function serverHop()
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.placeId)})
        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.jobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.placeId, servers[math.random(1, #servers)], Player)
        else
            return Rayfield:Notify({
                Title = "Peteware",
                Content = "Serverhop Failed. Couldnt find a available server.",
                Duration = 3.5,
                Image = "bell-ring",
            })
        end
    else
        Rayfield:Notify({
                Title = "Peteware",
                Content = "Incompatible Exploit. Your exploit does not support this command (missing request).",
                Duration = 3,
                Image = "bell-ring",
            })
    end
end

local PetewareOverlay = {}

local PetewareOverlayUI = CoreGui:FindFirstChild("PetewareOverlay")

if PetewareOverlayUI then
    PetewareOverlayUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetewareOverlay"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

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

    TweenService:Create(overlay, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        TextTransparency = 0
    }):Play()

local rotationSpeed = 20 
local currentRotation = 0

RunService.RenderStepped:Connect(function(deltaTime)
	currentRotation = (currentRotation + rotationSpeed * deltaTime) % 360
	icon.Rotation = currentRotation
end)
end

function PetewareOverlay.Hide()
    TweenService:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        TextTransparency = 1
    }):Play()

    task.delay(0.5, function()
        screenGui.Enabled = false
    end)
end

local PetewarePlatform = workspace:FindFirstChild("PetewarePlatform")

if PetewarePlatform then
    PetewarePlatform:Destroy()
end

local platformPart = Instance.new("Part")
platformPart.Name = "PetewarePlatform"
platformPart.Anchored = true
platformPart.Size = Vector3.new(20, 1, 20)
platformPart.Position = Vector3.new(-327, 20, 191)
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

local function PetewarePlatformShow()
platformPart.Transparency = 0
platformPart.CanCollide = true
decal.Transparency = 0
end

local function PetewarePlatformHide()
platformPart.Transparency = 1
platformPart.CanCollide = false
decal.Transparency = 1
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "FE2 Retro Peteware v1.1.0",
   Icon = 0, 
   LoadingTitle = "FE2 Retro | Peteware",
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

if DeviceUser == "PC" then
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
    [+] Infinite Oxygen
    Please consider joining the server and suggesting more features.
    Please report any bugs to our discord server by creating a ticket.]]})

local Button = Tab:CreateButton({
   Name = "Join Discord",
   Callback = function()
       if setclip then
   setclip("https://discord.gg/4UjSNcPCdh")
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Copied to Clipboard! Discord Server Copied to Clipboard.",
   Duration = 1.5,
   Image = "bell-ring",
       })
   else
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Unsupported Executor. Your executor doesnt support setclipboard().",
   Duration = 2.5,
   Image = "bell-ring",
       })
   end
   end,
})

local Tab = Window:CreateTab("Main", "gem")

local Section = Tab:CreateSection("Autofarming")

local AutofarmXPToggle = Tab:CreateToggle({
    Name = "XP Autofarm",
    CurrentValue = false,
    Flag = "AutofarmXPToggle", 
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
   Title = "Peteware",
   Content = "XP Autofarm Enabled.",
   Duration = 4.5,
   Image = "bell-ring",
})
        end
        isFarming = Value
        local connection = nil
        local lastMapInstance = nil
        local currentMapName = nil
        local processedMap = false
        local elevatorPosition = Vector3.new(-26, -144, 74)

        local function teleportToElevator(waitTime)
            task.wait(waitTime or 1.5)
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:WaitForChild("HumanoidRootPart", 5)
            if HRP then
                HRP.CFrame = CFrame.new(elevatorPosition)
            end
        end

        local function autofarm()
            while isFarming do
                local Character = Player.Character or Player.CharacterAdded:Wait()
                local HRP = Character:WaitForChild("HumanoidRootPart", 5)
                if not HRP then return end

                local distance = (HRP.Position - elevatorPosition).Magnitude
                if distance <= 500 then
                    teleportToElevator(1)
                    repeat
                        task.wait(1)
                        Character = Player.Character or Player.CharacterAdded:Wait()
                        HRP = Character:FindFirstChild("HumanoidRootPart")
                        if HRP then
                            distance = (HRP.Position - elevatorPosition).Magnitude
                        end
                    until distance > 500 or not isFarming
                    task.wait(0.5)
                    continue
                end

                local map = game.Workspace.Multiplayer:FindFirstChild("Map")
                if map then
                    local actualMapName = getMapName() or map.Name

                    if map ~= lastMapInstance or actualMapName ~= currentMapName then
                        lastMapInstance = map
                        currentMapName = actualMapName
                        processedMap = false
                        print("[Autofarm]: New Map: " .. actualMapName)
                        task.wait(1)
                    end

                    if not processedMap then
                        processedMap = true
                        print("[Autofarm]: Processing: " .. actualMapName)

                        buttons(0.05)

                        if mapName == "Sinking Ship" then
    local Map = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Section2")
    local ExitV2 = Map and Map:FindFirstChild("ExitRegion")
    if ExitV2 then
        targetCFrame = ExitV2.CFrame
    else
        warn("[TpExit]: Couldnt locate ExitRegion.")
    end
                        else
                            local spawnObj = map:FindFirstChild("Spawn")
                            if spawnObj and spawnObj.Position.X < 3000 then
                                Tpexit(1)
                            else
                                Tpexit(2)
                            end
                        end

                        print("[Autofarm]: Processed Map: " .. actualMapName)
                    end
                end
                task.wait(0.5)
            end
        end

        if Value then
            isFarming = true

            if connection then
                connection:Disconnect()
                connection = nil
            end

            local function onCharacterAdded(character)
                local Humanoid = character:WaitForChild("Humanoid", 5)
                if Humanoid then
                    Humanoid.Died:Connect(function()
                        task.wait(1.5)
                        if isFarming then
                            teleportToElevator()
                        end
                    end)
                end
            end

            connection = Player.CharacterAdded:Connect(onCharacterAdded)

            if Player.Character then
                onCharacterAdded(Player.Character)
            end

            spawn(autofarm)
        else
            isFarming = false
            if connection then
                connection:Disconnect()
                connection = nil
            end
            Rayfield:Notify({
   Title = "Peteware",
   Content = "XP Autofarm Disabled.",
   Duration = 3.5,
   Image = "bell-ring",
})
        end
    end,
})

local Section = Tab:CreateSection("In-Game")

local InfiniteAirToggle = Tab:CreateToggle({
   Name = "InfO²",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
       isAir = Value
        local running = isAir
        local lastMapState = nil
        local lastRadiusState = nil
        local lastSetValue = nil
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local elevatorPosition = Vector3.new(-26, -144, 74)
        local loading = "loading"
        local waiting = "waiting"
        local ingame = "ingame"
        local characterConnection, deathConnection, loopThread

        local function setValue(newValue)
            if lastSetValue ~= newValue then
                local aux = loadstring(game:HttpGetAsync("https://pastebin.com/raw/KnbcZji1"))()
                local scriptPath = game:GetService("Players").LocalPlayer.PlayerScripts.CL_MAIN_GameScript
                local closureName = "Unnamed function"
                local upvalueIndex = 13
                local closureConstants = {
                    [1] = "inPart",
                    [2] = "CFrame",
                    [3] = "p",
                    [4] = "BrickColor",
                    [5] = "r",
                    [6] = 0.33
                }
                local closure = aux.searchClosure(scriptPath, closureName, upvalueIndex, closureConstants)
                setupvalue(closure, upvalueIndex, newValue)
                lastSetValue = newValue
            end
        end

        local function setupCharacter(newCharacter)

    character = newCharacter

    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    setValue(nil) 

    if deathConnection then deathConnection:Disconnect() end

    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if humanoid then

        deathConnection = humanoid.Died:Connect(function()

            if loopThread then

                running = false

                task.wait(0.5)

                setValue(loading) 

            end

        end)

    end

end

        if characterConnection then characterConnection:Disconnect() end
        characterConnection = Player.CharacterAdded:Connect(setupCharacter)

        setupCharacter(character)

        if isAir then
            Rayfield:Notify({
   Title = "Peteware",
   Content = "Infinite Oxygen Enabled.",
   Duration = 3.5,
   Image = "bell-ring",
})
            
            loopThread = spawn(function()
                while isAir do
                    local map = game.Workspace.Multiplayer:FindFirstChild("Map")
                    local currentMapState, currentRadiusState
                    if map then
                        currentMapState = "mapPresent"
                        if humanoidRootPart then
                            local distance = (humanoidRootPart.Position - elevatorPosition).Magnitude
                            if distance <= 500 then
                                currentRadiusState = "inRadius"
                            else
                                currentRadiusState = "outOfRadius"
                            end
                        end
                    else
                        currentMapState = "mapAbsent"
                        currentRadiusState = "noMap"
                    end
                    if currentMapState ~= lastMapState or currentRadiusState ~= lastRadiusState then
                        if currentMapState == "mapPresent" then
                            if currentRadiusState == "outOfRadius" then
                                setValue(ingame)
                                task.wait(0.5)
                                setValue(loading)
                            elseif currentRadiusState == "inRadius" then
                                setValue(waiting)
                            end
                        end
                        lastMapState = currentMapState
                        lastRadiusState = currentRadiusState
                    end
                    task.wait()
                end
            end)
        else
            Rayfield:Notify({
   Title = "Peteware",
   Content = "Infinite Oxygen Disabled.",
   Duration = 3.5,
   Image = "bell-ring",
})
            if humanoidRootPart then
                local distance = (humanoidRootPart.Position - elevatorPosition).Magnitude
                if distance <= 500 then
                    setValue(waiting)
                else
                    setValue(ingame)
                end
            end
            if loopThread then running = false end
        end
   end,
})

function buttons(waittime)
    local Map = game.Workspace.Multiplayer.Map
    local Btns = {}
    local Desc = {}
    for i, v in pairs(Map:GetDescendants()) do
        Desc[v.Name .. "Obj"] = v
    end
    for i = 0, 30 do
        if Desc["_Button" .. tostring(i) .. "Obj"] ~= nil then
            table.insert(Btns, Desc["_Button" .. tostring(i) .. "Obj"])
        end
    end
    for _, v in pairs(Btns) do
        local Hitbox = v.Hitbox
        Player.Character.HumanoidRootPart.CFrame = Hitbox.CFrame
        task.wait(waittime)
    end
end

local TPButtonsButton = Tab:CreateButton({
   Name = "Press Buttons",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (HRP.Position - elevatorPosition).Magnitude

        if distance > 500 then
            print("[ButtonTp]: All Buttons Pressed.")
            buttons(0.05)
        else
            warn("[ButtonTp]: Failed to press Buttons.")
            warn("[ButtonTp]: Player hasn't loaded into the map.")
            openDevConsole()
            task.wait(2.5)
            closeDevConsole()
        end
   end,
})

function Tpexit(pos)
    spawn(function()
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

        if not HumanoidRootPart then
            warn("[TpExit]: Couldnt find HumanoidRootPart")
            return
        end

        local mapName = getMapName()
        local targetCFrame

        if mapName == "Sinking Ship" then
    local Map = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Section2")
    local ExitV2 = Map and Map:FindFirstChild("ExitRegion")
    if ExitV2 then
        targetCFrame = ExitV2.CFrame
    else
        warn("[TpExit]: Couldnt locate ExitRegion.")
    end
else
            local Map = game.Workspace.Multiplayer:FindFirstChild("Map")
            local ExitBlock = Map and Map:FindFirstChild("ExitRegion")
            
            if ExitBlock then
                targetCFrame = ExitBlock.CFrame
            else
                if pos == 1 then
                    targetCFrame = CFrame.new(2080, 990, 2)
                elseif pos == 2 then
                    targetCFrame = CFrame.new(4080, 990, 2)
                else
                    warn("[TpExit]: Couldnt locate ExitRegion.")
                    return
                end
            end
        end
        
        local Ts = game:GetService("TweenService")
        local Ti = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local Tp = { CFrame = targetCFrame }

        local Tw = Ts:Create(HumanoidRootPart, Ti, Tp)
        Tw:Play()
        Tw.Completed:Wait()
    end)
end

local TPExitButton = Tab:CreateButton({
   Name = "Teleport to Exit",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local radius = 500
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local distance = (humanoidRootPart.Position - elevatorPosition).Magnitude

            if distance > radius then
                print("[TpExit]: Teleported to ExitRegion.")
                local exit = game.Workspace.Multiplayer.Map:FindFirstChild("ExitRegion")
                if exit then
                    Tpexit()
                else
                    local spawn = game.Workspace.Multiplayer.Map:FindFirstChild("Spawn")
                    if spawn.Position.X < 3000 then
                        Tpexit(1)
                    else
                        Tpexit(2)
                    end
                end
            else
                warn("[TpExit]: ExitRegion TP Failed.")
                warn("[TpExit]: Player hasn't loaded into the map.")
                openDevConsole()
                task.wait(2.5)
                closeDevConsole()
            end
        end
   end,
})

local Tab = Window:CreateTab("Teleports", "user")

local Section = Tab:CreateSection("Lobby")

local LobbyTPButton = Tab:CreateButton({
   Name = "Lobby",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (HRP.Position - elevatorPosition).Magnitude

        if distance < 500 then
       HRP.CFrame = CFrame.new(-25, -145, 47)
       else
           openDevConsole()
           warn("[Teleport]: Cannot teleport while In-Game")
           task.wait(2.5)
           closeDevConsole()
        end
   end,
})

local ElevatorTPButton = Tab:CreateButton({
   Name = "Elevator",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (HRP.Position - elevatorPosition).Magnitude

        if distance < 500 then
       HRP.CFrame = CFrame.new(-26, -144, 74)
       else
           openDevConsole()
           warn("[Teleport]: Cannot teleport while In-Game")
           task.wait(2.5)
           closeDevConsole()
        end
   end,
})

local SecretAreaTPButton = Tab:CreateButton({
   Name = "Secret Area",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (HRP.Position - elevatorPosition).Magnitude

        if distance < 500 then
       HRP.CFrame = CFrame.new(-61, -177, -40)
       else
           openDevConsole()
           warn("[Teleport]: Cannot teleport while In-Game")
           task.wait(2.5)
           closeDevConsole()
        end
   end,
})

local Tab = Window:CreateTab("Misc", "circle-ellipsis")

local Section = Tab:CreateSection("Other")

local AutoLock = false

local function StartAutoLock()
    AutoLock = true
    Rayfield:Notify({
    Title = "Peteware",
   Content = "Auto Insane Lock On. Automatically locks to insane.",
   Duration = 3.5,
   Image = "bell-ring",
})
    repeat
	    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("BuyDifLock"):FireServer()
	    task.wait(3)
    until not AutoLock
end

local function StopAutoLock()
    AutoLock = false
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Auto Insane Lock Off.",
   Duration = 3.5,
   Image = "bell-ring",
})
end

local AutoLockToggle = Tab:CreateToggle({
   Name = "Auto Lock to Insane (10 gems)",
   CurrentValue = false,
   Flag = "AutoLockToggle", 
   Callback = function(Value)
       if Value then
           StartAutoLock()
       elseif not Value then
           StopAutoLock()
       end
   end,
})

local DestroyExitButton = Tab:CreateButton({
   Name = "Destroy Exit",
   Callback = function()
       local Map = game.Workspace.Multiplayer:FindFirstChild("Map")

if Map then
    local ExitBlock = Map:FindFirstChild("ExitBlock")
    if ExitBlock then
        ExitBlock:Destroy()
        Rayfield:Notify({
   Title = "Peteware",
   Content = "Exit Block Destroyed.",
   Duration = 4.5,
   Image = "bell-ring",
})
    end
else
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Failed to destroy Exit Block, Map not found.",
   Duration = 4.5,
   Image = "bell-ring",
})
     end
   end,
})

local Section = Tab:CreateSection("Legit")

local ControllerShiftlockButton = Tab:CreateButton({
   Name = "Controller Shiftlock",
   Callback = function()
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Controller Shiftlock Enabled. Controls: RB on Xbox, R1 on Playstation.",
   Duration = 4.5,
   Image = "bell-ring",
})    

local shiftlockEnabled = false
local Input = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GameSettings = UserSettings():GetService("UserGameSettings")
local g, J

local function ForceShiftLock()
    local success, rotationType = pcall(function()
        return GameSettings.RotationType
    end)
    if success then g = rotationType end

    J = RunService.RenderStepped:Connect(function()
        pcall(function()
            GameSettings.RotationType = Enum.RotationType.CameraRelative
        end)
    end)
end

local function EndForceShiftLock()
    if J then
        pcall(function()
            GameSettings.RotationType = g or Enum.RotationType.MovementRelative
        end)
        J:Disconnect()
    end
end

-- Shiftlock R1 Toggle
Input.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR1 then
        shiftlockEnabled = not shiftlockEnabled
        if shiftlockEnabled then
            ForceShiftLock()
        else
            EndForceShiftLock()
        end
    end
end)
   end,
})

local MobileShiftlockButton = Tab:CreateButton({
   Name = "Mobile Shiftlock",
   Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/4Tu7D3hn",true))()
   end,
})

local Divider = Tab:CreateDivider()

local Section = Tab:CreateSection("Other Scripts")

local FpsBoosterButton = Tab:CreateButton({
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
    Name = "Developers Toolbox | Peteware",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PetewareScripts/Developers-Toolbox-Peteware/refs/heads/main/main.lua", true))()
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

local KeepPeteware = true
local teleportConnection

local KeepPetewareToggle = Tab:CreateToggle({
    Name = "Keep Peteware On Server Hop/Rejoin",
    CurrentValue = false,
    Flag = "KeepPetewareToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "Peteware",
                Content = "Whenever you rejoin or serverhop, the script will automatically execute.",
                Duration = 3.5,
                Image = "bell-ring",
            })

            KeepPeteware = true

            if teleportConnection then
                teleportConnection:Disconnect()
            end

            teleportConnection = game.Players.LocalPlayer.OnTeleport:Connect(function(State)
                if KeepPeteware and queueteleport then
                    queueteleport([[
                        local success, err = pcall(function()
                            repeat task.wait() until game:IsLoaded()
                            task.wait(1)
                            loadstring(game:HttpGet("https://pastefy.app/Hs52zR1t/raw"))()
                        end)
                        if not success then
                            warn("Peteware failed to load after teleport:", err)
                        end
                    ]])
                end
            end)

        else
            Rayfield:Notify({
                Title = "Peteware",
                Content = "The script will no longer auto-execute on rejoin or serverhop.",
                Duration = 2,
                Image = "bell-ring",
            })

            KeepPeteware = false

            if teleportConnection then
                teleportConnection:Disconnect()
                teleportConnection = nil
            end
        end
    end,
})

KeepPetewareToggle:Set(true)

local RayfieldOptimisation = false

local function StartRayfieldOptimisation()
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Started Rayfield Optimisation.",
   Duration = 2,
   Image = "bell-ring",
})
    task.spawn(function()
           while RayfieldOptimisation do
        task.wait(0.1)
        pcall(function()
            local OldRayfieldPath = CoreGui:FindFirstChild("Rayfield-Old")
            if OldRayfieldPath then
                OldRayfieldPath:Destroy()
            end
        end)
           end
    end)
end

local function StopRayfieldOptimisation()
    Rayfield:Notify({
   Title = "Peteware",
   Content = "Stopped Rayfield Optimisation.",
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
           RayfieldOptimisation = true
           StartRayfieldOptimisation()
           
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
       StarterGui:SetCore("DevConsoleVisible", true)
   end,
})

local confirmDestroy = false

local DestroyUIButton = Tab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        if not confirmDestroy then
            confirmDestroy = true
            Rayfield:Notify({
                Title = "Peteware",
                Content = "Confirm UI Destruction. Click 'Destroy UI' again to confirm.",
                Duration = 3,
                Image = "bell-ring",
            })
            task.delay(3.5, function()
                confirmDestroy = false
            end)
        else
            task.wait()
            isFarming = false
             KeepPeteware = false
             if teleportConnection then
                teleportConnection:Disconnect()
             end
             AutoLock = false
             task.wait()
             _G.Execution = false
            Rayfield:Destroy()
        end
    end,
})

else
    openDevConsole()
    warn("[Peteware]: [3/3] Authentication Failed, Please try and reset your HWID")
    
    task.wait(1.5)
    
    LocalPlayer:Kick("You are not whitelisted. You have not purchased the script or there is an error with it. Please contact the owner of the script (PouPeuu_V2) for support.")
end

--[[// Credits
Infinite Yield: Server Hop and Anti-AFK
Infinite Yield Discord Server: https://discord.gg/78ZuWSq
]]
