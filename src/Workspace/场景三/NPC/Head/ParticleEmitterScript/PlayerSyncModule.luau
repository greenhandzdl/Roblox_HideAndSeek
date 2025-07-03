local Players = game:GetService("Players")

local function Register(emitterEvent, config, part)
	Players.PlayerAdded:Connect(function(player)
		emitterEvent:FireClient(player, "register", config)
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		emitterEvent:FireClient(player, "register", config)
	end
	part.Destroying:Connect(function()
		emitterEvent:FireAllClients("unregister", config.name)
	end)
end

local function Unregister(emitterEvent, config)
	emitterEvent:FireAllClients("unregister", config.name)
end

return {
	Register = Register,
	Unregister = Unregister
} 