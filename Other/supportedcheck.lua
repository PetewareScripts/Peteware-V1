--//UI Check
if _G.PetewareUI then
    local supportedGames = {
        12339127827,
        2474168535,
        85896571713843
    }
    
    local screenGui = game:GetService("CoreGui"):FindFirstChild("Peteware-V1")
--// Notification
local notification = Instance.new("Frame", screenGui)
notification.Size = UDim2.new(0, 500, 0, 60)
notification.Position = UDim2.new(0.5, -250, 0.25, 0)
notification.BackgroundColor3 = theme.tabBackgroundSelected
notification.Visible = false
notification.BackgroundTransparency = 1
Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 12)

local notificationText = Instance.new("TextLabel", notification)
notificationText.Size = UDim2.new(1, 0, 1, 0)
notificationText.BackgroundTransparency = 1
notificationText.TextColor3 = theme.textColor
notificationText.Font = Enum.Font.GothamBold
notificationText.TextSize = 22
notificationText.TextWrapped = true
notificationText.Text = ""
notificationText.TextTransparency = 1

function ShowNotification(text)
	notificationText.Text = text
	notification.Visible = true
	tweenService:Create(notification, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
	tweenService:Create(notificationText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

	task.delay(2, function()
		tweenService:Create(notification, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		tweenService:Create(notificationText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		task.wait(0.4)
		notification.Visible = false
	end)
   end
--// Supported Check
if game.PlaceId == supportedGames then
    ShowNotification("Supported Game, Loading Peteware-V1")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PetewareScripts/Peteware-V1/refs/heads/main/Loader",true))()
    else
        ShowNotification("Unsupported Game.")
    end
end
