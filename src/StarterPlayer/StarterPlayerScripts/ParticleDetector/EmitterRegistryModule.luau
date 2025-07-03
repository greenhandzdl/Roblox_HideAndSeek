local ReplicatedStorage = game:GetService("ReplicatedStorage")
local emitterEvent = ReplicatedStorage:WaitForChild("EmitterEvent")
local PartFinder = require(script.Parent.PartFinderModule)

local registeredEmitters = {}

local function Init()
	emitterEvent.OnClientEvent:Connect(function(action, data)
		if action == "register" then
			data.part = PartFinder.GetPartByName(data)
			registeredEmitters[data.name] = data
		elseif action == "unregister" then
			registeredEmitters[data] = nil
		end
	end)
end

local function GetEmitters()
	return registeredEmitters
end

return {
	Init = Init,
	GetEmitters = GetEmitters
} 