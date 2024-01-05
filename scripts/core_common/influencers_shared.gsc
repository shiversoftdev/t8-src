// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace influencers;

/*
	Name: __init__system__
	Namespace: influencers
	Checksum: 0xD806C429
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"influencers_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: influencers
	Checksum: 0xA71CA70B
	Offset: 0x138
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.var_3d984b4c))
	{
		level.var_3d984b4c = 1;
	}
	if(level.var_3d984b4c)
	{
		callback::on_connecting(&onplayerconnect);
		callback::on_joined_team(&on_joined_team);
		callback::on_spawned(&onplayerspawned);
	}
}

/*
	Name: onplayerspawned
	Namespace: influencers
	Checksum: 0x5F8C42B
	Offset: 0x1D0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function onplayerspawned()
{
	removeallinfluencersfromentity(self);
	self create_player_influencers();
}

/*
	Name: onplayerconnect
	Namespace: influencers
	Checksum: 0x85A634BE
	Offset: 0x210
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function onplayerconnect()
{
	level endon(#"game_ended");
	self callback::on_grenade_fired(&on_grenade_fired);
	self callback::on_death(&on_player_death);
}

/*
	Name: on_player_death
	Namespace: influencers
	Checksum: 0xABDDFBBF
	Offset: 0x278
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function on_player_death(params)
{
	if(game.state != "playing")
	{
		return;
	}
	level create_friendly_influencer("friend_dead", self.origin, self.team);
}

/*
	Name: on_joined_team
	Namespace: influencers
	Checksum: 0x9B800EE
	Offset: 0x2D8
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function on_joined_team(params)
{
	self.lastspawnpoint = undefined;
}

/*
	Name: on_grenade_fired
	Namespace: influencers
	Checksum: 0x9F5C575F
	Offset: 0x2F8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function on_grenade_fired(params)
{
	grenade = params.projectile;
	weapon = params.weapon;
	level thread create_grenade_influencers(self.pers[#"team"], weapon, grenade);
}

/*
	Name: get_friendly_team_mask
	Namespace: influencers
	Checksum: 0xDAB27C90
	Offset: 0x378
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
	Namespace: influencers
	Checksum: 0xCC63BA13
	Offset: 0x3D8
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
	Name: add_influencer_tracker
	Namespace: influencers
	Checksum: 0x50E9677
	Offset: 0x438
	Size: 0xF0
	Parameters: 2
	Flags: Linked, Private
*/
function private add_influencer_tracker(influencer, name)
{
	if(!isdefined(self.influencers))
	{
		self.influencers = [];
	}
	if(!isdefined(self.influencers[name]))
	{
		self.influencers[name] = [];
	}
	if(!isdefined(self.influencers[name]))
	{
		self.influencers[name] = [];
	}
	else if(!isarray(self.influencers[name]))
	{
		self.influencers[name] = array(self.influencers[name]);
	}
	self.influencers[name][self.influencers[name].size] = influencer;
}

/*
	Name: create_influencer_generic
	Namespace: influencers
	Checksum: 0x1866F88E
	Offset: 0x530
	Size: 0x168
	Parameters: 4
	Flags: None
*/
function create_influencer_generic(str_name, origin_or_entity, str_team, is_for_enemy = 0)
{
	if(str_team === #"any")
	{
		team_mask = level.spawnsystem.ispawn_teammask[#"all"];
	}
	else
	{
		if(is_for_enemy)
		{
			team_mask = self get_enemy_team_mask(str_team);
		}
		else
		{
			team_mask = self get_friendly_team_mask(str_team);
		}
	}
	if(isentity(origin_or_entity))
	{
		influencer = addentityinfluencer(str_name, origin_or_entity, team_mask);
	}
	else if(isvec(origin_or_entity))
	{
		influencer = addinfluencer(str_name, origin_or_entity, team_mask);
	}
	if(!isentity(origin_or_entity))
	{
		self add_influencer_tracker(influencer, str_name);
	}
	return influencer;
}

/*
	Name: create_influencer
	Namespace: influencers
	Checksum: 0x1EFF53DF
	Offset: 0x6A0
	Size: 0x3A
	Parameters: 3
	Flags: Linked
*/
function create_influencer(name, origin, team_mask)
{
	return addinfluencer(name, origin, team_mask);
}

/*
	Name: create_friendly_influencer
	Namespace: influencers
	Checksum: 0x3DFCF016
	Offset: 0x6E8
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function create_friendly_influencer(name, origin, team)
{
	team_mask = self get_friendly_team_mask(team);
	influencer = create_influencer(name, origin, team_mask);
	return influencer;
}

/*
	Name: create_enemy_influencer
	Namespace: influencers
	Checksum: 0xC6A67494
	Offset: 0x760
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function create_enemy_influencer(name, origin, team)
{
	team_mask = self get_enemy_team_mask(team);
	influencer = create_influencer(name, origin, team_mask);
	return influencer;
}

/*
	Name: create_entity_influencer
	Namespace: influencers
	Checksum: 0x304823FA
	Offset: 0x7D8
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function create_entity_influencer(name, team_mask)
{
	return addentityinfluencer(name, self, team_mask);
}

/*
	Name: function_f15009ad
	Namespace: influencers
	Checksum: 0x786F3272
	Offset: 0x810
	Size: 0x3A
	Parameters: 3
	Flags: None
*/
function function_f15009ad(name, origin, var_f317c70c)
{
	return function_a116c91b(name, origin, var_f317c70c);
}

/*
	Name: create_entity_friendly_influencer
	Namespace: influencers
	Checksum: 0xBDBE7D95
	Offset: 0x858
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function create_entity_friendly_influencer(name, team)
{
	team_mask = self get_friendly_team_mask(team);
	return self create_entity_influencer(name, team_mask);
}

/*
	Name: create_entity_enemy_influencer
	Namespace: influencers
	Checksum: 0x7C21FA7F
	Offset: 0x8B8
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function create_entity_enemy_influencer(name, team)
{
	team_mask = self get_enemy_team_mask(team);
	return self create_entity_influencer(name, team_mask);
}

/*
	Name: create_player_influencers
	Namespace: influencers
	Checksum: 0xECB5472E
	Offset: 0x918
	Size: 0x1D2
	Parameters: 0
	Flags: Linked
*/
function create_player_influencers()
{
	if(!isdefined(self.pers[#"team"]) || self.pers[#"team"] == #"spectator")
	{
		return;
	}
	if(self.influencers_created === 0)
	{
		return;
	}
	if(!level.teambased)
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
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
	self create_entity_influencer("enemy", enemy_teams_mask);
	if(level.teambased)
	{
		self create_entity_influencer("friend", team_mask);
	}
	self.influencers_created = 1;
}

/*
	Name: create_player_spawn_influencers
	Namespace: influencers
	Checksum: 0xA375FA43
	Offset: 0xAF8
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function create_player_spawn_influencers(spawn_origin)
{
	level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers[#"team"]);
	level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers[#"team"]);
}

/*
	Name: remove_influencer_tracking
	Namespace: influencers
	Checksum: 0x86524EBB
	Offset: 0xB80
	Size: 0x90
	Parameters: 1
	Flags: Linked, Private
*/
function private remove_influencer_tracking(to_be_removed)
{
	if(isdefined(self.influencers))
	{
		foreach(influencer_name_array in self.influencers)
		{
			arrayremovevalue(influencer_name_array, to_be_removed);
		}
	}
}

/*
	Name: is_influencer_tracked
	Namespace: influencers
	Checksum: 0x763F31AC
	Offset: 0xC18
	Size: 0x9A
	Parameters: 1
	Flags: Linked, Private
*/
function private is_influencer_tracked(influencer)
{
	if(isdefined(self.influencers))
	{
		foreach(influencer_name_array in self.influencers)
		{
			if(isinarray(influencer_name_array, influencer))
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: remove_influencer
	Namespace: influencers
	Checksum: 0x29013508
	Offset: 0xCC0
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function remove_influencer(to_be_removed)
{
	if(is_influencer_tracked(to_be_removed))
	{
		self remove_influencer_tracking(to_be_removed);
	}
	removeinfluencer(to_be_removed);
}

/*
	Name: remove_influencers
	Namespace: influencers
	Checksum: 0x6DC23EE6
	Offset: 0xD20
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function remove_influencers()
{
	if(!isdefined(self))
	{
		return;
	}
	if(isentity(self))
	{
		removeallinfluencersfromentity(self);
	}
	else if(isdefined(self.influencers))
	{
		foreach(influencer_name_array in self.influencers)
		{
			foreach(influencer in influencer_name_array)
			{
				self remove_influencer_tracking(influencer);
				removeinfluencer(influencer);
			}
		}
	}
	self.influencers = [];
}

/*
	Name: create_grenade_influencers
	Namespace: influencers
	Checksum: 0x84DBB377
	Offset: 0xE70
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function create_grenade_influencers(parent_team, weapon, grenade)
{
	pixbeginevent(#"create_grenade_influencers");
	spawn_influencer = weapon.spawninfluencer;
	if(isdefined(grenade.origin) && spawn_influencer != "" && isdefined(level.spawnsystem))
	{
		if(!level.teambased || !isdefined(parent_team))
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
		grenade create_entity_influencer(spawn_influencer, weapon_team_mask);
	}
	pixendevent();
}

/*
	Name: create_map_placed_influencers
	Namespace: influencers
	Checksum: 0x605B9B15
	Offset: 0xFA8
	Size: 0x7E
	Parameters: 0
	Flags: None
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
	Namespace: influencers
	Checksum: 0x4A7665F9
	Offset: 0x1030
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
	Name: create_turret_influencer
	Namespace: influencers
	Checksum: 0x6CF771D8
	Offset: 0x10D8
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function create_turret_influencer(name)
{
	turret = self;
	preset = getinfluencerpreset(name);
	if(!isdefined(preset))
	{
		return;
	}
	projected_point = turret.origin + (vectorscale(anglestoforward(turret.angles), preset[#"radius"] * 0.7));
	return create_enemy_influencer(name, turret.origin, turret.team);
}

