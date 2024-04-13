local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Lib.Matter)

return {
	Test = Matter.event("Test"),
}
