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

--// UI Cleanup
local oldGui = coreGui:FindFirstChild("PetewareAdvertiseUI")
if oldGui then oldGui:Destroy() end

--// Services & Setup
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local textChatService = game:GetService("TextChatService")

--// Theme
local theme = {
	textColor = Color3.fromRGB(235, 235, 235),
	background = Color3.fromRGB(18, 18, 18),
	topbar = Color3.fromRGB(28, 28, 30),
	notificationBackground = Color3.fromRGB(24, 24, 24),
	notificationActionsBackground = Color3.fromRGB(50, 50, 50),
	elementBackground = Color3.fromRGB(28, 28, 28),
	elementBackgroundHover = Color3.fromRGB(38, 38, 38),
	tabBackgroundSelected = Color3.fromRGB(255, 140, 0)
}

--// Main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetewareAdvertiseUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = coreGui

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 280, 0, 90)
container.Position = UDim2.new(0, 20, 1, -120)
container.BackgroundColor3 = theme.elementBackground
container.Parent = screenGui
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 14)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 24)
titleLabel.Position = UDim2.new(0, 10, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Peteware Advertising"
titleLabel.TextColor3 = theme.textColor
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = container

local advertiseButton = Instance.new("TextButton")
advertiseButton.Size = UDim2.new(0.75, -5, 0, 50)
advertiseButton.Position = UDim2.new(0, 5, 0, 36)
advertiseButton.Text = "Advertise"
advertiseButton.TextColor3 = theme.textColor
advertiseButton.Font = Enum.Font.GothamBold
advertiseButton.TextSize = 22
advertiseButton.BackgroundColor3 = theme.topbar
advertiseButton.AutoButtonColor = false
advertiseButton.Parent = container
advertiseButton.ClipsDescendants = true
Instance.new("UICorner", advertiseButton).CornerRadius = UDim.new(0, 12)

local advertiseShadow = Instance.new("Frame")
advertiseShadow.Size = UDim2.new(1, 6, 1, 6)
advertiseShadow.Position = UDim2.new(0, -3, 0, -3)
advertiseShadow.BackgroundColor3 = Color3.new(0, 0, 0)
advertiseShadow.BackgroundTransparency = 0.75
advertiseShadow.ZIndex = 0
advertiseShadow.Parent = advertiseButton
Instance.new("UICorner", advertiseShadow).CornerRadius = UDim.new(0, 12)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.25, -10, 0, 50)
closeButton.Position = UDim2.new(0.75, 5, 0, 36)
closeButton.Text = "X"
closeButton.TextColor3 = theme.textColor
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 22
closeButton.BackgroundColor3 = theme.notificationActionsBackground
closeButton.AutoButtonColor = false
closeButton.Parent = container
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 12)

local hoverTween = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickTween = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function AnimateHover(button, enter)
	local targetProps = enter and {
		BackgroundColor3 = theme.tabBackgroundSelected,
		TextColor3 = Color3.new(0, 0, 0),
		Size = UDim2.new(button == closeButton and 0.25 or 0.75, -10, 0, 56),
		Position = UDim2.new(button == closeButton and 0.75 or 0, 5, 0, 33)
	} or {
		BackgroundColor3 = button == closeButton and theme.notificationActionsBackground or theme.topbar,
		TextColor3 = theme.textColor,
		Size = UDim2.new(button == closeButton and 0.25 or 0.75, -10, 0, 50),
		Position = UDim2.new(button == closeButton and 0.75 or 0, 5, 0, 36)
	}
	tweenService:Create(button, hoverTween, targetProps):Play()
end

local function AnimateClick(button, down)
	tweenService:Create(button, clickTween, {
		Size = UDim2.new(button == closeButton and 0.25 or 0.75, -10, 0, down and 46 or 56),
		Position = UDim2.new(button == closeButton and 0.75 or 0, 5, 0, down and 41 or 33)
	}):Play()
end

-- Hover + click binds
for _, button in ipairs({advertiseButton, closeButton}) do
	button.MouseEnter:Connect(function() AnimateHover(button, true) end)
	button.MouseLeave:Connect(function() AnimateHover(button, false) end)
	button.MouseButton1Down:Connect(function() AnimateClick(button, true) end)
	button.MouseButton1Up:Connect(function() AnimateClick(button, false) end)
end

advertiseButton.MouseEnter:Connect(function()
	tweenService:Create(advertiseShadow, hoverTween, {BackgroundTransparency = 0.5}):Play()
end)
advertiseButton.MouseLeave:Connect(function()
	tweenService:Create(advertiseShadow, hoverTween, {BackgroundTransparency = 0.75}):Play()
end)

-- Announcement
local announcement = Instance.new("Frame")
announcement.Size = UDim2.new(0, 500, 0, 60)
announcement.Position = UDim2.new(0.5, -250, 0.25, 0)
announcement.BackgroundColor3 = theme.tabBackgroundSelected
announcement.Visible = false
announcement.BackgroundTransparency = 1
announcement.Parent = screenGui
Instance.new("UICorner", announcement).CornerRadius = UDim.new(0, 12)

local announcementText = Instance.new("TextLabel")
announcementText.Size = UDim2.new(1, 0, 1, 0)
announcementText.BackgroundTransparency = 1
announcementText.TextColor3 = theme.textColor
announcementText.Font = Enum.Font.GothamBold
announcementText.TextSize = 22
announcementText.TextWrapped = true
announcementText.Text = ""
announcementText.TextTransparency = 1
announcementText.Parent = announcement

function ShowAnnouncement(text)
	announcementText.Text = text
	announcement.Visible = true
	tweenService:Create(announcement, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
	tweenService:Create(announcementText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

	task.delay(2, function()
		tweenService:Create(announcement, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		tweenService:Create(announcementText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		task.wait(0.4)
		announcement.Visible = false
	end)
end

function CloseWithAnimation()
	advertiseButton.Active = false
	closeButton.Active = false

	tweenService:Create(container, TweenInfo.new(0.4), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(container.Position.X.Scale, container.Position.X.Offset + 140, container.Position.Y.Scale, container.Position.Y.Offset + 45),
		BackgroundTransparency = 1
	}):Play()

	for _, child in ipairs(container:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") then
			pcall(function()
				tweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
			end)
		end
	end

	task.delay(0.45, function()
		screenGui:Destroy()
	end)
end

-- Button Handlers
advertiseButton.MouseButton1Click:Connect(function()
	ShowAnnouncement("📢 Thank you for advertising Peteware!")
	local generalChannel = textChatService:FindFirstChild("TextChannels") and textChatService.TextChannels:FindFirstChild("RBXGeneral")
	if generalChannel and generalChannel:IsA("TextChannel") then
		generalChannel:SendAsync("FOR OP SCRIPTS JOIN PETEWARE: discorn/4UjSNcPCdh")
	end
end)

closeButton.MouseButton1Click:Connect(CloseWithAnimation)

function EnableDrag(frame)
	local dragging, dragInput, dragStart, startPos

	local function Update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	userInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			Update(input)
		end
	end)
end

EnableDrag(container)
