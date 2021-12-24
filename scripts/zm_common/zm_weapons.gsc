// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1ac263b07ef50ab6;
#using script_2f09d8055b480c9c;
#using script_3f9e0dc8454d98e1;
#using script_43642da1b2402e5c;
#using script_47fb62300ac0bd60;
#using script_56ca01b3b31455b5;
#using script_5b18db57724ff7be;
#using script_63a86ef12b120b23;
#using script_676d3a2160d92de8;
#using script_6e3c826b1814cab6;
#using script_7133a4d461308099;
#using script_7224d61ed502ea07;
#using script_7bafaa95bb1b427e;
#using script_7fbcea48606829db;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\gametypes\globallogic_utils.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_weapons;

/*
	Name: function_89f2df9
	Namespace: zm_weapons
	Checksum: 0xD9A7FB13
	Offset: 0x290
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weapons
	Checksum: 0x7DF4F7E8
	Offset: 0x2E0
	Size: 0x166
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level flag::init("zm_weapons_table_loaded");
	level.weaponnone = getweapon(#"none");
	level.weaponnull = getweapon(#"weapon_null");
	level.var_78032351 = getweapon(#"defaultweapon");
	level.weaponbasemelee = getweapon(#"knife");
	if(!isdefined(level.zombie_weapons))
	{
		level.zombie_weapons = [];
	}
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	level.limited_weapons = [];
	function_ec38915a();
	level.var_51443ce5 = &get_player_weapondata;
	level.var_bfbdc0cd = &weapondata_give;
	level.var_ee5c0b6e = &function_93cd8e76;
}

/*
	Name: __main__
	Namespace: zm_weapons
	Checksum: 0x83D34315
	Offset: 0x450
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	init();
}

/*
	Name: init
	Namespace: zm_weapons
	Checksum: 0x23799BA0
	Offset: 0x470
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!isdefined(level.pack_a_punch_camo_index))
	{
		level.pack_a_punch_camo_index = 42;
	}
	level.primary_weapon_array = [];
	level.side_arm_array = [];
	level.grenade_array = [];
	level.inventory_array = [];
	init_weapons();
	level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: zm_weapons
	Checksum: 0xA9D9031A
	Offset: 0x518
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self thread watchforgrenadeduds();
	self thread watchforgrenadelauncherduds();
	self.staticweaponsstarttime = gettime();
	if(!isdefined(self.var_f6d3c3))
	{
		self.var_f6d3c3 = [];
	}
}

/*
	Name: function_ec38915a
	Namespace: zm_weapons
	Checksum: 0x868CCC04
	Offset: 0x578
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_ec38915a()
{
	if(!isdefined(level.var_5a069e6))
	{
		level.var_5a069e6 = [];
	}
	if(!isdefined(level.var_44e0d625))
	{
		level.var_44e0d625 = [];
	}
	function_8005e7f3(getweapon(#"smg_handling_t8"), getweapon(#"hash_1b055fadc5573c29"));
	function_8005e7f3(getweapon(#"hash_514128f7d058cde0"), getweapon(#"hash_3b34bf98ebd70d14"));
	function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw"), getweapon(#"special_ballisticknife_t8_dw_dw"));
	function_8005e7f3(getweapon(#"hash_3882e337d28ec4df"), getweapon(#"special_ballisticknife_t8_dw_upgraded_dw"));
}

/*
	Name: function_8005e7f3
	Namespace: zm_weapons
	Checksum: 0x6C786F73
	Offset: 0x708
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function function_8005e7f3(w_base, var_ebc2aad)
{
	if(w_base != level.weaponnone && var_ebc2aad != level.weaponnone)
	{
		level.var_5a069e6[w_base] = var_ebc2aad;
		level.var_44e0d625[var_ebc2aad] = w_base;
	}
}

/*
	Name: player_gunchallengecomplete
	Namespace: zm_weapons
	Checksum: 0xA9D92E3D
	Offset: 0x780
	Size: 0x1BC
	Parameters: 1
	Flags: Event
*/
event player_gunchallengecomplete(s_event)
{
	if(s_event.is_lastrank)
	{
		var_8e617ca1 = 0;
		var_4e81c501 = function_efd851e();
		foreach(weapon in var_4e81c501)
		{
			str_weapon = weapon.name;
			var_c0ba2963 = getbaseweaponitemindex(weapon);
			var_cc074f5b = stats::get_stat(#"hash_60e21f66eb3a1f18", str_weapon, #"xp");
			if(isdefined(var_cc074f5b))
			{
				var_6b792d1d = function_33cc663e(str_weapon);
				var_56ccc9fe = stats::get_stat(#"hash_60e21f66eb3a1f18", str_weapon, #"plevel");
				if(var_cc074f5b >= var_6b792d1d || var_56ccc9fe >= 1)
				{
					var_8e617ca1++;
				}
			}
		}
		if(var_8e617ca1 >= 25)
		{
			zm_utility::giveachievement_wrapper("zm_trophy_gold");
		}
	}
}

/*
	Name: function_efd851e
	Namespace: zm_weapons
	Checksum: 0x839431EB
	Offset: 0x948
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_efd851e()
{
	var_4e81c501 = [];
	foreach(s_weapon in level.zombie_weapons)
	{
		switch(s_weapon.weapon_classname)
		{
			case 0:
			case "equipment":
			case "shield":
			case "melee":
			{
				continue;
			}
		}
		if(is_wonder_weapon(s_weapon.weapon))
		{
			continue;
		}
		if(!isdefined(var_4e81c501))
		{
			var_4e81c501 = [];
		}
		else if(!isarray(var_4e81c501))
		{
			var_4e81c501 = array(var_4e81c501);
		}
		var_4e81c501[var_4e81c501.size] = s_weapon.weapon;
	}
	return var_4e81c501;
}

/*
	Name: function_14590040
	Namespace: zm_weapons
	Checksum: 0x6F12F579
	Offset: 0xAA8
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_14590040(str_weapon)
{
	var_9bea1b6 = [];
	for(i = 0; i < 16; i++)
	{
		var_4a3def14 = tablelookup(#"hash_5ea60cf27bedfa51", 2, str_weapon, 0, i, 1);
		if("" == var_4a3def14)
		{
			break;
		}
		var_9bea1b6[i] = int(var_4a3def14);
	}
	return var_9bea1b6;
}

/*
	Name: function_33cc663e
	Namespace: zm_weapons
	Checksum: 0x1B654AF7
	Offset: 0xB68
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_33cc663e(str_weapon)
{
	var_9bea1b6 = function_14590040(str_weapon);
	return var_9bea1b6[var_9bea1b6.size - 1];
}

/*
	Name: watchforgrenadeduds
	Namespace: zm_weapons
	Checksum: 0x8AFC916A
	Offset: 0xBB0
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function watchforgrenadeduds()
{
	self endon(#"death", #"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(!zm_equipment::is_equipment(weapon) && !zm_loadout::is_placeable_mine(weapon))
		{
			grenade thread checkgrenadefordud(weapon, 1, self);
		}
	}
}

/*
	Name: watchforgrenadelauncherduds
	Namespace: zm_weapons
	Checksum: 0x2FE199F6
	Offset: 0xC90
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function watchforgrenadelauncherduds()
{
	self endon(#"death", #"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_launcher_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		grenade thread checkgrenadefordud(weapon, 0, self);
	}
}

/*
	Name: grenade_safe_to_throw
	Namespace: zm_weapons
	Checksum: 0xD45F590E
	Offset: 0xD40
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function grenade_safe_to_throw(player, weapon)
{
	if(isdefined(level.grenade_safe_to_throw))
	{
		return self [[level.grenade_safe_to_throw]](player, weapon);
	}
	return 1;
}

/*
	Name: grenade_safe_to_bounce
	Namespace: zm_weapons
	Checksum: 0xA4ECEF2C
	Offset: 0xD88
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function grenade_safe_to_bounce(player, weapon)
{
	if(isdefined(level.grenade_safe_to_bounce))
	{
		return self [[level.grenade_safe_to_bounce]](player, weapon);
	}
	return 1;
}

/*
	Name: makegrenadedudanddestroy
	Namespace: zm_weapons
	Checksum: 0x4718CBCA
	Offset: 0xDD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function makegrenadedudanddestroy()
{
	self endon(#"death");
	self notify(#"grenade_dud");
	self makegrenadedud();
	wait(3);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: checkgrenadefordud
	Namespace: zm_weapons
	Checksum: 0x63610DF7
	Offset: 0xE40
	Size: 0x102
	Parameters: 3
	Flags: Linked
*/
function checkgrenadefordud(weapon, isthrowngrenade, player)
{
	self endon(#"death");
	player endon(#"zombify");
	if(!isdefined(self))
	{
		return;
	}
	if(!self grenade_safe_to_throw(player, weapon))
	{
		self thread makegrenadedudanddestroy();
		return;
	}
	for(;;)
	{
		self waittill_timeout(0.25, #"grenade_bounce", #"stationary", #"death", #"zombify");
		if(!self grenade_safe_to_bounce(player, weapon))
		{
			self thread makegrenadedudanddestroy();
			return;
		}
	}
}

/*
	Name: get_nonalternate_weapon
	Namespace: zm_weapons
	Checksum: 0x460C80D9
	Offset: 0xF50
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function get_nonalternate_weapon(weapon)
{
	if(isdefined(weapon.isaltmode) && weapon.isaltmode)
	{
		return weapon.altweapon;
	}
	return weapon;
}

/*
	Name: function_af29d744
	Namespace: zm_weapons
	Checksum: 0x8F91C57F
	Offset: 0xF98
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_af29d744(weapon)
{
	if(isdefined(weapon))
	{
		if(weapon.isaltmode)
		{
			weapon = weapon.altweapon;
		}
		weapon = function_386dacbc(weapon);
	}
	return weapon;
}

/*
	Name: function_93cd8e76
	Namespace: zm_weapons
	Checksum: 0x1DCB32FC
	Offset: 0xFF0
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function function_93cd8e76(weapon, var_1011fc73 = 0)
{
	if(weapon.inventorytype == "dwlefthand")
	{
		weapon = weapon.dualwieldweapon;
	}
	weapon = function_af29d744(weapon);
	if(var_1011fc73 && isdefined(level.zombie_weapons_upgraded[weapon]))
	{
		return level.zombie_weapons_upgraded[weapon];
	}
	return weapon;
}

/*
	Name: switch_from_alt_weapon
	Namespace: zm_weapons
	Checksum: 0xA4861721
	Offset: 0x1090
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function switch_from_alt_weapon(weapon)
{
	if(weapon.ischargeshot)
	{
		return weapon;
	}
	alt = get_nonalternate_weapon(weapon);
	if(alt != weapon)
	{
		if(!weaponhasattachment(weapon, "dualoptic"))
		{
			self switchtoweaponimmediate(alt);
			self waittill_timeout(1, #"weapon_change_complete");
		}
		return alt;
	}
	return weapon;
}

/*
	Name: give_start_weapons
	Namespace: zm_weapons
	Checksum: 0xA606C387
	Offset: 0x1140
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function give_start_weapons(takeallweapons, alreadyspawned)
{
	if(isdefined(self.s_loadout) && zombie_utility::function_d2dfacfd("retain_weapons") && namespace_59ff1d6c::function_901b751c(#"hash_589c0366b1458c7e"))
	{
		self player_give_loadout(self.s_loadout, 1, 0);
		self.s_loadout = undefined;
	}
	else
	{
		self zm_loadout::give_start_weapon(1);
		self zm_loadout::init_player_offhand_weapons();
	}
}

/*
	Name: give_fallback_weapon
	Namespace: zm_weapons
	Checksum: 0xA8D7C786
	Offset: 0x1218
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function give_fallback_weapon(immediate = 0)
{
	zm_melee_weapon::give_fallback_weapon(immediate);
}

/*
	Name: take_fallback_weapon
	Namespace: zm_weapons
	Checksum: 0x48138B35
	Offset: 0x1250
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function take_fallback_weapon()
{
	zm_melee_weapon::take_fallback_weapon();
}

/*
	Name: switch_back_primary_weapon
	Namespace: zm_weapons
	Checksum: 0xBBD39943
	Offset: 0x1270
	Size: 0x254
	Parameters: 3
	Flags: Linked
*/
function switch_back_primary_weapon(oldprimary, immediate = 0, var_6d4494f9 = 0)
{
	if(isdefined(self.laststand) && self.laststand)
	{
		return;
	}
	if(!isdefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_loadout::is_melee_weapon(oldprimary) || zm_loadout::is_placeable_mine(oldprimary) || zm_loadout::is_lethal_grenade(oldprimary) || zm_loadout::is_tactical_grenade(oldprimary, !var_6d4494f9) || !self hasweapon(oldprimary))
	{
		oldprimary = undefined;
	}
	else if(oldprimary.isheroweapon || oldprimary.isgadget && (!isdefined(self.hero_power) || self.hero_power <= 0))
	{
		oldprimary = undefined;
	}
	primaryweapons = self getweaponslistprimaries();
	if(isdefined(oldprimary) && (isinarray(primaryweapons, oldprimary) || (oldprimary.isriotshield && var_6d4494f9)))
	{
		if(immediate)
		{
			self switchtoweaponimmediate(oldprimary);
		}
		else
		{
			self switchtoweapon(oldprimary);
		}
	}
	else if(primaryweapons.size > 0)
	{
		if(immediate)
		{
			self switchtoweaponimmediate();
		}
		else
		{
			self switchtoweapon();
		}
	}
	else
	{
		give_fallback_weapon(immediate);
	}
}

/*
	Name: updatelastheldweapontimingszm
	Namespace: zm_weapons
	Checksum: 0x7B4EFE42
	Offset: 0x14D0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function updatelastheldweapontimingszm(newtime)
{
	if(isdefined(self.currentweapon) && isdefined(self.currenttime))
	{
		curweapon = self.currentweapon;
		totaltime = int((newtime - self.currenttime) / 1000);
		if(totaltime > 0)
		{
			self stats::function_e24eec31(curweapon, #"timeused", totaltime);
		}
	}
}

/*
	Name: updateweapontimingszm
	Namespace: zm_weapons
	Checksum: 0xAC15C9C3
	Offset: 0x1578
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function updateweapontimingszm(newtime)
{
	if(isbot(self))
	{
		return;
	}
	updatelastheldweapontimingszm(newtime);
	if(!isdefined(self.staticweaponsstarttime))
	{
		return;
	}
	totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
	if(totaltime < 0)
	{
		return;
	}
	self.staticweaponsstarttime = newtime;
}

/*
	Name: default_check_firesale_loc_valid_func
	Namespace: zm_weapons
	Checksum: 0x3A274AAC
	Offset: 0x1610
	Size: 0x8
	Parameters: 0
	Flags: Linked
*/
function default_check_firesale_loc_valid_func()
{
	return 1;
}

/*
	Name: add_zombie_weapon
	Namespace: zm_weapons
	Checksum: 0xD1405F
	Offset: 0x1620
	Size: 0x3A0
	Parameters: 12
	Flags: Linked
*/
function add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier = 0, in_box)
{
	weapon = getweapon(weapon_name);
	upgrade = undefined;
	if(isdefined(upgrade_name))
	{
		upgrade = getweapon(upgrade_name);
	}
	if(isdefined(level.zombie_include_weapons) && !isdefined(level.zombie_include_weapons[weapon]))
	{
		return;
	}
	struct = spawnstruct();
	if(!isdefined(level.zombie_weapons))
	{
		level.zombie_weapons = [];
	}
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	if(isdefined(upgrade_name))
	{
		level.zombie_weapons_upgraded[upgrade] = weapon;
	}
	struct.weapon = weapon;
	struct.upgrade = upgrade;
	struct.weapon_classname = weapon_class;
	if(function_8b1a219a())
	{
		struct.hint = #"hash_2791ecebb85142c4";
	}
	else
	{
		struct.hint = #"hash_60606b68e93a29c8";
	}
	struct.cost = cost;
	struct.vox = weaponvo;
	struct.vox_response = weaponvoresp;
	struct.is_wonder_weapon = is_wonder_weapon;
	struct.tier = tier;
	/#
		println("" + function_9e72a96(weapon_name));
	#/
	struct.is_in_box = level.zombie_include_weapons[weapon];
	if(!isdefined(ammo_cost) || ammo_cost == 0)
	{
		ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
	}
	struct.ammo_cost = ammo_cost;
	if(weapon.isemp || (isdefined(upgrade) && upgrade.isemp))
	{
		level.should_watch_for_emp = 1;
	}
	level.zombie_weapons[weapon] = struct;
	/#
		if(isdefined(level.devgui_add_weapon) && (!is_ee || getdvarint(#"hash_11ad6a9695943217", 0)))
		{
			level thread [[level.devgui_add_weapon]](weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost);
		}
	#/
}

/*
	Name: is_weapon_included
	Namespace: zm_weapons
	Checksum: 0x546F926D
	Offset: 0x19C8
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function is_weapon_included(weapon)
{
	if(!isdefined(level.zombie_weapons))
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	return isdefined(level.zombie_weapons[function_386dacbc(weapon)]);
}

/*
	Name: is_weapon_or_base_included
	Namespace: zm_weapons
	Checksum: 0x13B76D7A
	Offset: 0x1A28
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function is_weapon_or_base_included(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	return isdefined(level.zombie_weapons[function_386dacbc(weapon)]) || isdefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

/*
	Name: include_zombie_weapon
	Namespace: zm_weapons
	Checksum: 0xEBAC861
	Offset: 0x1A98
	Size: 0x9A
	Parameters: 2
	Flags: Linked
*/
function include_zombie_weapon(weapon_name, in_box)
{
	if(!isdefined(level.zombie_include_weapons))
	{
		level.zombie_include_weapons = [];
	}
	if(!isdefined(in_box))
	{
		in_box = 1;
	}
	/#
		println("" + function_9e72a96(weapon_name));
	#/
	level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

/*
	Name: init_weapons
	Namespace: zm_weapons
	Checksum: 0x78B0ED04
	Offset: 0x1B40
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function init_weapons()
{
	level.var_c60359dc = [];
	var_8e01336 = getdvarint(#"hash_4fdf506c770b343", 0);
	switch(var_8e01336)
	{
		case 1:
		{
			var_4ef031c9 = #"hash_5694d3fa5334f8fe";
			break;
		}
		case 2:
		{
			var_4ef031c9 = #"hash_3f8d28bb3d9e9bec";
			break;
		}
		default:
		{
			var_4ef031c9 = #"hash_7bda40310359350e";
		}
	}
	load_weapon_spec_from_table(var_4ef031c9, 0);
	if(isdefined(level.var_d0ab70a2))
	{
		load_weapon_spec_from_table(level.var_d0ab70a2, 0);
	}
	level flag::set("zm_weapons_table_loaded");
	level.var_c60359dc = undefined;
}

/*
	Name: add_limited_weapon
	Namespace: zm_weapons
	Checksum: 0x6D5B4DEB
	Offset: 0x1C90
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function add_limited_weapon(weapon_name, amount)
{
	if(amount == 0)
	{
		return;
	}
	level.limited_weapons[getweapon(weapon_name)] = amount;
}

/*
	Name: limited_weapon_below_quota
	Namespace: zm_weapons
	Checksum: 0x86BD38B5
	Offset: 0x1CE8
	Size: 0x48C
	Parameters: 2
	Flags: Linked
*/
function limited_weapon_below_quota(weapon, ignore_player)
{
	if(isdefined(level.limited_weapons[weapon]))
	{
		var_83916b6 = undefined;
		if(!isdefined(var_83916b6))
		{
			var_83916b6 = getentarray("zm_pack_a_punch", "targetname");
		}
		if(isdefined(level.no_limited_weapons) && level.no_limited_weapons)
		{
			return 0;
		}
		upgradedweapon = weapon;
		if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade))
		{
			upgradedweapon = level.zombie_weapons[weapon].upgrade;
		}
		players = getplayers();
		count = 0;
		limit = level.limited_weapons[weapon];
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(ignore_player) && ignore_player == players[i])
			{
				continue;
			}
			if(players[i] has_weapon_or_upgrade(weapon))
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		foreach(machine in var_83916b6)
		{
			if(!isdefined(machine))
			{
				continue;
			}
			if(!isdefined(machine.unitrigger_stub))
			{
				continue;
			}
			if(isdefined(machine.unitrigger_stub.current_weapon) && (machine.unitrigger_stub.current_weapon == weapon || machine.unitrigger_stub.current_weapon == upgradedweapon))
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		foreach(chest in level.chests)
		{
			if(!isdefined(chest))
			{
				continue;
			}
			if(!isdefined(chest.zbarrier))
			{
				continue;
			}
			if(isdefined(chest.zbarrier.weapon) && chest.zbarrier.weapon == weapon)
			{
				count++;
				if(count >= limit)
				{
					return 0;
				}
			}
		}
		if(isdefined(level.custom_limited_weapon_checks))
		{
			foreach(check in level.custom_limited_weapon_checks)
			{
				count = count + [[check]](weapon);
			}
			if(count >= limit)
			{
				return 0;
			}
		}
		if(isdefined(level.random_weapon_powerups))
		{
			for(powerupindex = 0; powerupindex < level.random_weapon_powerups.size; powerupindex++)
			{
				if(isdefined(level.random_weapon_powerups[powerupindex]) && level.random_weapon_powerups[powerupindex].base_weapon == weapon)
				{
					count++;
					if(count >= limit)
					{
						return 0;
					}
				}
			}
		}
	}
	return 1;
}

/*
	Name: add_custom_limited_weapon_check
	Namespace: zm_weapons
	Checksum: 0xCD54F8E6
	Offset: 0x2180
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function add_custom_limited_weapon_check(callback)
{
	if(!isdefined(level.custom_limited_weapon_checks))
	{
		level.custom_limited_weapon_checks = [];
	}
	level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

/*
	Name: add_weapon_to_content
	Namespace: zm_weapons
	Checksum: 0xF18AE1C
	Offset: 0x21D0
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function add_weapon_to_content(weapon_name, package)
{
	if(!isdefined(level.content_weapons))
	{
		level.content_weapons = [];
	}
	level.content_weapons[getweapon(weapon_name)] = package;
}

/*
	Name: player_can_use_content
	Namespace: zm_weapons
	Checksum: 0xDC30A685
	Offset: 0x2238
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function player_can_use_content(weapon)
{
	if(isdefined(level.content_weapons))
	{
		if(isdefined(level.content_weapons[weapon]))
		{
			return self hasdlcavailable(level.content_weapons[weapon]);
		}
	}
	return 1;
}

/*
	Name: get_weapon_hint
	Namespace: zm_weapons
	Checksum: 0xBC708A55
	Offset: 0x2298
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function get_weapon_hint(weapon)
{
	/#
		/#
			assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "");
		#/
	#/
	return level.zombie_weapons[weapon].hint;
}

/*
	Name: get_weapon_cost
	Namespace: zm_weapons
	Checksum: 0xE0242ACE
	Offset: 0x2318
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function get_weapon_cost(weapon)
{
	/#
		/#
			assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "");
		#/
	#/
	return level.zombie_weapons[weapon].cost;
}

/*
	Name: get_ammo_cost
	Namespace: zm_weapons
	Checksum: 0x4D62BD05
	Offset: 0x2398
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function get_ammo_cost(weapon)
{
	/#
		/#
			assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "");
		#/
	#/
	return level.zombie_weapons[weapon].ammo_cost;
}

/*
	Name: get_upgraded_ammo_cost
	Namespace: zm_weapons
	Checksum: 0x9ED22387
	Offset: 0x2418
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function get_upgraded_ammo_cost(weapon)
{
	/#
		/#
			assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "");
		#/
	#/
	if(isdefined(level.zombie_weapons[weapon].upgraded_ammo_cost))
	{
		return level.zombie_weapons[weapon].upgraded_ammo_cost;
	}
	return 4500;
}

/*
	Name: get_ammo_cost_for_weapon
	Namespace: zm_weapons
	Checksum: 0xBB2A54B8
	Offset: 0x24B8
	Size: 0x192
	Parameters: 3
	Flags: Linked
*/
function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000)
{
	w_root = function_386dacbc(w_current);
	if(is_weapon_upgraded(w_root))
	{
		w_root = get_base_weapon(w_root);
	}
	is_wonder_weapon = is_wonder_weapon(w_root);
	if(self has_upgrade(w_root))
	{
		if(zm_wallbuy::is_wallbuy(w_root))
		{
			n_ammo_cost = 4000;
		}
		else if(is_wonder_weapon)
		{
			n_ammo_cost = 7500;
		}
		else
		{
			n_ammo_cost = n_upgraded_non_wallbuy_cost;
		}
	}
	else if(zm_wallbuy::is_wallbuy(w_root))
	{
		n_ammo_cost = get_ammo_cost(w_root);
		n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
	}
	else if(is_wonder_weapon)
	{
		n_ammo_cost = 4000;
	}
	else
	{
		n_ammo_cost = n_base_non_wallbuy_cost;
	}
	return n_ammo_cost;
}

/*
	Name: get_is_in_box
	Namespace: zm_weapons
	Checksum: 0x3269AB61
	Offset: 0x2658
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_is_in_box(weapon)
{
	/#
		assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "");
	#/
	return level.zombie_weapons[weapon].is_in_box;
}

/*
	Name: function_603af7a8
	Namespace: zm_weapons
	Checksum: 0x3E882EEF
	Offset: 0x26C0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_603af7a8(weapon)
{
	if(isdefined(level.zombie_weapons[weapon]))
	{
		level.zombie_weapons[weapon].is_in_box = 1;
	}
	/#
		level thread zm_devgui::function_bcc8843e(function_a16a090d(weapon), "", "");
	#/
}

/*
	Name: function_f1114209
	Namespace: zm_weapons
	Checksum: 0x77320D63
	Offset: 0x2740
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_f1114209(weapon)
{
	if(isdefined(level.zombie_weapons[weapon]))
	{
		level.zombie_weapons[weapon].is_in_box = 0;
	}
}

/*
	Name: weapon_supports_default_attachment
	Namespace: zm_weapons
	Checksum: 0xC0982DC5
	Offset: 0x2788
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function weapon_supports_default_attachment(weapon)
{
	weapon = get_base_weapon(weapon);
	attachment = level.zombie_weapons[weapon].default_attachment;
	return isdefined(attachment);
}

/*
	Name: default_attachment
	Namespace: zm_weapons
	Checksum: 0x3D3CFB12
	Offset: 0x27E0
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function default_attachment(weapon)
{
	weapon = get_base_weapon(weapon);
	attachment = level.zombie_weapons[weapon].default_attachment;
	if(isdefined(attachment))
	{
		return attachment;
	}
	return "none";
}

/*
	Name: weapon_supports_attachments
	Namespace: zm_weapons
	Checksum: 0x74893DA9
	Offset: 0x2848
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function weapon_supports_attachments(weapon)
{
	weapon = get_base_weapon(weapon);
	attachments = level.zombie_weapons[weapon].addon_attachments;
	return isdefined(attachments) && attachments.size > 1;
}

/*
	Name: random_attachment
	Namespace: zm_weapons
	Checksum: 0x5A978841
	Offset: 0x28B0
	Size: 0x14A
	Parameters: 2
	Flags: None
*/
function random_attachment(weapon, exclude)
{
	lo = 0;
	if(isdefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0)
	{
		attachments = level.zombie_weapons[weapon].addon_attachments;
	}
	else
	{
		attachments = weapon.supportedattachments;
		lo = 1;
	}
	minatt = lo;
	if(isdefined(exclude) && exclude != "none")
	{
		minatt = lo + 1;
	}
	if(attachments.size > minatt)
	{
		while(true)
		{
			idx = (randomint(attachments.size - lo)) + lo;
			if(!isdefined(exclude) || attachments[idx] != exclude)
			{
				return attachments[idx];
			}
		}
	}
	return "none";
}

/*
	Name: get_attachment_index
	Namespace: zm_weapons
	Checksum: 0x3B5A918F
	Offset: 0x2A08
	Size: 0x148
	Parameters: 1
	Flags: None
*/
function get_attachment_index(weapon)
{
	attachments = weapon.attachments;
	if(!attachments.size)
	{
		return -1;
	}
	weapon = get_nonalternate_weapon(weapon);
	base = function_386dacbc(weapon);
	if(attachments[0] === level.zombie_weapons[base].default_attachment)
	{
		return 0;
	}
	if(isdefined(level.zombie_weapons[base].addon_attachments))
	{
		for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++)
		{
			if(level.zombie_weapons[base].addon_attachments[i] == attachments[0])
			{
				return i + 1;
			}
		}
	}
	/#
		println("" + weapon.name);
	#/
	return -1;
}

/*
	Name: weapon_supports_this_attachment
	Namespace: zm_weapons
	Checksum: 0xC0CDD154
	Offset: 0x2B58
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function weapon_supports_this_attachment(weapon, att)
{
	weapon = get_nonalternate_weapon(weapon);
	base = function_386dacbc(weapon);
	if(att == level.zombie_weapons[base].default_attachment)
	{
		return 1;
	}
	if(isdefined(level.zombie_weapons[base].addon_attachments))
	{
		for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++)
		{
			if(level.zombie_weapons[base].addon_attachments[i] == att)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: get_base_weapon
	Namespace: zm_weapons
	Checksum: 0x696678E8
	Offset: 0x2C50
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function get_base_weapon(upgradedweapon)
{
	upgradedweapon = get_nonalternate_weapon(upgradedweapon);
	upgradedweapon = function_386dacbc(upgradedweapon);
	if(isdefined(level.zombie_weapons_upgraded[upgradedweapon]))
	{
		return level.zombie_weapons_upgraded[upgradedweapon];
	}
	return upgradedweapon;
}

/*
	Name: get_upgrade_weapon
	Namespace: zm_weapons
	Checksum: 0x1324B255
	Offset: 0x2CC0
	Size: 0x1DA
	Parameters: 2
	Flags: Linked
*/
function get_upgrade_weapon(weapon, add_attachment)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	newweapon = rootweapon;
	baseweapon = get_base_weapon(weapon);
	if(!is_weapon_upgraded(rootweapon) && isdefined(level.zombie_weapons[rootweapon]))
	{
		newweapon = level.zombie_weapons[rootweapon].upgrade;
	}
	else if(!namespace_59ff1d6c::function_901b751c(#"hash_57a5c7a9dcf94d61"))
	{
		return weapon;
	}
	/#
		if(isdefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size)
		{
			newweapon = getweapon(newweapon.name, weapon.attachments);
			return newweapon;
		}
	#/
	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].default_attachment))
	{
		att = level.zombie_weapons[rootweapon].default_attachment;
		newweapon = getweapon(newweapon.name, att);
	}
	return newweapon;
}

/*
	Name: can_upgrade_weapon
	Namespace: zm_weapons
	Checksum: 0xF8BEADBD
	Offset: 0x2EA8
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function can_upgrade_weapon(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon))
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	if(!is_weapon_upgraded(rootweapon))
	{
		upgraded_weapon = level.zombie_weapons[rootweapon].upgrade;
		return isdefined(upgraded_weapon) && upgraded_weapon != level.weaponnone;
	}
	return 0;
}

/*
	Name: weapon_supports_aat
	Namespace: zm_weapons
	Checksum: 0x1A9045A7
	Offset: 0x2F98
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function weapon_supports_aat(weapon)
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_57a5c7a9dcf94d61"))
	{
		return 0;
	}
	if(!isdefined(weapon))
	{
		return 0;
	}
	if(weapon == level.weaponnone || weapon == level.weaponzmfists)
	{
		return 0;
	}
	weapontopack = get_nonalternate_weapon(weapon);
	if(!aat::is_exempt_weapon(weapontopack))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_weapon_upgraded
	Namespace: zm_weapons
	Checksum: 0xAB91E5C2
	Offset: 0x3048
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function is_weapon_upgraded(weapon)
{
	if(!isdefined(weapon))
	{
		return 0;
	}
	if(weapon == level.weaponnone || weapon == level.weaponzmfists)
	{
		return 0;
	}
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_weapon_with_attachments
	Namespace: zm_weapons
	Checksum: 0xD251E8E0
	Offset: 0x30F0
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function get_weapon_with_attachments(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	if(self has_weapon_or_attachments(rootweapon))
	{
		/#
			if(isdefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size)
			{
				return weapon;
			}
		#/
		return self getbuildkitweapon(rootweapon);
	}
	return undefined;
}

/*
	Name: has_weapon_or_attachments
	Namespace: zm_weapons
	Checksum: 0x1E6DAE9A
	Offset: 0x31B8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function has_weapon_or_attachments(weapon)
{
	if(self hasweapon(weapon, 1))
	{
		return 1;
	}
	if(self hasweapon(self getbuildkitweapon(weapon), 1))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_386dacbc
	Namespace: zm_weapons
	Checksum: 0x147B3A4D
	Offset: 0x3230
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_386dacbc(weapon)
{
	rootweapon = weapon.rootweapon;
	if(isdefined(level.var_44e0d625[rootweapon]))
	{
		rootweapon = level.var_44e0d625[rootweapon];
	}
	return rootweapon;
}

/*
	Name: has_upgrade
	Namespace: zm_weapons
	Checksum: 0xBA098011
	Offset: 0x3288
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function has_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	has_upgrade = 0;
	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade))
	{
		has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
	}
	return has_upgrade;
}

/*
	Name: has_weapon_or_upgrade
	Namespace: zm_weapons
	Checksum: 0x90063408
	Offset: 0x3348
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function has_weapon_or_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	upgradedweaponname = rootweapon;
	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade))
	{
		upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
	}
	has_weapon = 0;
	if(isdefined(level.zombie_weapons[rootweapon]))
	{
		has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
	}
	if(!has_weapon && zm_equipment::is_equipment(rootweapon))
	{
		has_weapon = self zm_equipment::is_active(rootweapon);
	}
	return has_weapon;
}

/*
	Name: add_shared_ammo_weapon
	Namespace: zm_weapons
	Checksum: 0xF8D35138
	Offset: 0x3488
	Size: 0x32
	Parameters: 2
	Flags: None
*/
function add_shared_ammo_weapon(weapon, base_weapon)
{
	level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

/*
	Name: get_shared_ammo_weapon
	Namespace: zm_weapons
	Checksum: 0x9632AE39
	Offset: 0x34C8
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function get_shared_ammo_weapon(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	weapons = self getweaponslist(1);
	foreach(w in weapons)
	{
		w = function_386dacbc(w);
		if(!isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons_upgraded[w]))
		{
			w = level.zombie_weapons_upgraded[w];
		}
		if(isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon)
		{
			return w;
		}
	}
	return undefined;
}

/*
	Name: get_player_weapon_with_same_base
	Namespace: zm_weapons
	Checksum: 0xE5D12B13
	Offset: 0x3648
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function get_player_weapon_with_same_base(weapon)
{
	if(isdefined(level.var_ee565b3f))
	{
		retweapon = [[level.var_ee565b3f]](weapon);
		if(isdefined(retweapon))
		{
			return retweapon;
		}
	}
	weapon = get_nonalternate_weapon(weapon);
	rootweapon = function_386dacbc(weapon);
	retweapon = self get_weapon_with_attachments(rootweapon);
	if(!isdefined(retweapon))
	{
		if(isdefined(level.zombie_weapons[rootweapon]))
		{
			if(isdefined(level.zombie_weapons[rootweapon].upgrade))
			{
				retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
			}
		}
		else if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
		{
			retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
		}
	}
	return retweapon;
}

/*
	Name: get_weapon_hint_ammo
	Namespace: zm_weapons
	Checksum: 0xA4C7B600
	Offset: 0x3788
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function get_weapon_hint_ammo()
{
	if(function_8b1a219a())
	{
		return #"hash_2791ecebb85142c4";
	}
	return #"hash_60606b68e93a29c8";
}

/*
	Name: weapon_set_first_time_hint
	Namespace: zm_weapons
	Checksum: 0x81C73C1A
	Offset: 0x37C8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function weapon_set_first_time_hint(cost, ammo_cost)
{
	self sethintstring(get_weapon_hint_ammo());
}

/*
	Name: get_pack_a_punch_weapon_options
	Namespace: zm_weapons
	Checksum: 0x5F59A1C1
	Offset: 0x3810
	Size: 0x198
	Parameters: 1
	Flags: None
*/
function get_pack_a_punch_weapon_options(weapon)
{
	if(!isdefined(self.pack_a_punch_weapon_options))
	{
		self.pack_a_punch_weapon_options = [];
	}
	if(!is_weapon_upgraded(weapon))
	{
		return self calcweaponoptions(0, 0, 0, 0, 0);
	}
	if(isdefined(self.pack_a_punch_weapon_options[weapon]))
	{
		return self.pack_a_punch_weapon_options[weapon];
	}
	camo_index = self zm_camos::function_4f727cf5(weapon);
	reticle_index = randomintrange(0, 16);
	var_eb2e3f90 = 0;
	plain_reticle_index = 16;
	use_plain = randomint(10) < 1;
	if(use_plain)
	{
		reticle_index = plain_reticle_index;
	}
	/#
		if(getdvarint(#"scr_force_reticle_index", 0) >= 0)
		{
			reticle_index = getdvarint(#"scr_force_reticle_index", 0);
		}
	#/
	self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, reticle_index, var_eb2e3f90);
	return self.pack_a_punch_weapon_options[weapon];
}

/*
	Name: function_17512fb3
	Namespace: zm_weapons
	Checksum: 0x39CA88E8
	Offset: 0x39B0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_17512fb3()
{
	lethal_grenade = self zm_loadout::get_player_lethal_grenade();
	if(!self hasweapon(lethal_grenade))
	{
		self giveweapon(lethal_grenade);
		self setweaponammoclip(lethal_grenade, 0);
		self switchtooffhand(lethal_grenade);
		self ability_util::gadget_reset(lethal_grenade, 0, 0, 1, 0);
	}
}

/*
	Name: give_build_kit_weapon
	Namespace: zm_weapons
	Checksum: 0x2A735F33
	Offset: 0x3A60
	Size: 0x338
	Parameters: 4
	Flags: Linked
*/
function give_build_kit_weapon(weapon, var_51ec4e93, var_bd5d43c6, b_switch_weapon = 1)
{
	if(isdefined(var_51ec4e93))
	{
		n_camo = var_51ec4e93;
	}
	else
	{
		n_camo = self zm_camos::function_79be4786(weapon);
	}
	base_weapon = weapon;
	if(is_weapon_upgraded(weapon))
	{
		level notify(#"hash_6dead3931d3e708a", {#weapon:weapon, #player:self});
		if(!isdefined(n_camo))
		{
			n_camo = self zm_camos::function_4f727cf5(weapon);
		}
		base_weapon = get_base_weapon(weapon);
	}
	/#
		if(isdefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size)
		{
			if(!isdefined(n_camo))
			{
				n_camo = 0;
			}
			weapon_options = self calcweaponoptions(n_camo, 0, 0);
			self giveweapon(weapon, weapon_options);
			return weapon;
		}
	#/
	weapon = self getbuildkitweapon(weapon);
	weapon = function_1242e467(weapon);
	w_root = function_386dacbc(weapon);
	weapon_options = self getbuildkitweaponoptions(w_root, n_camo, var_bd5d43c6);
	if(!isdefined(n_camo))
	{
		n_camo = getcamoindex(weapon_options);
	}
	if(!(isdefined(b_switch_weapon) && b_switch_weapon))
	{
		self.var_57c1d146[weapon] = 1;
	}
	self giveweapon(weapon, weapon_options);
	if(!self hasweapon(weapon))
	{
		return weapon;
	}
	var_35dbd2be = self function_9826b353(w_root);
	if(isdefined(var_35dbd2be) && var_35dbd2be >= 0)
	{
		self function_3fb8b14(weapon, var_35dbd2be);
	}
	var_502dadb4 = self function_74829bcf(w_root);
	if(isdefined(var_502dadb4) && var_502dadb4 >= 0)
	{
		self function_a85d2581(weapon, var_502dadb4);
	}
	return weapon;
}

/*
	Name: weapon_give
	Namespace: zm_weapons
	Checksum: 0x68D8C56F
	Offset: 0x3DA0
	Size: 0xC8
	Parameters: 5
	Flags: Linked
*/
function weapon_give(weapon, nosound = 0, b_switch_weapon = 1, var_51ec4e93, var_bd5d43c6)
{
	if(!(isdefined(nosound) && nosound))
	{
		self zm_utility::play_sound_on_ent("purchase");
	}
	weapon = self give_build_kit_weapon(weapon, var_51ec4e93, var_bd5d43c6, b_switch_weapon);
	if(!(isdefined(nosound) && nosound))
	{
		self play_weapon_vo(weapon);
	}
	return weapon;
}

/*
	Name: weapon_take
	Namespace: zm_weapons
	Checksum: 0xB70BD707
	Offset: 0x3E70
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function weapon_take(weapon)
{
	if(self hasweapon(weapon))
	{
		self takeweapon(weapon);
	}
}

/*
	Name: play_weapon_vo
	Namespace: zm_weapons
	Checksum: 0xD4CD282E
	Offset: 0x3EB8
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function play_weapon_vo(weapon)
{
	if(isdefined(level.var_d99d49fd))
	{
		result = self [[level.var_d99d49fd]](weapon);
		if(result)
		{
			return;
		}
	}
	if(isdefined(level._audio_custom_weapon_check))
	{
		type = self [[level._audio_custom_weapon_check]](weapon);
	}
	else
	{
		type = self weapon_type_check(weapon);
	}
	if(!isdefined(type))
	{
		return;
	}
	if(isdefined(level.sndweaponpickupoverride))
	{
		foreach(override in level.sndweaponpickupoverride)
		{
			if(type === override)
			{
				self zm_audio::create_and_play_dialog(#"weapon_pickup", override);
				return;
			}
		}
	}
	if(isdefined(self.var_966bfd1b) && self.var_966bfd1b)
	{
		self.var_966bfd1b = 0;
		self zm_audio::create_and_play_dialog(#"magicbox", type);
	}
	else if(type == "upgrade")
	{
		self zm_audio::create_and_play_dialog(#"weapon_pickup", #"upgrade");
	}
	else if(randomintrange(0, 100) <= 75 || type == "shield")
	{
		self zm_audio::create_and_play_dialog(#"weapon_pickup", type);
	}
	else
	{
		self zm_audio::create_and_play_dialog(#"weapon_pickup", #"generic");
	}
}

/*
	Name: weapon_type_check
	Namespace: zm_weapons
	Checksum: 0x6F7F58DE
	Offset: 0x4130
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function weapon_type_check(weapon)
{
	if(!isdefined(self.entity_num))
	{
		return "crappy";
	}
	weapon = get_nonalternate_weapon(weapon);
	weapon = function_386dacbc(weapon);
	if(is_weapon_upgraded(weapon) && !self bgb::is_enabled(#"zm_bgb_wall_power"))
	{
		return "upgrade";
	}
	if(isdefined(level.zombie_weapons[weapon]))
	{
		return level.zombie_weapons[weapon].vox;
	}
	return "crappy";
}

/*
	Name: ammo_give
	Namespace: zm_weapons
	Checksum: 0xD4F2953F
	Offset: 0x4208
	Size: 0x37E
	Parameters: 2
	Flags: Linked
*/
function ammo_give(weapon, b_purchased = 1)
{
	var_cd9d17e0 = 0;
	if(!zm_loadout::is_offhand_weapon(weapon) || weapon.isriotshield)
	{
		weapon = self get_weapon_with_attachments(weapon);
		if(isdefined(weapon))
		{
			if(namespace_4b9b8ded::is_active(1) || namespace_a9e73d8d::is_active())
			{
				var_cb48c3c9 = 0;
				var_ef0714fa = 0;
			}
			else
			{
				var_cb48c3c9 = weapon.maxammo;
				var_ef0714fa = weapon.startammo;
			}
			var_98f6dae8 = self getweaponammoclip(weapon);
			n_clip_size = weapon.clipsize;
			if(var_98f6dae8 < n_clip_size)
			{
				var_cd9d17e0 = 1;
			}
			var_4052eae0 = 0;
			if(!var_cd9d17e0 && weapon.dualwieldweapon != level.weaponnone)
			{
				var_4052eae0 = self getweaponammoclip(weapon.dualwieldweapon);
				var_5916b9ab = weapon.dualwieldweapon.clipsize;
				if(var_4052eae0 < var_5916b9ab)
				{
					var_cd9d17e0 = 1;
				}
			}
			if(!var_cd9d17e0)
			{
				var_b8624c26 = self getammocount(weapon);
				if(self hasperk(#"specialty_extraammo"))
				{
					n_ammo_max = var_cb48c3c9;
				}
				else
				{
					n_ammo_max = var_ef0714fa;
				}
				if(weapon.isdualwield)
				{
					if(weapon == getweapon(#"hash_6a0c4101e88a4707"))
					{
						n_ammo_max = (n_ammo_max * 2) - var_98f6dae8;
					}
					var_b8624c26 = var_b8624c26 + var_4052eae0;
				}
				var_6ec34556 = isdefined(weapon.iscliponly) && (weapon.iscliponly ? var_98f6dae8 : (n_ammo_max + var_98f6dae8) + var_4052eae0);
				if(var_b8624c26 >= var_6ec34556)
				{
					var_cd9d17e0 = 0;
				}
				else
				{
					var_cd9d17e0 = 1;
				}
			}
		}
	}
	else if(self has_weapon_or_upgrade(weapon))
	{
		if(self getammocount(weapon) < weapon.maxammo)
		{
			var_cd9d17e0 = 1;
		}
	}
	if(var_cd9d17e0)
	{
		if(b_purchased)
		{
			self zm_utility::play_sound_on_ent("purchase");
		}
		self function_7c5dd4bd(weapon);
		return 1;
	}
	if(!var_cd9d17e0)
	{
		return 0;
	}
}

/*
	Name: get_default_weapondata
	Namespace: zm_weapons
	Checksum: 0x30A1DE26
	Offset: 0x4590
	Size: 0x216
	Parameters: 1
	Flags: Linked
*/
function get_default_weapondata(weapon)
{
	weapondata = [];
	weapondata[#"weapon"] = weapon;
	dw_weapon = weapon.dualwieldweapon;
	alt_weapon = weapon.altweapon;
	weaponnone = getweapon(#"none");
	if(isdefined(level.weaponnone))
	{
		weaponnone = level.weaponnone;
	}
	if(weapon != weaponnone)
	{
		weapondata[#"clip"] = weapon.clipsize;
		weapondata[#"stock"] = weapon.maxammo;
		weapondata[#"fuel"] = weapon.fuellife;
		weapondata[#"heat"] = 0;
		weapondata[#"overheat"] = 0;
	}
	if(dw_weapon != weaponnone)
	{
		weapondata[#"lh_clip"] = dw_weapon.clipsize;
	}
	else
	{
		weapondata[#"lh_clip"] = 0;
	}
	if(alt_weapon != weaponnone)
	{
		weapondata[#"alt_clip"] = alt_weapon.clipsize;
		weapondata[#"alt_stock"] = alt_weapon.maxammo;
	}
	else
	{
		weapondata[#"alt_clip"] = 0;
		weapondata[#"alt_stock"] = 0;
	}
	return weapondata;
}

/*
	Name: get_player_weapondata
	Namespace: zm_weapons
	Checksum: 0x9B84C4DD
	Offset: 0x47B0
	Size: 0x426
	Parameters: 1
	Flags: Linked
*/
function get_player_weapondata(weapon)
{
	weapondata = [];
	if(!isdefined(weapon))
	{
		weapon = self getcurrentweapon();
	}
	weapondata[#"weapon"] = weapon;
	if(weapondata[#"weapon"] != level.weaponnone)
	{
		weapondata[#"clip"] = self getweaponammoclip(weapon);
		weapondata[#"stock"] = self getweaponammostock(weapon);
		weapondata[#"fuel"] = self getweaponammofuel(weapon);
		weapondata[#"heat"] = self isweaponoverheating(1, weapon);
		weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
		if(weapon.isgadget)
		{
			slot = self gadgetgetslot(weapon);
			weapondata[#"power"] = self gadgetpowerget(slot);
		}
		if(weapon.isriotshield)
		{
			weapondata[#"health"] = self.weaponhealth;
		}
	}
	else
	{
		weapondata[#"clip"] = 0;
		weapondata[#"stock"] = 0;
		weapondata[#"fuel"] = 0;
		weapondata[#"heat"] = 0;
		weapondata[#"overheat"] = 0;
		weapondata[#"power"] = undefined;
	}
	dw_weapon = weapon.dualwieldweapon;
	if(dw_weapon != level.weaponnone)
	{
		weapondata[#"lh_clip"] = self getweaponammoclip(dw_weapon);
	}
	else
	{
		weapondata[#"lh_clip"] = 0;
	}
	alt_weapon = weapon.altweapon;
	if(alt_weapon != level.weaponnone)
	{
		weapondata[#"alt_clip"] = self getweaponammoclip(alt_weapon);
		weapondata[#"alt_stock"] = self getweaponammostock(alt_weapon);
	}
	else
	{
		weapondata[#"alt_clip"] = 0;
		weapondata[#"alt_stock"] = 0;
	}
	if(self aat::function_c5abc232(weapon))
	{
		weapondata[#"aat"] = self aat::getaatonweapon(weapon, 1);
	}
	weapondata[#"repacks"] = self zm_pap_util::function_83c29ddb(weapon);
	return weapondata;
}

/*
	Name: weapon_is_better
	Namespace: zm_weapons
	Checksum: 0xAF85F1FB
	Offset: 0x4BE0
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function weapon_is_better(left, right)
{
	if(left != right)
	{
		left_upgraded = is_weapon_upgraded(left);
		right_upgraded = is_weapon_upgraded(right);
		if(left_upgraded)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: merge_weapons
	Namespace: zm_weapons
	Checksum: 0xEC100BF1
	Offset: 0x4C58
	Size: 0x64E
	Parameters: 2
	Flags: Linked
*/
function merge_weapons(oldweapondata, newweapondata)
{
	weapondata = [];
	if(isdefined(level.var_bb2323e4))
	{
		weapondata = [[level.var_bb2323e4]](oldweapondata, newweapondata);
		if(isdefined(weapondata))
		{
			return weapondata;
		}
	}
	if(weapon_is_better(oldweapondata[#"weapon"], newweapondata[#"weapon"]))
	{
		weapondata[#"weapon"] = oldweapondata[#"weapon"];
	}
	else
	{
		weapondata[#"weapon"] = newweapondata[#"weapon"];
	}
	weapon = weapondata[#"weapon"];
	dw_weapon = weapon.dualwieldweapon;
	alt_weapon = weapon.altweapon;
	if(weapon != level.weaponnone)
	{
		weapondata[#"clip"] = newweapondata[#"clip"] + oldweapondata[#"clip"];
		weapondata[#"clip"] = int(min(weapondata[#"clip"], weapon.clipsize));
		weapondata[#"stock"] = newweapondata[#"stock"] + oldweapondata[#"stock"];
		weapondata[#"stock"] = int(min(weapondata[#"stock"], weapon.maxammo));
		weapondata[#"fuel"] = newweapondata[#"fuel"] + oldweapondata[#"fuel"];
		weapondata[#"fuel"] = int(min(weapondata[#"fuel"], weapon.fuellife));
		weapondata[#"heat"] = int(min(newweapondata[#"heat"], oldweapondata[#"heat"]));
		weapondata[#"overheat"] = int(min(newweapondata[#"overheat"], oldweapondata[#"overheat"]));
		weapondata[#"power"] = int(max((isdefined(newweapondata[#"power"]) ? newweapondata[#"power"] : 0), (isdefined(oldweapondata[#"power"]) ? oldweapondata[#"power"] : 0)));
	}
	if(dw_weapon != level.weaponnone)
	{
		weapondata[#"lh_clip"] = newweapondata[#"lh_clip"] + oldweapondata[#"lh_clip"];
		weapondata[#"lh_clip"] = int(min(weapondata[#"lh_clip"], dw_weapon.clipsize));
	}
	if(alt_weapon != level.weaponnone)
	{
		weapondata[#"alt_clip"] = newweapondata[#"alt_clip"] + oldweapondata[#"alt_clip"];
		weapondata[#"alt_clip"] = int(min(weapondata[#"alt_clip"], alt_weapon.clipsize));
		weapondata[#"alt_stock"] = newweapondata[#"alt_stock"] + oldweapondata[#"alt_stock"];
		weapondata[#"alt_stock"] = int(min(weapondata[#"alt_stock"], alt_weapon.maxammo));
	}
	return weapondata;
}

/*
	Name: weapondata_give
	Namespace: zm_weapons
	Checksum: 0xE1EACF9B
	Offset: 0x52B0
	Size: 0x4F8
	Parameters: 1
	Flags: Linked
*/
function weapondata_give(weapondata)
{
	current = self get_player_weapon_with_same_base(weapondata[#"weapon"]);
	if(isdefined(current))
	{
		curweapondata = self get_player_weapondata(current);
		self weapon_take(current);
		weapondata = merge_weapons(curweapondata, weapondata);
	}
	weapon = weapondata[#"weapon"];
	weapon_give(weapon, 1);
	if(weapon != level.weaponnone)
	{
		if((weapondata[#"clip"] + weapondata[#"stock"]) <= weapon.clipsize)
		{
			self setweaponammoclip(weapon, weapon.clipsize);
			self setweaponammostock(weapon, 0);
		}
		else
		{
			self setweaponammoclip(weapon, weapondata[#"clip"]);
			self setweaponammostock(weapon, weapondata[#"stock"]);
		}
		if(isdefined(weapondata[#"fuel"]))
		{
			self setweaponammofuel(weapon, weapondata[#"fuel"]);
		}
		if(isdefined(weapondata[#"heat"]) && isdefined(weapondata[#"overheat"]))
		{
			self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
		}
		if(weapon.isgadget && isdefined(weapondata[#"power"]))
		{
			slot = self gadgetgetslot(weapon);
			if(slot >= 0)
			{
				self gadgetpowerset(slot, weapondata[#"power"]);
			}
		}
		if(weapon.isriotshield && isdefined(weapondata[#"health"]))
		{
			self.weaponhealth = weapondata[#"health"];
		}
	}
	dw_weapon = weapon.dualwieldweapon;
	if(function_386dacbc(dw_weapon) != level.weaponnone)
	{
		if(!self hasweapon(dw_weapon))
		{
			self giveweapon(dw_weapon);
		}
		self setweaponammoclip(dw_weapon, weapondata[#"lh_clip"]);
	}
	alt_weapon = weapon.altweapon;
	if(function_386dacbc(alt_weapon) != level.weaponnone)
	{
		if(!self hasweapon(alt_weapon))
		{
			self giveweapon(alt_weapon);
		}
		self setweaponammoclip(alt_weapon, weapondata[#"alt_clip"]);
		self setweaponammostock(alt_weapon, weapondata[#"alt_stock"]);
	}
	if(isdefined(weapondata[#"aat"]))
	{
		self aat::acquire(weapon, weapondata[#"aat"]);
	}
	if(isdefined(weapondata[#"repacks"]) && weapondata[#"repacks"] > 0)
	{
		self zm_pap_util::repack_weapon(weapon, weapondata[#"repacks"]);
	}
	return weapon;
}

/*
	Name: weapondata_take
	Namespace: zm_weapons
	Checksum: 0xC841871C
	Offset: 0x57B0
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function weapondata_take(weapondata)
{
	weapon = weapondata[#"weapon"];
	if(weapon != level.weaponnone)
	{
		if(self hasweapon(weapon))
		{
			self weapon_take(weapon);
		}
	}
	dw_weapon = weapon.dualwieldweapon;
	if(dw_weapon != level.weaponnone)
	{
		if(self hasweapon(dw_weapon))
		{
			self weapon_take(dw_weapon);
		}
	}
	alt_weapon = weapon.altweapon;
	var_15e41636 = [];
	while(alt_weapon != level.weaponnone)
	{
		if(!isdefined(var_15e41636))
		{
			var_15e41636 = [];
		}
		else if(!isarray(var_15e41636))
		{
			var_15e41636 = array(var_15e41636);
		}
		if(!isinarray(var_15e41636, alt_weapon))
		{
			var_15e41636[var_15e41636.size] = alt_weapon;
		}
		if(self hasweapon(alt_weapon))
		{
			self weapon_take(alt_weapon);
		}
		alt_weapon = alt_weapon.altweapon;
		if(isinarray(var_15e41636, alt_weapon))
		{
			/#
				println(("" + function_9e72a96(alt_weapon.name)) + "");
			#/
			break;
		}
	}
}

/*
	Name: create_loadout
	Namespace: zm_weapons
	Checksum: 0x6B55731E
	Offset: 0x59C0
	Size: 0x19E
	Parameters: 1
	Flags: None
*/
function create_loadout(weapons)
{
	weaponnone = getweapon(#"none");
	if(isdefined(level.weaponnone))
	{
		weaponnone = level.weaponnone;
	}
	loadout = spawnstruct();
	loadout.weapons = [];
	foreach(weapon in weapons)
	{
		if(isstring(weapon))
		{
			weapon = getweapon(weapon);
		}
		if(weapon == weaponnone)
		{
			/#
				println("" + weapon.name);
			#/
		}
		loadout.weapons[weapon.name] = get_default_weapondata(weapon);
		if(!isdefined(loadout.current))
		{
			loadout.current = weapon;
		}
	}
	return loadout;
}

/*
	Name: player_get_loadout
	Namespace: zm_weapons
	Checksum: 0xE1BCF82
	Offset: 0x5B68
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function player_get_loadout()
{
	loadout = spawnstruct();
	loadout.current = self getcurrentweapon();
	loadout.stowed = self getstowedweapon();
	loadout.weapons = [];
	foreach(weapon in self getweaponslist())
	{
		loadout.weapons[weapon.name] = self get_player_weapondata(weapon);
	}
	return loadout;
}

/*
	Name: player_give_loadout
	Namespace: zm_weapons
	Checksum: 0x7FA798DE
	Offset: 0x5C78
	Size: 0x2CC
	Parameters: 3
	Flags: Linked
*/
function player_give_loadout(loadout, replace_existing = 1, immediate_switch = 0)
{
	if(replace_existing)
	{
		self takeallweapons();
	}
	foreach(weapondata in loadout.weapons)
	{
		if(isdefined(weapondata[#"weapon"].isheroweapon) && weapondata[#"weapon"].isheroweapon)
		{
			self zm_hero_weapon::function_2264d131(self.var_fd05e363, 0);
			w_weapon = weapondata[#"weapon"];
			if(w_weapon.isgadget && isdefined(weapondata[#"power"]))
			{
				slot = self gadgetgetslot(w_weapon);
				if(slot >= 0)
				{
					self gadgetpowerset(slot, weapondata[#"power"]);
				}
			}
			continue;
		}
		self weapondata_give(weapondata);
	}
	if(self getweaponslistprimaries().size == 0)
	{
		self zm_loadout::give_start_weapon(1);
	}
	if(!zm_loadout::is_offhand_weapon(loadout.current))
	{
		if(immediate_switch)
		{
			self switchtoweaponimmediate(loadout.current);
		}
		else
		{
			self switchtoweapon(loadout.current);
		}
	}
	else if(immediate_switch)
	{
		self switchtoweaponimmediate();
	}
	else
	{
		self switchtoweapon();
	}
	if(isdefined(loadout.stowed))
	{
		self setstowedweapon(loadout.stowed);
	}
}

/*
	Name: player_take_loadout
	Namespace: zm_weapons
	Checksum: 0x3818308
	Offset: 0x5F50
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function player_take_loadout(loadout)
{
	foreach(weapondata in loadout.weapons)
	{
		self weapondata_take(weapondata);
	}
}

/*
	Name: register_zombie_weapon_callback
	Namespace: zm_weapons
	Checksum: 0xC6A82209
	Offset: 0x5FE0
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function register_zombie_weapon_callback(weapon, func)
{
	if(!isdefined(level.zombie_weapons_callbacks))
	{
		level.zombie_weapons_callbacks = [];
	}
	if(!isdefined(level.zombie_weapons_callbacks[weapon]))
	{
		level.zombie_weapons_callbacks[weapon] = func;
	}
}

/*
	Name: set_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0x6A63D8D
	Offset: 0x6048
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function set_stowed_weapon(weapon)
{
	self.weapon_stowed = weapon;
	if(!(isdefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed))
	{
		self setstowedweapon(self.weapon_stowed);
	}
}

/*
	Name: clear_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0x8BB2E800
	Offset: 0x60A8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function clear_stowed_weapon()
{
	self notify(#"hash_70957a1035bda74b");
	self.weapon_stowed = undefined;
	self clearstowedweapon();
}

/*
	Name: suppress_stowed_weapon
	Namespace: zm_weapons
	Checksum: 0xF0B422F2
	Offset: 0x60E8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function suppress_stowed_weapon(onoff)
{
	self.stowed_weapon_suppressed = onoff;
	if(onoff || !isdefined(self.weapon_stowed))
	{
		self clearstowedweapon();
	}
	else
	{
		self setstowedweapon(self.weapon_stowed);
	}
}

/*
	Name: checkstringvalid
	Namespace: zm_weapons
	Checksum: 0x7EDD808
	Offset: 0x6160
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function checkstringvalid(var_f5bc27b5)
{
	if(var_f5bc27b5 != "")
	{
		return var_f5bc27b5;
	}
	return undefined;
}

/*
	Name: load_weapon_spec_from_table
	Namespace: zm_weapons
	Checksum: 0x89BF10CD
	Offset: 0x6190
	Size: 0x49A
	Parameters: 2
	Flags: Linked
*/
function load_weapon_spec_from_table(table, first_row)
{
	gametype = util::function_5df4294();
	index = first_row;
	row = tablelookuprow(table, index);
	while(isdefined(row))
	{
		weapon_name = checkstringvalid(row[0]);
		if(isinarray(level.var_c60359dc, weapon_name))
		{
			index++;
			row = tablelookuprow(table, index);
			continue;
		}
		if(!isdefined(level.var_c60359dc))
		{
			level.var_c60359dc = [];
		}
		else if(!isarray(level.var_c60359dc))
		{
			level.var_c60359dc = array(level.var_c60359dc);
		}
		level.var_c60359dc[level.var_c60359dc.size] = weapon_name;
		upgrade_name = checkstringvalid(row[1]);
		is_ee = row[2];
		cost = row[3];
		weaponvo = checkstringvalid(row[4]);
		weaponvoresp = checkstringvalid(row[5]);
		ammo_cost = row[6];
		create_vox = row[7];
		is_zcleansed = row[8];
		in_box = row[9];
		upgrade_in_box = row[10];
		is_limited = row[11];
		var_ddca6652 = row[17];
		limit = row[12];
		upgrade_limit = row[13];
		content_restrict = row[14];
		wallbuy_autospawn = row[15];
		weapon_class = checkstringvalid(row[16]);
		is_wonder_weapon = row[18];
		tier = row[19];
		zm_utility::include_weapon(weapon_name, in_box);
		if(isdefined(upgrade_name))
		{
			zm_utility::include_weapon(upgrade_name, upgrade_in_box);
		}
		add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier, in_box);
		if(is_limited)
		{
			if(isdefined(limit))
			{
				add_limited_weapon(weapon_name, limit);
			}
			if(isdefined(upgrade_limit) && isdefined(upgrade_name))
			{
				add_limited_weapon(upgrade_name, upgrade_limit);
			}
		}
		if(!var_ddca6652 && weapon_class !== "equipment")
		{
			aat::register_aat_exemption(getweapon(weapon_name));
			if(isdefined(upgrade_name))
			{
				aat::register_aat_exemption(getweapon(upgrade_name));
			}
		}
		index++;
		row = tablelookuprow(table, index);
	}
}

/*
	Name: is_wonder_weapon
	Namespace: zm_weapons
	Checksum: 0xE9C011EF
	Offset: 0x6638
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function is_wonder_weapon(w_to_check)
{
	w_base = get_base_weapon(w_to_check);
	if(isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_eb0b9fc3
	Namespace: zm_weapons
	Checksum: 0x6C46732B
	Offset: 0x66A8
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function function_eb0b9fc3(w_to_check)
{
	if(level.zombie_weapons[w_to_check].weapon_classname === "tr")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e17d0760
	Namespace: zm_weapons
	Checksum: 0xF4BB57A8
	Offset: 0x66E8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_e17d0760(weapon)
{
	if(weapon.explosioninnerdamage > 0 || weapon.explosionouterdamage > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f5a0899d
	Namespace: zm_weapons
	Checksum: 0x8BCA6199
	Offset: 0x6730
	Size: 0x96
	Parameters: 2
	Flags: Linked
*/
function function_f5a0899d(weapon, var_d921715f = 1)
{
	if(isdefined(weapon))
	{
		if(!var_d921715f && is_wonder_weapon(weapon))
		{
			return 0;
		}
		var_3ba4bf7d = self getweaponslistprimaries();
		if(isinarray(var_3ba4bf7d, weapon))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_7c5dd4bd
	Namespace: zm_weapons
	Checksum: 0xA6CA8C32
	Offset: 0x67D0
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_7c5dd4bd(w_weapon)
{
	if(zm_loadout::function_2ff6913(w_weapon))
	{
		return;
	}
	if(!self hasweapon(w_weapon))
	{
		return;
	}
	self setweaponammoclip(w_weapon, w_weapon.clipsize);
	self notify(#"hash_278526d0bbdb4ce7");
	if(namespace_4b9b8ded::is_active(1))
	{
		self function_7f7c1226(w_weapon);
		return;
	}
	if(self hasperk(#"specialty_extraammo"))
	{
		self givemaxammo(w_weapon);
	}
	else
	{
		self givestartammo(w_weapon);
	}
}

/*
	Name: function_7f7c1226
	Namespace: zm_weapons
	Checksum: 0xA7D85986
	Offset: 0x68D0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7f7c1226(weapon)
{
	waittillframeend();
	if(weaponhasattachment(weapon, "uber") && weapon.statname == #"smg_capacity_t8" || (isdefined(weapon.isriotshield) && weapon.isriotshield))
	{
		n_stock = weapon.clipsize;
	}
	else
	{
		n_stock = 0;
	}
	self setweaponammostock(weapon, n_stock);
}

/*
	Name: function_35746b9c
	Namespace: zm_weapons
	Checksum: 0xDE97860D
	Offset: 0x6990
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function function_35746b9c(weapon, str_mod = "MOD_MELEE")
{
	w_root = function_93cd8e76(weapon, 1);
	if(w_root.name == "pistol_standard_t8" || w_root.name == "ar_stealth_t8")
	{
		if(weaponhasattachment(weapon, "uber") && str_mod == "MOD_MELEE")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_ed29dde5
	Namespace: zm_weapons
	Checksum: 0xA464FB4C
	Offset: 0x6A58
	Size: 0x570
	Parameters: 3
	Flags: Linked
*/
function function_ed29dde5(var_947d01ee, var_ccd1bc81 = 0, var_609a8d33 = 0)
{
	a_weapons = [];
	foreach(s_weapon in level.zombie_weapons)
	{
		if(s_weapon.weapon_classname === var_947d01ee)
		{
			if(var_609a8d33)
			{
				if(!isdefined(a_weapons))
				{
					a_weapons = [];
				}
				else if(!isarray(a_weapons))
				{
					a_weapons = array(a_weapons);
				}
				a_weapons[a_weapons.size] = s_weapon.weapon.name;
			}
			else if(!isdefined(a_weapons))
			{
				a_weapons = [];
			}
			else if(!isarray(a_weapons))
			{
				a_weapons = array(a_weapons);
			}
			a_weapons[a_weapons.size] = s_weapon.weapon;
			if(var_ccd1bc81)
			{
				if(var_609a8d33)
				{
					if(!isdefined(a_weapons))
					{
						a_weapons = [];
					}
					else if(!isarray(a_weapons))
					{
						a_weapons = array(a_weapons);
					}
					a_weapons[a_weapons.size] = s_weapon.upgrade.name;
				}
				else if(!isdefined(a_weapons))
				{
					a_weapons = [];
				}
				else if(!isarray(a_weapons))
				{
					a_weapons = array(a_weapons);
				}
				a_weapons[a_weapons.size] = s_weapon.upgrade;
			}
		}
		if(s_weapon.weapon_classname === "shield" && var_947d01ee != "shield")
		{
			if(s_weapon.weapon.weapclass === var_947d01ee)
			{
				if(var_609a8d33)
				{
					if(!isdefined(a_weapons))
					{
						a_weapons = [];
					}
					else if(!isarray(a_weapons))
					{
						a_weapons = array(a_weapons);
					}
					a_weapons[a_weapons.size] = s_weapon.weapon.name;
					if(s_weapon.weapon.dualwieldweapon != level.weaponnone)
					{
						if(!isdefined(a_weapons))
						{
							a_weapons = [];
						}
						else if(!isarray(a_weapons))
						{
							a_weapons = array(a_weapons);
						}
						a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon.name;
					}
				}
				else if(!isdefined(a_weapons))
				{
					a_weapons = [];
				}
				else if(!isarray(a_weapons))
				{
					a_weapons = array(a_weapons);
				}
				a_weapons[a_weapons.size] = s_weapon.weapon;
				if(s_weapon.weapon.dualwieldweapon != level.weaponnone)
				{
					if(!isdefined(a_weapons))
					{
						a_weapons = [];
					}
					else if(!isarray(a_weapons))
					{
						a_weapons = array(a_weapons);
					}
					a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon;
				}
			}
			if(s_weapon.weapon.altweapon.weapclass === var_947d01ee)
			{
				if(var_609a8d33)
				{
					if(!isdefined(a_weapons))
					{
						a_weapons = [];
					}
					else if(!isarray(a_weapons))
					{
						a_weapons = array(a_weapons);
					}
					a_weapons[a_weapons.size] = s_weapon.weapon.altweapon.name;
					continue;
				}
				if(!isdefined(a_weapons))
				{
					a_weapons = [];
				}
				else if(!isarray(a_weapons))
				{
					a_weapons = array(a_weapons);
				}
				a_weapons[a_weapons.size] = s_weapon.weapon.altweapon;
			}
		}
	}
	return a_weapons;
}

