--[[
@author Int64
A library of network functions to replace the SetNetworked* functions.
This file contains all the server side code.
It is safe to call SetNetty* functions in think functions because broadcasting only happens if the value changes.
]]

util.AddNetworkString("nty_int") --INT
util.AddNetworkString("nty_ent") --ENTITY
util.AddNetworkString("nty_flt") --FLOAT
util.AddNetworkString("nty_str") --STRING
util.AddNetworkString("nty_vec") --VECTOR
util.AddNetworkString("nty_ang") --ANGLE
util.AddNetworkString("nty_bol") --BOOL
util.AddNetworkString("nty_clr") --CLEAR COMMAND

--Send a clear command on removal of an entity.
function NettyEntityRemoved(enty) 
	if not (IsValid(enty)) then return end
	local entid = enty:EntIndex()
	Netty.INTS[entid] = nil;
	Netty.ENTITIES[entid] = nil;
	Netty.FLOATS[entid] = nil;
	Netty.STRINGS[entid] = nil;
	Netty.VECTORS[entid] = nil;
	Netty.ANGLES[entid] = nil;
	Netty.BOOLS[entid] = nil;
	--ENTITIES
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
	net.Start("nty_clr")
	net.WriteString(entid)
	net.Broadcast()
end
hook.Add("EntityRemoved", "NettyEntityRemoved", NettyEntityRemoved)

--Update a player with all the NETTY variables once he spawns.
function NettyPlayerConnect(player)
	if (IsValid(player)) then
		--INTEGERS
		for ent, _ in pairs(Netty.INTS) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.INTS[ent]) do
					net.Start("nty_int")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteInt(value, 32)
					net.Send(player)
				end
			else
				Netty.INTS[ent] = nil;
			end
		end

		--FLOATS
		for ent, _ in pairs(Netty.FLOATS) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.FLOATS[ent]) do
					net.Start("nty_flt")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteFloat(value)
					net.Send(player)
				end
			else
				Netty.FLOATS[ent] = nil;
			end
		end

		--STRINGS
		for ent, _ in pairs(Netty.STRINGS) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.STRINGS[ent]) do
					net.Start("nty_str")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteString(value)
					net.Send(player)
				end
			else
				Netty.STRINGS[ent] = nil;
			end
		end
		--[[
		--ENTITIES
		for ent, _ in pairs(Netty.ENTITIES) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.ENTITIES[ent]) do
					net.Start("nty_ent")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteString(value)
					net.Send(player)
				end
			else
				Netty.ENTITIES[ent] = nil;
			end
		end
		]]
		--VECTORS
		for ent, _ in pairs(Netty.VECTORS) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.VECTORS[ent]) do
					net.Start("nty_vec")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteVector(value)
					net.Send(player)
				end
			else
				Netty.VECTORS[ent] = nil;
			end
		end

		--ANGLES
		for ent, _ in pairs(Netty.ANGLES) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.ANGLES[ent]) do
					net.Start("nty_ang")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteAngle(value)
					net.Send(player)
				end
			else
				Netty.ANGLES[ent] = nil;
			end
		end

		--BOOLS
		for ent, _ in pairs(Netty.BOOLS) do
			if (IsValid(Entity(ent))) then
				for id, value in pairs(Netty.BOOLS[ent]) do
					net.Start("nty_bol")
					net.WriteString(ent)
					net.WriteString(id)
					net.WriteBit(value)
					net.Send(player)
				end
			else
				Netty.BOOLS[ent] = nil;
			end
		end
	end
end

hook.Add("PlayerInitialSpawn", "NettyPlayerConnect", NettyPlayerConnect)

print("[NETTY] Hooked")