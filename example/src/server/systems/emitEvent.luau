local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Lib.Matter)
local events = require(ReplicatedStorage.Shared.events)

local changes, disconnect = events.Test:listen()
local function system(world)
	events.Test:emit({ number = 3 })
	for event in changes do
		print(event) -- { number = 3 }
	end
end

return system
