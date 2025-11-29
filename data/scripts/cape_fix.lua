dofile("data/scripts/lib/utilities.lua")

local player = get_players()[1]
local x, y = EntityGetTransform(player)
local old_cape1 = EntityGetWithName("cape1")

local cape_VerletPhysics1 = EntityGetFirstComponent(old_cape1, "VerletPhysicsComponent")

if ComponentGetValue2( cape_VerletPhysics1, "m_is_culled_previous" ) == "1" then
	EntityRemoveFromParent(old_cape1)
    EntityKill(old_cape1)
	EntityLoad("mods/DarkAtlas/skin/entities/atlas_cape/atlas_cape.xml",x,y)
	local new_cape1 = EntityGetWithName("cape1")
	EntityAddChild(player,new_cape1)
end