local function newEvent(name)
	name = name or debug.info(2, "s") .. "@" .. debug.info(2, "l")

	local event = {}
	event.__index = event

	function event.new()
		return table.freeze(setmetatable({
			_listeners = {},
		}, event))
	end

	function event:emit(data)
		debug.profilebegin("emit")
		for _, listener in self._listeners do
			table.insert(listener.storage, data)
		end

		debug.profileend()
	end

	local lastId = 0
	function event:listen()
		local id = lastId + 1
		lastId = id

		local storage = {}
		table.insert(self._listeners, { id = id, storage = storage })
		return function()
			return table.remove(storage, 1)
		end, function()
			for index, data in self._listeners do
				if data.id == id then
					table.remove(index)
					return
				end
			end
		end
	end

	--[[setmetatable(event, {
		__call = function(_, ...)
			return event.new(...)
		end,
		--[[__tostring = function()
			return name
		end,]]
	--]]

	return event.new()
end

return {
	newEvent = newEvent,
}
