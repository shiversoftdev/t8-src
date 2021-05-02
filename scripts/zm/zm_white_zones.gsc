// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5b4f7a8178990872;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_9146fc8b;

/*
	Name: init
	Namespace: namespace_9146fc8b
	Checksum: 0xABA70B6
	Offset: 0x510
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_spawned(&function_29ec1ad7);
}

/*
	Name: zone_init
	Namespace: namespace_9146fc8b
	Checksum: 0xD388FD0D
	Offset: 0x540
	Size: 0x914
	Parameters: 0
	Flags: Linked
*/
function zone_init()
{
	level flag::init("always_on");
	level flag::set("always_on");
	zm_zonemgr::add_adjacent_zone("zone_security_checkpoint", "zone_street_start", "always_on");
	zm_zonemgr::add_adjacent_zone("zone_street_start", "zone_street_mid", "street_start_to_street_mid", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_street_mid", "culdesac_to_street", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_street_mid", "culdesac_to_street", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_culdesac_yellow", "culdesac_to_street", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_angled_house", "culdesac_to_street", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_angled_house", "culdesac_to_street", 0);
	zm_zonemgr::add_adjacent_zone("zone_street_start", "zone_reinsel_house", "street_start_to_reinsel", 0);
	zm_zonemgr::add_adjacent_zone("zone_reinsel_house", "zone_solitary", "street_start_to_reinsel", 0);
	zm_zonemgr::add_adjacent_zone("zone_reinsel_house", "zone_solitary", "hoggatt_to_reinsel", 0);
	zm_zonemgr::add_adjacent_zone("zone_solitary", "zone_hoggatt_house", "hoggatt_to_reinsel", 0);
	zm_zonemgr::add_adjacent_zone("zone_reinsel_house", "zone_hoggatt_house", "hoggatt_to_reinsel", 0);
	zm_zonemgr::add_adjacent_zone("zone_street_mid", "zone_hoggatt_house", "street_mid_to_hoggat", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_backyard", "zone_hoggatt_house", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_green_house_f1", "culdesac_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_green_house_f2", "culdesac_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_house_f1", "zone_green_house_f2", "culdesac_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_backyard", "zone_green_house_f1", "green_backyard_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_backyard", "zone_green_house_f2", "green_backyard_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_house_f1", "zone_green_house_f2", "green_backyard_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_green_house_f2", "green_backyard_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_street_start", "zone_obrien_house", "street_start_to_obrien", 0);
	zm_zonemgr::add_adjacent_zone("zone_obrien_house", "zone_hammond_house", "hammond_to_obrien", 0);
	zm_zonemgr::add_adjacent_zone("zone_street_mid", "zone_hammond_house", "street_mid_to_hammond", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_backyard", "zone_hammond_house", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_yellow_house_f1", "culdesac_to_yellow_house_f1", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_yellow_house_f2", "culdesac_to_yellow_house_f1", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_house_f1", "zone_yellow_house_f2", "culdesac_to_yellow_house_f1", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_backyard", "zone_yellow_house_f1", "yellow_backyard_to_yellow_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_backyard", "zone_yellow_house_f2", "yellow_backyard_to_yellow_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_house_f1", "zone_yellow_house_f2", "yellow_backyard_to_yellow_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_yellow_house_f2", "yellow_backyard_to_yellow_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_angled_house", "culdesac_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_angled_house", "culdesac_to_green_house", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_green", "zone_angled_house", "culdesac_to_yellow_house_f1", 0);
	zm_zonemgr::add_adjacent_zone("zone_culdesac_yellow", "zone_angled_house", "culdesac_to_yellow_house_f1", 0);
	zm_zonemgr::add_adjacent_zone("zone_yellow_backyard", "zone_bunker_lounge_entrance", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_lounge_entrance", "zone_bunker_lounge", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_green_backyard", "zone_bunker_diner_entrance", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_diner_entrance", "zone_bunker_diner", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_beds_1", "zone_bunker_beds_2", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_beds_1", "zone_bunker_diner", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_diner", "zone_bunker_diner_entrance", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_beds_2", "zone_bunker_lounge", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_lounge", "zone_bunker_lounge_entrance", "backyard_to_bunker", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_beds_1", "zone_bunker_power_1", "bunker_beds_to_bunker_power", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_beds_2", "zone_bunker_power_2", "bunker_beds_to_bunker_power", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_power_1", "zone_bunker_power_2", "bunker_beds_to_bunker_power", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_power_2", "zone_bunker_storage", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_storage", "zone_bunker_storage_entrance", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_storage_entrance", "zone_obrien_house", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_power_1", "zone_bunker_solitary", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_solitary", "zone_bunker_solitary", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_solitary", "zone_reinsel_house", "bunker_power_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_solitary", "zone_bunker_apd", "bunker_boss_event", 0);
	zm_zonemgr::add_adjacent_zone("zone_bunker_storage", "zone_bunker_apd", "bunker_boss_event", 0);
	function_3673cfa1();
}

/*
	Name: function_fb29f7ca
	Namespace: namespace_9146fc8b
	Checksum: 0xFF748EE9
	Offset: 0xE60
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_fb29f7ca()
{
	level endon(#"game_ended");
	level.var_5fa2f970 = [];
	while(zm_zonemgr::any_player_in_zone("zone_security_checkpoint"))
	{
		waitframe(1);
	}
	level.var_5fa2f970 = getentarray("no_starting_powerups", "targetname");
}

/*
	Name: function_3673cfa1
	Namespace: namespace_9146fc8b
	Checksum: 0x7A21919A
	Offset: 0xEE0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_3673cfa1()
{
	level thread function_57ea545d("hammond_to_obrien");
	level thread function_57ea545d("bunker_power_event");
	level thread function_57ea545d("bunker_beds_to_bunker_power");
}

/*
	Name: function_57ea545d
	Namespace: namespace_9146fc8b
	Checksum: 0x801D5CD4
	Offset: 0xF50
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_57ea545d(str_flag)
{
	var_aed93d1d = getentarray(str_flag + "_navmesh_blocker", "targetname");
	if(var_aed93d1d.size > 0)
	{
		array::run_all(var_aed93d1d, &disconnectpaths);
		level flag::wait_till(str_flag);
		array::run_all(var_aed93d1d, &connectpaths);
		array::run_all(var_aed93d1d, &delete);
	}
}

/*
	Name: function_8920570d
	Namespace: namespace_9146fc8b
	Checksum: 0x61436315
	Offset: 0x1020
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_8920570d(str_zone)
{
	if(isdefined(str_zone))
	{
		switch(str_zone)
		{
			case "zone_bunker_storage":
			case "zone_bunker_lounge":
			case "zone_bunker_lounge_entrance":
			case "zone_bunker_power_1":
			case "zone_bunker_power_2":
			case "zone_bunker_beds_2":
			case "zone_bunker_beds_1":
			case "zone_bunker_diner_entrance":
			case "zone_bunker_solitary":
			case "zone_bunker_apd":
			case "zone_bunker_storage_entrance":
			case "zone_bunker_diner":
			{
				return 1;
			}
			default:
			{
				return 0;
			}
		}
	}
	return 0;
}

/*
	Name: function_29ec1ad7
	Namespace: namespace_9146fc8b
	Checksum: 0xE96B3859
	Offset: 0x1130
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_29ec1ad7()
{
	self thread function_8e0b371();
}

/*
	Name: function_8e0b371
	Namespace: namespace_9146fc8b
	Checksum: 0x3405F7E5
	Offset: 0x1158
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_8e0b371()
{
	self endon(#"disconnect");
	while(true)
	{
		if(isalive(self))
		{
			str_location = function_ab7f70b9(self);
			self namespace_2c9e6caa::function_29780fb5((isdefined(str_location) ? str_location : #""));
		}
		else
		{
			self namespace_2c9e6caa::function_29780fb5(#"");
		}
		wait(0.5);
	}
}

/*
	Name: function_ab7f70b9
	Namespace: namespace_9146fc8b
	Checksum: 0x96B5D8CA
	Offset: 0x1218
	Size: 0x45E
	Parameters: 1
	Flags: Linked
*/
function function_ab7f70b9(e_player)
{
	str_zone = e_player zm_zonemgr::get_player_zone();
	if(!isdefined(str_zone))
	{
		return undefined;
	}
	switch(str_zone)
	{
		case "zone_culdesac_green":
		case "zone_culdesac_yellow":
		{
			var_601fee0 = #"hash_4aa0489391d8a215";
			break;
		}
		case "zone_angled_house":
		{
			var_601fee0 = #"hash_2ed7f0b52bd11574";
			break;
		}
		case "zone_green_house_f1":
		{
			var_601fee0 = #"hash_1923631001f38512";
			break;
		}
		case "zone_green_house_f2":
		{
			var_601fee0 = #"hash_1923621001f3835f";
			break;
		}
		case "zone_green_backyard":
		{
			var_601fee0 = #"hash_3d030d65a86f31cc";
			break;
		}
		case "zone_yellow_house_f1":
		{
			var_601fee0 = #"hash_431ca30866da6a25";
			break;
		}
		case "zone_yellow_house_f2":
		{
			var_601fee0 = #"hash_431ca00866da650c";
			break;
		}
		case "zone_yellow_backyard":
		{
			var_601fee0 = #"hash_1277174ca2ba0df";
			break;
		}
		case "hash_11aeb684f2449edb":
		{
			var_601fee0 = #"hash_5ff3990c30bac4bc";
			break;
		}
		case "zone_security_checkpoint":
		{
			var_601fee0 = #"hash_7b20b0be4c557f4e";
			break;
		}
		case "zone_street_start":
		{
			var_601fee0 = #"hash_551b715f4aea3557";
			break;
		}
		case "zone_street_mid":
		{
			var_601fee0 = #"hash_551b725f4aea370a";
			break;
		}
		case "zone_hoggatt_house":
		{
			var_601fee0 = #"hash_5d01269f88dfde25";
			break;
		}
		case "zone_reinsel_house":
		{
			var_601fee0 = #"hash_5d01239f88dfd90c";
			break;
		}
		case "zone_hammond_house":
		{
			var_601fee0 = #"hash_75391930b5467c7e";
			break;
		}
		case "zone_obrien_house":
		{
			var_601fee0 = #"hash_75391830b5467acb";
			break;
		}
		case "zone_bunker_apd":
		{
			var_601fee0 = #"hash_20bd99c897a2920c";
			break;
		}
		case "zone_solitary":
		case "zone_bunker_solitary":
		{
			var_601fee0 = #"hash_314d27b045b35ee4";
			break;
		}
		case "zone_bunker_lounge":
		case "zone_bunker_lounge_entrance":
		{
			var_601fee0 = #"hash_1b60859f3a2f9d03";
			break;
		}
		case "zone_bunker_beds_2":
		case "zone_bunker_beds_1":
		{
			var_601fee0 = #"hash_1ec883f1cf006ca9";
			break;
		}
		case "zone_bunker_diner_entrance":
		case "zone_bunker_diner":
		{
			var_601fee0 = #"hash_352ef8e844f92ce3";
			break;
		}
		case "zone_bunker_storage":
		case "zone_bunker_storage_entrance":
		{
			var_601fee0 = #"hash_575e5c7bf38523da";
			break;
		}
		case "zone_bunker_power_1":
		case "zone_bunker_power_2":
		{
			var_601fee0 = #"hash_24acc68c936da840";
			break;
		}
	}
	return var_601fee0;
}

