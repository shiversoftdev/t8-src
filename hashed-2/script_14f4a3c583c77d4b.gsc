// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_399c912938783695;
#using script_467027ea7017462b;
#using script_47fb62300ac0bd60;
#using script_6e3c826b1814cab6;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_loadout;

/*
	Name: function_89f2df9
	Namespace: zm_loadout
	Checksum: 0xEEBBF112
	Offset: 0x1B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_loadout", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_loadout
	Checksum: 0x34CA6720
	Offset: 0x1F8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_connect
	Namespace: zm_loadout
	Checksum: 0xD9708671
	Offset: 0x248
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.currentweaponstarttime = gettime();
	self.currentweapon = level.weaponnone;
	self.var_1d838ee9 = level.weaponnone;
	if(!isdefined(self.var_57c1d146))
	{
		self.var_57c1d146 = [];
	}
}

/*
	Name: on_player_spawned
	Namespace: zm_loadout
	Checksum: 0xD2BAF4BA
	Offset: 0x298
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.class_num = self function_cc90c352();
}

/*
	Name: weapon_changed
	Namespace: zm_loadout
	Checksum: 0xA61F98F7
	Offset: 0x2C8
	Size: 0x5A
	Parameters: 1
	Flags: Event
*/
event weapon_changed(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	self.currentweaponstarttime = gettime();
	self.currentweapon = eventstruct.weapon;
	self.var_1d838ee9 = eventstruct.last_weapon;
}

/*
	Name: loadout_changed
	Namespace: zm_loadout
	Checksum: 0x5881B182
	Offset: 0x330
	Size: 0xD4
	Parameters: 1
	Flags: Event
*/
event loadout_changed(eventstruct)
{
	switch(eventstruct.event)
	{
		case "give_weapon":
		{
			self function_54cb37a4(eventstruct.weapon);
			break;
		}
		case "take_weapon":
		{
			self function_ad4c1664(eventstruct.weapon);
			break;
		}
	}
	if(isdefined(self))
	{
		self thread zm_player::function_de3936f8(eventstruct.weapon);
		self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
	}
}

/*
	Name: function_ad4c1664
	Namespace: zm_loadout
	Checksum: 0x8E72921B
	Offset: 0x410
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_ad4c1664(weapon)
{
	self notify(#"weapon_take", weapon);
	primaryweapons = self getweaponslistprimaries();
	current_weapon = self getcurrentweapon();
	if(zm_equipment::is_equipment(weapon))
	{
		self zm_equipment::take(weapon);
	}
	if(function_59b0ef71("melee_weapon", weapon))
	{
		self function_6519eea8("melee_weapon", level.weaponnone);
	}
	else
	{
		if(function_59b0ef71("hero_weapon", weapon))
		{
			self function_6519eea8("hero_weapon", level.weaponnone);
		}
		else
		{
			if(function_59b0ef71("lethal_grenade", weapon))
			{
				self function_6519eea8("lethal_grenade", level.weaponnone);
			}
			else
			{
				if(function_59b0ef71("tactical_grenade", weapon))
				{
					self function_6519eea8("tactical_grenade", level.weaponnone);
				}
				else if(function_59b0ef71("placeable_mine", weapon))
				{
					self function_6519eea8("placeable_mine", level.weaponnone);
				}
			}
		}
	}
	if(!is_offhand_weapon(weapon) && primaryweapons.size < 1)
	{
		self zm_weapons::give_fallback_weapon();
	}
}

/*
	Name: function_54cb37a4
	Namespace: zm_loadout
	Checksum: 0xEAAEC35F
	Offset: 0x648
	Size: 0x56C
	Parameters: 1
	Flags: Linked
*/
function function_54cb37a4(weapon)
{
	self notify(#"weapon_give", weapon);
	self endon(#"disconnect");
	primaryweapons = self getweaponslistprimaries();
	initial_current_weapon = self getcurrentweapon();
	current_weapon = self zm_weapons::switch_from_alt_weapon(initial_current_weapon);
	/#
		assert(self zm_weapons::player_can_use_content(weapon));
	#/
	weapon_limit = zm_utility::get_player_weapon_limit(self);
	if(isdefined(weapon.var_52a84c7a) && weapon.var_52a84c7a)
	{
		zm_items::player_pick_up(self, weapon);
		return;
	}
	if(zm_equipment::is_equipment(weapon))
	{
		self zm_equipment::give(weapon);
	}
	if(weapon.isriotshield)
	{
		if(isdefined(self.player_shield_reset_health))
		{
			self [[self.player_shield_reset_health]](weapon);
		}
	}
	if(function_59b0ef71("melee_weapon", weapon))
	{
		had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
		self function_6519eea8("melee_weapon", weapon);
		if(had_fallback_weapon)
		{
			self zm_melee_weapon::give_fallback_weapon();
		}
	}
	else
	{
		if(function_59b0ef71("hero_weapon", weapon))
		{
			self function_6519eea8("hero_weapon", weapon);
		}
		else
		{
			if(function_59b0ef71("lethal_grenade", weapon))
			{
				self function_6519eea8("lethal_grenade", weapon);
			}
			else
			{
				if(function_59b0ef71("tactical_grenade", weapon))
				{
					self function_6519eea8("tactical_grenade", weapon);
				}
				else if(function_59b0ef71("placeable_mine", weapon))
				{
					self function_6519eea8("placeable_mine", weapon);
				}
			}
		}
	}
	if(!is_offhand_weapon(weapon) && !function_2ff6913(weapon) && weapon != self zm_melee_weapon::determine_fallback_weapon())
	{
		self zm_weapons::take_fallback_weapon();
	}
	if(primaryweapons.size > weapon_limit)
	{
		if(is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self.laststandpistol === weapon)
		{
			current_weapon = undefined;
		}
		if(isdefined(current_weapon))
		{
			if(!is_offhand_weapon(weapon))
			{
				self zm_weapons::weapon_take(current_weapon);
				if(isdefined(initial_current_weapon) && current_weapon != initial_current_weapon)
				{
					self zm_weapons::weapon_take(initial_current_weapon);
				}
			}
		}
	}
	if(isdefined(level.zombiemode_offhand_weapon_give_override))
	{
		if(self [[level.zombiemode_offhand_weapon_give_override]](weapon))
		{
			return;
		}
	}
	if(is_placeable_mine(weapon))
	{
		self thread zm_placeable_mine::setup_for_player(weapon);
		return weapon;
	}
	if(isdefined(level.zombie_weapons_callbacks) && isdefined(level.zombie_weapons_callbacks[weapon]))
	{
		self thread [[level.zombie_weapons_callbacks[weapon]]]();
	}
	self zm_weapons::function_7c5dd4bd(weapon);
	if(isdefined(self.var_57c1d146[weapon]) && self.var_57c1d146[weapon])
	{
		self.var_57c1d146[weapon] = undefined;
		return;
	}
	if(!is_offhand_weapon(weapon) && !is_hero_weapon(weapon))
	{
		if(!is_melee_weapon(weapon))
		{
			self switchtoweapon(weapon);
		}
		else
		{
			self switchtoweapon(current_weapon);
		}
	}
}

/*
	Name: function_5a5a742a
	Namespace: zm_loadout
	Checksum: 0x1249E542
	Offset: 0xBC0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_5a5a742a(slot)
{
	if(!isdefined(level.var_d5f9c1d2))
	{
		level.var_d5f9c1d2 = [];
	}
	if(!isdefined(level.var_d5f9c1d2[slot]))
	{
		level.var_d5f9c1d2[slot] = [];
	}
	return level.var_d5f9c1d2[slot];
}

/*
	Name: function_e884e095
	Namespace: zm_loadout
	Checksum: 0x8AEC49AD
	Offset: 0xC28
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_e884e095(slot, weapon)
{
	if(isstring(weapon) || function_7a600918(weapon))
	{
		weapon = getweapon(weapon);
	}
	if(weapon.name == #"none")
	{
		return;
	}
	if(function_59b0ef71(slot, weapon))
	{
		return;
	}
	if(!isdefined(level.var_d5f9c1d2))
	{
		level.var_d5f9c1d2 = [];
	}
	if(!isdefined(level.var_d5f9c1d2[slot]))
	{
		level.var_d5f9c1d2[slot] = [];
	}
	level.var_d5f9c1d2[slot][weapon] = weapon;
}

/*
	Name: function_59b0ef71
	Namespace: zm_loadout
	Checksum: 0xBF54ECAE
	Offset: 0xD38
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_59b0ef71(slot, weapon)
{
	if(!isdefined(weapon) || !isdefined(level.var_d5f9c1d2) || !isdefined(level.var_d5f9c1d2[slot]))
	{
		return 0;
	}
	return isdefined(level.var_d5f9c1d2[slot][weapon]);
}

/*
	Name: function_393977df
	Namespace: zm_loadout
	Checksum: 0xB2ADD1C3
	Offset: 0xDA8
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_393977df(slot, weapon)
{
	if(!isdefined(weapon) || weapon == level.weaponnone || !isdefined(self.var_49377865) || !isdefined(self.var_49377865[slot]))
	{
		return 0;
	}
	return self.var_49377865[slot] == weapon;
}

/*
	Name: function_8f85096
	Namespace: zm_loadout
	Checksum: 0x28726CB1
	Offset: 0xE28
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_8f85096(slot)
{
	if(!isdefined(self.var_49377865))
	{
		self.var_49377865 = [];
	}
	if(!isdefined(self.var_49377865[slot]))
	{
		self.var_49377865[slot] = level.weaponnone;
	}
	var_4d5892ca = level.weaponnone;
	if(isdefined(self.var_49377865) && isdefined(self.var_49377865[slot]))
	{
		var_4d5892ca = self.var_49377865[slot];
	}
	return var_4d5892ca;
}

/*
	Name: function_6519eea8
	Namespace: zm_loadout
	Checksum: 0xB9CA9188
	Offset: 0xEC8
	Size: 0x16A
	Parameters: 2
	Flags: Linked
*/
function function_6519eea8(slot, weapon)
{
	if(!isdefined(self.var_49377865))
	{
		self.var_49377865 = [];
	}
	if(!isdefined(self.var_49377865[slot]))
	{
		self.var_49377865[slot] = level.weaponnone;
	}
	if(!isdefined(weapon))
	{
		weapon = level.weaponnone;
	}
	old_weapon = self function_8f85096(slot);
	self notify(#"hash_4078956b159dd0f3", {#weapon:weapon, #slot:slot});
	self notify("new_" + slot, {#weapon:weapon});
	self.var_49377865[slot] = level.weaponnone;
	if(old_weapon != level.weaponnone && old_weapon != weapon)
	{
		if(self hasweapon(old_weapon))
		{
			self takeweapon(old_weapon);
		}
	}
	self.var_49377865[slot] = weapon;
}

/*
	Name: register_lethal_grenade_for_level
	Namespace: zm_loadout
	Checksum: 0xB18617C3
	Offset: 0x1040
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function register_lethal_grenade_for_level(weaponname)
{
	function_e884e095("lethal_grenade", weaponname);
}

/*
	Name: is_lethal_grenade
	Namespace: zm_loadout
	Checksum: 0x4387F95D
	Offset: 0x1070
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_lethal_grenade(weapon)
{
	return function_59b0ef71("lethal_grenade", weapon);
}

/*
	Name: is_player_lethal_grenade
	Namespace: zm_loadout
	Checksum: 0x24572026
	Offset: 0x10A0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_lethal_grenade(weapon)
{
	return self function_393977df("lethal_grenade", weapon);
}

/*
	Name: get_player_lethal_grenade
	Namespace: zm_loadout
	Checksum: 0x65F55156
	Offset: 0x10D8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_player_lethal_grenade()
{
	return self function_8f85096("lethal_grenade");
}

/*
	Name: set_player_lethal_grenade
	Namespace: zm_loadout
	Checksum: 0xCE7CD9C2
	Offset: 0x1108
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_player_lethal_grenade(weapon)
{
	self function_6519eea8("lethal_grenade", weapon);
}

/*
	Name: init_player_lethal_grenade
	Namespace: zm_loadout
	Checksum: 0x325D31F7
	Offset: 0x1140
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function init_player_lethal_grenade()
{
	var_cd6fae8c = self function_2dfb9150("primarygrenade");
	s_weapon = getunlockableiteminfofromindex(var_cd6fae8c, 1);
	w_weapon = level.zombie_lethal_grenade_player_init;
	if(isdefined(s_weapon) && isdefined(s_weapon.var_3cf2d21))
	{
		w_weapon = getweapon(s_weapon.var_3cf2d21);
		self zm_weapons::weapon_give(w_weapon, 1, 0);
	}
	else
	{
		self zm_weapons::weapon_give(level.zombie_lethal_grenade_player_init, 1, 0);
	}
	if(w_weapon.isgadget)
	{
		slot = self gadgetgetslot(w_weapon);
		var_aabc1f49 = (isdefined(self.firstspawn) ? self.firstspawn : 1);
		if(slot >= 0 && var_aabc1f49)
		{
			self gadgetpowerreset(slot, 1);
		}
	}
}

/*
	Name: register_tactical_grenade_for_level
	Namespace: zm_loadout
	Checksum: 0x627CA289
	Offset: 0x12C8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function register_tactical_grenade_for_level(weaponname, var_b1830d98 = 0)
{
	function_e884e095("tactical_grenade", weaponname);
	if(var_b1830d98)
	{
		var_54cae2d8 = getweapon(weaponname);
		level.var_b115fab2 = var_54cae2d8;
	}
}

/*
	Name: is_tactical_grenade
	Namespace: zm_loadout
	Checksum: 0xC002DCDC
	Offset: 0x1348
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function is_tactical_grenade(weapon, var_9f428637 = 1)
{
	if(!var_9f428637 && (isdefined(weapon.isriotshield) && weapon.isriotshield))
	{
		return 0;
	}
	return function_59b0ef71("tactical_grenade", weapon);
}

/*
	Name: is_player_tactical_grenade
	Namespace: zm_loadout
	Checksum: 0x686FEE5F
	Offset: 0x13C8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_tactical_grenade(weapon)
{
	return self function_393977df("tactical_grenade", weapon);
}

/*
	Name: get_player_tactical_grenade
	Namespace: zm_loadout
	Checksum: 0x22F0F049
	Offset: 0x1400
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_player_tactical_grenade()
{
	return self function_8f85096("tactical_grenade");
}

/*
	Name: set_player_tactical_grenade
	Namespace: zm_loadout
	Checksum: 0x894F8BA3
	Offset: 0x1430
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function set_player_tactical_grenade(weapon)
{
	self function_6519eea8("tactical_grenade", weapon);
}

/*
	Name: init_player_tactical_grenade
	Namespace: zm_loadout
	Checksum: 0xCFEB91E1
	Offset: 0x1468
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init_player_tactical_grenade()
{
	self function_6519eea8("tactical_grenade", level.zombie_tactical_grenade_player_init);
}

/*
	Name: is_placeable_mine
	Namespace: zm_loadout
	Checksum: 0x7D2D8711
	Offset: 0x14A0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_placeable_mine(weapon)
{
	return function_59b0ef71("placeable_mine", weapon);
}

/*
	Name: is_player_placeable_mine
	Namespace: zm_loadout
	Checksum: 0xD2E6557F
	Offset: 0x14D0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_placeable_mine(weapon)
{
	return self function_393977df("placeable_mine", weapon);
}

/*
	Name: get_player_placeable_mine
	Namespace: zm_loadout
	Checksum: 0x37F876C8
	Offset: 0x1508
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_player_placeable_mine()
{
	return self function_8f85096("placeable_mine");
}

/*
	Name: set_player_placeable_mine
	Namespace: zm_loadout
	Checksum: 0x3A89F9D1
	Offset: 0x1538
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_player_placeable_mine(weapon)
{
	self function_6519eea8("placeable_mine", weapon);
}

/*
	Name: init_player_placeable_mine
	Namespace: zm_loadout
	Checksum: 0xE866C54F
	Offset: 0x1570
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init_player_placeable_mine()
{
	self function_6519eea8("placeable_mine", level.zombie_placeable_mine_player_init);
}

/*
	Name: register_melee_weapon_for_level
	Namespace: zm_loadout
	Checksum: 0xA1DC99B9
	Offset: 0x15A8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function register_melee_weapon_for_level(weaponname)
{
	function_e884e095("melee_weapon", weaponname);
}

/*
	Name: is_melee_weapon
	Namespace: zm_loadout
	Checksum: 0x31F56FD7
	Offset: 0x15D8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_melee_weapon(weapon)
{
	return function_59b0ef71("melee_weapon", weapon);
}

/*
	Name: is_player_melee_weapon
	Namespace: zm_loadout
	Checksum: 0xF4C3D43A
	Offset: 0x1608
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_melee_weapon(weapon)
{
	return self function_393977df("melee_weapon", weapon);
}

/*
	Name: get_player_melee_weapon
	Namespace: zm_loadout
	Checksum: 0x46EA7DF3
	Offset: 0x1640
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_player_melee_weapon()
{
	return self function_8f85096("melee_weapon");
}

/*
	Name: set_player_melee_weapon
	Namespace: zm_loadout
	Checksum: 0x37FDEADD
	Offset: 0x1670
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function set_player_melee_weapon(weapon)
{
	had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
	self function_6519eea8("melee_weapon", weapon);
	if(had_fallback_weapon)
	{
		self zm_melee_weapon::give_fallback_weapon();
	}
}

/*
	Name: init_player_melee_weapon
	Namespace: zm_loadout
	Checksum: 0x529A5A02
	Offset: 0x16E8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init_player_melee_weapon()
{
	self zm_weapons::weapon_give(level.zombie_melee_weapon_player_init, 1, 0);
}

/*
	Name: register_hero_weapon_for_level
	Namespace: zm_loadout
	Checksum: 0x12C00858
	Offset: 0x1720
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function register_hero_weapon_for_level(weaponname)
{
	function_e884e095("hero_weapon", weaponname);
}

/*
	Name: is_hero_weapon
	Namespace: zm_loadout
	Checksum: 0x13C00B1
	Offset: 0x1750
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_hero_weapon(weapon)
{
	return function_59b0ef71("hero_weapon", weapon);
}

/*
	Name: is_player_hero_weapon
	Namespace: zm_loadout
	Checksum: 0x4D0D7965
	Offset: 0x1780
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_hero_weapon(weapon)
{
	return self function_393977df("hero_weapon", weapon);
}

/*
	Name: get_player_hero_weapon
	Namespace: zm_loadout
	Checksum: 0x6ED5C5B
	Offset: 0x17B8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function get_player_hero_weapon()
{
	return self function_8f85096("hero_weapon");
}

/*
	Name: set_player_hero_weapon
	Namespace: zm_loadout
	Checksum: 0x18D74954
	Offset: 0x17E8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_player_hero_weapon(weapon)
{
	self function_6519eea8("hero_weapon", weapon);
}

/*
	Name: init_player_hero_weapon
	Namespace: zm_loadout
	Checksum: 0xB19E48FE
	Offset: 0x1820
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function init_player_hero_weapon()
{
	self zm_hero_weapon::function_21c786cf();
}

/*
	Name: has_player_hero_weapon
	Namespace: zm_loadout
	Checksum: 0xB98D6F2C
	Offset: 0x1848
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function has_player_hero_weapon()
{
	current_hero_weapon = get_player_hero_weapon();
	return isdefined(current_hero_weapon) && current_hero_weapon != level.weaponnone;
}

/*
	Name: register_offhand_weapons_for_level_defaults
	Namespace: zm_loadout
	Checksum: 0xD746DF0B
	Offset: 0x1888
	Size: 0x216
	Parameters: 0
	Flags: Linked
*/
function register_offhand_weapons_for_level_defaults()
{
	if(isdefined(level.register_offhand_weapons_for_level_defaults_override))
	{
		[[level.register_offhand_weapons_for_level_defaults_override]]();
		return;
	}
	if(isdefined(level.var_22fda912))
	{
		[[level.var_22fda912]]();
	}
	register_lethal_grenade_for_level(#"claymore");
	register_lethal_grenade_for_level(#"eq_acid_bomb");
	register_lethal_grenade_for_level(#"hash_34b7eb9fde56bd35");
	register_lethal_grenade_for_level(#"eq_molotov");
	register_lethal_grenade_for_level(#"hash_c78156ba6aeda14");
	register_lethal_grenade_for_level(#"mini_turret");
	register_lethal_grenade_for_level(#"proximity_grenade");
	register_lethal_grenade_for_level(#"sticky_grenade");
	level.zombie_lethal_grenade_player_init = getweapon(#"hash_34b7eb9fde56bd35");
	register_melee_weapon_for_level(level.weaponbasemelee.name);
	if(namespace_cb7cafc3::function_166646a6() == 1)
	{
		register_melee_weapon_for_level(#"bowie_knife_story_1");
	}
	else
	{
		register_melee_weapon_for_level(#"bowie_knife");
	}
	level.zombie_melee_weapon_player_init = level.weaponbasemelee;
	level.zombie_equipment_player_init = undefined;
}

/*
	Name: init_player_offhand_weapons
	Namespace: zm_loadout
	Checksum: 0xE62BE9D9
	Offset: 0x1AA8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init_player_offhand_weapons()
{
	init_player_lethal_grenade();
	init_player_tactical_grenade();
	init_player_placeable_mine();
	init_player_melee_weapon();
	init_player_hero_weapon();
	zm_equipment::init_player_equipment();
}

/*
	Name: function_2ff6913
	Namespace: zm_loadout
	Checksum: 0x244EF476
	Offset: 0x1B18
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function function_2ff6913(weapon)
{
	return weapon.isperkbottle || weapon.isflourishweapon;
}

/*
	Name: is_offhand_weapon
	Namespace: zm_loadout
	Checksum: 0xF41C2A6F
	Offset: 0x1B48
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function is_offhand_weapon(weapon)
{
	return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

/*
	Name: is_player_offhand_weapon
	Namespace: zm_loadout
	Checksum: 0xDB20D7A4
	Offset: 0x1BF0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function is_player_offhand_weapon(weapon)
{
	return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

/*
	Name: has_powerup_weapon
	Namespace: zm_loadout
	Checksum: 0x897832B3
	Offset: 0x1C98
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function has_powerup_weapon()
{
	return isdefined(self.has_powerup_weapon) && self.has_powerup_weapon;
}

/*
	Name: has_hero_weapon
	Namespace: zm_loadout
	Checksum: 0xA86D4FC0
	Offset: 0x1CB8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function has_hero_weapon()
{
	weapon = self getcurrentweapon();
	return isdefined(weapon.isheroweapon) && weapon.isheroweapon;
}

/*
	Name: give_start_weapon
	Namespace: zm_loadout
	Checksum: 0x324EC483
	Offset: 0x1D08
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function give_start_weapon(b_switch_weapon)
{
	var_9aeb4447 = self function_2dfb9150("primary");
	s_weapon = getunlockableiteminfofromindex(var_9aeb4447, 1);
	if(isdefined(s_weapon) && isdefined(s_weapon.var_3cf2d21) && namespace_59ff1d6c::function_bce642a1(s_weapon) && namespace_59ff1d6c::function_901b751c(#"hash_7bc64c0823c87e41"))
	{
		self zm_weapons::weapon_give(getweapon(s_weapon.var_3cf2d21), 1, b_switch_weapon);
		if(namespace_59ff1d6c::function_901b751c(#"hash_7bc64c0823c87e41") && isdefined(self.var_8313fee5))
		{
			self thread function_d9153457(b_switch_weapon);
		}
	}
	else
	{
		self zm_weapons::weapon_give(level.start_weapon, 1, b_switch_weapon);
		if(isdefined(s_weapon) && (!namespace_59ff1d6c::function_bce642a1(s_weapon) || !namespace_59ff1d6c::function_901b751c(#"hash_7bc64c0823c87e41")))
		{
			self thread namespace_59ff1d6c::function_343353f8();
		}
	}
}

/*
	Name: function_2dfb9150
	Namespace: zm_loadout
	Checksum: 0x54691FC6
	Offset: 0x1ED8
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_2dfb9150(slot)
{
	if(!isdefined(self.class_num))
	{
		self.class_num = self function_cc90c352();
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = 0;
	}
	return self getloadoutitem(self.class_num, slot);
}

/*
	Name: function_439b009a
	Namespace: zm_loadout
	Checksum: 0x722EB26A
	Offset: 0x1F50
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_439b009a(slot)
{
	if(!isdefined(self.class_num))
	{
		self.class_num = self function_cc90c352();
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = 0;
	}
	return self getloadoutweapon(self.class_num, slot);
}

/*
	Name: function_d9153457
	Namespace: zm_loadout
	Checksum: 0x16054671
	Offset: 0x1FC8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_d9153457(b_switch_weapon = 1)
{
	self endon(#"death");
	var_19673a84 = getweapon(self.var_8313fee5);
	if(var_19673a84 !== level.weaponnone)
	{
		self zm_weapons::weapon_give(var_19673a84, 1, 0);
		if(b_switch_weapon)
		{
			level waittill(#"start_zombie_round_logic");
			self switchtoweaponimmediate(var_19673a84, 1);
		}
	}
}

