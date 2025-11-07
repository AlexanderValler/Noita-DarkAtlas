dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "data/scripts/gun/procedural/gun_action_utils.lua" )

-- This function selects and returns a random element from the input table 'target'
-- It converts the selected element to a string before returning
function get_random_from( target )
	local rnd = Random(1, #target)
	
	return tostring(target[rnd])
end

-- This function generates a random number within a specified range
-- It expects 'target' to be a table with two elements: the minimum and maximum values
-- It returns a random number between these two values, inclusive
function get_random_between_range( target )
	local minval = target[1]
	local maxval = target[2]
	
	return Random(minval, maxval)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

-- 
local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

local wand = { }
wand.name = {"Template wand"}
wand.deck_capacity = { 3, 5 }
wand.actions_per_round = 2
wand.reload_time = {20,30}
wand.shuffle_deck_when_empty = 0
wand.fire_rate_wait = {1,1}
wand.spread_degrees = {5,10}
wand.speed_multiplier = 1.5
wand.mana_charge_speed = {50,100}
wand.mana_max = {100,150}

local mana_max = get_random_between_range( wand.mana_max )
local deck_capacity = get_random_between_range( wand.deck_capacity )

ComponentSetValue2( ability_comp, "ui_name", get_random_from( wand.name ) )

ComponentObjectSetValue2( ability_comp, "gun_config", "reload_time", get_random_between_range( wand.reload_time ) )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "fire_rate_wait", get_random_between_range( wand.fire_rate_wait ) )
ComponentSetValue2( ability_comp, "mana_charge_speed", get_random_between_range( wand.mana_charge_speed ) )

ComponentObjectSetValue2( ability_comp, "gun_config", "actions_per_round", wand.actions_per_round )
ComponentObjectSetValue2( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue2( ability_comp, "gun_config", "shuffle_deck_when_empty", wand.shuffle_deck_when_empty )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "spread_degrees", get_random_between_range( wand.spread_degrees ) )
ComponentObjectSetValue2( ability_comp, "gunaction_config", "speed_multiplier", wand.speed_multiplier )

ComponentSetValue2( ability_comp, "mana_max", mana_max )
ComponentSetValue2( ability_comp, "mana", mana_max )

local colours = { "COLOUR_RAINBOW", "COLOUR_RED", "COLOUR_PURPLE", "COLOUR_ORANGE", "COLOUR_BLUE", "COLOUR_YELLOW", "COLOUR_GREEN" }

-- Add permanently a color
AddGunActionPermanent( entity_id, get_random_from( colours ) )

AddGunAction( entity_id, "RECOIL_DAMPER" )

for i=1,2 do
	AddGunAction( entity_id, "RUBBER_BALL" )
end

local item_comp = EntityGetFirstComponent( entity_id, "ItemComponent" )

ComponentSetValue2( item_comp, "item_name", "$item_wand_good_3" )
-- $item_wand_experimental_1 --> "EXPERIMENTAL WAND"
-- $item_wand_experimental_2 --> "EXPERIMENTAL WAND"
-- $item_wand_good_1 --> "WAND OF SWIFTNESS"
-- $item_wand_good_2 --> "WAND OF DESTRUCTION"
-- $item_wand_good_3 --> "WAND OF MULTITUDES"
-- $item_wand_ruusu --> "RUUSU"
-- $item_wand_varpuluuta --> "VARPULUUTA"
-- $item_wand_valtikka --> "VALTIKKA"
-- $item_wand_kiekurakeppi --> "KIEKURAKEPPI"
-- $item_wand_arpaluu --> "ARPALUU"
-- $item_vasta --> "VASTA"
-- $item_vihta --> "VIHTA"
ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )