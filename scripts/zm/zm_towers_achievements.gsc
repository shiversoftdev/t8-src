// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using script_782b5203722a7801;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_26ab2959;

/*
	Name: init
	Namespace: namespace_26ab2959
	Checksum: 0x7939A4F2
	Offset: 0x248
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"hash_6efaa75e1959aa0f");
	callback::on_connect(&function_131495a5);
	callback::on_connect(&function_6fdb733f);
	callback::on_ai_killed(&function_7b7ba154);
	callback::on_ai_killed(&function_3cbde7f5);
	callback::on_ai_killed(&function_b43c1bad);
	level.gib_on_damage = &function_cda4b8ba;
	level thread function_a87d82d1();
	level thread function_cbdb5e70();
	level flag::wait_till("all_players_spawned");
	array::thread_all(level.players, &function_131495a5);
	array::thread_all(level.players, &function_6fdb733f);
	array::thread_all(level.players, &function_45057dc4);
}

/*
	Name: function_45057dc4
	Namespace: namespace_26ab2959
	Checksum: 0x20BD41E4
	Offset: 0x3F8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_45057dc4()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"challenges_complete");
	self zm_utility::giveachievement_wrapper("zm_towers_challenges");
	/#
		self function_53b04cab("");
	#/
}

/*
	Name: function_131495a5
	Namespace: namespace_26ab2959
	Checksum: 0x9CA42380
	Offset: 0x480
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_131495a5()
{
	self notify("558820cf64d9ca3f");
	self endon("558820cf64d9ca3f");
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_change");
		w_weapon = var_be17187b.weapon;
		if(namespace_10f9f462::function_a2c527e5(w_weapon))
		{
			break;
		}
	}
	self zm_utility::giveachievement_wrapper("zm_towers_get_ww");
	/#
		self function_53b04cab("");
	#/
}

/*
	Name: function_7b7ba154
	Namespace: namespace_26ab2959
	Checksum: 0xE5BF8A9
	Offset: 0x570
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_7b7ba154(s_params)
{
	e_attacker = s_params.eattacker;
	if(!isdefined(e_attacker))
	{
		return;
	}
	var_64c09f7f = e_attacker.activated_by_player;
	if(!isplayer(var_64c09f7f))
	{
		return;
	}
	if(!isdefined(e_attacker._trap_type))
	{
		return;
	}
	if(e_attacker._trap_type != "hellpool")
	{
		return;
	}
	switch(e_attacker.script_string)
	{
		case "hash_7ebf57684b9746dc":
		{
			var_378e29b9 = "towers_acid_trap_built_ra";
			break;
		}
		case "hash_7eae57684b88d3a9":
		{
			var_378e29b9 = "towers_acid_trap_built_danu";
			break;
		}
		case "hash_7ebf49684b972f12":
		{
			var_378e29b9 = "towers_acid_trap_built_odin";
			break;
		}
		case "hash_7eae45684b88b513":
		{
			var_378e29b9 = "towers_acid_trap_built_zeus";
			break;
		}
		default:
		{
			return;
		}
	}
	var_64c09f7f zm_stats::increment_client_stat(var_378e29b9, 1);
	var_64c09f7f thread function_9bb7596b();
}

/*
	Name: function_9bb7596b
	Namespace: namespace_26ab2959
	Checksum: 0x811762DB
	Offset: 0x6F0
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_9bb7596b()
{
	b_ra = self zm_stats::function_eb50d9bf("towers_acid_trap_built_ra");
	b_danu = self zm_stats::function_eb50d9bf("towers_acid_trap_built_danu");
	b_odin = self zm_stats::function_eb50d9bf("towers_acid_trap_built_odin");
	b_zeus = self zm_stats::function_eb50d9bf("towers_acid_trap_built_zeus");
	if(b_ra && b_danu && b_odin && b_zeus)
	{
		self zm_utility::giveachievement_wrapper("zm_towers_trap_build");
	}
}

/*
	Name: function_3cbde7f5
	Namespace: namespace_26ab2959
	Checksum: 0x77F9E2E8
	Offset: 0x7E8
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_3cbde7f5(s_params)
{
	e_player = s_params.eattacker;
	if(!isplayer(e_player))
	{
		return;
	}
	e_projectile = function_5180cfce(s_params);
	if(!isdefined(e_projectile))
	{
		return;
	}
	if(!isdefined(e_projectile.var_1c5254ca))
	{
		e_projectile.var_1c5254ca = 0;
	}
	e_projectile.var_1c5254ca++;
	if(e_projectile.var_1c5254ca >= 9 && !e_player flag::exists(#"hash_599401a7cc5b8a84"))
	{
		e_player flag::init(#"hash_599401a7cc5b8a84");
		e_player flag::set(#"hash_599401a7cc5b8a84");
		e_player zm_utility::giveachievement_wrapper("zm_towers_ww_kills");
		/#
			e_player function_53b04cab("");
		#/
	}
}

/*
	Name: function_5180cfce
	Namespace: namespace_26ab2959
	Checksum: 0x95C781AB
	Offset: 0x948
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_5180cfce(s_params)
{
	e_projectile = s_params.einflictor;
	w_weapon = s_params.weapon;
	if(!isdefined(w_weapon) || !namespace_10f9f462::is_crossbow(w_weapon) || namespace_10f9f462::function_c6da1395(w_weapon))
	{
		return undefined;
	}
	if(!isdefined(e_projectile))
	{
		return undefined;
	}
	var_73e48d1a = e_projectile.weapon;
	if(!isdefined(var_73e48d1a) || !namespace_10f9f462::is_crossbow(var_73e48d1a) || namespace_10f9f462::function_c6da1395(var_73e48d1a))
	{
		return undefined;
	}
	return e_projectile;
}

/*
	Name: function_b43c1bad
	Namespace: namespace_26ab2959
	Checksum: 0x95705AF6
	Offset: 0xA30
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_b43c1bad(s_params)
{
	if(self.archetype !== #"tiger")
	{
		return;
	}
	waitframe(1);
	var_328cd9eb = self.var_39ebb8cc;
	if(!isdefined(var_328cd9eb) || var_328cd9eb.archetype !== #"tiger")
	{
		return;
	}
	e_player = var_328cd9eb.var_443d78cc;
	if(isplayer(e_player) && !e_player flag::exists(#"hash_4969e1eae9bf556f"))
	{
		e_player flag::init(#"hash_4969e1eae9bf556f");
		e_player flag::set(#"hash_4969e1eae9bf556f");
		e_player zm_utility::giveachievement_wrapper("zm_towers_kitty_kitty");
		/#
			e_player function_53b04cab("");
		#/
	}
}

/*
	Name: function_cda4b8ba
	Namespace: namespace_26ab2959
	Checksum: 0x549B488B
	Offset: 0xB78
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_cda4b8ba(e_attacker)
{
	if(!isplayer(e_attacker) || e_attacker zm_zonemgr::get_player_zone() !== "zone_body_pit")
	{
		return;
	}
	if(!isdefined(e_attacker.var_b26f3221))
	{
		e_attacker.var_b26f3221 = 0;
	}
	e_attacker.var_b26f3221++;
	if(e_attacker.var_b26f3221 >= 13 && !e_attacker flag::exists(#"hash_2086e93d2f58efce"))
	{
		e_attacker flag::init(#"hash_2086e93d2f58efce");
		e_attacker flag::set(#"hash_2086e93d2f58efce");
		e_attacker zm_utility::giveachievement_wrapper("zm_towers_dismember");
		/#
			e_attacker function_53b04cab("");
		#/
	}
}

/*
	Name: function_a24ba4fc
	Namespace: namespace_26ab2959
	Checksum: 0x499F37DA
	Offset: 0xCC0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_a24ba4fc()
{
	zm_utility::giveachievement_wrapper("zm_towers_boss_kill", 1);
	/#
		self function_53b04cab("");
	#/
	self zm_challenges::function_9a9ab6f6(#"hash_6d5340d9e43ed73d");
	if(isdefined(level.var_2d744147) && level.var_2d744147 <= 5940000)
	{
		self zm_challenges::function_979f4cc0(#"hash_69f53cb2579fba3e");
	}
}

/*
	Name: function_a87d82d1
	Namespace: namespace_26ab2959
	Checksum: 0xF237F5E3
	Offset: 0xD78
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_a87d82d1()
{
	level endon(#"end_game");
	level waittill(#"door_opened");
	level flag::set(#"hash_6efaa75e1959aa0f");
	callback::remove_on_connect(&function_6fdb733f);
}

/*
	Name: function_6fdb733f
	Namespace: namespace_26ab2959
	Checksum: 0x8E90193C
	Offset: 0xDF8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_6fdb733f()
{
	self notify("72218f31e92393e3");
	self endon("72218f31e92393e3");
	level endon(#"door_opened", #"end_game", #"hash_6efaa75e1959aa0f");
	self endon(#"death");
	if(level.round_number > 1 || level flag::get(#"hash_6efaa75e1959aa0f"))
	{
		return;
	}
	while(true)
	{
		level waittill(#"end_of_round");
		if(level.round_number >= 20)
		{
			break;
		}
	}
	self zm_utility::giveachievement_wrapper("zm_towers_arena_survive");
	/#
		self function_53b04cab("");
	#/
}

/*
	Name: function_cbdb5e70
	Namespace: namespace_26ab2959
	Checksum: 0x41A4CB89
	Offset: 0xF28
	Size: 0x1A8
	Parameters: 0
	Flags: Linked
*/
function function_cbdb5e70()
{
	level endon(#"end_game");
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		return;
	}
	if(!level flag::exists(#"hash_76692d6669cb0500"))
	{
		level flag::init(#"hash_76692d6669cb0500");
	}
	level waittill(#"start_of_round");
	a_e_players = level.players;
	level flag::wait_till_timeout(300, #"hash_76692d6669cb0500");
	if(level flag::get(#"hash_76692d6669cb0500"))
	{
		foreach(e_player in a_e_players)
		{
			if(isdefined(e_player))
			{
				e_player zm_utility::giveachievement_wrapper("zm_towers_fast_pap");
				/#
					e_player function_53b04cab("");
				#/
			}
		}
	}
}

/*
	Name: function_53b04cab
	Namespace: namespace_26ab2959
	Checksum: 0xC5C61DD6
	Offset: 0x10D8
	Size: 0x74
	Parameters: 1
	Flags: Private
*/
private function function_53b04cab(var_378e29b9)
{
	/#
		if(!isdefined(var_378e29b9))
		{
			var_378e29b9 = "";
		}
		self endon(#"death");
		str_name = self.name;
		if(!isdefined(str_name))
		{
			return;
		}
		iprintln((str_name + "") + var_378e29b9);
	#/
}

