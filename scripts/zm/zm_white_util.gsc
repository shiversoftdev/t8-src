// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3510d12b63a575c3;
#using script_5bb072c3abf4652c;
#using script_5f9141e04e4e94a2;
#using script_6a3f43063dfd1bdc;
#using script_70d6524cefc5604f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_9cf755b;

/*
	Name: init
	Namespace: namespace_9cf755b
	Checksum: 0xB3682777
	Offset: 0x398
	Size: 0x52C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_d2ed4be7 = array(#"zombie", #"mannequin");
	callback::on_spawned(&function_ea6a4006);
	level.var_5dd0d3ff = spawn("script_origin", (0, 0, 0));
	level.var_5dd0d3ff.name = "rush";
	level.var_5dd0d3ff.isspeaking = 0;
	level.var_5dd0d3ff.var_5b6ebfd0 = 0;
	level.var_8200dc81 = spawn("script_origin", (0, 0, 0));
	level.var_8200dc81.name = "ncom";
	level.var_8200dc81.isspeaking = 0;
	level.var_8200dc81.var_5b6ebfd0 = 0;
	level.var_170ea961 = getent("atlas_ct", "targetname");
	level.var_170ea961.name = "mcca";
	level.var_170ea961.isspeaking = 0;
	level.var_170ea961.var_5b6ebfd0 = 0;
	level.var_2aeeb358 = [];
	level.var_2aeeb358[0] = getweapon("ray_gun");
	level.var_2aeeb358[1] = getweapon("ray_gun_upgraded");
	level.var_2aeeb358[2] = getweapon("ray_gun_mk2");
	level.var_2aeeb358[3] = getweapon("ray_gun_mk2_upgraded");
	level.var_2aeeb358[4] = getweapon("ray_gun_mk2v");
	level.var_2aeeb358[5] = getweapon("ray_gun_mk2v_upgraded");
	level.var_2aeeb358[6] = getweapon("ray_gun_mk2x");
	level.var_2aeeb358[7] = getweapon("ray_gun_mk2x_dw");
	level.var_2aeeb358[8] = getweapon("ray_gun_mk2y");
	level.var_2aeeb358[9] = getweapon("ray_gun_mk2y_upgraded");
	level.var_2aeeb358[10] = getweapon("ray_gun_mk2z");
	level.var_2aeeb358[11] = getweapon("ray_gun_mk2z_upgraded");
	level.var_65b6264d = array(level.var_2aeeb358[0], level.var_2aeeb358[1], level.var_2aeeb358[2], level.var_2aeeb358[3]);
	level.var_584a3e61 = array(level.var_2aeeb358[4], level.var_2aeeb358[5], level.var_2aeeb358[6], level.var_2aeeb358[7], level.var_2aeeb358[8], level.var_2aeeb358[9], level.var_2aeeb358[10], level.var_2aeeb358[11]);
	namespace_4cd9c601::function_69f490a(level.var_584a3e61);
	level.var_ee565b3f = &function_8a4b7d4a;
	level.var_bb2323e4 = &function_afbd7223;
	level flag::init(#"hash_595f26b382ef7867");
	level flag::init(#"hash_3a183a144032bbf3");
	callback::on_ai_spawned(&on_ai_spawned);
}

/*
	Name: function_ea6a4006
	Namespace: namespace_9cf755b
	Checksum: 0xF244589D
	Offset: 0x8D0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_ea6a4006()
{
	self zm_audio::function_6191af93(#"surrounded", #"self", #"oh", #"shit", 100);
	self zm_audio::function_6191af93(#"magicbox", #"hash_10f614b278daaebc", #"magicbox", #"monkey", 100);
	self zm_audio::function_6191af93(#"kill", #"hash_10f614b278daaebc", #"kill", #"monkey", 100);
	self zm_audio::function_6191af93(#"kill", #"ray_gun_mk2", #"kill", #"hash_34540a6bb099133e", 100);
	self zm_audio::function_87714659(&function_e08cd7b, #"roundstart", #"special");
}

/*
	Name: function_e08cd7b
	Namespace: namespace_9cf755b
	Checksum: 0xE21E4ED2
	Offset: 0xA80
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_e08cd7b(category, subcategory)
{
	if(level flag::get("mee_round"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5d7d0c85
	Namespace: namespace_9cf755b
	Checksum: 0xB460E73C
	Offset: 0xAC8
	Size: 0x3A8
	Parameters: 1
	Flags: Linked
*/
function function_5d7d0c85(var_2753f06a)
{
	wait(1);
	b_played = 0;
	a_players = arraycopy(level.players);
	if(!isdefined(level.host))
	{
		return 0;
	}
	var_5316ea7d = level.host zm_vo::function_82f9bc9f();
	if(a_players.size == 1)
	{
		e_player = a_players[0];
		if(var_2753f06a == 0)
		{
			str_suffix = #"hash_2f99f466b2830fbd" + var_5316ea7d;
		}
		else
		{
			str_suffix = #"hash_353c8321de1d10b1" + var_2753f06a + "_" + var_5316ea7d;
		}
		b_played = e_player zm_vo::function_a2bd5a0c(str_suffix, 0, 1);
	}
	else
	{
		arrayremovevalue(a_players, level.host);
		if(var_2753f06a == 0)
		{
			level.host namespace_509a75d1::function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d);
			var_d1e952c4 = namespace_509a75d1::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				if(var_d1e952c4 zm_vo::function_82f9bc9f() === "rich")
				{
					var_d1e952c4 namespace_509a75d1::function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d, 5);
				}
				else
				{
					var_d1e952c4 namespace_509a75d1::function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d);
				}
			}
			if(var_5316ea7d === "take" && var_d1e952c4 zm_vo::function_82f9bc9f() === "demp")
			{
				foreach(player in a_players)
				{
					if(player zm_vo::function_82f9bc9f() === "rich")
					{
						player namespace_509a75d1::function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d, 7);
					}
				}
			}
		}
		else
		{
			level.host namespace_509a75d1::function_51b752a9(#"hash_71bde3a512edb440" + var_2753f06a + "_" + var_5316ea7d);
			var_d1e952c4 = namespace_509a75d1::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				var_d1e952c4 namespace_509a75d1::function_51b752a9(#"hash_71bde3a512edb440" + var_2753f06a + "_" + var_5316ea7d);
			}
		}
		b_played = 1;
	}
	return b_played;
}

/*
	Name: function_733a6ab7
	Namespace: namespace_9cf755b
	Checksum: 0xA42C6973
	Offset: 0xE78
	Size: 0x7C
	Parameters: 4
	Flags: None
*/
function function_733a6ab7(e_player, var_50a85511, var_3d7ad116, var_21fd1ca8)
{
	level endon(#"end_game");
	e_player namespace_509a75d1::function_51b752a9(var_50a85511);
	wait(1);
	var_3d7ad116 thread namespace_509a75d1::function_6a0d675d(var_21fd1ca8, -1, 1);
}

/*
	Name: function_c2cc8e
	Namespace: namespace_9cf755b
	Checksum: 0x1EE8D918
	Offset: 0xF00
	Size: 0xC4
	Parameters: 3
	Flags: None
*/
function function_c2cc8e(e_player, var_50a85511, var_21fd1ca8)
{
	level endon(#"end_game");
	self endon(#"death", #"player_down", #"disconnect");
	namespace_509a75d1::function_3c173d37();
	e_player namespace_509a75d1::function_51b752a9(var_50a85511);
	namespace_509a75d1::function_3c173d37();
	e_player zm_audio::do_player_or_npc_playvox(var_21fd1ca8, 1);
}

/*
	Name: function_491673da
	Namespace: namespace_9cf755b
	Checksum: 0x4877608C
	Offset: 0xFD0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_491673da(var_21fd1ca8)
{
	if(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f)
	{
		return;
	}
	level endon(#"end_game");
	self endon(#"death", #"player_down", #"disconnect");
	self zm_audio::do_player_or_npc_playvox(var_21fd1ca8, 1);
}

/*
	Name: function_31e7b76f
	Namespace: namespace_9cf755b
	Checksum: 0x35040289
	Offset: 0x1070
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function function_31e7b76f(n_delay, var_3d7ad116, var_21fd1ca8, str_cancel)
{
	level endon(#"end_game", str_cancel);
	wait(n_delay);
	var_3d7ad116 thread namespace_509a75d1::function_6a0d675d(var_21fd1ca8, 0, 1);
}

/*
	Name: function_ec34b5ee
	Namespace: namespace_9cf755b
	Checksum: 0x3C1DD56C
	Offset: 0x10E0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_ec34b5ee(alias)
{
	if(!isdefined(alias))
	{
		return;
	}
	if(!isdefined(level.var_e356155f))
	{
		level.var_e356155f = 0;
	}
	if(level.var_e356155f == 0)
	{
		level.var_e356155f = 1;
		level function_2389bb7a(alias);
		level.var_e356155f = 0;
		level notify(#"hash_62d5ef9902abf374");
	}
}

/*
	Name: function_2389bb7a
	Namespace: namespace_9cf755b
	Checksum: 0xC5470E0E
	Offset: 0x1178
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_2389bb7a(str_sound)
{
	n_wait = float(soundgetplaybacktime(str_sound)) / 1000;
	n_wait = max(n_wait - 0.5, 0.1);
	foreach(player in level.players)
	{
		player playsoundtoplayer(str_sound, player);
	}
	wait(n_wait);
}

/*
	Name: function_f4a39bc4
	Namespace: namespace_9cf755b
	Checksum: 0xE3405A21
	Offset: 0x1280
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_f4a39bc4()
{
	level thread function_f2fa71ce();
	function_364cd8c0("apd_lockdown");
	zm_zonemgr::enable_zone("zone_bunker_apd");
	zm_zonemgr::enable_zone("zone_culdesac_green");
	zm_zonemgr::enable_zone("zone_culdesac_yellow");
	zm_zonemgr::enable_zone("zone_angled_house");
	level thread function_612918d9("bunker_door_storage_blocker");
	level thread function_612918d9("bunker_door_solitary_blocker");
	level thread function_bf25aeb1("bunker_door_solitary_lockdown");
	level thread function_bf25aeb1("bunker_door_storage_lockdown");
	level thread function_bf25aeb1("bunker_door_electric");
	var_baaa17ec = getentarray("lockdown_door", "targetname");
	foreach(var_80ff15bc in var_baaa17ec)
	{
		var_80ff15bc function_46ed91c6();
	}
}

/*
	Name: function_e95d25
	Namespace: namespace_9cf755b
	Checksum: 0x3A5251D4
	Offset: 0x1458
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function function_e95d25()
{
	/#
		while(true)
		{
			level waittill(#"open_sesame");
			function_f4a39bc4();
			wait(1);
		}
	#/
}

/*
	Name: function_6f635c39
	Namespace: namespace_9cf755b
	Checksum: 0x9E6AF25B
	Offset: 0x14A0
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function function_6f635c39(str)
{
	/#
		assert(isdefined(str), "");
	#/
	a_doors = getentarray(str, "script_string");
	foreach(door in a_doors)
	{
		door function_20681be5();
	}
}

/*
	Name: function_20681be5
	Namespace: namespace_9cf755b
	Checksum: 0x5F3B2094
	Offset: 0x1570
	Size: 0x196
	Parameters: 0
	Flags: Linked, Private
*/
private function function_20681be5()
{
	if(self.b_open == 0)
	{
		return 0;
	}
	destpos = self.origin - (0, 0, self.var_3de056e7);
	self moveto(destpos, 0.5, 0.05, 0.05);
	self playsound(#"evt_bunker_door_interior_close");
	e_collision = getent(self.linkname, "linkto");
	e_collision disconnectpaths();
	if(isdefined(self.var_61e10b48) && isdefined(self.var_d42d6fdf))
	{
		level.zones[hash(self.var_61e10b48)].adjacent_zones[hash(self.var_d42d6fdf)].is_connected = 0;
		level.zones[hash(self.var_d42d6fdf)].adjacent_zones[hash(self.var_61e10b48)].is_connected = 0;
	}
	self.b_open = 0;
	return 1;
}

/*
	Name: function_364cd8c0
	Namespace: namespace_9cf755b
	Checksum: 0x7E148BE5
	Offset: 0x1710
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function function_364cd8c0(str)
{
	/#
		assert(isdefined(str), "");
	#/
	a_doors = getentarray(str, "script_string");
	foreach(door in a_doors)
	{
		door function_46ed91c6();
	}
}

/*
	Name: function_46ed91c6
	Namespace: namespace_9cf755b
	Checksum: 0xF1D27132
	Offset: 0x17E0
	Size: 0x196
	Parameters: 0
	Flags: Linked, Private
*/
private function function_46ed91c6()
{
	if(self.b_open == 1)
	{
		return 0;
	}
	destpos = self.origin + (0, 0, self.var_3de056e7);
	self moveto(destpos, 0.5, 0.05, 0.05);
	self playsound(#"evt_bunker_door_interior_open");
	e_collision = getent(self.linkname, "linkto");
	e_collision disconnectpaths();
	if(isdefined(self.var_61e10b48) && isdefined(self.var_d42d6fdf))
	{
		level.zones[hash(self.var_61e10b48)].adjacent_zones[hash(self.var_d42d6fdf)].is_connected = 1;
		level.zones[hash(self.var_d42d6fdf)].adjacent_zones[hash(self.var_61e10b48)].is_connected = 1;
	}
	self.b_open = 1;
	return 1;
}

/*
	Name: function_612918d9
	Namespace: namespace_9cf755b
	Checksum: 0xA880A0A1
	Offset: 0x1980
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_612918d9(str)
{
	/#
		/#
			assert(isdefined(str), "");
		#/
	#/
	var_dc3827e3 = getentarray(str, "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		e_blocker notsolid();
		e_blocker delete();
	}
}

/*
	Name: function_ca4ee4d1
	Namespace: namespace_9cf755b
	Checksum: 0x7830F2C0
	Offset: 0x1A70
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_ca4ee4d1(str)
{
	/#
		/#
			assert(isdefined(str), "");
		#/
	#/
	var_20475c5a = struct::get_array(str, "targetname");
	foreach(s_bunker_door in var_20475c5a)
	{
		/#
			/#
				assert(isdefined(s_bunker_door.init_anim), "");
			#/
		#/
		s_bunker_door thread scene::play(s_bunker_door.init_anim);
	}
}

/*
	Name: function_bf25aeb1
	Namespace: namespace_9cf755b
	Checksum: 0x2C94B672
	Offset: 0x1B88
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_bf25aeb1(str)
{
	/#
		/#
			assert(isdefined(str), "");
		#/
	#/
	var_20475c5a = struct::get_array(str, "script_noteworthy");
	foreach(s_bunker_door in var_20475c5a)
	{
		/#
			/#
				assert(isdefined(s_bunker_door.var_ee00b371), "");
			#/
		#/
		s_bunker_door thread scene::play(s_bunker_door.var_ee00b371);
	}
}

/*
	Name: function_f2fa71ce
	Namespace: namespace_9cf755b
	Checksum: 0x7A12A113
	Offset: 0x1CA0
	Size: 0x1B6
	Parameters: 0
	Flags: Linked
*/
function function_f2fa71ce()
{
	e_door = getent("apd_lockdown", "targetname");
	var_82d27368 = getent(e_door.target, "targetname");
	if(!e_door.b_open)
	{
		e_door rotateto(e_door.angles + vectorscale((0, -1, 0), 90), 1, 0.1, 0.2);
		var_82d27368 notsolid();
		var_82d27368 connectpaths();
		if(isdefined(e_door.var_61e10b48) && isdefined(e_door.var_d42d6fdf))
		{
			level.zones[hash(e_door.var_61e10b48)].adjacent_zones[hash(e_door.var_d42d6fdf)].is_connected = 1;
			level.zones[hash(e_door.var_d42d6fdf)].adjacent_zones[hash(e_door.var_61e10b48)].is_connected = 1;
		}
		e_door.b_open = 1;
	}
}

/*
	Name: function_985c08e7
	Namespace: namespace_9cf755b
	Checksum: 0xC38B146A
	Offset: 0x1E60
	Size: 0x1B2
	Parameters: 0
	Flags: Linked
*/
function function_985c08e7()
{
	e_door = getent("apd_lockdown", "targetname");
	var_82d27368 = getent(e_door.target, "targetname");
	if(e_door.b_open)
	{
		e_door rotateto(e_door.angles + vectorscale((0, -1, 0), 90), 1, 0.1, 0.2);
		var_82d27368 solid();
		var_82d27368 disconnectpaths();
		if(isdefined(e_door.var_61e10b48) && isdefined(e_door.var_d42d6fdf))
		{
			level.zones[hash(e_door.var_61e10b48)].adjacent_zones[hash(e_door.var_d42d6fdf)].is_connected = 0;
			level.zones[hash(e_door.var_d42d6fdf)].adjacent_zones[hash(e_door.var_61e10b48)].is_connected = 0;
		}
		e_door.b_open = 0;
	}
}

/*
	Name: function_85edbfb9
	Namespace: namespace_9cf755b
	Checksum: 0x679E1B60
	Offset: 0x2020
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function function_85edbfb9(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_2aeeb358[2] || w_weapon == level.var_2aeeb358[3]);
}

/*
	Name: function_1526eabf
	Namespace: namespace_9cf755b
	Checksum: 0xBE1F22CC
	Offset: 0x2070
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_1526eabf(e_player)
{
	return isplayer(e_player) && e_player zm_weapons::has_weapon_or_upgrade(level.var_2aeeb358[2]);
}

/*
	Name: function_d7c9337c
	Namespace: namespace_9cf755b
	Checksum: 0x47FC0E07
	Offset: 0x20C8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_d7c9337c()
{
	if(self hasweapon(level.var_2aeeb358[2]))
	{
		return level.var_2aeeb358[2];
	}
	var_6febd6e0 = zm_weapons::get_upgrade_weapon(level.var_2aeeb358[2]);
	if(self hasweapon(var_6febd6e0))
	{
		return var_6febd6e0;
	}
}

/*
	Name: function_f214f97e
	Namespace: namespace_9cf755b
	Checksum: 0x14AD043D
	Offset: 0x2158
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_f214f97e()
{
	var_84963f35 = self function_d7c9337c();
	if(isdefined(var_84963f35))
	{
		self zm_weapons::weapon_take(var_84963f35);
	}
}

/*
	Name: on_ai_spawned
	Namespace: namespace_9cf755b
	Checksum: 0xE084865A
	Offset: 0x21A8
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
private function on_ai_spawned()
{
	if(self.archetype === #"zombie")
	{
		self.var_8b59c468 = &function_ae18909c;
	}
}

/*
	Name: function_ae18909c
	Namespace: namespace_9cf755b
	Checksum: 0x2970E590
	Offset: 0x21E8
	Size: 0xA6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ae18909c()
{
	b_success = 0;
	if(level flag::get(#"hash_595f26b382ef7867"))
	{
		b_success = self namespace_3e3742fd::function_8033b54();
	}
	if(!b_success && level flag::get(#"hash_3a183a144032bbf3"))
	{
		b_success = self namespace_825eac6b::function_33d9b1f8();
	}
	if(!b_success)
	{
		self.var_8b59c468 = undefined;
	}
}

/*
	Name: is_ray_gun
	Namespace: namespace_9cf755b
	Checksum: 0x50B61FE6
	Offset: 0x2298
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_ray_gun(w_weapon)
{
	return isinarray(level.var_2aeeb358, w_weapon);
}

/*
	Name: function_c654e39a
	Namespace: namespace_9cf755b
	Checksum: 0xAF5BFF39
	Offset: 0x22D0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_c654e39a(w_weapon)
{
	return isinarray(level.var_584a3e61, w_weapon);
}

/*
	Name: function_7b08796f
	Namespace: namespace_9cf755b
	Checksum: 0xEC3E7B91
	Offset: 0x2308
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_7b08796f()
{
	return isdefined(self function_c7274071());
}

/*
	Name: function_c7274071
	Namespace: namespace_9cf755b
	Checksum: 0xC62B21FE
	Offset: 0x2330
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_c7274071()
{
	foreach(var_ea6b9209 in level.var_2aeeb358)
	{
		if(self hasweapon(var_ea6b9209))
		{
			return var_ea6b9209;
		}
	}
}

/*
	Name: function_358da2a7
	Namespace: namespace_9cf755b
	Checksum: 0x3DD16B1E
	Offset: 0x23C8
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function function_358da2a7(e_player)
{
	if(level flag::get("enable_countermeasure_5") && self.stub.related_parent.var_4f84520b === 0)
	{
		w_give = self.stub.related_parent.var_5af20245;
		var_40d3de6c = e_player function_c7274071();
		if(isdefined(var_40d3de6c))
		{
			if(var_40d3de6c == w_give)
			{
				self sethintstring(zm_utility::function_d6046228(#"hash_1ee18bf56df7a29b", #"hash_39d6b1ad0b94f111"));
			}
			else
			{
				self sethintstring(zm_utility::function_d6046228(#"hash_172253c9314825fc", #"hash_71016e43b6fe0570"), w_give.displayname, var_40d3de6c.displayname);
			}
		}
		else
		{
			self sethintstring(zm_utility::function_d6046228(#"hash_314a7588b45256eb", #"hash_6831cfd35264e1"), w_give.displayname);
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_d1ca61a7
	Namespace: namespace_9cf755b
	Checksum: 0xF78FDA33
	Offset: 0x2570
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_d1ca61a7()
{
	self endon(#"death");
	w_give = self.var_5af20245;
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	e_player = var_be17187b.e_who;
	var_40d3de6c = e_player function_c7274071();
	b_give_weapon = 1;
	if(isdefined(var_40d3de6c))
	{
		if(var_40d3de6c == w_give)
		{
			e_player zm_weapons::function_7c5dd4bd(w_give);
			b_give_weapon = 0;
		}
		else
		{
			e_player zm_weapons::weapon_take(var_40d3de6c);
		}
	}
	if(b_give_weapon)
	{
		e_player zm_weapons::weapon_give(w_give, 1);
	}
	self.var_4f84520b = 1;
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self hide();
}

/*
	Name: function_8a4b7d4a
	Namespace: namespace_9cf755b
	Checksum: 0x80AAFA6D
	Offset: 0x26C0
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_8a4b7d4a(weapon)
{
	if(isinarray(level.var_65b6264d, weapon))
	{
		foreach(var_edd21c9a in level.var_65b6264d)
		{
			if(self hasweapon(var_edd21c9a, 1))
			{
				return var_edd21c9a;
			}
		}
	}
}

/*
	Name: function_afbd7223
	Namespace: namespace_9cf755b
	Checksum: 0x52D2336B
	Offset: 0x2780
	Size: 0x298
	Parameters: 2
	Flags: Linked
*/
function function_afbd7223(oldweapondata, newweapondata)
{
	w_current = oldweapondata[#"weapon"];
	var_2153c223 = newweapondata[#"weapon"];
	if(isinarray(level.var_65b6264d, w_current) && isinarray(level.var_65b6264d, var_2153c223))
	{
		weapondata = [];
		var_8500c3b7 = array(level.var_2aeeb358[3], level.var_2aeeb358[1], level.var_2aeeb358[2], level.var_2aeeb358[0]);
		foreach(var_9fbd6e74 in var_8500c3b7)
		{
			if(w_current == var_9fbd6e74 || var_2153c223 == var_9fbd6e74)
			{
				weapondata[#"weapon"] = var_9fbd6e74;
				break;
			}
		}
		var_a0bd414d = weapondata[#"weapon"];
		weapondata[#"clip"] = int(min(newweapondata[#"clip"] + oldweapondata[#"clip"], var_a0bd414d.clipsize));
		weapondata[#"stock"] = int(min(newweapondata[#"stock"] + oldweapondata[#"stock"], var_a0bd414d.maxammo));
		return weapondata;
	}
}

/*
	Name: function_c05cc102
	Namespace: namespace_9cf755b
	Checksum: 0x614F142E
	Offset: 0x2A20
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_c05cc102(s_params)
{
	self endon(#"death");
	if(!zm_utility::function_850e7499(s_params.weapon))
	{
		return;
	}
	var_be17187b = undefined;
	var_be17187b = s_params.projectile waittill(#"projectile_impact_explode", #"explode", #"death");
	if(isdefined(s_params.projectile) && var_be17187b._notify == "death")
	{
		level notify(#"hash_3042a9bf2f57ea0a", {#hash_814c9389:s_params.projectile.origin, #attacker:self});
	}
	else if(var_be17187b._notify == "projectile_impact_explode")
	{
		level notify(#"hash_3042a9bf2f57ea0a", {#hash_814c9389:var_be17187b.position, #attacker:self});
	}
}

