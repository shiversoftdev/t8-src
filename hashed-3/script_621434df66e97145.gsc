// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using script_6a3f43063dfd1bdc;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_87b5173f;

/*
	Name: preload
	Namespace: namespace_87b5173f
	Checksum: 0xEB9F79DC
	Offset: 0x428
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	clientfield::register("actor", "shower_trap_death_fx", 1, 1, "int");
	clientfield::register("scriptmover", "shower_trap_fx", 1, 1, "int");
	clientfield::register("toplayer", "player_shower_trap_post_fx", 18000, 1, "int");
	clientfield::register("toplayer", "player_fire_trap_post_fx", 18000, 1, "int");
	clientfield::register("scriptmover", "fire_trap_fx", 1, 1, "int");
	clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int");
	clientfield::register("actor", "spinning_trap_eye_fx", 1, 1, "int");
	clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int");
}

/*
	Name: init
	Namespace: namespace_87b5173f
	Checksum: 0x912BB3F1
	Offset: 0x5B8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread init_weapons_locker();
	level thread function_33e9442f();
	level thread function_31c7123b();
	level thread function_d8a7606();
	level thread function_982029e3();
}

/*
	Name: init_weapons_locker
	Namespace: namespace_87b5173f
	Checksum: 0x48194F49
	Offset: 0x640
	Size: 0x30C
	Parameters: 0
	Flags: Linked
*/
function init_weapons_locker()
{
	level.s_weapons_locker = struct::get("s_weapons_locker", "targetname");
	level.s_weapons_locker.a_weapons = getentarray(level.s_weapons_locker.target, "targetname");
	foreach(weapon in level.s_weapons_locker.a_weapons)
	{
		weapon setinvisibletoall();
	}
	if(zm_utility::function_e51dc2d8() || zm_utility::function_3bff983f())
	{
		foreach(e_player in getplayers())
		{
			if(isdefined(e_player))
			{
				e_player function_af613bbf(level.s_weapons_locker.a_weapons);
				e_player.var_5a5bf8e7 = 0;
			}
		}
	}
	callback::on_connect(&on_player_connect);
	level flag::wait_till(#"hash_25d9ccebd2bdecd9");
	var_89ea5336 = getent("e_sarge_l", "targetname");
	var_ff82be75 = getent("e_sarge_r", "targetname");
	var_89ea5336 playsound(#"hash_75410a9cb6086f34");
	var_89ea5336 rotateyaw(185, 0.85, 0.1, 0.1);
	var_ff82be75 rotateyaw(-220, 1, 0.05, 0.05);
	level.s_weapons_locker zm_unitrigger::create(&function_9d485d13, 64);
	level.s_weapons_locker thread function_4ef09c7a();
}

/*
	Name: function_33e9442f
	Namespace: namespace_87b5173f
	Checksum: 0x7DDB91A3
	Offset: 0x958
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_33e9442f()
{
	level.s_ray_gun_case = struct::get("s_ray_gun_case", "targetname");
	level.s_ray_gun_case.var_1c12e292 = struct::get("rg_case", "targetname");
	level.s_ray_gun_case.var_1c12e292 scene::play("idle");
	level.s_ray_gun_case.var_a2b9ebe7 = getent(level.s_ray_gun_case.target, "targetname");
	level.s_ray_gun_case.var_a2b9ebe7.var_5af20245 = level.var_2aeeb358[3];
	if(zm_utility::function_e51dc2d8())
	{
		s_unitrigger = level.s_ray_gun_case.var_a2b9ebe7 zm_unitrigger::create(&namespace_9cf755b::function_358da2a7);
		level.s_ray_gun_case.var_a2b9ebe7.var_4f84520b = 0;
		level flag::wait_till(#"enable_countermeasure_5");
		level.s_ray_gun_case.var_1c12e292 scene::play("open");
		zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
		level.s_ray_gun_case.var_a2b9ebe7 thread namespace_9cf755b::function_d1ca61a7();
	}
	else
	{
		level.s_ray_gun_case.var_a2b9ebe7 hide();
	}
}

/*
	Name: function_31c7123b
	Namespace: namespace_87b5173f
	Checksum: 0xC1640E9B
	Offset: 0xB58
	Size: 0x278
	Parameters: 0
	Flags: Linked
*/
function function_31c7123b()
{
	level.s_shower_trap = struct::get("s_shower_trap", "targetname");
	var_3b2c2d10 = level.s_shower_trap;
	var_3b2c2d10._trap_type = "acid";
	var_3b2c2d10.e_volume = getent(var_3b2c2d10.target, "targetname");
	var_3b2c2d10.e_volume._trap_type = "acid";
	var_3b2c2d10.var_28ea1870 = struct::get_array(var_3b2c2d10.target3, "targetname");
	var_3b2c2d10.var_54a168f2 = struct::get_array(var_3b2c2d10.target2, "targetname");
	var_3b2c2d10.a_e_lights = getentarray(var_3b2c2d10.target4, "targetname");
	var_3b2c2d10.var_2c0d31a5 = struct::get_array(var_3b2c2d10.target5, "targetname");
	var_3b2c2d10.var_6b64b967 = 0;
	var_3b2c2d10.var_41ee2ddc = 1;
	level flag::wait_till("all_players_spawned");
	level flag::wait_till(#"hash_25d9cdebd2bdee8c");
	foreach(s_button in var_3b2c2d10.var_54a168f2)
	{
		s_button.var_3b2c2d10 = var_3b2c2d10;
		s_button zm_unitrigger::create(&function_67b12ae8, 64);
		s_button thread function_6c029b7();
		s_button thread function_79eec899();
	}
}

/*
	Name: function_6c029b7
	Namespace: namespace_87b5173f
	Checksum: 0x6B2EFF5F
	Offset: 0xDD8
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_6c029b7()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(isdefined(self.power_flag) && !level flag::get(self.power_flag))
		{
			continue;
		}
		if(level.s_shower_trap.var_6b64b967 === 1)
		{
			continue;
		}
		if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.s_shower_trap.var_41ee2ddc === 1)
		{
			var_b5f26b1a = self.var_3b2c2d10.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			if(!var_b5f26b1a)
			{
				continue;
			}
			self notify(#"hash_41d1d9f238b43a7");
			self.var_64c09f7f = e_who;
			level.s_shower_trap.activated_by_player = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"hash_3f3ef774cd01d778", #"activate");
			}
		}
	}
}

/*
	Name: function_79eec899
	Namespace: namespace_87b5173f
	Checksum: 0x89589AB1
	Offset: 0x1018
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_79eec899()
{
	level endon(#"end_game");
	function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	function_eb59d9fe(level.s_shower_trap.var_2c0d31a5);
	while(true)
	{
		self waittill(#"hash_41d1d9f238b43a7");
		function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		level.s_shower_trap.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
		}
		level.s_shower_trap function_17b07f6c(e_who);
		level.s_shower_trap.var_6b64b967 = 0;
		level.s_shower_trap.var_41ee2ddc = 0;
		var_628a2951 = zm_traps::function_da13db45(60, e_who);
		wait(var_628a2951);
		function_91ecec97(level.s_shower_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		level.s_shower_trap.var_41ee2ddc = 1;
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: function_17b07f6c
	Namespace: namespace_87b5173f
	Checksum: 0x61900E80
	Offset: 0x1238
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_17b07f6c(e_player)
{
	level endon(#"end_game");
	n_total_time = 0;
	self thread shower_trap_fx(1);
	while(n_total_time < 40)
	{
		self thread function_9c9d3bdc(e_player);
		self thread function_17f9c268();
		wait(0.1);
		n_total_time = n_total_time + 0.1;
	}
	self thread shower_trap_fx(0);
}

/*
	Name: function_9c9d3bdc
	Namespace: namespace_87b5173f
	Checksum: 0x8CA8EFAE
	Offset: 0x12F8
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_9c9d3bdc(var_64c09f7f)
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && ai istouching(self.e_volume))
		{
			ai thread function_a77f3804(var_64c09f7f, self.e_volume);
		}
	}
}

/*
	Name: function_a77f3804
	Namespace: namespace_87b5173f
	Checksum: 0x3AD2C471
	Offset: 0x13D8
	Size: 0x1CC
	Parameters: 2
	Flags: Linked
*/
function function_a77f3804(var_64c09f7f, e_volume)
{
	self endon(#"death");
	self.marked_for_death = 1;
	if(isdefined(level.s_shower_trap.activated_by_player) && isplayer(level.s_shower_trap.activated_by_player))
	{
		level.s_shower_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
		level.s_shower_trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
	}
	self clientfield::set("shower_trap_death_fx", 1);
	level notify(#"hash_336bf8053ce21208", {#e_player:var_64c09f7f});
	wait(randomfloatrange(0.25, 0.5));
	if(isalive(self))
	{
		self zombie_utility::gib_random_parts();
		self thread function_d55cc959();
		self.var_12745932 = 1;
		self dodamage(self.health + 1000, e_volume.origin, e_volume);
	}
}

/*
	Name: shower_trap_fx
	Namespace: namespace_87b5173f
	Checksum: 0xA2943ACB
	Offset: 0x15B0
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function shower_trap_fx(var_9d9f02b4)
{
	if(var_9d9f02b4)
	{
		foreach(var_9e659454 in self.var_28ea1870)
		{
			var_9e659454.mdl_fx = util::spawn_model("tag_origin", var_9e659454.origin, var_9e659454.angles);
			var_9e659454.mdl_fx clientfield::set("shower_trap_fx", 1);
		}
	}
	else
	{
		foreach(var_9e659454 in self.var_28ea1870)
		{
			var_9e659454.mdl_fx clientfield::set("shower_trap_fx", 0);
			waitframe(1);
			var_9e659454.mdl_fx delete();
		}
	}
}

/*
	Name: function_d55cc959
	Namespace: namespace_87b5173f
	Checksum: 0x56BDAC6A
	Offset: 0x1728
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_d55cc959()
{
	wait(2);
	if(isdefined(self))
	{
		self clientfield::set("shower_trap_death_fx", 0);
	}
}

/*
	Name: function_17f9c268
	Namespace: namespace_87b5173f
	Checksum: 0xDEFC5C6B
	Offset: 0x1768
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_17f9c268()
{
	foreach(e_player in getplayers())
	{
		if(e_player istouching(self.e_volume))
		{
			e_player thread function_b691c69(self);
		}
	}
}

/*
	Name: function_b691c69
	Namespace: namespace_87b5173f
	Checksum: 0x46004080
	Offset: 0x1810
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_b691c69(var_3b2c2d10)
{
	self endon(#"death", #"disconnect");
	if(!isdefined(self.var_e613b44) || !self.var_e613b44)
	{
		self.var_e613b44 = 1;
		e_volume = var_3b2c2d10.e_volume;
		self thread function_24c4375b();
		if(e_volume zm_traps::function_3f401e8d(self))
		{
			return;
		}
		if(!self laststand::player_is_in_laststand())
		{
			if(zm_utility::is_standard())
			{
				self dodamage(50, self.origin, undefined, e_volume);
			}
			else
			{
				self dodamage(150, self.origin, undefined, e_volume);
			}
			self zm_audio::playerexert("cough");
		}
	}
}

/*
	Name: function_24c4375b
	Namespace: namespace_87b5173f
	Checksum: 0x94EFF561
	Offset: 0x1958
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_24c4375b()
{
	self endon(#"bled_out", #"disconnect");
	if(self clientfield::get_to_player("player_shower_trap_post_fx") === 1)
	{
		return;
	}
	self clientfield::set_to_player("player_shower_trap_post_fx", 1);
	wait(1);
	self.var_e613b44 = 0;
	self clientfield::set_to_player("player_shower_trap_post_fx", 0);
}

/*
	Name: function_13e49422
	Namespace: namespace_87b5173f
	Checksum: 0xD2E0A056
	Offset: 0x1A00
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_13e49422(trap)
{
	playsoundatposition(#"hash_4b93c2d674807e60", self.origin);
	self waittill(#"available");
	playsoundatposition(#"hash_16ec74a08f28a468", self.origin);
}

/*
	Name: function_d8a7606
	Namespace: namespace_87b5173f
	Checksum: 0x33BC82DC
	Offset: 0x1A80
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_d8a7606()
{
	level.s_fire_trap = struct::get("s_fire_trap", "targetname");
	var_3b2c2d10 = level.s_fire_trap;
	var_3b2c2d10._trap_type = "fire";
	var_3b2c2d10.e_volume = getent(var_3b2c2d10.target, "targetname");
	var_3b2c2d10.e_volume._trap_type = "fire";
	var_3b2c2d10.var_28ea1870 = struct::get_array(var_3b2c2d10.target3, "targetname");
	var_3b2c2d10.var_54a168f2 = struct::get_array(var_3b2c2d10.target2, "targetname");
	var_3b2c2d10.a_e_lights = getentarray(var_3b2c2d10.target4, "targetname");
	var_3b2c2d10.var_2c0d31a5 = struct::get_array(var_3b2c2d10.target5, "targetname");
	var_3b2c2d10.var_6b64b967 = 0;
	var_3b2c2d10.var_41ee2ddc = 1;
	level flag::wait_till("all_players_spawned");
	level flag::wait_till(#"hash_25d9caebd2bde973");
	foreach(s_button in var_3b2c2d10.var_54a168f2)
	{
		s_button.var_3b2c2d10 = var_3b2c2d10;
		s_button zm_unitrigger::create(&function_67b12ae8, 64);
		s_button thread function_f24b1ecb();
		s_button thread function_64fa1b6a();
		s_button thread function_cbeb9a33();
	}
}

/*
	Name: function_f24b1ecb
	Namespace: namespace_87b5173f
	Checksum: 0x1A45AB14
	Offset: 0x1D18
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_f24b1ecb()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(isdefined(self.power_flag) && !level flag::get(self.power_flag))
		{
			continue;
		}
		if(level.s_fire_trap.var_6b64b967 === 1)
		{
			continue;
		}
		if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.s_fire_trap.var_41ee2ddc === 1)
		{
			var_b5f26b1a = self.var_3b2c2d10.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			if(!var_b5f26b1a)
			{
				continue;
			}
			self notify(#"hash_17a4c7c988aa685");
			self.var_64c09f7f = e_who;
			level.s_fire_trap.activated_by_player = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"hash_3f3ef774cd01d778", #"activate");
			}
		}
	}
}

/*
	Name: function_64fa1b6a
	Namespace: namespace_87b5173f
	Checksum: 0x2C123174
	Offset: 0x1F58
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_64fa1b6a()
{
	level endon(#"end_game");
	function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	function_eb59d9fe(level.s_fire_trap.var_2c0d31a5);
	while(true)
	{
		self waittill(#"hash_17a4c7c988aa685");
		function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		level.s_fire_trap.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
		}
		level.s_fire_trap function_aa5e0bca(e_who);
		level.s_fire_trap.var_6b64b967 = 0;
		level.s_fire_trap.var_41ee2ddc = 0;
		var_628a2951 = zm_traps::function_da13db45(60, e_who);
		wait(var_628a2951);
		function_91ecec97(level.s_fire_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		level.s_fire_trap.var_41ee2ddc = 1;
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: function_aa5e0bca
	Namespace: namespace_87b5173f
	Checksum: 0xAFBEAEA2
	Offset: 0x2178
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_aa5e0bca(e_player)
{
	level endon(#"end_game");
	n_total_time = 0;
	self thread fire_trap_fx(1);
	while(n_total_time < 40)
	{
		self thread function_bd117af1(e_player);
		self thread function_956ddb52();
		wait(0.1);
		n_total_time = n_total_time + 0.1;
	}
	self thread fire_trap_fx(0);
}

/*
	Name: function_bd117af1
	Namespace: namespace_87b5173f
	Checksum: 0xB9BAC840
	Offset: 0x2238
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_bd117af1(var_64c09f7f)
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && ai istouching(self.e_volume))
		{
			ai thread function_11e5b2ee(var_64c09f7f, self.e_volume);
		}
	}
}

/*
	Name: function_11e5b2ee
	Namespace: namespace_87b5173f
	Checksum: 0xEB2BF40
	Offset: 0x2318
	Size: 0x334
	Parameters: 2
	Flags: Linked
*/
function function_11e5b2ee(var_64c09f7f, e_volume)
{
	self endon(#"death");
	self.marked_for_death = 1;
	if(isdefined(level.s_fire_trap.activated_by_player) && isplayer(level.s_fire_trap.activated_by_player))
	{
		level.s_fire_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
		level.s_fire_trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
	}
	level notify(#"hash_5bf8e381a1e393c6", {#e_player:var_64c09f7f});
	if(isdefined(self.animname) && self.animname != "zombie_dog")
	{
		if(level.burning_zombies.size < 6)
		{
			level.burning_zombies[level.burning_zombies.size] = self;
			self thread zm_traps::zombie_flame_watch();
			self playsound(#"zmb_ignite");
			self thread zombie_death::flame_death_fx();
			playfxontag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
			wait(randomfloat(1.25));
		}
		else
		{
			refs[0] = "guts";
			refs[1] = "right_arm";
			refs[2] = "left_arm";
			refs[3] = "right_leg";
			refs[4] = "left_leg";
			refs[5] = "no_legs";
			refs[6] = "head";
			self.a.gib_ref = refs[randomint(refs.size)];
			playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
			wait(randomfloat(1.25));
			self playsound(#"wpn_zmb_electrap_zap");
		}
	}
	self.var_12745932 = 1;
	self dodamage(self.health + 666, self.origin, e_volume);
}

/*
	Name: fire_trap_fx
	Namespace: namespace_87b5173f
	Checksum: 0x41976F3A
	Offset: 0x2658
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function fire_trap_fx(var_9d9f02b4)
{
	if(var_9d9f02b4)
	{
		foreach(var_9e659454 in self.var_28ea1870)
		{
			var_9e659454.mdl_fx = util::spawn_model("tag_origin", var_9e659454.origin, var_9e659454.angles);
			var_9e659454.mdl_fx clientfield::set("fire_trap_fx", 1);
		}
	}
	else
	{
		foreach(var_9e659454 in self.var_28ea1870)
		{
			var_9e659454.mdl_fx clientfield::set("fire_trap_fx", 0);
			waitframe(1);
			var_9e659454.mdl_fx delete();
		}
	}
}

/*
	Name: function_956ddb52
	Namespace: namespace_87b5173f
	Checksum: 0xD37D9049
	Offset: 0x27D0
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_956ddb52()
{
	foreach(e_player in getplayers())
	{
		if(e_player istouching(self.e_volume))
		{
			e_player thread function_5c6fd230(self);
		}
	}
}

/*
	Name: function_5c6fd230
	Namespace: namespace_87b5173f
	Checksum: 0xD207C110
	Offset: 0x2878
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_5c6fd230(var_3b2c2d10)
{
	self endon(#"death", #"disconnect");
	if(self zm_traps::function_3f401e8d(self))
	{
		return;
	}
	if(!(isdefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand())
	{
		self.is_burning = 1;
		self thread function_867c70bf();
		if(isdefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered)
		{
			visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
		}
		else
		{
			self setburn(1.25);
		}
		self notify(#"burned");
		self dodamage(50, self.origin);
		wait(0.2);
		self.is_burning = undefined;
	}
}

/*
	Name: function_867c70bf
	Namespace: namespace_87b5173f
	Checksum: 0x23E1B80F
	Offset: 0x29D0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_867c70bf()
{
	self endon(#"death");
	if(self clientfield::get_to_player("player_fire_trap_post_fx") === 1)
	{
		return;
	}
	self clientfield::set_to_player("player_fire_trap_post_fx", 1);
	wait(1.45);
	self.is_burning = undefined;
	self clientfield::set_to_player("player_fire_trap_post_fx", 0);
}

/*
	Name: function_982029e3
	Namespace: namespace_87b5173f
	Checksum: 0xF85C33C5
	Offset: 0x2A68
	Size: 0x2B8
	Parameters: 0
	Flags: Linked
*/
function function_982029e3()
{
	level.s_spinning_trap = struct::get("s_spinning_trap", "targetname");
	var_3b2c2d10 = level.s_spinning_trap;
	var_3b2c2d10._trap_type = "rotating";
	var_3b2c2d10.e_volume = getent(var_3b2c2d10.target, "targetname");
	var_3b2c2d10.e_volume._trap_type = "rotating";
	var_3b2c2d10.var_54a168f2 = struct::get_array(var_3b2c2d10.target2, "targetname");
	var_3b2c2d10.a_e_lights = getentarray(var_3b2c2d10.target4, "targetname");
	var_3b2c2d10.var_2c0d31a5 = struct::get_array(var_3b2c2d10.target5, "targetname");
	var_3b2c2d10.e_trap = struct::get(var_3b2c2d10.target3, "targetname");
	var_3b2c2d10.e_trap thread scene::play("idle");
	var_3b2c2d10.var_6b64b967 = 0;
	var_3b2c2d10.var_41ee2ddc = 1;
	level flag::wait_till("all_players_spawned");
	level flag::wait_till(#"hash_25d9cbebd2bdeb26");
	foreach(s_button in var_3b2c2d10.var_54a168f2)
	{
		s_button.var_3b2c2d10 = var_3b2c2d10;
		s_button zm_unitrigger::create(&function_67b12ae8, 64);
		s_button thread function_6facfabc();
		s_button thread function_7fffc105();
		s_button thread function_cbeb9a33();
	}
}

/*
	Name: function_6facfabc
	Namespace: namespace_87b5173f
	Checksum: 0x2978B14
	Offset: 0x2D28
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_6facfabc()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(isdefined(self.power_flag) && !level flag::get(self.power_flag))
		{
			continue;
		}
		if(level.s_spinning_trap.var_6b64b967 === 1)
		{
			continue;
		}
		if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.s_spinning_trap.var_41ee2ddc === 1)
		{
			var_b5f26b1a = self.var_3b2c2d10.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			if(!var_b5f26b1a)
			{
				continue;
			}
			self notify(#"hash_5a7f89c0b12d9f27");
			self.var_64c09f7f = e_who;
			level.s_spinning_trap.activated_by_player = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"hash_3f3ef774cd01d778", #"activate");
			}
		}
	}
}

/*
	Name: function_7fffc105
	Namespace: namespace_87b5173f
	Checksum: 0x33ED752F
	Offset: 0x2F68
	Size: 0x250
	Parameters: 0
	Flags: Linked
*/
function function_7fffc105()
{
	level endon(#"end_game");
	function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	function_eb59d9fe(level.s_spinning_trap.var_2c0d31a5);
	while(true)
	{
		self waittill(#"hash_5a7f89c0b12d9f27");
		function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		level.s_spinning_trap.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
		}
		level.s_spinning_trap.e_volume playsound(#"hash_345bf7f9d6f848b9");
		level.s_spinning_trap function_cb206caf(e_who);
		level.s_spinning_trap.var_6b64b967 = 0;
		level.s_spinning_trap.var_41ee2ddc = 0;
		var_628a2951 = zm_traps::function_da13db45(60, e_who);
		wait(var_628a2951);
		function_91ecec97(level.s_spinning_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		level.s_spinning_trap.var_41ee2ddc = 1;
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: function_cb206caf
	Namespace: namespace_87b5173f
	Checksum: 0x7B81D395
	Offset: 0x31C0
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_cb206caf(e_player)
{
	level endon(#"end_game");
	n_total_time = 0;
	self.e_trap scene::play("intro");
	snd_ent = spawn("script_origin", level.s_spinning_trap.origin);
	snd_ent playloopsound(#"hash_57820fd1863bbf19");
	while(n_total_time < 40)
	{
		self thread function_74a809fd();
		self thread function_b45556a4(e_player);
		self thread function_fcac4b4e();
		wait(0.1);
		n_total_time = n_total_time + 0.1;
	}
	self notify(#"hash_4334e5d9747e57ef");
	level.s_spinning_trap.e_volume playsound(#"hash_632248542476cd73");
	snd_ent stoploopsound();
	self.e_trap scene::play("outro");
	snd_ent delete();
}

/*
	Name: function_74a809fd
	Namespace: namespace_87b5173f
	Checksum: 0xEE03B3BC
	Offset: 0x3370
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_74a809fd()
{
	self endon(#"hash_4334e5d9747e57ef");
	while(true)
	{
		self.e_trap scene::play("loop");
	}
}

/*
	Name: function_b45556a4
	Namespace: namespace_87b5173f
	Checksum: 0x31C43636
	Offset: 0x33C0
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_b45556a4(var_64c09f7f)
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && ai istouching(self.e_volume))
		{
			ai thread function_7bd8cfde(var_64c09f7f, self);
		}
	}
}

/*
	Name: function_7bd8cfde
	Namespace: namespace_87b5173f
	Checksum: 0x3189E977
	Offset: 0x3498
	Size: 0x464
	Parameters: 2
	Flags: Linked
*/
function function_7bd8cfde(var_64c09f7f, var_3b2c2d10)
{
	self endon(#"death");
	if(isdefined(self.var_bd4627e1) && self.var_bd4627e1)
	{
		return;
	}
	if(isdefined(self.var_ad81ef15) && self.var_ad81ef15)
	{
		return;
	}
	self.var_ad81ef15 = 1;
	self.marked_for_death = 1;
	if(isdefined(var_3b2c2d10.activated_by_player) && isplayer(var_3b2c2d10.activated_by_player))
	{
		var_3b2c2d10.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
		var_3b2c2d10.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
	}
	level notify(#"hash_63be45d89436088", {#e_player:var_64c09f7f});
	if(isalive(self) && (!isdefined(self.var_bd4627e1) || !self.var_bd4627e1))
	{
		self clientfield::set("spinning_trap_blood_fx", 1);
	}
	self playsound(#"hash_42c6cc2204b7fbbd");
	var_8e0f01f = var_3b2c2d10.e_trap.scene_ents[#"hash_7aff0ee60ddd937b"] gettagorigin("tag_fan_blade_A_2");
	n_dist = distance2d(self.origin, var_8e0f01f);
	if(!(isdefined(var_3b2c2d10.var_705682df) && var_3b2c2d10.var_705682df) && self.var_6f84b820 === #"basic" && n_dist <= 128 && self.team != #"allies")
	{
		self thread function_bcfd9acb(var_3b2c2d10);
		a_e_players = util::get_array_of_closest(self.origin, getplayers());
	}
	else if(isai(self) && !isvehicle(self))
	{
		self thread function_572d630b();
	}
	if(self.var_6f84b820 === #"basic" && !isvehicle(self))
	{
		if(randomint(100) < 20)
		{
			gibserverutils::annihilate(self);
		}
		else
		{
			self function_63e5e387(var_3b2c2d10);
		}
		level notify(#"hash_148b3ce521088846", {#e_player:var_64c09f7f});
		self dodamage(self.health + 1000, self.origin, var_3b2c2d10.e_volume);
	}
	else
	{
		level notify(#"hash_148b3ce521088846", {#e_player:var_64c09f7f});
		self dodamage(self.health + 1000, self.origin, var_3b2c2d10.e_volume);
	}
}

/*
	Name: function_bcfd9acb
	Namespace: namespace_87b5173f
	Checksum: 0xEF708BDF
	Offset: 0x3908
	Size: 0x3B6
	Parameters: 1
	Flags: Linked
*/
function function_bcfd9acb(var_3b2c2d10)
{
	var_3b2c2d10.var_705682df = 1;
	self.var_bd4627e1 = 1;
	self clientfield::set("spinning_trap_eye_fx", 1);
	var_e72c9959 = util::spawn_model("tag_origin", var_3b2c2d10.e_trap.scene_ents[#"hash_7aff0ee60ddd937b"] gettagorigin("tag_fan_blade_A_2"), var_3b2c2d10.e_trap.scene_ents[#"hash_7aff0ee60ddd937b"] gettagangles("tag_fan_blade_A_2"));
	var_e72c9959 linkto(var_3b2c2d10.e_trap.scene_ents[#"hash_7aff0ee60ddd937b"], "tag_fan_blade_A_2");
	self val::set("spinning_trap", "ignoreall", 1);
	self val::set("spinning_trap", "allowdeath", 0);
	self.b_ignore_cleanup = 1;
	self.health = 1;
	self notsolid();
	self setteam(util::get_enemy_team(self.team));
	self zombie_utility::makezombiecrawler(1);
	var_e72c9959 thread scene::init(#"hash_6a81729051de85ac", self);
	playsoundatposition(#"hash_42c6cc2204b7fbbd", self.origin);
	var_3b2c2d10 waittill(#"hash_4334e5d9747e57ef");
	var_44342e79 = var_e72c9959 scene::function_8582657c(#"p8_fxanim_zm_esc_trap_fan_play", "Shot 2");
	var_e72c9959 scene::play(#"hash_6a81729051de85ac", self);
	if(isdefined(self))
	{
		self val::reset("spinning_trap", "ignoreall");
		self val::reset("spinning_trap", "allowdeath");
		self.b_ignore_cleanup = 0;
		self solid();
		self setteam(level.zombie_team);
		self clientfield::set("spinning_trap_eye_fx", 0);
		self dodamage(self.health + 1000, self.origin);
	}
	var_e72c9959 unlink();
	var_e72c9959 delete();
	var_3b2c2d10.var_705682df = undefined;
}

/*
	Name: function_63e5e387
	Namespace: namespace_87b5173f
	Checksum: 0x15FBE765
	Offset: 0x3CC8
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_63e5e387(var_3b2c2d10)
{
	n_lift_height = randomintrange(8, 64);
	v_away_from_source = vectornormalize(self.origin - var_3b2c2d10.e_volume.origin);
	v_away_from_source = v_away_from_source * 128;
	v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
	a_trace = physicstraceex(self.origin + vectorscale((0, 0, 1), 32), self.origin + v_away_from_source, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), self);
	self setplayercollision(0);
	self startragdoll();
	self launchragdoll(150 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
}

/*
	Name: function_fcac4b4e
	Namespace: namespace_87b5173f
	Checksum: 0xEBD72FE3
	Offset: 0x3E30
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_fcac4b4e()
{
	foreach(e_player in getplayers())
	{
		if(e_player istouching(self.e_volume))
		{
			e_player thread function_1259cbbb(self);
		}
	}
}

/*
	Name: function_1259cbbb
	Namespace: namespace_87b5173f
	Checksum: 0x52E2FCE6
	Offset: 0x3ED8
	Size: 0x1B6
	Parameters: 1
	Flags: Linked
*/
function function_1259cbbb(var_3b2c2d10)
{
	self endon(#"death", #"disconnect");
	if(!isdefined(self.var_c87b7253) || !self.var_c87b7253)
	{
		e_volume = var_3b2c2d10.e_volume;
		if(e_volume zm_traps::function_3f401e8d(self))
		{
			return;
		}
		if(!self laststand::player_is_in_laststand())
		{
			if(zm_utility::is_standard())
			{
				self dodamage(50, self.origin, undefined, e_volume);
			}
			else
			{
				self.var_c87b7253 = 1;
				if(self.health >= 200)
				{
					self dodamage(50, self.origin, undefined, e_volume);
					wait(0.75);
					self.var_c87b7253 = 0;
				}
				else if(self.health >= 100)
				{
					self dodamage(35, self.origin, undefined, e_volume);
					wait(0.75);
					self.var_c87b7253 = 0;
				}
				else
				{
					self dodamage(15, self.origin, undefined, e_volume);
					wait(0.75);
					self.var_c87b7253 = 0;
				}
			}
		}
	}
}

/*
	Name: function_572d630b
	Namespace: namespace_87b5173f
	Checksum: 0xE04BD3DD
	Offset: 0x4098
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_572d630b()
{
	wait(2);
	if(isdefined(self))
	{
		self clientfield::set("spinning_trap_blood_fx", 0);
	}
}

/*
	Name: function_af613bbf
	Namespace: namespace_87b5173f
	Checksum: 0x70C65F1F
	Offset: 0x40D8
	Size: 0x222
	Parameters: 1
	Flags: Linked
*/
function function_af613bbf(a_weapons)
{
	self endon(#"disconnect");
	self.var_45c57fa5 = array::random(a_weapons);
	switch(self.var_45c57fa5.script_string)
	{
		case "tr":
		{
			self.var_af561b1f = #"hash_4176883a68b00090";
			self.var_a794d091 = #"hash_2fa3f09f73bf523c";
			self.var_636a8bf7 = #"hash_4bf5a2219b1a65d2";
			self.var_45c57fa5 setinvisibletoplayer(self, 0);
			break;
		}
		case "lmg":
		{
			self.var_af561b1f = #"hash_4e543dd90408cd76";
			self.var_a794d091 = #"hash_2e3938a646e43352";
			self.var_636a8bf7 = #"hash_1fc7843987e89a83";
			self.var_45c57fa5 setinvisibletoplayer(self, 0);
			break;
		}
		case "ar":
		{
			self.var_af561b1f = #"hash_6dd7b677c74ebba9";
			self.var_a794d091 = #"hash_24f2c78de733d877";
			self.var_636a8bf7 = #"hash_4dfeb08c20a14b8b";
			self.var_45c57fa5 setinvisibletoplayer(self, 0);
			break;
		}
		case "shotgun":
		{
			self.var_af561b1f = #"hash_58eff35154ec1990";
			self.var_a794d091 = #"hash_670dd9efc63b2d3c";
			self.var_636a8bf7 = #"hash_459f15018585edda";
			self.var_45c57fa5 setinvisibletoplayer(self, 0);
			break;
		}
	}
}

/*
	Name: function_9d485d13
	Namespace: namespace_87b5173f
	Checksum: 0x52886CB
	Offset: 0x4308
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_9d485d13(e_player)
{
	if(!e_player.var_5a5bf8e7)
	{
		str_hint = zm_utility::function_d6046228(e_player.var_af561b1f, e_player.var_a794d091);
		self sethintstring(str_hint);
		return 1;
	}
	self sethintstring("");
	return 0;
}

/*
	Name: function_4ef09c7a
	Namespace: namespace_87b5173f
	Checksum: 0x160EB579
	Offset: 0x43A0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_4ef09c7a()
{
	self endon(#"hash_5cc6008e5cdc03de");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(!isdefined(e_who.var_5a5bf8e7) || e_who.var_5a5bf8e7)
		{
			continue;
		}
		if(isdefined(e_who.var_636a8bf7))
		{
			var_498a708 = getweapon(e_who.var_636a8bf7);
		}
		e_who thread swap_weapon(var_498a708);
		e_who.var_45c57fa5 setinvisibletoplayer(e_who, 1);
		e_who.var_5a5bf8e7 = 1;
		e_who notify(#"hash_9e146af7233ec36");
	}
}

/*
	Name: on_player_connect
	Namespace: namespace_87b5173f
	Checksum: 0x8F6003F1
	Offset: 0x44C8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self function_af613bbf(level.s_weapons_locker.a_weapons);
	self.var_5a5bf8e7 = 0;
}

/*
	Name: function_67b12ae8
	Namespace: namespace_87b5173f
	Checksum: 0x19B7972B
	Offset: 0x4508
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_67b12ae8(e_player)
{
	s_button = self.stub.related_parent;
	if(e_player zm_utility::is_drinking())
	{
		self sethintstring("");
		return 0;
	}
	if(s_button.var_3b2c2d10.var_6b64b967 === 1)
	{
		self sethintstring(#"hash_39d080503c6a8d96");
		return 1;
	}
	if(isdefined(s_button.power_flag) && !level flag::get(s_button.power_flag))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(s_button.var_3b2c2d10.var_41ee2ddc === 0)
	{
		self sethintstring(#"hash_21db2780833a8bfd");
		return 1;
	}
	if(util::function_5df4294() == "zstandard")
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_61d85c966dd9e83f");
			return 1;
		}
		self sethintstring(#"hash_24a438482954901");
		return 1;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
		return 1;
	}
	self sethintstring(#"hash_23c1c09e94181fdb", 1000);
	return 1;
}

/*
	Name: function_eb59d9fe
	Namespace: namespace_87b5173f
	Checksum: 0x31B6C705
	Offset: 0x47D8
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_eb59d9fe(var_2c0d31a5)
{
	foreach(panel in var_2c0d31a5)
	{
		panel thread scene::play("open");
	}
}

/*
	Name: function_91ecec97
	Namespace: namespace_87b5173f
	Checksum: 0x3EF039BF
	Offset: 0x4868
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function function_91ecec97(a_e_lights, str_model)
{
	foreach(light in a_e_lights)
	{
		light setmodel(str_model);
	}
}

/*
	Name: swap_weapon
	Namespace: namespace_87b5173f
	Checksum: 0x71C9D480
	Offset: 0x48F8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function swap_weapon(var_498a708)
{
	var_6822257f = self getweaponslist();
	foreach(var_f99a6771 in var_6822257f)
	{
		if(var_f99a6771.rootweapon === var_498a708)
		{
			self zm_weapons::function_7c5dd4bd(var_f99a6771);
			return;
		}
	}
	if(!self hasweapon(var_498a708, 1))
	{
		self function_e2a25377(var_498a708);
	}
}

/*
	Name: function_e2a25377
	Namespace: namespace_87b5173f
	Checksum: 0x42BAD078
	Offset: 0x49F0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_e2a25377(var_498a708)
{
	if(self hasweapon(zm_weapons::get_base_weapon(var_498a708), 1))
	{
		self takeweapon(zm_weapons::get_base_weapon(var_498a708), 1);
	}
	self zm_weapons::weapon_give(var_498a708, 1);
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_87b5173f
	Checksum: 0x754D1B6A
	Offset: 0x4A80
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

