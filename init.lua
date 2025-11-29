function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	-- random loadout compatibility fix
	if tonumber(StatsGetValue("playtime")) < 1 then
		
		local plyrChildEnt = EntityGetAllChildren( player_entity )
		if ( plyrChildEnt ~= nil ) then
			for i,chldEntity in ipairs( plyrChildEnt ) do
				local childName = EntityGetName( chldEntity)
				if ( childName == "arm_r" ) then
					EntityKill( chldEntity )
					arm_entity = EntityLoad( "mods/DarkAtlas/files/skin/entities/player_arm.xml")
					EntityAddChild( player_entity, arm_entity )
					break
				end
			end
		end
		
		EntityAddComponent( player_entity, "SpriteComponent",
		{
			_tags="character, DarkAtlas_Model",
			alpha="1", 
			image_file="mods/DarkAtlas/files/skin/enemies_gfx/player.xml", 
			next_rect_animation="", 
			offset_x="6", 
			offset_y="14" ,
			rect_animation="walk",
			update_transform="1",                                               
			z_index="0.602"
		} )	
		
		ComponentSetValue2( EntityGetFirstComponent( player_entity, "DamageModelComponent" ), "ragdoll_filenames_file", "mods/DarkAtlas/files/skin/ragdolls/player/filenames.txt" )

		-- Removes cape
		local plyChildEnt = EntityGetAllChildren( player_entity )
		if ( plyChildEnt ~= nil ) then
			for i,childEntity in ipairs( plyChildEnt ) do
				if ( EntityGetName( childEntity ) == "cape" ) then
					EntityKill( childEntity )
					break
				end
			end
		end

		if ModSettingGet("DarkAtlas.CAPE_TOGGLE") == true then	
			-- Adds cape entities
			local px, py = EntityGetTransform( player_entity )
			local ent_cape = EntityLoad("mods/DarkAtlas/skin/entities/atlas_cape/atlas_cape.xml",px, py)    
			EntityAddChild(player_entity, ent_cape )
			
			EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, DarkAtlas_Cape_Top, cape_top_fix1",
				alpha="1", 
				image_file="mods/DarkAtlas/files/skin/enemies_gfx/player_cape_top.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				z_index="0.598"
			} )
			EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, DarkAtlas_Cape_Top, cape_top_fix2",
				alpha="0", 
				image_file="mods/DarkAtlas/files/skin/enemies_gfx/player_cape_top.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				z_index="0.598"
			} )
		end
			

		--if ModSettingGet("DarkAtlas.JETPACK_TOGGLE") == true then
			EntitySetComponentsWithTagEnabled( player_entity, "jetpack", 1 )
			if( nil == EntityGetFirstComponent( player_entity, "ParticleEmitterComponent", "DarkAtlas_pt" ) ) then
				-- Remove old particles
				for i,compo in ipairs( {"ParticleEmitterComponent", "SpriteParticleEmitterComponent"} ) do
					while( compo ~= nil ) do
						local ptEmit = EntityGetFirstComponent( player_entity, compo, "jetpack" )
						if ( ptEmit == nil ) then break end
						EntityRemoveComponent( player_entity, ptEmit )
					end
				end
				-- Create new particles start
				local ptEmit1 = EntityAddComponent( player_entity, "ParticleEmitterComponent",
				{
					_tags="jetpack,DarkAtlas_pt",
					emitted_material_name="plasma_fading",
					x_pos_offset_min="-5",
					x_pos_offset_max="5",
					y_pos_offset_min="-5",
					y_pos_offset_max="5",
					x_vel_min="-8",
					x_vel_max="8",
					y_vel_min="-8",
					y_vel_max="8",
					count_min="2",
					attractor_force="0",
					lifetime_min="0.0",
					lifetime_max="15",
					create_real_particles="0",
					emit_cosmetic_particles="1",
					fade_based_on_lifetime="1",
					draw_as_long="1",
					emission_interval_min_frames="5",
					emission_interval_max_frames="5",
					is_trail="0",
					trail_gap="0.0",
					airflow_force="1.051",
					airflow_time="1.01",
					airflow_scale="0.05",
					is_emitting="1"
				} )
				local ptEmit2 = EntityAddComponent( player_entity, "ParticleEmitterComponent",
				{
					_tags="jetpack,DarkAtlas_pt",
					emitted_material_name="plasma_fading_pink",
					x_pos_offset_min="-5",
					x_pos_offset_max="5",
					y_pos_offset_min="-5",
					y_pos_offset_max="5",
					x_vel_min="-8",
					x_vel_max="8",
					y_vel_min="-8",
					y_vel_max="8",
					count_min="2",
					attractor_force="0",
					lifetime_min="0.0",
					lifetime_max="15",
					create_real_particles="0",
					emit_cosmetic_particles="1",
					fade_based_on_lifetime="1",
					draw_as_long="1",
					emission_interval_min_frames="5",
					emission_interval_max_frames="5",
					is_trail="0",
					trail_gap="0.0",
					airflow_force="1.051",
					airflow_time="1.01",
					airflow_scale="0.05",
					is_emitting="1"
				} )
				local ptx, pty = ComponentGetValueVector2( ptEmit1, "gravity" )
				local amn, amx = ComponentGetValueVector2( ptEmit1, "area_circle_radius" )
				pty = "0.0"
				amx = "0"
				ComponentSetValueVector2( ptEmit1, "gravity", ptx, pty )
				ComponentSetValueVector2( ptEmit2, "gravity", ptx, pty )
				ComponentSetValueVector2( ptEmit1, "offset", "-2", "2" )
				ComponentSetValueVector2( ptEmit2, "offset", "-2", "2" )
				ComponentSetValueVector2( ptEmit1, "area_circle_radius", amn, amx )
				ComponentSetValueVector2( ptEmit2, "area_circle_radius", amn, amx )
				-- Create new particles end
			end
		--end
		
		EntityAddComponent( player_entity, "LuaComponent",
		{
		remove_after_executed="0",
		execute_times="-1",
		script_source_file="data/scripts/cape_fix.lua"
		} )		
		EntityAddComponent( player_entity, "LuaComponent",
		{
		remove_after_executed="0",
		execute_times="-1",
		script_source_file="data/scripts/invisibility_fix.lua"
		} )

		-- Atlas transformations (probably remove this but it might be needed for lukky)
		-- EntityAddComponent( player_entity, "LuaComponent",
		-- {
		-- 	remove_after_executed="0",
		-- 	execute_times="-1",
		-- 	script_source_file="data/scripts/atlas_transformations.lua"
		-- } )

		--add wand on ground at start of the game
		--Path to the wand XML file
		local wand_path = "mods/DarkAtlas/files/wands/atlas_wand_1.xml"
		local x, y = EntityGetTransform(player_entity)
		SetRandomSeed( x, y + GameGetFrameNum() )
		-- Function to load the wand into the game
		local wand = EntityLoad(wand_path, x, y)
	end
end