// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;

#namespace namespace_7b77c0bc;

/*
	Name: function_89f2df9
	Namespace: namespace_7b77c0bc
	Checksum: 0x8C455F1F
	Offset: 0x1B8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6a84119b30b658cb", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7b77c0bc
	Checksum: 0x72BDF971
	Offset: 0x208
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_707471ee();
}

/*
	Name: __main__
	Namespace: namespace_7b77c0bc
	Checksum: 0x80F724D1
	Offset: 0x228
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_707471ee
	Namespace: namespace_7b77c0bc
	Checksum: 0xDE0053D4
	Offset: 0x238
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function function_707471ee()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"hash_5b141f82a55645a9", #"hash_e58ff2df5bfd9b3", 4000, #"hash_4f7614bf7bd645c8", getweapon("zombie_perk_bottle_dying_wish"), getweapon("zombie_perk_totem_dying_wish"), #"hash_31b19618ca4f41");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_5b141f82a55645a9", #"hash_e58ff2df5bfd9b3", 4000, #"hash_249546bf5f378924", getweapon("zombie_perk_bottle_dying_wish"), getweapon("zombie_perk_totem_dying_wish"), #"hash_31b19618ca4f41");
	}
	zm_perks::register_perk_precache_func(#"hash_5b141f82a55645a9", &function_aa1c61e);
	zm_perks::register_perk_clientfields(#"hash_5b141f82a55645a9", &function_bee10d1f, &function_dbf100ee);
	zm_perks::register_perk_machine(#"hash_5b141f82a55645a9", &function_32b9bac, &function_536f842f);
	zm_perks::register_perk_host_migration_params(#"hash_5b141f82a55645a9", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"hash_5b141f82a55645a9", &function_2aefd3c4, &function_f3862b9b, &function_9227a4d8);
	zm_player::function_a827358a(&function_a102936);
	zm_perks::function_430970f6(#"hash_5b141f82a55645a9", &function_ab41c8ab);
}

/*
	Name: function_536f842f
	Namespace: namespace_7b77c0bc
	Checksum: 0x80F724D1
	Offset: 0x4E0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_536f842f()
{
}

/*
	Name: function_aa1c61e
	Namespace: namespace_7b77c0bc
	Checksum: 0x6E03A58
	Offset: 0x4F0
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_aa1c61e()
{
	if(isdefined(level.var_d1c19f4e))
	{
		[[level.var_d1c19f4e]]();
		return;
	}
	level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
	level.machine_assets[#"hash_5b141f82a55645a9"] = spawnstruct();
	level.machine_assets[#"hash_5b141f82a55645a9"].weapon = getweapon("zombie_perk_bottle_dying_wish");
	level.machine_assets[#"hash_5b141f82a55645a9"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"hash_5b141f82a55645a9"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_bee10d1f
	Namespace: namespace_7b77c0bc
	Checksum: 0x6ABB156
	Offset: 0x608
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_bee10d1f()
{
	clientfield::register("allplayers", "" + #"hash_10f459edea6b3eb", 1, 1, "int");
}

/*
	Name: function_dbf100ee
	Namespace: namespace_7b77c0bc
	Checksum: 0x4B15037C
	Offset: 0x658
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_dbf100ee(state)
{
}

/*
	Name: function_32b9bac
	Namespace: namespace_7b77c0bc
	Checksum: 0x7A9B208B
	Offset: 0x670
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_32b9bac(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_phd_jingle";
	use_trigger.script_string = "divetonuke_perk";
	use_trigger.script_label = "mus_perks_phd_sting";
	use_trigger.target = "vending_divetonuke";
	perk_machine.script_string = "divetonuke_perk";
	perk_machine.targetname = "vending_divetonuke";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "divetonuke_perk";
	}
}

/*
	Name: function_d1c19f4e
	Namespace: namespace_7b77c0bc
	Checksum: 0x30624A35
	Offset: 0x730
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function function_d1c19f4e()
{
	level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
}

/*
	Name: function_2aefd3c4
	Namespace: namespace_7b77c0bc
	Checksum: 0xD1BDE0C6
	Offset: 0x770
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_2aefd3c4()
{
	self.var_95df0a1b = zm_perks::function_c1efcc57(#"hash_5b141f82a55645a9");
	if(isdefined(self.var_a4630f64) && self.var_a4630f64 && isdefined(self.var_95df0a1b))
	{
		self zm_perks::function_2ac7579(self.var_95df0a1b, 2, #"hash_e58ff2df5bfd9b3");
	}
	if(!isdefined(self.var_a4630f64))
	{
		self.var_a4630f64 = 0;
	}
	if(!isdefined(self.var_30d7498d))
	{
		self.var_30d7498d = 1;
	}
	if(!isdefined(self.var_740ffad6))
	{
		self.var_740ffad6 = 540;
	}
}

/*
	Name: function_f3862b9b
	Namespace: namespace_7b77c0bc
	Checksum: 0x62A23B45
	Offset: 0x850
	Size: 0xD6
	Parameters: 4
	Flags: Linked
*/
function function_f3862b9b(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_5b141f82a55645a9" + "_take");
	if(isdefined(self.var_eb319d10) && self.var_eb319d10)
	{
		self function_2ca96414();
	}
	/#
		assert(isdefined(self.var_95df0a1b), "");
	#/
	if(isdefined(self.var_95df0a1b))
	{
		self zm_perks::function_13880aa5(self.var_95df0a1b, 0, #"hash_e58ff2df5bfd9b3");
		self.var_95df0a1b = undefined;
	}
}

/*
	Name: function_a102936
	Namespace: namespace_7b77c0bc
	Checksum: 0x503A9531
	Offset: 0x930
	Size: 0xF0
	Parameters: 10
	Flags: Linked
*/
function function_a102936(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(self hasperk(#"hash_5b141f82a55645a9"))
	{
		if(idamage >= self.health && !self.var_a4630f64 && self.var_eb319d10 !== 1)
		{
			self thread function_d752a094();
			return self.health - 1;
		}
		if(isdefined(self.var_eb319d10) && self.var_eb319d10)
		{
			return 0;
		}
	}
	return -1;
}

/*
	Name: function_eeb3bf92
	Namespace: namespace_7b77c0bc
	Checksum: 0x67C1A3C6
	Offset: 0xA28
	Size: 0x178
	Parameters: 1
	Flags: Linked
*/
function function_eeb3bf92(var_1483b30b)
{
	level endon(#"round_reset");
	self endon(#"disconnect", #"hash_5b141f82a55645a9" + "_take");
	n_time_left = var_1483b30b;
	self zm_perks::function_13880aa5(self.var_95df0a1b, 1, #"hash_e58ff2df5bfd9b3");
	while(n_time_left > 0)
	{
		wait(0.1);
		n_time_left = n_time_left - 0.1;
		n_time_left = math::clamp(n_time_left, 0, var_1483b30b);
		n_percentage = n_time_left / var_1483b30b;
		n_percentage = math::clamp(n_percentage, 0.02, var_1483b30b);
		if(self hasperk(#"hash_5b141f82a55645a9") && isdefined(self.var_95df0a1b))
		{
			self zm_perks::function_13880aa5(self.var_95df0a1b, n_percentage, #"hash_e58ff2df5bfd9b3");
		}
	}
}

/*
	Name: function_d752a094
	Namespace: namespace_7b77c0bc
	Checksum: 0x14DDDF20
	Offset: 0xBA8
	Size: 0x17E
	Parameters: 0
	Flags: Linked
*/
function function_d752a094()
{
	self endon(#"disconnect", #"hash_5b141f82a55645a9" + "_take");
	self val::set(#"hash_6c80da4b37fb1000", "takedamage", 0);
	self val::set(#"hash_6c80da4b37fb1000", "health_regen", 0);
	self.var_eb319d10 = 1;
	self zm_perks::function_f0ac059f(self.var_95df0a1b, self.var_eb319d10, #"hash_e58ff2df5bfd9b3");
	self thread function_eeb3bf92(10);
	self clientfield::set("" + #"hash_10f459edea6b3eb", 1);
	self waittill_timeout(10, #"fake_death", #"hash_57d4f53c12705eac");
	self function_2ca96414();
	if(self hasperk(#"hash_48255a3b086a9bea"))
	{
		self.health = self.var_66cb03ad;
	}
}

/*
	Name: function_2ca96414
	Namespace: namespace_7b77c0bc
	Checksum: 0x165E3E7B
	Offset: 0xD30
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_2ca96414()
{
	self val::reset(#"hash_6c80da4b37fb1000", "takedamage");
	self val::reset(#"hash_6c80da4b37fb1000", "health_regen");
	self.var_eb319d10 = undefined;
	self zm_perks::function_f0ac059f(self.var_95df0a1b, self.var_eb319d10, #"hash_e58ff2df5bfd9b3");
	self thread function_d2bbaa76(self.var_740ffad6);
	self.var_30d7498d++;
	self.var_740ffad6 = self.var_740ffad6 + (60 * self.var_30d7498d);
	self clientfield::set("" + #"hash_10f459edea6b3eb", 0);
}

/*
	Name: function_ab41c8ab
	Namespace: namespace_7b77c0bc
	Checksum: 0x76D01A40
	Offset: 0xE40
	Size: 0x18E
	Parameters: 12
	Flags: Linked
*/
function function_ab41c8ab(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker.var_eb319d10) && attacker.var_eb319d10 && meansofdeath === "MOD_MELEE")
	{
		damage = damage * 6;
		if(!isdefined(self.var_6f84b820))
		{
			return damage;
		}
		switch(self.var_6f84b820)
		{
			case "popcorn":
			case "basic":
			case "enhanced":
			{
				self zombie_utility::gib_random_parts();
				gibserverutils::annihilate(self);
				damage = self.health;
				break;
			}
			case "heavy":
			case "miniboss":
			case "boss":
			{
				damage = damage + 7000;
				break;
			}
		}
	}
	return damage;
}

/*
	Name: function_d2bbaa76
	Namespace: namespace_7b77c0bc
	Checksum: 0xB8692F0
	Offset: 0xFD8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_d2bbaa76(var_85dcb56c)
{
	self endon(#"hash_ed7c0dc0ca165df", #"disconnect");
	self.var_a4630f64 = 1;
	if(self hasperk(#"hash_5b141f82a55645a9") && isdefined(self.var_95df0a1b))
	{
		self zm_perks::function_2ac7579(self.var_95df0a1b, 2, #"hash_e58ff2df5bfd9b3");
	}
	self thread function_7d72c6f9(var_85dcb56c);
	wait(var_85dcb56c);
	self thread function_9227a4d8();
}

/*
	Name: function_7d72c6f9
	Namespace: namespace_7b77c0bc
	Checksum: 0x8AD13F34
	Offset: 0x10B0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_7d72c6f9(var_85dcb56c)
{
	self endon(#"disconnect", #"hash_ed7c0dc0ca165df");
	self.var_3e48c35a = var_85dcb56c;
	self zm_perks::function_13880aa5(self.var_95df0a1b, 0, #"hash_e58ff2df5bfd9b3");
	while(true)
	{
		wait(0.1);
		self.var_3e48c35a = self.var_3e48c35a - 0.1;
		self.var_3e48c35a = math::clamp(self.var_3e48c35a, 0, var_85dcb56c);
		n_percentage = 1 - (self.var_3e48c35a / var_85dcb56c);
		n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);
		if(self hasperk(#"hash_5b141f82a55645a9") && isdefined(self.var_95df0a1b))
		{
			self zm_perks::function_13880aa5(self.var_95df0a1b, n_percentage, #"hash_e58ff2df5bfd9b3");
		}
	}
}

/*
	Name: function_9227a4d8
	Namespace: namespace_7b77c0bc
	Checksum: 0x569244F1
	Offset: 0x1218
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_9227a4d8()
{
	self notify(#"hash_ed7c0dc0ca165df");
	self.var_a4630f64 = 0;
	if(self hasperk(#"hash_5b141f82a55645a9"))
	{
		/#
			assert(isdefined(self.var_95df0a1b), "");
		#/
		if(isdefined(self.var_95df0a1b))
		{
			self zm_perks::function_2ac7579(self.var_95df0a1b, 1, #"hash_e58ff2df5bfd9b3");
			self zm_perks::function_13880aa5(self.var_95df0a1b, 1, #"hash_e58ff2df5bfd9b3");
		}
	}
}

