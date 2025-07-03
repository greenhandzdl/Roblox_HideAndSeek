local EmitterRegistry = require(script.Parent.EmitterRegistryModule)
local ParticleHitCheck = require(script.Parent.ParticleHitCheckModule)

local Main = {}

function Main.Start()
	EmitterRegistry.Init()
	ParticleHitCheck.Start(EmitterRegistry)
end

return Main 