// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_29b970364d23b9;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_652c3ad8;

/*
	Name: function_89f2df9
	Namespace: namespace_652c3ad8
	Checksum: 0x9E235049
	Offset: 0x4E0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_74eeacf89752d785", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_652c3ad8
	Checksum: 0xD190ADB5
	Offset: 0x530
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "fan_trap_blood_fx", 1, 1, "int");
	clientfield::register("toplayer", "rumble_fan_trap", 1, 1, "int");
	clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int");
	clientfield::register("scriptmover", "acid_trap_fx", 1, 1, "int");
	clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int");
	clientfield::register("actor", "spinning_trap_eye_fx", 1, 1, "int");
	clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int");
	clientfield::register("toplayer", "player_acid_trap_post_fx", 1, 1, "int");
	level thread function_6dbbc97();
	level thread init_fan_trap_trigs();
	level thread init_acid_trap_trigs();
}

/*
	Name: __main__
	Namespace: namespace_652c3ad8
	Checksum: 0x5AAAD9DF
	Offset: 0x708
	Size: 0x1F8
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread function_8aeee6b8();
	var_e4f517f0 = getentarray("zm_spinning_trap", "script_noteworthy");
	foreach(var_fe861167 in var_e4f517f0)
	{
		var_fe861167 thread function_dcd775a();
	}
	var_59fe5c9e = getentarray("zm_fan_trap", "script_noteworthy");
	foreach(var_7c68fa38 in var_59fe5c9e)
	{
		var_7c68fa38 thread function_ea490292();
	}
	var_5c2bef3d = getentarray("zm_acid_trap", "script_noteworthy");
	foreach(var_4d42c97f in var_5c2bef3d)
	{
		var_4d42c97f thread function_39f2d90f();
	}
}

/*
	Name: init_fan_trap_trigs
	Namespace: namespace_652c3ad8
	Checksum: 0xC6CFA320
	Offset: 0x908
	Size: 0x424
	Parameters: 0
	Flags: Linked
*/
function init_fan_trap_trigs()
{
	var_59fe5c9e = getentarray("zm_fan_trap", "script_noteworthy");
	foreach(var_7c68fa38 in var_59fe5c9e)
	{
		var_7c68fa38._trap_cooldown_time = 25;
		var_7c68fa38.var_cd6ebde4 = [];
		var_8541c382 = getentarray(var_7c68fa38.target, "targetname");
		for(i = 0; i < var_8541c382.size; i++)
		{
			if(isdefined(var_8541c382[i].script_string))
			{
				if(var_8541c382[i].script_string == "fan_trap_rumble")
				{
					var_7c68fa38.t_rumble = var_8541c382[i];
					continue;
				}
				if(var_8541c382[i].script_string == "fxanim_fan")
				{
					var_7c68fa38.var_6dead4d5 = var_8541c382[i];
					continue;
				}
				if(var_8541c382[i].script_string == "trap_control_panel")
				{
					if(!isdefined(var_7c68fa38.var_cd6ebde4))
					{
						var_7c68fa38.var_cd6ebde4 = [];
					}
					else if(!isarray(var_7c68fa38.var_cd6ebde4))
					{
						var_7c68fa38.var_cd6ebde4 = array(var_7c68fa38.var_cd6ebde4);
					}
					if(!isinarray(var_7c68fa38.var_cd6ebde4, var_8541c382[i]))
					{
						var_7c68fa38.var_cd6ebde4[var_7c68fa38.var_cd6ebde4.size] = var_8541c382[i];
					}
				}
			}
		}
		var_1f88db8a = struct::get_array(var_7c68fa38.target);
		for(i = 0; i < var_1f88db8a.size; i++)
		{
			if(isdefined(var_1f88db8a[i].script_noteworthy))
			{
				if(var_1f88db8a[i].script_noteworthy == "brutus_trap_finder")
				{
					if(!isdefined(var_7c68fa38.var_31004a80))
					{
						var_7c68fa38.var_31004a80 = [];
					}
					else if(!isarray(var_7c68fa38.var_31004a80))
					{
						var_7c68fa38.var_31004a80 = array(var_7c68fa38.var_31004a80);
					}
					if(!isinarray(var_7c68fa38.var_31004a80, var_1f88db8a[i]))
					{
						var_7c68fa38.var_31004a80[var_7c68fa38.var_31004a80.size] = var_1f88db8a[i];
					}
				}
			}
		}
	}
	zm_traps::register_trap_basic_info("zm_fan_trap", &activate_zm_fan_trap, &function_76e0728d);
	zm_traps::register_trap_damage("zm_fan_trap", &function_5758997a, &function_9c2d463d);
	zm_traps::function_60d9e800("zm_fan_trap", &zapper_light_red, &zapper_light_green);
}

/*
	Name: function_ea490292
	Namespace: namespace_652c3ad8
	Checksum: 0x1CA8B893
	Offset: 0xD38
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_ea490292()
{
	level flag::wait_till("start_zombie_round_logic");
	self zapper_light_red();
	if(isdefined(self.script_int))
	{
		level flag::wait_till("power_on" + self.script_int);
	}
	else
	{
		level flag::wait_till("power_on");
	}
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"trap_activated");
		if(s_result.trap == self)
		{
			s_result.var_dd54ffdb zm_stats::increment_client_stat("prison_fan_trap_used", 0);
		}
	}
}

/*
	Name: activate_zm_fan_trap
	Namespace: namespace_652c3ad8
	Checksum: 0x7994919C
	Offset: 0xE48
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function activate_zm_fan_trap()
{
	level.trapped_track[#"fan"] = 1;
	self.in_use = 1;
	self thread zm_traps::trap_damage();
	self.var_6dead4d5 thread scene::init(#"p8_fxanim_zm_esc_trap_fan_play", self.var_6dead4d5);
	self thread fan_trap_timeout();
	self thread fan_trap_rumble_think();
	self waittill(#"hash_2133afbbd7534561");
	self.in_use = undefined;
	self.var_6dead4d5 thread scene::play(#"p8_fxanim_zm_esc_trap_fan_play", self.var_6dead4d5);
	a_players = getplayers();
	foreach(e_player in a_players)
	{
		if(isdefined(e_player.fan_trap_rumble) && e_player.fan_trap_rumble)
		{
			e_player clientfield::set_to_player("rumble_fan_trap", 0);
			e_player.fan_trap_rumble = undefined;
		}
	}
	self notify(#"trap_done");
	self waittill(#"available");
}

/*
	Name: function_76e0728d
	Namespace: namespace_652c3ad8
	Checksum: 0xD5445E23
	Offset: 0x1030
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_76e0728d()
{
	self playsound(#"zmb_trap_activate");
	self waittill(#"available");
	self playsound(#"zmb_trap_available");
}

/*
	Name: function_5758997a
	Namespace: namespace_652c3ad8
	Checksum: 0xD7206E39
	Offset: 0x1098
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_5758997a(t_damage)
{
	self endon(#"death");
	if(zm_utility::is_standard())
	{
		self dodamage(25, self.origin, undefined, t_damage);
	}
	else
	{
		if(!self hasperk(#"specialty_armorvest") || (self.health - 100) < 1)
		{
			radiusdamage(self.origin, 10, self.health + 100, self.health + 100, t_damage);
		}
		else
		{
			self dodamage(50, self.origin, undefined, t_damage);
		}
	}
}

/*
	Name: function_9c2d463d
	Namespace: namespace_652c3ad8
	Checksum: 0x3FAAAFF8
	Offset: 0x11A0
	Size: 0x424
	Parameters: 1
	Flags: Linked
*/
function function_9c2d463d(t_damage)
{
	if(isdefined(level.custom_fan_trap_damage_func))
	{
		self thread [[level.custom_fan_trap_damage_func]](t_damage);
		return;
	}
	if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"boss")
	{
		t_damage notify(#"hash_2133afbbd7534561");
		return;
	}
	if(isdefined(self.var_238b3806) && self.var_238b3806)
	{
		return;
	}
	if(level.round_number < 40)
	{
		self.marked_for_death = 1;
		self clientfield::set("fan_trap_blood_fx", 1);
		level notify(#"hash_528d7b7f7d6c51a1", {#e_player:t_damage.activated_by_player});
		self zombie_utility::gib_random_parts();
		playsoundatposition("zmb_trap_fan_grind", self.origin);
		self thread stop_fan_trap_blood_fx();
		self dodamage(self.health + 1000, t_damage.origin, undefined, t_damage);
		if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
		{
			t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		}
	}
	else
	{
		if(isdefined(self.var_1adc13ad) && self.var_1adc13ad)
		{
			return;
		}
		self.var_1adc13ad = 1;
		self clientfield::set("fan_trap_blood_fx", 1);
		while(isalive(self) && self istouching(t_damage) && (isdefined(t_damage.in_use) && t_damage.in_use))
		{
			self function_1395e596();
			self dodamage(self.maxhealth * 0.3, t_damage.origin, undefined, t_damage);
			playsoundatposition("zmb_trap_fan_grind", self.origin);
			wait(0.1);
		}
		if(isalive(self))
		{
			self clientfield::set("fan_trap_blood_fx", 0);
			self.var_1adc13ad = undefined;
		}
		else
		{
			level notify(#"hash_528d7b7f7d6c51a1", {#e_player:t_damage.activated_by_player});
			if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
			{
				t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
				t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
			}
		}
	}
}

/*
	Name: function_1395e596
	Namespace: namespace_652c3ad8
	Checksum: 0xF39B18C
	Offset: 0x15D0
	Size: 0x12E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1395e596()
{
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	playsoundatposition(#"zmb_death_gibs", self.origin);
	if(math::cointoss())
	{
		if(!gibserverutils::isgibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
			return;
		}
	}
	if(math::cointoss())
	{
		if(!gibserverutils::isgibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
			return;
		}
	}
	if(math::cointoss())
	{
		gibserverutils::gibrightleg(self);
		return;
	}
	if(math::cointoss())
	{
		gibserverutils::gibleftleg(self);
		return;
	}
}

/*
	Name: fan_trap_timeout
	Namespace: namespace_652c3ad8
	Checksum: 0x665E175F
	Offset: 0x1708
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function fan_trap_timeout()
{
	self endon(#"hash_2133afbbd7534561");
	n_duration = 0;
	while(n_duration < 25)
	{
		wait(0.05);
		n_duration = n_duration + 0.05;
	}
	self notify(#"hash_2133afbbd7534561");
}

/*
	Name: fan_trap_rumble_think
	Namespace: namespace_652c3ad8
	Checksum: 0xA5587E71
	Offset: 0x1778
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function fan_trap_rumble_think()
{
	self endon(#"hash_2133afbbd7534561");
	while(true)
	{
		s_result = undefined;
		s_result = self.t_rumble waittill(#"trigger");
		if(isplayer(s_result.activator))
		{
			if(!(isdefined(s_result.activator.fan_trap_rumble) && s_result.activator.fan_trap_rumble))
			{
				self thread fan_trap_rumble(s_result.activator);
			}
		}
	}
}

/*
	Name: fan_trap_rumble
	Namespace: namespace_652c3ad8
	Checksum: 0xB9C57ABF
	Offset: 0x1838
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function fan_trap_rumble(e_player)
{
	e_player endon(#"death", #"disconnect");
	self endon(#"hash_2133afbbd7534561");
	while(true)
	{
		if(e_player istouching(self.t_rumble))
		{
			e_player clientfield::set_to_player("rumble_fan_trap", 1);
			e_player.fan_trap_rumble = 1;
			wait(0.25);
		}
		else
		{
			e_player clientfield::set_to_player("rumble_fan_trap", 0);
			e_player.fan_trap_rumble = 0;
			break;
		}
	}
}

/*
	Name: fan_trap_damage
	Namespace: namespace_652c3ad8
	Checksum: 0xBCC6947A
	Offset: 0x1920
	Size: 0x158
	Parameters: 0
	Flags: None
*/
function fan_trap_damage()
{
	if(isdefined(level.custom_fan_trap_damage_func))
	{
		self thread [[level.custom_fan_trap_damage_func]]();
		return;
	}
	self endon(#"fan_trap_finished");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator))
		{
			s_result.activator thread player_fan_trap_damage();
		}
		else
		{
			if(isdefined(s_result.activator.is_brutus) && s_result.activator.is_brutus)
			{
				self notify(#"hash_2133afbbd7534561");
				return;
			}
			if(isdefined(self.var_238b3806) && self.var_238b3806)
			{
				return;
			}
			if(!isdefined(s_result.activator.marked_for_death))
			{
				s_result.activator.marked_for_death = 1;
				s_result.activator thread zombie_fan_trap_death();
			}
		}
	}
}

/*
	Name: player_fan_trap_damage
	Namespace: namespace_652c3ad8
	Checksum: 0x4A849144
	Offset: 0x1A80
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function player_fan_trap_damage()
{
	self endon(#"death");
	if(zm_utility::is_standard())
	{
		self dodamage(25, self.origin);
	}
	else
	{
		if(!self hasperk(#"specialty_armorvest") || (self.health - 100) < 1)
		{
			radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
		}
		else
		{
			self dodamage(50, self.origin);
		}
	}
}

/*
	Name: zombie_fan_trap_death
	Namespace: namespace_652c3ad8
	Checksum: 0x669E1A22
	Offset: 0x1B78
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function zombie_fan_trap_death()
{
	self endon(#"death");
	self clientfield::set("fan_trap_blood_fx", 1);
	if(!(isdefined(self.is_brutus) && self.is_brutus))
	{
		self zombie_utility::gib_random_parts();
	}
	self thread stop_fan_trap_blood_fx();
	self dodamage(self.health + 1000, self.origin);
}

/*
	Name: stop_fan_trap_blood_fx
	Namespace: namespace_652c3ad8
	Checksum: 0xA4C83E5
	Offset: 0x1C30
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function stop_fan_trap_blood_fx()
{
	wait(2);
	if(isdefined(self))
	{
		self clientfield::set("fan_trap_blood_fx", 0);
	}
}

/*
	Name: function_8aeee6b8
	Namespace: namespace_652c3ad8
	Checksum: 0xBD4CD294
	Offset: 0x1C70
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_8aeee6b8()
{
	level flag::wait_till_any(array("activate_cafeteria", "activate_infirmary"));
	level flag::set("acid_trap_available");
}

/*
	Name: init_acid_trap_trigs
	Namespace: namespace_652c3ad8
	Checksum: 0xD12FB3E9
	Offset: 0x1CD0
	Size: 0x4C4
	Parameters: 0
	Flags: Linked
*/
function init_acid_trap_trigs()
{
	var_5c2bef3d = getentarray("zm_acid_trap", "script_noteworthy");
	foreach(var_4d42c97f in var_5c2bef3d)
	{
		var_4d42c97f._trap_cooldown_time = 25;
		var_4d42c97f.var_28ea1870 = [];
		var_4d42c97f.var_cd6ebde4 = [];
		var_4d42c97f.var_31004a80 = [];
		var_8541c382 = getentarray(var_4d42c97f.target, "targetname");
		for(i = 0; i < var_8541c382.size; i++)
		{
			if(isdefined(var_8541c382[i].script_string))
			{
				if(var_8541c382[i].script_string == "trap_control_panel")
				{
					if(!isdefined(var_4d42c97f.var_cd6ebde4))
					{
						var_4d42c97f.var_cd6ebde4 = [];
					}
					else if(!isarray(var_4d42c97f.var_cd6ebde4))
					{
						var_4d42c97f.var_cd6ebde4 = array(var_4d42c97f.var_cd6ebde4);
					}
					if(!isinarray(var_4d42c97f.var_cd6ebde4, var_8541c382[i]))
					{
						var_4d42c97f.var_cd6ebde4[var_4d42c97f.var_cd6ebde4.size] = var_8541c382[i];
					}
				}
			}
		}
		var_1f88db8a = struct::get_array(var_4d42c97f.target, "targetname");
		for(i = 0; i < var_1f88db8a.size; i++)
		{
			if(isdefined(var_1f88db8a[i].script_string))
			{
				if(var_1f88db8a[i].script_string == "acid_trap_fx")
				{
					if(!isdefined(var_4d42c97f.var_28ea1870))
					{
						var_4d42c97f.var_28ea1870 = [];
					}
					else if(!isarray(var_4d42c97f.var_28ea1870))
					{
						var_4d42c97f.var_28ea1870 = array(var_4d42c97f.var_28ea1870);
					}
					if(!isinarray(var_4d42c97f.var_28ea1870, var_1f88db8a[i]))
					{
						var_4d42c97f.var_28ea1870[var_4d42c97f.var_28ea1870.size] = var_1f88db8a[i];
					}
				}
			}
			if(isdefined(var_1f88db8a[i].script_noteworthy))
			{
				if(var_1f88db8a[i].script_noteworthy == "brutus_trap_finder")
				{
					if(!isdefined(var_4d42c97f.var_31004a80))
					{
						var_4d42c97f.var_31004a80 = [];
					}
					else if(!isarray(var_4d42c97f.var_31004a80))
					{
						var_4d42c97f.var_31004a80 = array(var_4d42c97f.var_31004a80);
					}
					if(!isinarray(var_4d42c97f.var_31004a80, var_1f88db8a[i]))
					{
						var_4d42c97f.var_31004a80[var_4d42c97f.var_31004a80.size] = var_1f88db8a[i];
					}
				}
			}
		}
	}
	zm_traps::register_trap_basic_info("zm_acid_trap", &activate_zm_acid_trap, &function_6219e5ab);
	zm_traps::register_trap_damage("zm_acid_trap", &function_efd61793, &function_9699194a);
	zm_traps::function_60d9e800("zm_acid_trap", &zapper_light_red, &zapper_light_green);
}

/*
	Name: function_39f2d90f
	Namespace: namespace_652c3ad8
	Checksum: 0xB2A57974
	Offset: 0x21A0
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_39f2d90f()
{
	level flag::wait_till("start_zombie_round_logic");
	self zapper_light_red();
	level flag::wait_till("acid_trap_available");
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"trap_activated");
		if(s_result.trap == self)
		{
			s_result.var_dd54ffdb zm_stats::increment_client_stat("prison_acid_trap_used", 0);
		}
	}
}

/*
	Name: activate_zm_acid_trap
	Namespace: namespace_652c3ad8
	Checksum: 0x193586E3
	Offset: 0x2278
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function activate_zm_acid_trap()
{
	level.trapped_track[#"acid"] = 1;
	for(i = 0; i < self.var_28ea1870.size; i++)
	{
		self.var_28ea1870[i] thread acid_trap_fx(self);
		waitframe(1);
	}
	self.in_use = 1;
	self thread zm_traps::trap_damage();
	self waittilltimeout(25, #"hash_2133afbbd7534561");
	self.in_use = undefined;
	self notify(#"trap_done");
	self waittill(#"available");
}

/*
	Name: function_6219e5ab
	Namespace: namespace_652c3ad8
	Checksum: 0xA26F2280
	Offset: 0x2360
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_6219e5ab(trap)
{
	playsoundatposition(#"hash_4b93c2d674807e60", self.origin);
	self waittill(#"available");
	playsoundatposition(#"zmb_acid_trap_available", self.origin);
}

/*
	Name: function_efd61793
	Namespace: namespace_652c3ad8
	Checksum: 0x8DC9FDD8
	Offset: 0x23E0
	Size: 0x1CE
	Parameters: 1
	Flags: Linked
*/
function function_efd61793(t_damage)
{
	self endon(#"death", #"disconnect");
	if(!(isdefined(self.is_in_acid) && self.is_in_acid) && !self laststand::player_is_in_laststand())
	{
		self.is_in_acid = 1;
		self thread function_1a5df584(t_damage);
		while(self istouching(t_damage) && (isdefined(t_damage.in_use) && t_damage.in_use) && !self laststand::player_is_in_laststand())
		{
			if(self.health <= 20)
			{
				self dodamage(self.health + 100, self.origin, undefined, t_damage);
			}
			else
			{
				if(zm_utility::is_standard())
				{
					self dodamage(self.maxhealth / 5.5, self.origin, undefined, t_damage);
				}
				else
				{
					self dodamage(self.maxhealth / 2.75, self.origin, undefined, t_damage);
				}
				self zm_audio::playerexert("cough");
			}
			wait(1);
		}
		self.is_in_acid = undefined;
	}
}

/*
	Name: function_9699194a
	Namespace: namespace_652c3ad8
	Checksum: 0x9F746EDB
	Offset: 0x25B8
	Size: 0x464
	Parameters: 1
	Flags: Linked
*/
function function_9699194a(t_damage)
{
	if(isdefined(level.custom_acid_trap_damage_func))
	{
		t_damage thread [[level.custom_acid_trap_damage_func]]();
		return;
	}
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"boss")
	{
	}
	else
	{
		if(isdefined(self.var_238b3806) && self.var_238b3806)
		{
			return;
		}
		if(isdefined(self.var_1adc13ad) && self.var_1adc13ad)
		{
			return;
		}
		self.var_1adc13ad = 1;
		if(level.round_number < 40)
		{
			self.marked_for_death = 1;
			self clientfield::set("acid_trap_death_fx", 1);
			level notify(#"hash_317f58ba0d580c27", {#e_player:t_damage.activated_by_player});
			wait(randomfloatrange(0.25, 2));
			if(isalive(self))
			{
				self zombie_utility::gib_random_parts();
				self thread stop_acid_death_fx();
				self.var_12745932 = 1;
				self dodamage(self.health + 1000, t_damage.origin, t_damage.activated_by_player, t_damage);
				if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
				{
					t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
					t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
				}
			}
		}
		else
		{
			self clientfield::set("acid_trap_death_fx", 1);
			while(isalive(self) && self istouching(t_damage) && (isdefined(t_damage.in_use) && t_damage.in_use))
			{
				self function_1395e596();
				self.var_143964f0 = self.var_12745932;
				self.var_12745932 = 1;
				self dodamage(self.maxhealth * 0.2, t_damage.origin, t_damage.activated_by_player, t_damage);
				wait(0.3);
			}
			if(isalive(self))
			{
				self clientfield::set("acid_trap_death_fx", 0);
				self.var_1adc13ad = undefined;
				self.var_12745932 = self.var_143964f0;
				self.var_143964f0 = undefined;
			}
			else
			{
				level notify(#"hash_317f58ba0d580c27", {#e_player:t_damage.activated_by_player});
				if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
				{
					t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
					t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
				}
			}
		}
	}
}

/*
	Name: acid_trap_fx
	Namespace: namespace_652c3ad8
	Checksum: 0xEFBBB124
	Offset: 0x2A28
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function acid_trap_fx(e_trap)
{
	mdl_fx = util::spawn_model("tag_origin", self.origin, self.angles);
	mdl_fx clientfield::set("acid_trap_fx", 1);
	e_trap waittilltimeout(25, #"hash_2133afbbd7534561");
	mdl_fx clientfield::set("acid_trap_fx", 0);
	waitframe(1);
	mdl_fx delete();
}

/*
	Name: stop_acid_death_fx
	Namespace: namespace_652c3ad8
	Checksum: 0xE5A00ED0
	Offset: 0x2AE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function stop_acid_death_fx()
{
	wait(2);
	if(isdefined(self))
	{
		self clientfield::set("acid_trap_death_fx", 0);
	}
}

/*
	Name: function_1a5df584
	Namespace: namespace_652c3ad8
	Checksum: 0xA6AF4529
	Offset: 0x2B20
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_1a5df584(t_damage)
{
	self endon(#"bled_out", #"disconnect");
	if(self clientfield::get_to_player("player_acid_trap_post_fx") === 1)
	{
		return;
	}
	self clientfield::set_to_player("player_acid_trap_post_fx", 1);
	while(self istouching(t_damage) && (isdefined(t_damage.in_use) && t_damage.in_use))
	{
		waitframe(1);
	}
	self clientfield::set_to_player("player_acid_trap_post_fx", 0);
}

/*
	Name: function_6dbbc97
	Namespace: namespace_652c3ad8
	Checksum: 0x9C8D51FB
	Offset: 0x2C08
	Size: 0x464
	Parameters: 0
	Flags: Linked
*/
function function_6dbbc97()
{
	var_e4f517f0 = getentarray("zm_spinning_trap", "script_noteworthy");
	foreach(var_fe861167 in var_e4f517f0)
	{
		var_fe861167._trap_cooldown_time = 25;
		a_e_targets = getentarray(var_fe861167.target, "targetname");
		var_fe861167.var_cd6ebde4 = [];
		var_fe861167.var_31004a80 = [];
		for(i = 0; i < a_e_targets.size; i++)
		{
			if(isdefined(a_e_targets[i].script_string))
			{
				if(a_e_targets[i].script_string == "spinning_trap_rumble")
				{
					var_fe861167.t_rumble = a_e_targets[i];
					continue;
				}
				if(a_e_targets[i].script_string == "fxanim_spinning_trap")
				{
					var_fe861167.var_db919ceb = a_e_targets[i];
					continue;
				}
				if(a_e_targets[i].script_string == "trap_control_panel")
				{
					if(!isdefined(var_fe861167.var_cd6ebde4))
					{
						var_fe861167.var_cd6ebde4 = [];
					}
					else if(!isarray(var_fe861167.var_cd6ebde4))
					{
						var_fe861167.var_cd6ebde4 = array(var_fe861167.var_cd6ebde4);
					}
					if(!isinarray(var_fe861167.var_cd6ebde4, a_e_targets[i]))
					{
						var_fe861167.var_cd6ebde4[var_fe861167.var_cd6ebde4.size] = a_e_targets[i];
					}
				}
			}
		}
		var_1f88db8a = struct::get_array(var_fe861167.target);
		for(i = 0; i < var_1f88db8a.size; i++)
		{
			if(isdefined(var_1f88db8a[i].script_noteworthy))
			{
				if(var_1f88db8a[i].script_noteworthy == "brutus_trap_finder")
				{
					if(!isdefined(var_fe861167.var_31004a80))
					{
						var_fe861167.var_31004a80 = [];
					}
					else if(!isarray(var_fe861167.var_31004a80))
					{
						var_fe861167.var_31004a80 = array(var_fe861167.var_31004a80);
					}
					if(!isinarray(var_fe861167.var_31004a80, var_1f88db8a[i]))
					{
						var_fe861167.var_31004a80[var_fe861167.var_31004a80.size] = var_1f88db8a[i];
					}
				}
			}
		}
		var_fe861167.var_db919ceb thread scene::play(#"p8_fxanim_zm_esc_trap_spinning_bundle", var_fe861167.var_db919ceb);
	}
	zm_traps::register_trap_basic_info("zm_spinning_trap", &activate_zm_spinning_trap, &function_ffe09b75);
	zm_traps::register_trap_damage("zm_spinning_trap", &function_7e74aa5, &function_1f7e661f);
	zm_traps::function_60d9e800("zm_spinning_trap", &zapper_light_red, &zapper_light_green);
}

/*
	Name: function_dcd775a
	Namespace: namespace_652c3ad8
	Checksum: 0xE5646260
	Offset: 0x3078
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_dcd775a()
{
	level flag::wait_till("start_zombie_round_logic");
	self zapper_light_red();
	if(isdefined(self.script_int))
	{
		level flag::wait_till("power_on" + self.script_int);
	}
	else
	{
		level flag::wait_till("power_on");
	}
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"trap_activated");
		if(s_result.trap == self)
		{
			s_result.var_dd54ffdb zm_stats::increment_client_stat("prison_spinning_trap_used", 0);
		}
	}
}

/*
	Name: activate_zm_spinning_trap
	Namespace: namespace_652c3ad8
	Checksum: 0x31DF396A
	Offset: 0x3188
	Size: 0x222
	Parameters: 0
	Flags: Linked
*/
function activate_zm_spinning_trap()
{
	level.trapped_track[#"fan"] = 1;
	self.in_use = 1;
	self.var_db919ceb thread scene::init(#"p8_fxanim_zm_esc_trap_spinning_bundle", self.var_db919ceb);
	var_a5fa009d = struct::get("spinning_trap_poi", "targetname");
	self thread function_61791b8b(var_a5fa009d);
	self thread function_4a15e725();
	self thread function_c3ac9950();
	wait(1.2);
	self thread zm_traps::trap_damage();
	self waittill(#"hash_2133afbbd7534561");
	self.in_use = undefined;
	self.var_db919ceb thread scene::play(#"p8_fxanim_zm_esc_trap_spinning_bundle", self.var_db919ceb);
	a_players = getplayers();
	foreach(e_player in a_players)
	{
		if(isdefined(e_player.b_spinning_trap_rumble) && e_player.b_spinning_trap_rumble)
		{
			e_player clientfield::set_to_player("rumble_spinning_trap", 0);
			e_player.b_spinning_trap_rumble = undefined;
		}
	}
	self notify(#"trap_done");
	self waittill(#"available");
}

/*
	Name: function_ffe09b75
	Namespace: namespace_652c3ad8
	Checksum: 0xBA0CD16F
	Offset: 0x33B8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_ffe09b75()
{
	self playsound(#"zmb_trap_activate");
}

/*
	Name: function_7e74aa5
	Namespace: namespace_652c3ad8
	Checksum: 0x75FF7FDA
	Offset: 0x33E8
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_7e74aa5(t_damage)
{
	self endon(#"death", #"disconnect");
	if(zm_utility::is_standard())
	{
		self dodamage(5, self.origin, undefined, t_damage);
	}
	else
	{
		if(!self hasperk(#"specialty_armorvest") || (self.health - 100) < 1)
		{
			radiusdamage(self.origin, 10, self.health + 100, self.health + 100, t_damage);
		}
		else
		{
			self dodamage(50, self.origin, undefined, t_damage);
		}
	}
}

/*
	Name: function_1f7e661f
	Namespace: namespace_652c3ad8
	Checksum: 0x3C333D34
	Offset: 0x3500
	Size: 0x886
	Parameters: 1
	Flags: Linked
*/
function function_1f7e661f(t_damage)
{
	if(isdefined(level.var_d36e5ece))
	{
		self thread [[level.var_d36e5ece]](t_damage);
		return;
	}
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"boss")
	{
		t_damage notify(#"hash_2133afbbd7534561");
		return;
	}
	if(isdefined(self.var_238b3806) && self.var_238b3806 || (isdefined(self.var_bd4627e1) && self.var_bd4627e1))
	{
		return;
	}
	if(isdefined(self.var_1adc13ad) && self.var_1adc13ad)
	{
		return;
	}
	self.var_1adc13ad = 1;
	if(isai(self) && !isvehicle(self))
	{
		self clientfield::set("spinning_trap_blood_fx", 1);
	}
	self playsound(#"hash_42c6cc2204b7fbbd");
	v_hook = t_damage.var_db919ceb gettagorigin("tag_weapon_3");
	n_dist = distance2d(self.origin, v_hook);
	if(!(isdefined(t_damage.var_705682df) && t_damage.var_705682df) && self.var_6f84b820 === #"basic" && n_dist <= 128 && self.team != #"allies")
	{
		t_damage.var_705682df = 1;
		self.var_bd4627e1 = 1;
		self clientfield::set("spinning_trap_eye_fx", 1);
		var_e72c9959 = util::spawn_model("tag_origin", t_damage.var_db919ceb gettagorigin("tag_weapon_3"), t_damage.var_db919ceb gettagangles("tag_weapon_3"));
		var_e72c9959 linkto(t_damage.var_db919ceb, "tag_weapon_3");
		self thread function_864365ef(t_damage, var_e72c9959);
		a_e_players = util::get_array_of_closest(self.origin, getplayers());
		if(isdefined(a_e_players[0]) && distance2dsquared(a_e_players[0].origin, self.origin) < (400 * 400))
		{
			a_e_players[0] zm_audio::create_and_play_dialog(#"hash_2c3c478eed0f3b99", #"hook", undefined, 1);
		}
	}
	else
	{
		if(isai(self) && !isvehicle(self))
		{
			self thread function_572d630b();
		}
		if(self.var_6f84b820 === #"basic" && !isvehicle(self))
		{
			str_tag = t_damage.var_db919ceb get_closest_tag(self.origin);
			if(str_tag === "tag_weapon_1")
			{
				self zombie_utility::makezombiecrawler(1);
			}
			else
			{
				if(str_tag === "tag_weapon_4")
				{
					gibserverutils::gibhead(self);
				}
				else
				{
					if(str_tag === "tag_weapon_3" && randomint(100) < 75)
					{
						gibserverutils::annihilate(self);
					}
					else
					{
						n_lift_height = randomintrange(8, 64);
						v_away_from_source = vectornormalize(self.origin - t_damage.origin);
						v_away_from_source = v_away_from_source * 128;
						v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
						a_trace = physicstraceex(self.origin + vectorscale((0, 0, 1), 32), self.origin + v_away_from_source, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), self);
						self setplayercollision(0);
						self startragdoll();
						self launchragdoll((150 * anglestoup(self.angles)) + (v_away_from_source[0], v_away_from_source[1], 0));
					}
				}
			}
			level notify(#"hash_148b3ce521088846", {#e_player:t_damage.activated_by_player});
			self dodamage(self.health + 1000, self.origin, undefined, t_damage);
			if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
			{
				t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
				t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
			}
		}
		else
		{
			if(self.var_6f84b820 === #"popcorn")
			{
				level notify(#"hash_148b3ce521088846", {#e_player:t_damage.activated_by_player});
				self dodamage(self.health + 1000, self.origin, undefined, t_damage);
				if(isdefined(t_damage.activated_by_player) && isplayer(t_damage.activated_by_player))
				{
					t_damage.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
					t_damage.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
				}
			}
			else
			{
				self dodamage(self.maxhealth * 0.2, self.origin, undefined, t_damage);
				wait(0.25);
				if(isdefined(self))
				{
					self.var_1adc13ad = undefined;
				}
			}
		}
	}
}

/*
	Name: get_closest_tag
	Namespace: namespace_652c3ad8
	Checksum: 0x7E4BAA89
	Offset: 0x3D90
	Size: 0xFA
	Parameters: 1
	Flags: Linked, Private
*/
function private get_closest_tag(v_pos)
{
	if(!isdefined(self.var_e60684da))
	{
		self function_c846fd12();
	}
	var_59add9df = undefined;
	for(i = 0; i < self.var_e60684da.size; i++)
	{
		if(!isdefined(var_59add9df))
		{
			var_59add9df = self.var_e60684da[i];
			continue;
		}
		if(distance2dsquared(v_pos, self gettagorigin(self.var_e60684da[i])) < distance2dsquared(v_pos, self gettagorigin(var_59add9df)))
		{
			var_59add9df = self.var_e60684da[i];
		}
	}
	return tolower(var_59add9df);
}

/*
	Name: function_c846fd12
	Namespace: namespace_652c3ad8
	Checksum: 0x7334F5B9
	Offset: 0x3E98
	Size: 0x72
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c846fd12()
{
	tags = [];
	tags[tags.size] = "tag_weapon_1";
	tags[tags.size] = "tag_weapon_2";
	tags[tags.size] = "tag_weapon_3";
	tags[tags.size] = "tag_weapon_4";
	self.var_e60684da = tags;
}

/*
	Name: function_4a15e725
	Namespace: namespace_652c3ad8
	Checksum: 0x25FF08F0
	Offset: 0x3F18
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_4a15e725()
{
	self endon(#"hash_2133afbbd7534561");
	n_duration = 0;
	while(n_duration < 25)
	{
		wait(0.05);
		n_duration = n_duration + 0.05;
	}
	self notify(#"hash_2133afbbd7534561");
}

/*
	Name: function_c3ac9950
	Namespace: namespace_652c3ad8
	Checksum: 0x23B49756
	Offset: 0x3F88
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_c3ac9950()
{
	self endon(#"hash_2133afbbd7534561");
	while(true)
	{
		s_result = undefined;
		s_result = self.t_rumble waittill(#"trigger");
		if(isplayer(s_result.activator))
		{
			if(!(isdefined(s_result.activator.b_spinning_trap_rumble) && s_result.activator.b_spinning_trap_rumble))
			{
				self thread spinning_trap_rumble(s_result.activator);
			}
		}
	}
}

/*
	Name: spinning_trap_rumble
	Namespace: namespace_652c3ad8
	Checksum: 0x102E9F16
	Offset: 0x4048
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function spinning_trap_rumble(e_player)
{
	e_player endon(#"death", #"disconnect");
	self endon(#"hash_2133afbbd7534561");
	while(true)
	{
		if(e_player istouching(self.t_rumble))
		{
			e_player clientfield::set_to_player("rumble_spinning_trap", 1);
			e_player.b_spinning_trap_rumble = 1;
			wait(0.25);
		}
		else
		{
			e_player clientfield::set_to_player("rumble_spinning_trap", 0);
			e_player.b_spinning_trap_rumble = undefined;
			break;
		}
	}
}

/*
	Name: function_572d630b
	Namespace: namespace_652c3ad8
	Checksum: 0x44F41834
	Offset: 0x4128
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
	Name: function_864365ef
	Namespace: namespace_652c3ad8
	Checksum: 0x75A5EBF0
	Offset: 0x4168
	Size: 0x2A6
	Parameters: 2
	Flags: Linked
*/
function function_864365ef(t_damage, var_e72c9959)
{
	self val::set("spinning_trap", "ignoreall", 1);
	self val::set("spinning_trap", "allowdeath", 0);
	self.b_ignore_cleanup = 1;
	self.health = 1;
	self notsolid();
	self setteam(util::get_enemy_team(self.team));
	self zombie_utility::makezombiecrawler(1);
	var_e72c9959 thread scene::init(#"hash_6a81729051de85ac", self);
	playsoundatposition(#"hash_42c6cc2204b7fbbd", self.origin);
	t_damage waittill(#"hash_2133afbbd7534561");
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
	t_damage.var_705682df = undefined;
}

/*
	Name: function_61791b8b
	Namespace: namespace_652c3ad8
	Checksum: 0xAABF4496
	Offset: 0x4418
	Size: 0x214
	Parameters: 1
	Flags: Linked, Private
*/
function private function_61791b8b(s_pos = self)
{
	v_point = getclosestpointonnavmesh(s_pos.origin, 128, 16);
	if(!isdefined(v_point))
	{
		return;
	}
	var_dd239d21 = spawn("script_origin", v_point);
	if(!(isdefined(var_dd239d21 zm_utility::in_playable_area()) && var_dd239d21 zm_utility::in_playable_area()))
	{
		var_dd239d21 delete();
		return;
	}
	var_dd239d21 zm_utility::create_zombie_point_of_interest(300, 4, 10000);
	var_dd239d21 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 90);
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(ai_zombie.var_6f84b820 == #"miniboss" || ai_zombie.var_6f84b820 == #"boss")
		{
			ai_zombie thread zm_utility::add_poi_to_ignore_list(var_dd239d21);
		}
	}
	self waittill(#"hash_2133afbbd7534561");
	var_dd239d21 delete();
}

/*
	Name: function_e3f8ed75
	Namespace: namespace_652c3ad8
	Checksum: 0xFCC27986
	Offset: 0x4638
	Size: 0x23C
	Parameters: 0
	Flags: None
*/
function function_e3f8ed75()
{
	self.var_cd6ebde4 = [];
	self.var_e7bb2f7b = [];
	foreach(var_d8a375cc in self.var_5ecb27b7)
	{
		var_c2a3bbf = getentarray(var_d8a375cc.target, "targetname");
		for(i = 0; i < var_c2a3bbf.size; i++)
		{
			if(var_c2a3bbf[i].script_string === "trap_handle")
			{
				if(!isdefined(self.var_e7bb2f7b))
				{
					self.var_e7bb2f7b = [];
				}
				else if(!isarray(self.var_e7bb2f7b))
				{
					self.var_e7bb2f7b = array(self.var_e7bb2f7b);
				}
				if(!isinarray(self.var_e7bb2f7b, var_c2a3bbf[i]))
				{
					self.var_e7bb2f7b[self.var_e7bb2f7b.size] = var_c2a3bbf[i];
				}
				continue;
			}
			if(var_c2a3bbf[i].script_string === "trap_control_panel")
			{
				if(!isdefined(self.var_cd6ebde4))
				{
					self.var_cd6ebde4 = [];
				}
				else if(!isarray(self.var_cd6ebde4))
				{
					self.var_cd6ebde4 = array(self.var_cd6ebde4);
				}
				if(!isinarray(self.var_cd6ebde4, var_c2a3bbf[i]))
				{
					self.var_cd6ebde4[self.var_cd6ebde4.size] = var_c2a3bbf[i];
				}
			}
		}
	}
}

/*
	Name: zapper_light_red
	Namespace: namespace_652c3ad8
	Checksum: 0xA1F389E3
	Offset: 0x4880
	Size: 0x1CA
	Parameters: 0
	Flags: Linked
*/
function zapper_light_red()
{
	for(i = 0; i < self.var_cd6ebde4.size; i++)
	{
		self.var_cd6ebde4[i] setmodel(#"hash_aaeab9b07f785d9");
		self.var_cd6ebde4[i] playsound(#"hash_6c4aadc21a173f8b");
		self.var_cd6ebde4[i] playsound(#"hash_6c4cdf83585f2851");
	}
	level flag::wait_till("start_zombie_round_logic");
	switch(self.script_noteworthy)
	{
		case "zm_spinning_trap":
		{
			exploder::exploder("fxexp_spinning_trap_light_red");
			exploder::kill_exploder("fxexp_spinning_trap_light_green");
			break;
		}
		case "zm_fan_trap":
		{
			exploder::exploder("fxexp_fan_trap_light_red");
			exploder::kill_exploder("fxexp_fan_trap_light_green");
			break;
		}
		case "zm_acid_trap":
		{
			exploder::exploder("fxexp_acid_trap_light_red");
			exploder::kill_exploder("fxexp_acid_trap_light_green");
			break;
		}
	}
}

/*
	Name: zapper_light_green
	Namespace: namespace_652c3ad8
	Checksum: 0xBF143938
	Offset: 0x4A58
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function zapper_light_green()
{
	for(i = 0; i < self.var_cd6ebde4.size; i++)
	{
		self.var_cd6ebde4[i] setmodel(#"p7_zm_mob_trap_control_base");
		self.var_cd6ebde4[i] playsound(#"hash_27343b1084481dcb");
		self.var_cd6ebde4[i] playsound(#"hash_57154349da449cd");
	}
	switch(self.script_noteworthy)
	{
		case "zm_spinning_trap":
		{
			exploder::kill_exploder("fxexp_spinning_trap_light_red");
			exploder::exploder("fxexp_spinning_trap_light_green");
			break;
		}
		case "zm_fan_trap":
		{
			exploder::kill_exploder("fxexp_fan_trap_light_red");
			exploder::exploder("fxexp_fan_trap_light_green");
			break;
		}
		case "zm_acid_trap":
		{
			exploder::kill_exploder("fxexp_acid_trap_light_red");
			exploder::exploder("fxexp_acid_trap_light_green");
			break;
		}
	}
}

/*
	Name: function_80ac9e32
	Namespace: namespace_652c3ad8
	Checksum: 0xEC372C61
	Offset: 0x4C10
	Size: 0x188
	Parameters: 0
	Flags: None
*/
function function_80ac9e32()
{
	self zapper_light_red();
	foreach(var_fe043be4 in self.var_e7bb2f7b)
	{
		var_fe043be4 rotatepitch(-180, 0.5);
		var_fe043be4 playsound(#"amb_sparks_l_b");
	}
	wait(0.5);
	self notify(#"switch_activated");
	self waittill(#"available");
	self zapper_light_green();
	foreach(var_fe043be4 in self.var_e7bb2f7b)
	{
		var_fe043be4 rotatepitch(180, 0.5);
	}
}

