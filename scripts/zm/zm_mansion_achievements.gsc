// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace mansion_achievements;

/*
	Name: init
	Namespace: mansion_achievements
	Checksum: 0x30682A78
	Offset: 0x230
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_51e43f4f();
	level thread function_f4b6212();
	level thread function_c91cfd5a();
	level thread function_a46f4413();
	callback::on_connect(&on_player_connect);
	callback::on_player_damage(&on_player_damage);
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: on_player_connect
	Namespace: mansion_achievements
	Checksum: 0x5D3AF9B7
	Offset: 0x300
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread function_51328dc2();
	self thread function_783dcd31();
	self thread function_87a4fba4();
	self thread function_e1ae38eb();
	self thread function_dd592c16();
	self thread function_18c92a4f();
}

/*
	Name: on_player_damage
	Namespace: mansion_achievements
	Checksum: 0x42479C63
	Offset: 0x3A0
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(isdefined(params.einflictor) && isdefined(params.einflictor.var_9fde8624))
	{
		var_e72cb811 = params.einflictor.var_9fde8624;
	}
	if(isdefined(params.einflictor) && isdefined(params.einflictor.str_current_anim))
	{
		str_current_anim = params.einflictor.str_current_anim;
	}
	if(var_e72cb811 === #"crimson_nosferatu" && str_current_anim === #"hash_30a3ae992c453f0c")
	{
		self notify(#"hash_6938bc311a1a893e");
	}
}

/*
	Name: on_ai_killed
	Namespace: mansion_achievements
	Checksum: 0xA2276EA
	Offset: 0x490
	Size: 0x280
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(params)
{
	e_attacker = params.eattacker;
	if(isplayer(e_attacker))
	{
		if(self.archetype == #"nosferatu")
		{
			str_zone = self zm_utility::get_current_zone();
			if(isdefined(params.weapon) && isdefined(params.weapon.name))
			{
				str_weapon = params.weapon.name;
			}
			if(str_zone === "zone_dining_room" && str_weapon === #"stake_knife")
			{
				e_attacker notify(#"hash_4505abb76e48700a");
			}
		}
		else if(self.archetype == #"werewolf")
		{
			str_zone = self zm_utility::get_current_zone();
			if(isdefined(params.weapon) && isdefined(params.weapon.name))
			{
				str_weapon = params.weapon.name;
			}
			a_revolvers = array(#"pistol_topbreak_t8", #"pistol_topbreak_t8_upgraded", #"pistol_revolver_t8", #"pistol_revolver_t8_gold", #"pistol_revolver_t8_upgraded", #"hash_138efe2bb30be63c", #"hash_138f012bb30beb55", #"hash_46ad37ce8122812e", #"hash_138f002bb30be9a2", #"hash_3a8348f19a7e7629");
			if(str_zone === "zone_library" && isdefined(str_weapon) && isinarray(a_revolvers, str_weapon))
			{
				e_attacker notify(#"hash_1ac06d8c0149a66c");
			}
		}
	}
}

/*
	Name: function_51e43f4f
	Namespace: mansion_achievements
	Checksum: 0xAF1B0485
	Offset: 0x718
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_51e43f4f()
{
	level endon(#"end_game");
	level flagsys::wait_till(#"hash_25d8c88ff3f91ee5");
	/#
		iprintlnbold("");
	#/
	zm_utility::giveachievement_wrapper("ZM_MANSION_ARTIFACT", 1);
}

/*
	Name: function_783dcd31
	Namespace: mansion_achievements
	Checksum: 0x1D77B38C
	Offset: 0x7A0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_783dcd31()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_4505abb76e48700a");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_STAKE", 0);
}

/*
	Name: function_87a4fba4
	Namespace: mansion_achievements
	Checksum: 0xB1EA89CF
	Offset: 0x840
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_87a4fba4()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_1ac06d8c0149a66c");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_BOARD", 0);
}

/*
	Name: function_51328dc2
	Namespace: mansion_achievements
	Checksum: 0xEEA03F78
	Offset: 0x8E0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_51328dc2()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_6938bc311a1a893e");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_BITE", 0);
}

/*
	Name: function_f4b6212
	Namespace: mansion_achievements
	Checksum: 0x7F79B755
	Offset: 0x980
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_f4b6212()
{
	level endon(#"end_game", #"hash_691d769f8aa3dcbd");
	level waittill(#"hash_3464fd1132f34721");
	/#
		iprintlnbold("");
	#/
	zm_utility::giveachievement_wrapper("ZM_MANSION_QUICK", 1);
}

/*
	Name: function_c91cfd5a
	Namespace: mansion_achievements
	Checksum: 0x479CCD84
	Offset: 0xA10
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_c91cfd5a()
{
	level endon(#"end_game");
	for(var_532a9491 = 0; var_532a9491 < 3; var_532a9491++)
	{
		level waittill(#"hash_144b3192f03325f3");
	}
	/#
		iprintlnbold("");
	#/
	zm_utility::giveachievement_wrapper("ZM_MANSION_ALCHEMICAL", 1);
}

/*
	Name: function_a46f4413
	Namespace: mansion_achievements
	Checksum: 0xCF8C0904
	Offset: 0xAB8
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_a46f4413()
{
	level endon(#"end_game");
	level.var_f5ad5bac = 0;
	level thread function_8dc740fa("zblueprint_mansion_silver_molten");
	level thread function_8dc740fa("zblueprint_mansion_ww_lvl2");
	level thread function_8dc740fa("zblueprint_chaos_lvl3");
	level thread function_8dc740fa("zblueprint_shield_dual_wield");
	level thread function_8dc740fa("zblueprint_mansion_silver_bullet");
	level thread function_8dc740fa("zblueprint_mansion_a_skeet_fink");
	while(true)
	{
		level waittill(#"crafting_table_completed");
		if(level.var_f5ad5bac >= 6)
		{
			/#
				iprintlnbold("");
			#/
			zm_utility::giveachievement_wrapper("ZM_MANSION_CRAFTING", 1);
			break;
		}
	}
}

/*
	Name: function_8dc740fa
	Namespace: mansion_achievements
	Checksum: 0xC803CFBD
	Offset: 0xC28
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_8dc740fa(var_c75beecc)
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"blueprint_completed");
		if(waitresult.blueprint.name === var_c75beecc)
		{
			level.var_f5ad5bac++;
			level notify(#"crafting_table_completed");
			break;
		}
	}
}

/*
	Name: function_e1ae38eb
	Namespace: mansion_achievements
	Checksum: 0x64218D85
	Offset: 0xCB8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_e1ae38eb()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_510f9114e7a6300c");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_SHOCKING", 0);
}

/*
	Name: function_dd592c16
	Namespace: mansion_achievements
	Checksum: 0x280BED59
	Offset: 0xD58
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_dd592c16()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_305ca852d958a7e1");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_CLOCK", 0);
}

/*
	Name: function_18c92a4f
	Namespace: mansion_achievements
	Checksum: 0x5B3CD14C
	Offset: 0xDF8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_18c92a4f()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_148a0d55a59ee6a3");
	/#
		iprintlnbold("" + self getentnum());
	#/
	self zm_utility::giveachievement_wrapper("ZM_MANSION_SHRINKING", 0);
}

