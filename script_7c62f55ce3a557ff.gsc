// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm\ai\zm_ai_brutus.gsc;
#using script_41fe08c37d53a635;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\archetype_brutus.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace zombie_brutus_util;

/*
	Name: __init__system__
	Namespace: zombie_brutus_util
	Checksum: 0x64D26825
	Offset: 0x2D8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zombie_brutus_util", &__init__, &__main__, #"zm_ai_brutus");
}

/*
	Name: __init__
	Namespace: zombie_brutus_util
	Checksum: 0x153B769E
	Offset: 0x338
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "brutus_lock_down", 1, 1, "int");
	level.var_d668eae7 = getentarray("brutus_zombie_spawner", "script_noteworthy");
	if(level.var_d668eae7.size == 0)
	{
		/#
			assertmsg("");
		#/
		return;
	}
	/#
		thread function_60f8374c();
	#/
	level flag::init("brutus_setup_complete");
}

/*
	Name: __main__
	Namespace: zombie_brutus_util
	Checksum: 0x47905BBC
	Offset: 0x408
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread enable_brutus();
}

/*
	Name: enable_brutus
	Namespace: zombie_brutus_util
	Checksum: 0x8A53CA4D
	Offset: 0x430
	Size: 0x346
	Parameters: 0
	Flags: Linked
*/
function enable_brutus()
{
	array::thread_all(level.var_d668eae7, &spawner::add_spawn_function, &brutus_prespawn);
	for(i = 0; i < level.var_d668eae7.size; i++)
	{
		level.var_d668eae7[i].is_enabled = 1;
		level.var_d668eae7[i].script_forcespawn = 1;
	}
	level.var_57d61da9 = struct::get_array("brutus_location", "script_noteworthy");
	level.var_361ec6d1 = 0;
	level.brutus_health = 500;
	level.brutus_round_count = 0;
	level.var_152c591 = 1;
	level.brutus_last_spawn_round = 0;
	level.brutus_count = 0;
	level.brutus_max_count = 4;
	level.brutus_damage_percent = 0.1;
	level.brutus_team_points_for_death = 500;
	level.brutus_player_points_for_death = 250;
	level.brutus_points_for_helmet = 250;
	level.brutus_alarm_chance = 100;
	level.brutus_min_alarm_chance = 100;
	level.brutus_alarm_chance_increment = 10;
	level.brutus_max_alarm_chance = 200;
	level.brutus_min_round_fq = 4;
	level.brutus_max_round_fq = 7;
	if(zm_utility::is_standard())
	{
		level.brutus_min_round_fq = 8;
		level.brutus_max_round_fq = 12;
	}
	level.brutus_zombie_per_round = 1;
	level.brutus_players_in_zone_spawn_point_cap = 120;
	level.var_a33d6e46 = 0;
	level.brutus_min_pulls_between_box_spawns = 4;
	level.brutus_explosive_damage_increase = 600;
	level.brutus_failed_paths_to_teleport = 4;
	level.brutus_do_prologue = 1;
	level.brutus_min_spawn_delay = 10;
	level.brutus_max_spawn_delay = 60;
	level.brutus_respawn_after_despawn = 1;
	level.brutus_in_grief = 0;
	if(level.scr_zm_ui_gametype == "zgrief")
	{
		level.brutus_in_grief = 1;
	}
	level.brutus_custom_goalradius = 48;
	level thread brutus_spawning_logic();
	if(!level.brutus_in_grief)
	{
		level.custom_perk_validation = &check_perk_machine_valid;
		level.custom_craftable_validation = &check_craftable_table_valid;
	}
}

/*
	Name: brutus_prespawn
	Namespace: zombie_brutus_util
	Checksum: 0x80F724D1
	Offset: 0x780
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function brutus_prespawn()
{
}

/*
	Name: brutus_spawning_logic
	Namespace: zombie_brutus_util
	Checksum: 0x45AE6285
	Offset: 0x790
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function brutus_spawning_logic()
{
	if(level.brutus_in_grief || (isdefined(level.var_153e9058) && level.var_153e9058) || (isdefined(level.var_a2831281) && level.var_a2831281))
	{
		return;
	}
	level thread enable_brutus_rounds();
	level thread function_6340fe2();
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"spawn_brutus");
		n_spawn = s_result.n_spawn;
		if(n_spawn > 1)
		{
			level thread function_f332f2b7(n_spawn, s_result.str_zone_name, s_result.var_dde9ff11, s_result.var_68ffecfb);
		}
		else
		{
			ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);
			if(isalive(ai_brutus))
			{
				if(isdefined(s_result.var_68ffecfb) && s_result.var_68ffecfb)
				{
					var_1a8c05ae = thread function_9398e511();
					if(isdefined(var_1a8c05ae))
					{
						ai_brutus thread brutus_spawn(var_1a8c05ae.n_health, var_1a8c05ae.var_37d3fab9, var_1a8c05ae.var_1e1ce722, var_1a8c05ae.var_72275733, s_result.str_zone_name);
					}
				}
				else
				{
					ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, s_result.str_zone_name);
				}
				if(!(isdefined(s_result.var_dde9ff11) && s_result.var_dde9ff11) && (!(isdefined(level.var_779eb5f5) && level.var_779eb5f5)) && isalive(ai_brutus))
				{
					ai_brutus playsound(#"zmb_ai_brutus_spawn_2d");
				}
			}
		}
	}
}

/*
	Name: function_f332f2b7
	Namespace: zombie_brutus_util
	Checksum: 0x321D4C2C
	Offset: 0xA38
	Size: 0x1F0
	Parameters: 4
	Flags: Linked, Private
*/
function private function_f332f2b7(n_spawn, str_zone_name, var_dde9ff11, var_68ffecfb)
{
	level endon(#"end_of_round", #"end_game");
	var_33882d9b = 0;
	while(var_33882d9b < n_spawn)
	{
		ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);
		if(isdefined(ai_brutus))
		{
			if(isdefined(var_68ffecfb) && var_68ffecfb)
			{
				var_1a8c05ae = thread function_9398e511();
				if(isdefined(var_1a8c05ae))
				{
					ai_brutus thread brutus_spawn(var_1a8c05ae.n_health, var_1a8c05ae.var_37d3fab9, var_1a8c05ae.var_1e1ce722, var_1a8c05ae.var_72275733, str_zone_name);
				}
			}
			else
			{
				ai_brutus thread brutus_spawn(undefined, undefined, undefined, undefined, str_zone_name);
			}
			if(!(isdefined(var_dde9ff11) && var_dde9ff11))
			{
				playsoundatposition(#"zmb_ai_brutus_spawn_2d", (0, 0, 0));
			}
			var_33882d9b++;
		}
		if(isdefined(level.var_152c591) && level.var_152c591 && (!(isdefined(level.var_a2831281) && level.var_a2831281)))
		{
			wait(randomfloatrange(15, 45));
		}
		util::wait_network_frame();
	}
}

/*
	Name: zombie_setup_attack_properties
	Namespace: zombie_brutus_util
	Checksum: 0x5C9A01AC
	Offset: 0xC30
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function zombie_setup_attack_properties()
{
	self val::reset(#"attack_properties", "ignoreall");
	self.meleeattackdist = 64;
	self.maxsightdistsqrd = 16384;
	self.disablearrivals = 1;
	self.disableexits = 1;
}

/*
	Name: brutus_spawn
	Namespace: zombie_brutus_util
	Checksum: 0x8610BDF6
	Offset: 0xC98
	Size: 0x5CE
	Parameters: 5
	Flags: Linked
*/
function brutus_spawn(starting_health, has_helmet, helmet_hits, explosive_dmg_taken, zone_name)
{
	self endon(#"death");
	level.var_a33d6e46 = 0;
	self.has_helmet = (isdefined(has_helmet) ? 1 : has_helmet);
	self.helmet_hits = (isdefined(helmet_hits) ? 0 : helmet_hits);
	self.explosive_dmg_taken = (isdefined(explosive_dmg_taken) ? 0 : explosive_dmg_taken);
	if(isdefined(starting_health))
	{
		self.starting_health = starting_health;
		self.health = starting_health;
		self.maxhealth = starting_health;
	}
	self.no_damage_points = 1;
	self.no_powerups = 1;
	self endon(#"death");
	level endon(#"intermission");
	self.animname = "brutus_zombie";
	self.audio_type = "brutus";
	self.has_legs = 1;
	self.is_brutus = 1;
	if(!(isdefined(level.var_f300b600) && level.var_f300b600))
	{
		self.ignore_enemy_count = 1;
	}
	self.var_db8b3627 = 0;
	self.custom_item_dmg = 1000;
	self.brutus_lockdown_state = 0;
	self setphysparams(20, 0, 60);
	self.zombie_init_done = 1;
	self notify(#"zombie_init_done");
	self.allowpain = 0;
	self animmode("normal");
	self orientmode("face enemy");
	self zombie_setup_attack_properties();
	self setfreecameralockonallowed(0);
	level thread zm_spawner::zombie_death_event(self);
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	if(!isdefined(zone_name))
	{
		a_str_active_zones = zm_zonemgr::get_active_zone_names();
		foreach(str_zone in a_str_active_zones)
		{
			spawn_pos = get_best_brutus_spawn_pos(str_zone);
			if(isdefined(spawn_pos))
			{
				zone_name = str_zone;
				break;
			}
		}
	}
	else
	{
		spawn_pos = get_best_brutus_spawn_pos(zone_name);
		if(!isdefined(spawn_pos))
		{
			a_str_active_zones = zm_zonemgr::get_active_zone_names();
			foreach(str_zone in a_str_active_zones)
			{
				spawn_pos = get_best_brutus_spawn_pos(str_zone);
				if(isdefined(spawn_pos))
				{
					break;
				}
			}
		}
	}
	if(!isdefined(spawn_pos))
	{
		if(!isdefined(zone_name))
		{
			zone_name = "undefined zone";
		}
		self delete();
		level notify(#"brutus_spawn_failed");
		return;
	}
	if(!isdefined(spawn_pos.angles))
	{
		spawn_pos.angles = (0, 0, 0);
	}
	if(isdefined(level.brutus_do_prologue) && level.brutus_do_prologue)
	{
		self brutus_spawn_prologue(spawn_pos);
	}
	if(!self.has_helmet)
	{
		self detach("c_t8_zmb_mob_brutus_helmet");
	}
	level.brutus_count++;
	self thread brutus_death();
	self thread brutus_check_zone();
	self thread brutus_watch_enemy();
	self forceteleport(spawn_pos.origin, spawn_pos.angles);
	self thread brutus_lockdown_client_effects(0.5);
	self thread zombie_utility::delayed_zombie_eye_glow();
	level notify(#"brutus_spawned", {#ai_brutus:self});
	util::wait_network_frame();
	self callback::callback(#"hash_6f9c2499f805be2f");
	if(isdefined(level.var_779eb5f5) && level.var_779eb5f5)
	{
		return;
	}
}

/*
	Name: get_best_brutus_spawn_pos
	Namespace: zombie_brutus_util
	Checksum: 0x7A8F6248
	Offset: 0x1270
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function get_best_brutus_spawn_pos(zone_name)
{
	val = 0;
	for(i = 0; i < level.var_57d61da9.size; i++)
	{
		if(isdefined(zone_name) && level.var_57d61da9[i].zone_name != zone_name)
		{
			a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);
			if(a_players_in_zone.size)
			{
				continue;
			}
		}
		if(isdefined(level.var_8b4ac110))
		{
			var_2a291abf = level.var_8b4ac110;
		}
		else
		{
			var_2a291abf = 412;
		}
		e_player_closest = arraygetclosest(level.var_57d61da9[i].origin, level.players, var_2a291abf);
		if(isdefined(e_player_closest))
		{
			continue;
		}
		newval = get_brutus_spawn_pos_val(level.var_57d61da9[i]);
		if(newval > val)
		{
			val = newval;
			pos_idx = i;
		}
	}
	if(isdefined(pos_idx))
	{
		return level.var_57d61da9[pos_idx];
	}
	return undefined;
}

/*
	Name: get_brutus_spawn_pos_val
	Namespace: zombie_brutus_util
	Checksum: 0xBE50AEF8
	Offset: 0x1408
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function get_brutus_spawn_pos_val(brutus_pos)
{
	n_score = 0;
	zone_name = brutus_pos.zone_name;
	if(!zm_zonemgr::zone_is_enabled(zone_name))
	{
		return 0;
	}
	if(!level.zones[zone_name].is_active)
	{
		return 0;
	}
	a_players_in_zone = zm_zonemgr::get_players_in_zone(zone_name, 1);
	n_score_addition = 1;
	for(i = 0; i < a_players_in_zone.size; i++)
	{
		if(self findpath(brutus_pos.origin, a_players_in_zone[i].origin, 0, 0))
		{
			n_dist = distance2d(brutus_pos.origin, a_players_in_zone[i].origin);
			n_score_addition = n_score_addition + math::linear_map(n_dist, 128, 4016, 0, level.brutus_players_in_zone_spawn_point_cap);
		}
	}
	if(n_score_addition > level.brutus_players_in_zone_spawn_point_cap)
	{
		n_score_addition = level.brutus_players_in_zone_spawn_point_cap;
	}
	n_score = n_score + n_score_addition;
	return n_score;
}

/*
	Name: brutus_spawn_prologue
	Namespace: zombie_brutus_util
	Checksum: 0x59CF2594
	Offset: 0x15A8
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function brutus_spawn_prologue(spawn_pos)
{
	playsoundatposition(#"zmb_ai_brutus_prespawn", spawn_pos.origin);
	wait(3);
}

/*
	Name: function_6340fe2
	Namespace: zombie_brutus_util
	Checksum: 0xE4C22509
	Offset: 0x15F0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function function_6340fe2()
{
	level flag::wait_till("start_zombie_round_logic");
	if(isdefined(level.chests))
	{
		for(i = 0; i < level.chests.size; i++)
		{
			level.chests[i] thread wait_on_box_alarm();
		}
	}
}

/*
	Name: enable_brutus_rounds
	Namespace: zombie_brutus_util
	Checksum: 0xCD265544
	Offset: 0x1678
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function enable_brutus_rounds()
{
	level.brutus_rounds_enabled = 1;
	level flag::init("brutus_round");
	level thread brutus_round_tracker();
}

/*
	Name: brutus_round_tracker
	Namespace: zombie_brutus_util
	Checksum: 0xFB7F8378
	Offset: 0x16C8
	Size: 0x2A2
	Parameters: 0
	Flags: Linked
*/
function brutus_round_tracker()
{
	level.next_brutus_round = level.round_number + randomintrange(level.brutus_min_round_fq, level.brutus_max_round_fq);
	old_spawn_func = level.round_spawn_func;
	old_wait_func = level.round_wait_func;
	while(true)
	{
		level waittill(#"between_round_over");
		players = getplayers();
		if(isdefined(level.next_dog_round) && level.next_dog_round == level.next_brutus_round)
		{
			level.next_brutus_round = level.next_brutus_round + 2;
		}
		if(level.round_number < 6 && (isdefined(level.is_forever_solo_game) && level.is_forever_solo_game) && (!(isdefined(level.var_cab8d080) && level.var_cab8d080)))
		{
			if(level.next_brutus_round < 6)
			{
				level.next_brutus_round = 6;
			}
			continue;
		}
		else
		{
			if(zm_utility::is_standard() && (!(isdefined(level.var_42cd50b3) && level.var_42cd50b3)) && (!(isdefined(level.var_cab8d080) && level.var_cab8d080)))
			{
				continue;
			}
			else if(level.next_brutus_round <= level.round_number)
			{
				if(isdefined(level.var_cab8d080) && level.var_cab8d080)
				{
					level.var_cab8d080 = undefined;
				}
				else
				{
					wait(randomfloatrange(level.brutus_min_spawn_delay, level.brutus_max_spawn_delay));
				}
				if(attempt_brutus_spawn(function_7265bed3()))
				{
					level.music_round_override = 1;
					level.next_brutus_round = level.round_number + randomintrange(level.brutus_min_round_fq, level.brutus_max_round_fq);
				}
			}
		}
	}
}

/*
	Name: function_7265bed3
	Namespace: zombie_brutus_util
	Checksum: 0xCF550378
	Offset: 0x1978
	Size: 0x76
	Parameters: 0
	Flags: Linked, Private
*/
function private function_7265bed3()
{
	if(level.round_number >= 30)
	{
		level.brutus_zombie_per_round = 4;
	}
	else
	{
		if(level.round_number >= 25)
		{
			level.brutus_zombie_per_round = 3;
		}
		else if(level.round_number >= 17)
		{
			level.brutus_zombie_per_round = 2;
		}
	}
	return level.brutus_zombie_per_round;
}

/*
	Name: brutus_round_spawn_failsafe_respawn
	Namespace: zombie_brutus_util
	Checksum: 0xDD77D90B
	Offset: 0x19F8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function brutus_round_spawn_failsafe_respawn()
{
	while(true)
	{
		wait(2);
		if(attempt_brutus_spawn(1))
		{
			break;
		}
	}
}

/*
	Name: attempt_brutus_spawn
	Namespace: zombie_brutus_util
	Checksum: 0x72929065
	Offset: 0x1A38
	Size: 0x13C
	Parameters: 4
	Flags: Linked
*/
function attempt_brutus_spawn(n_spawn_num, str_zone_name, var_dde9ff11 = 0, var_68ffecfb = 0)
{
	if((level.brutus_count + n_spawn_num) > level.brutus_max_count && (!(isdefined(level.var_a2831281) && level.var_a2831281)) || (isdefined(level.var_153e9058) && level.var_153e9058))
	{
		/#
			iprintln("");
		#/
		level thread function_5e4d2f31();
		return false;
	}
	level notify(#"spawn_brutus", {#hash_68ffecfb:var_68ffecfb, #hash_dde9ff11:var_dde9ff11, #str_zone_name:str_zone_name, #n_spawn:n_spawn_num});
	return true;
}

/*
	Name: function_5e4d2f31
	Namespace: zombie_brutus_util
	Checksum: 0xAF2AD1EE
	Offset: 0x1B80
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function function_5e4d2f31()
{
	waitframe(1);
	level notify(#"brutus_spawn_failed");
}

/*
	Name: brutus_death
	Namespace: zombie_brutus_util
	Checksum: 0xCFC8E1FF
	Offset: 0x1BA8
	Size: 0x806
	Parameters: 0
	Flags: Linked
*/
function brutus_death()
{
	self endon(#"brutus_cleanup");
	self thread brutus_cleanup();
	if(level.brutus_in_grief)
	{
		self thread brutus_cleanup_at_end_of_grief_round();
	}
	s_result = undefined;
	s_result = self waittill(#"death");
	if(isdefined(s_result.weapon) && (s_result.weapon == getweapon(#"ww_blundergat_t8") || s_result.weapon == getweapon(#"ww_blundergat_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8") || s_result.weapon == getweapon(#"ww_blundergat_fire_t8_upgraded") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded") || s_result.weapon == getweapon(#"hash_494f5501b3f8e1e9")) && isplayer(s_result.attacker))
	{
		s_result.attacker notify(#"hash_2e36f5f4d9622bb3", {#weapon:s_result.weapon});
	}
	level.brutus_count--;
	if(zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0)
	{
		level.last_brutus_origin = self.origin;
		level notify(#"last_brutus_down");
		if(isdefined(self.brutus_round_spawn_failsafe) && self.brutus_round_spawn_failsafe)
		{
			level.next_brutus_round = level.round_number + 1;
		}
	}
	else if(isdefined(self.brutus_round_spawn_failsafe) && self.brutus_round_spawn_failsafe)
	{
		level.zombie_total++;
		level.zombie_total_subtract++;
		level thread brutus_round_spawn_failsafe_respawn();
	}
	var_1982af82 = 0;
	a_s_blueprints = zm_crafting::function_31d883d7();
	foreach(s_blueprint in a_s_blueprints)
	{
		if(s_blueprint.var_54a97edd == getweapon(#"zhield_spectral_dw"))
		{
			var_1982af82 = 1;
			break;
		}
	}
	if(isdefined(level.crafting_components[#"hash_1e5657f6a6f09389"]) && (!(isdefined(var_1982af82) && var_1982af82)))
	{
		w_component = zm_crafting::get_component(#"hash_1e5657f6a6f09389");
		if(!zm_items::player_has(level.players[0], w_component) && (!(isdefined(self.var_eebea220) && self.var_eebea220)) && !level flag::get("round_reset"))
		{
			self.var_db8b3627 = 1;
			self thread function_4621cb04(w_component);
		}
	}
	if(!(isdefined(self.var_db8b3627) && self.var_db8b3627))
	{
		if(!(isdefined(level.global_brutus_powerup_prevention) && level.global_brutus_powerup_prevention))
		{
			if(level.powerup_drop_count >= level.zombie_vars[#"zombie_powerup_drop_max_per_round"])
			{
				level.powerup_drop_count = level.zombie_vars[#"zombie_powerup_drop_max_per_round"] - 1;
			}
			var_1f8ae158 = groundtrace(self.origin + vectorscale((0, 0, 1), 8), self.origin + (vectorscale((0, 0, -1), 100000)), 0, self)[#"position"];
			level thread zm_powerups::powerup_drop(var_1f8ae158, undefined, 0);
		}
	}
	if(isplayer(self.attacker))
	{
		event = "death";
		if(level.brutus_in_grief)
		{
			team_points = level.brutus_team_points_for_death;
			player_points = level.brutus_player_points_for_death;
			a_players = getplayers(self.team);
		}
		else
		{
			multiplier = zm_score::get_points_multiplier(self.attacker);
			team_points = multiplier * zm_utility::round_up_score(level.brutus_team_points_for_death, 5);
			player_points = multiplier * zm_utility::round_up_score(level.brutus_player_points_for_death, 5);
			a_players = getplayers();
		}
		foreach(player in a_players)
		{
			if(!zm_utility::is_player_valid(player))
			{
				continue;
			}
			player zm_score::add_to_player_score(team_points);
			if(player == self.attacker)
			{
				player zm_score::add_to_player_score(player_points);
				level notify(#"brutus_killed", {#player:player});
			}
			player.pers[#"score"] = player.score;
			player zm_stats::increment_client_stat("prison_brutus_killed", 0);
		}
	}
	self notify(#"brutus_cleanup");
}

/*
	Name: function_4621cb04
	Namespace: zombie_brutus_util
	Checksum: 0x4BFE8379
	Offset: 0x23B8
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_4621cb04(w_component)
{
	var_70f6878b = groundtrace(self.origin + vectorscale((0, 0, 1), 8), self.origin + (vectorscale((0, 0, -1), 100000)), 0, self)[#"position"];
	mdl_key = util::spawn_model(w_component.worldmodel, var_70f6878b + vectorscale((0, 0, 1), 36), self.angles);
	mdl_key endon(#"death");
	w_item = zm_items::spawn_item(w_component, var_70f6878b + vectorscale((0, 0, 1), 12), self.angles);
	w_item ghost();
	mdl_key thread function_f57a7d55(w_item);
	mdl_key thread function_69740610(w_item);
	while(isdefined(w_item))
	{
		wait(0.25);
	}
	mdl_key delete();
}

/*
	Name: function_f57a7d55
	Namespace: zombie_brutus_util
	Checksum: 0xEEAC69B5
	Offset: 0x2530
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_f57a7d55(w_item)
{
	self endon(#"death");
	self clientfield::set("powerup_fx", 2);
	while(isdefined(w_item))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = math::clamp(randomint(360), 60, 300);
		yaw = self.angles[1] + yaw;
		new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
		self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		wait(randomfloat(waittime - 0.1));
	}
}

/*
	Name: function_69740610
	Namespace: zombie_brutus_util
	Checksum: 0x7B95C8A7
	Offset: 0x26A0
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_69740610(w_item)
{
	self endon(#"death");
	wait(15);
	for(i = 0; i < 40; i++)
	{
		if(i % 2)
		{
			self ghost();
		}
		else
		{
			self show();
		}
		if(i < 15)
		{
			wait(0.5);
			continue;
		}
		if(i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self clientfield::set("powerup_grabbed_fx", 2);
	util::wait_network_frame();
	if(isdefined(w_item))
	{
		w_item delete();
	}
}

/*
	Name: brutus_cleanup
	Namespace: zombie_brutus_util
	Checksum: 0x573003D4
	Offset: 0x27C0
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function brutus_cleanup()
{
	self waittill(#"brutus_cleanup");
	level.var_361ec6d1 = 0;
	if(isdefined(self.sndbrutusmusicent))
	{
		self.sndbrutusmusicent delete();
		self.sndbrutusmusicent = undefined;
	}
	a_ai_brutus = getaiarchetypearray(#"brutus");
	if(a_ai_brutus.size)
	{
		level.brutus_count = a_ai_brutus.size;
	}
	else
	{
		level.brutus_count = 0;
	}
}

/*
	Name: brutus_cleanup_at_end_of_grief_round
	Namespace: zombie_brutus_util
	Checksum: 0x784C918F
	Offset: 0x2878
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function brutus_cleanup_at_end_of_grief_round()
{
	self endon(#"death", #"brutus_cleanup");
	level waittill(#"keep_griefing", #"game_module_ended");
	self notify(#"brutus_cleanup");
	self delete();
}

/*
	Name: wait_on_box_alarm
	Namespace: zombie_brutus_util
	Checksum: 0xFC080F85
	Offset: 0x28F8
	Size: 0x196
	Parameters: 0
	Flags: Linked
*/
function wait_on_box_alarm()
{
	while(true)
	{
		self.zbarrier waittill(#"randomization_done");
		level.var_a33d6e46++;
		if(level.brutus_in_grief)
		{
			level.brutus_min_pulls_between_box_spawns = randomintrange(7, 10);
		}
		if(level.var_a33d6e46 >= level.brutus_min_pulls_between_box_spawns)
		{
			rand = randomint(500);
			if(level.brutus_in_grief)
			{
				attempt_brutus_spawn(1);
			}
			else
			{
				if(rand <= level.brutus_alarm_chance)
				{
					if(level flag::get("moving_chest_now"))
					{
						continue;
					}
					if(attempt_brutus_spawn(1))
					{
						if(level.next_brutus_round == (level.round_number + 1))
						{
							level.next_brutus_round++;
						}
						level.brutus_alarm_chance = level.brutus_min_alarm_chance;
					}
				}
				else if(level.brutus_alarm_chance < level.brutus_max_alarm_chance)
				{
					level.brutus_alarm_chance = level.brutus_alarm_chance + level.brutus_alarm_chance_increment;
				}
			}
		}
	}
}

/*
	Name: check_perk_machine_valid
	Namespace: zombie_brutus_util
	Checksum: 0x8C750A8C
	Offset: 0x2A98
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function check_perk_machine_valid(player)
{
	if(isdefined(self.is_locked) && self.is_locked)
	{
		if(player zm_score::can_player_purchase(self.locked_cost))
		{
			player zm_score::minus_to_player_score(self.locked_cost);
			self.is_locked = 0;
			self.locked_cost = undefined;
			self.lock_fx delete();
			self zm_perks::reset_vending_hint_string();
		}
		return false;
	}
	return true;
}

/*
	Name: check_craftable_table_valid
	Namespace: zombie_brutus_util
	Checksum: 0x3D3E54D5
	Offset: 0x2B50
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function check_craftable_table_valid(player)
{
	if(!isdefined(self.stub) && (isdefined(self.is_locked) && self.is_locked))
	{
		if(player zm_score::can_player_purchase(self.locked_cost))
		{
			player zm_score::minus_to_player_score(self.locked_cost);
			self.is_locked = 0;
			self.locked_cost = undefined;
			self.lock_fx delete();
		}
		return false;
	}
	if(isdefined(self.stub) && (isdefined(self.stub.is_locked) && self.stub.is_locked))
	{
		if(player zm_score::can_player_purchase(self.stub.locked_cost))
		{
			player zm_score::minus_to_player_score(self.stub.locked_cost);
			self.stub.is_locked = 0;
			self.stub.locked_cost = undefined;
			self.stub.lock_fx delete();
			self sethintstring(self.stub.hint_string);
		}
		return false;
	}
	return true;
}

/*
	Name: brutus_check_zone
	Namespace: zombie_brutus_util
	Checksum: 0x1BAE3B10
	Offset: 0x2CF0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function brutus_check_zone()
{
	self endon(#"death", #"brutus_cleanup");
	self.in_player_zone = 0;
	while(true)
	{
		self.in_player_zone = 0;
		foreach(zone in level.zones)
		{
			if(!isdefined(zone.volumes) || zone.volumes.size == 0)
			{
				continue;
			}
			zone_name = zone.volumes[0].targetname;
			if(self zm_zonemgr::entity_in_zone(zone_name))
			{
				if(isdefined(zone.is_occupied) && zone.is_occupied)
				{
					self.in_player_zone = 1;
					break;
				}
			}
		}
		wait(0.2);
	}
}

/*
	Name: brutus_watch_enemy
	Namespace: zombie_brutus_util
	Checksum: 0x82564694
	Offset: 0x2E50
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function brutus_watch_enemy()
{
	self endon(#"death", #"brutus_cleanup");
	level endon(#"end_game");
	while(true)
	{
		if(!zm_utility::is_player_valid(self.favoriteenemy))
		{
			var_1cc3df76 = util::get_active_players();
			if(var_1cc3df76.size)
			{
				self.favoriteenemy = function_9a78baba(var_1cc3df76);
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_9a78baba
	Namespace: zombie_brutus_util
	Checksum: 0xE198FE0
	Offset: 0x2F08
	Size: 0x11E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9a78baba(var_1cc3df76)
{
	least_hunted = var_1cc3df76[0];
	for(i = 0; i < var_1cc3df76.size; i++)
	{
		if(isdefined(var_1cc3df76[i]) && !isdefined(var_1cc3df76[i].hunted_by))
		{
			var_1cc3df76[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(var_1cc3df76[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(least_hunted))
		{
			least_hunted = var_1cc3df76[i];
		}
		if(var_1cc3df76[i].hunted_by < least_hunted.hunted_by)
		{
			least_hunted = var_1cc3df76[i];
		}
	}
	least_hunted.hunted_by = least_hunted.hunted_by + 1;
	return least_hunted;
}

/*
	Name: brutus_lockdown_client_effects
	Namespace: zombie_brutus_util
	Checksum: 0xEB6C131C
	Offset: 0x3030
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function brutus_lockdown_client_effects(delay)
{
	self endon(#"death", #"brutus_cleanup");
	if(isdefined(delay))
	{
		wait(delay);
	}
	if(self.brutus_lockdown_state)
	{
		self.brutus_lockdown_state = 0;
		self clientfield::set("brutus_lock_down", 0);
	}
	else
	{
		self.brutus_lockdown_state = 1;
		self clientfield::set("brutus_lock_down", 1);
	}
}

/*
	Name: function_61263ebc
	Namespace: zombie_brutus_util
	Checksum: 0x4106727E
	Offset: 0x30E0
	Size: 0xAE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_61263ebc()
{
	trace = groundtrace(self.origin + vectorscale((0, 0, 1), 70), self.origin + (vectorscale((0, 0, -1), 100)), 0, self);
	if(isdefined(trace[#"entity"]))
	{
		entity = trace[#"entity"];
		if(entity ismovingplatform())
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_b02aec83
	Namespace: zombie_brutus_util
	Checksum: 0xB0A05BAD
	Offset: 0x3198
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function function_b02aec83()
{
	self endon(#"death", #"brutus_cleanup", #"ignore_cleanup");
	while(true)
	{
		if(isdefined(self.favoriteenemy))
		{
			break;
		}
		waitframe(1);
	}
	while(true)
	{
		if(!isdefined(self.favoriteenemy) && !self function_61263ebc())
		{
			level thread function_ba497d2d(self);
			return;
		}
		waitframe(2);
	}
}

/*
	Name: function_ba497d2d
	Namespace: zombie_brutus_util
	Checksum: 0x1DD2FD09
	Offset: 0x3250
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function function_ba497d2d(e_brutus)
{
	self endon(#"end_game");
	e_brutus clientfield::set("brutus_spawn_clientfield", 0);
	waitframe(1);
	if(isdefined(e_brutus) && isalive(e_brutus))
	{
		var_1a8c05ae = {#hash_72275733:e_brutus.explosive_dmg_taken, #hash_1e1ce722:e_brutus.helmet_hits, #hash_37d3fab9:e_brutus.has_helmet, #n_health:e_brutus.health};
		if(!isdefined(level.var_f158b05c))
		{
			level.var_f158b05c = [];
		}
		else if(!isarray(level.var_f158b05c))
		{
			level.var_f158b05c = array(level.var_f158b05c);
		}
		level.var_f158b05c[level.var_f158b05c.size] = var_1a8c05ae;
		e_brutus notify(#"zombie_delete");
		e_brutus notify(#"brutus_cleanup");
		e_brutus delete();
	}
	found_target = 0;
	while(!found_target)
	{
		var_1cc3df76 = util::get_active_players();
		foreach(e_target in var_1cc3df76)
		{
			if(zombie_utility::is_player_valid(e_target, 1))
			{
				found_target = 1;
				break;
			}
		}
		waitframe(1);
	}
	attempt_brutus_spawn(1, undefined, 0, 1);
}

/*
	Name: function_9398e511
	Namespace: zombie_brutus_util
	Checksum: 0x3FB5167F
	Offset: 0x34D0
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9398e511()
{
	if(isdefined(level.var_f158b05c) && level.var_f158b05c.size > 0)
	{
		var_1a8c05ae = level.var_f158b05c[0];
		arrayremovevalue(level.var_f158b05c, var_1a8c05ae);
		return var_1a8c05ae;
	}
	return undefined;
}

/*
	Name: function_60f8374c
	Namespace: zombie_brutus_util
	Checksum: 0xBD2ED08D
	Offset: 0x3548
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_60f8374c()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_2e0d129b);
		adddebugcommand("");
	#/
}

/*
	Name: function_2e0d129b
	Namespace: zombie_brutus_util
	Checksum: 0x1D49B56B
	Offset: 0x3598
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_2e0d129b(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_4d20b9f9a8da7a33":
			{
				level.var_cab8d080 = 1;
				if(isdefined(level.next_brutus_round))
				{
					zm_devgui::zombie_devgui_goto_round(level.next_brutus_round);
				}
				break;
			}
		}
	#/
}

