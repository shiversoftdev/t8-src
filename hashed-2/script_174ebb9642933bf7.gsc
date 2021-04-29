// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_df88241c;

/*
	Name: function_89f2df9
	Namespace: namespace_df88241c
	Checksum: 0xC140230F
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_18c69cd2b0bf61b9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_df88241c
	Checksum: 0x192D3BC1
	Offset: 0x1B8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_f4f794bf = array(5, 7, 9, 12);
	level.nova_crawler_spawner = getent("nova_crawler_spawner", "script_noteworthy");
	spawner::add_archetype_spawn_function(#"nova_crawler", &function_b38636ed);
	namespace_c3287616::register_archetype(#"nova_crawler", &function_c73902fd, &function_ccdfa71b, &function_33bf3983, 10);
	zm_score::function_e5d6e6dd(#"nova_crawler", 60);
}

/*
	Name: function_b38636ed
	Namespace: namespace_df88241c
	Checksum: 0x14495D82
	Offset: 0x2C8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_b38636ed()
{
	level thread zm_spawner::zombie_death_event(self);
}

/*
	Name: function_c73902fd
	Namespace: namespace_df88241c
	Checksum: 0x69B99B21
	Offset: 0x2F0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_c73902fd(var_dbce0c44)
{
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	var_8cf00d40 = int(floor(var_dbce0c44 / 10));
	return var_8cf00d40;
}

/*
	Name: function_ccdfa71b
	Namespace: namespace_df88241c
	Checksum: 0x9C070C82
	Offset: 0x368
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_ccdfa71b()
{
	ai = function_33bf3983();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_33bf3983
	Namespace: namespace_df88241c
	Checksum: 0x90061B17
	Offset: 0x3B0
	Size: 0x18E
	Parameters: 1
	Flags: Linked
*/
function function_33bf3983(var_8b952619 = undefined)
{
	var_d8d8ce1b = undefined;
	if(function_4748fb49() < function_59257d57() && (!(isdefined(level.var_5e45f817) && level.var_5e45f817)) && (isdefined(level.zm_loc_types[#"hash_506aba309cfe3f56"]) && level.zm_loc_types[#"hash_506aba309cfe3f56"].size > 0))
	{
		var_d8d8ce1b = zombie_utility::spawn_zombie(level.nova_crawler_spawner);
		if(isdefined(var_d8d8ce1b))
		{
			var_d8d8ce1b.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
			var_d8d8ce1b thread zombie_utility::round_spawn_failsafe();
			if(isdefined(var_8b952619))
			{
				var_d8d8ce1b function_e2bab5ec(var_8b952619);
				var_8b952619.var_d51f4e2d = gettime();
			}
			else
			{
				spawn_location = var_d8d8ce1b function_9216fd1f();
				if(isdefined(spawn_location))
				{
					var_d8d8ce1b function_e2bab5ec(spawn_location);
					spawn_location.var_d51f4e2d = gettime();
				}
			}
		}
	}
	return var_d8d8ce1b;
}

/*
	Name: function_59257d57
	Namespace: namespace_df88241c
	Checksum: 0x792D0323
	Offset: 0x548
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_59257d57()
{
	if(level flag::exists("nova_crawlers_round") && level flag::get("nova_crawlers_round"))
	{
		return level.zombie_ai_limit;
	}
	if(zm_utility::function_3bff983f())
	{
		return level.var_f4f794bf[level.players.size - 1] * 2;
	}
	return level.var_f4f794bf[level.players.size - 1];
}

/*
	Name: function_4748fb49
	Namespace: namespace_df88241c
	Checksum: 0xA1DFFF98
	Offset: 0x600
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_4748fb49()
{
	var_ccd08b96 = getaiarchetypearray(#"nova_crawler");
	var_cc9e7e12 = var_ccd08b96.size;
	foreach(var_2c217682 in var_ccd08b96)
	{
		if(!isalive(var_2c217682))
		{
			var_cc9e7e12--;
		}
	}
	return var_cc9e7e12;
}

/*
	Name: function_6b8c8cd1
	Namespace: namespace_df88241c
	Checksum: 0xDE49FF09
	Offset: 0x6C8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_6b8c8cd1(n_round)
{
	namespace_c3287616::function_b4a8f95a(#"nova_crawler", n_round, &crawler_round_start, &function_c33b7bb5, &function_f6e748b, &function_f726e44, 0);
}

/*
	Name: crawler_round_start
	Namespace: namespace_df88241c
	Checksum: 0x6D16F449
	Offset: 0x740
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function crawler_round_start()
{
	level flag::set(#"hash_2a1fc2e349c48462");
	level flag::set("crawler_round");
}

/*
	Name: function_c33b7bb5
	Namespace: namespace_df88241c
	Checksum: 0xD0A3A13B
	Offset: 0x790
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_c33b7bb5(var_d25bbdd5)
{
	level flag::clear(#"hash_2a1fc2e349c48462");
	level flag::clear("crawler_round");
}

/*
	Name: function_f6e748b
	Namespace: namespace_df88241c
	Checksum: 0xCE3EDB28
	Offset: 0x7E8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_f6e748b()
{
	return 40 * (isdefined(level.var_71bc2e8f) ? level.var_71bc2e8f : 1);
}

/*
	Name: function_f726e44
	Namespace: namespace_df88241c
	Checksum: 0x622B9503
	Offset: 0x820
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_f726e44(count, max)
{
	wait(randomfloatrange(0.25, 0.5));
}

/*
	Name: function_a5abd591
	Namespace: namespace_df88241c
	Checksum: 0x1C77ACD8
	Offset: 0x860
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_a5abd591()
{
	var_5935bd0e = array::randomize(level.activeplayers);
	e_target = undefined;
	foreach(e_player in var_5935bd0e)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			e_target = e_player;
			break;
		}
	}
	return e_target;
}

/*
	Name: function_9a898f07
	Namespace: namespace_df88241c
	Checksum: 0xFC0C4E29
	Offset: 0x928
	Size: 0x2CA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9a898f07(e_target)
{
	if(isdefined(level.zm_loc_types[#"hash_506aba309cfe3f56"]) && level.zm_loc_types[#"hash_506aba309cfe3f56"].size > 0)
	{
		var_a6c95035 = [];
		var_5f3b05e8 = e_target zm_zonemgr::get_player_zone();
		if(!isdefined(var_5f3b05e8))
		{
			return undefined;
		}
		var_c61e7ea7 = level.zones[var_5f3b05e8];
		var_24f5d9f8 = array(var_c61e7ea7.name);
		var_e15699c4 = getarraykeys(var_c61e7ea7.adjacent_zones);
		foreach(str_zone in var_e15699c4)
		{
			if(var_c61e7ea7.adjacent_zones[str_zone].is_connected)
			{
				if(!isdefined(var_24f5d9f8))
				{
					var_24f5d9f8 = [];
				}
				else if(!isarray(var_24f5d9f8))
				{
					var_24f5d9f8 = array(var_24f5d9f8);
				}
				var_24f5d9f8[var_24f5d9f8.size] = str_zone;
			}
		}
		foreach(loc in level.zm_loc_types[#"hash_506aba309cfe3f56"])
		{
			if(array::contains(var_24f5d9f8, loc.zone_name))
			{
				if(!isdefined(var_a6c95035))
				{
					var_a6c95035 = [];
				}
				else if(!isarray(var_a6c95035))
				{
					var_a6c95035 = array(var_a6c95035);
				}
				var_a6c95035[var_a6c95035.size] = loc;
			}
		}
		s_spawn_loc = array::random(var_a6c95035);
	}
	return s_spawn_loc;
}

/*
	Name: function_87348a88
	Namespace: namespace_df88241c
	Checksum: 0xBDD88F8A
	Offset: 0xC00
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_87348a88(e_target)
{
	var_8b952619 = function_9a898f07(e_target);
	return function_33bf3983(var_8b952619);
}

/*
	Name: function_9216fd1f
	Namespace: namespace_df88241c
	Checksum: 0x91B9470B
	Offset: 0xC50
	Size: 0xE2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9216fd1f()
{
	spawn_locations = [];
	spawn_location = undefined;
	if(isdefined(level.zm_loc_types[#"hash_506aba309cfe3f56"]))
	{
		spawn_locations = level.zm_loc_types[#"hash_506aba309cfe3f56"];
	}
	if(spawn_locations.size > 0)
	{
		if(!isdefined(spawn_location))
		{
			spawn_info = zm_spawner::function_dce9f1a6(spawn_locations);
			spawn_location = spawn_info.spot;
		}
		if(!isdefined(spawn_location))
		{
			spawn_location = zm_spawner::function_65439499(spawn_locations);
		}
		if(!isdefined(spawn_location))
		{
			spawn_location = array::random(spawn_locations);
		}
	}
	return spawn_location;
}

/*
	Name: function_e2bab5ec
	Namespace: namespace_df88241c
	Checksum: 0x634E9FD9
	Offset: 0xD40
	Size: 0x2F6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e2bab5ec(spot)
{
	if(isdefined(self.anchor))
	{
		return;
	}
	if(isdefined(spot.script_int) && spot.script_int == 1)
	{
		self.custom_riseanim = "ai_t8_zm_quad_traverse_ground_crawlfast";
		self thread zm_spawner::do_zombie_rise(spot);
		self thread function_a672326a();
	}
	else
	{
		self.anchor = spawn("script_origin", self.origin);
		self.anchor.angles = self.angles;
		self linkto(self.anchor);
		self.anchor thread zm_utility::anchor_delete_failsafe(self);
		if(!isdefined(spot.angles))
		{
			spot.angles = (0, 0, 0);
		}
		self ghost();
		self.anchor moveto(spot.origin, 0.05);
		self.anchor waittill(#"movedone");
		target_org = zombie_utility::get_desired_origin();
		if(isdefined(target_org))
		{
			anim_ang = vectortoangles(target_org - self.origin);
			self.anchor rotateto((0, anim_ang[1], 0), 0.05);
			self.anchor waittill(#"rotatedone");
		}
		if(isdefined(level.zombie_spawn_fx))
		{
			playfx(level.zombie_spawn_fx, spot.origin);
		}
		self unlink();
		if(isdefined(self.anchor))
		{
			self.anchor delete();
		}
		if(!(isdefined(self.dontshow) && self.dontshow))
		{
			self show();
		}
		self notify(#"spawn_complete");
		self notify(#"risen", {#find_flesh_struct_string:spot.script_string});
	}
}

/*
	Name: function_a672326a
	Namespace: namespace_df88241c
	Checksum: 0x699620B3
	Offset: 0x1040
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_a672326a()
{
	self endon(#"death");
	self waittill(#"rise_anim_finished");
	self notify(#"spawn_complete");
}

/*
	Name: function_c44636f2
	Namespace: namespace_df88241c
	Checksum: 0xFD0C9171
	Offset: 0x1088
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function function_c44636f2(b_ignore_cleanup = 1)
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_4deb3ae7a73c87f3") || (isdefined(level.var_5e45f817) && level.var_5e45f817))
	{
		return;
	}
	level.var_1ba6a97c = 1;
	level.var_8167b1e = b_ignore_cleanup;
	/#
		assert(isdefined(level.var_807ffa2e));
	#/
	level thread [[level.var_807ffa2e]]();
}

/*
	Name: function_5b0522fa
	Namespace: namespace_df88241c
	Checksum: 0xFAB593EC
	Offset: 0x1148
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function function_5b0522fa()
{
	level.var_f5419c22 = 20;
	namespace_c3287616::function_b4a8f95a(#"nova_crawler", level.var_f5419c22, &function_9e97e0f7, &function_de265920, &function_70a8e26c, &function_d7e9e2ff, level.var_8167b1e);
	zm_utility::function_fdb0368(11);
	level flagsys::set(#"hash_2a1fc2e349c48462");
}

/*
	Name: function_9e97e0f7
	Namespace: namespace_df88241c
	Checksum: 0x257FC13E
	Offset: 0x1210
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_9e97e0f7()
{
	level flag::set(#"hash_2a1fc2e349c48462");
}

/*
	Name: function_de265920
	Namespace: namespace_df88241c
	Checksum: 0x25289A31
	Offset: 0x1240
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_de265920(var_d25bbdd5)
{
	level flag::clear(#"hash_2a1fc2e349c48462");
	wait(5);
}

/*
	Name: function_70a8e26c
	Namespace: namespace_df88241c
	Checksum: 0xE93EA84C
	Offset: 0x1280
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_70a8e26c()
{
	a_e_players = getplayers();
	n_max = namespace_a28acff3::get_zombie_count_for_round(level.var_f5419c22, a_e_players.size);
	return int(n_max * 0.6);
}

/*
	Name: function_d7e9e2ff
	Namespace: namespace_df88241c
	Checksum: 0x6B94D3C7
	Offset: 0x12F0
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_d7e9e2ff()
{
	wait(0.1);
}

