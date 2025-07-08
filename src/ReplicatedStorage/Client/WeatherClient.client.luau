--- WeatherClient.client.luau
-- 动态天气系统（客户端表现）
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeatherEvent = ReplicatedStorage:WaitForChild("WeatherEvent")

local function applyWeather(state)
	if state == "Sunny" then
		-- TODO: 切换为晴天表现
		print("[WeatherClient] 晴天")
	elseif state == "Rainy" then
		-- TODO: 切换为雨天表现
		print("[WeatherClient] 雨天")
	elseif state == "Foggy" then
		-- TODO: 切换为雾天表现
		print("[WeatherClient] 雾天")
	end
end

WeatherEvent.OnClientEvent:Connect(applyWeather) 