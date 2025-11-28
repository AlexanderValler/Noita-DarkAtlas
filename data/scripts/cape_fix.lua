dofile("data/scripts/lib/utilities.lua")

local player = get_players()[1]
local x, y = EntityGetTransform(player)
local old_cape1 = EntityGetWithName("cape1")
local old_cape2 = EntityGetWithName("cape2")
local old_cape3 = EntityGetWithName("cape3")

local cape_VerletPhysics1 = EntityGetFirstComponent(old_cape1, "VerletPhysicsComponent")
local cape_VerletPhysics2 = EntityGetFirstComponent(old_cape2, "VerletPhysicsComponent")
local cape_VerletPhysics3 = EntityGetFirstComponent(old_cape3, "VerletPhysicsComponent")

if ComponentGetValue2( cape_VerletPhysics1, "m_is_culled_previous" ) == "1" then
	EntityRemoveFromParent(old_cape1)
    EntityKill(old_cape1)
	EntityLoad("mods/DarkAtlas/skin/entities/atlas_cape/atlas_cape.xml",x,y)
	local new_cape1 = EntityGetWithName("cape1")
	EntityAddChild(player,new_cape1)
end

if ComponentGetValue2( cape_VerletPhysics2, "m_is_culled_previous" ) == "1" then
	EntityRemoveFromParent(old_cape2)
    EntityKill(old_cape2)
	EntityLoad("mods/DarkAtlas/skin/entities/atlas_cape/atlas_cape2.xml",x,y)
	local new_cape2 = EntityGetWithName("cape2")
	EntityAddChild(player,new_cape2)
end

if ComponentGetValue2( cape_VerletPhysics3, "m_is_culled_previous" ) == "1" then
	EntityRemoveFromParent(old_cape3)
    EntityKill(old_cape3)
	EntityLoad("mods/DarkAtlas/skin/entities/atlas_cape/atlas_cape3.xml",x,y)
	local new_cape3 = EntityGetWithName("cape3")
	EntityAddChild(player,new_cape3)
end