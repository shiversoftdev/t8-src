// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\gametypes\spawnlogic.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace spawning;

/*
	Name: __init__
	Namespace: spawning
	Checksum: 0x9A98CD26
	Offset: 0x310
	Size: 0x204
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level init_spawn_system();
	level.recently_deceased = [];
	foreach(team, _ in level.teams)
	{
		level.recently_deceased[team] = util::spawn_array_struct();
	}
	callback::on_connecting(&on_player_connecting);
	level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
	level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
	/#
		setdvar(#"scr_debug_spawn_player", "");
		setdvar(#"scr_debug_render_spawn_data", 1);
		setdvar(#"scr_debug_render_snapshotmode", 0);
		setdvar(#"scr_spawn_point_test_mode", 0);
		level.test_spawn_point_index = 0;
		setdvar(#"scr_debug_render_spawn_text", 1);
	#/
}

/*
	Name: init_spawn_system
	Namespace: spawning
	Checksum: 0x850F8DB2
	Offset: 0x520
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function init_spawn_system()
{
	level.spawnsystem = spawnstruct();
	spawnsystem = level.spawnsystem;
	if(!isdefined(spawnsystem.unifiedsideswitching))
	{
		spawnsystem.unifiedsideswitching = 1;
	}
	spawnsystem.objective_facing_bonus = 0;
	spawnsystem.ispawn_teammask = [];
	spawnsystem.ispawn_teammask_free = 1;
	spawnsystem.ispawn_teammask[#"free"] = spawnsystem.ispawn_teammask_free;
	all = spawnsystem.ispawn_teammask_free;
	count = 1;
	foreach(team, _ in level.teams)
	{
		spawnsystem.ispawn_teammask[team] = 1 << count;
		all = all | spawnsystem.ispawn_teammask[team];
		count++;
	}
	spawnsystem.ispawn_teammask[#"all"] = all;
}

/*
	Name: on_player_connecting
	Namespace: spawning
	Checksum: 0xAFFEA0E0
	Offset: 0x6C0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function on_player_connecting()
{
	level endon(#"game_ended");
	self setentertime(gettime());
	callback::on_spawned(&on_player_spawned);
	callback::on_joined_team(&on_joined_team);
	self thread ongrenadethrow();
}

/*
	Name: on_player_spawned
	Namespace: spawning
	Checksum: 0x317395A4
	Offset: 0x758
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	for(;;)
	{
		self waittill(#"spawned_player");
		self enable_player_influencers(1);
		self thread ondeath();
	}
}

/*
	Name: ondeath
	Namespace: spawning
	Checksum: 0x8FA998DE
	Offset: 0x7D8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function ondeath()
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	self waittill(#"death");
	self enable_player_influencers(0);
	level create_friendly_influencer("friend_dead", self.origin, self.team);
}

/*
	Name: on_joined_team
	Namespace: spawning
	Checksum: 0x6EC0D91E
	Offset: 0x870
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function on_joined_team(params)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	self player_influencers_set_team();
}

/*
	Name: ongrenadethrow
	Namespace: spawning
	Checksum: 0xFE0096F8
	Offset: 0x8C0
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function ongrenadethrow()
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		level thread create_grenade_influencers(self.pers[#"team"], weapon, grenade);
		waitframe(1);
	}
}

/*
	Name: get_friendly_team_mask
	Namespace: spawning
	Checksum: 0x370FFA46
	Offset: 0x990
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function get_friendly_team_mask(team)
{
	if(level.teambased)
	{
		team_mask = util::getteammask(team);
	}
	else
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	return team_mask;
}

/*
	Name: get_enemy_team_mask
	Namespace: spawning
	Checksum: 0x9CA5D964
	Offset: 0x9F0
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function get_enemy_team_mask(team)
{
	if(level.teambased)
	{
		team_mask = util::getotherteamsmask(team);
	}
	else
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	return team_mask;
}

/*
	Name: create_influencer
	Namespace: spawning
	Checksum: 0x55895310
	Offset: 0xA50
	Size: 0x68
	Parameters: 3
	Flags: Linked
*/
function create_influencer(name, origin, team_mask)
{
	self.influencers[name] = addinfluencer(name, origin, team_mask);
	self thread watch_remove_influencer();
	return self.influencers[name];
}

/*
	Name: create_friendly_influencer
	Namespace: spawning
	Checksum: 0x9E97491E
	Offset: 0xAC0
	Size: 0x78
	Parameters: 3
	Flags: Linked
*/
function create_friendly_influencer(name, origin, team)
{
	team_mask = self get_friendly_team_mask(team);
	self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
	return self.influencersfriendly[name];
}

/*
	Name: create_enemy_influencer
	Namespace: spawning
	Checksum: 0x75DBB3EA
	Offset: 0xB40
	Size: 0x78
	Parameters: 3
	Flags: Linked
*/
function create_enemy_influencer(name, origin, team)
{
	team_mask = self get_enemy_team_mask(team);
	self.influencersenemy[name] = create_influencer(name, origin, team_mask);
	return self.influencersenemy[name];
}

/*
	Name: create_entity_influencer
	Namespace: spawning
	Checksum: 0xE57AAE28
	Offset: 0xBC0
	Size: 0x48
	Parameters: 2
	Flags: Linked
*/
function create_entity_influencer(name, team_mask)
{
	self.influencers[name] = addentityinfluencer(name, self, team_mask);
	return self.influencers[name];
}

/*
	Name: create_entity_friendly_influencer
	Namespace: spawning
	Checksum: 0x961D1D7A
	Offset: 0xC10
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function create_entity_friendly_influencer(name)
{
	team_mask = self get_friendly_team_mask();
	return self create_entity_masked_friendly_influencer(name, team_mask);
}

/*
	Name: create_entity_enemy_influencer
	Namespace: spawning
	Checksum: 0xEA0C31A8
	Offset: 0xC68
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function create_entity_enemy_influencer(name)
{
	team_mask = self get_enemy_team_mask();
	return self create_entity_masked_enemy_influencer(name, team_mask);
}

/*
	Name: create_entity_masked_friendly_influencer
	Namespace: spawning
	Checksum: 0xAC48CC51
	Offset: 0xCC0
	Size: 0x48
	Parameters: 2
	Flags: Linked
*/
function create_entity_masked_friendly_influencer(name, team_mask)
{
	self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
	return self.influencersfriendly[name];
}

/*
	Name: create_entity_masked_enemy_influencer
	Namespace: spawning
	Checksum: 0x2F1D9D6A
	Offset: 0xD10
	Size: 0x48
	Parameters: 2
	Flags: Linked
*/
function create_entity_masked_enemy_influencer(name, team_mask)
{
	self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
	return self.influencersenemy[name];
}

/*
	Name: create_player_influencers
	Namespace: spawning
	Checksum: 0xDCED60E8
	Offset: 0xD60
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function create_player_influencers()
{
	/#
		assert(!isdefined(self.influencers));
	#/
	/#
		assert(!isdefined(self.influencers));
	#/
	if(!level.teambased)
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		other_team_mask = level.spawnsystem.ispawn_teammask_free;
		weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		if(isdefined(self.pers[#"team"]))
		{
			team = self.pers[#"team"];
			team_mask = util::getteammask(team);
			enemy_teams_mask = util::getotherteamsmask(team);
		}
		else
		{
			team_mask = 0;
			enemy_teams_mask = 0;
		}
	}
	angles = self.angles;
	origin = self.origin;
	up = (0, 0, 1);
	forward = (1, 0, 0);
	self.influencers = [];
	self.friendlyinfluencers = [];
	self.enemyinfluencers = [];
	self create_entity_masked_enemy_influencer(#"enemy", enemy_teams_mask);
	if(level.teambased)
	{
		self create_entity_masked_friendly_influencer("friend", team_mask);
	}
	if(!isdefined(self.pers[#"team"]) || self.pers[#"team"] == "spectator")
	{
		self enable_influencers(0);
	}
}

/*
	Name: remove_influencers
	Namespace: spawning
	Checksum: 0x913D8B5
	Offset: 0xFC0
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function remove_influencers()
{
	foreach(influencer in self.influencers)
	{
		removeinfluencer(influencer);
	}
	self.influencers = [];
	if(isdefined(self.influencersfriendly))
	{
		self.influencersfriendly = [];
	}
	if(isdefined(self.influencersenemy))
	{
		self.influencersenemy = [];
	}
}

/*
	Name: watch_remove_influencer
	Namespace: spawning
	Checksum: 0xF81B189E
	Offset: 0x1080
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function watch_remove_influencer()
{
	self endon(#"death");
	self notify(#"watch_remove_influencer");
	self endon(#"watch_remove_influencer");
	waitresult = undefined;
	waitresult = self waittill(#"influencer_removed");
	arrayremovevalue(self.influencers, waitresult.index);
	arrayremovevalue(self.influencersfriendly, waitresult.index);
	arrayremovevalue(self.influencersenemy, waitresult.index);
	self thread watch_remove_influencer();
}

/*
	Name: enable_influencers
	Namespace: spawning
	Checksum: 0x80F70C5
	Offset: 0x1168
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function enable_influencers(enabled)
{
	foreach(influencer in self.influencers)
	{
		enableinfluencer(influencer, enabled);
	}
}

/*
	Name: enable_player_influencers
	Namespace: spawning
	Checksum: 0xC64C08C4
	Offset: 0x11F8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function enable_player_influencers(enabled)
{
	if(!isdefined(self.influencers))
	{
		self create_player_influencers();
	}
	self enable_influencers(enabled);
}

/*
	Name: player_influencers_set_team
	Namespace: spawning
	Checksum: 0x754A2C68
	Offset: 0x1248
	Size: 0x1A8
	Parameters: 0
	Flags: Linked
*/
function player_influencers_set_team()
{
	if(!level.teambased)
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		team = self.pers[#"team"];
		team_mask = util::getteammask(team);
		enemy_teams_mask = util::getotherteamsmask(team);
	}
	if(isdefined(self.influencersfriendly))
	{
		foreach(influencer in self.influencersfriendly)
		{
			setinfluencerteammask(influencer, team_mask);
		}
	}
	if(isdefined(self.influencersenemy))
	{
		foreach(influencer in self.influencersenemy)
		{
			setinfluencerteammask(influencer, enemy_teams_mask);
		}
	}
}

/*
	Name: create_grenade_influencers
	Namespace: spawning
	Checksum: 0x99B133D8
	Offset: 0x13F8
	Size: 0x10C
	Parameters: 3
	Flags: Linked
*/
function create_grenade_influencers(parent_team, weapon, grenade)
{
	pixbeginevent(#"create_grenade_influencers");
	spawn_influencer = weapon.spawninfluencer;
	if(isdefined(grenade.origin) && spawn_influencer != "")
	{
		if(!level.teambased)
		{
			weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
		}
		else
		{
			weapon_team_mask = util::getotherteamsmask(parent_team);
			if(level.friendlyfire)
			{
				weapon_team_mask = weapon_team_mask | util::getteammask(parent_team);
			}
		}
		grenade create_entity_masked_enemy_influencer(spawn_influencer, weapon_team_mask);
	}
	pixendevent();
}

/*
	Name: create_map_placed_influencers
	Namespace: spawning
	Checksum: 0x99D68A5
	Offset: 0x1510
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function create_map_placed_influencers()
{
	staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
	for(i = 0; i < staticinfluencerents.size; i++)
	{
		staticinfluencerent = staticinfluencerents[i];
		create_map_placed_influencer(staticinfluencerent);
	}
}

/*
	Name: create_map_placed_influencer
	Namespace: spawning
	Checksum: 0x2B73364B
	Offset: 0x1598
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function create_map_placed_influencer(influencer_entity)
{
	influencer_id = -1;
	if(isdefined(influencer_entity.script_noteworty))
	{
		team_mask = util::getteammask(influencer_entity.script_team);
		level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
	}
	else
	{
		/#
			assertmsg("");
		#/
	}
	return influencer_id;
}

/*
	Name: updateallspawnpoints
	Namespace: spawning
	Checksum: 0xA03F3D29
	Offset: 0x1640
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function updateallspawnpoints()
{
	foreach(team, _ in level.teams)
	{
		gatherspawnpoints(team);
	}
	spawnlogic::clearspawnpoints();
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			spawnlogic::addspawnpoints(team, level.unified_spawn_points[team].a);
		}
	}
	else
	{
		foreach(team, _ in level.teams)
		{
			spawnlogic::addspawnpoints("free", level.unified_spawn_points[team].a);
		}
	}
	remove_unused_spawn_entities();
}

/*
	Name: onspawnplayer_unified
	Namespace: spawning
	Checksum: 0x6779FFE0
	Offset: 0x17F8
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function onspawnplayer_unified(predictedspawn = 0)
{
	/#
		if(getdvarint(#"scr_spawn_point_test_mode", 0) != 0)
		{
			spawn_point = get_debug_spawnpoint(self);
			self spawn(spawn_point.origin, spawn_point.angles);
			return;
		}
	#/
	use_new_spawn_system = 0;
	initial_spawn = 1;
	if(isdefined(self.uspawn_already_spawned))
	{
		initial_spawn = !self.uspawn_already_spawned;
	}
	if(level.usestartspawns)
	{
		use_new_spawn_system = 0;
	}
	if(level.gametype == "sd")
	{
		use_new_spawn_system = 0;
	}
	util::set_dvar_if_unset("scr_spawn_force_unified", "0");
	[[level.onspawnplayer]](predictedspawn);
	if(!predictedspawn)
	{
		self.uspawn_already_spawned = 1;
	}
}

/*
	Name: getspawnpoint
	Namespace: spawning
	Checksum: 0x563748D8
	Offset: 0x1948
	Size: 0x13E
	Parameters: 2
	Flags: None
*/
function getspawnpoint(player_entity, predictedspawn = 0)
{
	if(level.teambased)
	{
		point_team = player_entity.pers[#"team"];
		influencer_team = player_entity.pers[#"team"];
	}
	else
	{
		point_team = "free";
		influencer_team = "free";
	}
	if(level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.unifiedsideswitching)
	{
		point_team = util::getotherteam(point_team);
	}
	best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);
	if(!predictedspawn)
	{
		player_entity.last_spawn_origin = best_spawn[#"origin"];
	}
	return best_spawn;
}

/*
	Name: get_debug_spawnpoint
	Namespace: spawning
	Checksum: 0x8B7041D7
	Offset: 0x1A90
	Size: 0x252
	Parameters: 1
	Flags: None
*/
function get_debug_spawnpoint(player)
{
	if(level.teambased)
	{
		team = player.pers[#"team"];
	}
	else
	{
		team = "free";
	}
	index = level.test_spawn_point_index;
	level.test_spawn_point_index++;
	if(team == "free")
	{
		spawn_counts = 0;
		foreach(team, _ in level.teams)
		{
			spawn_counts = spawn_counts + level.unified_spawn_points[team].a.size;
		}
		if(level.test_spawn_point_index >= spawn_counts)
		{
			level.test_spawn_point_index = 0;
		}
		count = 0;
		foreach(team, _ in level.teams)
		{
			size = level.unified_spawn_points[team].a.size;
			if(level.test_spawn_point_index < count + size)
			{
				return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
			}
			count = count + size;
		}
	}
	else
	{
		if(level.test_spawn_point_index >= level.unified_spawn_points[team].a.size)
		{
			level.test_spawn_point_index = 0;
		}
		return level.unified_spawn_points[team].a[level.test_spawn_point_index];
	}
}

/*
	Name: get_best_spawnpoint
	Namespace: spawning
	Checksum: 0xE2E4F90E
	Offset: 0x1CF0
	Size: 0x1B0
	Parameters: 4
	Flags: Linked
*/
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn)
{
	if(level.teambased)
	{
		vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
	}
	else
	{
		vis_team_mask = level.spawnsystem.ispawn_teammask_free;
	}
	spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
	if(!predictedspawn)
	{
		var_48eba3a3 = {#z:spawn_point[#"origin"][2], #y:spawn_point[#"origin"][1], #x:spawn_point[#"origin"][0], #hash_c734ddf2:getplayerspawnid(player), #reason:"point used"};
		function_92d1707f(#"hash_263d9506f7e11fdd", var_48eba3a3);
	}
	return spawn_point;
}

/*
	Name: gatherspawnpoints
	Namespace: spawning
	Checksum: 0x35851388
	Offset: 0x1EA8
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function gatherspawnpoints(player_team)
{
	if(!isdefined(level.unified_spawn_points))
	{
		level.unified_spawn_points = [];
	}
	else if(isdefined(level.unified_spawn_points[player_team]))
	{
		return level.unified_spawn_points[player_team];
	}
	spawn_entities_s = util::spawn_array_struct();
	spawn_entities_s.a = spawnlogic::getteamspawnpoints(player_team);
	if(!isdefined(spawn_entities_s.a))
	{
		spawn_entities_s.a = [];
	}
	level.unified_spawn_points[player_team] = spawn_entities_s;
	return spawn_entities_s;
}

/*
	Name: is_hardcore
	Namespace: spawning
	Checksum: 0x5E91C16C
	Offset: 0x1F80
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function is_hardcore()
{
	return isdefined(level.hardcoremode) && level.hardcoremode;
}

/*
	Name: teams_have_enmity
	Namespace: spawning
	Checksum: 0x531A7F2B
	Offset: 0x1FA8
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function teams_have_enmity(team1, team2)
{
	if(!isdefined(team1) || !isdefined(team2) || level.gametype == "dm")
	{
		return 1;
	}
	return team1 != #"neutral" && team2 != #"neutral" && team1 != team2;
}

/*
	Name: remove_unused_spawn_entities
	Namespace: spawning
	Checksum: 0x79C4A0E3
	Offset: 0x2038
	Size: 0x226
	Parameters: 0
	Flags: Linked
*/
function remove_unused_spawn_entities()
{
	spawn_entity_types = [];
	spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
	spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
	spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
	spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
	spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_axis_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_allies_start";
	spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn";
	for(i = 0; i < spawn_entity_types.size; i++)
	{
		if(spawn_point_class_name_being_used(spawn_entity_types[i]))
		{
			continue;
		}
		spawnpoints = spawnlogic::getspawnpointarray(spawn_entity_types[i]);
		delete_all_spawns(spawnpoints);
	}
}

/*
	Name: delete_all_spawns
	Namespace: spawning
	Checksum: 0x3B3BD5C0
	Offset: 0x2268
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function delete_all_spawns(spawnpoints)
{
	for(i = 0; i < spawnpoints.size; i++)
	{
		spawnpoints[i] delete();
	}
}

/*
	Name: spawn_point_class_name_being_used
	Namespace: spawning
	Checksum: 0x8F8D6070
	Offset: 0x22C0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function spawn_point_class_name_being_used(name)
{
	if(!isdefined(level.spawn_point_class_names))
	{
		return false;
	}
	for(i = 0; i < level.spawn_point_class_names.size; i++)
	{
		if(level.spawn_point_class_names[i] == name)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: initialspawnprotection
	Namespace: spawning
	Checksum: 0x1FB4675C
	Offset: 0x2338
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function initialspawnprotection(specialtyname, spawnmonitorspeed)
{
	self endon(#"death", #"disconnect");
	if(!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0)
	{
		return;
	}
	if(specialtyname == "specialty_nottargetedbyairsupport")
	{
		self.specialty_nottargetedbyairsupport = 1;
		wait(level.spawnprotectiontime);
		self.specialty_nottargetedbyairsupport = undefined;
	}
	else if(!self hasperk(specialtyname))
	{
		self setperk(specialtyname);
		wait(level.spawnprotectiontime);
		self unsetperk(specialtyname);
	}
}

