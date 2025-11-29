dofile("data/scripts/lib/utilities.lua")

local player = get_players()[1]
local invis_effect = GameGetGameEffect(player, "INVISIBILITY")
local is_invisible = ComponentGetValue2( invis_effect, "mInvisible")

local copy_hat_sprite = EntityGetFirstComponent(player, "SpriteComponent", "copy_hat_fix")
local copy_no_hat_sprite = EntityGetFirstComponent(player, "SpriteComponent", "copy_no_hat_fix")

local cape_top1_sprite = EntityGetFirstComponent(player, "SpriteComponent", "cape_top_fix1")
local cape_top2_sprite = EntityGetFirstComponent(player, "SpriteComponent", "cape_top_fix2")

if ModSettingGet("DarkAtlas.HAT_TOGGLE") == true then
	if is_invisible == nil then
		ComponentSetValue2(copy_hat_sprite,"alpha", 1)
	elseif is_invisible ~= nil then
		ComponentSetValue2(copy_hat_sprite,"alpha", 0)
	end
elseif ModSettingGet("DarkAtlas.HAT_TOGGLE") == false then
	if is_invisible == nil then
		ComponentSetValue(copy_no_hat_sprite,"alpha", 1)
	elseif is_invisible ~= nil then
		ComponentSetValue(copy_no_hat_sprite,"alpha", 0)
	end
end

if ModSettingGet("DarkAtlas.CAPE_TOGGLE") == true then
	if is_invisible == nil then
		ComponentSetValue2(cape_top1_sprite,"alpha", 1)
		ComponentSetValue2(cape_top2_sprite,"alpha", 0)
	elseif is_invisible ~= nil then
		if is_invisible == "0" then
			ComponentSetValue2(cape_top1_sprite,"alpha", 0)
			ComponentSetValue2(cape_top2_sprite,"alpha", 1)
		elseif is_invisible == "1" then
			ComponentSetValue2(cape_top1_sprite,"alpha", 0)
			ComponentSetValue2(cape_top2_sprite,"alpha", 0.7)
		end
	end
end