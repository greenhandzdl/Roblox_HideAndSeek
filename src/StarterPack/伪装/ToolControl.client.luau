local tool = script.Parent
local Players = game:GetService("Players")

local cooldown = 8 -- 冷却时间（秒）
local useTime = 5  -- 装备持续时间（秒）
local canEquip = true

-- 工具脱下函数
local function unequipTool()
	local character = tool.Parent
	if character and character:IsA("Model") and character:FindFirstChild("Humanoid") then
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			tool.Parent = player.Backpack
		end
	end
end

-- 工具装备逻辑
local function onEquipped()
	if not canEquip then
		unequipTool()
		return
	end
	canEquip = false
	-- 5秒后自动脱下
	task.delay(useTime, function()
		if tool.Parent and tool.Parent:IsA("Model") and tool.Parent:FindFirstChild("Humanoid") then
			unequipTool()
		end
	end)
	-- 8秒冷却
	task.delay(cooldown, function()
		canEquip = true
	end)
end

tool.Equipped:Connect(onEquipped)

tool.Unequipped:Connect(function()
	-- 可根据需要添加额外逻辑
end)

-- 防止冷却期间被手动装备
if tool.Parent and tool.Parent:IsA("Model") and tool.Parent:FindFirstChild("Humanoid") then
	if not canEquip then
		unequipTool()
	end
end 