// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1ac263b07ef50ab6;
#using script_5660bae5b402a1eb;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_b6737b02;

/*
	Name: function_89f2df9
	Namespace: namespace_b6737b02
	Checksum: 0x36B3B568
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2a62a00449e2e702", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b6737b02
	Checksum: 0xBB4FBC6E
	Offset: 0x168
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("small_ammo", &function_81558cdf);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("small_ammo", "p7_zm_power_up_max_ammo", #"hash_69256172c78db147", &zm_powerups::func_should_never_drop, 1, 0, 0);
	}
}

/*
	Name: function_81558cdf
	Namespace: namespace_b6737b02
	Checksum: 0x9006C652
	Offset: 0x1F8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_81558cdf(player)
{
	if(zm_powerups::function_cfd04802(#"small_ammo"))
	{
		level thread function_d7d24283(self, player);
	}
	else
	{
		level thread function_8be02874(self, player);
	}
}

/*
	Name: function_d7d24283
	Namespace: namespace_b6737b02
	Checksum: 0xE58394FC
	Offset: 0x270
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_d7d24283(var_7d81025, player)
{
	if(isdefined(level.check_player_is_ready_for_ammo))
	{
		if([[level.check_player_is_ready_for_ammo]](player) == 0)
		{
			return;
		}
	}
	function_ae7afb91(player);
	player playsoundtoplayer(#"zmb_full_ammo", player);
}

/*
	Name: function_8be02874
	Namespace: namespace_b6737b02
	Checksum: 0xC04A1E8F
	Offset: 0x2F0
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_8be02874(drop_item, player)
{
	players = getplayers(player.team);
	if(isdefined(level._get_game_module_players))
	{
		players = [[level._get_game_module_players]](player);
	}
	level notify(#"hash_41ccd6a10f7370cc");
	foreach(player in players)
	{
		if(isdefined(level.check_player_is_ready_for_ammo))
		{
			if([[level.check_player_is_ready_for_ammo]](player) == 0)
			{
				continue;
			}
		}
		function_ae7afb91(player);
	}
	level thread function_71bf1101(drop_item, player.team);
}

/*
	Name: function_ae7afb91
	Namespace: namespace_b6737b02
	Checksum: 0x51269DF6
	Offset: 0x428
	Size: 0x1E0
	Parameters: 1
	Flags: Linked
*/
function function_ae7afb91(player)
{
	a_w_weapons = player getweaponslist(0);
	player.var_655c0753 = undefined;
	player notify(#"zmb_small_ammo");
	player zm_placeable_mine::disable_all_prompts_for_player();
	foreach(w_weapon in a_w_weapons)
	{
		if(zm_loadout::is_lethal_grenade(w_weapon) || zm_loadout::is_offhand_weapon(w_weapon))
		{
			continue;
		}
		if(isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[w_weapon]) && (!(isdefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)))
		{
			continue;
		}
		if(isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[w_weapon.name]))
		{
			continue;
		}
		if(zm_loadout::is_hero_weapon(w_weapon))
		{
			continue;
		}
		if(player hasweapon(w_weapon))
		{
			player function_7374e868(w_weapon);
		}
	}
}

/*
	Name: function_71bf1101
	Namespace: namespace_b6737b02
	Checksum: 0xAF2E4378
	Offset: 0x610
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_71bf1101(drop_item, player_team)
{
	players = getplayers(player_team);
	players[0] playsoundtoteam("zmb_full_ammo", player_team);
}

/*
	Name: function_7374e868
	Namespace: namespace_b6737b02
	Checksum: 0xE7021237
	Offset: 0x678
	Size: 0x206
	Parameters: 1
	Flags: Linked
*/
function function_7374e868(weapon)
{
	var_cd9d17e0 = 0;
	if(!zm_loadout::is_offhand_weapon(weapon) || weapon.isriotshield)
	{
		weapon = self zm_weapons::get_weapon_with_attachments(weapon);
		if(isdefined(weapon))
		{
			var_cb48c3c9 = weapon.maxammo;
			var_ef0714fa = weapon.startammo;
			n_clip_size = weapon.clipsize;
			var_5916b9ab = 0;
			if(weapon.dualwieldweapon != level.weaponnone)
			{
				var_5916b9ab = weapon.dualwieldweapon.clipsize;
			}
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
				n_ammo_max = n_ammo_max * 2;
			}
			if(var_b8624c26 >= ((n_ammo_max + n_clip_size) + var_5916b9ab))
			{
				var_cd9d17e0 = 0;
			}
			else
			{
				var_cd9d17e0 = 1;
			}
		}
	}
	else if(self zm_weapons::has_weapon_or_upgrade(weapon))
	{
		if(self getammocount(weapon) < weapon.maxammo)
		{
			var_cd9d17e0 = 1;
		}
	}
	if(var_cd9d17e0)
	{
		self give_clip_of_ammo(weapon);
		return true;
	}
	if(!var_cd9d17e0)
	{
		return false;
	}
}

/*
	Name: give_clip_of_ammo
	Namespace: namespace_b6737b02
	Checksum: 0x831A9706
	Offset: 0x888
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function give_clip_of_ammo(w_weapon)
{
	if(zm_loadout::function_2ff6913(w_weapon))
	{
		return;
	}
	if(!self hasweapon(w_weapon))
	{
		return;
	}
	self notify(#"hash_64f02bb4452a4bd7");
	if(namespace_4b9b8ded::is_active(1))
	{
		self function_7f7c1226(w_weapon);
		return;
	}
	n_clip = 0;
	var_98f6dae8 = self getweaponammoclip(w_weapon);
	n_pool = 0;
	var_df670713 = self getammocount(w_weapon);
	if(self hasperk(#"specialty_extraammo"))
	{
		n_pool = w_weapon.maxammo;
	}
	else
	{
		n_pool = w_weapon.startammo;
	}
	if(weaponhasattachment(w_weapon, "uber") && w_weapon.statname == #"smg_capacity_t8" || (isdefined(w_weapon.isriotshield) && w_weapon.isriotshield))
	{
		n_clip = w_weapon.clipsize / 4;
	}
	else
	{
		n_clip = w_weapon.clipsize;
	}
	n_stock = int(min(n_pool, (var_df670713 - var_98f6dae8) + n_clip));
	self setweaponammostock(w_weapon, n_stock);
}

/*
	Name: function_7f7c1226
	Namespace: namespace_b6737b02
	Checksum: 0xAEC6AA3B
	Offset: 0xAA8
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7f7c1226(weapon)
{
	waittillframeend();
	if(weaponhasattachment(weapon, "uber") && weapon.statname == #"smg_capacity_t8" || (isdefined(weapon.isriotshield) && weapon.isriotshield))
	{
		n_stock = weapon.clipsize / 4;
	}
	else
	{
		n_stock = 0;
	}
	self setweaponammostock(weapon, n_stock);
}

