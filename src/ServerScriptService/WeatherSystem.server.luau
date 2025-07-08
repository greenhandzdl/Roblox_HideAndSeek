--- WeatherSystem.server.luau
-- 动态天气系统（服务端权威控制）
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeatherEvent = ReplicatedStorage:FindFirstChild("WeatherEvent") or Instance.new("RemoteEvent", ReplicatedStorage)
WeatherEvent.Name = "WeatherEvent"

local weatherStates = {"Sunny", "Rainy", "Foggy"}
local currentWeather = "Sunny"
local WEATHER_INTERVAL = 300 -- 5分钟

local function setWeather(state)
	currentWeather = state
	WeatherEvent:FireAllClients(state)
	print("[WeatherSystem] 天气切换为：", state)
end

local function randomWeather()
	local idx = math.random(1, #weatherStates)
	return weatherStates[idx]
end

setWeather(currentWeather)

while true do
	task.wait(WEATHER_INTERVAL)
	local newWeather = randomWeather()
	if newWeather ~= currentWeather then
		setWeather(newWeather)
	end
end 