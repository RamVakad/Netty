--[[
@author Int64
A library of network functions to replace the SetNetworked* functions.
This file contains all the clientside code.
]]

--[[
Reference:
util.AddNetworkString("nty_int") --INT
util.AddNetworkString("nty_ent") --ENTITY
util.AddNetworkString("nty_flt") --FLOAT
util.AddNetworkString("nty_str") --STRING
util.AddNetworkString("nty_vec") --VECTOR
util.AddNetworkString("nty_ang") --ANGLE
util.AddNetworkString("nty_bol") --BOOL
util.AddNetworkString("nty_clr") --CLEAR COMMAND
]]

net.Receive("nty_clr", function (len)

	local entid = tonumber(net.ReadString())
	Netty.INTS[entid] = nil;
	Netty.ENTITIES[entid] = nil;
	Netty.FLOATS[entid] = nil;
	Netty.STRINGS[entid] = nil;
	Netty.VECTORS[entid] = nil;
	Netty.ANGLES[entid] = nil;
	Netty.BOOLS[entid] = nil;
	--[[
	for ent, _ in pairs(Netty.ENTITIES) do
		if (IsValid(Entity(ent))) then
			for id, value in pairs(Netty.ENTITIES[ent]) do
				if (value == entid) then
					Netty.ENTITIES[ent][id] = nil;
				end
			end
		else
			Netty.ENTITIES[ent] = nil;
		end
	end
	]]
end )

net.Receive("nty_int", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadInt(32)
	Netty.SetNettyInt(entid, id, value)

end )

net.Receive("nty_ent", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadString()
	Netty.SetNettyEntity(entid, id, value)

end )

net.Receive("nty_flt", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadFloat()
	Netty.SetNettyFloat(entid, id, value)

end )

net.Receive("nty_str", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadString()
	Netty.SetNettyString(entid, id, value)
end )

net.Receive("nty_vec", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadVector()
	Netty.SetNettyVector(entid, id, value)

end )

net.Receive("nty_ang", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = net.ReadAngle()
	Netty.SetNettyAngle(entid, id, value)

end )

net.Receive("nty_bol", function (len)

	local entid = tonumber(net.ReadString())
	local id = net.ReadString()
	local value = (net.ReadBit() == 1)
	Netty.SetNettyBool(entid, id, value)
	
end )