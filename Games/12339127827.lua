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

-- Disclaimer: This script has been discontinued

--// Loading Handler
if not game:IsLoaded() then
repeat task.wait() until game:IsLoaded()
task.wait(1)
end

--// Execution Handler
if _G.Execution then
    pcall(function()
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
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
local playerGui = player:WaitForChild("PlayerGui")

--// Anti-AFK
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    wait(2)
end)

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
	if execution then
    SetupCharacter()
    end
end)

--// Execution Logging
local deviceUser

if not _G.ExecutionLogged then
    _G.ExecutionLogged = true

    local function LogExecution()
        local webhookUrl = "YOUR_DISCORD_WEBHOOK_URL_HERE"
        
        local jobId = game.JobId
        local placeId = game.PlaceId
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name
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
    deviceUser = "Mobile"
elseif uis.MouseEnabled and uis.KeyboardEnabled and not uis.TouchEnabled then
    deviceUser = "PC"
    else
    deviceUser = "Unknown"
end

local executorUsed = identifyexecutor()

local deviceEmoji = "[💻]" 
if deviceUser == "Mobile" then
    deviceEmoji = "[📱]"
elseif deviceUser == "Unknown" then
    deviceEmoji = "[❓]"
end

        local githubBase = "https://petewarescripts.github.io/Roblox-Joiner/"
        local githubJoinLink = string.format("%s/?placeId=%d&jobId=%s", githubBase, placeId, jobId)
        local playerProfileLink = string.format("https://www.roblox.com/users/%d/profile", player.UserId)
        local joinScript = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s")', placeId, jobId)
        local usedScript = "FE2 Retro Peteware v1.2.1"

        local jsonData = httpService:JSONEncode({
            username = "Petah Assistant",
            avatar_url = "https://media.discordapp.net/attachments/1276618605215219722/1370544872993329162/stewie-gun.gif?ex=681fe2e1&is=681e9161&hm=257497f332ffab8ba50af15641d62fc2647ef1fa01a3fd166dbfe0f5886d2dbf&=",
            embeds = {{
                title = "Execution Log",
                color = 16740099,
                thumbnail = {
                    url = string.format("https://media.discordapp.net/attachments/1276618605215219722/1370449278857641994/peteware.png?ex=68203299&is=681ee119&hm=b3b9e1caf3824fd08598ede191cea7c2b5a45788d25aa8b389a5f8e51053fcba&=&format=webp&quality=lossless&width=537&height=602")
                },
                fields = {
                    {name = "**Script Ran:**", value = usedScript, inline = false},
                    {name = "**[👤] Username:**", value = player.Name, inline = false},
                    {name = "**[👤] Display Name:**", value = player.DisplayName, inline = true},
                    {name = "**[🪪] UserID:**", value = tostring(player.UserId), inline = true},
                    {name = "**[📷] Profile:**", value = string.format("[Click here to view profile](%s)", playerProfileLink), inline = true},
                    {name = "**[🌎] Game Name:**", value = string.format("[**%s**](https://www.roblox.com/games/%d)", gameName, placeId), inline = false},
                    {name = "**[:link:] Join Server (URL):**", value = string.format("[Click here to join](%s)", githubJoinLink), inline = true},
                    {name = "**[:file_folder:] Join Server (Script):**", value = string.format("```lua\n%s```", joinScript), inline = true},
                    {name = "**[🧠] Device Info:**", value = string.format("%s Device: %s\n[🛠️] Executor: %s", deviceEmoji, deviceUser, executorUsed), inline = false},
                    {name = "**[🌟] Credits**", value = "**Peteware -** https://discord.gg/4UjSNcPCdh", inline = false},
                    {name = "**[🕒] Timestamp**", value = formattedTime, inline = true}
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

--// Autofarm Status Logging
local autofarmStatus = "🟢"
local autofarmWebhookUrl = "PLEASE_INPUT_YOUR_WEBHOOK_URL"

local function AutofarmWebhook()
    local level = playerGui.GameGui.HUD.MenuToggle.Stats.XPStats.Icon.Info.Text
    local xpProgress = playerGui.GameGui.HUD.MenuToggle.Stats.XPStats.XP.Text
    local gems = playerGui.GameGui.HUD.MenuToggle.Stats.GemAmt.Amount.Text
    local coins = playerGui.GameGui.HUD.MenuToggle.Stats.CoinAmt.Amount.Text

    local FE2Gem = "<:FE2Gem:1376690948939186216>"
    local FE2Coin = "<:FE2Coin:1376690888910176256>"

    local headshotUrl = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..player.UserId.."&size=150x150&format=Png&isCircular=true"
    local success, result = pcall(function()
        return httpService:JSONDecode(game:HttpGet(headshotUrl))
    end)
    if not (success and result and result.data and #result.data > 0) then return end
    local avatarHeadshot = result.data[1].imageUrl

    local time = os.date("!*t")
    local function isDST(year, month, day)
        local function lastSunday(month)
            local d = os.time({year = year, month = month, day = 31})
            while os.date("*t", d).wday ~= 1 do
                d = d - 86400
            end
            return d
        end
        local current = os.time({year = year, month = month, day = day})
        return current >= lastSunday(3) and current < lastSunday(10)
    end
    if isDST(time.year, time.month, time.day) then
        time.hour = time.hour + 1
    end
    local formattedTime = string.format("%04d-%02d-%02d %02d:%02d", time.year, time.month, time.day, time.hour, time.min)

    local jsonData = {
        username = "Petah Assistant",
        avatar_url = "https://media.discordapp.net/attachments/1276618605215219722/1370544872993329162/stewie-gun.gif?ex=681fe2e1&is=681e9161&hm=257497f332ffab8ba50af15641d62fc2647ef1fa01a3fd166dbfe0f5886d2dbf&=",
        embeds = {{
            title = "FE2 Retro Autofarm",
            color = 16740099,
            thumbnail = { url = avatarHeadshot },
            fields = {
                {name = "**Statistics**", value = "Player: **" .. player.DisplayName .. "**\nLevel: **" .. level .. "** | " .. xpProgress .. "\n" .. FE2Gem .. " **" .. gems .. "**\n" .. FE2Coin .. " **" .. coins .. "**", inline = false},
                {name = "**Status:** "..autofarmStatus, value = "", inline = false},
                {name = "**[🌟] Credits**", value = "**Peteware -** https://discord.gg/4UjSNcPCdh", inline = true},
                {name = "**[🕒] Timestamp**", value = formattedTime, inline = false}
            }
        }}
    }

    local body = httpService:JSONEncode(jsonData)

    if not autofarmWebhookUrl or autofarmWebhookUrl == "PLEASE_INPUT_YOUR_WEBHOOK_URL" then return end

    if httprequest then
        pcall(function()
                local response = httprequest({
                    Url = autofarmWebhookUrl,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = body
                })
        end)
    end
end

--// Functions
local mapHistory = {} 
isFarming= Value 
isAir= Value
local lastMapName = nil 

local function GetMapName()
    local mapSettings = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Settings")
    if mapSettings then
        local mapNameObj = mapSettings:FindFirstChild("MapName")
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

local function RejoinServer()
    teleportService:TeleportToPlaceInstance(game.placeId, game.jobId)
end

local function ServerHop()
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.placeId)})
        local body = httpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxplayers) and v.playing < v.maxplayers and v.id ~= game.jobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            teleportService:TeleportToPlaceInstance(game.placeId, servers[math.random(1, #servers)], player)
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

--// Peteware Overlay (not used)
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

--// Main UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "FE2 Retro Peteware v1.2.1",
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
    [+] Autofarm Status (webhook)
    [/] Fixed Optimisation Issues (better looping logic)
    This script has now been discontinued.]]})

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

        local function TeleportToElevator(waitTime)
            task.wait(waitTime or 1.5)
            if hrp then
                hrp.CFrame = CFrame.new(elevatorPosition)
            end
        end

        local function LevelAutofarm()
    while isFarming do
        if not hrp then
            return
        end

        local distance = (hrp.Position - elevatorPosition).Magnitude
        if distance <= 500 then
            TeleportToElevator(1)
            repeat
                task.wait(1)
                if hrp then
                    distance = (hrp.Position - elevatorPosition).Magnitude
                end
            until distance > 500 or not isFarming
            task.wait(0.5)
        else
            local map = game.Workspace.Multiplayer:FindFirstChild("Map")
            if map then
                local actualMapName = GetMapName() or map.Name

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
                        local map = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Section2")
                        local exitV2 = map and map:FindFirstChild("ExitRegion")
                        if exitV2 then
                            targetCFrame = exitV2.CFrame
                        else
                            Rayfield:Notify({
                                Title = "Peteware",
                                Content = "Couldnt locate Exit Region.",
                                Duration = "1.5",
                                Image = "bell-ring",
                            })
                        end
                    else
                        local spawnObj = map:FindFirstChild("Spawn")
                        if spawnObj and spawnObj.Position.X < 3000 then
                            Tpexit(1)
                        else
                            Tpexit(2)
                        end
                    end
                    Rayfield:Notify({
                        Title = "Peteware",
                        Content = "[Autofarm]: Processed Map: " .. actualMapName,
                        Duration = 2.5,
                        Image = "bell-ring",
                    })
                end
            end
            task.wait(0.5)
        end
    end
end

        if Value then
            isFarming = true

            if connection then
                connection:Disconnect()
                connection = nil
            end

            local function onCharacterAdded(character)
                if humanoid then
                    humanoid.Died:Connect(function()
                        task.wait(1.5)
                        if isFarming then
                            TeleportToElevator()
                        end
                    end)
                end
            end

            connection = player.CharacterAdded:Connect(onCharacterAdded)

            if char then
                onCharacterAdded(char)
            end

            task.spawn(LevelAutofarm)
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

local Input = Tab:CreateInput({
   Name = "Webhook Url",
   CurrentValue = "",
   PlaceholderText = "Input Your URL",
   RemoveTextAfterFocusLost = false,
   Flag = "WebhookUrl",
   Callback = function(Text)
       autofarmWebhookUrl = Text
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Set Webhook Url: " .. autofarmWebhookUrl,
   Duration = 3.5,
   Image = "bell-ring",
})
   end,
})

local webhookStatus = false

local AutofarmWebhookToggle = Tab:CreateToggle({
   Name = "Send Status Webhook",
   CurrentValue = false,
   Flag = "SendStatusWebhookToggle", 
   Callback = function(Value)
       webhookStatus = Value
       if Value then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Sending Statistics to Webhook: " .. autofarmWebhookUrl,
   Duration = 3.5,
   Image = "bell-ring",
})
       else
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Stopped Sending Statistics to Webhook.",
   Duration = 1.5,
   Image = "bell-ring",
})
       end
   end,
})

local Section = Tab:CreateSection("In-Game")

local InfiniteAirToggle = Tab:CreateToggle({
   Name = "InfO²",
   CurrentValue = false,
   Flag = "InfiniteAirToggle", 
   Callback = function(Value)
       isAir = Value
        local running = isAir
        local lastMapState = nil
        local lastRadiusState = nil
        local lastSetValue = nil
        local character = player.Character or player.CharacterAdded:Wait()
        local elevatorPosition = Vector3.new(-26, -144, 74)
        local loading = "loading"
        local waiting = "waiting"
        local ingame = "ingame"
        local characterConnection, deathConnection, loopThread

        local function setValue(newValue)
            if lastSetValue ~= newValue then
                local aux = loadstring(game:HttpGetAsync("https://pastebin.com/raw/KnbcZji1"))()
                local scriptPath = player.PlayerScripts.CL_MAIN_GameScript
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
            char = newCharacter
    setValue(nil)
    if deathConnection then deathConnection:Disconnect() end
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
        characterConnection = player.CharacterAdded:Connect(setupCharacter)
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
                        if hrp then
                            local distance = (hrp.Position - elevatorPosition).Magnitude
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
            if hrp then
                local distance = (hrp.Position - elevatorPosition).Magnitude
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
    local map = game.Workspace.Multiplayer.Map
    local Btns = {}
    local Desc = {}
    for i, v in pairs(map:GetDescendants()) do
        Desc[v.Name .. "Obj"] = v
    end
    for i = 0, 30 do
        if Desc["_Button" .. tostring(i) .. "Obj"] ~= nil then
            table.insert(Btns, Desc["_Button" .. tostring(i) .. "Obj"])
        end
    end
    for _, v in pairs(Btns) do
        local Hitbox = v.Hitbox
        player.Character.HumanoidRootPart.CFrame = Hitbox.CFrame
        task.wait(waittime)
    end
end

local TPButtonsButton = Tab:CreateButton({
   Name = "Press Buttons",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (hrp.Position - elevatorPosition).Magnitude

        if distance > 500 then
            buttons(0.05)
            Rayfield:Notify({
                Title = "Peteware",
                Content = "Teleported to buttons.",
                Duration = 1.5,
                Image = "bell-ring",
            })
        else
            Rayfield:Notify({
                Title = "Peteware",
                Content = "Failed to teleport to buttons, Cannot teleport in lobby.",
                Duration = "1.5",
                Image = "bell-ring",
            })
            openDevConsole()
            task.wait(2.5)
            closeDevConsole()
        end
   end,
})

function Tpexit(pos)
    spawn(function()
        if not hrp then
            Rayfield:Notify({
                Title = "Peteware",
                Content = "HumanoidRootPart wasnt available.",
                Duration = 1.5,
                Image = "bell-ring",
            })
            return
        end

        local mapName = GetMapName()
        local targetCFrame

        if mapName == "Sinking Ship" then
    local map = game.Workspace.Multiplayer:FindFirstChild("Map") and game.Workspace.Multiplayer.Map:FindFirstChild("Section2")
    local exitV2 = map and map:FindFirstChild("ExitRegion")
    if exitV2 then
        targetCFrame = exitV2.CFrame
    else
        Rayfield:Notify({
   Title = "Peteware",
   Content = "Couldnt locate Exit Region.",
   Duration = 1.5,
   Image = "bell-ring",
})
    end
else
            local map = game.Workspace.Multiplayer:FindFirstChild("Map")
            local exitBlock = map and map:FindFirstChild("ExitRegion")
            
            if exitBlock then
                targetCFrame = exitBlock.CFrame
            else
                if pos == 1 then
                    targetCFrame = CFrame.new(2080, 990, 2)
                elseif pos == 2 then
                    targetCFrame = CFrame.new(4080, 990, 2)
                else
                    Rayfield:Notify({
   Title = "Peteware",
   Content = "Couldnt locate Exit Region.",
   Duration = 1.5,
   Image = "bell-ring",
})
                    return
                end
            end
        end
        
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local pos = { CFrame = targetCFrame }

        local tpTween = tweenService:Create(hrp, tweenInfo, pos)
        tpTween:Play()
        tpTween.Completed:Wait()
    end)
end

local TPExitButton = Tab:CreateButton({
   Name = "Teleport to Exit",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local radius = 500

        if hrp then
            local distance = (hrp.Position - elevatorPosition).Magnitude
            if distance > radius then
                Rayfield:Notify({
   Title = "Peteware",
   Content = "Teleported to Exit.",
   Duration = 2.5,
   Image = "bell-ring",
})
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
                Rayfield:Notify({
   Title = "Peteware",
   Content = "Exit Teleport Failed, Cannot teleport in lobby.",
   Duration = 3.5,
   Image = "bell-ring",
})
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
        local distance = (hrp.Position - elevatorPosition).Magnitude

        if distance < 500 then
       hrp.CFrame = CFrame.new(-25, -145, 47)
       else
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Cannot teleport while In-Game.",
   Duration = 1.5,
   Image = "bell-ring",
})
        end
   end,
})

local ElevatorTPButton = Tab:CreateButton({
   Name = "Elevator",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (hrp.Position - elevatorPosition).Magnitude

        if distance < 500 then
       hrp.CFrame = CFrame.new(-26, -144, 74)
       else
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Cannot teleport while In-Game.",
   Duration = 1.5,
   Image = "bell-ring",
})
        end
   end,
})

local SecretAreaTPButton = Tab:CreateButton({
   Name = "Secret Area",
   Callback = function()
       local elevatorPosition = Vector3.new(-26, -144, 74)
        local distance = (hrp.Position - elevatorPosition).Magnitude

        if distance < 500 then
       hrp.CFrame = CFrame.new(-61, -177, -40)
       else
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Cannot teleport while In-Game.",
   Duration = 1.5,
   Image = "bell-ring",
})
        end
   end,
})

local Tab = Window:CreateTab("Misc", "circle-ellipsis")

local Section = Tab:CreateSection("Other")

local autoLock = false

local function StartAutoLock()
    autoLock = true
    Rayfield:Notify({
    Title = "Peteware",
   Content = "Auto Insane Lock On. Automatically locks to insane.",
   Duration = 3.5,
   Image = "bell-ring",
})
end

local function StopAutoLock()
    autoLock = false
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
       local map = game.Workspace.Multiplayer:FindFirstChild("Map")

if map then
    local ExitBlock = map:FindFirstChild("ExitBlock")
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

_G.ControllerShiftlock = false

local ControllerShiftlockButton = Tab:CreateButton({
   Name = "Controller Shiftlock",
   Callback = function()
       if _G.ControllerShiftlock then
           Rayfield:Notify({
   Title = "Peteware",
   Content = "Controller Shiftlock Enabled.",
   Duration = 6.5,
   Image = "bell-ring",
})    
           return
       end
       Rayfield:Notify({
   Title = "Peteware",
   Content = "Controller Shiftlock Enabled. Controls: RB on Xbox, R1 on Playstation.",
   Duration = 6.5,
   Image = "bell-ring",
})    

local shiftlockEnabled = false
local gameSettings = UserSettings():GetService("UserGameSettings")
local g, J

local function ForceShiftLock()
    local success, rotationType = pcall(function()
        return GameSettings.RotationType
    end)
    if success then g = rotationType end

    J = runService.RenderStepped:Connect(function()
        pcall(function()
            GameSettings.RotationType = Enum.RotationType.CameraRelative
        end)
    end)
end

local function EndForceShiftLock()
    if J then
        pcall(function()
            gameSettings.RotationType = g or Enum.RotationType.MovementRelative
        end)
        J:Disconnect()
    end
end
       
uis.InputBegan:Connect(function(uis, gameProcessed)
    if gameProcessed then return end
    
    if uis.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR1 then
        shiftlockEnabled = not shiftlockEnabled
        if shiftlockEnabled then
            ForceShiftLock()
        else
            EndForceShiftLock()
        end
    end
end)
       _G.ControllerShiftlock = true
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
       RejoinServer()
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
       ServerHop()
   end,
})

local keepPeteware = true
local teleportConnection

local keepPetewareToggle = Tab:CreateToggle({
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

            keepPeteware = true

            if teleportConnection then
                teleportConnection:Disconnect()
            end
            
            teleportConnection = player.OnTeleport:Connect(function(State)
                if keepPeteware and queueteleport then
                    queueteleport([[
                        local success, err = pcall(function()
                            repeat task.wait() until game:IsLoaded()
                            task.wait(1)
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/PetewareScripts/Peteware-V1/refs/heads/main/Loader",true))()
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

keepPetewareToggle:Set(true)

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
            local OldRayfieldPath = coreGui:FindFirstChild("Rayfield-Old")
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
       starterGui:SetCore("DevConsoleVisible", true)
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
	    sendingStatus = false
	    webhookStatus = false
            isFarming = false
             keepPeteware = false
             if teleportConnection then
                teleportConnection:Disconnect()
             end
             autoLock = false
	     autoLockWait = false
             task.wait()
             _G.Execution = false
	     execution = false
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
runService.RenderStepped:Connect(function()
    if webhookStatus then
        autofarmStatus = "🟢"
        if ShouldRun("autofarmWebhook", 60) then
        AutofarmWebhook()
        end
    else
        task.wait(1)
        autofarmStatus = "🔴"
    end
    if autoLock and ShouldRun("autoLock", 3) then
        replicatedStorage:WaitForChild("Remote"):WaitForChild("BuyDifLock"):FireServer()
    end
end)

--[[// Credits
Infinite Yield: Server Hop and Anti-AFK
Infinite Yield Discord Server: https://discord.gg/78ZuWSq
Also my friend for the controller shiftlock
but he doesnt have anything really he just knows lua
]]
