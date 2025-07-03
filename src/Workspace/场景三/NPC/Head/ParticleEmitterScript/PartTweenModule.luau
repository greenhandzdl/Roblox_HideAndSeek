local TweenService = game:GetService("TweenService")

local runningTweens = {}

local function StartTween(part)
	if runningTweens[part] then return end
	runningTweens[part] = true
	task.spawn(function()
		while runningTweens[part] do
			local delta = math.rad(math.random(-10, 10))
			local currentCFrame = part.CFrame
			local pos = currentCFrame.Position
			local _, y, _ = currentCFrame:ToOrientation()
			local newCFrame = CFrame.new(pos) * CFrame.Angles(0, y + delta, 0)
			local tween = TweenService:Create(part, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = newCFrame})
			tween:Play()
			tween.Completed:Wait()
			task.wait(0.2)
		end
	end)
end

local function StopTween(part)
	runningTweens[part] = nil
end

return {
	StartTween = StartTween,
	StopTween = StopTween
} 