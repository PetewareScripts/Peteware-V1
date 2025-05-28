--[[
PLEASE READ - IMPORTANT

© 2025 Peteware
This project is part of Developers-Toolbox-Peteware, an open-source Roblox toolbox for developing scripts.

Licensed under the MIT License.  
See the full license at:  
https://github.com/PetewareScripts/Developers-Toolbox-Peteware/blob/main/LICENSE

**Attribution required:** You must give proper credit to Peteware when using or redistributing this project or its derivatives.

This software is provided "AS IS" without warranties of any kind.  
Violations of license terms may result in legal action.

Thank you for respecting the license and supporting open source software!

Peteware Development Team
]]

--// Services & Setup
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

--// UI Optimise
local oldGui = coreGui:FindFirstChild("PetewareAdvertiseUI")
if oldGui then
	oldGui:Destroy()
end

--// Main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetewareAdvertiseUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = coreGui

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

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 280, 0, 90)
container.Position = UDim2.new(0, 20, 1, -120)
container.BackgroundColor3 = theme.elementBackground
container.Parent = screenGui

local containerCorner = Instance.new("UICorner", container)
containerCorner.CornerRadius = UDim.new(0, 14)

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

local advertiseCorner = Instance.new("UICorner", advertiseButton)
advertiseCorner.CornerRadius = UDim.new(0, 12)

local advertiseShadow = Instance.new("Frame")
advertiseShadow.Size = UDim2.new(1, 6, 1, 6)
advertiseShadow.Position = UDim2.new(0, -3, 0, -3)
advertiseShadow.BackgroundColor3 = Color3.new(0, 0, 0)
advertiseShadow.BackgroundTransparency = 0.75
advertiseShadow.ZIndex = 0
advertiseShadow.Parent = advertiseButton

local advertiseShadowCorner = Instance.new("UICorner", advertiseShadow)
advertiseShadowCorner.CornerRadius = UDim.new(0, 12)

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

local closeCorner = Instance.new("UICorner", closeButton)
closeCorner.CornerRadius = UDim.new(0, 12)

local dragging, dragInput, dragStart, startPos

function EnableDrag(frame)
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
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

EnableDrag(container)

local hoverTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickTweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local closeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

advertiseButton.MouseEnter:Connect(function()
	tweenService:Create(advertiseButton, hoverTweenInfo, {
		BackgroundColor3 = theme.tabBackgroundSelected,
		TextColor3 = Color3.new(0, 0, 0),
		Size = UDim2.new(0.75, -5, 0, 56),
		Position = UDim2.new(0, 5, 0, 33)
	}):Play()
	tweenService:Create(advertiseShadow, hoverTweenInfo, {BackgroundTransparency = 0.5}):Play()
end)

advertiseButton.MouseLeave:Connect(function()
	tweenService:Create(advertiseButton, hoverTweenInfo, {
		BackgroundColor3 = theme.topbar,
		TextColor3 = theme.textColor,
		Size = UDim2.new(0.75, -5, 0, 50),
		Position = UDim2.new(0, 5, 0, 36)
	}):Play()
	tweenService:Create(advertiseShadow, hoverTweenInfo, {BackgroundTransparency = 0.75}):Play()
end)

advertiseButton.MouseButton1Down:Connect(function()
	tweenService:Create(advertiseButton, clickTweenInfo, {
		Size = UDim2.new(0.75, -5, 0, 46),
		Position = UDim2.new(0, 5, 0, 41)
	}):Play()
end)

advertiseButton.MouseButton1Up:Connect(function()
	tweenService:Create(advertiseButton, clickTweenInfo, {
		Size = UDim2.new(0.75, -5, 0, 56),
		Position = UDim2.new(0, 5, 0, 33)
	}):Play()
end)

local announcement = Instance.new("Frame")
announcement.Size = UDim2.new(0, 500, 0, 60)
announcement.Position = UDim2.new(0.5, -250, 0.25, 0)
announcement.BackgroundColor3 = theme.tabBackgroundSelected
announcement.Visible = false
announcement.Parent = screenGui

local announcementCorner = Instance.new("UICorner", announcement)
announcementCorner.CornerRadius = UDim.new(0, 12)

local announcementText = Instance.new("TextLabel")
announcementText.Size = UDim2.new(1, 0, 1, 0)
announcementText.Position = UDim2.new(0, 0, 0, 0)
announcementText.BackgroundTransparency = 1
announcementText.TextColor3 = theme.textColor
announcementText.Font = Enum.Font.GothamBold
announcementText.TextSize = 22
announcementText.TextWrapped = true
announcementText.Text = ""
announcementText.Parent = announcement

local function CloseWithAnimation()
	advertiseButton.Active = false
	closeButton.Active = false

	local tween = tweenService:Create(container, closeTweenInfo, {
		Size = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(container.Position.X.Scale, container.Position.X.Offset + 140, container.Position.Y.Scale, container.Position.Y.Offset + 45)
	})
	for _, child in pairs(screenGui:GetChildren()) do
		if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") then
			tweenService:Create(child, closeTweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
		end
	end

	tween:Play()
	tween.Completed:Connect(function()
		screenGui:Destroy()
	end)
end

--// Button Handlers
closeButton.MouseButton1Click:Connect(CloseWithAnimation)

advertiseButton.MouseButton1Click:Connect(function()
	announcementText.Text = "📢 Thank you for advertising Peteware!"
	announcement.Visible = true
	wait(2)
	announcement.Visible = false
end)
