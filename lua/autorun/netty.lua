--[[
@author Int64
A library of network functions to replace the SetNetworked* functions.
This has all the GetNetty functions shared by the client and server.
]]


Netty = { }
Netty.META_ENT = FindMetaTable("Entity")
Netty.Disable = false;
Netty.OverrideNWFunctions = true;
Netty.Entities = { } -- All the entities with variables. Used only by the server.

Netty.INTS = {}
Netty.ENTITIES = {}
Netty.FLOATS = {}
Netty.STRINGS = {}
Netty.VECTORS = {}
Netty.ANGLES = {}
Netty.BOOLS = {}

function Netty.META_ENT:GetNettyInt(id, default)	
	if not Netty.INTS[self:EntIndex()] then Netty.INTS[self:EntIndex()] = {} end
	return Netty.INTS[self:EntIndex()] and Netty.INTS[self:EntIndex()][id] or default or 0;
end

function Netty.META_ENT:GetNettyFloat(id, default)	
	if not Netty.FLOATS[self:EntIndex()] then Netty.FLOATS[self:EntIndex()] = {} end
	return Netty.FLOATS[self:EntIndex()] and Netty.FLOATS[self:EntIndex()][id] or default or 0;
end

function Netty.META_ENT:GetNettyString(id, default)	
	if not Netty.STRINGS[self:EntIndex()] then Netty.STRINGS[self:EntIndex()] = {} end
	return Netty.STRINGS[self:EntIndex()] and Netty.STRINGS[self:EntIndex()][id] or default or "";
end

function Netty.META_ENT:GetNettyVector(id, default)	
	if not Netty.VECTORS[self:EntIndex()] then Netty.VECTORS[self:EntIndex()] = {} end
	return Netty.VECTORS[self:EntIndex()] and Netty.VECTORS[self:EntIndex()][id] or default;
end

function Netty.META_ENT:GetNettyAngle(id, default)	
	if not Netty.ANGLES[self:EntIndex()] then Netty.ANGLES[self:EntIndex()] = {} end
	return Netty.ANGLES[self:EntIndex()] and Netty.ANGLES[self:EntIndex()][id] or default;
end

function Netty.META_ENT:GetNettyBool(id, default)	
	if not Netty.BOOLS[self:EntIndex()] then Netty.BOOLS[self:EntIndex()] = {} end
	return Netty.BOOLS[self:EntIndex()] and Netty.BOOLS[self:EntIndex()][id] or default;
end

function Netty.META_ENT:GetNettyEntity(id, default)
	if not Netty.ENTITIES[self:EntIndex()] then Netty.ENTITIES[self:EntIndex()] = {} end
	if (Netty.ENTITIES[self:EntIndex()] and Netty.ENTITIES[self:EntIndex()][id]) then
		if (string.find(Netty.ENTITIES[self:EntIndex()][id], "PLY")) then
			return g_Player.GetByUniqueID(string.sub( Netty.ENTITIES[self:EntIndex()][id], 4 ));
		else
			return Entity(tonumber(Netty.ENTITIES[self:EntIndex()][id])) or default;
		end
	end
	return default;
end

function Netty.META_ENT:SetNettyInt(id, value)
	if (self:GetNettyInt(id) != value) then 
		Netty.INTS[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_int")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteInt(value, 32) --4 Bytes
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyEntity(id, value)	
	if (self:GetNettyEntity(id) != value) then 
		local entidx = value:EntIndex()..""
		if (value:IsPlayer()) then
			entidx = "PLY"..value:UniqueID();
		end
		Netty.ENTITIES[self:EntIndex()][id] = entidx;
		if not (SERVER) then return end
		net.Start("nty_ent")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteString(entidx)
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyFloat(id, value)	
	if (self:GetNettyFloat(id) != value) then 
		Netty.FLOATS[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_flt")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteFloat(value)
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyString(id, value)	
	if (self:GetNettyString(id) != value) then 
		Netty.STRINGS[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_str")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteString(value)
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyVector(id, value)	
	if (self:GetNettyVector(id) != value) then 
		Netty.VECTORS[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_vec")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteVector(value)
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyAngle(id, value)	
	if (self:GetNettyAngle(id) != value) then 
		Netty.ANGLES[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_ang")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteAngle(value)
		net.Broadcast();
	end
end

function Netty.META_ENT:SetNettyBool(id, value)	
	if (self:GetNettyBool(id) != value) then 
		Netty.BOOLS[self:EntIndex()][id] = value;
		if not (SERVER) then return end
		net.Start("nty_bol")
		net.WriteString(self:EntIndex())
		net.WriteString(id)
		net.WriteBit(value)
		net.Broadcast();
	end
end

function Netty.SetNettyInt(entid, id, value)
	if not Netty.INTS[entid] then Netty.INTS[entid] = {} end
	Netty.INTS[entid][id] = value;
end

function Netty.SetNettyEntity(entid, id, value)
	if not Netty.ENTITIES[entid] then Netty.ENTITIES[entid] = {} end
	Netty.ENTITIES[entid][id] = value;
end

function Netty.SetNettyFloat(entid, id, value)
	if not Netty.FLOATS[entid] then Netty.FLOATS[entid] = {} end
	Netty.FLOATS[entid][id] = value;
end

function Netty.SetNettyString(entid, id, value)
	if not Netty.STRINGS[entid] then Netty.STRINGS[entid] = {} end
	Netty.STRINGS[entid][id] = value;
end

function Netty.SetNettyVector(entid, id, value)
	if not Netty.VECTORS[entid] then Netty.VECTORS[entid] = {} end
	Netty.VECTORS[entid][id] = value;
end

function Netty.SetNettyAngle(entid, id, value)
	if not Netty.ANGLES[entid] then Netty.ANGLES[entid] = {} end
	Netty.ANGLES[entid][id] = value;
end

function Netty.SetNettyBool(entid, id, value)
	if not Netty.BOOLS[entid] then Netty.BOOLS[entid] = {} end
	Netty.BOOLS[entid][id] = value;
end

if Netty.Disable then
	--GET
	Netty.META_ENT.GetNettyInt = Netty.META_ENT.GetNetworkedInt
	Netty.META_ENT.GetNettyEntity = Netty.META_ENT.GetNetworkedEntity
	Netty.META_ENT.GetNettyFloat = Netty.META_ENT.GetNetworkedFloat
	Netty.META_ENT.GetNettyString = Netty.META_ENT.GetNetworkedString
	Netty.META_ENT.GetNettyVector = Netty.META_ENT.GetNetworkedVector
	Netty.META_ENT.GetNettyAngle = Netty.META_ENT.GetNetworkedAngle
	Netty.META_ENT.GetNettyBool = Netty.META_ENT.GetNetworkedBool

	--SET
	Netty.META_ENT.SetNettyInt = Netty.META_ENT.SetNetworkedInt
	Netty.META_ENT.SetNettyEntity = Netty.META_ENT.SetNetworkedEntity
	Netty.META_ENT.SetNettyFloat = Netty.META_ENT.SetNetworkedFloat
	Netty.META_ENT.SetNettyString = Netty.META_ENT.SetNetworkedString
	Netty.META_ENT.SetNettyVector = Netty.META_ENT.SetNetworkedVector
	Netty.META_ENT.SetNettyAngle = Netty.META_ENT.SetNetworkedAngle
	Netty.META_ENT.SetNettyBool = Netty.META_ENT.SetNetworkedBool
	return
end

if Netty.OverrideNWFunctions then
	--GET
	Netty.META_ENT.GetNetworkedInt = Netty.META_ENT.GetNettyInt
	--Netty.META_ENT.GetNetworkedEntity = Netty.META_ENT.GetNettyEntity
	Netty.META_ENT.GetNetworkedFloat = Netty.META_ENT.GetNettyFloat
	Netty.META_ENT.GetNetworkedString = Netty.META_ENT.GetNettyString
	Netty.META_ENT.GetNetworkedVector = Netty.META_ENT.GetNettyVector
	Netty.META_ENT.GetNetworkedAngle = Netty.META_ENT.GetNettyAngle
	Netty.META_ENT.GetNetworkedBool = Netty.META_ENT.GetNettyBool
	Netty.META_ENT.GetNWInt = Netty.META_ENT.GetNettyInt
	--Netty.META_ENT.GetNWEntity = Netty.META_ENT.GetNettyEntity
	Netty.META_ENT.GetNWFloat = Netty.META_ENT.GetNettyFloat
	Netty.META_ENT.GetNWString = Netty.META_ENT.GetNettyString
	Netty.META_ENT.GetNWVector = Netty.META_ENT.GetNettyVector
	Netty.META_ENT.GetNWAngle = Netty.META_ENT.GetNettyAngle
	Netty.META_ENT.GetNWBool = Netty.META_ENT.GetNettyBool
	--SET
	Netty.META_ENT.SetNetworkedInt = Netty.META_ENT.SetNettyInt
	--Netty.META_ENT.SetNetworkedEntity = Netty.META_ENT.SetNettyEntity
	Netty.META_ENT.SetNetworkedFloat = Netty.META_ENT.SetNettyFloat
	Netty.META_ENT.SetNetworkedString = Netty.META_ENT.SetNettyString
	Netty.META_ENT.SetNetworkedVector = Netty.META_ENT.SetNettyVector
	Netty.META_ENT.SetNetworkedAngle = Netty.META_ENT.SetNettyAngle
	Netty.META_ENT.SetNetworkedBool = Netty.META_ENT.SetNettyBool
	Netty.META_ENT.SetNWInt = Netty.META_ENT.SetNettyInt
	--Netty.META_ENT.SetNWEntity = Netty.META_ENT.SetNettyEntity
	Netty.META_ENT.SetNWFloat = Netty.META_ENT.SetNettyFloat
	Netty.META_ENT.SetNWString = Netty.META_ENT.SetNettyString
	Netty.META_ENT.SetNWVector = Netty.META_ENT.SetNettyVector
	Netty.META_ENT.SetNWAngle = Netty.META_ENT.SetNettyAngle
	Netty.META_ENT.SetNWBool = Netty.META_ENT.SetNettyBool
end

if (SERVER) then print("[NETTY] Loaded") end