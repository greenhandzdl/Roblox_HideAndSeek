local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local particleEncounterEvent = ReplicatedStorage:FindFirstChild("ParticleEncounter")
if not particleEncounterEvent then
	particleEncounterEvent = Instance.new("RemoteEvent")
	particleEncounterEvent.Name = "ParticleEncounter"
	particleEncounterEvent.Parent = ReplicatedStorage
end

local toolName = "伪装"

particleEncounterEvent.OnServerEvent:Connect(function(player, particlePart)
	print("[调试] 服务器收到ParticleEncounter事件，来自玩家：", player.Name, "粒子部件：", particlePart)
	local character = player.Character
	if not character then
		print("[调试] 玩家没有角色，忽略")
		return
	end
	local hasTool = false
	for _, obj in ipairs(character:GetChildren()) do
		if obj:IsA("Tool") and obj.Name == toolName then
			hasTool = true
			break
		end
	end
	print("[调试] 玩家", player.Name, hasTool and "已装备伪装" or "未装备伪装")
	if not hasTool then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			print("[调试] 玩家未装备伪装，执行死亡")
			humanoid.Health = 0
		end
	end
end) 