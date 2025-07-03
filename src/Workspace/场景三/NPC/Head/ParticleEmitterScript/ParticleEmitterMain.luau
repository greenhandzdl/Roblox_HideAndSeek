local EmitterConfig = require(script.Parent.EmitterConfigModule)
local PlayerSync = require(script.Parent.PlayerSyncModule)
local PartTween = require(script.Parent.PartTweenModule)

local Main = {}

function Main.Start(part)
	local emitter, config, emitterEvent = EmitterConfig.Setup(part)
	local isUnregistered = false

	local function cancelAndStop()
		if not isUnregistered then
			isUnregistered = true
			PlayerSync.Unregister(emitterEvent, config)
			PartTween.StopTween(part)
			EmitterConfig.DisableEmitter(part)
		end
	end

	PlayerSync.Register(emitterEvent, config, part)
	PartTween.StartTween(part)

	-- 新增：监听Humanoid死亡或Health为0
	local npcModel = part.Parent
	local humanoid = npcModel:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Connect(cancelAndStop)
		humanoid.HealthChanged:Connect(function(health)
			if health <= 0 then
				cancelAndStop()
			end
		end)
	end
end

return Main 