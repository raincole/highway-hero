require 'lib/class'

local Timer = class(Entity)

function Timer:__init()
	self._base.__init(self)
	self.time = 0
	self.status = 'stopped'
end

function Timer:registerObservers()
	beholder.observe('timeout', function() self.status = 'stopped' end)
	beholder.observe('hero_go', function() self.status = 'started' end)
end

function Timer:update(dt)
	if self.status == 'started' then
		self.time = self.time + dt * 3 -- for debugging
		if self:remainingTime() < 0 then
			self.time = 10
			beholder.trigger('timeout')
		end
	end
end

function Timer:remainingTime()
	return 10 - self.time
end

return Timer
