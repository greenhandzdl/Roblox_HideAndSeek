-- 不要用FindFirstChild,因为模型可能在此前没有加载出来
-- 仅用与场景三/{NPC}/Head/Script这种格式
local function GetPartByName(data)
	local scene = workspace:WaitForChild("场景三")
	if scene then
		local ParentPart = scene:WaitForChild(data.parentName)
		print(data)
		if ParentPart then
			return ParentPart:WaitForChild(data.name)
		end
	end
	return nil
end

return {
	GetPartByName = GetPartByName
} 