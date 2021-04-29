// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace blackjack_challenges;

/*
	Name: function_89f2df9
	Namespace: blackjack_challenges
	Checksum: 0xFF1E509A
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"blackjack_challenges", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: blackjack_challenges
	Checksum: 0x9682BA6F
	Offset: 0x140
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_start_gametype(&start_gametype);
}

/*
	Name: start_gametype
	Namespace: blackjack_challenges
	Checksum: 0x58D0598A
	Offset: 0x170
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function start_gametype()
{
	if(!isdefined(level.challengescallbacks))
	{
		level.challengescallbacks = [];
	}
	waittillframeend();
	if(challenges::canprocesschallenges())
	{
		challenges::registerchallengescallback("playerKilled", &challenge_kills);
		challenges::registerchallengescallback("roundEnd", &challenge_round_ended);
		challenges::registerchallengescallback("gameEnd", &challenge_game_ended);
		scoreevents::register_hero_ability_kill_event(&on_hero_ability_kill);
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: blackjack_challenges
	Checksum: 0x961307FD
	Offset: 0x268
	Size: 0x1C2
	Parameters: 0
	Flags: None
*/
function on_player_connect()
{
	player = self;
	if(challenges::canprocesschallenges())
	{
		specialistindex = player player_role::get();
		isblackjack = specialistindex == 9;
		if(isblackjack)
		{
			player thread track_blackjack_consumable();
			if(!isdefined(self.pers[#"blackjack_challenge_active"]))
			{
				remaining_time = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
				if(remaining_time > 0)
				{
					special_card_earned = player get_challenge_stat("special_card_earned");
					if(!special_card_earned)
					{
						player.pers[#"blackjack_challenge_active"] = 1;
						player.pers[#"blackjack_unique_specialist_kills"] = 0;
						player.pers[#"blackjack_specialist_kills"] = 0;
						player.pers[#"blackjack_unique_weapon_mask"] = 0;
						player.pers[#"blackjack_unique_ability_mask"] = 0;
					}
				}
			}
		}
	}
}

/*
	Name: is_challenge_active
	Namespace: blackjack_challenges
	Checksum: 0x8829786A
	Offset: 0x438
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function is_challenge_active()
{
	return self.pers[#"blackjack_challenge_active"] === 1;
}

/*
	Name: on_hero_ability_kill
	Namespace: blackjack_challenges
	Checksum: 0x662F3939
	Offset: 0x468
	Size: 0x16C
	Parameters: 2
	Flags: None
*/
function on_hero_ability_kill(ability, victimability)
{
	player = self;
	if(!isdefined(player) || !isplayer(player))
	{
		return;
	}
	if(!isdefined(player.isroulette) || !player.isroulette)
	{
		return;
	}
	if(player is_challenge_active())
	{
		player.pers[#"blackjack_specialist_kills"]++;
		currentheroabilitymask = player.pers[#"blackjack_unique_ability_mask"];
		heroabilitymask = get_hero_ability_mask(ability);
		newheroabilitymask = heroabilitymask | currentheroabilitymask;
		if(newheroabilitymask != currentheroabilitymask)
		{
			player.pers[#"blackjack_unique_specialist_kills"]++;
			player.pers[#"blackjack_unique_ability_mask"] = newheroabilitymask;
		}
		player check_blackjack_challenge();
	}
}

/*
	Name: debug_print_already_earned
	Namespace: blackjack_challenges
	Checksum: 0xAB632889
	Offset: 0x5E0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function debug_print_already_earned()
{
	/#
		if(getdvarint(#"scr_blackjack_sidebet_debug", 0) == 0)
		{
			return;
		}
		iprintln("");
	#/
}

/*
	Name: debug_print_kill_info
	Namespace: blackjack_challenges
	Checksum: 0xA0F035F3
	Offset: 0x638
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function debug_print_kill_info()
{
	/#
		if(getdvarint(#"scr_blackjack_sidebet_debug", 0) == 0)
		{
			return;
		}
		player = self;
		iprintln("" + player.pers[#"blackjack_specialist_kills"] + "" + player.pers[#"blackjack_unique_specialist_kills"]);
	#/
}

/*
	Name: debug_print_earned
	Namespace: blackjack_challenges
	Checksum: 0xD2368EB5
	Offset: 0x6E8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function debug_print_earned()
{
	/#
		if(getdvarint(#"scr_blackjack_sidebet_debug", 0) == 0)
		{
			return;
		}
		iprintln("");
	#/
}

/*
	Name: check_blackjack_challenge
	Namespace: blackjack_challenges
	Checksum: 0xA6E96304
	Offset: 0x740
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function check_blackjack_challenge()
{
	player = self;
	/#
		debug_print_kill_info();
	#/
	special_card_earned = player get_challenge_stat("special_card_earned");
	if(special_card_earned)
	{
		/#
			debug_print_already_earned();
		#/
		return;
	}
	if(player.pers[#"blackjack_specialist_kills"] >= 4 && player.pers[#"blackjack_unique_specialist_kills"] >= 2)
	{
		player set_challenge_stat("special_card_earned", 1);
		player stats::function_dad108fa(#"blackjack_challenge", 1);
		/#
			debug_print_earned();
		#/
	}
}

/*
	Name: challenge_kills
	Namespace: blackjack_challenges
	Checksum: 0x73FD7AEE
	Offset: 0x870
	Size: 0x22C
	Parameters: 1
	Flags: None
*/
function challenge_kills(data)
{
	attackeristhief = data.attackeristhief;
	attackerisroulette = data.attackerisroulette;
	attackeristhieforroulette = attackeristhief || attackerisroulette;
	if(!attackeristhieforroulette)
	{
		return;
	}
	victim = data.victim;
	attacker = data.attacker;
	player = attacker;
	weapon = data.weapon;
	if(!isdefined(weapon) || weapon == level.weaponnone)
	{
		return;
	}
	if(!isdefined(player) || !isplayer(player))
	{
		return;
	}
	if(attackeristhief)
	{
		if(weapon.isheroweapon === 1)
		{
			if(player is_challenge_active())
			{
				player.pers[#"blackjack_specialist_kills"]++;
				currentheroweaponmask = player.pers[#"blackjack_unique_weapon_mask"];
				heroweaponmask = get_hero_weapon_mask(attacker, weapon);
				newheroweaponmask = heroweaponmask | currentheroweaponmask;
				if(newheroweaponmask != currentheroweaponmask)
				{
					player.pers[#"blackjack_unique_specialist_kills"] = player.pers[#"blackjack_unique_specialist_kills"] + 1;
					player.pers[#"blackjack_unique_weapon_mask"] = newheroweaponmask;
				}
				player check_blackjack_challenge();
			}
		}
	}
}

/*
	Name: get_challenge_stat
	Namespace: blackjack_challenges
	Checksum: 0xF737138B
	Offset: 0xAA8
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function get_challenge_stat(stat_name)
{
	return self stats::get_stat(#"tenthspecialistcontract", stat_name);
}

/*
	Name: set_challenge_stat
	Namespace: blackjack_challenges
	Checksum: 0x1C7B611D
	Offset: 0xAE0
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function set_challenge_stat(stat_name, stat_value)
{
	return self stats::set_stat(#"tenthspecialistcontract", stat_name, stat_value);
}

/*
	Name: get_hero_weapon_mask
	Namespace: blackjack_challenges
	Checksum: 0x9F396DD6
	Offset: 0xB28
	Size: 0x182
	Parameters: 2
	Flags: None
*/
function get_hero_weapon_mask(attacker, weapon)
{
	if(!isdefined(weapon))
	{
		return 0;
	}
	switch(weapon.name)
	{
		case "hero_minigun":
		{
			return 1;
			break;
		}
		case "hero_flamethrower":
		{
			return 2;
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			return 4;
			break;
		}
		case "hero_firefly_swarm":
		case "hero_chemicalgelgun":
		{
			return 8;
			break;
		}
		case "hero_pineapple_grenade":
		case "hero_pineapplegun":
		{
			return 16;
			break;
		}
		case "hero_bowlauncher2":
		case "hero_bowlauncher3":
		case "hero_bowlauncher4":
		case "hero_bowlauncher":
		{
			return 64;
			break;
		}
		case "hero_gravityspikes":
		{
			return 128;
			break;
		}
		case "hero_annihilator":
		{
			return 256;
			break;
		}
		default:
		{
			return 0;
		}
	}
}

/*
	Name: get_hero_ability_mask
	Namespace: blackjack_challenges
	Checksum: 0x5DB57FD2
	Offset: 0xCB8
	Size: 0x11A
	Parameters: 1
	Flags: None
*/
function get_hero_ability_mask(ability)
{
	if(!isdefined(ability))
	{
		return 0;
	}
	switch(ability.name)
	{
		case "gadget_clone":
		{
			return 1;
			break;
		}
		case "gadget_heat_wave":
		{
			return 2;
			break;
		}
		case "gadget_resurrect":
		{
			return 8;
			break;
		}
		case "gadget_armor":
		{
			return 16;
			break;
		}
		case "gadget_camo":
		{
			return 32;
			break;
		}
		case "gadget_vision_pulse":
		{
			return 64;
			break;
		}
		case "gadget_speed_burst":
		{
			return 128;
			break;
		}
		case "gadget_combat_efficiency":
		{
			return 256;
			break;
		}
		default:
		{
			return 0;
		}
	}
}

/*
	Name: challenge_game_ended
	Namespace: blackjack_challenges
	Checksum: 0x87A8BFB9
	Offset: 0xDE0
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function challenge_game_ended(data)
{
	if(!isdefined(data))
	{
		return;
	}
	player = data.player;
	if(!isdefined(player))
	{
		return;
	}
	if(!isplayer(player))
	{
		return;
	}
	if(isbot(player))
	{
		return;
	}
	if(!player is_challenge_active())
	{
		return;
	}
	player report_consumable();
}

/*
	Name: challenge_round_ended
	Namespace: blackjack_challenges
	Checksum: 0x51318AB8
	Offset: 0xE80
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function challenge_round_ended(data)
{
	if(!isdefined(data))
	{
		return;
	}
	player = data.player;
	if(!isdefined(player))
	{
		return;
	}
	if(!isplayer(player))
	{
		return;
	}
	if(isbot(player))
	{
		return;
	}
	if(!player is_challenge_active())
	{
		return;
	}
	player report_consumable();
}

/*
	Name: track_blackjack_consumable
	Namespace: blackjack_challenges
	Checksum: 0x45D6A3CA
	Offset: 0xF20
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function track_blackjack_consumable()
{
	level endon(#"game_ended");
	self notify(#"track_blackjack_consumable_singleton");
	self endon(#"track_blackjack_consumable_singleton", #"disconnect");
	player = self;
	if(!isdefined(player.last_blackjack_consumable_time))
	{
		player.last_blackjack_consumable_time = 0;
	}
	while(isdefined(player))
	{
		random_wait_time = getdvarfloat(#"mp_blackjack_consumable_wait", 20) + randomfloatrange(-5, 5);
		wait(random_wait_time);
		player report_consumable();
	}
}

/*
	Name: report_consumable
	Namespace: blackjack_challenges
	Checksum: 0xA39234D7
	Offset: 0x1020
	Size: 0x162
	Parameters: 0
	Flags: None
*/
function report_consumable()
{
	player = self;
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(player.timeplayed) || !isdefined(player.timeplayed[#"total"]))
	{
		return;
	}
	current_time_played = player.timeplayed[#"total"];
	time_to_report = current_time_played - player.last_blackjack_consumable_time;
	if(time_to_report > 0)
	{
		max_time_to_report = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
		consumable_increment = int(min(time_to_report, max_time_to_report));
		if(consumable_increment > 0)
		{
			player consumableincrement("blackjack", "consumed", consumable_increment);
		}
	}
	player.last_blackjack_consumable_time = current_time_played;
}

