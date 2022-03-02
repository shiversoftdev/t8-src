// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3f9e0dc8454d98e1;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_mansion.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_a34af286;

/*
	Name: init
	Namespace: namespace_a34af286
	Checksum: 0x87D0373D
	Offset: 0x268
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "" + #"hash_54cceab249a41cde", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_336942eaf5fcd809", 8000, 1, "int");
	/#
		clientfield::register("", "" + #"hash_3efe70d8ad68a07d", 8000, 4, "");
		clientfield::register("", "" + #"hash_4d30672cd0a2ef31", 8000, 1, "");
	#/
	function_c739f755();
	namespace_ee206246::start(#"hash_391f247dda2377a9");
	namespace_ee206246::start(#"hash_1fa9e2a949df3866");
	level thread function_da66169f();
}

/*
	Name: function_c739f755
	Namespace: namespace_a34af286
	Checksum: 0xF7FA9513
	Offset: 0x3E8
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	namespace_ee206246::register(#"hash_391f247dda2377a9", #"step_1", #"hash_21ed75bc8122939c", &function_f62d9f65, &function_6134319c);
	namespace_ee206246::register(#"hash_1fa9e2a949df3866", #"step_1", #"hash_af33b9072da5dc1", &function_653412f4, &function_f1611d1);
	namespace_ee206246::register(#"hash_1fa9e2a949df3866", #"step_2", #"hash_af3389072da58a8", &function_db5aff40, &function_4056f452);
	namespace_ee206246::register(#"hash_1fa9e2a949df3866", #"step_3", #"hash_af3399072da5a5b", &function_c7da583f, &function_2a93c8cc);
	namespace_ee206246::register(#"hash_1fa9e2a949df3866", #"step_4", #"hash_af33e9072da62da", &function_ae072499, &function_57e9237a);
	namespace_ee206246::register(#"hash_1fa9e2a949df3866", #"step_5", #"hash_af33f9072da648d", &function_9c3b8102, &function_4a0f87c7);
}

/*
	Name: function_da66169f
	Namespace: namespace_a34af286
	Checksum: 0x757032C1
	Offset: 0x638
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_da66169f()
{
	level flagsys::wait_till("start_zombie_round_logic");
	if(!isdefined(level.var_46169cd9))
	{
		function_23da5626();
	}
}

/*
	Name: function_653412f4
	Namespace: namespace_a34af286
	Checksum: 0xF8B75DD2
	Offset: 0x688
	Size: 0x2A4
	Parameters: 1
	Flags: Linked
*/
function function_653412f4(var_a276c861)
{
	level.var_46169cd9 = 0;
	level.var_87e6a031 = getweapon(#"hash_10f614b278daaebc");
	level.var_65397c04 = getweapon(#"mini_turret");
	level.var_62aaf679 = getweapon(#"claymore");
	callback::on_connect(&function_dd162dbf);
	level flagsys::wait_till("start_zombie_round_logic");
	/#
		function_c9854faa();
	#/
	function_23da5626();
	level flag::init(#"hash_2311d328e336b7d");
	level.var_a690f86 = struct::get_array(#"hash_36b57732bfe7db9d", "targetname");
	array::thread_all(level.var_a690f86, &function_9f6a9379);
	level.var_72b665d8 = 6;
	level.var_93aa61b1 = struct::get_array(#"hash_7007d299ddde4783", "targetname");
	function_21334921();
	level.var_403919f2 = array::sort_by_script_int(level.var_403919f2, 1);
	/#
		foreach(var_dc175e4d in level.var_403919f2)
		{
			if(isdefined(var_dc175e4d.var_f3ce8379))
			{
				var_dc175e4d.var_f3ce8379 thread function_95b6c945();
			}
		}
	#/
	if(!var_a276c861)
	{
		level waittill(#"hash_75e5d46ef453bd62");
	}
}

/*
	Name: function_f1611d1
	Namespace: namespace_a34af286
	Checksum: 0x881A709B
	Offset: 0x938
	Size: 0x1AA
	Parameters: 2
	Flags: Linked
*/
function function_f1611d1(var_a276c861, ended_early)
{
	callback::remove_on_connect(&function_dd162dbf);
	foreach(var_4ef73a79 in level.var_403919f2)
	{
		if(isdefined(var_4ef73a79.var_f3ce8379))
		{
			var_4ef73a79.var_f3ce8379 delete();
		}
		if(isdefined(var_4ef73a79.var_d7e8ee3e))
		{
			var_4ef73a79.var_d7e8ee3e delete();
		}
	}
	if(var_a276c861 || ended_early)
	{
		var_4ef294d8 = int(6 / getplayers().size);
		foreach(e_player in getplayers())
		{
			e_player.var_c859fa3a = var_4ef294d8;
		}
	}
}

/*
	Name: function_23da5626
	Namespace: namespace_a34af286
	Checksum: 0x115F3C1C
	Offset: 0xAF0
	Size: 0x31E
	Parameters: 0
	Flags: Linked
*/
function function_23da5626()
{
	level.var_403919f2 = getentarray("jordans_reward_merciless", "targetname");
	level.var_22aacd56 = level.var_403919f2.size;
	foreach(var_4ef73a79 in level.var_403919f2)
	{
		var_c189a18d = struct::get(var_4ef73a79.target, "targetname");
		var_f3ce8379 = util::spawn_model(var_c189a18d.model, var_c189a18d.origin, var_c189a18d.angles);
		var_f3ce8379 setscale(var_c189a18d.modelscale);
		var_4ef73a79.var_f3ce8379 = var_f3ce8379;
		var_d7e8ee3e = getent(var_4ef73a79.target, "targetname");
		var_4ef73a79.var_d7e8ee3e = var_d7e8ee3e;
	}
	level.var_1c929a74 = struct::get_array(#"hash_4b78fbb5c37b6fdf", "targetname");
	foreach(var_c453fc76 in level.var_1c929a74)
	{
		var_ce3d3ff6 = util::spawn_model(var_c453fc76.model, var_c453fc76.origin, var_c453fc76.angles);
		var_3a75e57c = struct::get(var_c453fc76.target, "targetname");
		var_a38bb9a8 = util::spawn_model(var_3a75e57c.model, var_3a75e57c.origin, var_3a75e57c.angles);
		var_c453fc76.var_ce3d3ff6 = var_ce3d3ff6;
		var_c453fc76.var_a38bb9a8 = var_a38bb9a8;
		var_c453fc76.var_ce3d3ff6 clientfield::set("" + #"hash_54cceab249a41cde", 1);
		var_c453fc76.b_lit = 1;
	}
}

/*
	Name: function_21334921
	Namespace: namespace_a34af286
	Checksum: 0x51CEB97F
	Offset: 0xE18
	Size: 0x366
	Parameters: 0
	Flags: Linked
*/
function function_21334921()
{
	var_519cd38c = array(#"connect_main_hall_to_forest_entrance", #"connect_ground_floor_to_cellar", #"connect_main_hall_to_library", #"connect_main_hall_to_dining_room", #"connect_library_to_cemetery_entrance", #"connect_dining_room_to_greenhouse_entrance");
	n_count = 0;
	while(n_count < level.var_403919f2.size)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(var_519cd38c);
		switch(var_be17187b._notify)
		{
			case "connect_main_hall_to_forest_entrance":
			{
				var_4ef73a79 = function_54765bde(0, 0);
				s_candle = function_54765bde(0, 1);
				break;
			}
			case "connect_ground_floor_to_cellar":
			{
				var_4ef73a79 = function_54765bde(1, 0);
				s_candle = function_54765bde(1, 1);
				break;
			}
			case "connect_main_hall_to_library":
			{
				var_4ef73a79 = function_54765bde(2, 0);
				s_candle = function_54765bde(2, 1);
				break;
			}
			case "connect_main_hall_to_dining_room":
			{
				var_4ef73a79 = function_54765bde(3, 0);
				s_candle = function_54765bde(3, 1);
				break;
			}
			case "connect_library_to_cemetery_entrance":
			{
				var_4ef73a79 = function_54765bde(4, 0);
				s_candle = function_54765bde(4, 1);
				break;
			}
			case "connect_dining_room_to_greenhouse_entrance":
			{
				var_4ef73a79 = function_54765bde(5, 0);
				s_candle = function_54765bde(5, 1);
				break;
			}
			default:
			{
				/#
					assert("");
				#/
				break;
			}
		}
		if(isdefined(var_4ef73a79))
		{
			var_4ef73a79.script_int = n_count;
			/#
				if(isdefined(var_4ef73a79.var_f3ce8379))
				{
					var_4ef73a79.var_f3ce8379.script_int = n_count;
				}
			#/
		}
		n_count++;
		if(isdefined(s_candle))
		{
			s_candle.script_int = level.var_403919f2.size - n_count;
		}
	}
}

/*
	Name: function_54765bde
	Namespace: namespace_a34af286
	Checksum: 0x1D98863F
	Offset: 0x1188
	Size: 0xEA
	Parameters: 2
	Flags: Linked
*/
function function_54765bde(var_11a2d7c6, var_8750fd81)
{
	switch(var_8750fd81)
	{
		case 0:
		{
			var_2c5a2dcc = level.var_403919f2;
			break;
		}
		case 1:
		{
			var_2c5a2dcc = level.var_1c929a74;
			break;
		}
	}
	foreach(e_thing in var_2c5a2dcc)
	{
		if(e_thing.script_index === var_11a2d7c6)
		{
			return e_thing;
		}
	}
}

/*
	Name: function_dd162dbf
	Namespace: namespace_a34af286
	Checksum: 0x70B365A7
	Offset: 0x1280
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_dd162dbf()
{
	self notify("21a67d99777d1f78");
	self endon("21a67d99777d1f78");
	level endon(#"hash_75e5d46ef453bd62");
	self endon(#"disconnect");
	if(!isdefined(self.var_c859fa3a))
	{
		self.var_c859fa3a = 0;
	}
	self thread grenade_throw_watcher();
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_5bef9c261ba48023");
		if(isdefined(self))
		{
			self.var_c859fa3a++;
		}
	}
}

/*
	Name: grenade_throw_watcher
	Namespace: namespace_a34af286
	Checksum: 0x914BA7BE
	Offset: 0x1348
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function grenade_throw_watcher()
{
	self notify("3cf135e64119b4db");
	self endon("3cf135e64119b4db");
	level endon(#"hash_75e5d46ef453bd62");
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"grenade_fire");
		e_grenade = var_be17187b.projectile;
		if(e_grenade.weapon !== level.var_87e6a031 && e_grenade.weapon !== level.var_65397c04 && e_grenade.weapon !== level.var_62aaf679)
		{
			self thread function_fefbf8c2(e_grenade);
		}
	}
}

/*
	Name: function_fefbf8c2
	Namespace: namespace_a34af286
	Checksum: 0x3A62F5AA
	Offset: 0x1448
	Size: 0x2FC
	Parameters: 1
	Flags: Linked
*/
function function_fefbf8c2(e_grenade)
{
	/#
		iprintln(("" + self.playernum) + "");
	#/
	var_be17187b = undefined;
	var_be17187b = e_grenade waittill(#"explode", #"death");
	if(var_be17187b._notify === #"explode")
	{
		if(isdefined(var_be17187b.position))
		{
			v_gren_pos = var_be17187b.position;
			foreach(var_4ef73a79 in level.var_403919f2)
			{
				var_a878db9b = 0;
				var_c189a18d = struct::get(var_4ef73a79.target, "targetname");
				if(isdefined(var_c189a18d))
				{
					n_z_diff = v_gren_pos[2] - var_c189a18d.origin[2];
					if(n_z_diff >= 0 && n_z_diff <= 30 && distance2dsquared(v_gren_pos, var_c189a18d.origin) < 121)
					{
						var_a878db9b = 1;
					}
				}
				if(var_a878db9b)
				{
					playsoundatposition(#"hash_61a756bc7b27f7", v_gren_pos);
					if(isdefined(var_4ef73a79.var_f3ce8379))
					{
						var_4ef73a79.var_f3ce8379 delete();
					}
					if(isdefined(var_4ef73a79.var_d7e8ee3e))
					{
						var_4ef73a79.var_d7e8ee3e delete();
					}
					if(var_4ef73a79.script_int === level.var_46169cd9)
					{
						level.var_46169cd9++;
						level.var_403919f2[var_4ef73a79.script_int] notify(#"hash_189a9352bff55b80");
						if(isdefined(self))
						{
							self notify(#"hash_5bef9c261ba48023");
						}
						wait(0.1);
						if(level.var_46169cd9 >= level.var_22aacd56)
						{
							level notify(#"hash_75e5d46ef453bd62");
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_db5aff40
	Namespace: namespace_a34af286
	Checksum: 0xF876E5E9
	Offset: 0x1750
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_db5aff40(var_a276c861)
{
	if(!var_a276c861)
	{
		level.var_d4854b67 = 0;
		level.var_1c929a74 = array::sort_by_script_int(level.var_1c929a74, 1);
		foreach(var_c453fc76 in level.var_1c929a74)
		{
			var_c453fc76 function_5a7f565a();
			var_c453fc76 thread function_8ead19be();
			/#
				var_c453fc76 thread function_95b6c945();
			#/
		}
		array::thread_all(util::get_active_players(#"allies"), &function_3a57d343);
		callback::on_spawned(&function_3a57d343);
		while(level.var_d4854b67 < level.var_1c929a74.size)
		{
			var_be17187b = undefined;
			var_be17187b = level waittill(#"hash_13411a5231901c2e");
			if(var_be17187b.var_8ee6e347 === level.var_d4854b67)
			{
				level.var_d4854b67++;
			}
			else
			{
				level.var_d4854b67 = -1;
				foreach(var_c453fc76 in level.var_1c929a74)
				{
					if(var_c453fc76.script_int != var_be17187b.var_8ee6e347)
					{
						var_c453fc76 function_5a7f565a();
					}
				}
			}
		}
	}
}

/*
	Name: function_4056f452
	Namespace: namespace_a34af286
	Checksum: 0x40E5C0A0
	Offset: 0x19C0
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_4056f452(var_a276c861, ended_early)
{
	foreach(var_c453fc76 in level.var_1c929a74)
	{
		var_c453fc76 function_b094be90(1);
	}
	callback::remove_on_spawned(&function_3a57d343);
}

/*
	Name: function_8ead19be
	Namespace: namespace_a34af286
	Checksum: 0x28226DC9
	Offset: 0x1A80
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_8ead19be()
{
	level endon(#"game_ended");
	self endon(#"hash_189a9352bff55b80");
	self thread function_84eca8f8();
	self.var_ce3d3ff6 setcandamage(1);
	self.var_ce3d3ff6.health = 9999;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self.var_ce3d3ff6 waittill(#"damage");
		self.var_ce3d3ff6.health = 9999;
		if(!self.b_lit)
		{
			if(isplayer(var_be17187b.attacker) && (var_be17187b.mod === "MOD_BURNED" || var_be17187b.mod === "MOD_PROJECTILE_SPLASH" || var_be17187b.mod === "MOD_EXPLOSIVE"))
			{
				self function_b094be90();
				break;
			}
		}
	}
}

/*
	Name: function_84eca8f8
	Namespace: namespace_a34af286
	Checksum: 0xBA9988BB
	Offset: 0x1BE0
	Size: 0x2AA
	Parameters: 0
	Flags: Linked
*/
function function_84eca8f8()
{
	level endon(#"game_ended");
	self endon(#"hash_189a9352bff55b80");
	var_4acd2b1 = self.origin + vectorscale((0, 0, 1), 8);
	while(true)
	{
		if(!self.b_lit)
		{
			var_6b43c32f = [];
			foreach(e_player in util::get_active_players(#"allies"))
			{
				if(isdefined(e_player.var_1de56cc8) && e_player.var_1de56cc8)
				{
					if(!isdefined(var_6b43c32f))
					{
						var_6b43c32f = [];
					}
					else if(!isarray(var_6b43c32f))
					{
						var_6b43c32f = array(var_6b43c32f);
					}
					var_6b43c32f[var_6b43c32f.size] = e_player;
				}
			}
			foreach(var_774bf522 in var_6b43c32f)
			{
				v_position = var_774bf522 getweaponmuzzlepoint();
				v_forward = v_position + (var_774bf522 getweaponforwarddir() * 1600);
				var_b2171ef7 = pointonsegmentnearesttopoint(v_position, v_forward, var_4acd2b1);
				if(distancesquared(var_b2171ef7, var_4acd2b1) < 10 && beamtrace(v_position, var_4acd2b1, 1, var_774bf522, 0, 0, self.var_ce3d3ff6)[#"fraction"] == 1)
				{
					self function_b094be90();
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_3a57d343
	Namespace: namespace_a34af286
	Checksum: 0xA9171A2C
	Offset: 0x1E98
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_3a57d343()
{
	self notify("69c331ec544efd5c");
	self endon("69c331ec544efd5c");
	self endon(#"death");
	level endon(#"hash_33d9d5dbe3f1e8c2");
	var_65c41cdf = getweapon(#"hash_c78156ba6aeda14");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"projectile_impact", #"projectile_impact_explode");
		if(var_be17187b.weapon === var_65c41cdf)
		{
			var_672c5523 = array::get_all_closest(var_be17187b.position, level.var_1c929a74, undefined, level.var_1c929a74.size, 96);
			foreach(var_c565a3b in var_672c5523)
			{
				if(!var_c565a3b.b_lit && bullettracepassed(var_c565a3b.origin, var_be17187b.position, 0, undefined))
				{
					var_c565a3b function_b094be90();
				}
			}
		}
	}
}

/*
	Name: function_b094be90
	Namespace: namespace_a34af286
	Checksum: 0x381780DD
	Offset: 0x2058
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_b094be90(var_5cae7dc6 = 0)
{
	if(!self.b_lit)
	{
		self.var_ce3d3ff6 setmodel(self.model);
		self.var_ce3d3ff6 clientfield::set("" + #"hash_54cceab249a41cde", 1);
		self.var_ce3d3ff6 setcandamage(0);
		self.b_lit = 1;
		level notify(#"hash_13411a5231901c2e", {#hash_8ee6e347:self.script_int});
		self notify(#"hash_4b152ceaa6708e09");
	}
	if(var_5cae7dc6)
	{
		self notify(#"hash_189a9352bff55b80");
	}
}

/*
	Name: function_5a7f565a
	Namespace: namespace_a34af286
	Checksum: 0xDB86FA2D
	Offset: 0x2160
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_5a7f565a()
{
	self.var_ce3d3ff6 setmodel(self.script_string);
	self.var_ce3d3ff6 clientfield::set("" + #"hash_54cceab249a41cde", 0);
	self.b_lit = 0;
}

/*
	Name: function_c7da583f
	Namespace: namespace_a34af286
	Checksum: 0xD5D27C20
	Offset: 0x21C8
	Size: 0x556
	Parameters: 1
	Flags: Linked
*/
function function_c7da583f(var_a276c861)
{
	if(!var_a276c861)
	{
		level.var_352e1e6f = 0;
		var_1cb747b2 = struct::get(#"hash_2ed75532bbac2791", "targetname");
		var_1cb747b2.var_f55eb63 = util::spawn_model(var_1cb747b2.model, var_1cb747b2.origin, var_1cb747b2.angles);
		s_trigger_pos = struct::get(var_1cb747b2.target, "targetname");
		s_trigger_pos.var_1cb747b2 = var_1cb747b2;
		var_1cb747b2.s_unitrigger_stub = s_trigger_pos zm_unitrigger::create(undefined, 48, &function_88685116, 1, 1);
		level flag::wait_till(#"hash_2311d328e336b7d");
		for(i = 0; i < level.var_a690f86.size; i++)
		{
			if(!isdefined(level.var_a690f86[i].script_int))
			{
				level.var_a690f86 = array::exclude(level.var_a690f86, level.var_a690f86[i]);
				break;
			}
		}
		level.var_a690f86 = array::sort_by_script_int(level.var_a690f86, 1);
		foreach(var_29c75f3 in level.var_a690f86)
		{
			if(isdefined(var_29c75f3.script_string))
			{
				if(level.var_969e8ac2.var_c0ceb69c === #"hash_1184db7e6252576")
				{
					level waittill(#"forever");
				}
				while(!isdefined(level.var_969e8ac2.var_c0ceb69c))
				{
					wait(1);
				}
				var_12d5912a = level.var_969e8ac2.var_c0ceb69c;
				if(var_12d5912a == #"hash_2b73105e32379a57")
				{
					var_12d5912a = #"red";
				}
				if(var_12d5912a != hash(var_29c75f3.script_string))
				{
					var_c58e489b = var_29c75f3;
					continue;
				}
			}
			n_radius = 48;
			if(isdefined(var_29c75f3.radius))
			{
				n_radius = var_29c75f3.radius;
			}
			var_29c75f3.s_unitrigger_stub = var_29c75f3 zm_unitrigger::create(undefined, n_radius, &function_4c925e67, 1, 1);
			/#
				var_29c75f3 thread function_95b6c945();
			#/
		}
		level.var_a690f86 = array::exclude(level.var_a690f86, var_c58e489b);
		while(level.var_352e1e6f < level.var_a690f86.size)
		{
			var_be17187b = undefined;
			var_be17187b = level waittill(#"hash_df5cf4747eb1cf1");
			if(var_be17187b.var_9ea53c54 === level.var_352e1e6f && var_be17187b.activator === level.var_a690f86[var_be17187b.var_9ea53c54].var_64c09f7f)
			{
				playsoundatposition(#"hash_ef68ee749dfd885" + level.var_352e1e6f, level.var_a690f86[var_be17187b.var_9ea53c54].origin);
				level.var_352e1e6f++;
				zm_unitrigger::unregister_unitrigger(level.var_a690f86[var_be17187b.var_9ea53c54].s_unitrigger_stub);
				level.var_a690f86[var_be17187b.var_9ea53c54] notify(#"hash_189a9352bff55b80");
			}
			else
			{
				if(isdefined(var_be17187b.var_9ea53c54))
				{
					playsoundatposition(#"hash_4ec26fe871550c11", level.var_a690f86[var_be17187b.var_9ea53c54].origin);
				}
				level.var_352e1e6f = -1;
			}
		}
	}
}

/*
	Name: function_2a93c8cc
	Namespace: namespace_a34af286
	Checksum: 0x23E02F09
	Offset: 0x2728
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_2a93c8cc(var_a276c861, ended_early)
{
	foreach(var_29c75f3 in level.var_a690f86)
	{
		zm_unitrigger::unregister_unitrigger(var_29c75f3.s_unitrigger_stub);
		if(isdefined(var_29c75f3.var_8656a4f1))
		{
			var_29c75f3.var_8656a4f1 delete();
		}
	}
	var_1cb747b2 = struct::get(#"hash_2ed75532bbac2791", "targetname");
	zm_unitrigger::unregister_unitrigger(var_1cb747b2.s_unitrigger_stub);
	if(isdefined(var_1cb747b2.var_f55eb63))
	{
		var_1cb747b2.var_f55eb63 delete();
	}
}

/*
	Name: function_9f6a9379
	Namespace: namespace_a34af286
	Checksum: 0xFBDA9D6F
	Offset: 0x2868
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_9f6a9379()
{
	var_8656a4f1 = getent(self.target, "targetname");
	self.var_8656a4f1 = var_8656a4f1;
	var_8656a4f1 callback::function_35a12f19(&function_11a5f9cf);
}

/*
	Name: function_11a5f9cf
	Namespace: namespace_a34af286
	Checksum: 0x9D3297BC
	Offset: 0x28D0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_11a5f9cf(var_be17187b)
{
	if(isplayer(var_be17187b.activator))
	{
		var_29c75f3 = struct::get(self.targetname, "target");
		level.var_72b665d8--;
		var_29c75f3.script_int = level.var_72b665d8;
		var_29c75f3.var_64c09f7f = var_be17187b.activator;
		if(!level.var_72b665d8)
		{
			level flag::set(#"hash_2311d328e336b7d");
		}
		self callback::function_b74bf3e(&function_11a5f9cf);
	}
}

/*
	Name: function_88685116
	Namespace: namespace_a34af286
	Checksum: 0x2B91FECB
	Offset: 0x29B0
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_88685116()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		if(isplayer(var_be17187b.activator))
		{
			level.var_3a4aa2ab = 1;
			var_be17187b.activator playsound(#"hash_7025b0d4a2011877");
			var_1cb747b2 = self.stub.related_parent.var_1cb747b2;
			if(isdefined(var_1cb747b2.var_f55eb63))
			{
				var_1cb747b2.var_f55eb63 delete();
			}
			zm_unitrigger::unregister_unitrigger(var_1cb747b2.s_unitrigger_stub);
		}
	}
}

/*
	Name: function_4c925e67
	Namespace: namespace_a34af286
	Checksum: 0xD227D889
	Offset: 0x2AB8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_4c925e67()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		if(isplayer(var_be17187b.activator) && (isdefined(level.var_3a4aa2ab) && level.var_3a4aa2ab))
		{
			var_a690f86 = self.stub.related_parent;
			level notify(#"hash_df5cf4747eb1cf1", {#activator:var_be17187b.activator, #hash_9ea53c54:var_a690f86.script_int});
		}
	}
}

/*
	Name: function_ae072499
	Namespace: namespace_a34af286
	Checksum: 0x1553F664
	Offset: 0x2BB0
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_ae072499(var_a276c861)
{
	if(!var_a276c861)
	{
		level.var_93aa61b1 = array::sort_by_script_int(level.var_93aa61b1, 1);
		level thread function_8fb5f04c();
		foreach(var_10372151 in level.var_93aa61b1)
		{
			/#
				if(isdefined(level.var_a5c2a627) && level.var_a5c2a627)
				{
					if(array::find(level.var_93aa61b1, var_10372151) < level.var_93aa61b1.size - 2)
					{
						continue;
					}
				}
				var_10372151 thread function_95b6c945();
			#/
			level.var_55a2003d.origin = var_10372151.origin;
			level.var_55a2003d.script_noteworthy = var_10372151.script_noteworthy;
			if(level.var_55a2003d.script_noteworthy === "last_spot")
			{
				level thread function_5579efc3(var_10372151);
			}
			n_trigger_radius = 64;
			if(isdefined(var_10372151.radius))
			{
				n_trigger_radius = var_10372151.radius;
			}
			var_10372151.s_unitrigger_stub = var_10372151 zm_unitrigger::create(undefined, n_trigger_radius, &function_1d7382d0, 0, 1);
			var_10372151 waittill(#"hash_72fd666f6ed5a284");
			zm_unitrigger::unregister_unitrigger(var_10372151.s_unitrigger_stub);
			if(level.var_55a2003d.script_noteworthy !== "last_spot")
			{
				var_40388281 = var_10372151;
				while(isdefined(var_40388281))
				{
					var_40388281 = function_5579efc3(var_40388281);
				}
			}
		}
		if(isdefined(level.var_55a2003d))
		{
			level.var_55a2003d delete();
		}
		level notify(#"hash_60740a7ad79fbe01");
	}
}

/*
	Name: function_57e9237a
	Namespace: namespace_a34af286
	Checksum: 0x8B49C017
	Offset: 0x2E78
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function function_57e9237a(var_a276c861, ended_early)
{
	if(isdefined(level.var_93aa61b1))
	{
		foreach(var_10372151 in level.var_93aa61b1)
		{
			zm_unitrigger::unregister_unitrigger(var_10372151.s_unitrigger_stub);
		}
	}
	if(isdefined(level.var_55a2003d))
	{
		level.var_55a2003d delete();
	}
	/#
		if(var_a276c861 || ended_early)
		{
			level.var_7a27d2bc = level.players[0];
		}
	#/
}

/*
	Name: function_1d7382d0
	Namespace: namespace_a34af286
	Checksum: 0x870164CA
	Offset: 0x2F80
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_1d7382d0()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		if(isplayer(var_be17187b.activator))
		{
			var_10372151 = self.stub.related_parent;
			e_player = var_be17187b.activator;
			var_6e84d29e = e_player function_ffc00d17(var_10372151);
			if(var_6e84d29e)
			{
				b_result = e_player function_9215e9d(self, var_10372151);
				if(isdefined(b_result) && b_result)
				{
					var_10372151 notify(#"hash_72fd666f6ed5a284");
					level.var_55a2003d notify(#"hash_72fd666f6ed5a284");
					var_10372151 notify(#"hash_189a9352bff55b80");
					level.var_7a27d2bc = e_player;
				}
			}
		}
	}
}

/*
	Name: function_ffc00d17
	Namespace: namespace_a34af286
	Checksum: 0x9290CECB
	Offset: 0x30E0
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function function_ffc00d17(var_10372151)
{
	var_30cf8a0a = 1;
	b_lookat_check = 1;
	if(!isdefined(var_10372151))
	{
		return 0;
	}
	if(isdefined(var_10372151.script_string))
	{
		if(self getstance() != var_10372151.script_string)
		{
			var_30cf8a0a = 0;
			/#
				iprintlnbold("");
			#/
		}
	}
	if(isdefined(var_10372151.var_a556cf19))
	{
		var_9da6b1b4 = var_10372151.origin;
		if(var_10372151.script_noteworthy === "last_spot")
		{
			if(!isdefined(var_10372151.s_lookat))
			{
				var_10372151.s_lookat = struct::get(var_10372151.target, "targetname");
			}
			var_9da6b1b4 = var_10372151.s_lookat.origin;
		}
		if(!self util::is_looking_at(var_9da6b1b4, var_10372151.var_a556cf19))
		{
			b_lookat_check = 0;
			/#
				iprintlnbold("");
			#/
		}
	}
	return var_30cf8a0a && b_lookat_check;
}

/*
	Name: function_9215e9d
	Namespace: namespace_a34af286
	Checksum: 0x38493E8
	Offset: 0x3270
	Size: 0xB2
	Parameters: 2
	Flags: Linked
*/
function function_9215e9d(var_1e99deea, var_711067a4)
{
	self endon(#"hash_3b5f95e199c7d7db", #"death");
	var_1e99deea endon(#"death");
	self thread function_123c7022(var_1e99deea, var_711067a4);
	n_time = 1;
	if(isdefined(var_711067a4.script_float))
	{
		n_time = var_711067a4.script_float;
	}
	wait(n_time);
	self notify(#"hash_36de4efbe292709d");
	return true;
}

/*
	Name: function_123c7022
	Namespace: namespace_a34af286
	Checksum: 0xA2DCA37A
	Offset: 0x3330
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function function_123c7022(var_1e99deea, var_711067a4)
{
	self endon(#"hash_36de4efbe292709d", #"death");
	var_1e99deea endon(#"death");
	do
	{
		wait(0.2);
		var_6e84d29e = self function_ffc00d17(var_711067a4);
	}
	while(self istouching(var_1e99deea) && var_6e84d29e);
	self notify(#"hash_3b5f95e199c7d7db");
}

/*
	Name: function_8fb5f04c
	Namespace: namespace_a34af286
	Checksum: 0x36CECFCF
	Offset: 0x33E8
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function function_8fb5f04c()
{
	level endon(#"hash_60740a7ad79fbe01");
	level.var_55a2003d = util::spawn_model(#"tag_origin", level.var_93aa61b1[0].origin);
	level.var_55a2003d endon(#"death");
	level.var_55a2003d thread function_220b84f3();
	level.var_55a2003d playloopsound(#"hash_7345cdff8fcc5925");
	while(true)
	{
		level.var_55a2003d waittill(#"hash_28c5f067b06417a5");
		level.var_55a2003d stoploopsound(1);
		level.var_55a2003d playsound(#"hash_7eb387cfa6f69c57");
		level.var_55a2003d waittill(#"hash_7914a5a6ac424312");
		level.var_55a2003d playsound(#"hash_46adaad86ee481a5");
		level.var_55a2003d playloopsound(#"hash_7345cdff8fcc5925");
	}
}

/*
	Name: function_5579efc3
	Namespace: namespace_a34af286
	Checksum: 0xF8D274F1
	Offset: 0x3580
	Size: 0x296
	Parameters: 1
	Flags: Linked
*/
function function_5579efc3(var_40388281)
{
	var_4ea39df9 = var_40388281;
	var_40388281 = struct::get(var_40388281.target, "targetname");
	if(isdefined(var_40388281))
	{
		level.var_55a2003d.var_bf102318 = var_40388281;
		v_movement = var_40388281.origin - var_4ea39df9.origin;
		var_a3d9dcde = length(v_movement);
		var_5c0e76b9 = int(var_a3d9dcde / 14);
		var_cdf3b660 = vectornormalize(v_movement) * 14;
		var_a45dbb80 = var_4ea39df9.origin;
		if(isdefined(var_40388281.script_string) || isdefined(var_40388281.var_a556cf19))
		{
			level.var_55a2003d.var_b7834a7b = 1;
			level.var_55a2003d.script_string = var_40388281.script_string;
			level.var_55a2003d.var_13dd099c = var_40388281.var_13dd099c;
			level.var_55a2003d.var_bbf205b1 = var_40388281.var_bbf205b1;
		}
		for(i = 0; i < var_5c0e76b9; i++)
		{
			while(!level.var_55a2003d.var_c3202114)
			{
				wait(0.1);
			}
			var_a45dbb80 = var_a45dbb80 + var_cdf3b660;
			var_c562c0b4 = 0.2;
			if(var_40388281.script_string === "prone")
			{
				var_c562c0b4 = var_c562c0b4 * 2.5;
			}
			level.var_55a2003d moveto(var_a45dbb80, var_c562c0b4);
			wait(var_c562c0b4);
		}
		level.var_55a2003d moveto(var_40388281.origin, var_c562c0b4);
		wait(var_c562c0b4);
	}
	return var_40388281;
}

/*
	Name: function_220b84f3
	Namespace: namespace_a34af286
	Checksum: 0x3A3ED266
	Offset: 0x3820
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function function_220b84f3()
{
	self endon(#"death");
	self.var_c3202114 = 0;
	self waittill(#"hash_72fd666f6ed5a284");
	while(true)
	{
		if(self.script_string === "prone")
		{
			var_2d01ed64 = 96;
			var_da117886 = 160;
		}
		else
		{
			var_2d01ed64 = 256;
			var_da117886 = 640;
		}
		if(isdefined(self.var_13dd099c))
		{
			var_2d01ed64 = self.var_13dd099c;
		}
		if(isdefined(self.var_bbf205b1))
		{
			var_da117886 = self.var_bbf205b1;
		}
		n_range = (self.var_c3202114 ? var_da117886 : var_2d01ed64);
		if(self.script_noteworthy === "last_spot")
		{
			if(!self.var_c3202114)
			{
				self.var_c3202114 = 1;
				self notify(#"hash_7914a5a6ac424312");
				return;
			}
		}
		else
		{
			var_f5f25328 = array::get_all_closest(self.origin, util::get_active_players(#"allies"), undefined, 4, n_range);
			var_4821a237 = 1;
			if(isdefined(self.var_b7834a7b) && self.var_b7834a7b)
			{
				var_4821a237 = 0;
				foreach(e_player in var_f5f25328)
				{
					var_fee39c4a = e_player function_ffc00d17(self.var_bf102318);
					var_4821a237 = var_4821a237 | var_fee39c4a;
				}
			}
			if(self.var_c3202114)
			{
				if(!var_f5f25328.size || !var_4821a237)
				{
					self.var_c3202114 = 0;
					self notify(#"hash_28c5f067b06417a5");
				}
			}
			else if(var_f5f25328.size && var_4821a237)
			{
				self.var_c3202114 = 1;
				self notify(#"hash_7914a5a6ac424312");
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_9c3b8102
	Namespace: namespace_a34af286
	Checksum: 0xEB530B5
	Offset: 0x3B08
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_9c3b8102(var_a276c861)
{
	var_decc00a1 = level.var_93aa61b1[level.var_93aa61b1.size - 1];
	if(isalive(level.var_7a27d2bc))
	{
		level.var_7a27d2bc playsoundtoplayer(#"hash_1a447e459e1a1744", level.var_7a27d2bc);
		level.var_7a27d2bc thread function_6366a177(var_decc00a1);
		level.var_7a27d2bc waittill(#"hash_5fa4964a839dbe6d");
	}
	var_872e2994 = var_decc00a1;
	if(isalive(level.var_7a27d2bc))
	{
		level.var_7a27d2bc zm_vo::function_a2bd5a0c("vox_ghost_cath_jump_react", 2, 0, 9999, 1);
	}
	if(isdefined(var_872e2994.s_unitrigger_stub) && (isdefined(var_872e2994.s_unitrigger_stub.registered) && var_872e2994.s_unitrigger_stub.registered))
	{
		zm_unitrigger::unregister_unitrigger(var_872e2994.s_unitrigger_stub);
	}
	wait(2);
	function_7e04b65f();
}

/*
	Name: function_4a0f87c7
	Namespace: namespace_a34af286
	Checksum: 0x7B28C97
	Offset: 0x3CA8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_4a0f87c7(var_a276c861, ended_early)
{
}

/*
	Name: function_f84421eb
	Namespace: namespace_a34af286
	Checksum: 0x42C693D4
	Offset: 0x3CC8
	Size: 0x34
	Parameters: 3
	Flags: Linked
*/
function function_f84421eb(var_2e6c012e, e_player_2, b_lowest_first)
{
	return var_2e6c012e.var_c859fa3a > e_player_2.var_c859fa3a;
}

/*
	Name: function_7e04b65f
	Namespace: namespace_a34af286
	Checksum: 0xF85ACC58
	Offset: 0x3D08
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_7e04b65f()
{
	a_e_players = util::get_players(#"allies");
	level.var_32e85a16 = array::merge_sort(a_e_players, &function_f84421eb, 0);
	var_4162b7c9 = 0;
	foreach(e_player in level.var_32e85a16)
	{
		if(isdefined(e_player))
		{
			e_player playsound(#"hash_41d764eca159410e");
			var_4162b7c9 = (e_player.var_c859fa3a > var_4162b7c9 ? e_player.var_c859fa3a : var_4162b7c9);
			if(e_player.var_c859fa3a >= var_4162b7c9)
			{
				/#
					iprintlnbold(((("" + e_player getentnum()) + "") + e_player.var_c859fa3a) + "");
				#/
				e_player thread zm_magicbox::function_830b7ecd(level.var_87e6a031);
				e_player thread function_1704df5e();
			}
			e_player thread function_70d155c5();
		}
	}
}

/*
	Name: function_70d155c5
	Namespace: namespace_a34af286
	Checksum: 0x7F87C03C
	Offset: 0x3EE8
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_70d155c5()
{
	self endon(#"death");
	self zm_perks::function_cc24f525();
	for(i = 0; i < 2; i++)
	{
		var_16c042b8 = self zm_perks::function_b2cba45a();
		/#
			if(isdefined(var_16c042b8))
			{
				iprintlnbold("" + function_9e72a96(var_16c042b8));
			}
		#/
	}
}

/*
	Name: function_1704df5e
	Namespace: namespace_a34af286
	Checksum: 0xC8D32413
	Offset: 0x3F98
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_1704df5e()
{
	self endon(#"death");
	var_94899c49 = self getcurrentweapon();
	while(!isinarray(self getweaponslistprimaries(), var_94899c49))
	{
		var_94899c49 = self getcurrentweapon();
		wait(0.1);
	}
	var_c2415b72 = zm_weapons::function_93cd8e76(var_94899c49);
	var_c2415b72 = zm_weapons::get_base_weapon(var_c2415b72);
	/#
		iprintlnbold((("" + self getentnum()) + "") + function_9e72a96(var_c2415b72.name));
	#/
	while(self function_1ec86044(var_c2415b72) || (isdefined(level.pap_machine) && level.pap_machine.pack_player === self) || self scene::function_c935c42())
	{
		if(isdefined(level.pap_machine) && level.pap_machine.pack_player === self)
		{
			wait(2);
			continue;
		}
		if(self scene::function_c935c42())
		{
			wait(1);
			continue;
		}
		var_2709c26f = self function_64b50b8c(var_c2415b72);
		if(isdefined(var_2709c26f))
		{
			self givemaxammo(var_2709c26f);
		}
		else
		{
			/#
				assert(0, "");
			#/
			/#
			#/
		}
		wait(2);
	}
}

/*
	Name: function_1ec86044
	Namespace: namespace_a34af286
	Checksum: 0xA8AE536
	Offset: 0x41D8
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_1ec86044(var_c2415b72)
{
	self endon(#"death");
	if(var_c2415b72 == level.var_f086136b || var_c2415b72 == level.var_6fe89212)
	{
		return self zm_weapons::has_weapon_or_upgrade(level.var_f086136b) || self zm_weapons::has_weapon_or_upgrade(level.var_6fe89212) || self zm_weapons::has_weapon_or_upgrade(level.var_7b9ca97a);
	}
	return self zm_weapons::has_weapon_or_upgrade(var_c2415b72);
}

/*
	Name: function_64b50b8c
	Namespace: namespace_a34af286
	Checksum: 0x6414DC29
	Offset: 0x42B0
	Size: 0x1AE
	Parameters: 1
	Flags: Linked
*/
function function_64b50b8c(var_c2415b72)
{
	self endon(#"death");
	var_400c259d = self getweaponslistprimaries();
	if(var_c2415b72 == level.var_f086136b || var_c2415b72 == level.var_6fe89212 || var_c2415b72 == level.var_7b9ca97a)
	{
		foreach(var_5d22227d in var_400c259d)
		{
			if(var_5d22227d === level.var_f086136b || var_5d22227d === level.var_6fe89212 || var_5d22227d === level.var_7b9ca97a)
			{
				return var_5d22227d;
			}
		}
	}
	else
	{
		foreach(var_5d22227d in var_400c259d)
		{
			if(zm_weapons::get_base_weapon(zm_weapons::function_93cd8e76(var_5d22227d)) === var_c2415b72)
			{
				return var_5d22227d;
			}
		}
	}
}

/*
	Name: function_6366a177
	Namespace: namespace_a34af286
	Checksum: 0xDA1781F
	Offset: 0x4468
	Size: 0x3BE
	Parameters: 3
	Flags: Linked
*/
function function_6366a177(s_lookat, var_3ac8690f, var_149b3205)
{
	self val::set(#"hash_69fe6012338fa244", #"freezecontrols");
	self val::set(#"hash_69fe6012338fa244", "ignoreme", 1);
	self val::set(#"hash_69fe6012338fa244", "takedamage", 0);
	var_6c759f99 = util::spawn_model(#"hash_3ae1ad382a5ec0c8", s_lookat.origin + (vectorscale((0, 0, -1), 62)), s_lookat.angles);
	var_6c759f99 hide();
	var_6c759f99 showtoplayer(self);
	if(isdefined(var_149b3205))
	{
		v_angles = var_149b3205;
	}
	else
	{
		v_angles = self getplayerangles();
	}
	var_4b540767 = (v_angles[0] * -1, v_angles[1] + 180, v_angles[2] * -1);
	if(isdefined(var_3ac8690f))
	{
		var_6c9efff0 = (var_3ac8690f + (vectornormalize(anglestoforward(v_angles)) * 13)) + (vectornormalize(anglestoup(v_angles)) * -62);
	}
	else
	{
		var_6c9efff0 = (self geteye() + (vectornormalize(anglestoforward(v_angles)) * 13)) + (vectornormalize(anglestoup(v_angles)) * -62);
	}
	var_6c759f99 rotateto(var_4b540767, 0.3);
	var_6c759f99 moveto(var_6c9efff0, 0.3);
	wait(0.3);
	wait(0.5);
	var_6c759f99 clientfield::set("" + #"hash_336942eaf5fcd809", 1);
	wait(1);
	var_6c759f99 delete();
	if(isdefined(self))
	{
		self val::reset(#"hash_69fe6012338fa244", #"freezecontrols");
		self val::reset(#"hash_69fe6012338fa244", "ignoreme");
		self val::reset(#"hash_69fe6012338fa244", "takedamage");
		self notify(#"hash_5fa4964a839dbe6d");
	}
}

/*
	Name: function_f62d9f65
	Namespace: namespace_a34af286
	Checksum: 0xF5AF67C9
	Offset: 0x4830
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_f62d9f65(var_a276c861)
{
	level flag::init(#"hash_11cbce4fcf9f3aec");
	s_painting = struct::get(#"hash_451396ad5dd0643e", "targetname");
	s_painting.s_unitrigger_stub = s_painting zm_unitrigger::create(undefined, s_painting.radius, &function_eb269563, 0, 1);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_painting.s_unitrigger_stub, 1);
}

/*
	Name: function_6134319c
	Namespace: namespace_a34af286
	Checksum: 0xB5E81DD9
	Offset: 0x48F8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_6134319c(var_a276c861, ended_early)
{
}

/*
	Name: function_eb269563
	Namespace: namespace_a34af286
	Checksum: 0xF0B13562
	Offset: 0x4918
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function function_eb269563()
{
	self endon(#"death");
	s_lookat = struct::get(#"hash_435c10185189155d", "targetname");
	var_1611e2c0 = s_lookat.origin;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		e_player = var_be17187b.activator;
		if(isdefined(e_player.b_nosferatu_damage_fx) && e_player.b_nosferatu_damage_fx && (!(isdefined(e_player.var_4522314f) && e_player.var_4522314f)) && e_player util::is_looking_at(var_1611e2c0, 0.89))
		{
			e_player thread function_e92918f6(self, s_lookat);
		}
	}
}

/*
	Name: function_e92918f6
	Namespace: namespace_a34af286
	Checksum: 0x1BF213A3
	Offset: 0x4A58
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_e92918f6(var_1e99deea, s_lookat)
{
	self endoncallback(&function_dc123817, #"hash_3b5f95e199c7d7db", #"death");
	self.var_4522314f = 1;
	self thread function_da604bc0(var_1e99deea, s_lookat.origin);
	wait(30);
	if(level flag::get(#"hash_11cbce4fcf9f3aec"))
	{
		level flag::wait_till_clear(#"hash_11cbce4fcf9f3aec");
	}
	self thread function_623b460a();
}

/*
	Name: function_623b460a
	Namespace: namespace_a34af286
	Checksum: 0x6F798CD5
	Offset: 0x4B40
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_623b460a()
{
	level flag::set(#"hash_11cbce4fcf9f3aec");
	var_97b7cff3 = scene::get_active_scenes(#"p8_fxanim_zm_man_pjs_bundle");
	var_70c77e28 = var_97b7cff3[0];
	var_35694f3f = var_70c77e28.scene_ents[#"hash_7aff0ee60ddd937b"];
	/#
		/#
			assert(isdefined(var_35694f3f), "");
		#/
	#/
	if(isdefined(var_35694f3f))
	{
		var_35694f3f hide();
		var_35694f3f showtoplayer(self);
		self thread zm_vo::function_a2bd5a0c(#"hash_2f31e680acc67680", 4.5, 1, 9999);
		self playsoundtoplayer(#"hash_1a447f459e1a18f7", self);
		level thread scene::play(#"p8_fxanim_zm_man_pjs_bundle");
		wait(0.7);
		var_35694f3f clientfield::set("" + #"hash_336942eaf5fcd809", 1);
		wait(2);
		var_35694f3f hide();
		var_35694f3f clientfield::set("" + #"hash_336942eaf5fcd809", 0);
	}
	level scene::init(#"p8_fxanim_zm_man_pjs_bundle");
	self.var_4522314f = 0;
	wait(0.1);
	level flag::clear(#"hash_11cbce4fcf9f3aec");
}

/*
	Name: function_dc123817
	Namespace: namespace_a34af286
	Checksum: 0xD4711105
	Offset: 0x4D90
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_dc123817(str_notify)
{
	if(isdefined(self))
	{
		self.var_4522314f = 0;
	}
}

/*
	Name: function_da604bc0
	Namespace: namespace_a34af286
	Checksum: 0x81D4672D
	Offset: 0x4DB8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_da604bc0(var_1e99deea, var_1611e2c0)
{
	self endon(#"hash_36de4efbe292709d", #"death");
	/#
		iprintlnbold("" + self.playernum);
	#/
	do
	{
		wait(0.2);
	}
	while(function_533ca98d(var_1e99deea, var_1611e2c0));
	self notify(#"hash_3b5f95e199c7d7db");
	/#
		iprintlnbold("" + self.playernum);
	#/
}

/*
	Name: function_533ca98d
	Namespace: namespace_a34af286
	Checksum: 0x2350FCB6
	Offset: 0x4E80
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_533ca98d(var_1e99deea, var_1611e2c0)
{
	return isdefined(var_1e99deea) && self istouching(var_1e99deea) && self util::is_looking_at(var_1611e2c0, 0.89);
}

/*
	Name: function_c9854faa
	Namespace: namespace_a34af286
	Checksum: 0x55E008FC
	Offset: 0x4EE8
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_c9854faa()
{
	/#
		setdvar(#"hash_7a278441046d0a08", 0);
		setdvar(#"hash_71faad0772a081c1", 0);
		setdvar(#"hash_6bedacfaaa354b3d", 0);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		level thread function_e6440e06();
	#/
}

/*
	Name: function_e6440e06
	Namespace: namespace_a34af286
	Checksum: 0xAD4603A0
	Offset: 0x4FF0
	Size: 0x24E
	Parameters: 0
	Flags: None
*/
function function_e6440e06()
{
	/#
		var_5245371c = 0;
		var_972ed7e7 = 0;
		while(true)
		{
			var_8a4bff6d = getdvarint(#"hash_7a278441046d0a08", 0);
			if(var_8a4bff6d != var_5245371c)
			{
				switch(var_8a4bff6d)
				{
					case 0:
					{
						if(isdefined(level.var_55a2003d))
						{
							level.var_55a2003d clientfield::set("" + #"hash_487e544e29aa8e45", 0);
						}
						break;
					}
					case 1:
					{
						if(isdefined(level.var_55a2003d))
						{
							level.var_55a2003d clientfield::set("" + #"hash_487e544e29aa8e45", 1);
						}
						break;
					}
				}
			}
			var_67247963 = getdvarint(#"hash_71faad0772a081c1", 0);
			if(var_67247963 != var_972ed7e7)
			{
				switch(var_67247963)
				{
					case 0:
					{
						level notify(#"hash_7d85bf9a5c90b6d9");
						break;
					}
					case 1:
					{
						level thread function_6e0ed3e();
						break;
					}
				}
			}
			var_9ec35d59 = getdvarint(#"hash_6bedacfaaa354b3d", 0);
			if(var_9ec35d59)
			{
				setdvar(#"hash_6bedacfaaa354b3d", 0);
				level thread function_3ddf07f4();
			}
			var_5245371c = var_8a4bff6d;
			var_972ed7e7 = var_67247963;
			wait(1);
		}
	#/
}

/*
	Name: function_6e0ed3e
	Namespace: namespace_a34af286
	Checksum: 0x2AB5BC10
	Offset: 0x5248
	Size: 0x182
	Parameters: 0
	Flags: None
*/
function function_6e0ed3e()
{
	/#
		level endon(#"hash_7d85bf9a5c90b6d9");
		while(true)
		{
			foreach(n_index, e_player in getplayers())
			{
				n_y_pos = 720 + (18.7 * n_index);
				debug2dtext((120, n_y_pos, 0), ("" + n_index) + "", (1, 1, 0), 1, (0, 0, 0), 0.4, 1, 2);
				debug2dtext((120 + 100, n_y_pos, 0), "" + e_player.var_c859fa3a, (1, 1, 1), 1, (0, 0, 0), 0.4, 1, 2);
			}
			waitframe(2);
		}
	#/
}

/*
	Name: function_3ddf07f4
	Namespace: namespace_a34af286
	Checksum: 0x90AC8C12
	Offset: 0x53D8
	Size: 0x23C
	Parameters: 0
	Flags: None
*/
function function_3ddf07f4()
{
	/#
		if(!isdefined(level.var_ce277759))
		{
			level.var_ce277759 = 0;
		}
		var_538ff835 = [];
		for(i = 0; i < 4; i++)
		{
			var_54887c6a = spawnstruct();
			var_54887c6a.var_21c1ba1 = i;
			if(!isdefined(var_538ff835))
			{
				var_538ff835 = [];
			}
			else if(!isarray(var_538ff835))
			{
				var_538ff835 = array(var_538ff835);
			}
			var_538ff835[var_538ff835.size] = var_54887c6a;
			if(i != (level.var_ce277759 % 4))
			{
				var_54887c6a.var_c859fa3a = 2;
				continue;
			}
			var_54887c6a.var_c859fa3a = 0;
		}
		var_538ff835 = array::merge_sort(var_538ff835, &function_f84421eb, 0);
		var_4162b7c9 = 0;
		foreach(var_54887c6a in var_538ff835)
		{
			if(isdefined(var_54887c6a))
			{
				var_4162b7c9 = (var_54887c6a.var_c859fa3a > var_4162b7c9 ? var_54887c6a.var_c859fa3a : var_4162b7c9);
				if(var_54887c6a.var_c859fa3a >= var_4162b7c9)
				{
					/#
						iprintlnbold(((("" + var_54887c6a.var_21c1ba1) + "") + var_54887c6a.var_c859fa3a) + "");
					#/
				}
			}
		}
		level.var_ce277759++;
	#/
}

/*
	Name: function_95b6c945
	Namespace: namespace_a34af286
	Checksum: 0x921C9DDA
	Offset: 0x5620
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function function_95b6c945()
{
	/#
		if(!getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			return;
		}
		e_object = self;
		if(isstruct(self))
		{
			e_object = util::spawn_model(#"tag_origin", self.origin);
			e_object.script_int = self.script_int;
		}
		e_object clientfield::set("" + #"hash_3efe70d8ad68a07d", e_object.script_int + 1);
		self waittill(#"hash_189a9352bff55b80", #"death");
		if(isdefined(e_object) && !isstruct(e_object))
		{
			e_object delete();
		}
	#/
}

