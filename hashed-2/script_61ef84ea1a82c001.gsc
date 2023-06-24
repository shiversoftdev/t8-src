// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm\weapons\zm_weap_tomahawk.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_273ad667;

/*
	Name: __init__system__
	Namespace: namespace_273ad667
	Checksum: 0x7F6E9973
	Offset: 0x220
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_1f7228023b83d053", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_273ad667
	Checksum: 0x6D71F371
	Offset: 0x270
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"place_spoon", 1, 1, "int");
	clientfield::register("toplayer", "" + #"fill_blood", 1, 4, "int");
	clientfield::register("toplayer", "" + #"hash_2058d8d474a6b3e1", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_cc5b97a575d4d6d", 1, 1, "int");
	clientfield::register("world", "" + #"hash_ef497244490a0fc", 1, 3, "int");
	level flag::init(#"hash_1a367a4a0dfb0471");
	level flag::init(#"hash_79e07d3dcfbfb5ae");
	level flag::init(#"hash_29dc018e9551ecf");
	level flag::init(#"hash_3b1ad1b5bdc81825");
	level.var_92a01e03 = struct::get("s_firm_use_trig");
	level.s_break_large_metal = struct::get("s_break_large_metal");
	level.var_4b9d0136 = util::spawn_model("p8_fxanim_zm_esc_water_tower_mod", level.s_break_large_metal.origin, level.s_break_large_metal.angles);
	level.var_70d41750 = getentarray("t_metal_piece", "targetname");
	callback::on_connect(&vtol_dig);
}

/*
	Name: __main__
	Namespace: namespace_273ad667
	Checksum: 0xCEE99620
	Offset: 0x510
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	/#
		level thread function_d987ffa1();
	#/
	level flag::wait_till("start_zombie_round_logic");
	level.var_ac9cb27a = array(#"hash_67a31e96e8f4d0e9", #"hash_67a31b96e8f4cbd0", #"hash_67a31c96e8f4cd83", #"hash_67a32196e8f4d602");
	level flag::wait_till(#"hash_3b1ad1b5bdc81825");
	zm_spawner::register_zombie_death_event_callback(&function_85cfc2a3);
	foreach(e_player in getplayers())
	{
		e_player thread function_537f413d();
	}
	callback::on_connect(&function_537f413d);
	level.var_92a01e03.var_f53d5b31 = level.var_92a01e03 zm_unitrigger::create(&function_34b43e30, 128, &function_3a563d3c);
	level function_f519d04e();
}

/*
	Name: vtol_dig
	Namespace: namespace_273ad667
	Checksum: 0xFD42C3BA
	Offset: 0x6F0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function vtol_dig()
{
	self endon(#"disconnect");
	self flag::init(#"hash_6b33efdeedf241f");
	self flag::init(#"hash_30ae3926b2d211db");
	self flag::init(#"hash_3ade5b9424a14f81");
	self flag::init(#"hash_79ab766693ef2532");
	self waittill(#"spawned");
	self clientfield::set_to_player("" + #"fill_blood", 1);
}

/*
	Name: function_537f413d
	Namespace: namespace_273ad667
	Checksum: 0x826EBA7
	Offset: 0x7D8
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_537f413d()
{
	self endon(#"disconnect");
	self.var_8c79ac3f = 0;
	self thread function_7927b4f1();
	self flag::wait_till(#"hash_30ae3926b2d211db");
	if(!isdefined(level.var_92a01e03.var_da0824c7))
	{
		level.var_92a01e03.var_da0824c7 = level.var_92a01e03 zm_unitrigger::create(&function_c5c760a1, 128, &function_cd53088e);
	}
}

/*
	Name: function_3a563d3c
	Namespace: namespace_273ad667
	Checksum: 0x3A7107C5
	Offset: 0x898
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_3a563d3c(params)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(isplayer(e_player))
		{
			e_player takeweapon(getweapon(#"spoon_alcatraz"));
			if(isdefined(e_player.var_1c4683c4))
			{
				e_player giveweapon(e_player.var_1c4683c4);
			}
			e_player clientfield::set_to_player("" + #"place_spoon", 1);
			e_player flag::set(#"hash_6b33efdeedf241f");
		}
	}
}

/*
	Name: function_cd53088e
	Namespace: namespace_273ad667
	Checksum: 0x7DB82DB2
	Offset: 0x9D8
	Size: 0x220
	Parameters: 1
	Flags: Linked
*/
function function_cd53088e(params)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(isplayer(e_player) && e_player flag::get(#"hash_30ae3926b2d211db"))
		{
			e_player clientfield::set_to_player("" + #"place_spoon", 0);
			wait(0.1);
			e_player clientfield::set_to_player("" + #"fill_blood", 8);
			e_player flag::set(#"hash_3ade5b9424a14f81");
			playsoundatposition(#"hash_70c32e03adb92ec1", level.var_92a01e03.origin);
			playsoundatposition(#"hash_2f578ca03993ba56", level.var_4b9d0136.origin);
			level flag::set(#"hash_1a367a4a0dfb0471");
			if(level flag::get(#"hash_29dc018e9551ecf"))
			{
				e_player clientfield::set_to_player("" + #"hash_2058d8d474a6b3e1", 1);
				e_player thread function_5ec2f851();
			}
		}
	}
}

/*
	Name: function_5ec2f851
	Namespace: namespace_273ad667
	Checksum: 0x51950E30
	Offset: 0xC00
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5ec2f851()
{
	self endon(#"disconnect", #"hash_17b0a36fa17ca61a");
	var_5c4729d5 = getent("t_r_br_sp2_7", "targetname");
	while(true)
	{
		if(self istouching(var_5c4729d5) && self zm_utility::is_player_looking_at(level.var_4b9d0136.origin, 0.7, 0))
		{
			self clientfield::set_to_player("" + #"hash_cc5b97a575d4d6d", 1);
			self notify(#"hash_17b0a36fa17ca61a");
		}
		wait(1);
	}
}

/*
	Name: function_85cfc2a3
	Namespace: namespace_273ad667
	Checksum: 0x510024D7
	Offset: 0xD00
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_85cfc2a3(e_player)
{
	if(!isplayer(e_player))
	{
		return;
	}
	if(!e_player flag::exists(#"hash_6b33efdeedf241f") || !e_player flag::get(#"hash_6b33efdeedf241f"))
	{
		return;
	}
	if(!isdefined(e_player.var_8c79ac3f))
	{
		return;
	}
	if(function_3bc828f8(self.damageweapon))
	{
		if(e_player.var_3909389c)
		{
			e_player.var_8c79ac3f++;
			/#
				iprintln("" + e_player.var_8c79ac3f);
			#/
			e_player function_7127bd6c(e_player.var_8c79ac3f);
		}
		if(e_player.var_8c79ac3f >= 60)
		{
			e_player notify(#"hash_789b5173793a0f27");
			e_player playsoundtoplayer(#"hash_65b4e7aafb64c1a1", e_player);
			e_player.var_8c79ac3f = undefined;
			e_player flag::set(#"hash_30ae3926b2d211db");
		}
	}
}

/*
	Name: function_7927b4f1
	Namespace: namespace_273ad667
	Checksum: 0x22C4C74B
	Offset: 0xE98
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_7927b4f1()
{
	self endon(#"disconnect", #"hash_789b5173793a0f27");
	while(true)
	{
		var_bdf9e3c2 = self zm_zonemgr::get_player_zone();
		if(var_bdf9e3c2 === "zone_roof" || var_bdf9e3c2 === "zone_roof_infirmary")
		{
			self.var_3909389c = 1;
		}
		else
		{
			self.var_3909389c = 0;
		}
		wait(1);
	}
}

/*
	Name: function_7127bd6c
	Namespace: namespace_273ad667
	Checksum: 0x6E2BF000
	Offset: 0xF38
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function function_7127bd6c(var_8c79ac3f)
{
	switch(var_8c79ac3f)
	{
		case 1:
		{
			self clientfield::set_to_player("" + #"fill_blood", 2);
			break;
		}
		case 13:
		{
			self clientfield::set_to_player("" + #"fill_blood", 3);
			break;
		}
		case 25:
		{
			self clientfield::set_to_player("" + #"fill_blood", 4);
			break;
		}
		case 37:
		{
			self clientfield::set_to_player("" + #"fill_blood", 5);
			break;
		}
		case 49:
		{
			self clientfield::set_to_player("" + #"fill_blood", 6);
			break;
		}
		case 60:
		{
			self clientfield::set_to_player("" + #"fill_blood", 7);
			break;
		}
	}
}

/*
	Name: function_3bc828f8
	Namespace: namespace_273ad667
	Checksum: 0xC5BBFC5
	Offset: 0x10E8
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_3bc828f8(weapon_type)
{
	switch(weapon_type.name)
	{
		case "ww_blundergat_fire_t8":
		case "ww_blundergat_fire_t8_upgraded":
		case "ww_blundergat_acid_t8":
		case "hash_3de0926b89369160":
		case "hash_494f5501b3f8e1e9":
		case "ww_blundergat_acid_t8_upgraded":
		{
			return true;
		}
		default:
		{
			return false;
		}
	}
}

/*
	Name: function_34b43e30
	Namespace: namespace_273ad667
	Checksum: 0x309C6474
	Offset: 0x1198
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_34b43e30(e_player)
{
	return e_player hasweapon(getweapon(#"spoon_alcatraz")) && !e_player flag::get(#"hash_6b33efdeedf241f") && e_player util::is_looking_at(self.origin);
}

/*
	Name: function_c5c760a1
	Namespace: namespace_273ad667
	Checksum: 0x25285653
	Offset: 0x1220
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_c5c760a1(e_player)
{
	return e_player flag::get(#"hash_30ae3926b2d211db") && !e_player flag::get(#"hash_3ade5b9424a14f81");
}

/*
	Name: function_f519d04e
	Namespace: namespace_273ad667
	Checksum: 0xD6F4116
	Offset: 0x1278
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_f519d04e()
{
	/#
		level endon(#"hash_2386148c8bbd1bd5");
	#/
	level flag::wait_till(#"hash_1a367a4a0dfb0471");
	foreach(var_ac652438 in level.var_70d41750)
	{
		var_ac652438 thread function_834ba04a();
	}
	level function_48d7e846();
}

/*
	Name: function_834ba04a
	Namespace: namespace_273ad667
	Checksum: 0x1E701D34
	Offset: 0x1350
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_834ba04a()
{
	self endon(#"death");
	level endon(#"end_game");
	n_script_int = self.script_int;
	self waittill(#"trigger");
	switch(n_script_int)
	{
		case 1:
		{
			hidemiscmodels(self.target);
			level thread clientfield::set("" + #"hash_ef497244490a0fc", 1);
			break;
		}
		case 2:
		{
			hidemiscmodels(self.target);
			level thread clientfield::set("" + #"hash_ef497244490a0fc", 2);
			break;
		}
		case 3:
		{
			hidemiscmodels(self.target);
			level thread clientfield::set("" + #"hash_ef497244490a0fc", 3);
			break;
		}
		case 4:
		{
			hidemiscmodels(self.target);
			level thread clientfield::set("" + #"hash_ef497244490a0fc", 4);
			break;
		}
	}
	self delete();
}

/*
	Name: function_48d7e846
	Namespace: namespace_273ad667
	Checksum: 0x8F7FECBF
	Offset: 0x1570
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function function_48d7e846()
{
	level flag::wait_till_all(level.var_ac9cb27a);
	level flag::set(#"hash_79e07d3dcfbfb5ae");
	level.var_4b9d0136 thread scene::play(#"p8_fxanim_zm_esc_water_tower_bundle", level.var_4b9d0136);
	level thread clientfield::increment("" + #"hash_cd028842e18845e", 1);
	wait(3);
	e_closest = arraygetclosest(level.var_4b9d0136.origin, zm_vo::function_347f7d34());
	if(isalive(e_closest))
	{
		e_closest thread zm_audio::create_and_play_dialog(#"catwalk", #"hash_30b3d33fbe5f5328");
	}
	wait(2);
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_adc74a0d;
	foreach(e_player in level.players)
	{
		if(e_player flag::get(#"hash_3ade5b9424a14f81"))
		{
			e_player thread clientfield::set_to_player("" + #"hash_2058d8d474a6b3e1", 1);
		}
	}
	level flag::set(#"hash_29dc018e9551ecf");
}

/*
	Name: function_adc74a0d
	Namespace: namespace_273ad667
	Checksum: 0x5B3D6B0D
	Offset: 0x1820
	Size: 0x1E4
	Parameters: 2
	Flags: Linked
*/
function function_adc74a0d(e_grenade, n_grenade_charge_power)
{
	if(!isdefined(e_grenade))
	{
		return false;
	}
	if(!isdefined(self))
	{
		return false;
	}
	s_spork = struct::get("s_s_t_loc");
	if(!isdefined(s_spork))
	{
		return false;
	}
	distsq = distancesquared(e_grenade.origin, s_spork.origin);
	if(distsq < (200 * 200) && !self flag::get(#"hash_79ab766693ef2532") && level flag::get(#"hash_29dc018e9551ecf"))
	{
		self clientfield::set_to_player("" + #"hash_2058d8d474a6b3e1", 0);
		var_6e6ec518 = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_7b566fb = util::spawn_model("wpn_t8_zm_spork_world", e_grenade.origin, s_spork.angles);
		var_7b566fb linkto(var_6e6ec518);
		self thread zm_weap_tomahawk::tomahawk_return_player(var_6e6ec518, undefined, 800);
		self thread function_55a05382(var_6e6ec518, var_7b566fb);
		return true;
	}
	return false;
}

/*
	Name: function_55a05382
	Namespace: namespace_273ad667
	Checksum: 0x7BF08D4B
	Offset: 0x1A10
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_55a05382(var_6e6ec518, var_87d57162)
{
	self endon(#"disconnect");
	var_6e6ec518 waittill(#"death");
	var_87d57162 delete();
	w_current = self.currentweapon;
	self zm_melee_weapon::award_melee_weapon(#"spork_alcatraz");
	self flag::set(#"hash_79ab766693ef2532");
	self clientfield::set_to_player("" + #"hash_cc5b97a575d4d6d", 0);
}

/*
	Name: function_14a795c2
	Namespace: namespace_273ad667
	Checksum: 0x34BEDD39
	Offset: 0x1AE8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_14a795c2(e_player)
{
	return !e_player flag::get(#"hash_79ab766693ef2532") && level flag::get(#"hash_29dc018e9551ecf");
}

/*
	Name: function_d987ffa1
	Namespace: namespace_273ad667
	Checksum: 0xB1E5DB77
	Offset: 0x1B48
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_d987ffa1()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_2ad53df2);
		if(getdvarint(#"zm_debug_ee", 0))
		{
			adddebugcommand("");
			adddebugcommand("");
		}
	#/
}

/*
	Name: function_2ad53df2
	Namespace: namespace_273ad667
	Checksum: 0x7FC64FA
	Offset: 0x1BD0
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function function_2ad53df2(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_7ecd9429ad1bc7c7":
			{
				level thread function_45d8a460();
				return true;
				break;
			}
			case "hash_3e92494695e7803f":
			{
				level thread function_3dfa5598();
				return true;
				break;
			}
		}
	#/
}

/*
	Name: function_45d8a460
	Namespace: namespace_273ad667
	Checksum: 0xDBBEE279
	Offset: 0x1C68
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function function_45d8a460()
{
	/#
		foreach(player in level.players)
		{
			level flag::set(#"hash_3b1ad1b5bdc81825");
			if(!player hasweapon(getweapon(#"spoon_alcatraz")))
			{
				while(!isdefined(player.var_1c4683c4))
				{
					player.var_1c4683c4 = player.slot_weapons[#"melee_weapon"];
					wait(0.1);
				}
				w_current = player.currentweapon;
				player giveweapon(getweapon(#"spoon_alcatraz"));
				player switchtoweapon(w_current);
			}
		}
	#/
}

/*
	Name: function_3dfa5598
	Namespace: namespace_273ad667
	Checksum: 0xE05BD3BE
	Offset: 0x1DD8
	Size: 0x240
	Parameters: 0
	Flags: None
*/
function function_3dfa5598()
{
	/#
		foreach(player in level.players)
		{
			if(player hasweapon(getweapon(#"spoon_alcatraz")))
			{
				player takeweapon(getweapon(#"spoon_alcatraz"));
				if(isdefined(player.var_1c4683c4))
				{
					player giveweapon(player.var_1c4683c4);
				}
			}
			player notify(#"hash_789b5173793a0f27");
			player flag::set(#"hash_30ae3926b2d211db");
			if(isdefined(player.var_8c79ac3f))
			{
				player.var_8c79ac3f = undefined;
			}
			player clientfield::set_to_player("" + #"place_spoon", 1);
			player clientfield::set_to_player("" + #"fill_blood", 7);
			if(!isdefined(level.var_92a01e03.var_da0824c7))
			{
				level.var_92a01e03.var_da0824c7 = level.var_92a01e03 zm_unitrigger::create(&function_c5c760a1, 64, &function_cd53088e);
			}
			level function_f519d04e();
		}
	#/
}

