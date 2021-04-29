// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_57ff8cbb;

/*
	Name: function_89f2df9
	Namespace: namespace_57ff8cbb
	Checksum: 0x4C0947BA
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_19815b63228802cb", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_57ff8cbb
	Checksum: 0xBAF6EE60
	Offset: 0x108
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.n_cleanups_processed_this_frame = 0;
	level.var_2125984b = 0;
	level.var_53e4414 = &delete_zombie_noone_looking;
	level.var_fc73bad4 = [];
}

/*
	Name: __main__
	Namespace: namespace_57ff8cbb
	Checksum: 0x1B5B3A42
	Offset: 0x158
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread cleanup_main();
}

/*
	Name: force_check_now
	Namespace: namespace_57ff8cbb
	Checksum: 0x77D9D2AA
	Offset: 0x180
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function force_check_now()
{
	level notify(#"pump_distance_check");
}

/*
	Name: cleanup_main
	Namespace: namespace_57ff8cbb
	Checksum: 0x86041D39
	Offset: 0x1A0
	Size: 0x25C
	Parameters: 0
	Flags: Linked, Private
*/
private function cleanup_main()
{
	level endon(#"end_game");
	n_next_eval = 0;
	while(true)
	{
		util::wait_network_frame();
		n_time = gettime();
		if(n_time < n_next_eval)
		{
			continue;
		}
		if(isdefined(level.n_cleanup_manager_restart_time))
		{
			n_current_time = gettime() / 1000;
			n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
			if(n_delta_time < 0)
			{
				continue;
			}
			level.n_cleanup_manager_restart_time = undefined;
		}
		n_round_time = n_time - level.round_start_time / 1000;
		if(level.round_number <= 5 && n_round_time < 30)
		{
			continue;
		}
		else if(level.round_number > 5 && n_round_time < 20)
		{
			continue;
		}
		n_override_cleanup_dist_sq = undefined;
		if(level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3)
		{
			n_override_cleanup_dist_sq = 2250000;
		}
		n_next_eval = n_next_eval + 3000;
		a_ai_enemies = getaiteamarray(#"axis");
		foreach(ai_enemy in a_ai_enemies)
		{
			if(level.n_cleanups_processed_this_frame >= 1)
			{
				level.n_cleanups_processed_this_frame = 0;
				util::wait_network_frame();
			}
			ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
		}
	}
}

/*
	Name: do_cleanup_check
	Namespace: namespace_57ff8cbb
	Checksum: 0xCE2B4740
	Offset: 0x408
	Size: 0x35C
	Parameters: 1
	Flags: Linked
*/
function do_cleanup_check(n_override_cleanup_dist)
{
	if(!isalive(self))
	{
		return;
	}
	if(self.b_ignore_cleanup === 1)
	{
		return;
	}
	n_time_alive = gettime() - self.spawn_time;
	if(n_time_alive < 5000)
	{
		return;
	}
	if(isdefined(self.var_61c270) && self.var_61c270)
	{
		return;
	}
	if(n_time_alive < 45000 && self.completed_emerging_into_playable_area !== 1 && (!(isdefined(self.var_357c108b) && self.var_357c108b)))
	{
		return;
	}
	b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
	if(isdefined(level.var_11f7a9af) && level.var_11f7a9af)
	{
		var_22295e13 = self zm_zonemgr::get_zone_from_position(self.origin);
		if(isdefined(var_22295e13) && zm_zonemgr::get_players_in_zone(var_22295e13) == 0)
		{
			b_in_active_zone = 0;
		}
	}
	level.n_cleanups_processed_this_frame++;
	if(!b_in_active_zone)
	{
		n_dist_sq_min = 10000000;
		players = getplayers();
		e_closest_player = players[0];
		foreach(player in players)
		{
			if(!isalive(player))
			{
				continue;
			}
			n_dist_sq = distancesquared(self.origin, player.origin);
			if(n_dist_sq < n_dist_sq_min)
			{
				n_dist_sq_min = n_dist_sq;
				e_closest_player = player;
			}
		}
		if(isdefined(n_override_cleanup_dist))
		{
			n_cleanup_dist_sq = n_override_cleanup_dist;
		}
		else if(isdefined(e_closest_player) && player_ahead_of_me(e_closest_player))
		{
			if(self.zombie_move_speed === "walk")
			{
				n_cleanup_dist_sq = (isdefined(level.var_ef05cff5) ? level.var_ef05cff5 : 250000);
			}
			else
			{
				n_cleanup_dist_sq = (isdefined(level.var_18d20774) ? level.var_18d20774 : 189225);
			}
		}
		else
		{
			n_cleanup_dist_sq = (isdefined(level.var_ef05cff5) ? level.var_ef05cff5 : 250000);
		}
		if(n_dist_sq_min >= n_cleanup_dist_sq)
		{
			self thread function_96f7787d();
		}
	}
}

/*
	Name: function_96f7787d
	Namespace: namespace_57ff8cbb
	Checksum: 0x6A7DD8FA
	Offset: 0x770
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
private function function_96f7787d()
{
	self.var_61c270 = 1;
	self delete_zombie_noone_looking();
	if(isdefined(self))
	{
		self.var_61c270 = undefined;
	}
}

/*
	Name: delete_zombie_noone_looking
	Namespace: namespace_57ff8cbb
	Checksum: 0x569231E4
	Offset: 0x7B0
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
private function delete_zombie_noone_looking()
{
	if(isdefined(self.in_the_ground) && self.in_the_ground)
	{
		return;
	}
	if(!self.allowdeath)
	{
		return;
	}
	foreach(player in level.players)
	{
		if(player.sessionstate == "spectator")
		{
			continue;
		}
		if(self player_can_see_me(player))
		{
			return;
		}
	}
	self cleanup_zombie();
}

/*
	Name: function_cdf5a512
	Namespace: namespace_57ff8cbb
	Checksum: 0x125F721A
	Offset: 0x898
	Size: 0x96
	Parameters: 2
	Flags: Linked
*/
function function_cdf5a512(str_archetype, var_7e1eca2)
{
	if(!isdefined(level.var_55a99841))
	{
		level.var_55a99841 = [];
	}
	else if(!isarray(level.var_55a99841))
	{
		level.var_55a99841 = array(level.var_55a99841);
	}
	level.var_55a99841[str_archetype] = var_7e1eca2;
}

/*
	Name: function_9a62cdec
	Namespace: namespace_57ff8cbb
	Checksum: 0xF77EB3D9
	Offset: 0x938
	Size: 0x72
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9a62cdec()
{
	if(!isdefined(level.var_55a99841))
	{
		return 0;
	}
	if(isdefined(self.archetype) && isdefined(level.var_55a99841[self.archetype]))
	{
		var_914aeacb = self [[level.var_55a99841[self.archetype]]]();
		return isdefined(var_914aeacb) && var_914aeacb;
	}
	return 0;
}

/*
	Name: function_39553a7c
	Namespace: namespace_57ff8cbb
	Checksum: 0xCAE81277
	Offset: 0x9B8
	Size: 0xD8
	Parameters: 2
	Flags: Linked
*/
function function_39553a7c(str_archetype, func)
{
	if(!isdefined(level.var_f51ae00f))
	{
		level.var_f51ae00f = [];
	}
	if(!isdefined(level.var_f51ae00f[str_archetype]))
	{
		level.var_f51ae00f[str_archetype] = [];
	}
	else if(!isarray(level.var_f51ae00f[str_archetype]))
	{
		level.var_f51ae00f[str_archetype] = array(level.var_f51ae00f[str_archetype]);
	}
	level.var_f51ae00f[str_archetype][level.var_f51ae00f[str_archetype].size] = func;
}

/*
	Name: function_8327a85d
	Namespace: namespace_57ff8cbb
	Checksum: 0xEE180764
	Offset: 0xA98
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8327a85d(var_3a145c54)
{
	if(isdefined(level.var_f51ae00f) && isdefined(level.var_f51ae00f[self.archetype]))
	{
		foreach(func in level.var_f51ae00f[self.archetype])
		{
			self [[func]](var_3a145c54);
		}
	}
}

/*
	Name: cleanup_zombie
	Namespace: namespace_57ff8cbb
	Checksum: 0xA14CB801
	Offset: 0xB50
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function cleanup_zombie()
{
	if(function_9a62cdec())
	{
		return;
	}
	self function_23621259();
	self zombie_utility::reset_attack_spot();
	self.var_c39323b5 = 1;
	self.var_e700d5e2 = 1;
	self.allowdeath = 1;
	self kill();
	waitframe(1);
	if(isdefined(self))
	{
		/#
			debugstar(self.origin, 1000, (1, 1, 1));
		#/
		self delete();
	}
}

/*
	Name: player_can_see_me
	Namespace: namespace_57ff8cbb
	Checksum: 0x93AEBED1
	Offset: 0xC20
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function player_can_see_me(player)
{
	return !player function_80d68e4d(self, 0.766, 1);
}

/*
	Name: player_ahead_of_me
	Namespace: namespace_57ff8cbb
	Checksum: 0x9F37839D
	Offset: 0xC60
	Size: 0xB0
	Parameters: 1
	Flags: Linked, Private
*/
private function player_ahead_of_me(player)
{
	v_player_angles = player getplayerangles();
	v_player_forward = anglestoforward(v_player_angles);
	v_dir = player getorigin() - self.origin;
	n_dot = vectordot(v_player_forward, v_dir);
	if(n_dot < 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: get_escape_position
	Namespace: namespace_57ff8cbb
	Checksum: 0x63149311
	Offset: 0xD18
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function get_escape_position()
{
	self endon(#"death");
	if(isdefined(self.zone_name))
	{
		str_zone = self.zone_name;
	}
	else
	{
		str_zone = self zm_utility::get_current_zone();
	}
	if(isdefined(str_zone))
	{
		a_zones = get_adjacencies_to_zone(str_zone);
		a_wait_locations = get_wait_locations_in_zones(a_zones);
		s_farthest = self get_farthest_wait_location(a_wait_locations);
	}
	return s_farthest;
}

/*
	Name: get_adjacencies_to_zone
	Namespace: namespace_57ff8cbb
	Checksum: 0x23B0C1D7
	Offset: 0xDE0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function get_adjacencies_to_zone(str_zone)
{
	a_adjacencies = [];
	if(isdefined(str_zone) && isdefined(level.zones[str_zone]))
	{
		a_adjacencies[0] = str_zone;
		a_adjacent_zones = getarraykeys(level.zones[str_zone].adjacent_zones);
		for(i = 0; i < a_adjacent_zones.size; i++)
		{
			if(level.zones[str_zone].adjacent_zones[a_adjacent_zones[i]].is_connected)
			{
				if(!isdefined(a_adjacencies))
				{
					a_adjacencies = [];
				}
				else if(!isarray(a_adjacencies))
				{
					a_adjacencies = array(a_adjacencies);
				}
				a_adjacencies[a_adjacencies.size] = a_adjacent_zones[i];
			}
		}
	}
	return a_adjacencies;
}

/*
	Name: get_wait_locations_in_zones
	Namespace: namespace_57ff8cbb
	Checksum: 0x8D8480DC
	Offset: 0xF10
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function get_wait_locations_in_zones(a_zones)
{
	a_wait_locations = [];
	foreach(zone in a_zones)
	{
		if(isdefined(level.zones[zone].a_loc_types) && isdefined(level.zones[zone].a_loc_types[#"wait_location"]))
		{
			a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
			continue;
		}
		/#
			str_zone = function_9e72a96(zone);
			println("" + str_zone + "");
			iprintln("" + str_zone + "");
		#/
	}
	return a_wait_locations;
}

/*
	Name: get_farthest_wait_location
	Namespace: namespace_57ff8cbb
	Checksum: 0x89006C05
	Offset: 0x1090
	Size: 0x60
	Parameters: 1
	Flags: Linked, Private
*/
private function get_farthest_wait_location(a_wait_locations)
{
	if(!isdefined(a_wait_locations) || a_wait_locations.size == 0)
	{
		return undefined;
	}
	var_16db4a88 = arraysortclosest(a_wait_locations, self.origin);
	return var_16db4a88[var_16db4a88.size - 1];
}

/*
	Name: get_wait_locations_in_zone
	Namespace: namespace_57ff8cbb
	Checksum: 0x84830EFD
	Offset: 0x10F8
	Size: 0x8E
	Parameters: 1
	Flags: Linked, Private
*/
private function get_wait_locations_in_zone(zone)
{
	if(isdefined(level.zones[zone].a_loc_types[#"wait_location"]))
	{
		a_wait_locations = [];
		a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types[#"wait_location"], 0, 0);
		return a_wait_locations;
	}
	return undefined;
}

/*
	Name: get_escape_position_in_current_zone
	Namespace: namespace_57ff8cbb
	Checksum: 0x10907D52
	Offset: 0x1190
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function get_escape_position_in_current_zone()
{
	self endon(#"death");
	str_zone = self.zone_name;
	if(!isdefined(str_zone))
	{
		str_zone = self.zone_name;
	}
	if(isdefined(str_zone))
	{
		a_wait_locations = get_wait_locations_in_zone(str_zone);
		if(isdefined(a_wait_locations))
		{
			s_farthest = self get_farthest_wait_location(a_wait_locations);
		}
	}
	return s_farthest;
}

/*
	Name: no_target_override
	Namespace: namespace_57ff8cbb
	Checksum: 0x38AB72C7
	Offset: 0x1230
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function no_target_override(ai_zombie)
{
	if(!isdefined(ai_zombie.var_cc1c538e))
	{
		ai_zombie.var_cc1c538e = ai_zombie get_escape_position();
		ai_zombie val::set(#"hash_70eb9b26a388505a", "ignoreall", 1);
	}
	if(isdefined(ai_zombie.var_cc1c538e))
	{
		self setgoal(ai_zombie.var_cc1c538e.origin, 0, 32);
	}
	else
	{
		self setgoal(ai_zombie.origin, 0, 32);
	}
}

/*
	Name: function_d22435d9
	Namespace: namespace_57ff8cbb
	Checksum: 0xEBF105AE
	Offset: 0x1310
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_d22435d9(ai_zombie)
{
	ai_zombie.var_cc1c538e = undefined;
	ai_zombie val::reset(#"hash_70eb9b26a388505a", "ignoreall");
}

/*
	Name: function_c6ad3003
	Namespace: namespace_57ff8cbb
	Checksum: 0x4B6FEC2B
	Offset: 0x1358
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function function_c6ad3003(b_timeout = 0)
{
	a_ai_enemies = getaiteamarray(#"axis");
	foreach(ai_enemy in a_ai_enemies)
	{
		if(!isalive(ai_enemy))
		{
			continue;
		}
		else if(b_timeout && (isdefined(ai_enemy.var_126d7bef) && ai_enemy.var_126d7bef))
		{
			continue;
		}
		else if(!b_timeout && (isdefined(ai_enemy.b_ignore_cleanup) && ai_enemy.b_ignore_cleanup))
		{
			continue;
		}
		if(!ai_enemy.allowdeath)
		{
			continue;
		}
		ai_enemy function_23621259(1);
		ai_enemy zombie_utility::reset_attack_spot();
		ai_enemy.var_c39323b5 = 1;
		ai_enemy kill();
		waitframe(1);
	}
}

/*
	Name: function_23621259
	Namespace: namespace_57ff8cbb
	Checksum: 0xA3462267
	Offset: 0x14F8
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function function_23621259(var_3a145c54 = 0)
{
	if(isalive(self) && (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)))
	{
		if(var_3a145c54)
		{
			level.var_2125984b++;
		}
		else
		{
			level.zombie_total++;
			level.zombie_respawns++;
			level.zombie_total_subtract++;
		}
		if(!isdefined(self.maxhealth))
		{
			self.maxhealth = self.health;
		}
		if(self.health < self.maxhealth || (isdefined(self.var_bd2c55ef) && self.var_bd2c55ef))
		{
			var_1a8c05ae = {#hash_e0d660f6:self.var_e0d660f6, #n_health:self.health};
			if(!isdefined(level.var_fc73bad4[self.archetype]))
			{
				level.var_fc73bad4[self.archetype] = [];
			}
			else if(!isarray(level.var_fc73bad4[self.archetype]))
			{
				level.var_fc73bad4[self.archetype] = array(level.var_fc73bad4[self.archetype]);
			}
			level.var_fc73bad4[self.archetype][level.var_fc73bad4[self.archetype].size] = var_1a8c05ae;
		}
		self function_8327a85d(var_3a145c54);
	}
}

/*
	Name: function_aa5726f2
	Namespace: namespace_57ff8cbb
	Checksum: 0x4D81A184
	Offset: 0x16F0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_aa5726f2()
{
	if(isdefined(level.var_fc73bad4[self.archetype]) && level.var_fc73bad4[self.archetype].size > 0)
	{
		var_1a8c05ae = level.var_fc73bad4[self.archetype][0];
		self.health = var_1a8c05ae.n_health;
		if(isdefined(var_1a8c05ae.var_e0d660f6))
		{
			foreach(var_40783d81 in var_1a8c05ae.var_e0d660f6)
			{
				self [[var_40783d81]]();
			}
		}
		arrayremovevalue(level.var_fc73bad4[self.archetype], var_1a8c05ae);
	}
}

