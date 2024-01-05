// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_sword_pistol.csc;
#using scripts\zm\weapons\zm_weap_scepter.csc;
#using scripts\zm\weapons\zm_weap_hammer.csc;
#using scripts\zm\weapons\zm_weap_chakram.csc;
#using scripts\zm_common\zm_wallbuy.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_loadout.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace zm_weapons;

/*
	Name: __init__system__
	Namespace: zm_weapons
	Checksum: 0x190E002C
	Offset: 0x108
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weapons
	Checksum: 0x286AABB4
	Offset: 0x158
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level flag::init("weapon_table_loaded");
	callback::on_localclient_connect(&on_player_connect);
	level.weaponnone = getweapon(#"none");
	level.weaponnull = getweapon(#"weapon_null");
	level.var_78032351 = getweapon(#"defaultweapon");
	level.weaponbasemelee = getweapon(#"knife");
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	function_ec38915a();
}

/*
	Name: __main__
	Namespace: zm_weapons
	Checksum: 0xAA49F01A
	Offset: 0x278
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	init_weapons();
}

/*
	Name: on_player_connect
	Namespace: zm_weapons
	Checksum: 0x2D7D70A4
	Offset: 0x298
	Size: 0x248
	Parameters: 1
	Flags: Linked, Private
*/
function private on_player_connect(localclientnum)
{
	if(getmigrationstatus(localclientnum))
	{
		return;
	}
	resetweaponcosts(localclientnum);
	level flag::wait_till("weapon_table_loaded");
	if(getgametypesetting(#"zmwallbuysenabled"))
	{
		level flag::wait_till("weapon_wallbuys_created");
	}
	if(isdefined(level.weapon_costs))
	{
		foreach(weaponcost in level.weapon_costs)
		{
			player_cost = compute_player_weapon_ammo_cost(weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded, undefined, undefined, weaponcost.wonderweapon);
			setweaponcosts(localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost, weaponcost.upgradedweapon);
			if(isdefined(level.var_5a069e6[weaponcost.weapon]))
			{
				w_dw = level.var_5a069e6[weaponcost.weapon];
				var_8afe76d1 = level.var_5a069e6[weaponcost.upgradedweapon];
				if(!isdefined(var_8afe76d1))
				{
					var_8afe76d1 = level.weaponnone;
				}
				setweaponcosts(localclientnum, w_dw, weaponcost.cost, weaponcost.ammo_cost, player_cost, var_8afe76d1);
			}
		}
	}
}

/*
	Name: is_weapon_included
	Namespace: zm_weapons
	Checksum: 0x950C484D
	Offset: 0x4E8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function is_weapon_included(weapon)
{
	if(!isdefined(level._included_weapons))
	{
		return 0;
	}
	return isdefined(level._included_weapons[function_386dacbc(weapon)]);
}

/*
	Name: compute_player_weapon_ammo_cost
	Namespace: zm_weapons
	Checksum: 0xDEB43F0A
	Offset: 0x530
	Size: 0x14A
	Parameters: 6
	Flags: Linked
*/
function compute_player_weapon_ammo_cost(weapon, cost, upgraded, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000, is_wonder_weapon = 0)
{
	w_root = function_386dacbc(weapon);
	if(upgraded)
	{
		if(zm_wallbuy::is_wallbuy(level.zombie_weapons_upgraded[w_root]))
		{
			n_ammo_cost = 4000;
		}
		else
		{
			if(is_wonder_weapon)
			{
				n_ammo_cost = 7500;
			}
			else
			{
				n_ammo_cost = n_upgraded_non_wallbuy_cost;
			}
		}
	}
	else
	{
		if(zm_wallbuy::is_wallbuy(w_root))
		{
			n_ammo_cost = cost;
			n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
		}
		else
		{
			if(is_wonder_weapon)
			{
				n_ammo_cost = 4000;
			}
			else
			{
				n_ammo_cost = n_base_non_wallbuy_cost;
			}
		}
	}
	return n_ammo_cost;
}

/*
	Name: include_weapon
	Namespace: zm_weapons
	Checksum: 0xEE106290
	Offset: 0x688
	Size: 0x2B4
	Parameters: 6
	Flags: Linked
*/
function include_weapon(weapon_name, display_in_box, cost, ammo_cost, upgraded = 0, is_wonder_weapon = 0)
{
	if(!isdefined(level._included_weapons))
	{
		level._included_weapons = [];
	}
	weapon = getweapon(weapon_name);
	level._included_weapons[weapon] = weapon;
	if(!isdefined(level.weapon_costs))
	{
		level.weapon_costs = [];
	}
	if(!isdefined(level.weapon_costs[weapon_name]))
	{
		level.weapon_costs[weapon_name] = spawnstruct();
		level.weapon_costs[weapon_name].weapon = weapon;
		level.weapon_costs[weapon_name].upgradedweapon = level.weaponnone;
		level.weapon_costs[weapon_name].wonderweapon = is_wonder_weapon;
	}
	level.weapon_costs[weapon_name].cost = cost;
	if(!isdefined(ammo_cost) || ammo_cost == 0)
	{
		ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
	}
	level.weapon_costs[weapon_name].ammo_cost = ammo_cost;
	level.weapon_costs[weapon_name].upgraded = upgraded;
	if(isdefined(display_in_box) && !display_in_box)
	{
		return;
	}
	if(!isdefined(level._resetzombieboxweapons))
	{
		level._resetzombieboxweapons = 1;
		resetzombieboxweapons();
	}
	if(!isdefined(weapon.worldmodel))
	{
		/#
			thread util::error(("" + function_9e72a96(weapon_name)) + "");
		#/
		return;
	}
	addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
}

/*
	Name: include_upgraded_weapon
	Namespace: zm_weapons
	Checksum: 0x5E6DD579
	Offset: 0x948
	Size: 0x10E
	Parameters: 6
	Flags: Linked
*/
function include_upgraded_weapon(weapon_name, upgrade_name, display_in_box, cost, ammo_cost, is_wonder_weapon = 0)
{
	include_weapon(upgrade_name, display_in_box, cost, ammo_cost, 1, is_wonder_weapon);
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	weapon = getweapon(weapon_name);
	upgrade = getweapon(upgrade_name);
	level.zombie_weapons_upgraded[upgrade] = weapon;
	if(isdefined(level.weapon_costs[weapon_name]))
	{
		level.weapon_costs[weapon_name].upgradedweapon = upgrade;
	}
}

/*
	Name: is_weapon_upgraded
	Namespace: zm_weapons
	Checksum: 0xDD3D6050
	Offset: 0xA60
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function is_weapon_upgraded(weapon)
{
	if(!isdefined(level.zombie_weapons_upgraded))
	{
		level.zombie_weapons_upgraded = [];
	}
	rootweapon = function_386dacbc(weapon);
	if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
	{
		return true;
	}
	return false;
}

/*
	Name: checkstringvalid
	Namespace: zm_weapons
	Checksum: 0x64D613B7
	Offset: 0xAD0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function checkstringvalid(str)
{
	if(str != "")
	{
		return str;
	}
	return undefined;
}

/*
	Name: init_weapons
	Namespace: zm_weapons
	Checksum: 0x8C728D2
	Offset: 0xB00
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
	level flag::set("weapon_table_loaded");
	level.var_c60359dc = undefined;
}

/*
	Name: load_weapon_spec_from_table
	Namespace: zm_weapons
	Checksum: 0xCC05648D
	Offset: 0xC50
	Size: 0x38A
	Parameters: 2
	Flags: Linked
*/
function load_weapon_spec_from_table(table, first_row)
{
	gametype = util::get_game_type();
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
		cost = row[3];
		weaponvo = checkstringvalid(row[4]);
		weaponvoresp = checkstringvalid(row[5]);
		ammo_cost = row[6];
		create_vox = row[7];
		is_zcleansed = row[8];
		in_box = row[9];
		upgrade_in_box = row[10];
		is_limited = row[11];
		limit = row[12];
		upgrade_limit = row[13];
		content_restrict = row[14];
		wallbuy_autospawn = row[15];
		weapon_class = checkstringvalid(row[16]);
		is_wonder_weapon = row[18];
		tier = row[19];
		include_weapon(weapon_name, in_box, cost, ammo_cost, 0, is_wonder_weapon);
		if(isdefined(upgrade_name))
		{
			include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500, is_wonder_weapon);
		}
		index++;
		row = tablelookuprow(table, index);
	}
}

/*
	Name: function_ec38915a
	Namespace: zm_weapons
	Checksum: 0xE18AE8F0
	Offset: 0xFE8
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
	function_8005e7f3(getweapon(#"smg_handling_t8"), getweapon(#"smg_handling_t8_dw"));
	function_8005e7f3(getweapon(#"smg_handling_t8_upgraded"), getweapon(#"smg_handling_t8_upgraded_dw"));
	function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw"), getweapon(#"special_ballisticknife_t8_dw_dw"));
	function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw_upgraded"), getweapon(#"special_ballisticknife_t8_dw_upgraded_dw"));
}

/*
	Name: function_8005e7f3
	Namespace: zm_weapons
	Checksum: 0xD7844838
	Offset: 0x1178
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
	Name: function_386dacbc
	Namespace: zm_weapons
	Checksum: 0xE87793E5
	Offset: 0x11F0
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

