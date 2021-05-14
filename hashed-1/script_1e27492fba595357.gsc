// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_5660bae5b402a1eb;
#using script_6d19030aa9ed8220;
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

#namespace zm_powerup_full_ammo;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_full_ammo
	Checksum: 0x5E99B6C6
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_full_ammo", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_full_ammo
	Checksum: 0x8A9622D3
	Offset: 0x160
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("full_ammo", &grab_full_ammo);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", #"hash_460ca52bf94f19c0", &function_b695b971, 0, 0, 0);
	}
}

/*
	Name: grab_full_ammo
	Namespace: zm_powerup_full_ammo
	Checksum: 0xC33E2117
	Offset: 0x1F0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function grab_full_ammo(player)
{
	if(zm_powerups::function_cfd04802(#"full_ammo"))
	{
		level thread function_dae1df4d(self, player);
	}
	else
	{
		level thread full_ammo_powerup(self, player);
	}
	player thread zm_powerups::powerup_vo("full_ammo");
}

/*
	Name: function_dae1df4d
	Namespace: zm_powerup_full_ammo
	Checksum: 0xBFF3F14B
	Offset: 0x288
	Size: 0x2C4
	Parameters: 2
	Flags: Linked
*/
function function_dae1df4d(var_7d81025, player)
{
	if(isdefined(level.check_player_is_ready_for_ammo))
	{
		if([[level.check_player_is_ready_for_ammo]](player) == 0)
		{
			return;
		}
	}
	a_w_weapons = player getweaponslist(0);
	player.var_655c0753 = undefined;
	player notify(#"zmb_max_ammo");
	player zm_placeable_mine::disable_all_prompts_for_player();
	foreach(w_weapon in a_w_weapons)
	{
		if(level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon))
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
			if(zm_loadout::is_lethal_grenade(w_weapon))
			{
				player thread function_3ecbd9d(w_weapon);
				continue;
			}
			player zm_weapons::ammo_give(w_weapon, 0);
		}
	}
	if(player hasperk(#"specialty_widowswine"))
	{
		player zm_perk_widows_wine::function_46ad87c9();
	}
	player playsoundtoplayer(#"zmb_full_ammo", player);
	if(isdefined(var_7d81025))
	{
		player zm_utility::function_7a35b1d7(var_7d81025.hint);
	}
}

/*
	Name: full_ammo_powerup
	Namespace: zm_powerup_full_ammo
	Checksum: 0x7BC6851A
	Offset: 0x558
	Size: 0x34C
	Parameters: 2
	Flags: Linked
*/
function full_ammo_powerup(drop_item, player)
{
	players = getplayers(player.team);
	if(isdefined(level._get_game_module_players))
	{
		players = [[level._get_game_module_players]](player);
	}
	level notify(#"zmb_max_ammo_level");
	foreach(player in players)
	{
		if(isdefined(level.check_player_is_ready_for_ammo))
		{
			if([[level.check_player_is_ready_for_ammo]](player) == 0)
			{
				continue;
			}
		}
		a_w_weapons = player getweaponslist(0);
		player.var_655c0753 = undefined;
		player notify(#"zmb_max_ammo");
		player zm_placeable_mine::disable_all_prompts_for_player();
		foreach(w_weapon in a_w_weapons)
		{
			if(level.headshots_only && zm_loadout::is_lethal_grenade(w_weapon))
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
				if(zm_loadout::is_lethal_grenade(w_weapon))
				{
					player thread function_3ecbd9d(w_weapon);
					continue;
				}
				player zm_weapons::ammo_give(w_weapon, 0);
			}
		}
		if(player hasperk(#"specialty_widowswine"))
		{
			player zm_perk_widows_wine::function_46ad87c9();
		}
	}
	level thread full_ammo_on_hud(drop_item, player.team);
}

/*
	Name: function_3ecbd9d
	Namespace: zm_powerup_full_ammo
	Checksum: 0xC19910AF
	Offset: 0x8B0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_3ecbd9d(w_weapon)
{
	self endon(#"disconnect");
	n_slot = self gadgetgetslot(w_weapon);
	if(w_weapon == getweapon(#"tomahawk_t8") || w_weapon == getweapon(#"tomahawk_t8_upgraded"))
	{
		while(self function_36dfc05f(n_slot))
		{
			waitframe(1);
		}
		self notify(#"hash_3d73720d4588203c");
		self gadgetpowerset(n_slot, 100);
	}
	else
	{
		self gadgetpowerset(n_slot, 100);
	}
}

/*
	Name: full_ammo_on_hud
	Namespace: zm_powerup_full_ammo
	Checksum: 0xFE8030EA
	Offset: 0x9C8
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function full_ammo_on_hud(drop_item, player_team)
{
	players = getplayers(player_team);
	players[0] playsoundtoteam("zmb_full_ammo", player_team);
	if(isdefined(drop_item) && isdefined(drop_item.hint))
	{
		level zm_utility::function_7a35b1d7(drop_item.hint);
	}
}

/*
	Name: function_b695b971
	Namespace: zm_powerup_full_ammo
	Checksum: 0x82267F78
	Offset: 0xA68
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_b695b971()
{
	return level.zm_genesis_robot_pay_towardsreactswordstart <= 0;
}

