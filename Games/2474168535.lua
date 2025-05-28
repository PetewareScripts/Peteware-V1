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

--// Loading Handler
if not game:IsLoaded() then
repeat task.wait() until game:IsLoaded()
task.wait(1)
end

--// Execution Handler
if _G.Execution then
    pcall(function()
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
        warn("[Peteware]: Already Executed, Destroy the UI first if you want to execute again.")
        end)
    return
    else
        _G.Execution = true
end
local execution = true

--// Services & Setup
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local virtualUser = game:GetService("VirtualUser")
local coreGui = game:GetService("CoreGui")

local player = players.LocalPlayer

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

local inventory = player:WaitForChild("States"):WaitForChild("Bag")
local maxBag = player:WaitForChild("Stats"):WaitForChild("BagSizeLevel"):WaitForChild("CurrentAmount")
local robRemote = replicatedStorage:WaitForChild("GeneralEvents"):WaitForChild("Rob")
local depositPoint = CFrame.new(1636.62537, 104.349976, -1736.184)

local farmActive = false

local function SpawnLocation()
        local args = {
	"RedRocks",
}
    replicatedStorage:WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end

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

SetupCharacter()

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    
    if method == "FireServer" and tostring(self) == "ChangeCharacter" then
        if farmActive then
        task.wait(6)
        SpawnLocation()
    end
    end

    return oldNamecall(self, ...)
end))

player.CharacterAdded:Connect(function()
    task.wait(1)
    if execution then
    SetupCharacter()
    if farmActive and not clonedStatus then
        CloneHumanoid()
       end
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
        local usedScript = "Westbound Autofarm Peteware v1.1.0"

        local jsonData = game:GetService("HttpService"):JSONEncode({
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

--// Anti-AFK
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.zero)
end)

--// Overlay UI Setup
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

--// UI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "FarmInterface"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = coreGui
gui.DisplayOrder = 1000
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(300, 200)
frame.Position = UDim2.new(0.7, 0, 0.5, -100)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(35, 25, 10)
frame.BackgroundTransparency = 0.1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(220, 130, 40)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Westbound Autofarm Peteware v1.0.0"
title.TextColor3 = Color3.fromRGB(255, 180, 80)
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.fromOffset(120, 40)
toggleBtn.Position = UDim2.new(0.5, -60, 1, -60)
toggleBtn.AnchorPoint = Vector2.new(0.5, 1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 130, 40)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Text = "Start Autofarm"
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

--// Stats UI
local info = Instance.new("Frame")
info.Position = UDim2.new(0, 15, 0, 50)
info.Size = UDim2.new(1, -30, 1, -120)
info.BackgroundTransparency = 1
info.Parent = frame
Instance.new("UIListLayout", info).Padding = UDim.new(0, 8)

local function statLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(255, 200, 120)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text
    lbl.Parent = info
    return lbl
end

local statusText = statLabel("Autofarm Status: Loading...")
local cashText = statLabel("Earnings: $0")
local pingText = statLabel("Ping: Calculating...")
local fpsText = statLabel("FPS: Loading...")
local timerText = statLabel("Elapsed Time: 00:00:00")

--// Draggable UI
local dragging, dragInput, dragStart, startPos, tween
local function beginDrag(input)
    dragging = true
    dragStart, startPos = input.Position, frame.Position
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
    end)
end
local function UpdateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        if tween then tween:Cancel() end
        tween = tweenService:Create(frame, TweenInfo.new(0.08), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        })
        tween:Play()
    end
end
for _, obj in ipairs({frame, title}) do
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            UpdateDrag(input)
        end
    end)
end

--// Button Handlers
closeBtn.MouseButton1Click:Connect(function()
    SpawnLocation()
    PetewareOverlay.Hide()
  _G.Execution = false
    execution = false
  farmActive = false
    gui:Destroy()
end)

toggleBtn.MouseButton1Click:Connect(function()
    task.wait(1)
    farmActive = not farmActive
    toggleBtn.Text = farmActive and "Stop Autofarm" or "Start Autofarm"
    if farmActive then
        PetewareOverlay.Show()
    elseif not farmActive then
        clonedStatus = false
        SpawnLocation()
        PetewareOverlay.Hide()
    end
end)

--// Stats Update
local startCash = player:WaitForChild("leaderstats"):WaitForChild("$$").Value
local seconds, minutes, hours = 0, 0, 0
local function Format(n)
    return tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

task.spawn(function()
    while task.wait(1) do
        local ping = game:GetService("Stats"):FindFirstChild("PerformanceStats") and game.Stats.PerformanceStats:FindFirstChild("Ping")
        pingText.Text = ping and ("Ping: " .. math.floor(ping:GetValue()) .. "ms") or "Ping: N/A"
        fpsText.Text = "FPS: " .. math.floor(1 / runService.RenderStepped:Wait())
    end
end)

task.spawn(function()
    while task.wait(1) do
        if farmActive then
        statusText.Text = "Autofarm Status: 🟢"    
        seconds += 1
        if seconds >= 60 then seconds = 0 minutes += 1 end
        if minutes >= 60 then minutes = 0 hours += 1 end
        timerText.Text = string.format("Elapsed Time: %02d:%02d:%02d", hours, minutes, seconds)
        else
        statusText.Text = "Autofarm Status: 🔴"    
        end
        local currentCash = player.leaderstats["$$"].Value
        cashText.Text = "Earnings: $" .. Format(currentCash - startCash)
    end
end)

--// Robbing Logic
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

local function BagUpgrade()
    hrp.CFrame = CFrame.new(1609, 122, 1519)
end

--// Autofarming Execution
runService.RenderStepped:Connect(function()
    if farmActive then
        if not clonedStatus then 
            CloneHumanoid()
        end
        if not LootRegister() then
            LootSafe()
        end
    end
end)

--// Autofarming Webhook  (next update maybe)

--[[// Credits
Infinite Yield: Anti-AFK
Infinite Yield Discord Server: https://discord.gg/78ZuWSq
]]
