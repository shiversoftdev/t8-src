// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\gadgets\gadget_homunculus.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\weapons\sensor_dart.gsc;
#using scripts\mp_common\armor.gsc;
#using scripts\mp_common\item_world_util.gsc;
#using script_cb32d07c95e5628;
#using script_3a6e1cc57d28db61;
#using script_6b993fdc7adc35ec;
#using scripts\mp_common\item_inventory.gsc;
#using scripts\mp_common\item_drop.gsc;
#using scripts\mp_common\dynent_world.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace item_world;

/*
	Name: __init__system__
	Namespace: item_world
	Checksum: 0x307C2D71
	Offset: 0x3C8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"item_world", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: item_world
	Checksum: 0xB75A8503
	Offset: 0x410
	Size: 0x5E4
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	level.var_9cddbf4e = [];
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_01_mod"] = {#hash_b9492c6:#"hash_32f9ba3b1da75ed5", #open_sound:#"hash_3462cfb200a2367"};
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_04_mod"] = {#hash_b9492c6:#"hash_32f9ba3b1da75ed5", #open_sound:#"hash_3462cfb200a2367"};
	level.var_9cddbf4e[#"p8_fxanim_wz_death_stash_mod"] = {#hash_b9492c6:#"hash_70fb2ee1b706a28a", #open_sound:#"hash_5e8b0f6cade25ff6"};
	level.var_9cddbf4e[#"hash_1dcbe8021fb16344"] = {#hash_b9492c6:#"hash_6fcb29cae6678d93", #open_sound:#"hash_56b5b65c141f4629"};
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_ammo_mod"] = {#hash_b9492c6:#"hash_3e62bcbd6460ff44", #open_sound:#"hash_f743d336f8b7764"};
	level.var_9cddbf4e[#"hash_574076754776e003"] = {#hash_b9492c6:#"hash_22f426a8593609e8", #open_sound:#"hash_36e23ce3e5f7e4c0"};
	level.var_9cddbf4e[#"wpn_t7_drop_box_wz"] = {#hash_b9492c6:#"hash_2b751d50426093db", #open_sound:#"hash_613f8a1669f8b231"};
	callback::on_connect(&_on_player_connect);
	callback::on_spawned(&_on_player_spawned);
	callback::on_disconnect(&_on_player_disconnect);
	callback::add_callback(#"hash_41781454d98b676a", &function_9aefb438);
	clientfield::register("world", "item_world_seed", 1, 31, "int");
	clientfield::register("world", "item_world_disable", 1, 1, "int");
	clientfield::register("scriptmover", "item_world_attachments", 10000, 1, "int");
	clientfield::register_clientuimodel("hudItems.pickupHintGold", 1, 1, "int", 1);
	clientfield::register("toplayer", "disableItemPickup", 18000, 1, "int");
	function_116fd9a7();
	level thread function_f7fb8a17(0);
	level thread function_e1965ae1();
	level.var_703d32de = 0;
	level.var_17c7288a = &function_23b313bd;
	level.nullprimaryoffhand = getweapon(#"null_offhand_primary");
	level.nullsecondaryoffhand = getweapon(#"null_offhand_secondary");
	level thread namespace_65181344::init_spawn_system();
	if(!isdefined(level.var_227b9e91))
	{
		level.var_227b9e91 = new throttle();
		[[ level.var_227b9e91 ]]->initialize(4, 0.05);
	}
	level.var_3dfbaf65 = &function_8e0d14c1;
	level thread function_df1098a();
	level thread function_248022d9();
}

/*
	Name: function_e6ea1ee0
	Namespace: item_world
	Checksum: 0x39C97B04
	Offset: 0xA00
	Size: 0x72
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e6ea1ee0()
{
	[[ level.var_227b9e91 ]]->waitinqueue(self);
	var_fee74908 = function_784b5aa6();
	var_fee74908[var_fee74908.size] = (level flagsys::get(#"item_world_reset") ? 1 : 0);
	return var_fee74908;
}

/*
	Name: function_e0b64358
	Namespace: item_world
	Checksum: 0x45D5384E
	Offset: 0xA80
	Size: 0x1FA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e0b64358(player, item)
{
	if(!isdefined(player) || !isdefined(item))
	{
		return;
	}
	stash = item_world_util::function_31f5aa51(item);
	if(isdefined(stash) && (isdefined(stash.lootlocker) && stash.lootlocker))
	{
		var_97809692 = player item_inventory::function_2e711614(15);
		if(isdefined(var_97809692) && isdefined(var_97809692.var_a6762160) && var_97809692.var_a6762160.name == #"resource_item_loot_locker_key")
		{
			player item_inventory::use_inventory_item(var_97809692.var_bd027dd9, 1);
			if(!isdefined(player.var_fbcc86d3))
			{
				player.var_fbcc86d3 = [];
			}
			player.var_fbcc86d3[item.var_a6762160.weapon.name] = 1;
		}
		var_97809692 = player item_inventory::function_2e711614(15);
		if(!isdefined(var_97809692) || !isdefined(var_97809692.var_a6762160) || var_97809692.var_a6762160.name != #"resource_item_loot_locker_key")
		{
			stash.var_193b3626 = undefined;
		}
		if(!isdefined(stash.var_80b1d504))
		{
			stash.var_80b1d504 = 0;
		}
		stash.var_80b1d504 = stash.var_80b1d504 + 1;
	}
}

/*
	Name: function_f3b6e182
	Namespace: item_world
	Checksum: 0xED7E9B1A
	Offset: 0xC88
	Size: 0x20C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f3b6e182(player)
{
	/#
		assert(isplayer(player));
	#/
	usetrigger = spawn("trigger_radius_use", vectorscale((0, 0, -1), 10000), 0, 128, 72);
	usetrigger triggerignoreteam();
	usetrigger setinvisibletoall();
	usetrigger setvisibletoplayer(self);
	usetrigger setteamfortrigger(#"none");
	usetrigger setcursorhint("HINT_NOICON");
	usetrigger triggerenable(0);
	usetrigger function_89fca53b(0);
	usetrigger function_49462027(1, (((1 | 16) | 8388608) | 65536) | 4194304);
	player.var_207c9892 = getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000;
	function_dae4ab9b(usetrigger, player.var_207c9892);
	player clientclaimtrigger(usetrigger);
	player.var_19caeeea = usetrigger;
	usetrigger callback::on_trigger(&function_ad7ad6ce);
}

/*
	Name: function_b516210b
	Namespace: item_world
	Checksum: 0x834BFB80
	Offset: 0xEA0
	Size: 0x230
	Parameters: 3
	Flags: Linked, Private
*/
function private function_b516210b(var_889058cc, origin, activator)
{
	if(!isplayer(activator))
	{
		return;
	}
	var_cde95668 = isdefined(activator) && activator hasperk(#"specialty_quieter");
	if(isdefined(level.var_9cddbf4e[var_889058cc]))
	{
		mapping = level.var_9cddbf4e[var_889058cc];
		open_sound = playsoundatposition(mapping.open_sound, origin + vectorscale((0, 0, 1), 50));
		if(isdefined(open_sound))
		{
			open_sound hide();
		}
		var_b9492c6 = playsoundatposition(mapping.var_b9492c6, origin + vectorscale((0, 0, 1), 50));
		if(isdefined(var_b9492c6))
		{
			var_b9492c6 hide();
		}
		foreach(player in getplayers())
		{
			if(var_cde95668 && !player hasperk(#"specialty_loudenemies"))
			{
				if(isdefined(var_b9492c6))
				{
					var_b9492c6 showtoplayer(player);
				}
				continue;
			}
			if(isdefined(open_sound))
			{
				open_sound showtoplayer(player);
			}
		}
	}
}

/*
	Name: function_d045e83b
	Namespace: item_world
	Checksum: 0xE25C16B1
	Offset: 0x10D8
	Size: 0x132
	Parameters: 7
	Flags: Linked, Private
*/
function private function_d045e83b(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slot)
{
	if(item.var_a6762160.itemtype !== #"ammo")
	{
		/#
			assertmsg(("" + item.name) + "");
		#/
		return 0;
	}
	if(!self item_inventory::can_pickup_ammo(item))
	{
		return (isdefined(var_aec6fa7f) ? var_aec6fa7f : (isdefined(item.var_a6762160.var_a6762160.amount) ? item.var_a6762160.amount : 1));
	}
	player function_b00db06(8, itemid);
	return player item_inventory::equip_ammo(item, var_aec6fa7f);
}

/*
	Name: function_2e5b5858
	Namespace: item_world
	Checksum: 0x5B992843
	Offset: 0x1218
	Size: 0x200
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2e5b5858(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	droppeditem = undefined;
	var_3d1f9df4 = 0;
	var_b0938bd7 = undefined;
	var_381f3b39 = 0;
	if(player armor::has_armor())
	{
		inventoryitem = player.inventory.items[11];
		if(inventoryitem.var_bd027dd9 != 32767)
		{
			droppeditem = inventoryitem.var_a6762160;
			var_3d1f9df4 = droppeditem.amount;
		}
	}
	player item_inventory::drop_armor();
	var_77e61fc6 = player item_inventory::give_inventory_item(item, 1, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		if(player item_inventory::function_fba4a353(item))
		{
			player item_inventory::equip_armor(item);
			var_b0938bd7 = item.var_a6762160;
			var_381f3b39 = item.var_a6762160.amount;
		}
	}
	function_1a46c8ae(player, droppeditem, var_3d1f9df4, var_b0938bd7, var_381f3b39);
	return var_77e61fc6;
}

/*
	Name: function_cb9b4dd7
	Namespace: item_world
	Checksum: 0x3D09CC7A
	Offset: 0x1420
	Size: 0x80
	Parameters: 7
	Flags: Linked, Private
*/
function private function_cb9b4dd7(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	player item_inventory::function_3d113bfb();
	return var_77e61fc6;
}

/*
	Name: function_14b2eddf
	Namespace: item_world
	Checksum: 0xD478A3C0
	Offset: 0x14A8
	Size: 0x178
	Parameters: 7
	Flags: Linked, Private
*/
function private function_14b2eddf(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_f0dc4e93 = player item_inventory::function_ec087745();
	var_4838b749 = undefined;
	if(isdefined(var_f0dc4e93) && var_f0dc4e93 != 32767)
	{
		var_4838b749 = player item_inventory::function_b246c573(var_f0dc4e93);
	}
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	if(isdefined(var_4838b749) && isdefined(slotid) && namespace_a0d533d1::function_398b9770(var_4838b749, slotid))
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		player item_inventory::equip_attachment(item, var_f0dc4e93, undefined, 0);
	}
	return var_77e61fc6;
}

/*
	Name: function_42ffe9b2
	Namespace: item_world
	Checksum: 0x8746470F
	Offset: 0x1628
	Size: 0x110
	Parameters: 7
	Flags: Linked, Private
*/
function private function_42ffe9b2(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	if(player item_inventory::function_fba4a353(item))
	{
		slotid = 13;
	}
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	if(var_77e61fc6 < itemcount && slotid === 13)
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		player item_inventory::equip_backpack(item);
	}
	return var_77e61fc6;
}

/*
	Name: function_2eebeff5
	Namespace: item_world
	Checksum: 0x548ACF6B
	Offset: 0x1740
	Size: 0xF8
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2eebeff5(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		if(player item_inventory::function_fba4a353(item))
		{
			player thread item_inventory::equip_equipment(item);
		}
	}
	return var_77e61fc6;
}

/*
	Name: function_349d4c26
	Namespace: item_world
	Checksum: 0xEFA8BF38
	Offset: 0x1840
	Size: 0xF0
	Parameters: 7
	Flags: Linked, Private
*/
function private function_349d4c26(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		if(player item_inventory::function_fba4a353(item))
		{
			player thread item_inventory::equip_health(item);
		}
	}
	return var_77e61fc6;
}

/*
	Name: function_670cce3f
	Namespace: item_world
	Checksum: 0x27DA6B48
	Offset: 0x1938
	Size: 0x6A
	Parameters: 7
	Flags: Linked, Private
*/
function private function_670cce3f(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	return var_77e61fc6;
}

/*
	Name: function_41a52251
	Namespace: item_world
	Checksum: 0xB991E6D1
	Offset: 0x19B0
	Size: 0x6A
	Parameters: 7
	Flags: Linked, Private
*/
function private function_41a52251(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	return var_77e61fc6;
}

/*
	Name: function_2b2e9302
	Namespace: item_world
	Checksum: 0xBD3BF315
	Offset: 0x1A28
	Size: 0x90
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2b2e9302(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	player callback::callback(#"hash_3b891b6daa75c782", item);
	return var_77e61fc6;
}

/*
	Name: function_a240798a
	Namespace: item_world
	Checksum: 0x4C73E20E
	Offset: 0x1AC0
	Size: 0x6A
	Parameters: 7
	Flags: Linked, Private
*/
function private function_a240798a(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
	return var_77e61fc6;
}

/*
	Name: function_a712496a
	Namespace: item_world
	Checksum: 0xE9CE1164
	Offset: 0x1B38
	Size: 0x220
	Parameters: 7
	Flags: Linked, Private
*/
function private function_a712496a(item, player, var_bd027dd9, itemid, itemcount, var_aec6fa7f, slotid)
{
	/#
		assert(isplayer(self));
	#/
	if(item_inventory::get_weapon_count() == 2)
	{
		stashitem = item.hidetime === -1;
		stashitem = stashitem & (~(isdefined(item.deathstash) ? item.deathstash : 0));
		weaponitem = item_inventory::function_230ceec4(player.currentweapon);
		if(!isdefined(weaponitem))
		{
			player takeweapon(player.currentweapon);
		}
		else
		{
			player thread item_inventory::drop_inventory_item(weaponitem.var_bd027dd9, stashitem, item.origin, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname));
		}
	}
	var_77e61fc6 = player item_inventory::give_inventory_item(item, itemcount, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && item_world_util::function_db35e94f(item.var_bd027dd9))
		{
			item = item_inventory::get_inventory_item(item.var_bd027dd9);
		}
		player item_inventory::equip_weapon(item, 1, 1, 0, 1);
	}
	return var_77e61fc6;
}

/*
	Name: function_e1965ae1
	Namespace: item_world
	Checksum: 0x90CE3B09
	Offset: 0x1D60
	Size: 0x4D8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e1965ae1()
{
	level endon(#"game_ended");
	waitframe(1);
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	util::wait_network_frame(1);
	level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
	setdvar(#"hash_21e070fbb56cf0f", 0);
	if(isdefined(level.item_spawn_stashes))
	{
		foreach(supply_stash in level.item_spawn_stashes)
		{
			setdynentenabled(supply_stash, 1);
		}
	}
	foreach(player in getplayers())
	{
		if(isplayer(player))
		{
			player weaponobjects::function_ac7c2bf9();
		}
	}
	var_f997302a = getentarraybytype(4);
	for(index = 0; index < var_f997302a.size; index++)
	{
		if(isdefined(var_f997302a[index]))
		{
			var_f997302a[index] delete();
		}
	}
	foreach(homunculus in level.var_2da60c10)
	{
		if(isdefined(homunculus))
		{
			homunculus gadget_homunculus::function_7bfc867f();
		}
	}
	reset_item_world();
	if((isdefined(getgametypesetting(#"hash_7d8c969e384dd1c9")) ? getgametypesetting(#"hash_7d8c969e384dd1c9") : 0) || (isdefined(getgametypesetting(#"wzheavymetalheroes")) ? getgametypesetting(#"wzheavymetalheroes") : 0))
	{
		if(isdefined(level.var_5c14d2e6))
		{
			foreach(player in getplayers())
			{
				player thread [[level.var_5c14d2e6]]();
			}
		}
	}
	foreach(player in getplayers())
	{
		player thread item_inventory::function_461de298();
	}
	/#
		foreach(player in getplayers())
		{
			player thread function_76eb9bd7();
		}
	#/
}

/*
	Name: function_5019e563
	Namespace: item_world
	Checksum: 0x304A5810
	Offset: 0x2240
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event function_5019e563(eventstruct)
{
	if(!isdefined(self.var_554ec2e2))
	{
		return;
	}
	if(!(isdefined(eventstruct.freefall) && eventstruct.freefall) && (!(isdefined(eventstruct.var_695a7111) && eventstruct.var_695a7111)))
	{
		self thread [[self.var_554ec2e2]]();
	}
}

/*
	Name: function_87b05fa3
	Namespace: item_world
	Checksum: 0x192881A5
	Offset: 0x22C0
	Size: 0x4C
	Parameters: 1
	Flags: Event
*/
event function_87b05fa3(eventstruct)
{
	if(!isdefined(self.var_554ec2e2))
	{
		return;
	}
	if(!(isdefined(eventstruct.parachute) && eventstruct.parachute))
	{
		self thread [[self.var_554ec2e2]]();
	}
}

/*
	Name: function_f7fb8a17
	Namespace: item_world
	Checksum: 0xDFF544F4
	Offset: 0x2318
	Size: 0x25C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f7fb8a17(reset = 1)
{
	level endon(#"game_ended");
	waitframe(1);
	level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
	level flagsys::set(#"hash_2d3b2a4d082ba5ee");
	if(level flagsys::get(#"item_world_reset"))
	{
		return;
	}
	waitframe(1);
	level flagsys::clear(#"item_world_initialized");
	var_47f2f5fa = (1 << 29) - 1;
	var_582cb7bb = randomintrange(0, var_47f2f5fa) + 1;
	/#
		var_582cb7bb = getdvarint(#"hash_46870e6b25b988eb", var_582cb7bb);
	#/
	level.item_spawn_seed = var_582cb7bb;
	match_record::set_stat(#"item_spawn_seed", var_582cb7bb);
	setdvar(#"hash_21e070fbb56cf0f", 0);
	var_6937495e = var_582cb7bb << 1;
	var_6937495e = var_6937495e | (reset ? 1 : 0);
	level clientfield::set("item_world_seed", var_6937495e);
	level namespace_f0884ae5::setup(var_582cb7bb, reset);
	level flagsys::set(#"item_world_initialized");
	if(reset)
	{
		level flagsys::set(#"item_world_reset");
	}
	level flagsys::clear(#"hash_2d3b2a4d082ba5ee");
}

/*
	Name: function_a7b7d70b
	Namespace: item_world
	Checksum: 0x23E48BE6
	Offset: 0x2580
	Size: 0xAC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a7b7d70b(player, var_bd027dd9)
{
	item = player item_inventory::get_inventory_item(var_bd027dd9);
	if(isdefined(item) && isdefined(item.var_a6762160) && (isdefined(item.var_a6762160.consumable) && item.var_a6762160.consumable))
	{
		player function_b00db06(15, item.var_bd027dd9);
	}
}

/*
	Name: function_8bac489c
	Namespace: item_world
	Checksum: 0x45AA8E
	Offset: 0x2638
	Size: 0x80
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8bac489c(supplystash, player)
{
	/#
		assert(isdefined(supplystash));
	#/
	/#
		assert(isplayer(player));
	#/
	if(supplystash.var_193b3626 === player getentitynumber())
	{
		return true;
	}
	return false;
}

/*
	Name: function_35c26e09
	Namespace: item_world
	Checksum: 0x3022341D
	Offset: 0x26C0
	Size: 0x260
	Parameters: 1
	Flags: Linked, Private
*/
function private function_35c26e09(supplystash)
{
	supplystash.var_193b3626 = undefined;
	supplystash.var_80089988 = undefined;
	targetname = (isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	var_3c32093e = 0;
	var_3ba9a53f = [];
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, supplystash.origin) > 36)
		{
			continue;
		}
		if(!isdefined(item.var_a6762160))
		{
			continue;
		}
		if(item_world_util::can_pick_up(item))
		{
			var_3c32093e = 1;
			break;
		}
		var_3ba9a53f[var_3ba9a53f.size] = item;
	}
	if(!var_3c32093e)
	{
		foreach(item in var_3ba9a53f)
		{
			function_54ca5536(item.id, -1);
			resetitem = level flagsys::get(#"item_world_reset");
			function_bfc28859(3, item.id, resetitem);
			break;
		}
	}
	function_e2a06860(supplystash, 0);
	return true;
}

/*
	Name: function_199c092d
	Namespace: item_world
	Checksum: 0x70E51576
	Offset: 0x2928
	Size: 0x3F8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_199c092d(supplystash, player = undefined)
{
	/#
		assert(!isdefined(supplystash.var_193b3626));
	#/
	if(isdefined(supplystash.var_193b3626))
	{
		return false;
	}
	supplystash.var_193b3626 = player getentitynumber();
	item = player item_inventory::function_2e711614(15);
	if(item.var_a6762160.name !== #"resource_item_loot_locker_key")
	{
		return false;
	}
	lootweapons = player namespace_a0d533d1::get_loot_weapons();
	/#
		assert(lootweapons.size > 0);
	#/
	if(lootweapons.size <= 0)
	{
		return false;
	}
	var_cf23afee = [];
	foreach(weaponname in lootweapons)
	{
		var_cf23afee[weaponname] = 1;
	}
	targetname = (isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, supplystash.origin) > 36)
		{
			continue;
		}
		if(!isdefined(item.var_a6762160) || !isdefined(item.var_a6762160.weapon))
		{
			continue;
		}
		if(item_world_util::can_pick_up(item) && !isdefined(var_cf23afee[item.var_a6762160.weapon.name]))
		{
			consume_item(item);
			continue;
		}
		if(isdefined(player.var_fbcc86d3) && isdefined(player.var_fbcc86d3[item.var_a6762160.weapon.name]))
		{
			consume_item(item);
			continue;
		}
		if(isdefined(var_cf23afee[item.var_a6762160.weapon.name]))
		{
			function_54ca5536(item.id, -1);
			resetitem = level flagsys::get(#"item_world_reset");
			function_bfc28859(3, item.id, resetitem);
			continue;
		}
	}
	return true;
}

/*
	Name: function_23b313bd
	Namespace: item_world
	Checksum: 0x20E10D66
	Offset: 0x2D28
	Size: 0xAC2
	Parameters: 4
	Flags: Linked, Private
*/
function private function_23b313bd(player, eventtype, eventdata, var_c5a66313)
{
	if(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		return;
	}
	if(!isdefined(player))
	{
		return;
	}
	switch(eventtype)
	{
		case 1:
		{
			desiredtime = (eventdata ? 1 : 150);
			defaulttime = getdvarint(#"hash_3ec4f617fad5b87c", 150);
			player.var_207c9892 = min(desiredtime, defaulttime) / 1000;
			if(isdefined(player.var_19caeeea))
			{
				function_dae4ab9b(player.var_19caeeea, player.var_207c9892);
			}
			return;
		}
		case 2:
		{
			var_c1ea9cae = isdefined(eventdata) && eventdata;
			player.var_c1ea9cae = var_c1ea9cae;
		}
	}
	if(!function_1b11e73c())
	{
		return;
	}
	if(!isdefined(player) || !isalive(player))
	{
		return;
	}
	if(eventtype == 4 || eventtype == 11)
	{
		var_bd027dd9 = eventdata;
		quickequip = var_c5a66313;
		weaponid = (eventtype == 11 ? 1 : 0);
		if(player inlaststand() || !isdefined(player.inventory) || !player item_inventory::equip_item(var_bd027dd9, quickequip === 1, weaponid))
		{
			function_a7b7d70b(player, var_bd027dd9);
		}
		else
		{
			itemid = player item_inventory::function_c48cd17f(var_bd027dd9);
			if(itemid != 32767)
			{
				item = function_b1702735(itemid);
				if(isdefined(item) && isdefined(item.var_a6762160))
				{
					function_1a46c8ae(player, undefined, undefined, item.var_a6762160, item.var_a6762160.amount);
				}
			}
		}
		return;
	}
	if(player inlaststand())
	{
		return;
	}
	if(!isdefined(player.inventory))
	{
		return;
	}
	switch(eventtype)
	{
		case 3:
		case 12:
		{
			var_bd027dd9 = eventdata;
			if(player clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2)
			{
				item = function_528ca826(var_bd027dd9);
				if(isdefined(item) && player item_world_util::can_pick_up(item))
				{
					success = player pickup_item(item, 1, eventtype == 12);
					if(success)
					{
						function_e0b64358(player, item);
					}
				}
			}
			break;
		}
		case 5:
		{
			var_bd027dd9 = eventdata;
			count = var_c5a66313;
			var_a1ca235e = undefined;
			var_3d1f9df4 = undefined;
			if(item_world_util::function_2c7fc531(var_bd027dd9))
			{
				itemid = var_bd027dd9;
				item = function_b1702735(itemid);
				/#
					assert(item.var_a6762160.itemtype == #"ammo");
				#/
				if(item.var_a6762160.itemtype == #"ammo")
				{
					var_a1ca235e = item.var_a6762160;
					var_3d1f9df4 = count;
					player item_inventory::function_ecd1c667(itemid, count);
				}
			}
			else
			{
				if(var_bd027dd9 == 32767)
				{
					return;
				}
				inventory_item = player item_inventory::get_inventory_item(var_bd027dd9);
				if(!isdefined(inventory_item))
				{
					break;
				}
				var_104acafa = isdefined(inventory_item.endtime);
				if(!isdefined(count) || count === inventory_item.count || var_104acafa)
				{
					var_3d1f9df4 = (isdefined(count) ? count : inventory_item.var_a6762160.amount);
					player item_inventory::drop_inventory_item(var_bd027dd9);
				}
				else
				{
					var_3d1f9df4 = count;
					player item_inventory::function_cfe0e919(var_bd027dd9, count);
				}
			}
			function_1a46c8ae(player, var_a1ca235e, var_3d1f9df4, undefined, undefined);
			break;
		}
		case 6:
		{
			var_bd027dd9 = eventdata;
			var_c3f14af5 = player item_inventory::function_777cc133();
			if(isdefined(var_c3f14af5))
			{
				player item_inventory::function_d019bf1d(var_bd027dd9);
				attachmentslot = player item_inventory::function_b246c573(var_bd027dd9);
				if(isdefined(attachmentslot))
				{
					player item_inventory::function_26c87da8(attachmentslot, var_c3f14af5);
				}
			}
			break;
		}
		case 7:
		{
			var_bd027dd9 = eventdata;
			var_fc7876fd = var_c5a66313;
			item = function_528ca826(var_bd027dd9);
			if(!isdefined(item))
			{
				return;
			}
			origin = player getplayercamerapos();
			if(distance2dsquared(origin, item.origin) > (128 * 128) || (abs(origin[2] - item.origin[2])) > 128)
			{
				return;
			}
			if(!isdefined(item) || !isdefined(item.var_a6762160))
			{
				return;
			}
			if(item.var_a6762160.itemtype == #"weapon")
			{
				var_bd31d7b2 = player item_inventory::function_ec087745();
				success = 0;
				if(var_fc7876fd == 1 && var_bd31d7b2 != 32767)
				{
					success = player item_inventory::function_9d102bbd(item, var_bd31d7b2);
				}
				else
				{
					success = player pickup_item(item, 1);
				}
				if(isdefined(success) && success)
				{
					function_e0b64358(player, item);
				}
			}
			else
			{
				if(var_fc7876fd == 2)
				{
					player item_inventory::function_fba40e6c(item);
					break;
				}
				var_641d3dc2 = item.var_a6762160.itemtype != #"attachment";
				var_a6762160 = item.var_a6762160;
				player pickup_item(item, var_641d3dc2);
				if(var_fc7876fd == 1 || var_fc7876fd == 2)
				{
					if(isdefined(var_a6762160))
					{
						inventoryitem = player item_inventory::function_8babc9f9(var_a6762160);
					}
					if(isdefined(inventoryitem))
					{
						switch(inventoryitem.var_a6762160.itemtype)
						{
							case "equipment":
							{
								player item_inventory::equip_equipment(inventoryitem);
								break;
							}
							case "health":
							{
								player item_inventory::equip_health(inventoryitem);
								break;
							}
						}
					}
				}
			}
			break;
		}
		case 8:
		{
			var_bd027dd9 = eventdata;
			player item_inventory::function_9ba10b94(var_bd027dd9);
			break;
		}
		case 10:
		{
			player item_inventory::cycle_health_item();
			break;
		}
		case 9:
		{
			player item_inventory::cycle_equipment_item();
			break;
		}
	}
}

/*
	Name: _on_player_connect
	Namespace: item_world
	Checksum: 0x3E50ADCA
	Offset: 0x37F8
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
function private _on_player_connect()
{
	function_f3b6e182(self);
	self item_inventory::init_inventory();
	self.var_d7a70ae4 = undefined;
	if(function_76915220() && (!self issplitscreen() || !self function_f27ff71f()))
	{
		self thread function_ba96cdf(self);
	}
}

/*
	Name: _on_player_disconnect
	Namespace: item_world
	Checksum: 0xE5F99169
	Offset: 0x38A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
function private _on_player_disconnect()
{
	if(isdefined(self.var_19caeeea))
	{
		self.var_19caeeea delete();
	}
}

/*
	Name: _on_player_spawned
	Namespace: item_world
	Checksum: 0xEB60CAD8
	Offset: 0x38E0
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private _on_player_spawned()
{
	if(!isdefined(self.inventory))
	{
		self item_inventory::init_inventory();
	}
	/#
		self thread function_76eb9bd7();
	#/
}

/*
	Name: function_9aefb438
	Namespace: item_world
	Checksum: 0x32CBEB3A
	Offset: 0x3928
	Size: 0x408
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9aefb438(params)
{
	if(isdefined(params) && params.message == #"hash_52e9e8e985489587")
	{
		if(!isdefined(self) || !isplayer(self) || !isalive(self))
		{
			params.player = undefined;
			return;
		}
		msgtype = 13;
		var_bd027dd9 = undefined;
		if(!isdefined(self.var_bf3cabc9))
		{
			var_9b882d22 = self.var_d5673d87;
			if(!isdefined(var_9b882d22) || !isdefined(var_9b882d22.var_bd027dd9))
			{
				params.player = undefined;
				return;
			}
			if(!(isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1) && distance2dsquared(var_9b882d22.origin, self.origin) > (128 * 128))
			{
				params.player = undefined;
				return;
			}
			if(!(isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1) && var_9b882d22.var_a6762160.rarity == #"epic")
			{
				params.message = #"hash_433c75db9fd3177e";
			}
			var_bd027dd9 = var_9b882d22.var_bd027dd9;
		}
		else
		{
			msgtype = 14;
			var_bd027dd9 = self.var_bf3cabc9 getentitynumber();
		}
		platoon = getteamplatoon(self.team);
		if(platoon != #"none" && platoon != #"invalid")
		{
			teams = function_37d3bfcb(platoon);
			members = [];
			foreach(team in teams)
			{
				foreach(member in getplayers(team))
				{
					member function_b00db06(msgtype, var_bd027dd9, self getentitynumber());
				}
			}
		}
		else
		{
			members = getplayers(self.team);
			foreach(member in members)
			{
				member function_b00db06(msgtype, var_bd027dd9, self getentitynumber());
			}
		}
	}
}

/*
	Name: function_f27ff71f
	Namespace: item_world
	Checksum: 0x9D34A71C
	Offset: 0x3D38
	Size: 0xC8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f27ff71f()
{
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(player == self)
		{
			continue;
		}
		if(!self isplayeronsamemachine(player))
		{
			continue;
		}
		if(isdefined(player.var_d7a70ae4) && player.var_d7a70ae4)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_df1098a
	Namespace: item_world
	Checksum: 0xE59C7D36
	Offset: 0x3E08
	Size: 0x106
	Parameters: 0
	Flags: Linked, Private
*/
function private function_df1098a()
{
	self notify("10a9b70443a6baa1");
	self endon("10a9b70443a6baa1");
	level endon(#"game_ended");
	while(true)
	{
		players = getplayers();
		for(index = 0; index < players.size; index++)
		{
			player = players[index];
			if(isalive(player))
			{
				player function_7c84312d(player getplayercamerapos(), player getplayerangles());
			}
			if(((index + 1) % 15) == 0)
			{
				waitframe(1);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_ad7ad6ce
	Namespace: item_world
	Checksum: 0x3574E1F2
	Offset: 0x3F18
	Size: 0x362
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ad7ad6ce(trigger_struct)
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death");
	usetrigger = self;
	activator = trigger_struct.activator;
	if(!isdefined(activator) || !isplayer(activator) || !isalive(activator) || activator inlaststand())
	{
		return;
	}
	if(!activator function_8e0d14c1())
	{
		return;
	}
	if(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		return;
	}
	var_91d3170d = activator clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
	if(var_91d3170d == 4)
	{
		return;
	}
	if(var_91d3170d == 3)
	{
		stash = item_world_util::function_31f5aa51(usetrigger.itemstruct);
		if(!isdefined(stash))
		{
			return;
		}
		if(function_199c092d(stash, activator))
		{
			var_91d3170d = 1;
		}
		else
		{
			return;
		}
	}
	if(var_91d3170d == 1 || (var_91d3170d == 0 && usetrigger.itemstruct.hidetime === -1))
	{
		usetrigger sethintstring(#"");
		activator clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 2);
		activator thread function_eb900758(item_world_util::function_31f5aa51(usetrigger.itemstruct));
		function_a54d07e6(usetrigger.itemstruct, activator);
	}
	else
	{
		if(var_91d3170d == 2)
		{
			usetrigger sethintstring(#"");
		}
		else
		{
			item = usetrigger.itemstruct;
			if(isdefined(item) && !isentity(item) && isdefined(item.id))
			{
				item = function_b1702735(item.id);
			}
			if(activator item_world_util::can_pick_up(item))
			{
				activator pickup_item(item);
				while(isdefined(activator) && activator usebuttonpressed())
				{
					waitframe(1);
				}
			}
		}
	}
}

/*
	Name: function_eb900758
	Namespace: item_world
	Checksum: 0x52B9B1CE
	Offset: 0x4288
	Size: 0xFA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_eb900758(stash)
{
	self childthread function_d87c50ae(stash);
	self childthread function_6266f448(stash);
	self waittill(#"disconnect", #"death", #"entering_last_stand", #"hash_2781407e327b42ee");
	if(isdefined(stash) && (isdefined(stash.lootlocker) && stash.lootlocker))
	{
		function_35c26e09(stash);
	}
	if(isdefined(self))
	{
		self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
		self.var_c4462112 = 1;
	}
}

/*
	Name: function_6266f448
	Namespace: item_world
	Checksum: 0x6864B3DC
	Offset: 0x4390
	Size: 0xDE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6266f448(stash)
{
	self notify("6dcb0aa0e1be50d9");
	self endon("6dcb0aa0e1be50d9");
	self endon(#"disconnect", #"death", #"entering_last_stand", #"hash_2781407e327b42ee");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"menuresponse");
		if(waitresult.menu == "MultiItemPickup" && waitresult.response == "multi_item_menu_closed")
		{
			break;
		}
	}
	self notify(#"hash_2781407e327b42ee");
}

/*
	Name: function_d87c50ae
	Namespace: item_world
	Checksum: 0x187518B2
	Offset: 0x4478
	Size: 0x1FE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d87c50ae(stash)
{
	self notify("4bd96bb741326417");
	self endon("4bd96bb741326417");
	self endon(#"disconnect", #"death", #"entering_last_stand", #"hash_2781407e327b42ee");
	while(true)
	{
		waitframe(1);
		if(!isdefined(self.groupitems))
		{
			break;
		}
		if(self.groupitems.size == 0)
		{
			break;
		}
		var_9f69a4d3 = 0;
		foreach(item in self.groupitems)
		{
			if(isdefined(item) && self item_world_util::can_pick_up(item))
			{
				var_9f69a4d3 = 1;
				break;
			}
		}
		if(!var_9f69a4d3)
		{
			break;
		}
		if(self isfiring() || self playerads() > 0.3 || self ismeleeing())
		{
			break;
		}
		if(isdefined(stash) && (isdefined(stash.lootlocker) && stash.lootlocker) && !function_8bac489c(stash, self))
		{
			break;
		}
	}
	self notify(#"hash_2781407e327b42ee");
}

/*
	Name: function_937ea9e
	Namespace: item_world
	Checksum: 0x4021B23A
	Offset: 0x4680
	Size: 0x8A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_937ea9e(identifier, handler)
{
	/#
		assert(isdefined(level.var_66383953), "");
	#/
	/#
		assert(!isdefined(level.var_66383953[identifier]), "" + identifier);
	#/
	level.var_66383953[identifier] = handler;
}

/*
	Name: function_ba96cdf
	Namespace: item_world
	Checksum: 0xC8D1955C
	Offset: 0x4718
	Size: 0xAA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ba96cdf(player)
{
	if(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		return;
	}
	function_1b11e73c();
	if(isplayer(player))
	{
		var_fee74908 = player function_e6ea1ee0();
		if(isdefined(player))
		{
			player function_45ecbbc5(var_fee74908);
			player.var_d7a70ae4 = 1;
		}
	}
}

/*
	Name: function_116fd9a7
	Namespace: item_world
	Checksum: 0x3D7913B2
	Offset: 0x47D0
	Size: 0x254
	Parameters: 0
	Flags: Linked, Private
*/
function private function_116fd9a7()
{
	level.var_66383953 = [];
	function_937ea9e(#"hash_9ed0c30684ca35a", &function_d045e83b);
	function_937ea9e(#"hash_76a324a4d6073913", &function_2e5b5858);
	function_937ea9e(#"hash_3bfb97e39d67e5f9", &function_cb9b4dd7);
	function_937ea9e(#"hash_788c59214ead02af", &function_14b2eddf);
	function_937ea9e(#"hash_6247ea34d3b1ddb6", &function_42ffe9b2);
	function_937ea9e(#"hash_2cbf15cbb314c93e", &function_2eebeff5);
	function_937ea9e(#"hash_51b30f6e7331e136", &function_349d4c26);
	function_937ea9e(#"hash_2b4dff2e0db72d06", &function_670cce3f);
	function_937ea9e(#"generic_pickup", &function_41a52251);
	function_937ea9e(#"hash_5c844f5c1207159c", &function_2b2e9302);
	function_937ea9e(#"hash_31380667bf69d3a0", &function_a240798a);
	function_937ea9e(#"hash_50375e5de228e9fc", &function_a712496a);
}

/*
	Name: function_76915220
	Namespace: item_world
	Checksum: 0xEC7AD41A
	Offset: 0x4A30
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
function private function_76915220()
{
	return level.var_703d32de > 0;
}

/*
	Name: function_248022d9
	Namespace: item_world
	Checksum: 0x52031E5
	Offset: 0x4A50
	Size: 0x1B6
	Parameters: 0
	Flags: Linked
*/
function function_248022d9()
{
	level.var_37a4536d = [];
	if(!isdefined(level.var_75dc9c49))
	{
		level.var_75dc9c49 = 0;
	}
	resetflag = level flagsys::get(#"item_world_reset");
	while(true)
	{
		var_5610ded4 = level flagsys::get(#"item_world_reset");
		if(var_5610ded4 != resetflag)
		{
			level.var_37a4536d = [];
		}
		if(level.var_75dc9c49 > 0)
		{
			time = gettime();
			for(index = 0; index < level.var_37a4536d.size; index++)
			{
				respawnitem = level.var_37a4536d[index];
				if((time - respawnitem.hidetime) >= level.var_75dc9c49)
				{
					function_54ca5536(respawnitem.id, 0);
					function_bfc28859(3, respawnitem.id, var_5610ded4, 1);
					level.var_37a4536d[index] = undefined;
					continue;
				}
				break;
			}
			arrayremovevalue(level.var_37a4536d, undefined, 0);
		}
		resetflag = var_5610ded4;
		waitframe(1);
	}
}

/*
	Name: function_a54d07e6
	Namespace: item_world
	Checksum: 0x51537BC8
	Offset: 0x4C10
	Size: 0x964
	Parameters: 2
	Flags: Linked
*/
function function_a54d07e6(item, activator)
{
	/#
		assert(isdefined(item));
	#/
	if(isdefined(item) && (isdefined(item.targetname) || isdefined(item.var_67169c0b)))
	{
		targetname = (isdefined(item.targetname) ? item.targetname : item.var_67169c0b);
		stashes = level.var_93d08989[targetname];
		if(isdefined(stashes) && stashes.size > 0)
		{
			stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
			if(stashes.size <= 0)
			{
				return;
			}
			state = function_ffdbe8c2(stashes[0]);
			if(state == 0)
			{
				function_b516210b((isdefined(stashes[0].var_15d44120) ? stashes[0].var_15d44120 : stashes[0].model), stashes[0].origin, activator);
				function_e2a06860(stashes[0], 1);
				params = {#state:state, #activator:activator};
				stashes[0] callback::callback(#"on_stash_open", params);
			}
			else if(state == 1)
			{
				stashitems = function_91b29d2a(targetname);
				stashitems = arraysortclosest(stashitems, stashes[0].origin, stashitems.size, 0, 12);
				foreach(stashitem in stashitems)
				{
					if(isdefined(stashitem.var_a6762160) && stashitem.hidetime === -1)
					{
						return;
					}
				}
				dynamicitems = [];
				foreach(itemspawndrop in level.item_spawn_drops)
				{
					if(isdefined(itemspawndrop) && itemspawndrop.var_67169c0b === targetname)
					{
						dynamicitems[dynamicitems.size] = itemspawndrop;
					}
				}
				dynamicitems = arraysortclosest(dynamicitems, stashes[0].origin, dynamicitems.size, 0, 12);
				foreach(dynamicitem in dynamicitems)
				{
					if(dynamicitem.hidetime === -1)
					{
						return;
					}
				}
				if(isdefined(stashes[0].lootlocker) && stashes[0].lootlocker && activator !== level)
				{
					function_35c26e09(stashes[0]);
					function_e2a06860(stashes[0], 0);
					return;
				}
				function_e2a06860(stashes[0], 2);
				stashes[0] notify(#"hash_4c78fc894646853d");
			}
		}
		if(!isstring(targetname))
		{
			return;
		}
		stashes = getentarray(targetname, "targetname");
		if(stashes.size > 0)
		{
			stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
			if(stashes.size <= 0)
			{
				return;
			}
			stash = stashes[0];
			if(stash.var_bad13452 == 0)
			{
				function_b516210b(stash.model, stash.origin, activator);
				params = {#state:state, #activator:activator};
				stash callback::callback(#"on_stash_open", params);
				if(isdefined(stash.var_a76e4941) && stash.var_a76e4941)
				{
					stash animscripted("death_stash_open", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
				}
				else if(isdefined(stash.var_a64ed253) && stash.var_a64ed253)
				{
					stash animscripted("supply_drop_open", stash.origin, stash.angles, "p8_fxanim_wz_supply_stash_04_open_anim", "normal", "root", 1, 0);
				}
				stash.var_bad13452 = 1;
			}
			else if(stash.var_bad13452 == 1)
			{
				dynamicitems = [];
				foreach(itemspawndrop in level.item_spawn_drops)
				{
					if(isdefined(itemspawndrop) && itemspawndrop.var_67169c0b === targetname)
					{
						dynamicitems[dynamicitems.size] = itemspawndrop;
					}
				}
				dynamicitems = arraysortclosest(dynamicitems, stashes[0].origin, dynamicitems.size, 0, 12);
				foreach(dynamicitem in dynamicitems)
				{
					if(dynamicitem.hidetime === -1)
					{
						return;
					}
				}
				if(isdefined(stash.var_a76e4941) && stash.var_a76e4941)
				{
					stash animscripted("death_stash_empty", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
				}
				else if(isdefined(stash.var_a64ed253) && stash.var_a64ed253)
				{
					stash animscripted("supply_drop_empty", stash.origin, stash.angles, "p8_fxanim_wz_supply_stash_04_used_anim", "normal", "root", 1, 0);
				}
				stash.var_bad13452 = 2;
				stash clientfield::set("dynamic_stash", 2);
			}
		}
	}
}

/*
	Name: function_7c84312d
	Namespace: item_world
	Checksum: 0xB30412B8
	Offset: 0x5580
	Size: 0xFEE
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7c84312d(origin, angles)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return;
	}
	usetrigger = self.var_19caeeea;
	if(!isdefined(usetrigger))
	{
		return;
	}
	if(isdefined(self.disableitempickup) && self.disableitempickup)
	{
		return;
	}
	var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
	forward = vectornormalize(anglestoforward(angles));
	maxdist = util::function_16fb0a3b();
	if(var_512ddf16)
	{
		maxdist = 128;
	}
	var_f4b807cb = function_2e3efdda(origin, forward, 128, maxdist, 0);
	var_9b882d22 = undefined;
	if(var_512ddf16 && isdefined(self.var_d7abc784))
	{
		var_75f6d739 = anglestoforward((0, angles[1], 0));
		for(itemindex = 0; itemindex < var_f4b807cb.size; itemindex++)
		{
			itemdef = var_f4b807cb[itemindex];
			toitem = itemdef.origin - origin;
			if(itemdef.hidetime !== -1)
			{
				continue;
			}
			var_1777205e = vectordot(var_75f6d739, vectornormalize((toitem[0], toitem[1], 0)));
			if(var_1777205e >= 0.5 && distancesquared(itemdef.origin, self.var_d7abc784) <= (12 * 12))
			{
				if(item_world_util::function_2eb2c17c(origin, itemdef))
				{
					var_9b882d22 = itemdef;
					break;
					continue;
				}
				break;
			}
		}
	}
	if(!isdefined(var_9b882d22))
	{
		var_4bd72bfe = self.var_c1ea9cae;
		var_9b882d22 = item_world_util::function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe);
	}
	if(self inlaststand())
	{
		var_9b882d22 = undefined;
	}
	var_caafaa25 = #"";
	if(isdefined(var_9b882d22) && !self isinvehicle())
	{
		self.groupitems = [];
		hasbackpack = self item_inventory::has_backpack();
		stashitem = var_9b882d22.hidetime === -1;
		var_52bfa6e5 = !stashitem && item_inventory::function_550fcb41(var_9b882d22);
		var_f4b42fba = self item_inventory::has_armor() && var_9b882d22.var_a6762160.itemtype == #"armor";
		isammo = var_9b882d22.var_a6762160.itemtype == #"ammo";
		var_de41d336 = !hasbackpack && var_9b882d22.var_a6762160.itemtype == #"backpack";
		if(stashitem || (!isammo && !var_de41d336 && !var_52bfa6e5 && !var_f4b42fba))
		{
			var_433d429 = 14;
			self.groupitems = function_2e3efdda(var_9b882d22.origin, undefined, 128, var_433d429);
			self.groupitems = self array::filter(self.groupitems, 0, &item_world_util::can_pick_up);
		}
		if(self.groupitems.size == 1)
		{
			stashitem = self.groupitems[0].hidetime === -1;
		}
		var_b46724f6 = 0;
		if(isdefined(self.var_d5673d87) && (isdefined(var_9b882d22.targetname) || isdefined(var_9b882d22.var_67169c0b)))
		{
			if(isdefined(self.var_d5673d87.targetname) || isdefined(self.var_d5673d87.var_67169c0b))
			{
				var_45602f41 = (isdefined(var_9b882d22.targetname) ? var_9b882d22.targetname : var_9b882d22.var_67169c0b);
				var_d2daaa1a = (isdefined(self.var_d5673d87.targetname) ? self.var_d5673d87.targetname : self.var_d5673d87.var_67169c0b);
				var_b46724f6 = var_45602f41 != var_d2daaa1a;
			}
		}
		if(stashitem)
		{
			usetrigger setcursorhint("HINT_NOICON");
			usetrigger sethintstring(#"");
			usetrigger function_89fca53b(1);
			usetrigger function_49462027(0);
			stash = item_world_util::function_31f5aa51(var_9b882d22);
			var_e30063d2 = isdefined(stash) && (isdefined(stash.lootlocker) && stash.lootlocker);
			currentstate = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
			if(currentstate != 2 || (currentstate == 2 && var_b46724f6))
			{
				if(distancesquared(origin, var_9b882d22.origin) > 128 * 128)
				{
					self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
				}
				else
				{
					if(var_e30063d2 && !function_8bac489c(stash, self))
					{
						if(self item_inventory::function_471897e2())
						{
							self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 3);
						}
						else
						{
							self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 4);
						}
					}
					else
					{
						self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 1);
					}
				}
			}
		}
		else
		{
			usetrigger function_89fca53b(0);
			usetrigger function_49462027(1, (((1 | 16) | 8388608) | 65536) | 4194304);
			self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
			var_a6762160 = var_9b882d22.var_a6762160;
			if(isdefined(var_a6762160.weapon) && var_a6762160.weapon != level.weaponnone)
			{
				if(var_a6762160.itemtype != #"ammo")
				{
					usetrigger setcursorhint("HINT_WEAPON_3D", namespace_a0d533d1::function_2b83d3ff(var_9b882d22));
					var_caafaa25 = #"";
					if(isdefined(var_a6762160.weapon))
					{
						var_caafaa25 = var_a6762160.weapon.displayname;
					}
					else
					{
						var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"weapon/pickupnewweapon");
					}
					usetrigger sethintstring(var_caafaa25);
				}
				else
				{
					usetrigger setcursorhint("HINT_3D");
					var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"");
					usetrigger sethintstring(var_caafaa25);
				}
			}
			else
			{
				usetrigger setcursorhint("HINT_3D");
				var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"");
				usetrigger sethintstring(var_caafaa25);
			}
		}
		usetrigger.itemstruct = var_9b882d22;
		usetrigger.origin = var_9b882d22.origin + vectorscale((0, 0, 1), 4);
		usetrigger.angles = (0, 0, 0);
		usetrigger triggerenable(1);
		function_dae4ab9b(usetrigger, self.var_207c9892);
		if(!(isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1))
		{
			self clientfield::set_player_uimodel("hudItems.pickupHintGold", var_9b882d22.var_a6762160.rarity == #"epic");
		}
		if(!(isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1) && !var_512ddf16)
		{
			if(var_9b882d22.var_a6762160.itemtype == #"ammo")
			{
				if(!item_inventory::can_pickup_ammo(var_9b882d22))
				{
					function_dae4ab9b(usetrigger, getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000);
				}
			}
			else if(!isdefined(item_inventory::function_e66dcff5(var_9b882d22)))
			{
				function_dae4ab9b(usetrigger, getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000);
			}
		}
		self.var_d5673d87 = var_9b882d22;
		if(isdefined(self.var_d5673d87))
		{
			self.var_d7abc784 = self.var_d5673d87.origin;
		}
		else
		{
			self.var_d7abc784 = undefined;
		}
	}
	else
	{
		self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
		self clientfield::set_player_uimodel("hudItems.pickupHintGold", 0);
		usetrigger.itemstruct = undefined;
		usetrigger triggerenable(0);
		self.groupitems = undefined;
	}
	self.var_bb8abe86 = forward;
	self.var_1609622c = origin;
	self.var_34b00d0d = level.var_703d32de;
	self.var_cc586562 = undefined;
	self.var_bf3cabc9 = undefined;
	eyepos = self getplayercamerapos();
	if(isdefined(var_9b882d22) && (isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1))
	{
		var_caafaa25 = #"wz/supply_stash";
		var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, var_9b882d22.origin, 1, 0, 12);
		if(var_1ba7b9c8.size > 0 && isdefined(var_1ba7b9c8[0].displayname))
		{
			var_caafaa25 = var_1ba7b9c8[0].displayname;
		}
		var_c36bd68a = arraysortclosest(level.var_ace9fb52, var_9b882d22.origin, 1, 0, 12);
		if(var_c36bd68a.size > 0)
		{
			var_caafaa25 = #"wz/death_stash";
		}
		else
		{
			var_6594679a = arraysortclosest(level.item_supply_drops, var_9b882d22.origin, 1, 0, 12);
			if(var_6594679a.size > 0)
			{
				var_caafaa25 = #"wz/supply_drop";
			}
		}
	}
	else if(!isdefined(var_9b882d22) || distance2dsquared(var_9b882d22.origin, eyepos) > (128 * 128))
	{
		angles = self getplayerangles();
		self.var_bf3cabc9 = item_world_util::function_6af455de(0, eyepos, angles);
		hintstring = item_world_util::function_c62ad9a7(self.var_bf3cabc9);
		if(hintstring != #"")
		{
			var_caafaa25 = hintstring;
		}
	}
	self.var_cc586562 = var_caafaa25;
}

/*
	Name: function_c8ab2022
	Namespace: item_world
	Checksum: 0x9CD625DF
	Offset: 0x6578
	Size: 0x196
	Parameters: 2
	Flags: Linked
*/
function function_c8ab2022(item, var_cdf8c0d1 = 0)
{
	if(!isdefined(item))
	{
		return 0;
	}
	var_a6762160 = item.var_a6762160;
	itemcount = item.count;
	if(var_a6762160.itemtype == #"cash")
	{
		if(var_cdf8c0d1 && (!(isdefined(var_a6762160.stackable) && var_a6762160.stackable)))
		{
			return 1;
		}
		return (isdefined(item.count) ? item.count : 1);
	}
	if(!isdefined(itemcount))
	{
		itemcount = (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1);
		if(var_a6762160.itemtype == #"weapon")
		{
			itemcount = 1;
		}
	}
	if(var_cdf8c0d1 && (!(isdefined(var_a6762160.stackable) && var_a6762160.stackable)) && (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1) == 1)
	{
		itemcount = 1;
	}
	return itemcount;
}

/*
	Name: consume_item
	Namespace: item_world
	Checksum: 0x770370CD
	Offset: 0x6718
	Size: 0x3B4
	Parameters: 1
	Flags: Linked
*/
function consume_item(item)
{
	if(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		return;
	}
	if(isentity(item))
	{
		item.hidetime = gettime();
		if(isdefined(item.var_d783088e))
		{
			foreach(sensordart in item.var_d783088e)
			{
				if(!isdefined(sensordart))
				{
					continue;
				}
				sensordart thread sensor_dart::function_4db10465();
			}
			item.var_d783088e = undefined;
		}
	}
	else
	{
		if(isdefined(item))
		{
			function_54ca5536(item.id, gettime());
			if(isdefined(item.var_a6762160) && (isdefined(item.var_a6762160.var_47f145b4) && item.var_a6762160.var_47f145b4))
			{
				respawnitem = spawnstruct();
				respawnitem.id = item.id;
				respawnitem.hidetime = gettime();
				level.var_37a4536d[level.var_37a4536d.size] = respawnitem;
			}
			if(level flagsys::get(#"item_world_reset"))
			{
				function_bfc28859(2, item.id);
			}
			else
			{
				function_bfc28859(1, item.id);
			}
			if(isdefined(level.var_5b2a8d88) && isdefined(level.var_5b2a8d88[item.id]))
			{
				level.var_5b2a8d88[item.id] = 0;
			}
		}
		level.var_703d32de++;
	}
	if(isdefined(item))
	{
		function_a54d07e6(item, self);
	}
	if(isentity(item))
	{
		item clientfield::set("dynamic_item_drop", 2);
		item function_46d7f921(32767);
		item ghost();
		util::wait_network_frame(2);
		if(!isdefined(item))
		{
			return;
		}
		if(isdefined(item.var_38af96b9))
		{
			var_38af96b9 = item.var_38af96b9;
			var_38af96b9 stopsounds();
			util::wait_network_frame(1);
			if(isdefined(var_38af96b9))
			{
				var_38af96b9 delete();
			}
		}
		if(!isdefined(item))
		{
			return;
		}
		item delete();
	}
}

/*
	Name: function_df82b00c
	Namespace: item_world
	Checksum: 0x37063829
	Offset: 0x6AD8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_df82b00c()
{
	if(!isplayer(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(isdefined(self.var_19caeeea))
	{
		self.var_19caeeea triggerenable(0);
	}
	self.disableitempickup = 1;
	self.var_d5673d87 = undefined;
	self clientfield::set_to_player("disableItemPickup", 1);
}

/*
	Name: function_528ca826
	Namespace: item_world
	Checksum: 0x89C75E48
	Offset: 0x6B78
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_528ca826(var_bd027dd9)
{
	if(item_world_util::function_d9648161(var_bd027dd9))
	{
		if(item_world_util::function_2c7fc531(var_bd027dd9))
		{
			return function_b1702735(var_bd027dd9);
		}
		if(item_world_util::function_da09de95(var_bd027dd9))
		{
			if(isdefined(level.item_spawn_drops[var_bd027dd9]))
			{
				return level.item_spawn_drops[var_bd027dd9];
			}
		}
		else
		{
			/#
				assert(0, "");
			#/
		}
	}
}

/*
	Name: function_2e3efdda
	Namespace: item_world
	Checksum: 0x8F49B5AE
	Offset: 0x6C38
	Size: 0x142
	Parameters: 6
	Flags: Linked
*/
function function_2e3efdda(origin, dir, var_4e7bdb02, maxdistance, dot, var_bc1582aa = 1)
{
	var_4e7bdb02 = (isdefined(var_4e7bdb02) ? int(min(var_4e7bdb02, 4000)) : var_4e7bdb02);
	var_f4b807cb = function_abaeb170(origin, dir, var_4e7bdb02, maxdistance, dot, var_bc1582aa, -2147483647);
	var_6665e24 = arraysortclosest(level.item_spawn_drops, origin, var_4e7bdb02, 0, maxdistance);
	var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
	var_f4b807cb = arraysortclosest(var_f4b807cb, origin, var_4e7bdb02, 0, maxdistance);
	return var_f4b807cb;
}

/*
	Name: function_de2018e3
	Namespace: item_world
	Checksum: 0x473717A2
	Offset: 0x6D88
	Size: 0x48C
	Parameters: 3
	Flags: Linked
*/
function function_de2018e3(item, player, slotid = undefined)
{
	if(!isdefined(item))
	{
		return 0;
	}
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160.handler))
	{
		handlerfunc = level.var_66383953[var_a6762160.handler];
		if(isdefined(handlerfunc))
		{
			var_aec6fa7f = item.amount;
			if(!isdefined(var_aec6fa7f) || item.amount == 0)
			{
				if(var_a6762160.itemtype == #"ammo")
				{
				}
				else
				{
					if(var_a6762160.itemtype == #"weapon")
					{
						if(!isdefined(item.amount))
						{
							weapon = item_world_util::function_35e06774(var_a6762160);
							var_aec6fa7f = var_a6762160.amount;
							if(isdefined(weapon))
							{
								var_aec6fa7f = var_a6762160.amount * weapon.clipsize;
							}
						}
					}
					else
					{
						if(var_a6762160.itemtype == #"armor")
						{
							var_aec6fa7f = var_a6762160.amount;
						}
						else
						{
							if(var_a6762160.itemtype == #"equipment")
							{
								if(isentity(item))
								{
									var_aec6fa7f = item.ammo;
								}
								if(!isdefined(var_aec6fa7f))
								{
									var_aec6fa7f = 0;
								}
							}
							else
							{
								var_aec6fa7f = 0;
							}
						}
					}
				}
			}
			var_d72b1a4b = function_c8ab2022(item, 0);
			var_8cd447d8 = function_c8ab2022(item, 1);
			var_c5781c22 = player [[handlerfunc]](item, player, item.var_bd027dd9, item.id, var_8cd447d8, var_aec6fa7f, slotid);
			var_c5781c22 = var_c5781c22 + (var_d72b1a4b - var_8cd447d8);
			/#
				assert(isint(var_c5781c22) && var_c5781c22 >= 0);
			#/
			if(var_a6762160.itemtype == #"ammo" && var_d72b1a4b === var_c5781c22)
			{
			}
			else
			{
				if(var_c5781c22 == var_d72b1a4b)
				{
				}
				else
				{
					if(isdefined(player))
					{
						player gestures::function_56e00fbf("gestable_grab", undefined, 0);
					}
					if(isdefined(item))
					{
						if(var_a6762160.itemtype == #"ammo")
						{
							item.amount = var_c5781c22;
						}
						else
						{
							item.count = var_c5781c22;
						}
						if(isentity(item))
						{
							item clientfield::set("dynamic_item_drop_count", int(max(item.count, item.amount)));
						}
					}
				}
			}
			if(var_c5781c22 != var_d72b1a4b)
			{
				var_fceba0ce = {#player:player, #count:var_8cd447d8, #item:item};
				self callback::callback(#"on_item_pickup", var_fceba0ce);
			}
			return var_c5781c22;
		}
	}
	/#
		assertmsg(("" + var_a6762160.name) + "");
	#/
}

/*
	Name: pickup_item
	Namespace: item_world
	Checksum: 0x63169074
	Offset: 0x7220
	Size: 0x4B4
	Parameters: 3
	Flags: Linked
*/
function pickup_item(item, var_22be503 = 1, var_26a492bc = 0)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return 0;
	}
	if(!item_world_util::can_pick_up(item))
	{
		return 0;
	}
	if(isdefined(self.is_reviving_any) && self.is_reviving_any || (isdefined(self.var_5c574004) && self.var_5c574004))
	{
		return 0;
	}
	if(isdefined(item.hidefromteam) && item.hidefromteam == self.team)
	{
		if(!isdefined(item.var_6e788302) || item.var_6e788302 !== self getentitynumber())
		{
			self playsoundtoplayer(#"uin_unavailable_charging", self);
			return 0;
		}
	}
	self dynent_world::function_7f2040e8();
	if(var_22be503)
	{
		var_fa3df96 = self item_inventory::function_e66dcff5(item, var_26a492bc);
	}
	if(isdefined(var_fa3df96))
	{
		success = self function_83ddce0f(item, var_fa3df96);
		return success;
	}
	if(item.var_a6762160.itemtype != #"weapon")
	{
		var_d72b1a4b = function_c8ab2022(item, 0);
		var_8cd447d8 = function_c8ab2022(item, 1);
		var_77e61fc6 = function_de2018e3(item, self);
		var_77e61fc6 = var_77e61fc6 + (var_d72b1a4b - var_8cd447d8);
		if(var_77e61fc6 == 0)
		{
			if(item.var_a6762160.itemtype != #"armor")
			{
				if(isdefined(item) && isdefined(item.var_a6762160))
				{
					function_1a46c8ae(self, undefined, undefined, item.var_a6762160, item.var_a6762160.amount);
				}
			}
			consume_item(item);
			return 1;
		}
		if(var_77e61fc6 < var_8cd447d8 && !isentity(item) && item.var_a6762160.itemtype != #"ammo")
		{
			stashitem = item.hidetime === -1;
			stashitem = stashitem & (~(isdefined(item.deathstash) ? item.deathstash : 0));
			dropitem = self item_drop::drop_item(item.var_a6762160.weapon, var_77e61fc6, item.amount, item.id, item.origin, item.angles, stashitem, undefined, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname), undefined, undefined, 0);
			if(isdefined(dropitem))
			{
				dropitem.origin = item.origin;
				dropitem.angles = item.angles;
				consume_item(item);
			}
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_8e0d14c1
	Namespace: item_world
	Checksum: 0x2A48906B
	Offset: 0x76E0
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_8e0d14c1(var_4b0875ec = 0)
{
	/#
		assert(isplayer(self));
	#/
	usetrigger = self.var_19caeeea;
	if(!isdefined(usetrigger))
	{
		return false;
	}
	if(!isdefined(usetrigger.itemstruct))
	{
		return false;
	}
	if(var_4b0875ec && usetrigger.itemstruct.hidetime === -1)
	{
		return false;
	}
	origin = self getplayercamerapos();
	if(distance2dsquared(usetrigger.itemstruct.origin, origin) > 128 * 128)
	{
		return false;
	}
	if(abs(usetrigger.itemstruct.origin[2] - origin[2]) > 128)
	{
		return false;
	}
	return true;
}

/*
	Name: function_1a46c8ae
	Namespace: item_world
	Checksum: 0x63AC5E40
	Offset: 0x7830
	Size: 0x23C
	Parameters: 5
	Flags: Linked
*/
function function_1a46c8ae(player, var_a1ca235e, var_3d1f9df4, var_7089b458, var_381f3b39)
{
	if(game.state == "pregame" || (!isdefined(var_a1ca235e) && !isdefined(var_7089b458)))
	{
		return;
	}
	loc_000078A8:
	loc_000078DE:
	loc_000078FC:
	loc_0000792E:
	data = {#hash_d1f97c0f:(isdefined(var_381f3b39) ? var_381f3b39 : 0), #hash_6789038:(isdefined(var_7089b458) ? hash(var_7089b458.name) : 0), #hash_5b8ff5e9:(isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0), #dropped_item:(isdefined(var_a1ca235e) ? hash(var_a1ca235e.name) : 0), #player_xuid:(isdefined(player) ? int(player getxuid(1)) : 0), #game_time:function_f8d53445()};
	/#
		if(isdefined(var_a1ca235e))
		{
			println((("" + var_a1ca235e.name) + "") + (isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0));
		}
		if(isdefined(var_7089b458))
		{
			println((("" + var_7089b458.name) + "") + (isdefined(var_381f3b39) ? var_381f3b39 : 0));
		}
	#/
	function_92d1707f(#"hash_1ed3b4af49015043", data);
}

/*
	Name: function_83ddce0f
	Namespace: item_world
	Checksum: 0xE9E29F0
	Offset: 0x7A78
	Size: 0x508
	Parameters: 2
	Flags: Linked
*/
function function_83ddce0f(item, inventoryslot)
{
	var_a1ca235e = undefined;
	var_3d1f9df4 = 0;
	var_8acbe1d0 = self item_inventory::function_550fcb41(item) || item.var_a6762160.itemtype == #"armor_shard" || item.var_a6762160.itemtype == #"resource" || item.var_a6762160.itemtype == #"ammo" || (item.var_a6762160.itemtype == #"backpack" && !self item_inventory::has_backpack());
	stashitem = item.hidetime === -1;
	deathstashitem = (isdefined(item.deathstash) ? item.deathstash : 0);
	stashitem = stashitem & (~deathstashitem);
	dropitem = undefined;
	if(!var_8acbe1d0 && self item_inventory::has_inventory_item(inventoryslot))
	{
		var_69944179 = self.inventory.items[inventoryslot];
		var_a1ca235e = var_69944179.var_a6762160;
		var_3d1f9df4 = var_a1ca235e.amount;
		dropitem = self item_inventory::drop_inventory_item(var_69944179.var_bd027dd9, 0, item.origin, undefined, 0);
		if(!isdefined(dropitem))
		{
			return false;
		}
		waitframe(1);
	}
	if(isdefined(item) && !isentity(item) && isdefined(item.id))
	{
		item = function_b1702735(item.id);
	}
	if(!isdefined(item) || !item_world_util::can_pick_up(item))
	{
		if(isdefined(dropitem) && isdefined(item) && isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"backpack")
		{
			item_inventory::function_ec238da8();
		}
		return false;
	}
	var_77e61fc6 = function_de2018e3(item, self, inventoryslot);
	if(var_77e61fc6 == 0)
	{
		if(isdefined(item) && isdefined(item.var_a6762160))
		{
			function_1a46c8ae(self, var_a1ca235e, var_3d1f9df4, item.var_a6762160, item.var_a6762160.amount);
			if(item.var_a6762160.itemtype == #"backpack")
			{
				item_inventory::function_ec238da8();
			}
		}
		consume_item(item);
	}
	else if(!isentity(item) && item.var_a6762160.itemtype != #"ammo")
	{
		dropitem = self item_drop::drop_item(item.var_a6762160.weapon, item.count, item.amount, item.id, item.origin, item.angles, 0, undefined, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname), undefined, undefined, 0);
		if(isdefined(dropitem))
		{
			dropitem.origin = item.origin;
			dropitem.angles = item.angles;
			consume_item(item);
		}
	}
	return true;
}

/*
	Name: function_8eee98dd
	Namespace: item_world
	Checksum: 0xC51C0F4D
	Offset: 0x7F88
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_8eee98dd(supplystash)
{
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	function_4de3ca98();
	/#
		assert(isdefined(supplystash));
	#/
	if(!isdefined(supplystash) || !isdefined(supplystash.targetname))
	{
		return;
	}
	targetname = (isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(!isdefined(item.var_a6762160))
		{
			continue;
		}
		if(distancesquared(item.origin, supplystash.origin) > 36)
		{
			continue;
		}
		function_54ca5536(item.id, -1);
		resetitem = level flagsys::get(#"item_world_reset");
		function_bfc28859(3, item.id, resetitem);
	}
	function_e2a06860(supplystash, 0);
}

/*
	Name: function_160294c7
	Namespace: item_world
	Checksum: 0xBF2C80B6
	Offset: 0x8190
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_160294c7(supplystash)
{
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	function_4de3ca98();
	/#
		assert(isdefined(supplystash));
	#/
	if(!isdefined(supplystash) || !isdefined(supplystash.targetname))
	{
		return;
	}
	targetname = (isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, supplystash.origin) > 36)
		{
			continue;
		}
		if(item_world_util::can_pick_up(item))
		{
			consume_item(item);
		}
	}
	consumeitems = [];
	foreach(item in level.item_spawn_drops)
	{
		if(!isdefined(item))
		{
			continue;
		}
		var_45602f41 = (isdefined(item.targetname) ? item.targetname : item.var_67169c0b);
		if(!isdefined(var_45602f41))
		{
			continue;
		}
		if(var_45602f41 == targetname)
		{
			if(item_world_util::can_pick_up(item))
			{
				consumeitems[consumeitems.size] = item;
			}
		}
	}
	foreach(item in consumeitems)
	{
		if(isdefined(item))
		{
			consume_item(item);
		}
	}
	function_e2a06860(supplystash, 3);
}

/*
	Name: function_eb0c9b9c
	Namespace: item_world
	Checksum: 0x40E8BB37
	Offset: 0x84A0
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function function_eb0c9b9c()
{
	players = getplayers();
	var_7bba6210 = 1;
	while(var_7bba6210)
	{
		waitframe(1);
		var_7bba6210 = 0;
		foreach(player in players)
		{
			if(isdefined(player) && isalive(player) && (isdefined(player.var_7bba6210) && player.var_7bba6210))
			{
				var_7bba6210 = 1;
				break;
			}
		}
	}
}

/*
	Name: reset_item_world
	Namespace: item_world
	Checksum: 0x9117BCD3
	Offset: 0x85A0
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function reset_item_world()
{
	level.var_703d32de = 0;
	level.var_ab396c31 = 1;
	util::wait_network_frame(1);
	/#
		assert(level.var_703d32de == 0);
	#/
	players = getplayers();
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		if(isalive(player))
		{
			player thread item_inventory::reset_inventory();
		}
		if(((index + 1) % 3) == 0)
		{
			waitframe(1);
		}
	}
	function_eb0c9b9c();
	/#
		assert(level.var_703d32de == 0);
	#/
	function_f7fb8a17(1);
	util::wait_network_frame(1);
	/#
		assert(level.var_703d32de == 0);
	#/
	level.var_ab396c31 = undefined;
}

/*
	Name: function_cbc32e1b
	Namespace: item_world
	Checksum: 0xE2759302
	Offset: 0x8730
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_cbc32e1b(milliseconds)
{
	/#
		assert(isint(milliseconds));
	#/
	if(isint(milliseconds))
	{
		level.var_75dc9c49 = milliseconds;
	}
}

/*
	Name: function_1b11e73c
	Namespace: item_world
	Checksum: 0xAF656E6E
	Offset: 0x8798
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_1b11e73c()
{
	reset = isdefined(level flagsys::get(#"item_world_reset"));
	level flagsys::wait_till(#"item_world_initialized");
	if(reset != isdefined(level flagsys::get(#"item_world_reset")))
	{
		return false;
	}
	return true;
}

/*
	Name: function_4de3ca98
	Namespace: item_world
	Checksum: 0xC6A215DE
	Offset: 0x8830
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_4de3ca98()
{
	level flagsys::wait_till(#"item_world_initialized");
	level flagsys::wait_till(#"item_world_reset");
	while(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		waitframe(1);
	}
	util::wait_network_frame(1);
}

/*
	Name: function_76eb9bd7
	Namespace: item_world
	Checksum: 0x10FA85B5
	Offset: 0x88C0
	Size: 0x1A8
	Parameters: 0
	Flags: None
*/
function function_76eb9bd7()
{
	/#
		function_1b11e73c();
		if(!isdefined(self) || !isplayer(self) || !isalive(self))
		{
			return;
		}
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		inventorystr = getdvarstring(#"hash_7b2be9e03d9785f3", "");
		tokens = strtok(inventorystr, "");
		foreach(token in tokens)
		{
			item = function_4ba8fde(token);
			if(isdefined(item))
			{
				var_fa3df96 = self item_inventory::function_e66dcff5(item);
				self function_de2018e3(item, self, var_fa3df96);
			}
		}
	#/
}

