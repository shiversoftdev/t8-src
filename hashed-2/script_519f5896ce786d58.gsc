// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_776ab8d4;

/*
	Name: function_89f2df9
	Namespace: namespace_776ab8d4
	Checksum: 0xB04072D9
	Offset: 0x1C8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5303b5bf03fb20bc", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_776ab8d4
	Checksum: 0x80F724D1
	Offset: 0x218
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_776ab8d4
	Checksum: 0x9237D419
	Offset: 0x228
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		level thread function_716f2019();
	}
	else
	{
		e_clip = getent("ww_case_clip", "targetname");
		if(isdefined(e_clip))
		{
			e_clip delete();
		}
	}
}

/*
	Name: function_716f2019
	Namespace: namespace_776ab8d4
	Checksum: 0x38523E2E
	Offset: 0x2C0
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_716f2019()
{
	level flag::wait_till_any(array(#"power_on1", #"hash_2daf5bdda85cc660"));
	level flag::init(#"hash_7305c7f343dd8850");
	level flag::init(#"hash_51efb8481233c40d");
	level flag::init(#"hash_727b0a70b6f41db2");
	level flag::init(#"hash_6c453062178e1617");
	level flag::init(#"hash_4c1f880bcc6be2d0");
	level flag::init(#"hash_65224b2f37fb9446");
	level.var_44cff72 = struct::get("s_wonder_weapon_loc", "targetname");
	level.var_44cff72 zm_unitrigger::create(&function_7706457d, 46, &function_7310e1e0);
	level thread function_5d870c2c();
	level thread function_2325482e();
	function_688bcac2();
	array::thread_all(level.var_79f3b34b, &function_8bb2971c);
	level thread function_8476e19();
	zm_weapons::function_603af7a8(level.var_f086136b);
}

/*
	Name: function_5d870c2c
	Namespace: namespace_776ab8d4
	Checksum: 0xF9A31FD
	Offset: 0x4C8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_5d870c2c()
{
	scene::add_scene_func(#"hash_397b4423676a9894", &function_20d38ac0, "init");
	scene::init(#"hash_397b4423676a9894");
}

/*
	Name: function_20d38ac0
	Namespace: namespace_776ab8d4
	Checksum: 0xFCA42825
	Offset: 0x530
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_20d38ac0(a_ents)
{
	var_955a6e11 = a_ents[#"hash_7aff0ee60ddd937b"];
	if(isdefined(var_955a6e11))
	{
		var_955a6e11 function_53e45f4e();
	}
}

/*
	Name: function_53e45f4e
	Namespace: namespace_776ab8d4
	Checksum: 0x26CD0CBE
	Offset: 0x588
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_53e45f4e()
{
	level endon(#"hash_767a32d351763f32");
	self endon(#"death");
	var_8618ad82 = 1250 * 1250;
	while(true)
	{
		foreach(e_player in getplayers())
		{
			if(distance2dsquared(e_player.origin, self.origin) <= var_8618ad82)
			{
				b_in_range = 1;
				break;
			}
		}
		if(isdefined(b_in_range) && b_in_range && (!(isdefined(self clientfield::get("" + #"hash_17b6a8253206a3cf")) && self clientfield::get("" + #"hash_17b6a8253206a3cf"))))
		{
			self clientfield::set("" + #"hash_17b6a8253206a3cf", 1);
		}
		else if(!isdefined(b_in_range) && (isdefined(self clientfield::get("" + #"hash_17b6a8253206a3cf")) && self clientfield::get("" + #"hash_17b6a8253206a3cf")))
		{
			self clientfield::set("" + #"hash_17b6a8253206a3cf", 0);
		}
		b_in_range = undefined;
		wait(2);
	}
}

/*
	Name: function_688bcac2
	Namespace: namespace_776ab8d4
	Checksum: 0xA2084780
	Offset: 0x7D8
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function function_688bcac2()
{
	var_db1edf58 = struct::get_array("ww_case_lock");
	foreach(var_183d2001 in var_db1edf58)
	{
		var_f67ecd64 = util::spawn_model(var_183d2001.model, var_183d2001.origin, var_183d2001.angles);
		var_f67ecd64.script_int = var_183d2001.script_int;
		if(!isdefined(level.var_79f3b34b))
		{
			level.var_79f3b34b = [];
		}
		else if(!isarray(level.var_79f3b34b))
		{
			level.var_79f3b34b = array(level.var_79f3b34b);
		}
		level.var_79f3b34b[level.var_79f3b34b.size] = var_f67ecd64;
	}
}

/*
	Name: function_7706457d
	Namespace: namespace_776ab8d4
	Checksum: 0xF0FAAA95
	Offset: 0x940
	Size: 0x208
	Parameters: 1
	Flags: Linked
*/
function function_7706457d(e_player)
{
	if(!level flag::get(#"hash_4c1f880bcc6be2d0"))
	{
		foreach(var_82e1ca26 in level.var_79f3b34b)
		{
			if(zombie_utility::is_player_valid(e_player) && e_player function_8b4cc6ae(var_82e1ca26.origin, 10, 1, var_82e1ca26))
			{
				str_prompt = zm_utility::function_d6046228(#"hash_170f427c6f774cc6", #"hash_182213d7353c3062");
				self sethintstringforplayer(e_player, str_prompt);
				return 1;
			}
		}
		if(zombie_utility::is_player_valid(e_player) && e_player function_8b4cc6ae(level.var_44cff72.origin, 50, 0))
		{
			str_prompt = zm_utility::function_d6046228(#"hash_74088228890cabc3", #"hash_4428bea407adb029");
			self sethintstringforplayer(e_player, str_prompt);
			return 1;
		}
	}
	self sethintstringforplayer(e_player, "");
	return 1;
}

/*
	Name: function_7310e1e0
	Namespace: namespace_776ab8d4
	Checksum: 0x8F5C2DF7
	Offset: 0xB50
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_7310e1e0()
{
	level endon(#"hash_767a32d351763f32");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!level flag::get(#"hash_4c1f880bcc6be2d0"))
		{
			foreach(var_82e1ca26 in level.var_79f3b34b)
			{
				if(zombie_utility::is_player_valid(e_player) && e_player function_8b4cc6ae(var_82e1ca26.origin, 10, 1, var_82e1ca26) && (!(isdefined(self.var_86dbb82b) && self.var_86dbb82b)))
				{
					var_82e1ca26 function_f4ae6e44();
					break;
				}
			}
			if(zombie_utility::is_player_valid(e_player) && e_player function_8b4cc6ae(level.var_44cff72.origin, 50, 0))
			{
				level notify(#"hash_7ed0b257f8849c85");
			}
		}
	}
}

/*
	Name: function_f4ae6e44
	Namespace: namespace_776ab8d4
	Checksum: 0xC6F046DE
	Offset: 0xD28
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_f4ae6e44()
{
	self endon(#"death", #"destroyed");
	self.var_86dbb82b = 1;
	self rotateroll(-90, 0.5);
	self playsound(#"hash_1902d49433a38eba");
	self notify(#"hash_17ed60240cc5b0a8");
	self waittill(#"rotatedone");
	self playsound(#"hash_41879bbde78fcc85");
	self.var_86dbb82b = 0;
}

/*
	Name: function_8b4cc6ae
	Namespace: namespace_776ab8d4
	Checksum: 0xC48F6E2
	Offset: 0xDF8
	Size: 0xAA
	Parameters: 4
	Flags: Linked
*/
function function_8b4cc6ae(origin, arc_angle_degrees = 90, do_trace, e_ignore)
{
	arc_angle_degrees = absangleclamp360(arc_angle_degrees);
	dot = cos(arc_angle_degrees * 0.5);
	if(self util::is_player_looking_at(origin, dot, do_trace, e_ignore))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_2325482e
	Namespace: namespace_776ab8d4
	Checksum: 0x958D9AAF
	Offset: 0xEB0
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_2325482e()
{
	mdl_weapon = util::spawn_model(level.var_44cff72.model, level.var_44cff72.origin, level.var_44cff72.angles);
	var_cb31d9aa = getent("trigger_lookat_ww_case", "targetname");
	var_cb31d9aa thread function_7e7626b5();
	level flag::wait_till(#"hash_65224b2f37fb9446");
	level notify(#"hash_767a32d351763f32");
	if(isdefined(var_cb31d9aa))
	{
		var_cb31d9aa delete();
	}
	level thread zm_unitrigger::unregister_unitrigger(level.var_44cff72.s_unitrigger);
	scene::play(#"hash_397b4423676a9894");
	level.var_44cff72 zm_unitrigger::create(&function_9ffdf1be, 64, &function_f4f7650b);
	level flag::wait_till("ww_obtained");
	level thread zm_unitrigger::unregister_unitrigger(level.var_44cff72.s_unitrigger);
	mdl_weapon delete();
}

/*
	Name: function_7e7626b5
	Namespace: namespace_776ab8d4
	Checksum: 0xE204B7E4
	Offset: 0x1078
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_7e7626b5()
{
	self endon(#"death");
	level endon(#"hash_767a32d351763f32");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		player = var_be17187b.activator;
		if(zombie_utility::is_player_valid(player))
		{
			player thread namespace_891c9bac::function_a2bd5a0c(#"hash_28aa1fc068bb2e3b", 1);
			self delete();
		}
		wait(1);
	}
}

/*
	Name: function_9ffdf1be
	Namespace: namespace_776ab8d4
	Checksum: 0xAC6263F1
	Offset: 0x1148
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_9ffdf1be(e_player)
{
	if(!zm_utility::can_use(e_player, 1))
	{
		return 0;
	}
	if(e_player zm_weapons::has_weapon_or_upgrade(level.var_f086136b) || e_player zm_weapons::has_weapon_or_upgrade(level.var_6fe89212) || e_player zm_weapons::has_weapon_or_upgrade(level.var_7b9ca97a))
	{
		return 0;
	}
	self sethintstring(#"hash_660652361297f2ab");
	return 1;
}

/*
	Name: function_f4f7650b
	Namespace: namespace_776ab8d4
	Checksum: 0x8504BC93
	Offset: 0x1218
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_f4f7650b()
{
	level endon(#"ww_obtained");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player, 1))
		{
			e_player zm_weapons::weapon_give(level.var_f086136b);
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_74ba2bf90063e6c6", 1);
			level flag::set("ww_obtained");
		}
	}
}

/*
	Name: function_8bb2971c
	Namespace: namespace_776ab8d4
	Checksum: 0x6C99B0B
	Offset: 0x1300
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_8bb2971c()
{
	level endon(#"hash_767a32d351763f32");
	switch(self.script_int)
	{
		case 0:
		{
			var_1e30344b = #"hash_7305c7f343dd8850";
			break;
		}
		case 1:
		{
			var_1e30344b = #"hash_51efb8481233c40d";
			break;
		}
		case 2:
		{
			var_1e30344b = #"hash_727b0a70b6f41db2";
			break;
		}
		case 3:
		{
			var_1e30344b = #"hash_6c453062178e1617";
			break;
		}
	}
	var_50b185d1 = array(0, 1, 2, 3);
	var_210bfd21 = array::random(var_50b185d1);
	arrayremovevalue(var_50b185d1, var_210bfd21);
	self.var_210bfd21 = var_210bfd21;
	self thread function_175e4696(var_1e30344b);
	self thread function_4e833729();
	var_3aadd17 = array::random(var_50b185d1);
	self thread function_229f868f(var_3aadd17);
}

/*
	Name: function_229f868f
	Namespace: namespace_776ab8d4
	Checksum: 0xE522FCF1
	Offset: 0x14C0
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function function_229f868f(var_3aadd17)
{
	for(i = 0; i < var_3aadd17; i++)
	{
		self notify(#"hash_17ed60240cc5b0a8");
		self playsound(#"hash_559df0c493fb2378");
		self rotateroll(-90, 0.5);
		self waittill(#"rotatedone");
		self stopsound(#"hash_559df0c493fb2378");
		self playsound(#"hash_1a44db892b73701b");
	}
	level notify("ww_lock_scrambled_" + self.script_int);
}

/*
	Name: function_175e4696
	Namespace: namespace_776ab8d4
	Checksum: 0x486CA92B
	Offset: 0x15B8
	Size: 0x120
	Parameters: 1
	Flags: Linked
*/
function function_175e4696(var_1e30344b)
{
	level endon(#"hash_767a32d351763f32");
	self.n_rotation = 0;
	while(true)
	{
		self waittill(#"hash_17ed60240cc5b0a8");
		self.n_rotation = self.n_rotation + 1;
		if(self.n_rotation == 4)
		{
			self.n_rotation = 0;
		}
		if(self.n_rotation == self.var_210bfd21 && !level flag::get(var_1e30344b))
		{
			level flag::set(var_1e30344b);
		}
		else if(self.n_rotation != self.var_210bfd21 && level flag::get(var_1e30344b))
		{
			level flag::clear(var_1e30344b);
		}
	}
}

/*
	Name: function_8476e19
	Namespace: namespace_776ab8d4
	Checksum: 0x7B0878E4
	Offset: 0x16E0
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function function_8476e19()
{
	level endon(#"hash_767a32d351763f32");
	while(true)
	{
		level waittill(#"hash_7ed0b257f8849c85");
		level flag::set(#"hash_4c1f880bcc6be2d0");
		if(flag::get_all(array(#"hash_7305c7f343dd8850", #"hash_51efb8481233c40d", #"hash_727b0a70b6f41db2", #"hash_6c453062178e1617")))
		{
			level flag::set(#"hash_65224b2f37fb9446");
		}
		else
		{
			foreach(var_82e1ca26 in level.var_79f3b34b)
			{
				var_82e1ca26 thread function_229f868f(function_21a3a673(1, 4));
			}
			level util::waittill_multiple("ww_lock_scrambled_0", "ww_lock_scrambled_1", "ww_lock_scrambled_2", "ww_lock_scrambled_3");
			level flag::clear(#"hash_4c1f880bcc6be2d0");
		}
	}
}

/*
	Name: function_4e833729
	Namespace: namespace_776ab8d4
	Checksum: 0x11C8218F
	Offset: 0x18B0
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_4e833729()
{
	var_ecc45b8c = struct::get_array("ww_lock_solution_" + self.script_int);
	foreach(var_c3be418 in var_ecc45b8c)
	{
		if(var_c3be418.script_int == self.var_210bfd21)
		{
			var_9e7c3935 = util::spawn_model(var_c3be418.model, var_c3be418.origin, var_c3be418.angles);
		}
	}
	level flag::wait_till(#"hash_65224b2f37fb9446");
	if(isdefined(var_9e7c3935))
	{
		var_9e7c3935 delete();
	}
}

