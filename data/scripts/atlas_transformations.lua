dofile_once( "data/scripts/lib/utilities.lua" )

-- Get player information
local player = get_players()[1]
local player_sprite = EntityGetFirstComponent(player, "SpriteComponent")
local playerChildEntity = EntityGetAllChildren(player)
local fungal_transform = EntityGetFirstComponent(player, "SpriteComponent", "player_hat")
local lukki_transform = EntityGetFirstComponent(player, "SpriteComponent", "lukki_enable")

local enabled_crown = EntityGetFirstComponent(player, "SpriteComponent", "player_hat2")
local enabled_amulet = EntityGetFirstComponent(player, "SpriteComponent", "player_amulet")
local enabled_gem = EntityGetFirstComponent(player, "SpriteComponent", "player_amulet_gem")

-- Fungal transformation
if fungal_transform ~= nil then
	
	-- Change the player sprite
	if lukki_transform ~= nil then
		ComponentSetValue2(lukki_transform, "image_file", "mods/DarkAtlas/files/skin/enemies_gfx/player_shroom.xml" )
		-- ComponentSetValue2(lukki_transform, "image_file", "data/enemies_gfx/player_lukky.xml" )
	end
	else
			ComponentSetValue2(player_sprite, "image_file", "mods/DarkAtlas/files/skin/enemies_gfx/player_shroom.xml" )
			-- ComponentSetValue2(player_sprite, "image_file", "data/enemies_gfx/player.xml" )
		end
	end

	--Change the arm sprite
	if ( playerChildEntity ~= nil ) then
		for i,childEntity in ipairs( playerChildEntity ) do
			local childName = EntityGetName(childEntity)
			if ( childName == "arm_r" ) then
				local player_arm = EntityGetFirstComponent(childEntity, "SpriteComponent")
				ComponentSetValue2(player_arm, "image_file", "mods/DarkAtlas/files/skin/enemies_gfx/player_arm_fungal.xml" )
				--ComponentSetValue2(player_arm, "image_file", "data/enemies_gfx/player_arm.xml" )
				end
				break
			end
		end
	end
end

-- Execute upon lukki transformation
if lukki_transform ~= nil and bowl_transform ~= true then
	
	-- Change the player sprite
	if fungal_transform ~= nil then
			ComponentSetValue2(lukki_transform, "image_file", "mods/DarkAtlas/files/skin/enemies_gfx/player_lukky.xml" )
			--ComponentSetValue2(lukki_transform, "image_file", "data/enemies_gfx/player_lukky.xml" 
		end
	else
			ComponentSetValue2(lukki_transform, "image_file", "data/enemies_gfx/player_lukky.xml" )
			--ComponentSetValue2(lukki_transform, "image_file", "mods/DarkAtlas/files/skin/enemies_gfx/player_lukky.xml" )
		end
	end
	-- Execute transformation only once
	bowl_transform = true
end