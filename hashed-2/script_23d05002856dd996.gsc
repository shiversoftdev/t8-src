// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_b2cc62e0;

/*
	Name: init
	Namespace: namespace_b2cc62e0
	Checksum: 0x8709DC70
	Offset: 0x1F0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_e502ed82();
	spawner::add_archetype_spawn_function(#"gegenees", &function_b3786a8a);
	callback::on_connect(&function_3aed7ccf);
}

/*
	Name: function_3aed7ccf
	Namespace: namespace_b2cc62e0
	Checksum: 0x87720A06
	Offset: 0x268
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_3aed7ccf()
{
	self thread function_ec51ce01();
	self thread function_653f23be();
	self thread function_50e46434();
	self thread function_863d6212();
	self thread function_103e6827();
	self thread function_3c39c720();
	self thread function_74846734();
	self thread function_84d102f2();
}

/*
	Name: function_ec51ce01
	Namespace: namespace_b2cc62e0
	Checksum: 0x6D7FA554
	Offset: 0x338
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ec51ce01()
{
	self endon(#"disconnect");
	level waittill(#"hash_71d7e6a55a1ca9e");
	if(zm_utility::is_classic())
	{
		/#
			self iprintlnbold("");
		#/
		self zm_utility::giveachievement_wrapper("zm_red_tragedy");
	}
}

/*
	Name: function_653f23be
	Namespace: namespace_b2cc62e0
	Checksum: 0xDC573321
	Offset: 0x3C0
	Size: 0x174
	Parameters: 0
	Flags: Linked, Private
*/
private function function_653f23be()
{
	self endon(#"death");
	level endon(#"end_game");
	if(namespace_59ff1d6c::function_901b751c(#"startround") > 1)
	{
		return;
	}
	level flagsys::wait_till("start_zombie_round_logic");
	if(level.round_number > 1)
	{
		return;
	}
	while(level.round_number <= 20)
	{
		str_zone = self zm_zonemgr::get_player_zone();
		if(!isdefined(str_zone) || !isinarray(var_76f21e6b, str_zone))
		{
			return;
		}
		wait(1);
	}
	/#
		self iprintlnbold("");
	#/
	self zm_utility::giveachievement_wrapper("zm_red_follower");
}

/*
	Name: function_50e46434
	Namespace: namespace_b2cc62e0
	Checksum: 0xB0879784
	Offset: 0x540
	Size: 0x12A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_50e46434()
{
	self endon(#"disconnect");
	if(namespace_59ff1d6c::function_901b751c(#"startround") > 1)
	{
		return;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_751ac3ddacb1c548", #"between_round_over");
		if(var_88706ea7._notify == "between_round_over" && level.round_number > 15)
		{
			return;
		}
		if(!isdefined(level.var_705db276))
		{
			continue;
		}
		if(level.var_705db276 >= 5)
		{
			/#
				self iprintlnbold("");
			#/
			self zm_utility::giveachievement_wrapper("zm_red_tribute");
			return;
		}
	}
}

/*
	Name: function_863d6212
	Namespace: namespace_b2cc62e0
	Checksum: 0xA35B6469
	Offset: 0x678
	Size: 0x11A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_863d6212()
{
	self endon(#"disconnect");
	if(!namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4") || zm_utility::is_standard())
	{
		return;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_4c8edf52fbfca691");
		if(self flag::get(#"hash_39a1607d1d9f960b") || !isdefined(var_88706ea7.var_e0ae28d))
		{
			continue;
		}
		if(var_88706ea7.var_e0ae28d >= 4)
		{
			/#
				self iprintlnbold("");
			#/
			self zm_utility::giveachievement_wrapper("zm_red_mountains");
			return;
		}
	}
}

/*
	Name: function_103e6827
	Namespace: namespace_b2cc62e0
	Checksum: 0x79DCA48D
	Offset: 0x7A0
	Size: 0x122
	Parameters: 0
	Flags: Linked, Private
*/
private function function_103e6827()
{
	self endon(#"disconnect");
	if(!namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4") || zm_utility::is_standard())
	{
		return;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_175b1370e662293a");
		if(self flag::get(#"hash_39a1607d1d9f960b"))
		{
			continue;
		}
		if(isdefined(var_88706ea7.var_b1224954) && var_88706ea7.var_b1224954.var_3e6f3662 >= 15)
		{
			/#
				self iprintlnbold("");
			#/
			self zm_utility::giveachievement_wrapper("zm_red_no_obol");
			return;
		}
	}
}

/*
	Name: function_3c39c720
	Namespace: namespace_b2cc62e0
	Checksum: 0x50005C44
	Offset: 0x8D0
	Size: 0x19A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3c39c720()
{
	self endon_callback(&function_a5f404e2, #"disconnect");
	if(!namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4") || zm_utility::is_standard())
	{
		return;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_4969a839c4e666dc");
		if(self flag::get(#"hash_39a1607d1d9f960b"))
		{
			continue;
		}
		self.var_ec3e3f82 = 0;
		level callback::on_ai_killed(&function_8a595f5);
		self waittill(#"weapon_change", #"weapon_fired", #"hash_609518a5a35564bf");
		level callback::remove_on_ai_killed(&function_8a595f5);
		if(self.var_ec3e3f82 >= 20)
		{
			/#
				self iprintlnbold("");
			#/
			self zm_utility::giveachievement_wrapper("zm_red_sun");
			return;
		}
		self.var_ec3e3f82 = undefined;
	}
}

/*
	Name: function_8a595f5
	Namespace: namespace_b2cc62e0
	Checksum: 0xA8A361AF
	Offset: 0xA78
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_8a595f5(s_params)
{
	if(isplayer(s_params.eattacker) && s_params.weapon == level.var_45072d7d)
	{
		if(isdefined(self.var_4dcd7a1c) && self.var_4dcd7a1c)
		{
			s_params.eattacker.var_ec3e3f82++;
		}
	}
}

/*
	Name: function_a5f404e2
	Namespace: namespace_b2cc62e0
	Checksum: 0x20622574
	Offset: 0xAF0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a5f404e2(var_c34665fc)
{
	level callback::remove_on_ai_killed(&function_8a595f5);
}

/*
	Name: function_74846734
	Namespace: namespace_b2cc62e0
	Checksum: 0xDB213295
	Offset: 0xB28
	Size: 0x19A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_74846734()
{
	self endon_callback(&function_8828b419, #"disconnect");
	if(!namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4") || zm_utility::is_standard())
	{
		return;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_39bd256a221ddf79");
		if(self flag::get(#"hash_39a1607d1d9f960b"))
		{
			continue;
		}
		self.var_a9371a9a = 0;
		level callback::on_ai_killed(&function_c6125761);
		self waittill(#"weapon_change", #"weapon_fired", #"hash_609518a5a35564bf");
		level callback::remove_on_ai_killed(&function_c6125761);
		if(self.var_a9371a9a >= 20)
		{
			/#
				self iprintlnbold("");
			#/
			self zm_utility::giveachievement_wrapper("zm_red_wind");
			return;
		}
		self.var_a9371a9a = undefined;
	}
}

/*
	Name: function_c6125761
	Namespace: namespace_b2cc62e0
	Checksum: 0x77998548
	Offset: 0xCD0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_c6125761(s_params)
{
	if(isplayer(s_params.eattacker) && s_params.weapon == level.var_f7e963d9)
	{
		if(isdefined(self.var_8ac7cc49) && self.var_8ac7cc49 && isdefined(s_params.eattacker.var_a9371a9a))
		{
			s_params.eattacker.var_a9371a9a++;
		}
	}
}

/*
	Name: function_8828b419
	Namespace: namespace_b2cc62e0
	Checksum: 0xE38C5D14
	Offset: 0xD68
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8828b419(var_c34665fc)
{
	level callback::remove_on_ai_killed(&function_c6125761);
}

/*
	Name: function_84d102f2
	Namespace: namespace_b2cc62e0
	Checksum: 0xC6D22785
	Offset: 0xDA0
	Size: 0x184
	Parameters: 0
	Flags: Linked, Private
*/
private function function_84d102f2()
{
	self endon(#"disconnect", #"hash_5766f147327163d1");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_4fb1eb2c137a7955", #"hash_1e2d6c34f734996b");
		if(var_88706ea7._notify == #"hash_4fb1eb2c137a7955")
		{
			if(var_88706ea7.e_player !== self)
			{
				return;
			}
			waitframe(1);
			if(level flag::get(#"hash_67695ee69c57c0b2") && level flag::get(#"hash_61de3b8fe6f6a35"))
			{
				/#
					self iprintlnbold("");
				#/
				self zm_utility::giveachievement_wrapper("zm_red_eagle");
				self notify(#"hash_5766f147327163d1");
			}
			else
			{
				self thread function_9fdcf13f();
			}
		}
		else if(var_88706ea7._notify == #"hash_1e2d6c34f734996b")
		{
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_9fdcf13f
	Namespace: namespace_b2cc62e0
	Checksum: 0x9AFEB54D
	Offset: 0xF30
	Size: 0x70
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9fdcf13f()
{
	self endon(#"disconnect", #"hash_5766f147327163d1", #"hash_4fb1eb2c137a7955");
	self waittill(#"weapon_change");
	level notify(#"hash_1e2d6c34f734996b", {#e_player:self});
}

/*
	Name: function_b3786a8a
	Namespace: namespace_b2cc62e0
	Checksum: 0x4CA88980
	Offset: 0xFA8
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b3786a8a()
{
	self thread function_f31369ae();
}

/*
	Name: function_f31369ae
	Namespace: namespace_b2cc62e0
	Checksum: 0x61ADACA5
	Offset: 0xFD0
	Size: 0x18C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f31369ae()
{
	while(isalive(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage", #"death");
		if(var_88706ea7.weapon === getweapon(#"zhield_zpear_dw") || var_88706ea7.weapon === getweapon(#"hash_1a385be4d5103a33") && isplayer(var_88706ea7.attacker))
		{
			if(!isdefined(e_player))
			{
				e_player = var_88706ea7.attacker;
			}
			else if(e_player !== var_88706ea7.attacker || (isdefined(e_player.var_298cc14d) && e_player.var_298cc14d))
			{
				return;
			}
		}
		else
		{
			return;
		}
	}
	if(isdefined(e_player))
	{
		e_player.var_298cc14d = 1;
		/#
			e_player iprintlnbold("");
		#/
		e_player zm_utility::giveachievement_wrapper("zm_red_defense");
	}
}

/*
	Name: function_e502ed82
	Namespace: namespace_b2cc62e0
	Checksum: 0x980347F5
	Offset: 0x1168
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e502ed82()
{
	level endon(#"end_game");
	a_flags = array(#"hash_5827ff8b059b77f3", #"hash_786c9a9f60b254f5", #"hash_3b7c39d9b76689fb", #"hash_29ac8ec32d2a389b", #"hash_39100dea955077f2");
	level flagsys::wait_till_all(a_flags);
	/#
		iprintlnbold("");
	#/
	zm_utility::giveachievement_wrapper("zm_red_gods", 1);
}

