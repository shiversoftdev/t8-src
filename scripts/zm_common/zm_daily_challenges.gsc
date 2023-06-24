// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\table_shared.gsc;
#using scripts\zm_common\gametypes\globallogic_score.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_daily_challenges;

/*
	Name: __init__system__
	Namespace: zm_daily_challenges
	Checksum: 0x7BD1559D
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_daily_challenges", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_daily_challenges
	Checksum: 0xBC173F4D
	Offset: 0x1C8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_connect);
	callback::on_spawned(&on_spawned);
	callback::on_challenge_complete(&on_challenge_complete);
	zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

/*
	Name: __main__
	Namespace: zm_daily_challenges
	Checksum: 0x4D5F6B08
	Offset: 0x258
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread spent_points_tracking();
	level thread earned_points_tracking();
}

/*
	Name: on_connect
	Namespace: zm_daily_challenges
	Checksum: 0xC416F30F
	Offset: 0x298
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self thread round_tracking();
	self thread perk_purchase_tracking();
	self thread perk_drink_tracking();
	self.a_daily_challenges = [];
	self.a_daily_challenges[0] = 0;
	self.a_daily_challenges[1] = 0;
	self.a_daily_challenges[2] = 0;
	self.a_daily_challenges[3] = 0;
}

/*
	Name: on_spawned
	Namespace: zm_daily_challenges
	Checksum: 0x21EC46F5
	Offset: 0x348
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_spawned()
{
	self thread challenge_ingame_time_tracking();
}

/*
	Name: round_tracking
	Namespace: zm_daily_challenges
	Checksum: 0xC8E6AEAE
	Offset: 0x370
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function round_tracking()
{
	self endon(#"disconnect");
	while(true)
	{
		level waittill(#"end_of_round");
		self.a_daily_challenges[3]++;
		self zm_stats::increment_challenge_stat(#"hash_4d3e2513e68c6848", undefined, 1);
		/#
			debug_print("");
		#/
		switch(self.a_daily_challenges[3])
		{
			case 10:
			{
				self zm_stats::increment_challenge_stat(#"zm_daily_round_10", undefined, 1);
				/#
					debug_print("");
				#/
				break;
			}
			case 15:
			{
				self zm_stats::increment_challenge_stat(#"zm_daily_round_15", undefined, 1);
				/#
					debug_print("");
				#/
				break;
			}
			case 20:
			{
				self zm_stats::increment_challenge_stat(#"zm_daily_round_20", undefined, 1);
				/#
					debug_print("");
				#/
				break;
			}
			case 25:
			{
				self zm_stats::increment_challenge_stat(#"zm_daily_round_25", undefined, 1);
				/#
					debug_print("");
				#/
				break;
			}
			case 30:
			{
				self zm_stats::increment_challenge_stat(#"zm_daily_round_30", undefined, 1);
				/#
					debug_print("");
				#/
				break;
			}
		}
	}
}

/*
	Name: death_check_for_challenge_updates
	Namespace: zm_daily_challenges
	Checksum: 0xAD0CC568
	Offset: 0x5E0
	Size: 0xBB4
	Parameters: 1
	Flags: Linked
*/
function death_check_for_challenge_updates(e_attacker)
{
	if(!isdefined(e_attacker))
	{
		return;
	}
	if(isdefined(e_attacker._trap_type))
	{
		if(isdefined(e_attacker.activated_by_player))
		{
			e_attacker.activated_by_player zm_stats::increment_challenge_stat(#"zm_daily_kills_traps");
			/#
				debug_print("");
			#/
		}
	}
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills");
	/#
		debug_print("");
	#/
	if(isvehicle(self))
	{
		str_damagemod = self.str_damagemod;
		w_damage = self.w_damage;
	}
	else
	{
		str_damagemod = self.damagemod;
		w_damage = self.damageweapon;
	}
	if(w_damage.inventorytype == "dwlefthand")
	{
		w_damage = w_damage.dualwieldweapon;
	}
	w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
	if(isdefined(self.var_6f84b820))
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_heavy");
				/#
					debug_print("");
				#/
				break;
			}
			case "miniboss":
			{
				e_attacker zm_stats::increment_challenge_stat(#"hash_258c10d310bf4203");
				/#
					debug_print("");
				#/
				break;
			}
		}
	}
	switch(self.archetype)
	{
		case "blight_father":
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_blightfather");
			/#
				debug_print("");
			#/
			break;
		}
		case "catalyst":
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_catalyst");
			/#
				debug_print("");
			#/
			if(isdefined(self.var_69a981e6) && self.var_69a981e6)
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"catalyst_transformation_denials");
			}
			break;
		}
		case "gladiator":
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_gladiator");
			/#
				debug_print("");
			#/
			break;
		}
		case "stoker":
		{
			e_attacker zm_stats::increment_challenge_stat(#"hash_2eb016a9af7e8a3");
			/#
				debug_print("");
			#/
			break;
		}
		case "tiger":
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_tiger");
			/#
				debug_print("");
			#/
			break;
		}
	}
	if(isdefined(self.missinglegs) && self.missinglegs)
	{
		e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_crawler");
		/#
			debug_print("");
		#/
	}
	if(self zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod))
	{
		e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_headshots");
		/#
			debug_print("");
		#/
		if(isdefined(e_attacker.a_daily_challenges) && isint(e_attacker.a_daily_challenges[0]))
		{
			e_attacker.a_daily_challenges[0]++;
			if(e_attacker.a_daily_challenges[0] == 20)
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_headshots_in_row");
				/#
					debug_print("");
				#/
			}
		}
	}
	else
	{
		e_attacker.a_daily_challenges[0] = 0;
	}
	if(isplayer(e_attacker) && e_attacker zm_powerups::is_insta_kill_active())
	{
		e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_instakill");
		/#
			debug_print("");
		#/
	}
	if(zm_loadout::is_lethal_grenade(w_damage))
	{
		e_attacker zm_stats::increment_challenge_stat(#"hash_5f9b7801af13f397");
		/#
			debug_print("");
		#/
	}
	if(e_attacker zm_pap_util::function_b81da3fd(w_damage))
	{
		e_attacker zm_stats::increment_challenge_stat(#"hash_799aecaf1ec45db1");
		/#
			debug_print("");
		#/
		w_stat = zm_weapons::get_base_weapon(w_damage);
	}
	else
	{
		if(zm_weapons::is_weapon_upgraded(w_damage))
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_packed");
			/#
				debug_print("");
			#/
			w_stat = zm_weapons::get_base_weapon(w_damage);
		}
		else
		{
			w_stat = zm_weapons::function_386dacbc(w_damage);
		}
	}
	if(zm_loadout::is_hero_weapon(w_damage))
	{
		e_attacker zm_stats::increment_challenge_stat(#"hash_730e40ef22de352");
		/#
			debug_print("");
		#/
	}
	if(isdefined(level.zombie_weapons[w_stat]))
	{
		switch(level.zombie_weapons[w_stat].weapon_classname)
		{
			case "ar":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_rifle");
				/#
					debug_print("");
				#/
				break;
			}
			case "lmg":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_mg");
				/#
					debug_print("");
				#/
				break;
			}
			case "pistol":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_pistol");
				/#
					debug_print("");
				#/
				break;
			}
			case "shotgun":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_shotgun");
				/#
					debug_print("");
				#/
				break;
			}
			case "smg":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_smg");
				/#
					debug_print("");
				#/
				break;
			}
			case "sniper":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_sniper");
				/#
					debug_print("");
				#/
				break;
			}
			case "tr":
			{
				e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_tactical_rifle");
				/#
					debug_print("");
				#/
				break;
			}
		}
	}
	switch(str_damagemod)
	{
		case "mod_explosive":
		case "mod_grenade":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_projectile_splash":
		{
			e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_explosive");
			/#
				debug_print("");
			#/
			break;
		}
	}
	if(w_damage.statname === #"bowie_knife")
	{
		e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_bowie");
		/#
			debug_print("");
		#/
	}
}

/*
	Name: spent_points_tracking
	Namespace: zm_daily_challenges
	Checksum: 0x70815AF5
	Offset: 0x11A0
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function spent_points_tracking()
{
	level endon(#"end_game");
	while(true)
	{
		result = undefined;
		result = level waittill(#"spent_points");
		player = result.player;
		n_points = result.points;
		player.a_daily_challenges[1] = player.a_daily_challenges[1] + n_points;
		player zm_stats::increment_challenge_stat(#"zm_daily_spend_25k", n_points);
		player zm_stats::increment_challenge_stat(#"zm_daily_spend_50k", n_points);
		/#
			debug_print("");
		#/
	}
}

/*
	Name: earned_points_tracking
	Namespace: zm_daily_challenges
	Checksum: 0xC2802A59
	Offset: 0x12B0
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function earned_points_tracking()
{
	level endon(#"end_game");
	while(true)
	{
		result = undefined;
		result = level waittill(#"earned_points");
		player = result.player;
		if(!isdefined(player))
		{
			continue;
		}
		n_points = result.points;
		if(zm_utility::is_standard())
		{
			player zm_stats::increment_challenge_stat(#"hash_7ea82afc1c790346", n_points);
		}
		else
		{
			player zm_stats::increment_challenge_stat(#"hash_67970ded10f84169", n_points, 1);
		}
		/#
			debug_print("");
		#/
		n_multiplier = zm_score::get_points_multiplier(player);
		if(n_multiplier == 2)
		{
			player.a_daily_challenges[2] = player.a_daily_challenges[2] + n_points;
			player zm_stats::increment_challenge_stat(#"zm_daily_earn_5k_with_2x", n_points, 1);
			/#
				debug_print("");
			#/
		}
	}
}

/*
	Name: challenge_ingame_time_tracking
	Namespace: zm_daily_challenges
	Checksum: 0xA6FD299D
	Offset: 0x1468
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function challenge_ingame_time_tracking()
{
	self endon(#"disconnect");
	self notify(#"stop_challenge_ingame_time_tracking");
	self endon(#"stop_challenge_ingame_time_tracking");
	level flag::wait_till("start_zombie_round_logic");
	for(;;)
	{
		wait(1);
		zm_stats::increment_client_stat("ZM_DAILY_CHALLENGE_INGAME_TIME");
	}
}

/*
	Name: increment_windows_repaired
	Namespace: zm_daily_challenges
	Checksum: 0x22B3FE00
	Offset: 0x14F0
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function increment_windows_repaired(s_barrier)
{
	if(!isdefined(self.n_dc_barriers_rebuilt))
	{
		self.n_dc_barriers_rebuilt = 0;
	}
	if(!(isdefined(self.b_dc_rebuild_timer_active) && self.b_dc_rebuild_timer_active))
	{
		self thread rebuild_timer();
		self.a_s_barriers_rebuilt = [];
	}
	if(!isinarray(self.a_s_barriers_rebuilt, s_barrier))
	{
		if(!isdefined(self.a_s_barriers_rebuilt))
		{
			self.a_s_barriers_rebuilt = [];
		}
		else if(!isarray(self.a_s_barriers_rebuilt))
		{
			self.a_s_barriers_rebuilt = array(self.a_s_barriers_rebuilt);
		}
		self.a_s_barriers_rebuilt[self.a_s_barriers_rebuilt.size] = s_barrier;
		self.n_dc_barriers_rebuilt++;
	}
}

/*
	Name: rebuild_timer
	Namespace: zm_daily_challenges
	Checksum: 0xECB689E2
	Offset: 0x15F0
	Size: 0x9A
	Parameters: 0
	Flags: Linked, Private
*/
function private rebuild_timer()
{
	self endon(#"disconnect");
	self.b_dc_rebuild_timer_active = 1;
	wait(45);
	if(self.n_dc_barriers_rebuilt >= 5)
	{
		self zm_stats::increment_challenge_stat(#"zm_daily_rebuild_windows");
		/#
			debug_print("");
		#/
	}
	self.n_dc_barriers_rebuilt = 0;
	self.a_s_barriers_rebuilt = [];
	self.b_dc_rebuild_timer_active = undefined;
}

/*
	Name: increment_magic_box
	Namespace: zm_daily_challenges
	Checksum: 0xF9D4D0DE
	Offset: 0x1698
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function increment_magic_box()
{
	if(isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")) && zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on"))
	{
		self zm_stats::increment_challenge_stat(#"zm_daily_purchase_fire_sale_magic_box");
		/#
			debug_print("");
		#/
	}
	self zm_stats::increment_challenge_stat(#"zm_daily_purchase_magic_box", undefined, 1);
	self zm_stats::increment_challenge_stat(#"hash_702d98df99af63d5", undefined, 1);
	/#
		debug_print("");
	#/
}

/*
	Name: increment_nuked_zombie
	Namespace: zm_daily_challenges
	Checksum: 0xDF478B6C
	Offset: 0x17A8
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function increment_nuked_zombie()
{
	foreach(player in level.players)
	{
		if(player.sessionstate != "spectator")
		{
			player zm_stats::increment_challenge_stat(#"zm_daily_kills_nuked");
			/#
				debug_print("");
			#/
		}
	}
}

/*
	Name: perk_purchase_tracking
	Namespace: zm_daily_challenges
	Checksum: 0x362AAA03
	Offset: 0x1870
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function perk_purchase_tracking()
{
	self endon(#"disconnect");
	while(true)
	{
		str_perk = undefined;
		self waittill(#"perk_purchased", str_perk);
		self zm_stats::increment_challenge_stat(#"zm_daily_purchase_perks");
		/#
			debug_print("");
		#/
	}
}

/*
	Name: perk_drink_tracking
	Namespace: zm_daily_challenges
	Checksum: 0x509C4117
	Offset: 0x1908
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function perk_drink_tracking()
{
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"perk_bought");
		self zm_stats::increment_challenge_stat(#"zm_daily_drink_perks");
		/#
			debug_print("");
		#/
	}
}

/*
	Name: debug_print
	Namespace: zm_daily_challenges
	Checksum: 0xC6E8662
	Offset: 0x1988
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function debug_print(str_line)
{
	if(getdvarint(#"zombie_debug", 0) > 0)
	{
		/#
			println(str_line);
		#/
	}
}

/*
	Name: on_challenge_complete
	Namespace: zm_daily_challenges
	Checksum: 0x943740D7
	Offset: 0x19E0
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function on_challenge_complete(params)
{
	n_challenge_index = params.challenge_index;
	if(is_daily_challenge(n_challenge_index))
	{
		if(isdefined(self))
		{
			uploadstats(self);
		}
		a_challenges = table::load(#"gamedata/stats/zm/statsmilestones4.csv", "a0");
		str_current_challenge = a_challenges[n_challenge_index][#"e4"];
		n_players = level.players.size;
		n_time_played = game.timepassed / 1000;
		n_challenge_start_time = self zm_stats::get_global_stat("zm_daily_challenge_start_time");
		n_challenge_time_ingame = self globallogic_score::getpersstat(#"zm_daily_challenge_ingame_time");
		n_challenge_games_played = self zm_stats::get_global_stat("zm_daily_challenge_games_played");
		/#
			debug_print("" + n_challenge_index);
		#/
	}
}

/*
	Name: is_daily_challenge
	Namespace: zm_daily_challenges
	Checksum: 0xAABE5DCF
	Offset: 0x1B68
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function is_daily_challenge(n_challenge_index)
{
	n_row = tablelookuprownum(#"gamedata/stats/zm/statsmilestones4.csv", 0, n_challenge_index);
	if(n_row > -1)
	{
		return true;
	}
	return false;
}

