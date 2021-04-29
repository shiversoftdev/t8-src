// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6021ce59143452c3;
#using script_6334bf874cddcc13;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_ebd828b;

/*
	Name: init
	Namespace: namespace_ebd828b
	Checksum: 0x5B8B3669
	Offset: 0x6F0
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	/#
		level thread function_fbf74c49();
	#/
	level.var_cbb3dff5 = spawnstruct();
	level.var_cbb3dff5.a_players = [];
	level flag::init("any_round_has_started");
	level._effect[#"hash_7bd75ae600e0a590"] = "maps/zm_towers/fx8_crowd_reward_flower_exp";
	level._effect[#"hash_4c4f96aa02c32a2a"] = "maps/zm_towers/fx8_crowd_reward_flower_trail";
	level thread function_8e83be5d();
	callback::on_connect(&function_74fc278);
	callback::on_actor_killed(&function_2d074f7d);
	zm_powerups::powerup_set_statless_powerup("dung");
	zm_powerups::powerup_set_statless_powerup("rock");
	zm_powerups::register_powerup("dung", &function_1493a309);
	zm_powerups::add_zombie_powerup("dung", #"hash_8e136d0af55e88b", #"zombie_powerup_free_perk", &zm_powerups::func_should_never_drop, 1, 0, 0);
	zm_powerups::function_f0eb47d8("dung", 1);
	zm_powerups::function_80b4c5e0("dung", 1);
	level thread function_5d6119de();
	level thread function_259aa822();
	level thread function_9c5fb1b5();
	level thread function_e45ccfd7();
	callback::on_spawned(&function_bdb90d4);
	var_b49c3a1f = getentarray("t_crowd_damage", "targetname");
	array::thread_all(var_b49c3a1f, &function_6020c0b2);
	level.var_857878e6 = &function_857878e6;
	/#
		zm_net::network_choke_init("", 3);
	#/
}

/*
	Name: function_857878e6
	Namespace: namespace_ebd828b
	Checksum: 0x44D4E6CD
	Offset: 0x9F0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_857878e6()
{
	if(!level.var_210ce105 zm_towers_crowd_meter::is_open(self))
	{
		level.var_210ce105 zm_towers_crowd_meter::open(self);
	}
	level.var_210ce105 zm_towers_crowd_meter::set_visible(self, 1);
}

/*
	Name: function_e45ccfd7
	Namespace: namespace_ebd828b
	Checksum: 0x6270D437
	Offset: 0xA60
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_e45ccfd7()
{
	level endon(#"end_game");
	level flag::init(#"hash_a39684f0887e82e");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_26b0477726cdbf77");
		if(zm_utility::function_e51dc2d8() && isdefined(var_be17187b.var_4f3558ce))
		{
			var_be17187b.var_4f3558ce thread function_55d09221();
		}
	}
}

/*
	Name: function_55d09221
	Namespace: namespace_ebd828b
	Checksum: 0x3B05A294
	Offset: 0xB20
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function function_55d09221()
{
	self endon(#"death");
	level endon(#"end_game");
	while(true)
	{
		foreach(t_crowd_damage in var_b49c3a1f)
		{
			if(self istouching(t_crowd_damage) && !level flag::get(#"hash_a39684f0887e82e"))
			{
				level thread function_10ef0925(self);
			}
		}
		wait(1);
	}
}

/*
	Name: function_6020c0b2
	Namespace: namespace_ebd828b
	Checksum: 0x36977936
	Offset: 0xC48
	Size: 0x1FA
	Parameters: 0
	Flags: Linked
*/
function function_6020c0b2()
{
	self endon(#"death");
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		player = var_be17187b.attacker;
		if(isplayer(player))
		{
			player.var_7df228aa.var_56b97916 = player.var_7df228aa.var_56b97916 + var_be17187b.amount;
			var_a70a93d0 = 0;
			if(isdefined(var_be17187b.mod))
			{
				switch(var_be17187b.mod)
				{
					case "mod_explosive":
					case "mod_grenade":
					case "mod_grenade_splash":
					case "mod_projectile_splash":
					{
						var_a70a93d0 = 1;
						break;
					}
				}
			}
			if(isdefined(var_be17187b.weapon) && (isdefined(var_be17187b.weapon.isrocketlauncher) && var_be17187b.weapon.isrocketlauncher))
			{
				var_a70a93d0 = 1;
			}
			if(player.var_7df228aa.var_56b97916 >= 150)
			{
				player.var_7df228aa.var_56b97916 = 0;
				if(var_a70a93d0)
				{
					player function_b8dfa139(#"hash_4122108abe671eb7");
					wait(1);
				}
			}
		}
	}
}

/*
	Name: function_aa0b6eb
	Namespace: namespace_ebd828b
	Checksum: 0x4756EF66
	Offset: 0xE50
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_aa0b6eb()
{
	n_amount = self.var_7df228aa.var_def266a8;
	if(n_amount >= 50 || (isdefined(self.var_7df228aa.var_4b801cbf) && self.var_7df228aa.var_4b801cbf))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_88c02b18
	Namespace: namespace_ebd828b
	Checksum: 0xEE1F2FC1
	Offset: 0xEB8
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_88c02b18()
{
	n_amount = self.var_7df228aa.var_def266a8;
	if(n_amount <= -50 || (isdefined(self.var_7df228aa.var_83b82812) && self.var_7df228aa.var_83b82812))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5c1184e
	Namespace: namespace_ebd828b
	Checksum: 0x3E333F3F
	Offset: 0xF20
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_5c1184e(b_enable = 1)
{
	foreach(var_9e45f43d in array("siege_crowds_grp27", "siege_zm_crowds_indv_1", "siege_zm_crowds_indv_2", "siege_zm_crowds_indv_3", "siege_zm_crowds_indv_4", "siege_zm_crowds_indv_5"))
	{
		if(b_enable)
		{
			showmiscmodels(var_9e45f43d);
			continue;
		}
		hidemiscmodels(var_9e45f43d);
	}
}

/*
	Name: function_696a8df0
	Namespace: namespace_ebd828b
	Checksum: 0xC1EA173D
	Offset: 0x1010
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_696a8df0(b_enable = 1)
{
	if(b_enable)
	{
		showmiscmodels("siege_crowds_outro");
	}
	else
	{
		hidemiscmodels("siege_crowds_outro");
	}
}

/*
	Name: function_aec5ec5a
	Namespace: namespace_ebd828b
	Checksum: 0x9AB199ED
	Offset: 0x1078
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_aec5ec5a(b_enable = 1)
{
	if(b_enable)
	{
		showmiscmodels("siege_crowds_battle");
	}
	else
	{
		hidemiscmodels("siege_crowds_battle");
	}
}

/*
	Name: function_8237489a
	Namespace: namespace_ebd828b
	Checksum: 0x21EB0682
	Offset: 0x10E0
	Size: 0x158
	Parameters: 1
	Flags: Linked
*/
function function_8237489a(b_enable = 1)
{
	if(b_enable)
	{
		foreach(var_9e45f43d in array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27"))
		{
			showmiscmodels(var_9e45f43d);
		}
	}
	else
	{
		foreach(var_9e45f43d in array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27"))
		{
			hidemiscmodels(var_9e45f43d);
		}
	}
}

/*
	Name: function_10ef0925
	Namespace: namespace_ebd828b
	Checksum: 0xBD5D6939
	Offset: 0x1240
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_10ef0925(var_4f3558ce)
{
	self notify("142d6aa2cb9b2691");
	self endon("142d6aa2cb9b2691");
	level.var_cc3a64f1 = level.var_9a992b09;
	level.var_9a992b09 = 1;
	level flag::set(#"hash_a39684f0887e82e");
	level clientfield::set("crowd_react", 2);
	wait(3);
	function_8237489a(1);
	function_5c1184e(0);
	level clientfield::set("" + #"hash_2f895e916afde822", 1);
	if(isdefined(var_4f3558ce))
	{
		var_4f3558ce waittill(#"death");
	}
	else
	{
		wait(30);
	}
	level clientfield::set("" + #"hash_2f895e916afde822", 0);
	wait(3);
	function_5c1184e(1);
	function_8237489a(0);
	level.var_9a992b09 = level.var_cc3a64f1;
	level.var_cc3a64f1 = undefined;
	level flag::clear(#"hash_a39684f0887e82e");
}

/*
	Name: function_259aa822
	Namespace: namespace_ebd828b
	Checksum: 0x5518A52D
	Offset: 0x1420
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_259aa822()
{
	level endon(#"end_game");
	level waittill(#"start_of_round");
	level flag::set("any_round_has_started");
}

/*
	Name: function_1493a309
	Namespace: namespace_ebd828b
	Checksum: 0x60E2A64B
	Offset: 0x1480
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_1493a309(e_player)
{
	e_player zm_score::player_reduce_points("take_specified", 250);
	if(self.powerup_name === "dung")
	{
		e_player playsound(#"hash_66a500811a472fac");
		e_player clientfield::set_to_player("" + #"hash_7478ffee8332e21e", 1);
		e_player util::delay(5, "disconnect", &clientfield::set_to_player, "" + #"hash_7478ffee8332e21e", 0);
		level notify(#"hash_694f58e8bc5dd48", {#e_player:e_player});
	}
}

/*
	Name: function_2d074f7d
	Namespace: namespace_ebd828b
	Checksum: 0x38C24FEE
	Offset: 0x1598
	Size: 0x334
	Parameters: 1
	Flags: Linked
*/
function function_2d074f7d(params)
{
	switch(self.archetype)
	{
		case "stoker":
		case "gladiator":
		{
			str_event = #"hash_27aa025524aa2a01";
			break;
		}
		case "tiger":
		{
			str_event = #"hash_35af3a06fde7a8d9";
			break;
		}
		case "blight_father":
		{
			str_event = #"hash_755bc5e6c3486dc4";
			break;
		}
		case "elephant":
		{
			str_event = #"hash_8686f01be1cd8b5";
			break;
		}
		case "hash_165d4f75a46540bb":
		{
			str_event = #"hash_29a47f9b217e8b1c";
			break;
		}
		case "zombie":
		{
			if(self.missinglegs)
			{
				str_event = #"crawler_kill";
			}
		}
	}
	if(isplayer(params.eattacker) && isalive(params.eattacker))
	{
		player = params.eattacker;
		if(!isdefined(player.var_7df228aa.var_996e0d3e))
		{
			player.var_7df228aa.var_996e0d3e = 0;
		}
		player.var_7df228aa.var_996e0d3e++;
		player notify(#"hash_4093e684a539c91d");
		if(player.var_7df228aa.var_996e0d3e == 10)
		{
			player function_b8dfa139(#"hash_158076998c9b511f");
		}
		if(str_event === #"hash_27aa025524aa2a01")
		{
			if(!player.var_7df228aa.var_92e4bf1b)
			{
				player.var_7df228aa.var_92e4bf1b = 1;
				player function_b8dfa139(#"hash_131b705484b2876");
			}
			else
			{
				player function_b8dfa139(#"hash_27aa025524aa2a01");
			}
		}
		else if(str_event === #"hash_35af3a06fde7a8d9")
		{
			if(!player.var_7df228aa.var_c2b08a)
			{
				player.var_7df228aa.var_c2b08a = 1;
				player function_b8dfa139(#"hash_19fccc380453c9fa");
			}
		}
		else if(isdefined(str_event))
		{
			player function_b8dfa139(str_event);
		}
	}
}

/*
	Name: function_74fc278
	Namespace: namespace_ebd828b
	Checksum: 0x8E317C72
	Offset: 0x18D8
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_74fc278()
{
	self.var_7df228aa = spawnstruct();
	self.var_7df228aa.var_712856c1 = #"hash_4977f8aaa598d06c";
	self.var_7df228aa.var_21ce4da6 = #"hash_4977f8aaa598d06c";
	self.var_7df228aa.var_def266a8 = 0;
	self.var_7df228aa.var_e6476b32 = 0;
	self.var_7df228aa.var_a120aedc = 0;
	self.var_7df228aa.var_56b97916 = 0;
	self.var_7df228aa.var_996e0d3e = 0;
	self.var_7df228aa.var_92e4bf1b = 0;
	self.var_7df228aa.var_c2b08a = 0;
	self.var_7df228aa.var_f0c7d50a = 0;
	self flag::init("crowd_item_thrown_out_for_round_good");
	self flag::init("crowd_item_thrown_out_for_round_bad");
	self thread function_7469866d();
	self thread function_1b848dc2();
	self thread function_be93759e();
}

/*
	Name: function_be93759e
	Namespace: namespace_ebd828b
	Checksum: 0xF0060567
	Offset: 0x1A40
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_be93759e()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	level flag::wait_till("any_round_has_started");
	if(!level.var_210ce105 zm_towers_crowd_meter::is_open(self) && !zm_utility::is_standard())
	{
		level.var_210ce105 zm_towers_crowd_meter::set_visible(self, 1);
		level.var_210ce105 zm_towers_crowd_meter::open(self);
	}
}

/*
	Name: function_51ea46f3
	Namespace: namespace_ebd828b
	Checksum: 0x163EBE36
	Offset: 0x1B18
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_51ea46f3(b_enable = 1, b_close = 0)
{
	level.var_210ce105 zm_towers_crowd_meter::set_visible(self, b_enable);
	if(b_close)
	{
		if(level.var_210ce105 zm_towers_crowd_meter::is_open(self))
		{
			level.var_210ce105 zm_towers_crowd_meter::close(self);
		}
	}
}

/*
	Name: function_1b848dc2
	Namespace: namespace_ebd828b
	Checksum: 0x373156AD
	Offset: 0x1BC0
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_1b848dc2()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	level flag::wait_till("start_zombie_round_logic");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill_timeout(240, #"hash_4093e684a539c91d", #"death");
		if(isalive(self) && var_be17187b._notify == "timeout")
		{
			self function_b8dfa139(#"hash_1ecab55fd270f67b");
		}
	}
}

/*
	Name: function_5d6119de
	Namespace: namespace_ebd828b
	Checksum: 0x3304BF1C
	Offset: 0x1CB0
	Size: 0x710
	Parameters: 0
	Flags: Linked
*/
function function_5d6119de()
{
	level endon(#"end_game");
	level flag::init(#"crowd_throw_item_immediate");
	level flag::init(#"hash_1a9f6d0c1e7684b4");
	level flag::init(#"hash_80fa0541e21f744");
	level.var_8cdff3aa = 20;
	callback::function_74872db6(&function_74872db6);
	level flag::wait_till("start_zombie_round_logic");
	while(true)
	{
		while(level.var_8cdff3aa > 0 && !level flag::get("crowd_throw_item_immediate"))
		{
			wait(1);
			level.var_8cdff3aa = level.var_8cdff3aa - 1;
		}
		var_be79df4d = [];
		var_f8b181cf = [];
		foreach(player in level.players)
		{
			if(isalive(player) && player.var_7df228aa.var_def266a8 >= 40)
			{
				if(!isdefined(var_be79df4d))
				{
					var_be79df4d = [];
				}
				else if(!isarray(var_be79df4d))
				{
					var_be79df4d = array(var_be79df4d);
				}
				if(!isinarray(var_be79df4d, player))
				{
					var_be79df4d[var_be79df4d.size] = player;
				}
			}
			if(isalive(player) && player.var_7df228aa.var_def266a8 <= -40)
			{
				if(!isdefined(var_f8b181cf))
				{
					var_f8b181cf = [];
				}
				else if(!isarray(var_f8b181cf))
				{
					var_f8b181cf = array(var_f8b181cf);
				}
				if(!isinarray(var_f8b181cf, player))
				{
					var_f8b181cf[var_f8b181cf.size] = player;
				}
			}
		}
		if(var_be79df4d.size && var_f8b181cf.size)
		{
			var_a841b5f1 = arraycombine(var_be79df4d, var_f8b181cf, 0, 0);
			e_target_player = function_79b77be1(var_a841b5f1);
		}
		else if(var_be79df4d.size)
		{
			e_target_player = function_79b77be1(var_be79df4d);
		}
		else if(var_f8b181cf.size)
		{
			e_target_player = function_79b77be1(var_f8b181cf);
		}
		else if(level flag::get(#"crowd_throw_item_immediate"))
		{
			e_target_player = function_79b77be1(level.activeplayers);
		}
		if(!isalive(e_target_player))
		{
			continue;
		}
		str_player_zone = e_target_player zm_zonemgr::get_player_zone();
		var_2bd26cff = e_target_player.var_7df228aa.var_def266a8;
		while(isalive(e_target_player) && !level flag::get(#"crowd_throw_item_immediate") && n_time > 0)
		{
			if(str_player_zone === "zone_starting_area_ra" || str_player_zone === "zone_starting_area_odin" || str_player_zone === "zone_starting_area_danu" || str_player_zone === "zone_starting_area_zeus")
			{
				break;
			}
			str_player_zone = e_target_player zm_zonemgr::get_player_zone();
			wait(1);
			n_time = n_time - 1;
		}
		if(!isalive(e_target_player) || n_time <= 0 || (isdefined(e_target_player.var_7df228aa.var_4c83f6a2) && e_target_player.var_7df228aa.var_4c83f6a2))
		{
			level flag::clear(#"crowd_throw_item_immediate");
			continue;
		}
		if(level flag::get(#"crowd_throw_item_immediate") || (function_fd02425d(var_2bd26cff) && !e_target_player flag::get(#"crowd_item_thrown_out_for_round_good")) || (function_e94dbaa9(var_2bd26cff) && !e_target_player flag::get(#"crowd_item_thrown_out_for_round_bad")))
		{
			if(!level flag::get(#"crowd_throw_item_immediate"))
			{
				if(function_fd02425d(var_2bd26cff))
				{
					e_target_player flag::set(#"crowd_item_thrown_out_for_round_good");
				}
				else if(function_e94dbaa9(var_2bd26cff))
				{
					e_target_player flag::set(#"crowd_item_thrown_out_for_round_bad");
				}
			}
			e_target_player thread function_fce0d3b3(var_2bd26cff);
		}
		level flag::clear(#"crowd_throw_item_immediate");
	}
}

/*
	Name: function_fd02425d
	Namespace: namespace_ebd828b
	Checksum: 0x7114332B
	Offset: 0x23C8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_fd02425d(var_2bd26cff)
{
	if(var_2bd26cff >= 40)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e94dbaa9
	Namespace: namespace_ebd828b
	Checksum: 0x824316F8
	Offset: 0x23F8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_e94dbaa9(var_2bd26cff)
{
	if(var_2bd26cff <= -40)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_79b77be1
	Namespace: namespace_ebd828b
	Checksum: 0xC5F50E04
	Offset: 0x2428
	Size: 0x150
	Parameters: 1
	Flags: Linked
*/
function function_79b77be1(a_players)
{
	if(level flag::get(#"crowd_throw_item_immediate"))
	{
		e_target_player = array::random(a_players);
	}
	else
	{
		foreach(player in a_players)
		{
			var_def266a8 = player.var_7df228aa.var_def266a8;
			if(function_fd02425d(var_def266a8) && !player flag::get(#"crowd_item_thrown_out_for_round_good") || (function_e94dbaa9(var_def266a8) && !player flag::get(#"crowd_item_thrown_out_for_round_bad")))
			{
				e_target_player = player;
				break;
			}
		}
	}
	return e_target_player;
}

/*
	Name: function_74872db6
	Namespace: namespace_ebd828b
	Checksum: 0x27C77623
	Offset: 0x2580
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_74872db6()
{
	foreach(player in level.players)
	{
		player flag::clear(#"crowd_item_thrown_out_for_round_good");
		player flag::clear(#"crowd_item_thrown_out_for_round_bad");
	}
}

/*
	Name: function_fce0d3b3
	Namespace: namespace_ebd828b
	Checksum: 0x165261FD
	Offset: 0x2630
	Size: 0xF0A
	Parameters: 1
	Flags: Linked
*/
function function_fce0d3b3(var_2bd26cff)
{
	self endon(#"death");
	var_15230439 = struct::get_array("s_crowd_item_start");
	var_4f0ef489 = [];
	self.var_7df228aa.var_4c83f6a2 = 1;
	var_bec704d1 = 0;
	if(var_2bd26cff <= -40 || level flag::get(#"hash_80fa0541e21f744"))
	{
		if(level flag::get(#"hash_80fa0541e21f744"))
		{
			var_a714ee15 = arraycombine(array("dung"), array("rock"), 0, 0);
		}
		else if(var_2bd26cff <= -50 && level flag::get("zm_towers_pap_quest_completed"))
		{
			var_a714ee15 = array("dung");
		}
		else
		{
			var_a714ee15 = array("rock");
		}
	}
	else if(var_2bd26cff >= 40 || level flag::get(#"hash_1a9f6d0c1e7684b4"))
	{
		if(level flag::get(#"hash_1a9f6d0c1e7684b4"))
		{
			var_a714ee15 = arraycombine(array("double_points", "bonus_points_player", "insta_kill", "carpenter"), array("hero_weapon_power", "fire_sale"), 0, 0);
		}
		else if(var_2bd26cff >= 50 && !zm_utility::is_standard())
		{
			var_a714ee15 = array("hero_weapon_power", "fire_sale");
		}
		else
		{
			var_a714ee15 = array("double_points", "bonus_points_player", "insta_kill", "carpenter");
		}
		var_bec704d1 = 1;
	}
	else
	{
		var_a714ee15 = array("double_points", "bonus_points_player", "insta_kill", "carpenter");
		var_bec704d1 = 1;
	}
	if(var_bec704d1 && var_2bd26cff >= 50)
	{
		self.var_7df228aa.var_4b801cbf = 1;
	}
	else if(!var_bec704d1 && var_2bd26cff <= -50)
	{
		self.var_7df228aa.var_83b82812 = 1;
	}
	self function_dbe08c92(undefined, var_bec704d1);
	foreach(s_loc in var_15230439)
	{
	}
	while(true)
	{
		if(!isalive(self))
		{
			return;
		}
		foreach(s_loc in var_15230439)
		{
			if(self util::is_player_looking_at(s_loc.origin, 0.95, 1, self))
			{
				if(!isdefined(var_4f0ef489))
				{
					var_4f0ef489 = [];
				}
				else if(!isarray(var_4f0ef489))
				{
					var_4f0ef489 = array(var_4f0ef489);
				}
				var_4f0ef489[var_4f0ef489.size] = s_loc;
			}
		}
		if(var_4f0ef489.size)
		{
			break;
		}
		waitframe(1);
	}
	var_4d611aa2 = array::random(var_4f0ef489);
	var_edbc66b6 = array::random(struct::get_array(var_4d611aa2.target));
	foreach(s_loc in var_15230439)
	{
		if(isdefined(s_loc.var_d18b181c))
		{
			s_loc.var_d18b181c delete();
		}
	}
	level flag::clear(#"hash_80fa0541e21f744");
	level flag::clear(#"hash_1a9f6d0c1e7684b4");
	str_powerup = array::random(var_a714ee15);
	if(!isdefined(level.zombie_powerups[str_powerup]))
	{
		playsoundatposition(#"hash_339b376fb02738f5", var_4d611aa2.origin);
		if(str_powerup === "rock")
		{
			var_2e1f34dd = util::spawn_model(#"hash_5a78e7591a2e5e39", var_4d611aa2.origin, var_4d611aa2.angles);
			var_2e1f34dd fx::play(#"hash_4c4f96aa02c32a2a", var_2e1f34dd.origin, var_2e1f34dd.angles, "crowd_item_fly_fx_stop", 1);
			var_2e1f34dd setscale(8);
			n_time = var_2e1f34dd zm_utility::fake_physicslaunch(self geteye(), 5000);
			wait(n_time);
			if(isalive(self))
			{
				v_player_angles = self getplayerangles();
				v_pos = self geteye() + anglestoforward(v_player_angles) * 100;
				var_2e1f34dd moveto(v_pos, 0.05);
				self dodamage(5, v_pos);
				self shellshock(#"pain_zm", 3);
				self playsound(#"hash_270c80055a8d296c");
				/#
					self thread zm_net::network_choke_action("", &function_f3e454c1, self.name + "");
				#/
			}
			wait(0.05);
			if(isdefined(var_2e1f34dd))
			{
				var_2e1f34dd notify(#"crowd_item_fly_fx_stop");
				var_2e1f34dd delete();
			}
		}
	}
	else
	{
		playsoundatposition(#"hash_339b376fb02738f5", var_4d611aa2.origin);
		var_354ec191 = array::random(array(#"hash_3faf54e1959102df", #"hash_1bf5e8d33258cd2a", #"hash_31ea6efe6576be6d"));
		var_2e1f34dd = util::spawn_model(var_354ec191, var_4d611aa2.origin, var_4d611aa2.angles);
		var_2e1f34dd fx::play(#"hash_4c4f96aa02c32a2a", var_2e1f34dd.origin, var_2e1f34dd.angles, "crowd_item_fly_fx_stop", 1);
		n_time = var_2e1f34dd zm_utility::fake_physicslaunch(var_edbc66b6.origin, 600);
		wait(n_time);
		fx::play(#"hash_7bd75ae600e0a590", var_edbc66b6.origin, var_edbc66b6.angles + vectorscale((1, 0, 0), 270));
		var_2e1f34dd notify(#"crowd_item_fly_fx_stop");
		var_2e1f34dd.origin = var_edbc66b6.origin;
		switch(var_354ec191)
		{
			case "hash_3faf54e1959102df":
			{
				var_edbc66b6 thread scene::play("p8_fxanim_zm_towers_crowd_jar_01_bundle", var_2e1f34dd);
				break;
			}
			case "hash_1bf5e8d33258cd2a":
			{
				var_edbc66b6 thread scene::play("p8_fxanim_zm_towers_crowd_jar_02_bundle", var_2e1f34dd);
				break;
			}
			case "hash_31ea6efe6576be6d":
			{
				var_edbc66b6 thread scene::play("p8_fxanim_zm_towers_crowd_jar_03_bundle", var_2e1f34dd);
				break;
			}
		}
		earthquake(0.3, 0.5, var_edbc66b6.origin, 256);
		if(isalive(self))
		{
			var_7d81025 = zm_powerups::specific_powerup_drop(str_powerup, var_edbc66b6.origin);
			if(isdefined(var_7d81025))
			{
				if(str_powerup === "dung")
				{
					var_7d81025 moveto(groundtrace(var_7d81025.origin + vectorscale((0, 0, 1), 8), var_7d81025.origin + vectorscale((0, 0, -1), 100000), 0, var_7d81025)[#"position"] + (0, 0, 0), 0.25);
					var_7d81025 setscale(3);
					var_7d81025 playloopsound("zmb_dung_lp");
				}
				var_be17187b = undefined;
				var_be17187b = var_7d81025 waittill(#"powerup_grabbed", #"powerup_timedout", #"hacked", #"death");
				var_264cf1f9 = var_be17187b.e_grabber;
				if(isplayer(var_264cf1f9) && var_bec704d1 == 1)
				{
					var_264cf1f9 notify(#"hash_62f05feef69e1ed4");
				}
				if(isplayer(var_264cf1f9) && isplayer(self))
				{
					if(var_264cf1f9 == self)
					{
						/#
							self thread zm_net::network_choke_action("", &function_f3e454c1, var_264cf1f9.name + "" + str_powerup + "");
						#/
					}
					else if(str_powerup == "hero_weapon_power" || str_powerup == "bonus_points_player")
					{
						var_264cf1f9.var_7df228aa.var_a120aedc++;
						if(var_264cf1f9.var_7df228aa.var_a120aedc > 5)
						{
							var_264cf1f9 function_b8dfa139(#"hash_3d85834be3aff6d2");
						}
						else
						{
							var_264cf1f9 function_b8dfa139(#"hash_15b4f3726a962ee0");
						}
					}
					/#
						thread zm_net::network_choke_action("", &function_f3e454c1, var_264cf1f9.name + "" + self.name + "" + str_powerup);
					#/
				}
			}
		}
	}
	if(isdefined(self))
	{
		else
		{
		}
		self.var_7df228aa.var_4c83f6a2 = undefined;
		self.var_7df228aa.var_4b801cbf = undefined;
		self.var_7df228aa.var_83b82812 = undefined;
		self function_dbe08c92(self.var_7df228aa.var_21ce4da6);
	}
	level.var_8cdff3aa = 20;
}

/*
	Name: function_b8dfa139
	Namespace: namespace_ebd828b
	Checksum: 0x9A686F3C
	Offset: 0x3548
	Size: 0x5A4
	Parameters: 1
	Flags: Linked
*/
function function_b8dfa139(str_event)
{
	if(isdefined(level.var_9a992b09) && level.var_9a992b09)
	{
		return;
	}
	var_ac39950d = 0;
	switch(str_event)
	{
		case "hash_158076998c9b511f":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "hash_19fccc380453c9fa":
		{
			var_9c93ba8f = 3;
			break;
		}
		case "crawler_kill":
		{
			var_9c93ba8f = 1;
			break;
		}
		case "hash_131b705484b2876":
		{
			var_9c93ba8f = 15;
			var_ac39950d = 1;
			break;
		}
		case "hash_27aa025524aa2a01":
		{
			var_9c93ba8f = 8;
			break;
		}
		case "hash_755bc5e6c3486dc4":
		{
			var_9c93ba8f = 20;
			if(!self.var_7df228aa.var_f0c7d50a)
			{
				self.var_7df228aa.var_f0c7d50a = 1;
				var_ac39950d = 1;
			}
			break;
		}
		case "hash_8686f01be1cd8b5":
		{
			var_9c93ba8f = 30;
			var_ac39950d = 1;
			break;
		}
		case "hash_29a47f9b217e8b1c":
		{
			var_9c93ba8f = 10;
			var_ac39950d = 1;
			break;
		}
		case "hash_c65bc15b1aeb1bb":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "hash_c65bd15b1aeb36e":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "hash_c65be15b1aeb521":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "hash_2048e4bc4cd51960":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "trap_activated":
		{
			var_9c93ba8f = 5;
			var_ac39950d = 1;
			break;
		}
		case "trap_kill":
		{
			var_9c93ba8f = 1;
			break;
		}
		case "hash_689abcb17111463":
		{
			var_9c93ba8f = 3;
			break;
		}
		case "hash_197ae1fc115dc636":
		{
			var_9c93ba8f = 7;
			break;
		}
		case "hash_5d587a946bd4f958":
		{
			var_9c93ba8f = 15;
			var_ac39950d = 1;
			break;
		}
		case "hash_5986c925a370e137":
		{
			var_9c93ba8f = 20;
			break;
		}
		case "hash_300454c11a18ae03":
		{
			var_9c93ba8f = 5;
			break;
		}
		case "hash_39efd1a80488c531":
		{
			var_9c93ba8f = 10;
			break;
		}
		case "hash_69fc3ba948618464":
		{
			var_9c93ba8f = 15;
			break;
		}
		case "hash_4122108abe671eb7":
		{
			var_9c93ba8f = -25;
			break;
		}
		case "hash_7d48d521481272cf":
		{
			var_9c93ba8f = -2;
			break;
		}
		case "player_down":
		{
			var_9c93ba8f = -7;
			break;
		}
		case "player_death":
		{
			var_9c93ba8f = -13;
			break;
		}
		case "hash_1f2dfda53e67bf22":
		{
			var_9c93ba8f = -12;
			break;
		}
		case "hash_5198ca6a3343ece8":
		{
			var_9c93ba8f = -1;
			break;
		}
		case "hash_1ecab55fd270f67b":
		{
			var_9c93ba8f = -20;
			break;
		}
		case "hash_1dc206ff31de03eb":
		{
			var_9c93ba8f = -2;
			break;
		}
		case "hash_15b4f3726a962ee0":
		{
			var_9c93ba8f = -1;
			break;
		}
		case "hash_3d85834be3aff6d2":
		{
			var_9c93ba8f = -15;
			break;
		}
		case "hash_1480b76eb0f2efe8":
		{
			var_9c93ba8f = -10;
			break;
		}
		case "hash_60f39c53ee3e0ec7":
		{
			var_9c93ba8f = -10;
			break;
		}
		case "hash_74fc45698491be88":
		{
			var_9c93ba8f = -15;
			break;
		}
		default:
		{
			var_9c93ba8f = 0;
			break;
		}
	}
	/#
		self thread zm_net::network_choke_action("", &function_f3e454c1, str_event);
	#/
	if(self.var_7df228aa.var_def266a8 <= 0 && self.var_7df228aa.var_def266a8 + var_9c93ba8f >= 0 || (self.var_7df228aa.var_def266a8 >= 0 && self.var_7df228aa.var_def266a8 + var_9c93ba8f <= 0))
	{
		var_ac39950d = 1;
	}
	self.var_7df228aa.var_def266a8 = self.var_7df228aa.var_def266a8 + var_9c93ba8f;
	self.var_7df228aa.var_def266a8 = math::clamp(self.var_7df228aa.var_def266a8, -50, 50);
	self thread function_9da7999d(var_9c93ba8f, var_ac39950d, str_event);
}

/*
	Name: function_f3e454c1
	Namespace: namespace_ebd828b
	Checksum: 0xF55423F9
	Offset: 0x3AF8
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function function_f3e454c1(str_text)
{
	/#
		if(function_7a600918(str_text))
		{
			if(isplayer(self))
			{
				self iprintlnbold(function_9e72a96(str_text));
			}
			else
			{
				iprintlnbold(function_9e72a96(str_text));
			}
		}
		else if(isplayer(self))
		{
			self iprintlnbold(str_text);
		}
		else
		{
			iprintlnbold(str_text);
		}
	#/
}

/*
	Name: function_9da7999d
	Namespace: namespace_ebd828b
	Checksum: 0x203A0AF3
	Offset: 0x3BD8
	Size: 0x2AC
	Parameters: 3
	Flags: Linked
*/
function function_9da7999d(var_9c93ba8f = 0, var_ac39950d = 0, str_event)
{
	n_amount = self.var_7df228aa.var_def266a8;
	if(!isdefined(level.var_c71183aa))
	{
		level.var_c71183aa = 0;
	}
	level.var_2d2de57a = level.var_c71183aa;
	var_db5bdee0 = #"hash_12d62358eda9bdf1";
	if(n_amount <= -50)
	{
		var_db5bdee0 = #"hash_752852f7958f9112";
		level.var_c71183aa = 1;
	}
	else if(n_amount > -50 && n_amount <= -25)
	{
		var_db5bdee0 = #"hash_1cf3b5099b38de89";
		level.var_c71183aa = 1;
	}
	else if(n_amount > -25 && n_amount <= 0)
	{
		var_db5bdee0 = #"hash_4977f8aaa598d06c";
		level.var_c71183aa = 0;
	}
	else if(n_amount > 0 && n_amount <= 25)
	{
		var_db5bdee0 = #"hash_7dc7bbe5b45f4135";
		level.var_c71183aa = 2;
	}
	else if(n_amount > 25 && n_amount < 50)
	{
		var_db5bdee0 = #"hash_ad45e7c545f8482";
		level.var_c71183aa = 3;
	}
	else if(n_amount >= 50)
	{
		var_db5bdee0 = #"hash_1fe268f088f7e729";
		level.var_c71183aa = 3;
	}
	self.var_7df228aa.var_21ce4da6 = var_db5bdee0;
	self function_dbe08c92(self.var_7df228aa.var_21ce4da6);
	if(!self.var_7df228aa.var_e6476b32 || var_ac39950d)
	{
		self thread function_acab98ce(var_db5bdee0, var_9c93ba8f, var_ac39950d, str_event);
	}
	self thread zm_net::network_choke_action("", &function_f3e454c1, "");
}

/*
	Name: function_acab98ce
	Namespace: namespace_ebd828b
	Checksum: 0x10339DAF
	Offset: 0x3E90
	Size: 0x49C
	Parameters: 4
	Flags: Linked
*/
function function_acab98ce(var_82c32aa7, var_9c93ba8f, var_ac39950d = 0, str_event)
{
	str_name = self.name;
	var_65b29bff = "";
	var_aee1a869 = 0;
	var_31571f8a = 0;
	if(self.var_7df228aa.var_712856c1 == #"hash_752852f7958f9112" || self.var_7df228aa.var_712856c1 == #"hash_1cf3b5099b38de89" || self.var_7df228aa.var_712856c1 == #"hash_4977f8aaa598d06c" && (var_82c32aa7 == #"hash_752852f7958f9112" || var_82c32aa7 == #"hash_1cf3b5099b38de89" || var_82c32aa7 == #"hash_4977f8aaa598d06c") && var_9c93ba8f > 0)
	{
		var_aee1a869 = 1;
	}
	else if(self.var_7df228aa.var_712856c1 == #"hash_7dc7bbe5b45f4135" || self.var_7df228aa.var_712856c1 == #"hash_ad45e7c545f8482" || self.var_7df228aa.var_712856c1 == #"hash_1fe268f088f7e729" && (var_82c32aa7 == #"hash_7dc7bbe5b45f4135" || var_82c32aa7 == #"hash_ad45e7c545f8482" || var_82c32aa7 == #"hash_1fe268f088f7e729") && var_9c93ba8f <= 0)
	{
		var_31571f8a = 1;
	}
	level clientfield::set("crowd_react", level.var_c71183aa);
	self.var_7df228aa.var_712856c1 = var_82c32aa7;
	switch(var_82c32aa7)
	{
		case "hash_752852f7958f9112":
		{
			var_ee93032f = 0;
			break;
		}
		case "hash_1cf3b5099b38de89":
		{
			var_ee93032f = 1;
			break;
		}
		case "hash_4977f8aaa598d06c":
		{
			var_ee93032f = 2;
			break;
		}
		case "hash_7dc7bbe5b45f4135":
		{
			var_ee93032f = 3;
			break;
		}
		case "hash_ad45e7c545f8482":
		{
			var_ee93032f = 4;
			break;
		}
		case "hash_1fe268f088f7e729":
		{
			var_ee93032f = 5;
			break;
		}
	}
	if(var_aee1a869)
	{
		var_ee93032f = 7;
	}
	else if(var_31571f8a)
	{
		var_ee93032f = 6;
	}
	if(level flag::get("special_round"))
	{
		if(var_ee93032f != 5)
		{
			self clientfield::set_to_player("snd_crowd_react", var_ee93032f);
		}
	}
	else if(isdefined(level.var_412df700) && level.var_412df700)
	{
		if(var_ee93032f != 5)
		{
			self clientfield::set_to_player("snd_crowd_react", var_ee93032f);
		}
	}
	else
	{
		self clientfield::set_to_player("snd_crowd_react", var_ee93032f);
		self notify(#"hash_722941ef1aaab69f", {#str_event:str_event, #hash_ac39950d:var_ac39950d});
	}
	/#
		self thread zm_net::network_choke_action("", &function_f3e454c1, function_9e72a96(var_82c32aa7) + self.name);
	#/
	if(!var_ac39950d)
	{
		self thread function_692a63ae();
	}
}

/*
	Name: function_bdb90d4
	Namespace: namespace_ebd828b
	Checksum: 0xA755107
	Offset: 0x4338
	Size: 0x378
	Parameters: 0
	Flags: Linked
*/
function function_bdb90d4()
{
	level endon(#"end_game");
	self endon(#"death");
	if(zm_utility::is_standard())
	{
		return;
	}
	var_a849ed96 = array(#"hash_752852f7958f9112", #"hash_1cf3b5099b38de89", #"hash_4977f8aaa598d06c", #"hash_7dc7bbe5b45f4135", #"hash_ad45e7c545f8482", #"hash_1fe268f088f7e729");
	var_8f46fbc3 = self.var_7df228aa.var_21ce4da6;
	var_8b88a695 = array::find(var_a849ed96, var_8f46fbc3);
	while(true)
	{
		var_2b9164d3 = 0;
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_722941ef1aaab69f");
		var_ac39950d = var_be17187b.var_ac39950d;
		var_aa1b1bfd = self.var_7df228aa.var_21ce4da6;
		var_4245b6a3 = array::find(var_a849ed96, var_aa1b1bfd);
		if(var_aa1b1bfd == var_8f46fbc3 || var_be17187b.str_event == #"hash_197ae1fc115dc636" || var_be17187b.str_event == #"hash_5d587a946bd4f958")
		{
			continue;
		}
		switch(var_aa1b1bfd)
		{
			case "hash_752852f7958f9112":
			{
				str_category = "negative_terrible";
				break;
			}
			case "hash_1cf3b5099b38de89":
			{
				str_category = "negative_poor";
				break;
			}
			case "hash_4977f8aaa598d06c":
			{
				str_category = "negative_poor";
				break;
			}
			case "hash_7dc7bbe5b45f4135":
			{
				var_2b9164d3 = 1;
				str_category = "positive_good";
				break;
			}
			case "hash_ad45e7c545f8482":
			{
				var_2b9164d3 = 1;
				str_category = "positive_great";
				break;
			}
			case "hash_1fe268f088f7e729":
			{
				var_2b9164d3 = 1;
				str_category = "positive_immac";
				break;
			}
		}
		if(var_4245b6a3 < var_8b88a695 && var_aa1b1bfd != #"hash_752852f7958f9112")
		{
			var_2b9164d3 = 0;
			str_category = "negative_poor";
		}
		if(var_4245b6a3 > var_8b88a695 && var_aa1b1bfd != #"hash_1fe268f088f7e729")
		{
			str_category = "positive_good";
		}
		self thread function_1d9a9b89(str_category, var_2b9164d3, var_ac39950d);
		var_8f46fbc3 = var_aa1b1bfd;
		var_8b88a695 = var_4245b6a3;
	}
}

/*
	Name: function_1d9a9b89
	Namespace: namespace_ebd828b
	Checksum: 0xF02D7544
	Offset: 0x46B8
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function function_1d9a9b89(str_category, var_2b9164d3, var_ac39950d)
{
	self notify("3768bf148fdac027");
	self endon("3768bf148fdac027");
	self endon(#"death");
	if(var_2b9164d3)
	{
		level zm_audio::sndannouncerplayvox(#"hash_5f0f1e699aa7e761", self);
	}
	else
	{
		wait(2);
	}
	if(!var_ac39950d && (isdefined(self.var_7df228aa.var_e6476b32) && self.var_7df228aa.var_e6476b32))
	{
		return;
	}
	str_zone = self zm_zonemgr::get_player_zone();
	if(!isinarray(level.var_3d702dc9, str_zone))
	{
		return;
	}
	self thread namespace_891c9bac::function_a2bd5a0c(#"vox_crowd_" + str_category, 0, 0, undefined, 1, 1);
}

/*
	Name: function_9c5fb1b5
	Namespace: namespace_ebd828b
	Checksum: 0xB583F95D
	Offset: 0x47F0
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function function_9c5fb1b5()
{
	var_748cd0a0 = 0;
	level.var_412df700 = 0;
	if(namespace_f551babc::function_b47f6aba() || zm_utility::is_standard() || zm_utility::function_2438c536())
	{
		return;
	}
	while(true)
	{
		level waittill(#"end_of_round");
		level.var_412df700 = 1;
		if(!(isdefined(level.var_9a992b09) && level.var_9a992b09))
		{
			if(zm_audio::sndmusicsystem_isabletoplay())
			{
				foreach(player in level.players)
				{
					if(!(isdefined(var_748cd0a0) && var_748cd0a0))
					{
						player clientfield::set_to_player("snd_crowd_react", 10);
					}
				}
			}
		}
		var_748cd0a0 = 0;
		level waittill(#"start_of_round");
		level util::delay(18, "end_of_round", &function_6ddff873);
		if(!(isdefined(level.var_9a992b09) && level.var_9a992b09))
		{
			if(zm_audio::sndmusicsystem_isabletoplay())
			{
				foreach(player in level.players)
				{
					if(level flag::get("special_round"))
					{
						level notify(#"hash_37b8eeaed85f1b4c");
						player clientfield::set_to_player("snd_crowd_react", 14);
						var_748cd0a0 = 1;
						level thread function_75d594ec();
						continue;
					}
					player clientfield::set_to_player("snd_crowd_react", 9);
				}
			}
		}
	}
}

/*
	Name: function_6ddff873
	Namespace: namespace_ebd828b
	Checksum: 0xB26495AF
	Offset: 0x4AD8
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_6ddff873()
{
	level.var_412df700 = 0;
	if(!(isdefined(level.var_9a992b09) && level.var_9a992b09))
	{
		if(!level flag::get("special_round"))
		{
			foreach(player in level.players)
			{
				if(player function_aa0b6eb())
				{
					player clientfield::set_to_player("snd_crowd_react", 5);
				}
			}
		}
	}
}

/*
	Name: function_75d594ec
	Namespace: namespace_ebd828b
	Checksum: 0x7A3E8780
	Offset: 0x4BC8
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_75d594ec()
{
	level endon(#"end_game");
	level waittill(#"hash_7b9245ff51f3d4f7");
	if(zm_audio::sndmusicsystem_isabletoplay())
	{
		foreach(player in level.players)
		{
			player clientfield::set_to_player("snd_crowd_react", 15);
		}
	}
	else
	{
		foreach(player in level.players)
		{
			player clientfield::set_to_player("snd_crowd_react", 16);
		}
	}
}

/*
	Name: function_dbe08c92
	Namespace: namespace_ebd828b
	Checksum: 0x400297A4
	Offset: 0x4D18
	Size: 0x2E2
	Parameters: 2
	Flags: Linked
*/
function function_dbe08c92(var_82c32aa7, var_bec704d1)
{
	if(zm_utility::is_standard())
	{
		return;
	}
	if(!level.var_210ce105 zm_towers_crowd_meter::is_open(self))
	{
		level.var_210ce105 zm_towers_crowd_meter::open(self);
	}
	if(isdefined(self.var_7df228aa.var_4c83f6a2) && self.var_7df228aa.var_4c83f6a2)
	{
		if(isdefined(var_bec704d1))
		{
			if(var_bec704d1)
			{
				if(self.var_7df228aa.var_def266a8 >= 50)
				{
					level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_good");
				}
				else
				{
					level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_good_partial");
				}
			}
			else if(self.var_7df228aa.var_def266a8 <= -50)
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_bad");
			}
			else
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_power_up_available_bad_partial");
			}
		}
		return;
	}
	if(isdefined(var_82c32aa7))
	{
		switch(var_82c32aa7)
		{
			case "hash_752852f7958f9112":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_loathes");
				break;
			}
			case "hash_1cf3b5099b38de89":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_hates");
				break;
			}
			case "hash_4977f8aaa598d06c":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_no_love");
				break;
			}
			case "hash_7dc7bbe5b45f4135":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_warm_up");
				break;
			}
			case "hash_ad45e7c545f8482":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_likes");
				break;
			}
			case "hash_1fe268f088f7e729":
			{
				level.var_210ce105 zm_towers_crowd_meter::set_state(self, "crowd_loves");
				break;
			}
		}
	}
}

/*
	Name: function_692a63ae
	Namespace: namespace_ebd828b
	Checksum: 0xA653E028
	Offset: 0x5008
	Size: 0xD2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_692a63ae()
{
	self notify("5a2e6094bb4e37c6");
	self endon("5a2e6094bb4e37c6");
	self endon(#"disconnect");
	/#
		if(level flag::get(""))
		{
			return;
		}
	#/
	self.var_7df228aa.var_e6476b32 = 1;
	if(self.var_7df228aa.var_def266a8 >= 50 || self.var_7df228aa.var_def266a8 <= -50)
	{
		var_628a2951 = 20;
	}
	else
	{
		var_628a2951 = 10;
	}
	wait(var_628a2951);
	self.var_7df228aa.var_e6476b32 = 0;
}

/*
	Name: function_8e83be5d
	Namespace: namespace_ebd828b
	Checksum: 0xA937CC82
	Offset: 0x50E8
	Size: 0x228
	Parameters: 0
	Flags: Linked
*/
function function_8e83be5d()
{
	level endon(#"end_game");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_5198ca6a3343ece8", #"trap_kill", #"trap_activated");
		switch(waitresult._notify)
		{
			case "hash_5198ca6a3343ece8":
			{
				e_player = waitresult.player;
				if(!isplayer(e_player))
				{
					continue;
				}
				if(waitresult.weapon === level.var_3891e803 || waitresult.weapon === level.var_d7f4cb84)
				{
					str_event = #"hash_689abcb17111463";
				}
				else
				{
					waitresult.zombie function_308a32f0(e_player);
				}
				break;
			}
			case "trap_activated":
			{
				e_player = waitresult.var_dd54ffdb;
				str_event = #"trap_activated";
				break;
			}
			case "trap_kill":
			{
				if(isplayer(waitresult.e_victim))
				{
					e_player = waitresult.e_victim;
					str_event = #"hash_1f2dfda53e67bf22";
				}
				else
				{
					e_player = waitresult.e_trap.activated_by_player;
					str_event = #"trap_kill";
				}
				break;
			}
		}
		if(isplayer(e_player) && isdefined(str_event))
		{
			e_player function_b8dfa139(str_event);
		}
	}
}

/*
	Name: function_7469866d
	Namespace: namespace_ebd828b
	Checksum: 0x76377EFC
	Offset: 0x5318
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function function_7469866d()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"player_downed", #"bled_out", #"player_did_a_revive", #"hash_53620e40c7e139b9", #"destroy_riotshield", #"hash_74fc45698491be88", #"hash_60f39c53ee3e0ec7");
		switch(waitresult._notify)
		{
			case "player_downed":
			{
				str_event = #"player_down";
				break;
			}
			case "bled_out":
			{
				str_event = #"player_death";
				break;
			}
			case "player_did_a_revive":
			{
				if(waitresult.revived_player != self)
				{
					if(waitresult.revived_player.bleedout_time < 5)
					{
						str_event = #"hash_5d587a946bd4f958";
					}
					else
					{
						str_event = #"hash_197ae1fc115dc636";
					}
				}
				break;
			}
			case "hash_53620e40c7e139b9":
			{
				str_event = #"hash_1dc206ff31de03eb";
				break;
			}
			case "destroy_riotshield":
			{
				str_event = #"hash_1480b76eb0f2efe8";
				break;
			}
			case "hash_60f39c53ee3e0ec7":
			{
				str_event = #"hash_60f39c53ee3e0ec7";
				break;
			}
			case "hash_74fc45698491be88":
			{
				str_event = #"hash_74fc45698491be88";
				break;
			}
		}
		if(isdefined(str_event))
		{
			self function_b8dfa139(str_event);
			str_event = undefined;
		}
	}
}

/*
	Name: function_308a32f0
	Namespace: namespace_ebd828b
	Checksum: 0x7C08B411
	Offset: 0x5588
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_308a32f0(e_player)
{
	self endon(#"death");
	e_player endon(#"disconnect");
	while(isalive(self))
	{
		wait(10);
		e_player function_b8dfa139(#"hash_5198ca6a3343ece8");
	}
}

/*
	Name: function_fbf74c49
	Namespace: namespace_ebd828b
	Checksum: 0xEB78B753
	Offset: 0x5600
	Size: 0x40C
	Parameters: 0
	Flags: None
*/
function function_fbf74c49()
{
	/#
		level flag::init("");
		level flag::init("");
		zm_devgui::add_custom_devgui_callback(&function_e0bb973);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			adddebugcommand("");
		}
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("" + 240 + "");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		level thread function_eb6ff6a5();
	#/
}

/*
	Name: function_eb6ff6a5
	Namespace: namespace_ebd828b
	Checksum: 0x37316710
	Offset: 0x5A18
	Size: 0x102
	Parameters: 0
	Flags: None
*/
function function_eb6ff6a5()
{
	/#
		while(true)
		{
			if(level flag::get(""))
			{
				foreach(i, player in level.players)
				{
					debug2dtext((1100, 300 + 20 * i, 0), player.name + "" + player.var_7df228aa.var_def266a8, undefined, undefined, undefined, 1);
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_e0bb973
	Namespace: namespace_ebd828b
	Checksum: 0x4CF072C0
	Offset: 0x5B28
	Size: 0x8A2
	Parameters: 1
	Flags: None
*/
function function_e0bb973(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_b988aa7a2727ae5":
			{
				level flag::set(#"crowd_throw_item_immediate");
				level flag::set(#"hash_1a9f6d0c1e7684b4");
				level flag::clear(#"hash_80fa0541e21f744");
				break;
			}
			case "hash_4840e9ef3902deb3":
			{
				level flag::set(#"crowd_throw_item_immediate");
				level flag::clear(#"hash_1a9f6d0c1e7684b4");
				level flag::set(#"hash_80fa0541e21f744");
				break;
			}
			case "hash_4f715fd76b8686d":
			{
				level flag::toggle("");
				if(level flag::get(""))
				{
					thread zm_net::network_choke_action("", &function_f3e454c1, "");
					foreach(player in level.players)
					{
						player.var_7df228aa.var_e6476b32 = 0;
					}
				}
				else
				{
					thread zm_net::network_choke_action("", &function_f3e454c1, "" + 10 + "");
				}
				break;
			}
			case "hash_f7e831658b8fb28":
			{
				level flag::toggle("");
				break;
			}
			case "hash_4b6ce84335cf00ad":
			{
				if(!isdefined(level.var_55fdc354))
				{
					level.var_55fdc354 = 0;
				}
				switch(level.var_55fdc354)
				{
					case 0:
					{
						iprintlnbold("");
						function_5c1184e(1);
						function_aec5ec5a(0);
						function_696a8df0(0);
						function_8237489a(0);
						break;
					}
					case 1:
					{
						iprintlnbold("");
						function_aec5ec5a(1);
						function_5c1184e(0);
						function_696a8df0(0);
						function_8237489a(0);
						break;
					}
					case 2:
					{
						iprintlnbold("");
						function_696a8df0(1);
						function_5c1184e(0);
						function_aec5ec5a(0);
						function_8237489a(0);
						break;
					}
					case 3:
					{
						iprintlnbold("");
						function_8237489a(1);
						function_5c1184e(0);
						function_aec5ec5a(0);
						function_696a8df0(0);
						break;
					}
				}
				level.var_55fdc354++;
				if(zm_utility::function_e51dc2d8())
				{
					if(level.var_55fdc354 > 3)
					{
						level.var_55fdc354 = 0;
					}
				}
				else if(level.var_55fdc354 > 2)
				{
					level.var_55fdc354 = 0;
				}
				wait(0.5);
				break;
			}
			case "hash_1e51753996594cc3":
			{
				iprintlnbold("");
				level.var_55fdc354 = 3;
				function_8237489a(1);
				function_5c1184e(0);
				function_aec5ec5a(0);
				function_696a8df0(0);
				level thread function_10ef0925();
				break;
			}
			case "hash_131b705484b2876":
			case "hash_689abcb17111463":
			case "hash_8686f01be1cd8b5":
			case "hash_c65bc15b1aeb1bb":
			case "hash_c65bd15b1aeb36e":
			case "hash_c65be15b1aeb521":
			case "hash_1480b76eb0f2efe8":
			case "hash_158076998c9b511f":
			case "hash_15b4f3726a962ee0":
			case "hash_197ae1fc115dc636":
			case "hash_19fccc380453c9fa":
			case "hash_1dc206ff31de03eb":
			case "hash_1ecab55fd270f67b":
			case "hash_1f2dfda53e67bf22":
			case "crawler_kill":
			case "hash_2048e4bc4cd51960":
			case "hash_27aa025524aa2a01":
			case "hash_29a47f9b217e8b1c":
			case "hash_3d85834be3aff6d2":
			case "hash_4122108abe671eb7":
			case "trap_kill":
			case "hash_5198ca6a3343ece8":
			case "trap_activated":
			case "hash_5986c925a370e137":
			case "hash_5d587a946bd4f958":
			case "hash_60f39c53ee3e0ec7":
			case "player_down":
			case "player_death":
			case "hash_74fc45698491be88":
			case "hash_755bc5e6c3486dc4":
			case "hash_7d48d521481272cf":
			{
				foreach(player in level.activeplayers)
				{
					var_d80019d9 = hash(cmd);
					player function_b8dfa139(var_d80019d9);
				}
				break;
			}
		}
	#/
}

