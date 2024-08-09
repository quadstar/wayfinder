_addon.name     = 'wayfinder'
_addon.author   = 'quadstar'
_addon.version  = '1'
_addon.commands = {'wayfinder'}

function getPos()
	me = windower.ffxi.get_mob_by_target('me')
	windower.add_to_chat(55, ''..me.x)
	windower.add_to_chat(55, ''..me.y)
end

function goToPoint(point)
	me = windower.ffxi.get_mob_by_target('me')
	local angle = math.atan2(me.x - point.x, me.y - point.y) + math.pi/2
	windower.ffxi.run(angle)
	repeat
		me = windower.ffxi.get_mob_by_target('me')
		coroutine.sleep(.25)
	until (math.abs(point.x - me.x) < 3) and (math.abs(point.y - me.y) < 3) 
	windower.ffxi.run(false)
end

windower.register_event('addon command', function (...)
    local args = {...};
    if #args < 1 then
        return
    end
    
    if args[1] == 'go' then
    	goToPoint({x = args[2], y = args[3]})
    elseif args[1] == 'pos' then
    	getPos()
    elseif args[1] == 'stop' then
    	windower.ffxi.run(false)
    elseif args[1] == 'turn' then
    	windower.ffxi.turn(3.14)
    end
end)