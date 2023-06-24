// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zodt8_achievements;

/*
	Name: init
	Namespace: zodt8_achievements
	Checksum: 0x2AD7089E
	Offset: 0x188
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_55aa3c20();
	level thread function_6b34cb92();
	callback::on_connect(&on_player_connect);
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: on_player_connect
	Namespace: zodt8_achievements
	Checksum: 0xC78AADA2
	Offset: 0x208
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread function_25c39229();
	self thread function_d814403c();
	self thread function_1b454689();
	self thread function_46c56964();
	self thread function_ec3040dd();
	self thread function_52f9045f();
	self thread function_b97662b6();
}

/*
	Name: on_ai_killed
	Namespace: zodt8_achievements
	Checksum: 0x838CF89B
	Offset: 0x2C0
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(params)
{
	if(isplayer(params.eattacker))
	{
		params.eattacker thread function_e7750e06(params);
		if(self.archetype == #"zombie" || self.archetype == #"catalyst")
		{
			if(self clientfield::get("sndActorUnderwater"))
			{
				params.eattacker thread function_9ac35f47();
			}
			if(isdefined(params.einflictor) && params.einflictor.archetype === #"catalyst" && (isdefined(params.einflictor.var_85387c5b) && params.einflictor.var_85387c5b))
			{
				params.eattacker thread function_4060b2c6();
			}
		}
		else if(self.archetype == #"stoker")
		{
			if(isdefined(self.var_6f3ba226) && self.var_6f3ba226)
			{
				params.eattacker thread function_79182658();
			}
		}
	}
}

/*
	Name: function_55aa3c20
	Namespace: zodt8_achievements
	Checksum: 0x49303A05
	Offset: 0x458
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_55aa3c20()
{
	level endon(#"end_game");
	level flagsys::wait_till(#"hash_25d8c88ff3f91ee5");
	/#
		iprintlnbold("");
	#/
	zm_utility::giveachievement_wrapper("ZM_ZODT8_ARTIFACT", 1);
}

/*
	Name: function_25c39229
	Namespace: zodt8_achievements
	Checksum: 0x42E0F8C
	Offset: 0x4E0
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function function_25c39229()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self.var_6ab98264 = 0;
	self thread function_934d3464();
	while(true)
	{
		self waittill(#"hash_7ba738379777a068");
		self.var_6ab98264 = 1;
		b_success = self function_6e60e5b8();
		if(isdefined(b_success) && b_success)
		{
			/#
				iprintlnbold("" + self getentnum());
			#/
			self zm_utility::giveachievement_wrapper("ZM_ZODT8_STOWAWAY", 0);
			self notify(#"hash_10404a179a65cd64");
			return;
		}
		self.var_6ab98264 = 0;
	}
}

/*
	Name: function_6e60e5b8
	Namespace: zodt8_achievements
	Checksum: 0xE6AE2DE3
	Offset: 0x608
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_6e60e5b8()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_5a83ec4a73b3dc6");
	level waittill(#"start_of_round");
	var_980ea73 = level.round_number;
	while(true)
	{
		level waittill(#"end_of_round");
		if((level.round_number - var_980ea73) >= 5)
		{
			return true;
		}
	}
}

/*
	Name: function_934d3464
	Namespace: zodt8_achievements
	Checksum: 0xE10964F0
	Offset: 0x6C8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_934d3464()
{
	level endon(#"end_game");
	self endon(#"hash_10404a179a65cd64", #"disconnect");
	var_6bf54ff2 = array(#"zone_cargo");
	while(true)
	{
		if(isdefined(self.zone_name))
		{
			var_d5a6219e = (isstring(self.zone_name) ? hash(self.zone_name) : self.zone_name);
			if(isinarray(var_6bf54ff2, var_d5a6219e))
			{
				if(!self.var_6ab98264)
				{
					self notify(#"hash_7ba738379777a068");
				}
			}
			else if(self.var_6ab98264)
			{
				self notify(#"hash_5a83ec4a73b3dc6");
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_6b34cb92
	Namespace: zodt8_achievements
	Checksum: 0xAE4A0115
	Offset: 0x808
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_6b34cb92()
{
	level endon(#"end_game", #"hash_5c62047f5c8fdbdd", #"hash_6cd15a5470217958");
	while(true)
	{
		level waittill(#"end_of_round");
		if(level.round_number >= 20)
		{
			wait(2);
			/#
				iprintlnbold("");
			#/
			zm_utility::giveachievement_wrapper("ZM_ZODT8_DEEP_END", 1);
			return;
		}
	}
}

/*
	Name: function_d814403c
	Namespace: zodt8_achievements
	Checksum: 0x5A822FB2
	Offset: 0x8D8
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_d814403c()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"pap_taken");
		if(isdefined(level.s_pap_quest) && isdefined(level.s_pap_quest.var_88aa74e))
		{
			if(!isdefined(self.var_6ba87fa))
			{
				self.var_6ba87fa = [];
			}
			if(!isinarray(self.var_6ba87fa, level.s_pap_quest.var_88aa74e.prefabname))
			{
				if(!isdefined(self.var_6ba87fa))
				{
					self.var_6ba87fa = [];
				}
				else if(!isarray(self.var_6ba87fa))
				{
					self.var_6ba87fa = array(self.var_6ba87fa);
				}
				if(!isinarray(self.var_6ba87fa, level.s_pap_quest.var_88aa74e.prefabname))
				{
					self.var_6ba87fa[self.var_6ba87fa.size] = level.s_pap_quest.var_88aa74e.prefabname;
				}
				if(self.var_6ba87fa.size > 3)
				{
					wait(1);
					if(isdefined(self))
					{
						/#
							iprintlnbold("" + self getentnum());
						#/
						self zm_utility::giveachievement_wrapper("ZM_ZODT8_LITTLE_PACK", 0);
						self.var_6ba87fa = undefined;
						return;
					}
				}
			}
		}
	}
}

/*
	Name: function_1b454689
	Namespace: zodt8_achievements
	Checksum: 0x8BA8D7CF
	Offset: 0xAD8
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_1b454689()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"fasttravel_bought");
		if(isdefined(self.var_5817f611))
		{
			if(!isdefined(self.var_b5982a89))
			{
				self.var_b5982a89 = [];
			}
			if(!isinarray(self.var_b5982a89, self.var_5817f611))
			{
				if(!isdefined(self.var_b5982a89))
				{
					self.var_b5982a89 = [];
				}
				else if(!isarray(self.var_b5982a89))
				{
					self.var_b5982a89 = array(self.var_b5982a89);
				}
				if(!isinarray(self.var_b5982a89, self.var_5817f611))
				{
					self.var_b5982a89[self.var_b5982a89.size] = self.var_5817f611;
				}
				if(self.var_b5982a89.size > 7)
				{
					self waittill(#"fasttravel_finished", #"death");
					wait(1);
					if(isdefined(self))
					{
						/#
							iprintlnbold("" + self getentnum());
						#/
						self zm_utility::giveachievement_wrapper("ZM_ZODT8_SHORTCUT", 0);
						self.var_b5982a89 = undefined;
						return;
					}
				}
			}
		}
	}
}

/*
	Name: function_46c56964
	Namespace: zodt8_achievements
	Checksum: 0xE74186FC
	Offset: 0xCB0
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_46c56964()
{
	level endon(#"end_game");
	self endon(#"disconnect", #"hash_7ef6edd06b06d480");
	self.var_574b5261 = 0;
	while(true)
	{
		/#
			if(self.var_574b5261)
			{
				iprintln("" + self.var_574b5261);
			}
		#/
		waitresult = undefined;
		waitresult = self waittill(#"weapon_fired", #"weapon_switch_started", #"offhand_fire", #"grenade_pullback");
		self.var_574b5261 = 0;
	}
}

/*
	Name: function_e7750e06
	Namespace: zodt8_achievements
	Checksum: 0x69B3EC39
	Offset: 0xDA8
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_e7750e06(params)
{
	if(zm_weapons::is_wonder_weapon(params.weapon))
	{
		switch(params.weapon.name)
		{
			case "ww_tricannon_fire_t8":
			case "ww_tricannon_earth_t8":
			case "ww_tricannon_t8_upgraded":
			case "ww_tricannon_air_t8_upgraded":
			case "ww_tricannon_earth_t8_upgraded":
			case "ww_tricannon_fire_t8_upgraded":
			case "ww_tricannon_water_t8_upgraded":
			case "ww_tricannon_water_t8":
			case "ww_tricannon_t8":
			case "ww_tricannon_air_t8":
			{
				if(self.var_574b5261 >= 0)
				{
					self.var_574b5261++;
				}
				break;
			}
		}
		if(self.var_574b5261 >= 9)
		{
			/#
				iprintlnbold("" + self getentnum());
			#/
			self zm_utility::giveachievement_wrapper("ZM_ZODT8_TENTACLE", 0);
			self notify(#"hash_7ef6edd06b06d480");
			self.var_574b5261 = -1;
			return;
		}
	}
}

/*
	Name: function_ec3040dd
	Namespace: zodt8_achievements
	Checksum: 0x72113C50
	Offset: 0xF48
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_ec3040dd()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self.var_5b0772a7 = undefined;
	self.var_7f491224 = 0;
	while(true)
	{
		if(self.var_7f491224 >= 3)
		{
			/#
				iprintlnbold("" + self getentnum());
			#/
			self zm_utility::giveachievement_wrapper("ZM_ZODT8_STOKING", 0);
			self.var_8c5df11c = 1;
			return;
		}
		wait(2);
	}
}

/*
	Name: function_79182658
	Namespace: zodt8_achievements
	Checksum: 0x60FC3E8E
	Offset: 0x1028
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_79182658()
{
	if(isdefined(self.var_8c5df11c) && self.var_8c5df11c)
	{
		return;
	}
	if(!isdefined(self.var_5b0772a7))
	{
		self.var_5b0772a7 = level.round_number;
	}
	if(self.var_5b0772a7 != level.round_number)
	{
		self.var_5b0772a7 = level.round_number;
		self.var_7f491224 = 0;
	}
	self.var_7f491224++;
	/#
		iprintln("" + self.var_7f491224);
	#/
}

/*
	Name: function_52f9045f
	Namespace: zodt8_achievements
	Checksum: 0x976D3A30
	Offset: 0x10D8
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_52f9045f()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self.var_2b642048 = 0;
	/#
		var_1c5c067e = 0;
	#/
	while(true)
	{
		/#
			if(self.var_2b642048 != var_1c5c067e)
			{
				iprintln("" + self.var_2b642048);
				var_1c5c067e = self.var_2b642048;
			}
		#/
		if(self.var_2b642048 >= 9)
		{
			/#
				iprintlnbold("" + self getentnum());
			#/
			self zm_utility::giveachievement_wrapper("ZM_ZODT8_ROCK_PAPER", 0);
			return;
		}
		wait(2);
	}
}

/*
	Name: function_4060b2c6
	Namespace: zodt8_achievements
	Checksum: 0x2686B2B5
	Offset: 0x11F0
	Size: 0x10
	Parameters: 0
	Flags: Linked
*/
function function_4060b2c6()
{
	self.var_2b642048++;
}

/*
	Name: function_b97662b6
	Namespace: zodt8_achievements
	Checksum: 0x8C51D986
	Offset: 0x1208
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_b97662b6()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self.var_9e1be4c6 = 0;
	/#
		var_1c5c067e = 0;
	#/
	while(true)
	{
		/#
			if(self.var_9e1be4c6 != var_1c5c067e)
			{
				iprintln("" + self.var_9e1be4c6);
				var_1c5c067e = self.var_9e1be4c6;
			}
		#/
		if(self.var_9e1be4c6 >= 50)
		{
			/#
				iprintlnbold("" + self getentnum());
			#/
			self zm_utility::giveachievement_wrapper("ZM_ZODT8_SWIMMING", 0);
			return;
		}
		wait(2);
	}
}

/*
	Name: function_9ac35f47
	Namespace: zodt8_achievements
	Checksum: 0x773CA6FF
	Offset: 0x1320
	Size: 0x10
	Parameters: 0
	Flags: Linked
*/
function function_9ac35f47()
{
	self.var_9e1be4c6++;
}

