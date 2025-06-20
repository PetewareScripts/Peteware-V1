if keyUI then
    for _, obj in ipairs(keyUI:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            tweenService:Create(obj, TweenInfo.new(0.4), {
                TextTransparency = 1
            }):Play()
        elseif obj:IsA("Frame") then
            tweenService:Create(obj, TweenInfo.new(0.4), {
                BackgroundTransparency = 1
            }):Play()
        elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            tweenService:Create(obj, TweenInfo.new(0.4), {
                ImageTransparency = 1
            }):Play()
        end
    end

    task.delay(0.45, function()
        keyUI:Destroy()
    end)
end
loadstring(game:HttpGet('https://raw.githubusercontent.com/skxller1/Test/refs/heads/main/Growagarden'))()
