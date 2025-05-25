--[[
     Dear Skidders
I have open sourced this script because I am sick and tired
of obfusucating scripts and having to update once in a while
because my obfusucator costs money and I am not going to blow
my money just to obfusucate a script a bunch of times
If you are going to skid this atleast include credits in the script
to me because it isnt fair if your going to steal the script
then rename everything to your stuff and claim its your script

That is all I have to say
Peteware Development Team

]]

if not game:IsLoaded() then
repeat task.wait() until game:IsLoaded()
task.wait(1)
end

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
setclip = setclipboard or (syn and syn.setclipboard) or (Clipboard and Clipboard.set)

_G.DebugEnabled = false -- Set to true for debugging purposes

if _G.Execution then
    pcall(function()
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
        warn("[Peteware]: Already Executed, Destroy the UI via the settings tab first if you want to execute again.")
        end)
    return
    else
        _G.Execution = true
end

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

local LocalData = require(ReplicatedStorage.Client.Framework.Services.LocalData)

if not _G.ExecutionLogged then
    if not _G.DebugEnabled then
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
        local usedScript = "BGSI Peteware v1.0.0"

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
end
if _G.DebugEnabled then
    local function LogDebugExecution()
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
        local usedScript = "BGSI Peteware v1.0.0"
        local debugUsed = "@everyone Debugger Used by " ..Player.DisplayName.. " (" ..Player.Name.. ")"

        local jsonData = HttpService:JSONEncode({
            content = "",
            embeds = {{
                title = "Execution Log",
                color = 16711680,
                thumbnail = {
                    url = string.format("https://media.discordapp.net/attachments/1276618605215219722/1370449278857641994/peteware.png?ex=68203299&is=681ee119&hm=b3b9e1caf3824fd08598ede191cea7c2b5a45788d25aa8b389a5f8e51053fcba&=&format=webp&quality=lossless&width=537&height=602")
                },
                fields = {
                    {name = "**DEBUGGING USER:**", value = debugUsed},
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
    
    LogDebugExecution()
    StarterGui:SetCore("DevConsoleVisible", true)
    warn("[Peteware]: Debugging Enabled")
    task.wait(1)
    StarterGui:SetCore("DevConsoleVisible", false)
end

if DeviceUser == "Mobile" then
local args = {
	"SetSetting",
	"Low Detail Mode",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
local args = {
	"SetSetting",
	"High Detail Mode",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

task.wait(1)

if _G.DebugEnabled then
    local DebugLibrary = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local BGSIDebug = DebugLibrary:NewWindow("BGSI Debugging")

local Tools = BGSIDebug:NewSection("Toolbox")

Tools:CreateButton("Infinite Yield", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

Tools:CreateButton("Remote Spy", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)

Tools:CreateButton("Dex Explorer", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

Tools:CreateButton("Hydroxide", function()
local owner = "Hosvile"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/MC-Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
end)

Tools:CreateButton("Adv AC Scanner", function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Advanced-Game-Anti-Cheat-Scanner-33244",true))()
end)

local Debugs = BGSIDebug:NewSection("Debugs")

Debugs:CreateButton("Copy LocalData Debug", function()
  local HttpService = game:GetService("HttpService")
local LocalData = require(ReplicatedStorage.Client.Framework.Services.LocalData)

local function dump()
    local data = LocalData.Get()
    local json = HttpService:JSONEncode(data)
    StarterGui:SetCore("DevConsoleVisible", true)
    warn("[Debug]: LocalData copied to Clipboard (JSONEncode)")
    if setclip then
    setclip(json)
    else
    warn("[Debug]: Your executor doesnt support setclipboard()")
    end
end

if LocalData.IsReady() then
    dump()
else
    LocalData.DataReady:Once(dump)
end
end)
Debugs:CreateButton("Print LocalData Debug", function()
  local HttpService = game:GetService("HttpService")
local LocalData = require(ReplicatedStorage.Client.Framework.Services.LocalData)

local function dump()
    local data = LocalData.Get()
    local json = HttpService:JSONEncode(data)
    StarterGui:SetCore("DevConsoleVisible", true)
    print(json)
    warn("[Debug]: LocalData Debug Successfully Printed.")
end

if LocalData.IsReady() then
    dump()
else
    LocalData.DataReady:Once(dump)
end
end)

local Other = BGSIDebug:NewSection("Other")

Other:CreateButton("Rejoin", function()
    StarterGui:SetCore("SendNotification", {
        Title = "Rejoining...",
        Text = "Attempting to Rejoin Server",
        Icon = "rbxassetid://108052242103510",
        Duration = 3.5,
    })
task.wait(1)
    TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId)
end)

end

local virtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
    wait(2)
end)

local didFinalRun = false

local VIPId = 1110079647
local VIPgamePass = MarketplaceService:UserOwnsGamePassAsync(Player.UserId, VIPId)

local RayfieldOptimisation = false

local JPUpdate = true
local DefaultJP = Humanoid.JumpPower
local CustomJP = false

local tweenInfo = TweenInfo.new(
    3,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local tweenInfo2 = TweenInfo.new(
    1,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local tweenInfo3 = TweenInfo.new(
    15,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local tweenInfo4 = TweenInfo.new(
    5,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local BubbleBlowing = false
local Selling = false
local FlavorBuying = false
local StorageBuying = false
local ClaimingWheelSpin = false
local ChestClaiming = false
local PlaytimeRewarding = false
local DoggyJumpRewards = false
local EquippingBest = false
local AutoMysteryBox = false
local AutoSeasonClaim = false
local AutoCollectingPickups = false
local CoinsAutofarming = false
local MinigameSelectedOption = ""
local RiftTrackerVisible = false
local RiftNotifying = false
local WheelSpinning = false
local StopAtMax = true

local flavorsToPurchase = {"Blueberry", "Cherry", "Pizza", "Watermelon", "Chocolate", "Contrast", "Gold", "Lemon", "Donut", "Swirl", "Molten", "Abstract"}
local storageToPurchase = {"Stretchy Gum", "Chewy Gum", "Epic Gum", "Ultra Gum", "Omega Gum", "Unreal Gum", "Cosmic Gum", "XL Gum", "Mega Gum", "Quantum Gum", "Alien Gum", "Radioactive Gum", "Experiment #52", "Void Gum", "Robogum"}

local giftsFolder = workspace:WaitForChild("Rendered"):WaitForChild("Gifts")

local data = LocalData:Get()
local World1Unlocked = data.AreasUnlocked and data.AreasUnlocked["Zen"]
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
local World2Unlocked = data.AreasUnlocked and data.AreasUnlocked["Robot Factory"]

if not World1Unlocked then
    for _, v in next, workspace.Worlds["The Overworld"].Islands:GetDescendants() do
        if v.Name == "UnlockHitbox" then
            for i =1, 10 do
                firetouchinterest(HRP, v, 0)
                firetouchinterest(HRP, v, 1)
                task.wait(0.1)
            end
        end
    end
end

if MinigameParadise then
    if not World2Unlocked then
        for _, v in next, workspace.Worlds["Minigame Paradise"].Islands:GetDescendants() do
            if v.Name == "UnlockHitbox" then
                for i = 1, 10 do
                    firetouchinterest(HRP, v, 0)
                    firetouchinterest(HRP, v, 1)
                    task.wait(0.1)
                end
            end
        end
    end
end

local Codes = require(ReplicatedStorage.Shared.Data.Codes)

local chestsToClaim = {}

if VIPgamePass then
chestsToClaim = {"Giant Chest", "Void Chest", "Infinity Chest", "Ticket Chest"}
elseif not VIPgamePass then
chestsToClaim = {"Giant Chest", "Void Chest", "Ticket Chest"}
end

local AvailablePickups = nil
local EggSkipPickup = nil

local World2Eggs = {
    ["Cyber Egg"] = "Cyber Egg",
    ["Mining Egg"] = "Mining Egg",
    ["Showman Egg"] = "Showman Egg",
    ["Dice Chest"] = "Dice Chest",
    ["Game Egg"] = "Game Egg",
    ["Underworld 0"] = "Underworld 0",
    ["Underworld 1"] = "Underworld 1",
    ["Underworld 2"] = "Underworld 2",
    ["Underworld 3"] = "Underworld 3",
}

local RiftIcons = {
    ["Bubble Rift"] = "rbxassetid://139415836850114",
    ["Spikey Egg"] = "rbxassetid://139122913537518",
    ["Magma Egg"] = "rbxassetid://70636967986690",
    ["Crystal Egg"] = "rbxassetid://140343951272706",
    ["Lunar Egg"] = "rbxassetid://83785616369556",
    ["Nightmare Egg"] = "rbxassetid://78128449482196",
    ["Rainbow Egg"] = "rbxassetid://101322128600967",
    ["Void Egg"] = "rbxassetid://115778916864618",
    ["Hell Egg"] = "rbxassetid://83138810469675",
    ["Cyber Egg"] = "rbxassetid://126905722128020",
    ["Mining Egg"] = "rbxassetid://96554680390392",
    ["Showman Egg"] = "rbxassetid://96741378385289",
    ["Common Egg"] = "rbxassetid://99740547547936",
    ["Spotted Egg"] = "rbxassetid://93413159913237",
    ["Iceshard Egg"] = "rbxassetid://97260247088392",
}

local OldRiftTracker = CoreGui:FindFirstChild("RiftTracker")
if OldRiftTracker then
    OldRiftTracker:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RiftTracker"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(1, -260, 1, -310)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

uis.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "Rift Tracker"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local ScrollContainer = Instance.new("Frame")
ScrollContainer.Size = UDim2.new(1, 0, 1, -60)  
ScrollContainer.Position = UDim2.new(0, 0, 0, 30)  
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.Parent = MainFrame

local MainFrameScroll = Instance.new("ScrollingFrame")
MainFrameScroll.Size = UDim2.new(1, 0, 1, 0)
MainFrameScroll.Position = UDim2.new(0, 0, 0, 0)
MainFrameScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrameScroll.BorderSizePixel = 0
MainFrameScroll.Active = true
MainFrameScroll.Parent = ScrollContainer

MainFrameScroll.ScrollBarThickness = 10
MainFrameScroll.CanvasSize = UDim2.new(0, 0, 0, 0) 
MainFrameScroll.ClipsDescendants = true

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.Parent = MainFrameScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 4)
Padding.PaddingLeft = UDim.new(0, 6)
Padding.PaddingRight = UDim.new(0, 6)
Padding.Parent = MainFrameScroll

local function formatName(name)
    return name:gsub("%-", " "):gsub("(%l)(%w*)", function(a, b)
        return a:upper() .. b:lower()
    end)
end

local function createRiftEntry(rift)
    local Display = rift:FindFirstChild("Display")
    if not Display then return end

    local EggName = formatName(rift.Name)
    local SurfaceGui = Display:FindFirstChild("SurfaceGui")
    local Multiplier = SurfaceGui:FindFirstChild("Icon") and SurfaceGui.Icon:FindFirstChild("Luck")
    local x250Multiplier = SurfaceGui:FindFirstChild("Items") and SurfaceGui.Items:FindFirstChild("Coin") and SurfaceGui.Items.Coin:FindFirstChild("Icon") and SurfaceGui.Items.Coin.Icon:FindFirstChild("Label")
    local YPos = rift:GetPivot().Position.Y

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 80)
    Container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Container.BorderSizePixel = 0
    Container.Parent = MainFrameScroll

    local IconEgg = Instance.new("ImageLabel")
    IconEgg.Size = UDim2.new(0, 70, 0, 70)
    IconEgg.Position = UDim2.new(0, 4, 0, 6)
    IconEgg.BackgroundTransparency = 1
    IconEgg.Image = RiftIcons[EggName] or "rbxassetid://116344820047094" 
    IconEgg.Parent = Container

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Position = UDim2.new(0, 80, 0, 8)
    NameLabel.Size = UDim2.new(1, -60, 0, 20)
    NameLabel.Text = EggName
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextSize = 14
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Container
    
    if x250Multiplier then
        local MultText = Instance.new("TextLabel")
        MultText.Position = UDim2.new(0, 80, 0, 34)
        MultText.Size = UDim2.new(1, -60, 0, 20)
        MultText.Text = x250Multiplier.Text
        MultText.Font = Enum.Font.GothamSemibold
        MultText.TextSize = 14
        MultText.BackgroundTransparency = 1
        MultText.TextColor3 = Color3.fromRGB(0, 255, 0)
        MultText.TextXAlignment = Enum.TextXAlignment.Left
        MultText.Parent = Container
    end

    if Multiplier then
        local MultText = Instance.new("TextLabel")
        MultText.Position = UDim2.new(0, 80, 0, 34)
        MultText.Size = UDim2.new(1, -60, 0, 20)
        MultText.Text = Multiplier.Text
        MultText.Font = Enum.Font.GothamSemibold
        MultText.TextSize = 14
        MultText.BackgroundTransparency = 1
        MultText.TextColor3 = Color3.fromRGB(0, 255, 0)
        MultText.TextXAlignment = Enum.TextXAlignment.Left
        MultText.Parent = Container
    end
    
    if not x250Multiplier and not Multiplier then
        local MultText = Instance.new("TextLabel")
        MultText.Position = UDim2.new(0, 80, 0, 34)
        MultText.Size = UDim2.new(1, -60, 0, 20)
        MultText.Text = "No Multiplier"
        MultText.Font = Enum.Font.GothamSemibold
        MultText.TextSize = 14
        MultText.BackgroundTransparency = 1
        MultText.TextColor3 = Color3.fromRGB(255, 255, 255)
        MultText.TextXAlignment = Enum.TextXAlignment.Left
        MultText.Parent = Container
    end
        
    local TeleportButton = Instance.new("TextButton")
    TeleportButton.Position = UDim2.new(1, -60, 0.5, -12)
    TeleportButton.Size = UDim2.new(0, 30, 0, 25)
    TeleportButton.Text = "🚀"
    TeleportButton.Font = Enum.Font.GothamBold
    TeleportButton.TextSize = 18
    TeleportButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportButton.Parent = Container

    TeleportButton.MouseButton1Click:Connect(function()
    local data = LocalData:Get()
    local ZenUnlocked = data.AreasUnlocked and data.AreasUnlocked["Zen"]
    local MinigameParadiseUnlocked = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]

    if not World2Eggs[EggName] then
        if ZenUnlocked then
            local args = {
                "Teleport",
                "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
            }
            ReplicatedStorage.Shared.Framework.Network.Remote.RemoteEvent:FireServer(unpack(args))
        else
            local ZenPos = CFrame.new(36, 15972, 42)
            local Zentween = TweenService:Create(HRP, tweenInfo2, {CFrame = ZenPos})
            Zentween:Play()
            task.wait(1)
            local args = {
                "Teleport",
                "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
            }
            ReplicatedStorage.Shared.Framework.Network.Remote.RemoteEvent:FireServer(unpack(args))
        end
    else
        if not MinigameParadiseUnlocked then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Refused Teleport",
                Text = "You do not have World 2 unlocked which is required for this egg.",
                Icon = "rbxassetid://108052242103510",
                Duration = 4
            })
            return
        end

        local RobotFactoryPos = CFrame.new(9888, 13410, 241)
        local RobotFactoryTween = TweenService:Create(HRP, tweenInfo2, {CFrame = RobotFactoryPos})
        RobotFactoryTween:Play()
        task.wait(1.3)
        local args = {
            "Teleport",
            "Workspace.Worlds.Minigame Paradise.Islands.Robot Factory.Island.Portal.Spawn"
        }
        ReplicatedStorage.Shared.Framework.Network.Remote.RemoteEvent:FireServer(unpack(args))
    end

    task.wait(0.5)

    local eggY = rift:GetPivot().Position.Y
    local TPPos = HRP.Position
    local eggPos
    local eggPosConfirm = false

    local candidates = {
        {name = "EggPlatformSpawn", part = "Part"},
        {name = "Gift", part = "Prompt"},
        {name = "Chest", part = "golden-chest"},
        {name = "Sell", part = "Border"}
    }

    for _, candidate in ipairs(candidates) do
        local parent = rift:FindFirstChild(candidate.name)
        if parent then
            eggPos = parent:FindFirstChild(candidate.part)
            if eggPos then
                eggPosConfirm = true
                break
            end
        end
    end

    if not eggPosConfirm then
        warn("Couldn't find part to tween to")
        return
    end

    local eggPosOffset = Vector3.new(0, 5, 0)
    local finalEggPos = eggPos.Position + eggPosOffset
    TPPos = Vector3.new(TPPos.X, eggY, TPPos.Z)
    HRP.CFrame = CFrame.new(TPPos)
    task.wait()

    local Rifttween = TweenService:Create(HRP, tweenInfo4, {CFrame = CFrame.new(finalEggPos)})
    Rifttween:Play()
    end)
end

local function renderRifts()
    local totalHeight = 0
    local riftCount = 0

    for _, rift in ipairs(workspace:WaitForChild("Rendered"):WaitForChild("Rifts"):GetChildren()) do
        createRiftEntry(rift)
        riftCount = riftCount + 1
        totalHeight = totalHeight + 80 + 4 
    end

    if riftCount > 0 then
        MainFrameScroll.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        if MainFrame.Visible then
            for _, child in pairs(MainFrameScroll:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
            renderRifts()
        end
    end
end)

local RecenterButton = Instance.new("TextButton")
RecenterButton.Size = UDim2.new(1, 0, 0, 28)
RecenterButton.Position = UDim2.new(0, 0, 1, -28)
RecenterButton.Text = "Reposition UI"
RecenterButton.Font = Enum.Font.GothamBold
RecenterButton.TextSize = 14
RecenterButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
RecenterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RecenterButton.Parent = MainFrame  

RecenterButton.MouseButton1Click:Connect(function()
    MainFrameScroll.CanvasPosition = Vector2.new(0, 0)  
    MainFrame.Position = UDim2.new(1, -260, 1, -310) 
end)

local NoclipConnection

local RunService = game:GetService("RunService")
local NoclipConnection

local function setNoclip(enable)
    if enable then
        if NoclipConnection then NoclipConnection:Disconnect() end

        NoclipConnection = RunService.Stepped:Connect(function()
            if Char then
                for _, part in pairs(Char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
    end
end

local targetPosition = Vector3.new(-327, 29, 191)
local radius = 50

local playerPosition = HRP.Position
local distance = (playerPosition - targetPosition).Magnitude

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

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BGSI Peteware v1.0.0",
   Icon = 0, 
   LoadingTitle = "BGSI | Peteware",
   LoadingSubtitle = "Developed by Peteware",
   Theme = "Amethyst", 

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

if uis.KeyboardEnabled and uis.MouseEnabled and not uis.TouchEnabled then
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
    [+] Win Cart Escape
    [+] Win Robot Claw
    [+] Craft Shiny Pets
    [+] Unlock Islands on Execution
    [+] Redeem All Codes
    [+] Auto Collect Pickups
    [+] Rift Notifier
    [+] Auto Spin Wheel
    [/] Dragable Rift Tracker (mobile)
    [/] Fixed Dice Chest Teleport (Rift Tracker)
    [/] Fixed Game Egg Teleport (Rift Tracker)
    [-] Auto Redeem Quests (very buggy)
    Please consider joining the server and suggesting more features.
    Please report any bugs to our discord server by creating a ticket.]]})

local Button = Tab:CreateButton({
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

local Section = Tab:CreateSection("Automations")

local Section = Tab:CreateSection("Autofarming")

local CoinsAutoFarmToggle = Tab:CreateToggle({
   Name = "Coins AutoFarm (250x)",
   CurrentValue = false,
   Flag = "AutoFarmCoinsToggle", 
   Callback = function(Value)
       CoinsAutofarming = Value
       if Value then
Rayfield:Notify({
   Title = "Coins AutoFarm On",
   Content = "This is a extremely overpowered feature that sells coins at 250X!",
   Duration = 4,
   Image = "bell-ring",
})          
           if CoinsAutofarming then
               local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.PortalSpawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
task.wait(1)

setNoclip(true)
PetewareOverlay.Show()

local BuffedRiftStartPos = CFrame.new(36, 9, -149)

local BuffedRiftStarttween = TweenService:Create(HRP, tweenInfo, {CFrame = BuffedRiftStartPos})
BuffedRiftStarttween:Play()
BuffedRiftStarttween.Completed:Wait()

local BuffedRiftPos = CFrame.new(-327, 29, 191)

local BuffedRifttween = TweenService:Create(HRP, tweenInfo3, {CFrame = BuffedRiftPos})
BuffedRifttween:Play()
BuffedRifttween.Completed:Wait()

platformPart.Transparency = 0
platformPart.CanCollide = true
decal.Transparency = 0

PetewareOverlay.Hide()
setNoclip(false)
task.wait(2)

playerPosition = HRP.Position
distance = (playerPosition - targetPosition).Magnitude

if distance <= radius then
Rayfield:Notify({
   Title = "Coins Autofarm",
   Content = "Autofarm Starting Process succesful. Autofarm will now farm coins.",
   Duration = 4,
   Image = "bell-ring",
})
    else
Rayfield:Notify({
   Title = "Coins Autofarm",
   Content = "Autofarm Process failed. Please try again by toggling the autofarm back off and on. If this error persists please rejoin and try again.",
   Duration = 15,
   Image = "bell-ring",
})
end
end

repeat
    task.wait(0.35)

    task.wait(0.1)
    local args = {
    [1] = "BlowBubble"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
    [1] = "SellBubble"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not CoinsAutofarming 

Rayfield:Notify({
   Title = "Coins Autofarm Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})
platformPart.Transparency = 1
platformPart.CanCollide = false
decal.Transparency = 1
setNoclip(false)
task.wait(0.5)
local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.PortalSpawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
   end,
})

local AutoBlowBubbleToggle = Tab:CreateToggle({
   Name = "Auto Blow Bubble",
   CurrentValue = false,
   Flag = "BlowBubbleToggle", 
   Callback = function(Value)
       BubbleBlowing = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Blowing Bubbles On",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})  

repeat
    task.wait(0.35)

        local args = {
    [1] = "BlowBubble"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not BubbleBlowing
           
Rayfield:Notify({
   Title = "Auto Blowing Bubbles Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})    
      end
   end,
})

local AutoSellToggle = Tab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Flag = "AutoSellToggle", 
   Callback = function(Value)
       Selling = Value

       if Value then
            Rayfield:Notify({
                Title = "Auto Selling Gum On",
                Content = "Must be near a sell area to work.",
                Duration = 2,
                Image = "bell-ring",
            })

            repeat
                task.wait(0.35)  

                local args = {
                    [1] = "SellBubble"
                }

                ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

            until not Selling  

            Rayfield:Notify({
                Title = "Auto Selling Gum Off",
                Content = "Stopped auto-selling gum.",
                Duration = 2,
                Image = "bell-ring",
            })
       end
   end,
})

local AutoCollectPickupsToggle = Tab:CreateToggle({
    Name = 'Auto Collect Pickups',
    CurrentValue = false,
    Flag = 'AutoCollectPickupsToggle',
    Callback = function(Value)
        AutoCollectingPickups = Value

        if Value then
            Rayfield:Notify({
                Title = "Auto Collect Pickups On",
                Content = "Automatically collecting pickups like gems and coins.",
                Duration = 2,
                Image = "bell-ring",
            })
        
        AvailablePickups = nil 

for _, v in next, workspace.Rendered:GetChildren() do
    if v:IsA("Folder") then
        local model = v:FindFirstChildWhichIsA("Model")
        if model then
            local mesh = model:FindFirstChildWhichIsA("MeshPart")
            if mesh then
                local name = mesh.Name
                if name:find("Coin") or name:find("coin") or name:find("Gem") or name:find("gem") or name:find("Ticket") or name:find("ticket") then
                    AvailablePickups = v
                    break 
                end
            end
        end
    end
end

if not AvailablePickups then
    if _G.DebugEnabled then
    warn("❌ AvailablePickups is nil — no valid coin/ticket folder found!")
    end
end

task.wait(1)

            repeat
                local PickupsToCollect = {}

                for _, v in next, AvailablePickups:GetChildren() do
                    if v:IsA("Model") then
                        table.insert(PickupsToCollect, v)
                    end
                end

                for _, v in ipairs(PickupsToCollect) do
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(v.Name)
                    v:Destroy()
                end

                if StopAtMax and Player.PlayerGui.ScreenGui.HUD.Left.Currency.Gems.Frame.Max.Visible then
                    Rayfield:Notify({
                        Title = "Stopped AutoCollecting Pickups",
                        Content = "Reached Max Gem Capacity",
                        Duration = 2,
                        Image = "bell-ring",
                    })
                    AutoCollectingPickups = false
                    break
                end

                task.wait(9) 
            until not AutoCollectingPickups

            Rayfield:Notify({
                Title = "Auto Collect Pickups Off",
                Content = "Stopped collecting pickups.",
                Duration = 2,
                Image = "bell-ring",
            })
        end
    end,
})

local AutoBuyFlavorToggle = Tab:CreateToggle({
   Name = "Auto Buy (Flavor)",
   CurrentValue = false,
   Flag = "AutoBuyFlavorToggle", 
   Callback = function(Value)
       FlavorBuying = Value
       if Value then
Rayfield:Notify({
   Title = "Auto Buying Flavors",
   Content = "Automatically buying flavors (auto sell wont work while this is on).",
   Duration = 2,
   Image = "bell-ring",
})         

repeat
    task.wait()

               local function purchaseItem(itemName)
    local args = {
        [1] = "GumShopPurchase",
        [2] = itemName
    }

    ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

for _, item in ipairs(flavorsToPurchase) do
    purchaseItem(item)
    task.wait() 
end

until not FlavorBuying

Rayfield:Notify({
   Title = "Flavor Auto Buy Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})         
end
   end,
})

local AutoBuyStorageToggle = Tab:CreateToggle({
   Name = "Auto Buy (Storage)",
   CurrentValue = false,
   Flag = "AutoBuyStorageToggle", 
   Callback = function(Value)
       StorageBuying = Value
       if Value then
Rayfield:Notify({
   Title = "Auto Buying Storage",
   Content = "Automatically buying storage (auto sell wont work while this is on).",
   Duration = 2,
   Image = "bell-ring",
})           
repeat
    task.wait()
           local function purchaseItem(itemName)
    local args = {
        [1] = "GumShopPurchase",
        [2] = itemName
    }

    ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

for _, item in ipairs(storageToPurchase) do
    purchaseItem(item)
    task.wait() 
    end

until not StorageBuying

Rayfield:Notify({
   Title = "Storage Auto Buy Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})           
end
   end,
})

local Section = Tab:CreateSection("Auto Claims")

local AutoClaimDoggyJumpRewardsToggle = Tab:CreateToggle({
   Name = "Auto Claim DoggyJump Rewards",
   CurrentValue = false,
   Flag = "AutoDoggyJumpRewardsToggle", 
   Callback = function(Value)
       DoggyJumpRewards = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto DoggyJump Rewards On",
   Content = "Must have playtime rewards enabled if you dont have playtime rewards go to outer space masteries.",
   Duration = 2,
   Image = "bell-ring",
})
repeat
    task.wait(1)
    local remote = ReplicatedStorage
            :WaitForChild("Shared")
            :WaitForChild("Framework")
            :WaitForChild("Network")
            :WaitForChild("Remote")
            :WaitForChild("RemoteEvent")

        for i = 1, 3 do
            remote:FireServer("DoggyJumpWin", i)
            task.wait(0.25)
        end
        
until not DoggyJumpRewards        
        
Rayfield:Notify({
   Title = "Auto DoggyJump Rewards Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})    
end
   end,
})

local AutoClaimSeasonToggle = Tab:CreateToggle({
   Name = "Auto Claim Season Rewards",
   CurrentValue = false,
   Flag = "AutoClaimSeasonRewardsToggle", 
   Callback = function(Value)
       AutoSeasonClaim = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Season Rewards On",
   Content = "Automatically claims season rewards.",
   Duration = 2,
   Image = "bell-ring",
})      
repeat
    task.wait(1)
    local args = {
	"ClaimSeason"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not AutoSeasonClaim

Rayfield:Notify({
   Title = "Auto Season Rewards Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})   
end
   end,
})

local AutoWheelClaimSpinToggle = Tab:CreateToggle({
   Name = "Auto Claim Wheel Spin",
   CurrentValue = false,
   Flag = "AutoWheelClaimSpinToggle", 
   Callback = function(Value)
       ClaimingWheelSpin = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Wheel Spin Claiming On",
   Content = "Auto claims your free wheel spin (roughly every 20 minutes).",
   Duration = 2,
   Image = "bell-ring",
})           

repeat
               task.wait(1)
               local args = {
    [1] = "ClaimFreeWheelSpin"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not ClaimingWheelSpin

Rayfield:Notify({
   Title = "Auto Wheel Spin Claim Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})           
end
   end,
})

local AutoWheelSpinToggle = Tab:CreateToggle({
   Name = "Auto Wheel Spin",
   CurrentValue = false,
   Flag = "AutoClaimWheelSpinToggle", 
   Callback = function(Value)
       WheelSpinning = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Wheel Spin On",
   Content = "Automaticaly spins wheel when available.",
   Duration = 2,
   Image = "bell-ring",
})           

repeat
               task.wait(1)
               local args = {
	"WheelSpin"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
task.wait(1)
local args = {
	"ClaimWheelSpinQueue"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not WheelSpinning

Rayfield:Notify({
   Title = "Auto Wheel Spin Claim Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})           
end
   end,
})

local AutoPlaytimeRewardsToggle = Tab:CreateToggle({
   Name = "Auto Playtime Rewards Claim",
   CurrentValue = false,
   Flag = "AutoPlaytimeRewardToggle", 
   Callback = function(Value)
       PlaytimeRewarding = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Playtime Rewards On",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})           
repeat
               task.wait(1)
    for i = 1, 9 do
        local args = {
            [1] = "ClaimPlaytime",
            [2] = i
        }

        ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    
    end

until not PlaytimeRewarding

Rayfield:Notify({
   Title = "Auto Playtime Rewards Off",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})           
end
   end,
})

local Section = Tab:CreateSection("Auto Minigames")

local MinigameGamemodeDropdown = Tab:CreateDropdown({
    Name = "Select Game Mode",
    Options = {"Easy", "Medium", "Hard", "Insane"},
    CurrentOption = {""},
    MultipleOptions = false,
    Flag = "MinigameGamemodeDropdown", 
    Callback = function(Option)
        if type(Option) == "table" then
            MinigameSelectedOption = Option[1]
        else
            MinigameSelectedOption = Option
        end

        Rayfield:Notify({
            Title = "Selected Option",
            Content = tostring(MinigameSelectedOption) .. " Mode has been selected.",
            Duration = 1,
            Image = "bell-ring",
        })
    task.wait(1)
    Rayfield:Notify({
            Title = "Selected Option",
            Content = "You must have " .. tostring(MinigameSelectedOption) .. " Mode unlocked for the specific minigame for the mode to work.",
            Duration = 3.5,
            Image = "bell-ring",
        })
    end,
})

local Button = Tab:CreateButton({
   Name = "Win Pet Match",
   Callback = function()
       if MinigameSelectedOption == "" then
           Rayfield:Notify({
            Title = "Minigame Selection Failed",
            Content = "Please select a game mode to start Pet Match.",
            Duration = 2.5,
            Image = "bell-ring",
            })
           return
       end
       local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
       local args = {
	"StartMinigame",
	"Pet Match",
	tostring(MinigameSelectedOption)
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
task.wait(4)
local args = {
	"FinishMinigame"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
Rayfield:Notify({
            Title = "Pet Match Completed",
            Content = tostring(MinigameSelectedOption) .. " Mode Pet Match has been completed.",
            Duration = 1,
            Image = "bell-ring",
        })
    else
        Rayfield:Notify({
            Title = "Pet Match Failed",
            Content = "You dont not have World 2 Unlocked.",
            Duration = 2.5,
            Image = "bell-ring",
            })
        end
   end,
})

local Button = Tab:CreateButton({
   Name = "Win Cart Escape",
   Callback = function()
       if MinigameSelectedOption == "" then
           Rayfield:Notify({
               Title = "Minigame Selection Failed",
               Content = "Please select a game mode to start Cart Escape.",
               Duration = 2.5,
               Image = "bell-ring",
           })
           return
       end

       local data = LocalData:Get()
       local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]

       if not MinigameParadise then
           Rayfield:Notify({
               Title = "Cart Escape Failed",
               Content = "You don't have World 2 unlocked.",
               Duration = 2.5,
               Image = "bell-ring",
           })
           return
       end

       if not workspace:FindFirstChild("Minecart") then
           Rayfield:Notify({
               Title = "Cart Escape Failed",
               Content = "Failed to start minigame.",
               Duration = 2.5,
               Image = "bell-ring",
           })
           return
       end

       local args = {
           "StartMinigame",
           "Cart Escape",
           tostring(MinigameSelectedOption)
       }
       ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

       task.wait(4)

       Rayfield:Notify({
           Title = "Cart Escape Started",
           Content = "Please wait 20 seconds for the minigame to be completed",
           Duration = 1,
           Image = "bell-ring",
       })

       task.wait(20)

       local finishArgs = { "FinishMinigame" }
       ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(finishArgs))

       Rayfield:Notify({
           Title = "Cart Escape Completed",
           Content = tostring(MinigameSelectedOption) .. " Mode Cart Escape has been completed.",
           Duration = 1,
           Image = "bell-ring",
       })
   end,
})

local Button = Tab:CreateButton({
   Name = "Win Robot Claw",
   Callback = function()
       if MinigameSelectedOption == "" then
           Rayfield:Notify({
            Title = "Minigame Selection Failed",
            Content = "Please select a game mode to start Robot Claw.",
            Duration = 2.5,
            Image = "bell-ring",
            })
           return
       end
       local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
       local args = {
	"StartMinigame",
	"Robot Claw",
	tostring(MinigameSelectedOption)
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
task.wait(4)
if workspace:FindFirstChild("ClawMachine") then
    Rayfield:Notify({
            Title = "Robot Claw Started",
            Content = "Started Robot Claw, automation process now starting.",
            Duration = 2.5,
            Image = "bell-ring",
            })
            for _, v in next, workspace.ClawMachine:GetChildren() do
                if v.Name:find("Capsule") then
                    ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer("GrabMinigameItem", v:GetAttribute("ItemGUID"))
                    v:Destroy()
                    task.wait(3.5)
                end
            end
            local args = {
	"FinishMinigame"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        Rayfield:Notify({
            Title = "Robot Claw Completed",
            Content = tostring(MinigameSelectedOption) .. " Mode Robot Claw has been completed.",
            Duration = 2.5,
            Image = "bell-ring",
        })
        else
            Rayfield:Notify({
            Title = "Robot Claw Failed",
            Content = "Failed to start minigame.",
            Duration = 2.5,
            Image = "bell-ring",
            })
        end
    else
        Rayfield:Notify({
            Title = "Robot Claw Failed",
            Content = "You dont have World 2 Unlocked.",
            Duration = 2.5,
            Image = "bell-ring",
            })
        end
   end,
})

local Tab = Window:CreateTab("Teleports", "user")

local Section = Tab:CreateSection("World 1")

local Button = Tab:CreateButton({
   Name = "Spawn",
   Callback = function()
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.PortalSpawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
   end,
})

local Section = Tab:CreateSection("Islands")

local Button = Tab:CreateButton({
   Name = "Floating Island",
   Callback = function()
       local data = LocalData:Get()
    local FloatingIsland = data.AreasUnlocked and data.AreasUnlocked["Floating Island"]

    if FloatingIsland then
        local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
       local FloatingIslandPos = CFrame.new(1, 423, 132)

local FloatingIslandtween = TweenService:Create(HRP, tweenInfo, {CFrame = FloatingIslandPos})
FloatingIslandtween:Play() 
task.wait(3.3)
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
   end,
})

local Button = Tab:CreateButton({
   Name = "Outer Space",
   Callback = function()
       local data = LocalData:Get()
    local OuterSpace = data.AreasUnlocked and data.AreasUnlocked["Outer Space"]

    if OuterSpace then
        local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
       local OuterSpacePos = CFrame.new(18, 2663, -5)

local OuterSpacetween = TweenService:Create(HRP, tweenInfo, {CFrame = OuterSpacePos})
OuterSpacetween:Play()
       task.wait(3.3)
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Outer Space.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
   end,
})

local Button = Tab:CreateButton({
   Name = "Twilight",
   Callback = function()
       local data = LocalData:Get()
    local Twilight = data.AreasUnlocked and data.AreasUnlocked["Twilight"]

    if Twilight then
        local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
       local TwilightPos = CFrame.new(-71, 6862, 89)

local Twilighttween = TweenService:Create(HRP, tweenInfo, {CFrame = TwilightPos})
Twilighttween:Play()
       task.wait(3.3)
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
   end,
})

local Button = Tab:CreateButton({
   Name = "The Void",
   Callback = function()
       local data = LocalData:Get()
    local TheVoid = data.AreasUnlocked and data.AreasUnlocked["The Void"]

    if TheVoid then
        local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
       local VoidPos = CFrame.new(16, 10146, 152)

local Voidtween = TweenService:Create(HRP, tweenInfo, {CFrame = VoidPos})
Voidtween:Play()
       task.wait(3.3)
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.The Void.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
  end,
})

local Button = Tab:CreateButton({
   Name = "Zen",
   Callback = function()
       local data = LocalData:Get()
    local Zen = data.AreasUnlocked and data.AreasUnlocked["Zen"]

    if Zen then
        local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
       local ZenPos = CFrame.new(36, 15972, 42)

local Zentween = TweenService:Create(HRP, tweenInfo, {CFrame = ZenPos})
Zentween:Play()
       task.wait(3.3)
       local args = {
    [1] = "Teleport",
    [2] = "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
  end,
})

local Section = Tab:CreateSection("World 2")

local Button = Tab:CreateButton({
   Name = "Spawn",
   Callback = function()
local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
       local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.PortalSpawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
Rayfield:Notify({
   Title = "Teleportation Failed!",
   Content = "You need World 2 Unlocked for this teleport.",
   Duration = 1.5,
   Image = "bell-ring",
       })
end
   end,
})

local Section = Tab:CreateSection("Islands")

local Button = Tab:CreateButton({
   Name = "Dice Island",
   Callback = function()
       local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
    local DiceIsland = data.AreasUnlocked and data.AreasUnlocked["Dice Island"]

    if DiceIsland then
        local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.Islands.Dice Island.Island.Portal.Spawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
    local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.PortalSpawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
task.wait(0.1)
       local DiceIslandPos = CFrame.new(9888, 2908, 198)

local DiceIslandtween = TweenService:Create(HRP, tweenInfo, {CFrame = DiceIslandPos})
DiceIslandtween:Play()
       task.wait(3.3)
       local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.PortalSpawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
else
Rayfield:Notify({
   Title = "Teleportation Failed!",
   Content = "You need World 2 Unlocked for this teleport.",
   Duration = 1.5,
   Image = "bell-ring",
       })
end
  end,
})

local Button = Tab:CreateButton({
   Name = "Minecart Forest",
   Callback = function()
       local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
    local MinecartForest = data.AreasUnlocked and data.AreasUnlocked["Minecart Forest"]

    if MinecartForest then
        local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.Islands.Minecart Forest.Island.Portal.Spawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
    local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.PortalSpawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
       local MinecartForestPos = CFrame.new(9887, 7682, 213)

local MinecartForesttween = TweenService:Create(HRP, tweenInfo, {CFrame = MinecartForestPos})
MinecartForesttween:Play()
       task.wait(3.3)
       local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.Islands.Minecart Forest.Island.Portal.Spawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
else
Rayfield:Notify({
   Title = "Teleportation Failed!",
   Content = "You need World 2 Unlocked for this teleport.",
   Duration = 1.5,
   Image = "bell-ring",
       })
end
  end,
})

local Button = Tab:CreateButton({
   Name = "Robot Factory",
   Callback = function()
       local data = LocalData:Get()
local MinigameParadise = data.WorldsUnlocked and data.WorldsUnlocked["Minigame Paradise"]
if MinigameParadise then
    local RobotFactory = data.AreasUnlocked and data.AreasUnlocked["Robot Factory"]

    if RobotFactory then
        local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.Islands.Robot Factory.Island.Portal.Spawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
    local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.PortalSpawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
       local RobotFactoryPos = CFrame.new(9888, 13410, 241)

local RobotFactorytween = TweenService:Create(HRP, tweenInfo, {CFrame = RobotFactoryPos})
RobotFactorytween:Play()
       task.wait(3.3)
       local args = {
	"Teleport",
	"Workspace.Worlds.Minigame Paradise.Islands.Robot Factory.Island.Portal.Spawn"
}
ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end
else
Rayfield:Notify({
   Title = "Teleportation Failed!",
   Content = "You need World 2 Unlocked for this teleport.",
   Duration = 1.5,
   Image = "bell-ring",
       })
end
  end,
})

local Tab = Window:CreateTab("Misc", "circle-ellipsis")

local Section = Tab:CreateSection("Character")

local JPSlider = Tab:CreateSlider({
   Name = "JumpPower",
   Range = {0, 1000},
   Increment = 10,
   Suffix = "JumpPower",
   CurrentValue = DefaultJP,
   Flag = "JumpPowerSlider", 
   Callback = function(Value)
       if Value ~= DefaultJP then
            JPUpdate = false
            CustomJP = true
            if Humanoid.JumpPower ~= Value then
                Humanoid.JumpPower = Value
            end
        end
    end,
})

task.spawn(function()
    while true do
        task.wait(0.2)
        if JPUpdate and not CustomJP then
            DefaultJP = Humanoid.JumpPower
            JPSlider:Set(DefaultJP)
        end
    end
end)
    
local Button = Tab:CreateButton({
    Name = "Reset JumpPower",
    Callback = function()
        CustomJP = false
        JPUpdate = true

        Humanoid.JumpPower = DefaultJP
        JPSlider:Set(DefaultJP)
    end,
})

local Section = Tab:CreateSection("Automation")

local AutoMysteryBoxToggle = Tab:CreateToggle({
   Name = "Auto Claim Mystery Box",
   CurrentValue = false,
   Flag = "MysteryBoxToggle", 
   Callback = function(Value)
       AutoMysteryBox = Value
       
       if Value then
           Rayfield:Notify({
               Title = "Auto Mystery Box On",
               Content = "Automatically claiming mystery boxes.",
               Duration = 2,
               Image = "bell-ring",
           })  

repeat
               repeat task.wait() until LocalData.IsReady()

               local data = LocalData:Get()
               local count = data.Powerups and data.Powerups["Mystery Box"] or 0

               if count == 0 then
                   if not didFinalRun then
                       local args = {"UseGift", "Mystery Box", 1}
                       ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

                       for _, gift in ipairs(giftsFolder:GetChildren()) do
                           if gift:IsA("Model") or gift:IsA("Part") then
                               local giftId = gift.Name 
                               ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer("ClaimGift", giftId)
                               task.wait()
                               if gift and gift.Parent then
                                   gift:Destroy()
                               end
                           end
                       end

                       didFinalRun = true
                   end

                   task.wait(1)
               else
                   didFinalRun = false
                   local args = {"UseGift", "Mystery Box", 1}
                   ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

                   for _, gift in ipairs(giftsFolder:GetChildren()) do
                       if gift:IsA("Model") or gift:IsA("Part") then
                           local giftId = gift.Name 
                           ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer("ClaimGift", giftId)
                           task.wait()
                           if gift and gift.Parent then
                               gift:Destroy()
                           end
                       end
                   end

                   didFinalRun = false
                   task.wait()
               end

until not AutoMysteryBox

               Rayfield:Notify({
                   Title = "Auto Mystery Box Off",
                   Content = "",
                   Duration = 2,
                   Image = "bell-ring",
               })      
               AutoMysteryBox = false
               didFinalRun = false
end
   end,
})

local AutoEquipBestToggle = Tab:CreateToggle({
   Name = "Auto Equip Best",
   CurrentValue = false,
   Flag = "AutoEquipBestPets",
   Callback = function(Value)
       EquippingBest = Value
       
       if Value then
Rayfield:Notify({
   Title = "Auto Equip Best On",
   Content = "Automaticaly equiping your best pets.",
   Duration = 2,
   Image = "bell-ring",
})

repeat
               task.wait(2.5)
local args = {
    [1] = "EquipBestPets"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))

until not EquippingBest

Rayfield:Notify({
   Title = "Auto Equip Best Off",
   Content = "Stopped equipping best pets.",
   Duration = 2,
   Image = "bell-ring",
})
end
   end,
})

local Section = Tab:CreateSection("Other")

local Button = Tab:CreateButton({
   Name = "Craft Shiny Pets",
   Callback = function()
       for _, v in next, data.Pets do
           local petCount = require(ReplicatedStorage.Shared.Utils.ShinyUtil):GetOwnedCount(data, v)
           if petCount > 10 then
               ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer("MakePetShiny", v.Id)
               task.wait(5)
    end
end
   end,
})

local Button = Tab:CreateButton({
   Name = "Claim Legendary Pet",
   Callback = function()
Rayfield:Notify({
   Title = "Legendary Pet PopUp Opened",
   Content = "Pet redeemed (1 time use per account).",
   Duration = 3.5,
   Image = "bell-ring",
})     
local args = {
    [1] = "FreeNotifyLegendary"
}

ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
   end,
})

local Button = Tab:CreateButton({
   Name = "Redeem All Codes",
   Callback = function()
       for code in next, Codes do
           require(ReplicatedStorage.Shared.Framework.Network.Remote):InvokeServer("RedeemCode", code)
           Rayfield:Notify({
   Title = "Redeemed Code: " .. code,
   Content = "",
   Duration = 3.5,
   Image = "bell-ring",
})
end
Rayfield:Notify({
   Title = "Redeemed Codes",
   Content = "All the codes have been redeemed",
   Duration = 4.5,
   Image = "bell-ring",
})
   end,
})

local Section = Tab:CreateSection("Visual")

local RiftTrackerToggle = Tab:CreateToggle({
   Name = "Rift Tracker",
   CurrentValue = false,
   Flag = "RiftTrackerToggle", 
   Callback = function(Value)
       if Value then
           RiftTrackerVisibility = true
           if RiftTrackerVisibility then
               MainFrame.Visible = true
               MainFrameScroll.CanvasPosition = Vector2.new(0, 0)  
               MainFrame.Position = UDim2.new(1, -260, 1, -310)
           end
           elseif not Value then
               if RiftTrackerVisibility then
                   MainFrame.Visible = false
                   RiftTrackerVisibility = false
               end
           end
   end,
})

local Section = Tab:CreateSection("Rift Notifier")

local function formatName(name)
    return name:gsub("%-", " "):gsub("(%l)(%w*)", function(a, b)
        return a:upper() .. b:lower()
    end)
end

local RiftNotifySelectedOptions = {}
local MultiplierNotifySelectedOptions = {}
local RiftNotifying = false
local NotifiedRifts = {}

local function isValidSelection()
    return #RiftNotifySelectedOptions > 0 and #MultiplierNotifySelectedOptions > 0
end

local function checkRiftsAndNotify()
    while RiftNotifying do
        task.wait(1)

        for _, rift in ipairs(workspace:WaitForChild("Rendered"):WaitForChild("Rifts"):GetChildren()) do
            if NotifiedRifts[rift] then continue end

            local eggName = formatName(rift.Name)
            local multiplier = "None"

local display = rift:FindFirstChild("Display")
if display then
    local surfaceGui = display:FindFirstChild("SurfaceGui")
    if surfaceGui then
        local iconLuck = surfaceGui:FindFirstChild("Icon") and surfaceGui.Icon:FindFirstChild("Luck")
        if iconLuck and iconLuck.Text ~= "" then
            multiplier = iconLuck.Text
        else
            local iconMultiply = surfaceGui:FindFirstChild("Items") and surfaceGui.Items:FindFirstChild("Coin") and surfaceGui.Items.Coin:FindFirstChild("Icon") and surfaceGui.Items.Coin.Icon:FindFirstChild("Label")
            if iconMultiply and iconMultiply.Text ~= "" then
                multiplier = iconMultiply.Text
            else
                multiplier = "No Multiplier"
            end
        end
    end
end

            local riftMatch = table.find(RiftNotifySelectedOptions, eggName)
            local multiMatch = MultiplierNotifySelectedOptions[1] == "All Multipliers"
                or (multiplier ~= "None" and table.find(MultiplierNotifySelectedOptions, multiplier))

            if riftMatch and multiMatch then
                NotifiedRifts[rift] = true
                if DeviceUser == "PC" then
                Rayfield:Notify({
                    Title = "Rift Notification",
                    Content = eggName .. " with multiplier of " .. multiplier,
                    Duration = 15,
                    Image = "bell-ring",
                })
            else
                Rayfield:Notify({
                    Title = "Rift Notification",
                    Content = eggName .. " with multiplier of " .. multiplier,
                    Duration = 10,
                    Image = "bell-ring",
                })
                end
            end
        end
    end
end

local function startRiftNotifications()
    if not isValidSelection() then
        Rayfield:Notify({
            Title = "Rift Notification",
            Content = "Please select at least one option for both Rifts and Multiplier then turn this toggle off and on again.",
            Duration = 3.5,
            Image = "bell-ring",
        })
    ErrorToggle:Set(false)
        return
    end

    if not RiftNotifying then
        RiftNotifying = true
        Rayfield:Notify({
            Title = "Rift Notification Enabled",
            Content = "You will now recieve rift notifications based on your modifications.",
            Duration = 3.5,
            Image = "bell-ring",
        })
    task.wait(1)
        NotifiedRifts = {} 
        task.spawn(checkRiftsAndNotify)
    end
end

local function stopRiftNotifications()
    if RiftNotifying then
        RiftNotifying = false
        Rayfield:Notify({
            Title = "Rift Notification Disabled",
            Content = "You will no longer receive notifications.",
            Duration = 3.5,
            Image = "bell-ring",
        })
    end
end

local NotifyRiftDropdown = Tab:CreateDropdown({
    Name = "Select Rifts",
    Options = {"Spikey Egg", "Magma Egg", "Crystal Egg", "Lunar Egg", "Void Egg", "Hell Egg", "Nightmare Egg", "Rainbow Egg", "Mining Egg", "Cyber Egg", "Game Egg", "Underworld 0", "Underworld 1", "Underworld 2", "Underworld 3", "Silly Egg", "Dice Chest", "Bubble Rift", "Golden Chest", "Gift Rift"},
    CurrentOption = RiftNotifySelectedOptions,
    MultipleOptions = true,
    Flag = "RiftNotifySelectDropdown",
    Callback = function(Options)
        RiftNotifySelectedOptions = type(Options) == "table" and Options or {Options}
    end,
})

local NotifyMultiplierDropdown = Tab:CreateDropdown({
    Name = "Select Rift Multiplier",
    Options = {"No Multiplier", "x5", "x10", "x25", "x250", "All Multipliers"},
    CurrentOption = MultiplierNotifySelectedOptions,
    MultipleOptions = true,
    Flag = "MultiplierNotifySelectDropdown",
    Callback = function(Options)
        MultiplierNotifySelectedOptions = type(Options) == "table" and Options or {Options}
    end,
})

local NotifyRiftToggle = Tab:CreateToggle({
    Name = "Notify Rifts",
    CurrentValue = false,
    Flag = "NotifyRiftsToggle",
    Callback = function(Value)
        if Value then
            startRiftNotifications()
        else
            stopRiftNotifications()
        end
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

local Button = Tab:CreateButton({
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

local Button = Tab:CreateButton({
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
                Title = "Peteware on Rejoin / Server Hop On",
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
                Title = "Peteware on Rejoin / Server Hop Off",
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
elseif not Value then
    if RayfieldOptimisation then
Rayfield:Notify({
   Title = "Stopped Rayfield Optimisation",
   Content = "",
   Duration = 2,
   Image = "bell-ring",
})  
    RayfieldOptimisation = false
    end
    end
   end,
})

local Button = Tab:CreateButton({
   Name = "Open Console",
   Callback = function()
       StarterGui:SetCore("DevConsoleVisible", true)
   end,
})

local confirmDestroy = false

local Button = Tab:CreateButton({
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
             KeepPeteware = false
             if teleportConnection then
                teleportConnection:Disconnect()
             end
             task.wait()
             BubbleBlowing = false
             task.wait()
             Selling = false
             task.wait()
             FlavorBuying = false
             task.wait()
             StorageBuying = false
             task.wait()
             ClaimingWheelSpin = false
             task.wait()
             WheelSpinning = false
             task.wait()
             PlaytimeRewarding = false
             task.wait()
             DoggyJumpRewards = false
             task.wait()
             EquippingBest = false
             task.wait()
             CoinsAutofarming = false
             setNoclip(false)
             AutoSeasonClaim = false
             task.wait()
             AutoCollectingPickups = false
             task.wait()
             AutoMysteryBox = false
             task.wait()
             CustomJP = false
             JPUpdate = false
             Humanoid.JumpPower = DefaultJP
             task.wait()
             RayfieldOptimisation = false
             PetewareOverlay.Hide()
             task.wait(1)
             _G.Execution = false
            Rayfield:Destroy()
        end
    end,
})