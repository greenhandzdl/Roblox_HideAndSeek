local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local particleEncounterEvent = ReplicatedStorage:WaitForChild("ParticleEncounter")

local lastHit = 0
local HIT_COOLDOWN = 1

local function isInParticleCone(part, target, radius, angle)
	if not part then return false end
	local dir = part.CFrame.LookVector
	local toPlayer = (target.Position - part.Position)
	local dist = toPlayer.Magnitude
	local cosTheta = dir:Dot(toPlayer.Unit)
	local theta = math.deg(math.acos(cosTheta))
	if dist > radius then return false end
	return theta < (angle / 2)
end

local function RaycastCheck(origin, target, ignoreList)
	ignoreList = ignoreList or {}
	local direction = target - origin
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = ignoreList
	local result = workspace:Raycast(origin, direction, raycastParams)
	if result then
		return false -- 有物体阻挡
	else
		return true -- 没有物体阻挡
	end
end

local function Start(EmitterRegistry)
	RunService.RenderStepped:Connect(function()
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
		local hrp = player.Character.HumanoidRootPart
		for name, emitterConfig in pairs(EmitterRegistry.GetEmitters()) do
			local particlePart = emitterConfig.part
			if particlePart and isInParticleCone(particlePart, hrp, emitterConfig.radius, emitterConfig.angle)
				and RaycastCheck(particlePart, hrp, nil) then
				if tick() - lastHit > HIT_COOLDOWN then
					particleEncounterEvent:FireServer(particlePart)
					lastHit = tick()
				end
				break
			end
		end
	end)
end

return {
	Start = Start
} 