local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function Setup(part)
	local emitter = part:FindFirstChildOfClass("ParticleEmitter")
	if not emitter then
		emitter = Instance.new("ParticleEmitter")
		emitter.Parent = part
	end
	emitter.Texture = "rbxassetid://115851646282727"
	emitter.Lifetime = NumberRange.new(3, 5)
	emitter.Speed = NumberRange.new(12, 16)
	emitter.Rate = 60
	emitter.EmissionDirection = Enum.NormalId.Front
	emitter.SpreadAngle = Vector2.new(45, 15)
	emitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 2),
		NumberSequenceKeypoint.new(1, 0.2)
	})
	emitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 0.8)
	})
	emitter.LightEmission = 0.7
	emitter.Color = ColorSequence.new(Color3.new(0.949462, 0.692149, 0.655085))
	emitter.Enabled = true

	local maxSpeed = emitter.Speed.Max
	local maxLifetime = emitter.Lifetime.Max
	local spreadAngle = emitter.SpreadAngle.X
	local config = {
		name = part.Name,
		parentName = part.Parent.Name,
		radius = maxSpeed * maxLifetime,
		angle = spreadAngle * 2
	}

	local emitterEvent = ReplicatedStorage:FindFirstChild("EmitterEvent") or Instance.new("RemoteEvent", ReplicatedStorage)
	emitterEvent.Name = "EmitterEvent"

	return emitter, config, emitterEvent
end

local function DisableEmitter(part)
	local emitter = part:FindFirstChildOfClass("ParticleEmitter")
	if emitter then
		emitter.Enabled = false
	end
end

return {
	Setup = Setup,
	DisableEmitter = DisableEmitter
} 