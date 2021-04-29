// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_24c32478acf44108;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_perk_widows_wine;

/*
	Name: function_89f2df9
	Namespace: zm_perk_widows_wine
	Checksum: 0x5957E02D
	Offset: 0x280
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_widows_wine
	Checksum: 0x29C22469
	Offset: 0x2C8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_widows_wine_perk_for_level();
	namespace_9ff9f642::register_slowdown(#"hash_54016f8b03c9745e", 0.7, 12);
	namespace_9ff9f642::register_slowdown(#"hash_6b28a9e80349ad7e", 0.8, 6);
	namespace_9ff9f642::register_slowdown(#"hash_fa4899571ae8dbd", 0.85, 3);
}

/*
	Name: enable_widows_wine_perk_for_level
	Namespace: zm_perk_widows_wine
	Checksum: 0x650B8F39
	Offset: 0x378
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function enable_widows_wine_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_widowswine", #"perk_widows_wine", 3000, #"hash_618fdb0398552569", getweapon("zombie_perk_bottle_widows_wine"), getweapon("zombie_perk_totem_winters_wail"), #"hash_557e3edd7fe168c3");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_widowswine", #"perk_widows_wine", 3000, #"hash_1f1fee07c5d4d403", getweapon("zombie_perk_bottle_widows_wine"), getweapon("zombie_perk_totem_winters_wail"), #"hash_557e3edd7fe168c3");
	}
	zm_perks::register_perk_precache_func(#"specialty_widowswine", &widows_wine_precache);
	zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_register_clientfield, &widows_wine_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_widowswine", &widows_wine_perk_machine_setup);
	zm_perks::register_perk_host_migration_params(#"specialty_widowswine", "vending_widowswine", "widow_light");
	zm_perks::register_perk_threads(#"specialty_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost, &function_46ad87c9);
	if(isdefined(level.custom_widows_wine_perk_threads) && level.custom_widows_wine_perk_threads)
	{
		level thread [[level.custom_widows_wine_perk_threads]]();
	}
	init_widows_wine();
}

/*
	Name: widows_wine_precache
	Namespace: zm_perk_widows_wine
	Checksum: 0xBEA38452
	Offset: 0x608
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function widows_wine_precache()
{
	if(isdefined(level.widows_wine_precache_override_func))
	{
		[[level.widows_wine_precache_override_func]]();
		return;
	}
	level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
	level.machine_assets[#"specialty_widowswine"] = spawnstruct();
	level.machine_assets[#"specialty_widowswine"].weapon = getweapon("zombie_perk_bottle_widows_wine");
	level.machine_assets[#"specialty_widowswine"].off_model = "p7_zm_vending_widows_wine";
	level.machine_assets[#"specialty_widowswine"].on_model = "p7_zm_vending_widows_wine";
}

/*
	Name: widows_wine_register_clientfield
	Namespace: zm_perk_widows_wine
	Checksum: 0x56AB410B
	Offset: 0x718
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function widows_wine_register_clientfield()
{
	clientfield::register("actor", "winters_wail_freeze", 1, 1, "int");
	clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int");
	clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter");
	clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int");
}

/*
	Name: widows_wine_set_clientfield
	Namespace: zm_perk_widows_wine
	Checksum: 0xFC563630
	Offset: 0x7E8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function widows_wine_set_clientfield(state)
{
}

/*
	Name: widows_wine_perk_machine_setup
	Namespace: zm_perk_widows_wine
	Checksum: 0x533E902A
	Offset: 0x800
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function widows_wine_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_widow_jingle";
	use_trigger.script_string = "widowswine_perk";
	use_trigger.script_label = "mus_perks_widow_sting";
	use_trigger.target = "vending_widowswine";
	perk_machine.script_string = "widowswine_perk";
	perk_machine.targetname = "vending_widowswine";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "widowswine_perk";
	}
}

/*
	Name: init_widows_wine
	Namespace: zm_perk_widows_wine
	Checksum: 0xA4DB2912
	Offset: 0x8C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_widows_wine()
{
	zm_perks::register_perk_damage_override_func(&widows_wine_damage_callback);
}

/*
	Name: widows_wine_perk_activate
	Namespace: zm_perk_widows_wine
	Checksum: 0xFCDD800C
	Offset: 0x8F0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function widows_wine_perk_activate()
{
	self.var_828492e6 = zm_perks::function_c1efcc57(#"specialty_widowswine");
	self function_46ad87c9();
	self thread function_bcb4c0e3();
	self thread function_b2e5df58();
}

/*
	Name: widows_wine_contact_explosion
	Namespace: zm_perk_widows_wine
	Checksum: 0xDEF794D8
	Offset: 0x968
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function widows_wine_contact_explosion()
{
	self endon(#"disconnect");
	level endon(#"end_game");
	self clientfield::increment("winters_wail_explosion");
	a_ai_targets = self function_bdda420f(self.origin, 256);
	a_ai_targets = arraysortclosest(a_ai_targets, self.origin);
	foreach(ai_target in a_ai_targets)
	{
		var_ccc9bda1 = 0;
		if(!isdefined(ai_target))
		{
			continue;
		}
		if(!isdefined(ai_target.var_6f84b820))
		{
			continue;
		}
		switch(ai_target.var_6f84b820)
		{
			case "heavy":
			{
				var_3e5502b5 = #"hash_6b28a9e80349ad7e";
				var_ca6267ad = 6;
				break;
			}
			case "miniboss":
			{
				var_3e5502b5 = #"hash_fa4899571ae8dbd";
				var_ca6267ad = 3;
				break;
			}
			case "boss":
			{
				continue;
			}
			default:
			{
				var_3e5502b5 = #"hash_54016f8b03c9745e";
				var_ca6267ad = 12;
				var_ccc9bda1 = 1;
			}
		}
		n_dist_sq = distancesquared(self.origin, ai_target.origin);
		if(var_ccc9bda1 && n_dist_sq <= 10000)
		{
			ai_target thread function_5c114d09(self);
		}
		else
		{
			ai_target thread widows_wine_slow_zombie(self, var_3e5502b5, var_ca6267ad);
		}
		waitframe(1);
	}
	if(!self hasperk(#"specialty_widowswine"))
	{
		return;
	}
	self.var_a33a5a37--;
	self zm_perks::function_2ac7579(self.var_828492e6, 2, #"perk_widows_wine");
	self zm_perks::function_f2ff97a6(self.var_828492e6, self.var_a33a5a37, #"perk_widows_wine");
	if(self hasperk(#"hash_14e2498426fadea3"))
	{
		self thread function_c6366dbe();
	}
}

/*
	Name: function_c6366dbe
	Namespace: zm_perk_widows_wine
	Checksum: 0x7E47A5
	Offset: 0xCB0
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function function_c6366dbe()
{
	self notify(#"start_slow_field");
	self endon_callback(&function_10519783, #"disconnect", #"player_downed", #"start_slow_field");
	level endon_callback(&function_10519783, #"end_game");
	n_end_time = gettime() + int(5 * 1000);
	self clientfield::set("winters_wail_slow_field", 1);
	while(gettime() < n_end_time)
	{
		a_ai = self function_bdda420f(self.origin, 256);
		foreach(ai in a_ai)
		{
			if(!isdefined(ai.var_6f84b820))
			{
				continue;
			}
			switch(ai.var_6f84b820)
			{
				case "heavy":
				{
					var_3e5502b5 = #"hash_6b28a9e80349ad7e";
					var_ca6267ad = 6;
					break;
				}
				case "miniboss":
				{
					var_3e5502b5 = #"hash_fa4899571ae8dbd";
					var_ca6267ad = 3;
					break;
				}
				case "boss":
				{
					continue;
				}
				default:
				{
					var_3e5502b5 = #"hash_54016f8b03c9745e";
					var_ca6267ad = 12;
				}
			}
			ai thread widows_wine_slow_zombie(self, var_3e5502b5, var_ca6267ad);
		}
		wait(0.1);
	}
	self thread function_10519783();
}

/*
	Name: function_10519783
	Namespace: zm_perk_widows_wine
	Checksum: 0x7FC7C834
	Offset: 0xF50
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_10519783(var_c34665fc)
{
	if(isdefined(var_c34665fc) && (var_c34665fc == "disconnect" || var_c34665fc == "start_slow_field"))
	{
		return;
	}
	if(isplayer(self))
	{
		self clientfield::set("winters_wail_slow_field", 0);
	}
	else
	{
		array::thread_all(level.players, &clientfield::set, "winters_wail_slow_field", 0);
	}
}

/*
	Name: widows_wine_vehicle_damage_response
	Namespace: zm_perk_widows_wine
	Checksum: 0x5E939DD4
	Offset: 0x1000
	Size: 0xDC
	Parameters: 15
	Flags: None
*/
function widows_wine_vehicle_damage_response(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(weapon) && weapon == level.w_widows_wine_grenade && (!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)))
	{
		self thread widows_wine_vehicle_behavior(eattacker, weapon);
		return 0;
	}
	return idamage;
}

/*
	Name: widows_wine_damage_callback
	Namespace: zm_perk_widows_wine
	Checksum: 0xD40D0AEC
	Offset: 0x10E8
	Size: 0x174
	Parameters: 10
	Flags: Linked
*/
function widows_wine_damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(self hasperk(#"specialty_widowswine") && self function_8363e820() && !self bgb::is_enabled(#"zm_bgb_burned_out"))
	{
		if(smeansofdeath == "MOD_MELEE" && isai(eattacker) || (smeansofdeath == "MOD_EXPLOSIVE" && isvehicle(eattacker)))
		{
			if(level.gamedifficulty == 3 || (!(isdefined(eattacker.var_1c33120d) && eattacker.var_1c33120d) && self.maxhealth != self.health))
			{
				self thread widows_wine_contact_explosion();
			}
		}
	}
}

/*
	Name: function_5c114d09
	Namespace: zm_perk_widows_wine
	Checksum: 0x41C8388A
	Offset: 0x1268
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_5c114d09(e_player)
{
	self notify(#"widows_wine_cocoon");
	self endon(#"widows_wine_cocoon");
	if(isdefined(self.kill_on_wine_coccon) && self.kill_on_wine_coccon)
	{
		self kill();
		return;
	}
	if(!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon))
	{
		self.b_widows_wine_cocoon = 1;
		self.e_widows_wine_player = e_player;
		self namespace_9ff9f642::freeze();
		self.var_e8920729 = 1;
		self clientfield::set("winters_wail_freeze", 1);
	}
	self waittill_timeout(16, #"death");
	if(!isdefined(self))
	{
		return;
	}
	self namespace_9ff9f642::unfreeze();
	self.b_widows_wine_cocoon = undefined;
	self.var_e8920729 = 0;
	if(!(isdefined(self.b_widows_wine_slow) && self.b_widows_wine_slow))
	{
		self clientfield::set("winters_wail_freeze", 0);
	}
}

/*
	Name: widows_wine_slow_zombie
	Namespace: zm_perk_widows_wine
	Checksum: 0x763058B6
	Offset: 0x13D8
	Size: 0x13C
	Parameters: 3
	Flags: Linked
*/
function widows_wine_slow_zombie(e_player, var_3e5502b5, var_ca6267ad)
{
	self notify(#"widows_wine_slow");
	self endon(#"widows_wine_slow");
	if(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)
	{
		self thread function_5c114d09(e_player);
		self.b_widows_wine_slow = undefined;
		return;
	}
	if(!(isdefined(self.b_widows_wine_slow) && self.b_widows_wine_slow))
	{
		self.b_widows_wine_slow = 1;
		self clientfield::set("winters_wail_freeze", 1);
	}
	self thread namespace_9ff9f642::slowdown(var_3e5502b5);
	self waittill_timeout(var_ca6267ad, #"death");
	if(!isdefined(self))
	{
		return;
	}
	self.b_widows_wine_slow = undefined;
	if(!(isdefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon))
	{
		self clientfield::set("winters_wail_freeze", 0);
	}
}

/*
	Name: widows_wine_vehicle_behavior
	Namespace: zm_perk_widows_wine
	Checksum: 0x6A54D495
	Offset: 0x1520
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function widows_wine_vehicle_behavior(attacker, weapon)
{
	self endon(#"death");
	self.b_widows_wine_cocoon = 1;
	if(isdefined(self.archetype))
	{
		if(self.archetype == #"raps")
		{
			self clientfield::set("winters_wail_freeze", 1);
			self._override_raps_combat_speed = 5;
			wait(6);
			self dodamage(self.health + 1000, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, weapon);
		}
		else if(self.archetype == #"parasite")
		{
			waitframe(1);
			self dodamage(self.maxhealth, self.origin);
		}
	}
}

/*
	Name: widows_wine_perk_lost
	Namespace: zm_perk_widows_wine
	Checksum: 0xF04F4F2F
	Offset: 0x1650
	Size: 0xDE
	Parameters: 4
	Flags: Linked
*/
function widows_wine_perk_lost(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	self notify(#"stop_widows_wine");
	self endon(#"death");
	/#
		assert(isdefined(self.var_828492e6), "");
	#/
	if(isdefined(self.var_828492e6))
	{
		self zm_perks::function_13880aa5(self.var_828492e6, 0, #"perk_widows_wine");
		self zm_perks::function_f2ff97a6(self.var_828492e6, 0, #"perk_widows_wine");
		self.var_828492e6 = undefined;
	}
}

/*
	Name: function_8363e820
	Namespace: zm_perk_widows_wine
	Checksum: 0x7DF9290B
	Offset: 0x1738
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function function_8363e820()
{
	if(isdefined(self.var_a33a5a37) && self.var_a33a5a37 > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_fc256a55
	Namespace: zm_perk_widows_wine
	Checksum: 0xBF457BBD
	Offset: 0x1768
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function function_fc256a55()
{
	if(self hasperk(#"hash_14e2498426fadea3"))
	{
		return 4;
	}
	return 3;
}

/*
	Name: function_276e3360
	Namespace: zm_perk_widows_wine
	Checksum: 0x199D0DB4
	Offset: 0x17A0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_276e3360()
{
	n_total_charges = self function_fc256a55();
	return 1 / n_total_charges;
}

/*
	Name: function_bcb4c0e3
	Namespace: zm_perk_widows_wine
	Checksum: 0xA8A4446F
	Offset: 0x17E0
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function function_bcb4c0e3()
{
	self endon(#"stop_widows_wine", #"death");
	while(true)
	{
		wait(1);
		n_total_charges = self function_fc256a55();
		if(self.var_a33a5a37 < n_total_charges)
		{
			self.var_8376b1a = self.var_8376b1a + 1 / 60;
			if(self.var_8376b1a >= 1)
			{
				self.var_a33a5a37++;
				self.var_8376b1a = 0;
			}
		}
		else if(self.var_a33a5a37 > n_total_charges)
		{
			self.var_a33a5a37 = n_total_charges;
		}
		self function_2de8f9a5();
	}
}

/*
	Name: function_2de8f9a5
	Namespace: zm_perk_widows_wine
	Checksum: 0xDFDB2642
	Offset: 0x18D8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_2de8f9a5()
{
	if(self hasperk(#"specialty_widowswine"))
	{
		self zm_perks::function_f2ff97a6(self.var_828492e6, self.var_a33a5a37, #"perk_widows_wine");
		n_progress = self.var_8376b1a;
		if(self.var_a33a5a37 == self function_fc256a55())
		{
			n_progress = 1;
			self zm_perks::function_2ac7579(self.var_828492e6, 1, #"perk_widows_wine");
		}
		else
		{
			self zm_perks::function_2ac7579(self.var_828492e6, 2, #"perk_widows_wine");
		}
		self zm_perks::function_13880aa5(self.var_828492e6, n_progress, #"perk_widows_wine");
	}
}

/*
	Name: function_46ad87c9
	Namespace: zm_perk_widows_wine
	Checksum: 0x9145398D
	Offset: 0x1A10
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_46ad87c9()
{
	self.var_8376b1a = 0;
	self.var_a33a5a37 = self function_fc256a55();
	self function_2de8f9a5();
}

/*
	Name: function_b2e5df58
	Namespace: zm_perk_widows_wine
	Checksum: 0x14BC7E4F
	Offset: 0x1A58
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_b2e5df58()
{
	self endon(#"stop_widows_wine", #"death");
	while(true)
	{
		level waittill(#"end_of_round");
		self function_46ad87c9();
	}
}

