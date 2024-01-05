// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_damage_drains_points.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_contracts.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_score;

/*
	Name: __init__system__
	Namespace: zm_score
	Checksum: 0x3A6D8772
	Offset: 0x298
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_score", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_score
	Checksum: 0x59E79B4A
	Offset: 0x2E8
	Size: 0x1CA
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);
	foreach(subdivision in level.var_697c8943)
	{
		score_cf_register_info("damage" + subdivision, 1, 7);
	}
	score_cf_register_info("death_head", 1, 3);
	score_cf_register_info("death_melee", 1, 3);
	score_cf_register_info("transform_kill", 1, 3);
	clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int");
	callback::on_spawned(&player_on_spawned);
	level callback::on_ai_killed(&function_a3d16ee5);
	level.score_total = 0;
	level.a_func_score_events = [];
	level.var_c44113ca = [];
}

/*
	Name: __main__
	Namespace: zm_score
	Checksum: 0xA054FCE0
	Offset: 0x4C0
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.scoreongiveplayerscore = &function_610e9242;
}

/*
	Name: function_610e9242
	Namespace: zm_score
	Checksum: 0xF7E3BF90
	Offset: 0x4E8
	Size: 0xDA
	Parameters: 6
	Flags: Linked
*/
function function_610e9242(event, player, victim, descvalue, weapon, var_36f23f1f)
{
	score = player rank::getscoreinfovalue(event);
	/#
		assert(isdefined(score));
	#/
	xp = player rank::getscoreinfoxp(event);
	/#
		assert(isdefined(xp));
	#/
	label = rank::getscoreinfolabel(event);
	return score;
}

/*
	Name: register_score_event
	Namespace: zm_score
	Checksum: 0x7DA70BB4
	Offset: 0x5D0
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function register_score_event(str_event, func_callback)
{
	level.a_func_score_events[str_event] = func_callback;
}

/*
	Name: function_e5d6e6dd
	Namespace: zm_score
	Checksum: 0xA5E72A53
	Offset: 0x608
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_e5d6e6dd(str_archetype, n_score)
{
	level.var_c44113ca[str_archetype] = n_score;
}

/*
	Name: function_e5ca5733
	Namespace: zm_score
	Checksum: 0xB0A5564E
	Offset: 0x640
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_e5ca5733(str_archetype)
{
	if(isdefined(str_archetype) && isdefined(level.var_c44113ca[str_archetype]))
	{
		return level.var_c44113ca[str_archetype];
	}
	return 0;
}

/*
	Name: function_a3d16ee5
	Namespace: zm_score
	Checksum: 0x2D8FBF74
	Offset: 0x688
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_a3d16ee5(s_params)
{
	if(isdefined(self.score_event) && isplayer(s_params.eattacker))
	{
		scoreevents::processscoreevent(self.score_event, s_params.eattacker, undefined, s_params.weapon);
	}
}

/*
	Name: player_on_spawned
	Namespace: zm_score
	Checksum: 0x5955782E
	Offset: 0x6F8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function player_on_spawned()
{
	util::wait_network_frame();
	if(isdefined(self))
	{
		self.ready_for_score_events = 1;
	}
}

/*
	Name: score_cf_register_info
	Namespace: zm_score
	Checksum: 0x33E5D866
	Offset: 0x730
	Size: 0x96
	Parameters: 3
	Flags: Linked
*/
function score_cf_register_info(name, version, max_count)
{
	for(i = 0; i < 4; i++)
	{
		clientfield::register("worlduimodel", (("PlayerList.client" + i) + ".score_cf_") + name, version, getminbitcountfornum(max_count), "counter");
	}
}

/*
	Name: score_cf_increment_info
	Namespace: zm_score
	Checksum: 0xCC42B126
	Offset: 0x7D0
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function score_cf_increment_info(name, var_ce49f2dd = 0)
{
	if(!var_ce49f2dd && self bgb::function_69b88b5())
	{
		clientfield::increment_world_uimodel((("PlayerList.client" + self.entity_num) + ".score_cf_") + name);
	}
}

/*
	Name: player_add_points
	Namespace: zm_score
	Checksum: 0xAF9F1451
	Offset: 0x858
	Size: 0x7D8
	Parameters: 8
	Flags: Linked
*/
function player_add_points(event, mod, hit_location, e_target, zombie_team, damage_weapon, var_96054e3, var_e6e61503 = 0)
{
	if(level.intermission)
	{
		return;
	}
	if(!zm_utility::is_player_valid(self, 0, var_96054e3))
	{
		return;
	}
	player_points = 0;
	multiplier = get_points_multiplier(self);
	if(isdefined(level.a_func_score_events[event]))
	{
		player_points = [[level.a_func_score_events[event]]](event, mod, hit_location, zombie_team, damage_weapon);
	}
	else
	{
		switch(event)
		{
			case "rebuild_board":
			case "carpenter_powerup":
			case "nuke_powerup":
			case "reviver":
			case "oracle_boon":
			case "bonus_points_powerup":
			{
				player_points = mod;
				break;
			}
			case "bonus_points_powerup_shared":
			{
				player_points = mod;
				multiplier = 1;
				break;
			}
			case "damage_points":
			{
				switch(mod)
				{
					case 10:
					case 20:
					case 30:
					case 40:
					case 50:
					case 60:
					case 70:
					case 80:
					case 90:
					case 100:
					case 110:
					case 120:
					case 130:
					case 140:
					case 150:
					case 160:
					case 170:
					case 180:
					case 190:
					case 200:
					{
						player_points = mod;
						if(!function_e31cf9d5(event))
						{
							if(mod > 90)
							{
								self score_cf_increment_info("damage" + 90, var_e6e61503);
							}
							else
							{
								self score_cf_increment_info("damage" + mod, var_e6e61503);
							}
						}
					}
				}
				break;
			}
			case "death":
			{
				player_points = e_target.var_f256a4d9;
				if(!isdefined(player_points))
				{
					player_points = 0;
				}
				var_dd71ee3e = player_points;
				var_dc75a3a1 = 0;
				while(var_dd71ee3e > 0)
				{
					while(var_dd71ee3e < level.var_697c8943[var_dc75a3a1] && var_dc75a3a1 < level.var_697c8943.size)
					{
						var_dc75a3a1++;
					}
					if(var_dc75a3a1 == level.var_697c8943.size)
					{
						break;
					}
					var_dd71ee3e = var_dd71ee3e - level.var_697c8943[var_dc75a3a1];
					if(!function_e31cf9d5(event))
					{
						self score_cf_increment_info("damage" + level.var_697c8943[var_dc75a3a1], var_e6e61503);
					}
				}
				if(!function_e31cf9d5(event))
				{
					player_points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon, player_points, var_e6e61503);
				}
				if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH")
				{
					self zm_stats::increment_client_stat("grenade_kills");
					self zm_stats::increment_player_stat("grenade_kills");
				}
				break;
			}
			case "riotshield_fling":
			{
				player_points = mod;
				if(!var_e6e61503)
				{
					scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
				}
				break;
			}
			case "transform_kill":
			{
				self score_cf_increment_info("transform_kill", var_e6e61503);
				if(!var_e6e61503)
				{
					scoreevents::processscoreevent("transform_kill", self, undefined, damage_weapon);
				}
				player_points = zombie_utility::function_d2dfacfd(#"hash_68aa9b4c8de33261");
				break;
			}
			default:
			{
				/#
					assert(0, "");
				#/
				break;
			}
		}
	}
	if(isdefined(level.player_score_override))
	{
		player_points = self [[level.player_score_override]](damage_weapon, player_points);
	}
	player_points = multiplier * zm_utility::round_up_score(player_points, 10);
	if(isdefined(self.point_split_receiver) && event == "death")
	{
		split_player_points = player_points - (zm_utility::round_up_score(player_points * self.point_split_keep_percent, 10));
		self.point_split_receiver add_to_player_score(split_player_points);
		player_points = player_points - split_player_points;
	}
	if(event === "rebuild_board")
	{
		level notify(#"rebuild_board", {#points:player_points, #player:self});
	}
	self add_to_player_score(player_points, 1, event, var_e6e61503);
	if(var_e6e61503 || (isdefined(level.var_894a83d8) && level.var_894a83d8) || function_e31cf9d5(event))
	{
		return;
	}
	self.pers[#"score"] = self.score;
	if(isdefined(level._game_module_point_adjustment))
	{
		level [[level._game_module_point_adjustment]](self, zombie_team, player_points);
	}
}

/*
	Name: function_e31cf9d5
	Namespace: zm_score
	Checksum: 0x791CA589
	Offset: 0x1038
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e31cf9d5(str_score_event)
{
	if(namespace_32623e1c::is_active(1) && (str_score_event === "death" || str_score_event === "damage_points"))
	{
		return true;
	}
	return false;
}

/*
	Name: get_points_multiplier
	Namespace: zm_score
	Checksum: 0x4DEFC801
	Offset: 0x1098
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function get_points_multiplier(player)
{
	multiplier = (isdefined(player zombie_utility::function_73061b82(#"zombie_point_scalar")) ? player zombie_utility::function_73061b82(#"zombie_point_scalar") : zombie_utility::function_6403cf83(#"zombie_point_scalar", player.team));
	if(isdefined(level.current_game_module) && level.current_game_module == 2)
	{
		if(isdefined(level._race_team_double_points) && level._race_team_double_points == player._race_team)
		{
			return multiplier;
		}
		return 1;
	}
	return multiplier;
}

/*
	Name: player_add_points_kill_bonus
	Namespace: zm_score
	Checksum: 0x1C27B026
	Offset: 0x1198
	Size: 0x29E
	Parameters: 5
	Flags: Linked
*/
function player_add_points_kill_bonus(mod, hit_location, weapon, player_points = undefined, var_e6e61503 = 0)
{
	if(mod != "MOD_MELEE")
	{
		if("head" == hit_location || "helmet" == hit_location || "neck" == hit_location)
		{
			scoreevents::processscoreevent("headshot", self, undefined, weapon);
		}
		else
		{
			scoreevents::processscoreevent("kill", self, undefined, weapon);
		}
	}
	if(isdefined(level.player_score_override))
	{
		new_points = self [[level.player_score_override]](weapon, player_points);
		if(new_points > 0 && new_points != player_points)
		{
			return new_points;
		}
	}
	if(mod == "MOD_MELEE" && (!isdefined(weapon) || (!weapon.isriotshield && !zm_loadout::is_hero_weapon(weapon))))
	{
		self score_cf_increment_info("death_melee", var_e6e61503);
		scoreevents::processscoreevent("melee_kill", self, undefined, weapon);
		return zombie_utility::function_d2dfacfd(#"zombie_score_bonus_melee");
	}
	if(isdefined(player_points))
	{
		score = player_points;
	}
	else
	{
		score = 0;
	}
	if(isdefined(hit_location))
	{
		switch(hit_location)
		{
			case "head":
			case "helmet":
			case "neck":
			{
				self score_cf_increment_info("death_head", var_e6e61503);
				score = zombie_utility::function_d2dfacfd(#"zombie_score_bonus_head");
				break;
			}
			default:
			{
				break;
			}
		}
	}
	return score;
}

/*
	Name: player_reduce_points
	Namespace: zm_score
	Checksum: 0xFBB70C6
	Offset: 0x1440
	Size: 0x4E6
	Parameters: 2
	Flags: Linked
*/
function player_reduce_points(event, n_amount)
{
	if(level.intermission || zm_utility::is_standard())
	{
		return;
	}
	points = 0;
	switch(event)
	{
		case "take_all":
		{
			points = self.score;
			break;
		}
		case "take_half":
		{
			points = int(self.score / 2);
			break;
		}
		case "take_specified":
		{
			points = n_amount;
			break;
		}
		case "no_revive_penalty":
		{
			if(zm_custom::function_901b751c(#"hash_64291919b16c489a"))
			{
				percent = zm_custom::function_901b751c(#"hash_64291919b16c489a") / 100;
				points = self.score * percent;
			}
			else if(level.round_number >= 50)
			{
				percent = zombie_utility::function_d2dfacfd(#"penalty_no_revive");
				points = self.score * percent;
			}
			break;
		}
		case "died":
		{
			if(zm_custom::function_901b751c(#"hash_1158d006a3913ef6"))
			{
				percent = zm_custom::function_901b751c(#"hash_1158d006a3913ef6") / 100;
				points = self.score * percent;
			}
			else if(level.round_number >= 50)
			{
				percent = zombie_utility::function_d2dfacfd(#"penalty_died");
				points = self.score * percent;
			}
			break;
		}
		case "downed":
		{
			if(level.round_number < 50 && !zm_custom::function_901b751c(#"hash_1fed0d9afc0b0040"))
			{
				percent = 0;
			}
			else
			{
				if(zm_custom::function_901b751c(#"hash_1fed0d9afc0b0040"))
				{
					percent = zm_custom::function_901b751c(#"hash_1fed0d9afc0b0040") / 100;
				}
				else
				{
					percent = zombie_utility::function_d2dfacfd(#"penalty_downed");
					step = zombie_utility::function_d2dfacfd(#"hash_3037a1f286b662e6");
					if(step > 0)
					{
						percent = percent * (int(self.score / step));
					}
					if(percent > 0.5)
					{
						percent = 0.5;
					}
				}
			}
			self notify(#"i_am_down");
			points = self.score * percent;
			self.score_lost_when_downed = zm_utility::round_up_to_ten(int(points));
			break;
		}
		case "points_lost_on_hit_percent":
		{
			points = self.score * n_amount;
			break;
		}
		case "points_lost_on_hit_value":
		{
			points = n_amount;
			break;
		}
		default:
		{
			/#
				assert(0, "");
			#/
			break;
		}
	}
	points = self.score - zm_utility::round_up_to_ten(int(points));
	if(points < 0)
	{
		points = 0;
	}
	if(points > 4000000)
	{
		points = 4000000;
	}
	self.score = points;
	self notify(#"reduced_points", {#str_reason:event});
}

/*
	Name: add_to_player_score
	Namespace: zm_score
	Checksum: 0xD607740B
	Offset: 0x1930
	Size: 0x336
	Parameters: 4
	Flags: Linked
*/
function add_to_player_score(points, b_add_to_total = 1, str_awarded_by = "", var_e6e61503 = 0)
{
	if(!isdefined(points) || level.intermission)
	{
		return;
	}
	/#
		assert(isplayer(self), "");
	#/
	points = zm_utility::round_up_score(points, 10);
	if(isdefined(level.var_894a83d8) && level.var_894a83d8 || var_e6e61503 || function_e31cf9d5(str_awarded_by))
	{
		level thread zm_hero_weapon::function_3fe4a02e(self, points, str_awarded_by);
	}
	else
	{
		n_points_to_add_to_currency = bgb::add_to_player_score_override(points, str_awarded_by);
		self.score = self.score + n_points_to_add_to_currency;
		if(self.score > 4000000)
		{
			self.score = 4000000;
		}
		self.pers[#"score"] = self.score;
		self incrementplayerstat("scoreEarned", n_points_to_add_to_currency);
		self zm_stats::function_301c4be2("boas_scoreEarned", n_points_to_add_to_currency);
		self zm_stats::function_c0c6ab19(#"zearned", n_points_to_add_to_currency, 1);
		level notify(#"earned_points", {#points:points, #player:self});
		level thread zm_hero_weapon::function_3fe4a02e(self, points, str_awarded_by);
		self contracts::increment_zm_contract(#"hash_781e103e02826009", n_points_to_add_to_currency, #"zstandard");
		if(zm_utility::is_standard())
		{
			self zm_stats::function_c0c6ab19(#"rush_points", n_points_to_add_to_currency);
		}
		if(b_add_to_total)
		{
			self.score_total = self.score_total + points;
			level.score_total = level.score_total + points;
		}
		self notify(#"earned_points", {#str_awarded_by:str_awarded_by, #n_points:points});
	}
}

/*
	Name: minus_to_player_score
	Namespace: zm_score
	Checksum: 0x12CDE234
	Offset: 0x1C70
	Size: 0x1DE
	Parameters: 2
	Flags: Linked
*/
function minus_to_player_score(points, b_forced = 0)
{
	if(!isdefined(points) || level.intermission)
	{
		return;
	}
	if(self bgb::is_enabled(#"zm_bgb_shopping_free") && !b_forced)
	{
		self notify(#"hash_14b0ad44336160bc");
		self bgb::do_one_shot_use();
		self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
		return;
	}
	if(zm_utility::is_standard() && !b_forced)
	{
		return;
	}
	if(!b_forced)
	{
		self contracts::increment_zm_contract(#"hash_257283d6c7065a1e", points);
	}
	self.score = self.score - points;
	self.pers[#"score"] = self.score;
	self incrementplayerstat("scoreSpent", points);
	self zm_stats::function_301c4be2("boas_scoreSpent", points);
	level notify(#"spent_points", {#points:points, #player:self});
	self notify(#"spent_points", {#points:points});
}

/*
	Name: add_to_team_score
	Namespace: zm_score
	Checksum: 0x565673AC
	Offset: 0x1E58
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function add_to_team_score(points)
{
}

/*
	Name: minus_to_team_score
	Namespace: zm_score
	Checksum: 0x32DA4D7C
	Offset: 0x1E70
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function minus_to_team_score(points)
{
}

/*
	Name: player_died_penalty
	Namespace: zm_score
	Checksum: 0x1B920A20
	Offset: 0x1E88
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function player_died_penalty()
{
	players = getplayers(self.team);
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(player == self)
		{
			continue;
		}
		if(isdefined(player.is_zombie) && player.is_zombie)
		{
			continue;
		}
		player player_reduce_points("no_revive_penalty");
	}
}

/*
	Name: player_downed_penalty
	Namespace: zm_score
	Checksum: 0xEE1E0C60
	Offset: 0x1F70
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function player_downed_penalty()
{
	/#
		println("");
	#/
	self player_reduce_points("downed");
}

/*
	Name: can_player_purchase
	Namespace: zm_score
	Checksum: 0x7B31B8ED
	Offset: 0x1FC0
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function can_player_purchase(n_cost, var_1c65f833 = 0)
{
	if(self.score >= n_cost)
	{
		return true;
	}
	if(self bgb::is_enabled(#"zm_bgb_shopping_free"))
	{
		return true;
	}
	if(zm_utility::is_standard() && !var_1c65f833)
	{
		return true;
	}
	return false;
}

/*
	Name: function_82732ced
	Namespace: zm_score
	Checksum: 0x390FEFEB
	Offset: 0x2058
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_82732ced()
{
	if(isdefined(self.var_17a22c08))
	{
		var_7afe66bc = self.var_17a22c08;
	}
	else
	{
		var_7afe66bc = function_e5ca5733(self.archetype);
		/#
			assert(var_7afe66bc, ("" + function_9e72a96(self.archetype)) + "");
		#/
	}
	self.var_f256a4d9 = var_7afe66bc;
	self.var_d8caf335 = max(1, int(self.maxhealth / (var_7afe66bc * 0.1)));
	self.var_8d5c706f = [];
}

/*
	Name: function_89db94b3
	Namespace: zm_score
	Checksum: 0x6E77D77B
	Offset: 0x2140
	Size: 0x2F6
	Parameters: 3
	Flags: Linked
*/
function function_89db94b3(e_attacker, n_damage, e_inflictor)
{
	if(!isplayer(e_attacker) || !isdefined(self.var_8d5c706f) || (isdefined(self.marked_for_death) && self.marked_for_death))
	{
		return;
	}
	n_index = e_attacker.entity_num;
	if(!isdefined(n_index))
	{
		return;
	}
	if(!isdefined(self.var_8d5c706f[n_index]))
	{
		self.var_8d5c706f[n_index] = 0;
	}
	var_20701980 = self.var_8d5c706f[n_index];
	var_810a69da = var_20701980 + n_damage;
	var_86e74a5c = int(var_20701980 / self.var_d8caf335);
	var_6fb77dc8 = int(var_810a69da / self.var_d8caf335);
	n_points = (var_6fb77dc8 - var_86e74a5c) * 10;
	if(n_points > self.var_f256a4d9)
	{
		n_points = self.var_f256a4d9;
	}
	if(isdefined(e_attacker zombie_utility::function_73061b82(#"zombie_insta_kill")) && e_attacker zombie_utility::function_73061b82(#"zombie_insta_kill") || (isdefined(zombie_utility::function_6403cf83(#"zombie_insta_kill", e_attacker.team)) && zombie_utility::function_6403cf83(#"zombie_insta_kill", e_attacker.team)))
	{
		n_points = self.var_f256a4d9;
	}
	if(n_points)
	{
		if(isdefined(e_inflictor) && e_inflictor.var_9fde8624 === #"zombie_wolf_ally")
		{
			e_attacker player_add_points("damage_points", 70, undefined, undefined, undefined, undefined, undefined, self.var_12745932);
			self.var_f256a4d9 = self.var_f256a4d9 - n_points;
		}
		else
		{
			e_attacker player_add_points("damage_points", n_points, undefined, undefined, undefined, undefined, undefined, self.var_12745932);
			self.var_f256a4d9 = self.var_f256a4d9 - n_points;
		}
	}
	self.var_8d5c706f[n_index] = var_810a69da;
}

/*
	Name: function_acaab828
	Namespace: zm_score
	Checksum: 0x84B04A7D
	Offset: 0x2440
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_acaab828(b_disabled = 1)
{
	if(isdefined(self))
	{
		self.var_12745932 = b_disabled;
	}
}

/*
	Name: function_ffc2d0bc
	Namespace: zm_score
	Checksum: 0xE23813DA
	Offset: 0x2480
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_ffc2d0bc()
{
	return self.pers[#"score"];
}

/*
	Name: function_c1f146ff
	Namespace: zm_score
	Checksum: 0xEA9FDBCC
	Offset: 0x24A8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_c1f146ff(score)
{
	self.pers[#"score"] = score;
	self.score = score;
}

/*
	Name: function_bc9de425
	Namespace: zm_score
	Checksum: 0xA40A939B
	Offset: 0x24E8
	Size: 0x2BE
	Parameters: 1
	Flags: Linked
*/
function function_bc9de425(b_lowest_first = 0)
{
	var_5e8a44f9 = [];
	var_e8d2685c = 0;
	foreach(player in getplayers())
	{
		if(!isdefined(player.var_9fc3ee66))
		{
			player.var_9fc3ee66 = -1;
		}
		if(!isdefined(player.var_a8da9faf))
		{
			player.var_a8da9faf = -1;
		}
		if(!isdefined(var_5e8a44f9))
		{
			var_5e8a44f9 = [];
		}
		else if(!isarray(var_5e8a44f9))
		{
			var_5e8a44f9 = array(var_5e8a44f9);
		}
		var_5e8a44f9[var_5e8a44f9.size] = player.score;
		if(player.score > 0)
		{
			var_e8d2685c = 1;
		}
	}
	var_5e8a44f9 = array::sort_by_value(var_5e8a44f9, b_lowest_first);
	var_51639 = 0;
	var_694faff0 = -1;
	foreach(var_f0c1d3c2 in var_5e8a44f9)
	{
		if(var_e8d2685c && var_f0c1d3c2 != var_694faff0)
		{
			var_694faff0 = var_f0c1d3c2;
			var_51639++;
		}
		else
		{
			continue;
		}
		foreach(player in getplayers())
		{
			if(player.score == var_f0c1d3c2)
			{
				player.var_a8da9faf = player.var_9fc3ee66;
				player.var_9fc3ee66 = var_51639;
				continue;
			}
			continue;
		}
	}
	return var_5e8a44f9;
}

