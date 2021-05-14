// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_256b8879317373de;
#using script_37752a01e45812b8;
#using script_3f9e0dc8454d98e1;
#using script_4abf5d8ad3cb6c5b;
#using script_56ca01b3b31455b5;
#using script_6021ce59143452c3;
#using script_61a734c95edc17aa;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_18db89ed;

/*
	Name: init
	Namespace: namespace_18db89ed
	Checksum: 0x455AB1B3
	Offset: 0x250
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	zm_player::register_slowdown(#"hash_2f87c75c463e66c3", 0.7, 0.1);
}

/*
	Name: init_clientfields
	Namespace: namespace_18db89ed
	Checksum: 0xF604E32D
	Offset: 0x2A0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("allplayers", "" + #"hash_55543319943057f1", 24000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_5160727729fd57a2", 24000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_13f1aaee7ebf9986", 24000, 2, "int");
	clientfield::register("toplayer", "" + #"hash_603fc9d210bdbc4d", 24000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_67340426cd141891", 24000, 2, "int");
}

/*
	Name: main
	Namespace: namespace_18db89ed
	Checksum: 0x8968FAC3
	Offset: 0x3F0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level.a_e_water = getentarray("e_water", "targetname");
	level.a_s_float_path = struct::get_array("s_float_path", "script_noteworthy");
	level flag::init(#"hash_69a9d00e65ee6c40");
	level flag::init(#"hash_17b882aed4431728");
	level.var_b0a3611a = 0.5;
	level thread zombie_coast_adjust_percent();
	level.zombie_init_done = &zombie_check_riser;
	callback::on_spawned(&function_99ca73e1);
}

/*
	Name: zombie_coast_adjust_percent
	Namespace: namespace_18db89ed
	Checksum: 0x66525809
	Offset: 0x4F0
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function zombie_coast_adjust_percent()
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"between_round_over");
		level waittill(#"between_round_over");
		if(level.var_b0a3611a > 0.1)
		{
			level.var_b0a3611a = level.var_b0a3611a - 0.05;
			if(level.var_b0a3611a <= 0.1)
			{
				level.var_b0a3611a = 0.1;
				break;
			}
		}
	}
}

/*
	Name: zombie_check_riser
	Namespace: namespace_18db89ed
	Checksum: 0x214E599F
	Offset: 0x5B0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function zombie_check_riser()
{
	self endon(#"death");
	if(self.in_the_ground === 1)
	{
		self waittill(#"risen");
	}
	if(!level flag::get(#"hash_17b882aed4431728"))
	{
		self thread zombie_water_out();
	}
}

/*
	Name: zombie_water_out
	Namespace: namespace_18db89ed
	Checksum: 0xB5897DE0
	Offset: 0x630
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function zombie_water_out()
{
	self endon(#"death");
	while(true)
	{
		foreach(e_water in level.a_e_water)
		{
			if(self istouching(e_water))
			{
				self zombie_entered_water();
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: zombie_entered_water
	Namespace: namespace_18db89ed
	Checksum: 0x9F8CF239
	Offset: 0x6F8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function zombie_entered_water()
{
	self endon(#"death");
	self.b_in_water = 1;
	self zombie_water_move_slow();
	self thread zombie_water_in();
}

/*
	Name: zombie_water_move_slow
	Namespace: namespace_18db89ed
	Checksum: 0xF4C145B3
	Offset: 0x758
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function zombie_water_move_slow()
{
	switch(self.zombie_move_speed)
	{
		case "walk":
		{
			break;
		}
		case "run":
		{
			self thread zombie_utility::set_zombie_run_cycle("walk");
			break;
		}
		case "sprint":
		{
			self thread zombie_utility::set_zombie_run_cycle("run");
			break;
		}
		case "super_sprint":
		{
			self thread zombie_utility::set_zombie_run_cycle("sprint");
			break;
		}
	}
}

/*
	Name: zombie_water_in
	Namespace: namespace_18db89ed
	Checksum: 0x2CB8B30C
	Offset: 0x828
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function zombie_water_in()
{
	self endon(#"death");
	while(true)
	{
		self.b_in_water = 0;
		foreach(e_water in level.a_e_water)
		{
			if(self istouching(e_water))
			{
				self.b_in_water = 1;
				if(!isdefined(self.var_3f789444))
				{
					self thread function_4c6f90cd();
				}
			}
			if(!self.b_in_water)
			{
				self zombie_exited_water();
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_4c6f90cd
	Namespace: namespace_18db89ed
	Checksum: 0xFCD00E9E
	Offset: 0x930
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_4c6f90cd()
{
	self endon(#"death");
	if(isdefined(self.ignore_water_damage) && self.ignore_water_damage)
	{
		return;
	}
	self.var_3f789444 = 1;
	wait(2);
	if(self.var_3f789444 === 1)
	{
		var_baafc291 = level.zombie_health * level.var_b0a3611a;
		if(self.health <= var_baafc291)
		{
			self.water_damage = 1;
			self dodamage(var_baafc291, self.origin);
		}
		self.var_3f789444 = undefined;
	}
}

/*
	Name: zombie_exited_water
	Namespace: namespace_18db89ed
	Checksum: 0xCE326795
	Offset: 0x9F8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function zombie_exited_water()
{
	self endon(#"death");
	self.b_in_water = 0;
	self.var_3f789444 = undefined;
	self zombie_water_move_normal();
	self thread zombie_water_out();
}

/*
	Name: zombie_water_move_normal
	Namespace: namespace_18db89ed
	Checksum: 0x5AE222B3
	Offset: 0xA58
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function zombie_water_move_normal()
{
	switch(self.zombie_move_speed)
	{
		case "walk":
		{
			self thread zombie_utility::set_zombie_run_cycle("run");
			break;
		}
		case "run":
		{
			self thread zombie_utility::set_zombie_run_cycle("sprint");
			break;
		}
		case "sprint":
		{
			self thread zombie_utility::set_zombie_run_cycle("super_sprint");
			break;
		}
		case "super_sprint":
		{
			break;
		}
	}
}

/*
	Name: function_99ca73e1
	Namespace: namespace_18db89ed
	Checksum: 0xF6E3A9C5
	Offset: 0xB20
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_99ca73e1()
{
	/#
		if(getdvarint(#"hash_60464f7ad910bd1a", 0))
		{
			return;
		}
	#/
	self thread function_ea0c7ed8();
}

/*
	Name: function_ea0c7ed8
	Namespace: namespace_18db89ed
	Checksum: 0x8F108788
	Offset: 0xB70
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_ea0c7ed8()
{
	self notify("4c2bcc084cb1ca9b");
	self endon("4c2bcc084cb1ca9b");
	level endon(#"end_game", #"hash_507adabe6ce05360");
	self endon(#"death", #"player_frozen");
	while(true)
	{
		foreach(e_water in level.a_e_water)
		{
			if(self istouching(e_water) && !self laststand::player_is_in_laststand())
			{
				self function_b52931e7();
				return;
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_b52931e7
	Namespace: namespace_18db89ed
	Checksum: 0x94E977B5
	Offset: 0xCA0
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_b52931e7()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	self.b_in_water = 1;
	self notify(#"hash_42fcb8fa7aec0734");
	if(!level flag::get(#"hash_69a9d00e65ee6c40"))
	{
		self thread function_26a271e6();
		self thread function_6577cacc();
		if(self.var_2e6aa97d === 1)
		{
			self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 2);
			if(isdefined(self.var_cdce7ec) && self.var_cdce7ec)
			{
				self allowsprint(0);
			}
		}
		else
		{
			self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
			self allowsprint(0);
			if(self issliding())
			{
				self setstance("crouch");
			}
			self allowslide(0);
		}
	}
	else
	{
		self thread function_121f8a53();
	}
	self thread function_4ab00cab();
}

/*
	Name: function_26a271e6
	Namespace: namespace_18db89ed
	Checksum: 0x2134F699
	Offset: 0xE90
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_26a271e6()
{
	self endon(#"death", #"hash_668824b34b3076bc");
	wait(5);
	self thread zm_audio::create_and_play_dialog(#"freeze", #"exert");
}

/*
	Name: function_4ab00cab
	Namespace: namespace_18db89ed
	Checksum: 0x6FE319DC
	Offset: 0xEF8
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_4ab00cab()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	while(true)
	{
		wait(0.1);
		foreach(e_water in level.a_e_water)
		{
			if(!self istouching(e_water) || self laststand::player_is_in_laststand())
			{
				self thread function_6cf1cc01();
				return;
			}
		}
	}
}

/*
	Name: function_6cf1cc01
	Namespace: namespace_18db89ed
	Checksum: 0x232AC3F0
	Offset: 0x1000
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_6cf1cc01()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	self.b_in_water = 0;
	self notify(#"hash_668824b34b3076bc");
	if(!level flag::get(#"hash_9cfd45106ac760d") && !level flag::get(#"hash_198bc172b5af7f25"))
	{
		self allowsprint(1);
		self allowslide(1);
		self thread function_d2dd1f2b();
		self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	}
	self thread function_ea0c7ed8();
}

/*
	Name: function_6577cacc
	Namespace: namespace_18db89ed
	Checksum: 0x59E3EE54
	Offset: 0x1140
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_6577cacc()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_668824b34b3076bc");
	if(!isdefined(self.var_36a93d1))
	{
		self.var_36a93d1 = 0;
	}
	while(true)
	{
		wait(1);
		self.var_36a93d1++;
		if(self.var_2e6aa97d === 1)
		{
			var_24e0e73d = 30;
		}
		else
		{
			var_24e0e73d = 15;
		}
		if(self.var_36a93d1 >= int(var_24e0e73d * 0.5))
		{
			self thread zm_audio::create_and_play_dialog(#"freeze", #"start");
		}
		if(self.var_36a93d1 >= var_24e0e73d)
		{
			waitframe(1);
			if(self zm_zonemgr::get_player_zone() === "underwater_tunnel")
			{
				self thread function_34e1762b();
			}
			else
			{
				self thread water_player_freeze();
				self thread zm_audio::create_and_play_dialog(#"freeze", #"frozen");
			}
			self.var_36a93d1 = 0;
			return;
		}
	}
}

/*
	Name: function_121f8a53
	Namespace: namespace_18db89ed
	Checksum: 0x931274CD
	Offset: 0x12E8
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_121f8a53()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_668824b34b3076bc");
	while(true)
	{
		self dodamage(20, self.origin);
		wait(1);
	}
}

/*
	Name: function_d2dd1f2b
	Namespace: namespace_18db89ed
	Checksum: 0x2AD387E7
	Offset: 0x1368
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_d2dd1f2b()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_42fcb8fa7aec0734");
	if(!isdefined(self.var_36a93d1) || self.var_36a93d1 == 0)
	{
		return;
	}
	while(true)
	{
		wait(1);
		self.var_36a93d1--;
		if(self.var_36a93d1 <= 0)
		{
			self.var_36a93d1 = 0;
			return;
		}
	}
}

/*
	Name: water_player_freeze
	Namespace: namespace_18db89ed
	Checksum: 0xD43CB4CB
	Offset: 0x1410
	Size: 0x364
	Parameters: 0
	Flags: Linked
*/
function water_player_freeze()
{
	self endon_callback(&function_c64292f, #"death");
	self.var_7dc2d507 = 1;
	self notify(#"player_frozen");
	self namespace_565e073b::function_3931c78();
	self function_bad6907c();
	self clientfield::set("" + #"hash_55543319943057f1", 1);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 1);
	var_1d3683e1 = spawn("trigger_damage", self.origin, 0, 15, 72);
	var_1d3683e1 enablelinkto();
	var_1d3683e1 linkto(self);
	self.var_1d3683e1 = var_1d3683e1;
	self thread function_872ec0b2(var_1d3683e1);
	if(isbot(self))
	{
		self thread function_8eb7b0f7();
	}
	else
	{
		self thread function_6cadbaff();
	}
	if(self.var_d844486 !== 1)
	{
		self thread zm_equipment::show_hint_text(#"hash_4b6950ec49c7e04c", 3);
		self.var_d844486 = 1;
	}
	self waittill(#"hash_53bfad7081c69dee");
	self playsound(#"hash_2f8c9575cb36a298");
	self.var_7dc2d507 = 0;
	self function_46c3bbf7();
	self clientfield::set("" + #"hash_55543319943057f1", 0);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
	waitframe(2);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
	if(isdefined(var_1d3683e1))
	{
		var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	waitframe(2);
	self thread function_ea0c7ed8();
}

/*
	Name: function_c64292f
	Namespace: namespace_18db89ed
	Checksum: 0x1FCB061A
	Offset: 0x1780
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_c64292f(str_notify)
{
	if(isdefined(self) && isdefined(self.var_1d3683e1))
	{
		self.var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	if(isdefined(self) && isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_bad6907c
	Namespace: namespace_18db89ed
	Checksum: 0x9BD02FC2
	Offset: 0x1800
	Size: 0x444
	Parameters: 0
	Flags: Linked
*/
function function_bad6907c()
{
	self endon_callback(&function_26234f4c, #"disconnect");
	if(self isusingoffhand())
	{
		self forceoffhandend();
	}
	self disableoffhandspecial();
	self disableoffhandweapons();
	self allowmelee(0);
	w_current = self getcurrentweapon();
	if(zm_loadout::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || ability_util::is_weapon_gadget(w_current) || ability_util::is_hero_weapon(w_current))
	{
		var_2e07b8ff = self getweaponslistprimaries();
		if(isdefined(var_2e07b8ff) && var_2e07b8ff.size > 0)
		{
			self switchtoweapon(var_2e07b8ff[0], 1);
			var_5a7831c4 = 0;
			while(!var_5a7831c4)
			{
				waitframe(1);
				w_current = self getcurrentweapon();
				if(w_current == var_2e07b8ff[0])
				{
					var_5a7831c4 = 1;
				}
			}
		}
	}
	foreach(weapon in self getweaponslist(1))
	{
		self function_28602a03(weapon, 1, 0);
		if(weapon.dualwieldweapon != level.weaponnone)
		{
			self function_28602a03(weapon.dualwieldweapon, 1, 0);
		}
	}
	self.e_tag = util::spawn_model("tag_origin", self.origin, self.angles);
	self playerlinktoabsolute(self.e_tag, "tag_origin");
	self allowjump(0);
	self allowsprint(0);
	self player::allow_stance_change(0);
	self allowads(0);
	self thread function_67981637();
	self bgb::suspend_weapon_cycling();
	self disableweaponcycling();
	self namespace_7d0afffb::function_ac9cb612(1);
	self.var_be3224e6 = 1;
	if(isdefined(level.var_526d919))
	{
		w_current = self getcurrentweapon();
		if(isdefined(level.var_526d919[w_current.name]))
		{
			self allowmelee(1);
		}
		else
		{
			self allowmelee(0);
		}
	}
	else
	{
		self allowmelee(1);
	}
}

/*
	Name: function_67981637
	Namespace: namespace_18db89ed
	Checksum: 0xC0F6C02C
	Offset: 0x1C50
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_67981637()
{
	self endon(#"death");
	while(self.var_7dc2d507)
	{
		self shellshock(#"slowview", 1.1);
		wait(1);
	}
}

/*
	Name: function_46c3bbf7
	Namespace: namespace_18db89ed
	Checksum: 0x1BCCD4A
	Offset: 0x1CB0
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_46c3bbf7()
{
	self endon_callback(&function_26234f4c, #"disconnect");
	if(zm_utility::is_trials())
	{
		self namespace_78baa66c::function_b4bd25ef();
	}
	else
	{
		self enableoffhandspecial();
		self enableoffhandweapons();
		foreach(weapon in self getweaponslist(1))
		{
			self unlockweapon(weapon);
			if(weapon.dualwieldweapon != level.weaponnone)
			{
				self unlockweapon(weapon.dualwieldweapon);
			}
		}
	}
	self namespace_7d0afffb::function_ac9cb612(0);
	self.var_be3224e6 = 0;
	self bgb::resume_weapon_cycling();
	self enableweaponcycling();
	self stopshellshock();
	self allowjump(1);
	self allowsprint(1);
	self player::allow_stance_change(1);
	self allowads(1);
	self unlink();
	if(isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_26234f4c
	Namespace: namespace_18db89ed
	Checksum: 0xD2F546F5
	Offset: 0x1F00
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_26234f4c(str_notify)
{
	if(isdefined(self) && isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_872ec0b2
	Namespace: namespace_18db89ed
	Checksum: 0x47142A5E
	Offset: 0x1F48
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_872ec0b2(var_1d3683e1)
{
	self endon(#"death", #"hash_53bfad7081c69dee");
	while(true)
	{
		s_notify = undefined;
		s_notify = var_1d3683e1 waittill(#"damage");
		if(s_notify.attacker === self)
		{
			continue;
		}
		else
		{
			self notify(#"hash_53bfad7081c69dee");
		}
	}
}

/*
	Name: function_6cadbaff
	Namespace: namespace_18db89ed
	Checksum: 0x2ADDEC94
	Offset: 0x1FE8
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function function_6cadbaff()
{
	self endon(#"death", #"hash_53bfad7081c69dee");
	if(level flag::get(#"break_freeze_faster"))
	{
		self waittill(#"weapon_melee", #"weapon_melee_power");
		self playrumbleonentity("damage_heavy");
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
		self notify(#"hash_53bfad7081c69dee");
	}
	else
	{
		self waittill(#"weapon_melee", #"weapon_melee_power");
		self playrumbleonentity("damage_light");
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 2);
		self playsound(#"hash_1a3cd046cb0b437f");
		self waittill(#"weapon_melee", #"weapon_melee_power");
		self playrumbleonentity("damage_light");
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 1);
		self playsound(#"hash_1a3cd146cb0b4532");
		self waittill(#"weapon_melee", #"weapon_melee_power");
		self playrumbleonentity("damage_heavy");
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
		self notify(#"hash_53bfad7081c69dee");
	}
}

/*
	Name: function_8eb7b0f7
	Namespace: namespace_18db89ed
	Checksum: 0xB4ECF619
	Offset: 0x2258
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_8eb7b0f7()
{
	self endon(#"death", #"hash_53bfad7081c69dee");
	if(level flag::get(#"break_freeze_faster"))
	{
		wait(3);
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
		self notify(#"hash_53bfad7081c69dee");
	}
	else
	{
		wait(5);
		self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
		self notify(#"hash_53bfad7081c69dee");
	}
}

/*
	Name: function_142c254b
	Namespace: namespace_18db89ed
	Checksum: 0x1F15EB2F
	Offset: 0x2338
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_142c254b()
{
	self.var_1ed2984a = 1;
	self dodamage(50, self.origin, undefined, undefined, undefined, "MOD_BURNED");
	self thread function_e8485ac0();
}

/*
	Name: function_e8485ac0
	Namespace: namespace_18db89ed
	Checksum: 0x2AC56261
	Offset: 0x2398
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_e8485ac0()
{
	self endon(#"death");
	n_counter = 0;
	while(true)
	{
		wait(0.1);
		n_counter = n_counter + 0.1;
		if(n_counter >= 1)
		{
			self.var_1ed2984a = 0;
			return;
		}
	}
}

/*
	Name: function_34e1762b
	Namespace: namespace_18db89ed
	Checksum: 0x96B35092
	Offset: 0x2408
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_34e1762b()
{
	self endon_callback(&function_f0339fd, #"death");
	self.var_7dc2d507 = 1;
	self notify(#"player_frozen");
	self function_e22d95bc();
	self clientfield::set("" + #"hash_55543319943057f1", 1);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 1);
	self function_615d3be0();
	self function_d793c8ff();
	self function_bad6907c();
	var_1d3683e1 = spawn("trigger_damage", self.origin, 0, 15, 72);
	var_1d3683e1 enablelinkto();
	var_1d3683e1 linkto(self);
	self.var_1d3683e1 = var_1d3683e1;
	self thread function_872ec0b2(var_1d3683e1);
	self thread function_6cadbaff();
	self waittill(#"hash_53bfad7081c69dee");
	self.var_7dc2d507 = 0;
	self function_46c3bbf7();
	self clientfield::set("" + #"hash_55543319943057f1", 0);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
	waitframe(2);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
	if(isdefined(var_1d3683e1))
	{
		var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	waitframe(2);
	self thread function_ea0c7ed8();
}

/*
	Name: function_f0339fd
	Namespace: namespace_18db89ed
	Checksum: 0x1C912A2F
	Offset: 0x2710
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_f0339fd(str_notify)
{
	if(isdefined(self) && isdefined(self.var_1d3683e1))
	{
		self.var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	if(isdefined(self) && isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_e22d95bc
	Namespace: namespace_18db89ed
	Checksum: 0x869EE3B8
	Offset: 0x2790
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_e22d95bc()
{
	self endon_callback(&function_26234f4c, #"disconnect");
	self val::set(#"fasttravel", "freezecontrols", 1);
	self val::set(#"fasttravel", "ignoreme", 1);
	if(!self laststand::player_is_in_laststand())
	{
		str_stance = self getstance();
		switch(str_stance)
		{
			case "crouch":
			{
				self setstance("stand");
				wait(0.2);
				break;
			}
			case "prone":
			{
				self setstance("stand");
				wait(1);
				break;
			}
		}
	}
	self.e_tag = util::spawn_model("tag_origin", self.origin, self.angles);
	self playerlinktoabsolute(self.e_tag, "tag_origin");
}

/*
	Name: function_d793c8ff
	Namespace: namespace_18db89ed
	Checksum: 0xD747103
	Offset: 0x2930
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_d793c8ff()
{
	self endon_callback(&function_d92c3acf, #"disconnect");
	self val::set(#"fasttravel", "freezecontrols", 0);
	self val::set(#"fasttravel", "takedamage", 1);
	self val::set(#"fasttravel", "ignoreme", 0);
	self unlink();
	if(isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_d92c3acf
	Namespace: namespace_18db89ed
	Checksum: 0xF1A23345
	Offset: 0x2A28
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_d92c3acf(str_notify)
{
	if(isdefined(self) && isdefined(self.e_tag))
	{
		self.e_tag delete();
	}
}

/*
	Name: function_615d3be0
	Namespace: namespace_18db89ed
	Checksum: 0x39DDDE8A
	Offset: 0x2A70
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_615d3be0()
{
	level endon(#"end_game");
	a_s_float_path = array::get_all_closest(self.origin, level.a_s_float_path);
	var_98698d94 = a_s_float_path[0];
	while(true)
	{
		var_7c1bf084 = self function_e2d41c8d(var_98698d94);
		self.e_tag moveto(var_98698d94.origin, var_7c1bf084);
		self.e_tag waittill(#"movedone");
		if(isdefined(var_98698d94.target))
		{
			var_98698d94 = struct::get(var_98698d94.target, "targetname");
		}
		else
		{
			return;
		}
	}
}

/*
	Name: function_e2d41c8d
	Namespace: namespace_18db89ed
	Checksum: 0xF7C15682
	Offset: 0x2B80
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_e2d41c8d(s_start)
{
	var_96e16c65 = distance(self.origin, s_start.origin);
	var_7ddd94c0 = var_96e16c65 / 100;
	return 0.5 * var_7ddd94c0;
}

/*
	Name: water_debug_hud_elem_thread
	Namespace: namespace_18db89ed
	Checksum: 0x2CF50A01
	Offset: 0x2BE0
	Size: 0xC8
	Parameters: 1
	Flags: None
*/
function water_debug_hud_elem_thread(player)
{
	/#
		player endon(#"death");
		self thread update_hud_elem(player);
		while(true)
		{
			if(isdefined(player.b_in_water))
			{
				self setvalue(player.b_in_water);
				println("" + player getentitynumber() + "");
			}
			player waittill(#"update_frost_state");
		}
	#/
}

/*
	Name: update_hud_elem
	Namespace: namespace_18db89ed
	Checksum: 0xE59CE9C8
	Offset: 0x2CB0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function update_hud_elem(player)
{
	/#
		player endon(#"death");
		while(true)
		{
			wait(0.1);
			player notify(#"update_frost_state");
		}
	#/
}

