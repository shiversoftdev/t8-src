// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2bb5600d583e2812;
#using script_39bd5b6b799b1c9c;
#using script_3a6e1cc57d28db61;
#using script_3f65948f90646f7c;
#using script_64ab2b950d85b8ad;
#using script_6b7c77b107c81e62;
#using script_6b993fdc7adc35ec;
#using script_6e26f2d648dc4251;
#using script_8988fdbc78d6c53;
#using script_cb32d07c95e5628;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\armor.gsc;

#namespace item_world;

/*
	Name: function_89f2df9
	Namespace: item_world
	Checksum: 0x307C2D71
	Offset: 0x3C8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
private function __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	level.var_9cddbf4e = [];
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_01_mod"] = {#hash_b9492c6:#"hash_32f9ba3b1da75ed5", #hash_f6d388aa:#"hash_3462cfb200a2367"};
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_04_mod"] = {#hash_b9492c6:#"hash_32f9ba3b1da75ed5", #hash_f6d388aa:#"hash_3462cfb200a2367"};
	level.var_9cddbf4e[#"p8_fxanim_wz_death_stash_mod"] = {#hash_b9492c6:#"hash_70fb2ee1b706a28a", #hash_f6d388aa:#"hash_5e8b0f6cade25ff6"};
	level.var_9cddbf4e[#"hash_1dcbe8021fb16344"] = {#hash_b9492c6:#"hash_6fcb29cae6678d93", #hash_f6d388aa:#"hash_56b5b65c141f4629"};
	level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_ammo_mod"] = {#hash_b9492c6:#"hash_3e62bcbd6460ff44", #hash_f6d388aa:#"hash_f743d336f8b7764"};
	level.var_9cddbf4e[#"hash_574076754776e003"] = {#hash_b9492c6:#"hash_22f426a8593609e8", #hash_f6d388aa:#"hash_36e23ce3e5f7e4c0"};
	level.var_9cddbf4e[#"wpn_t7_drop_box_wz"] = {#hash_b9492c6:#"hash_2b751d50426093db", #hash_f6d388aa:#"hash_613f8a1669f8b231"};
	callback::on_connect(&function_4d97b664);
	callback::on_spawned(&function_e4a4b07b);
	callback::on_disconnect(&function_d446afe1);
	callback::add_callback(#"hash_41781454d98b676a", &function_9aefb438);
	clientfield::register("world", "item_world_seed", 1, 31, "int");
	clientfield::register("world", "item_world_disable", 1, 1, "int");
	clientfield::register("scriptmover", "item_world_attachments", 10000, 1, "int");
	clientfield::function_a8bbc967("hudItems.pickupHintGold", 1, 1, "int", 1);
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
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_227b9e91 = object;
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
private function function_e6ea1ee0()
{
	[[ level.var_227b9e91 ]]->waitinqueue(self);
	var_fee74908 = function_784b5aa6();
	var_fee74908[var_fee74908.size] = (level flagsys::get(#"hash_38a387462f3a9ad") ? 1 : 0);
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
private function function_e0b64358(player, item)
{
	if(!isdefined(player) || !isdefined(item))
	{
		return;
	}
	stash = namespace_ad5a0cd6::function_31f5aa51(item);
	if(isdefined(stash) && (isdefined(stash.var_1ed4b650) && stash.var_1ed4b650))
	{
		var_97809692 = player namespace_b376ff3f::function_2e711614(15);
		if(isdefined(var_97809692) && isdefined(var_97809692.var_a6762160) && var_97809692.var_a6762160.name == #"hash_211559ff9a516b7d")
		{
			player namespace_b376ff3f::function_6e376bb1(var_97809692.var_bd027dd9, 1);
			if(!isdefined(player.var_fbcc86d3))
			{
				player.var_fbcc86d3 = [];
			}
			player.var_fbcc86d3[item.var_a6762160.weapon.name] = 1;
		}
		var_97809692 = player namespace_b376ff3f::function_2e711614(15);
		if(!isdefined(var_97809692) || !isdefined(var_97809692.var_a6762160) || var_97809692.var_a6762160.name != #"hash_211559ff9a516b7d")
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
private function function_f3b6e182(player)
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
	usetrigger function_49462027(1, 1 | 16 | 8388608 | 65536 | 4194304);
	player.var_207c9892 = getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000;
	function_dae4ab9b(usetrigger, player.var_207c9892);
	player clientclaimtrigger(usetrigger);
	player.var_19caeeea = usetrigger;
	usetrigger callback::function_35a12f19(&function_ad7ad6ce);
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
private function function_b516210b(var_889058cc, origin, activator)
{
	if(!isplayer(activator))
	{
		return;
	}
	var_cde95668 = isdefined(activator) && activator hasperk(#"specialty_quieter");
	if(isdefined(level.var_9cddbf4e[var_889058cc]))
	{
		mapping = level.var_9cddbf4e[var_889058cc];
		var_f6d388aa = playsoundatposition(mapping.var_f6d388aa, origin + vectorscale((0, 0, 1), 50));
		if(isdefined(var_f6d388aa))
		{
			var_f6d388aa hide();
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
			if(isdefined(var_f6d388aa))
			{
				var_f6d388aa showtoplayer(player);
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
private function function_d045e83b(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slot)
{
	if(item.var_a6762160.itemtype !== #"ammo")
	{
		/#
			assertmsg("" + item.name + "");
		#/
		return 0;
	}
	if(!self namespace_b376ff3f::function_e106cbe9(item))
	{
		return (isdefined(var_aec6fa7f) ? var_aec6fa7f : (isdefined(item.var_a6762160.var_a6762160.amount) ? item.var_a6762160.amount : 1));
	}
	player function_b00db06(8, var_d8138db2);
	return player namespace_b376ff3f::function_11089ed8(item, var_aec6fa7f);
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
private function function_2e5b5858(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	droppeditem = undefined;
	var_3d1f9df4 = 0;
	var_b0938bd7 = undefined;
	var_381f3b39 = 0;
	if(player armor::has_armor())
	{
		var_b619c089 = player.inventory.items[11];
		if(var_b619c089.var_bd027dd9 != 32767)
		{
			droppeditem = var_b619c089.var_a6762160;
			var_3d1f9df4 = droppeditem.amount;
		}
	}
	player namespace_b376ff3f::drop_armor();
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, 1, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		if(player namespace_b376ff3f::function_fba4a353(item))
		{
			player namespace_b376ff3f::equip_armor(item);
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
private function function_cb9b4dd7(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
	player namespace_b376ff3f::function_3d113bfb();
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
private function function_14b2eddf(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_f0dc4e93 = player namespace_b376ff3f::function_ec087745();
	var_4838b749 = undefined;
	if(isdefined(var_f0dc4e93) && var_f0dc4e93 != 32767)
	{
		var_4838b749 = player namespace_b376ff3f::function_b246c573(var_f0dc4e93);
	}
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
	if(isdefined(var_4838b749) && isdefined(slotid) && namespace_a0d533d1::function_398b9770(var_4838b749, slotid))
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		player namespace_b376ff3f::function_224c09c9(item, var_f0dc4e93, undefined, 0);
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
private function function_42ffe9b2(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	if(player namespace_b376ff3f::function_fba4a353(item))
	{
		slotid = 13;
	}
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
	if(var_77e61fc6 < itemcount && slotid === 13)
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		player namespace_b376ff3f::function_2dab8a7f(item);
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
private function function_2eebeff5(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		if(player namespace_b376ff3f::function_fba4a353(item))
		{
			player thread namespace_b376ff3f::function_c8bedf1b(item);
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
private function function_349d4c26(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		if(player namespace_b376ff3f::function_fba4a353(item))
		{
			player thread namespace_b376ff3f::function_11fc9fa9(item);
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
private function function_670cce3f(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
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
private function function_41a52251(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
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
private function function_2b2e9302(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
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
private function function_a240798a(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, undefined, slotid);
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
private function function_a712496a(item, player, var_bd027dd9, var_d8138db2, itemcount, var_aec6fa7f, slotid)
{
	/#
		assert(isplayer(self));
	#/
	if(namespace_b376ff3f::function_57eac2ca() == 2)
	{
		var_be90d3da = item.var_8e092725 === -1;
		~item;
		var_be90d3da = var_be90d3da & (isdefined(item.var_4961f577) ? item.var_4961f577 : 0);
		var_64d58696 = namespace_b376ff3f::function_230ceec4(player.currentweapon);
		if(!isdefined(var_64d58696))
		{
			player takeweapon(player.currentweapon);
		}
		else
		{
			player thread namespace_b376ff3f::function_418f9eb8(var_64d58696.var_bd027dd9, var_be90d3da, item.origin, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname));
		}
	}
	var_77e61fc6 = player namespace_b376ff3f::function_e274f1fe(item, itemcount, var_aec6fa7f, slotid);
	if(var_77e61fc6 < itemcount)
	{
		if(isdefined(item.var_bd027dd9) && namespace_ad5a0cd6::function_db35e94f(item.var_bd027dd9))
		{
			item = namespace_b376ff3f::function_dfcacdc2(item.var_bd027dd9);
		}
		player namespace_b376ff3f::function_2b4d7b66(item, 1, 1, 0, 1);
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
private function function_e1965ae1()
{
	level endon(#"game_ended");
	waitframe(1);
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	util::wait_network_frame(1);
	level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
	setdvar(#"hash_21e070fbb56cf0f", 0);
	if(isdefined(level.var_5862f2ce))
	{
		foreach(var_b7c28bcc in level.var_5862f2ce)
		{
			setdynentenabled(var_b7c28bcc, 1);
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
	foreach(var_48ad08f5 in level.var_2da60c10)
	{
		if(isdefined(var_48ad08f5))
		{
			var_48ad08f5 namespace_8bf2881e::function_7bfc867f();
		}
	}
	function_8da29c95();
	if((isdefined(getgametypesetting(#"hash_7d8c969e384dd1c9")) ? getgametypesetting(#"hash_7d8c969e384dd1c9") : 0) || (isdefined(getgametypesetting(#"hash_24918193d72a5866")) ? getgametypesetting(#"hash_24918193d72a5866") : 0))
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
		player thread namespace_b376ff3f::function_461de298();
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
private function function_f7fb8a17(reset = 1)
{
	level endon(#"game_ended");
	waitframe(1);
	level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
	level flagsys::set(#"hash_2d3b2a4d082ba5ee");
	if(level flagsys::get(#"hash_38a387462f3a9ad"))
	{
		return;
	}
	waitframe(1);
	level flagsys::clear(#"hash_51daecff754729dc");
	var_47f2f5fa = 1 << 29 - 1;
	var_582cb7bb = randomintrange(0, var_47f2f5fa) + 1;
	/#
		var_582cb7bb = getdvarint(#"hash_46870e6b25b988eb", var_582cb7bb);
	#/
	level.var_cca3647d = var_582cb7bb;
	match_record::set_stat(#"hash_45cd259b367a6b1e", var_582cb7bb);
	setdvar(#"hash_21e070fbb56cf0f", 0);
	var_6937495e = var_582cb7bb << 1;
	var_6937495e = var_6937495e | (reset ? 1 : 0);
	level clientfield::set("item_world_seed", var_6937495e);
	level namespace_f0884ae5::setup(var_582cb7bb, reset);
	level flagsys::set(#"hash_51daecff754729dc");
	if(reset)
	{
		level flagsys::set(#"hash_38a387462f3a9ad");
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
private function function_a7b7d70b(player, var_bd027dd9)
{
	item = player namespace_b376ff3f::function_dfcacdc2(var_bd027dd9);
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
private function function_8bac489c(var_f4cdfe08, player)
{
	/#
		assert(isdefined(var_f4cdfe08));
	#/
	/#
		assert(isplayer(player));
	#/
	if(var_f4cdfe08.var_193b3626 === player getentitynumber())
	{
		return 1;
	}
	return 0;
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
private function function_35c26e09(var_f4cdfe08)
{
	var_f4cdfe08.var_193b3626 = undefined;
	var_f4cdfe08.var_80089988 = undefined;
	targetname = (isdefined(var_f4cdfe08.targetname) ? var_f4cdfe08.targetname : var_f4cdfe08.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	var_3c32093e = 0;
	var_3ba9a53f = [];
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, var_f4cdfe08.origin) > 36)
		{
			continue;
		}
		if(!isdefined(item.var_a6762160))
		{
			continue;
		}
		if(namespace_ad5a0cd6::can_pick_up(item))
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
			var_5a0fa544 = level flagsys::get(#"hash_38a387462f3a9ad");
			function_bfc28859(3, item.id, var_5a0fa544);
			break;
		}
	}
	function_e2a06860(var_f4cdfe08, 0);
	return 1;
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
private function function_199c092d(var_f4cdfe08, player = undefined)
{
	/#
		assert(!isdefined(var_f4cdfe08.var_193b3626));
	#/
	if(isdefined(var_f4cdfe08.var_193b3626))
	{
		return 0;
	}
	var_f4cdfe08.var_193b3626 = player getentitynumber();
	item = player namespace_b376ff3f::function_2e711614(15);
	if(item.var_a6762160.name !== #"hash_211559ff9a516b7d")
	{
		return 0;
	}
	var_bcb39afb = player namespace_a0d533d1::function_169cea63();
	/#
		assert(var_bcb39afb.size > 0);
	#/
	if(var_bcb39afb.size <= 0)
	{
		return 0;
	}
	var_cf23afee = [];
	foreach(weaponname in var_bcb39afb)
	{
		var_cf23afee[weaponname] = 1;
	}
	targetname = (isdefined(var_f4cdfe08.targetname) ? var_f4cdfe08.targetname : var_f4cdfe08.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, var_f4cdfe08.origin) > 36)
		{
			continue;
		}
		if(!isdefined(item.var_a6762160) || !isdefined(item.var_a6762160.weapon))
		{
			continue;
		}
		if(namespace_ad5a0cd6::can_pick_up(item) && !isdefined(var_cf23afee[item.var_a6762160.weapon.name]))
		{
			function_7730442c(item);
			continue;
		}
		if(isdefined(player.var_fbcc86d3) && isdefined(player.var_fbcc86d3[item.var_a6762160.weapon.name]))
		{
			function_7730442c(item);
			continue;
		}
		if(isdefined(var_cf23afee[item.var_a6762160.weapon.name]))
		{
			function_54ca5536(item.id, -1);
			var_5a0fa544 = level flagsys::get(#"hash_38a387462f3a9ad");
			function_bfc28859(3, item.id, var_5a0fa544);
			continue;
		}
	}
	return 1;
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
private function function_23b313bd(player, eventtype, eventdata, var_c5a66313)
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
			var_94f9862b = (eventdata ? 1 : 150);
			defaulttime = getdvarint(#"hash_3ec4f617fad5b87c", 150);
			player.var_207c9892 = min(var_94f9862b, defaulttime) / 1000;
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
		if(player inlaststand() || !isdefined(player.inventory) || !player namespace_b376ff3f::function_5a0ba107(var_bd027dd9, quickequip === 1, weaponid))
		{
			function_a7b7d70b(player, var_bd027dd9);
		}
		else
		{
			var_d8138db2 = player namespace_b376ff3f::function_c48cd17f(var_bd027dd9);
			if(var_d8138db2 != 32767)
			{
				item = function_b1702735(var_d8138db2);
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
				if(isdefined(item) && player namespace_ad5a0cd6::can_pick_up(item))
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
			if(namespace_ad5a0cd6::function_2c7fc531(var_bd027dd9))
			{
				var_d8138db2 = var_bd027dd9;
				item = function_b1702735(var_d8138db2);
				/#
					assert(item.var_a6762160.itemtype == #"ammo");
				#/
				if(item.var_a6762160.itemtype == #"ammo")
				{
					var_a1ca235e = item.var_a6762160;
					var_3d1f9df4 = count;
					player namespace_b376ff3f::function_ecd1c667(var_d8138db2, count);
				}
			}
			else if(var_bd027dd9 == 32767)
			{
				return;
			}
			var_86afeb67 = player namespace_b376ff3f::function_dfcacdc2(var_bd027dd9);
			if(!isdefined(var_86afeb67))
			{
				break;
			}
			var_104acafa = isdefined(var_86afeb67.endtime);
			if(!isdefined(count) || count === var_86afeb67.count || var_104acafa)
			{
				var_3d1f9df4 = (isdefined(count) ? count : var_86afeb67.var_a6762160.amount);
				player namespace_b376ff3f::function_418f9eb8(var_bd027dd9);
			}
			else
			{
				var_3d1f9df4 = count;
				player namespace_b376ff3f::function_cfe0e919(var_bd027dd9, count);
			}
			function_1a46c8ae(player, var_a1ca235e, var_3d1f9df4, undefined, undefined);
			break;
		}
		case 6:
		{
			var_bd027dd9 = eventdata;
			var_c3f14af5 = player namespace_b376ff3f::function_777cc133();
			if(isdefined(var_c3f14af5))
			{
				player namespace_b376ff3f::function_d019bf1d(var_bd027dd9);
				var_5a2df6f9 = player namespace_b376ff3f::function_b246c573(var_bd027dd9);
				if(isdefined(var_5a2df6f9))
				{
					player namespace_b376ff3f::function_26c87da8(var_5a2df6f9, var_c3f14af5);
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
			if(distance2dsquared(origin, item.origin) > 128 * 128 || abs(origin[2] - item.origin[2]) > 128)
			{
				return;
			}
			if(!isdefined(item) || !isdefined(item.var_a6762160))
			{
				return;
			}
			if(item.var_a6762160.itemtype == #"weapon")
			{
				var_bd31d7b2 = player namespace_b376ff3f::function_ec087745();
				success = 0;
				if(var_fc7876fd == 1 && var_bd31d7b2 != 32767)
				{
					success = player namespace_b376ff3f::function_9d102bbd(item, var_bd31d7b2);
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
			else if(var_fc7876fd == 2)
			{
				player namespace_b376ff3f::function_fba40e6c(item);
				break;
			}
			var_641d3dc2 = item.var_a6762160.itemtype != #"attachment";
			var_a6762160 = item.var_a6762160;
			player pickup_item(item, var_641d3dc2);
			if(var_fc7876fd == 1 || var_fc7876fd == 2)
			{
				if(isdefined(var_a6762160))
				{
					var_b619c089 = player namespace_b376ff3f::function_8babc9f9(var_a6762160);
				}
				if(isdefined(var_b619c089))
				{
					switch(var_b619c089.var_a6762160.itemtype)
					{
						case "equipment":
						{
							player namespace_b376ff3f::function_c8bedf1b(var_b619c089);
							break;
						}
						case "health":
						{
							player namespace_b376ff3f::function_11fc9fa9(var_b619c089);
							break;
						}
					}
				}
			}
			break;
		}
		case 8:
		{
			var_bd027dd9 = eventdata;
			player namespace_b376ff3f::function_9ba10b94(var_bd027dd9);
			break;
		}
		case 10:
		{
			player namespace_b376ff3f::function_e46ef859();
			break;
		}
		case 9:
		{
			player namespace_b376ff3f::function_20ecd64d();
			break;
		}
	}
}

/*
	Name: function_4d97b664
	Namespace: item_world
	Checksum: 0x3E50ADCA
	Offset: 0x37F8
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4d97b664()
{
	function_f3b6e182(self);
	self namespace_b376ff3f::function_814b5785();
	self.var_d7a70ae4 = undefined;
	if(function_76915220() && (!self issplitscreen() || !self function_f27ff71f()))
	{
		self thread function_ba96cdf(self);
	}
}

/*
	Name: function_d446afe1
	Namespace: item_world
	Checksum: 0xE5F99169
	Offset: 0x38A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d446afe1()
{
	if(isdefined(self.var_19caeeea))
	{
		self.var_19caeeea delete();
	}
}

/*
	Name: function_e4a4b07b
	Namespace: item_world
	Checksum: 0xEB60CAD8
	Offset: 0x38E0
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e4a4b07b()
{
	if(!isdefined(self.inventory))
	{
		self namespace_b376ff3f::function_814b5785();
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
private function function_9aefb438(params)
{
	if(isdefined(params) && params.message == #"hash_52e9e8e985489587")
	{
		if(!isdefined(self) || !isplayer(self) || !isalive(self))
		{
			params.player = undefined;
			return;
		}
		var_b909352 = 13;
		var_bd027dd9 = undefined;
		if(!isdefined(self.var_bf3cabc9))
		{
			var_9b882d22 = self.var_d5673d87;
			if(!isdefined(var_9b882d22) || !isdefined(var_9b882d22.var_bd027dd9))
			{
				params.player = undefined;
				return;
			}
			if(!(isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1) && distance2dsquared(var_9b882d22.origin, self.origin) > 128 * 128)
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
			var_b909352 = 14;
			var_bd027dd9 = self.var_bf3cabc9 getentitynumber();
		}
		platoon = function_22448d6c(self.team);
		if(platoon != #"none" && platoon != #"invalid")
		{
			teams = function_37d3bfcb(platoon);
			members = [];
			foreach(team in teams)
			{
				foreach(member in getplayers(team))
				{
					member function_b00db06(var_b909352, var_bd027dd9, self getentitynumber());
				}
			}
		}
		else
		{
			members = getplayers(self.team);
			foreach(member in members)
			{
				member function_b00db06(var_b909352, var_bd027dd9, self getentitynumber());
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
private function function_f27ff71f()
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
			return 1;
		}
	}
	return 0;
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
private function function_df1098a()
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
			if(index + 1 % 15 == 0)
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
private function function_ad7ad6ce(trigger_struct)
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
		stash = namespace_ad5a0cd6::function_31f5aa51(usetrigger.var_ba85cc6f);
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
	if(var_91d3170d == 1 || (var_91d3170d == 0 && usetrigger.var_ba85cc6f.var_8e092725 === -1))
	{
		usetrigger sethintstring(#"");
		activator clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 2);
		activator thread function_eb900758(namespace_ad5a0cd6::function_31f5aa51(usetrigger.var_ba85cc6f));
		function_a54d07e6(usetrigger.var_ba85cc6f, activator);
	}
	else if(var_91d3170d == 2)
	{
		usetrigger sethintstring(#"");
	}
	else
	{
		item = usetrigger.var_ba85cc6f;
		if(isdefined(item) && !isentity(item) && isdefined(item.id))
		{
			item = function_b1702735(item.id);
		}
		if(activator namespace_ad5a0cd6::can_pick_up(item))
		{
			activator pickup_item(item);
			while(isdefined(activator) && activator usebuttonpressed())
			{
				waitframe(1);
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
private function function_eb900758(stash)
{
	self thread function_d87c50ae(stash);
	self thread function_6266f448(stash);
	self waittill(#"disconnect", #"death", #"entering_last_stand", #"hash_2781407e327b42ee");
	if(isdefined(stash) && (isdefined(stash.var_1ed4b650) && stash.var_1ed4b650))
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
private function function_6266f448(stash)
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
private function function_d87c50ae(stash)
{
	self notify("4bd96bb741326417");
	self endon("4bd96bb741326417");
	self endon(#"disconnect", #"death", #"entering_last_stand", #"hash_2781407e327b42ee");
	while(true)
	{
		waitframe(1);
		if(!isdefined(self.var_f0f7e918))
		{
			break;
		}
		if(self.var_f0f7e918.size == 0)
		{
			break;
		}
		var_9f69a4d3 = 0;
		foreach(item in self.var_f0f7e918)
		{
			if(isdefined(item) && self namespace_ad5a0cd6::can_pick_up(item))
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
		if(isdefined(stash) && (isdefined(stash.var_1ed4b650) && stash.var_1ed4b650) && !function_8bac489c(stash, self))
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
private function function_937ea9e(identifier, handler)
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
private function function_ba96cdf(player)
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
private function function_116fd9a7()
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
private function function_76915220()
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
	resetflag = level flagsys::get(#"hash_38a387462f3a9ad");
	while(true)
	{
		var_5610ded4 = level flagsys::get(#"hash_38a387462f3a9ad");
		if(var_5610ded4 != resetflag)
		{
			level.var_37a4536d = [];
		}
		if(level.var_75dc9c49 > 0)
		{
			time = gettime();
			for(index = 0; index < level.var_37a4536d.size; index++)
			{
				var_3d2f8fc3 = level.var_37a4536d[index];
				if(time - var_3d2f8fc3.var_8e092725 >= level.var_75dc9c49)
				{
					function_54ca5536(var_3d2f8fc3.id, 0);
					function_bfc28859(3, var_3d2f8fc3.id, var_5610ded4, 1);
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
				stashes[0] callback::callback(#"hash_20eb78148e01f7c3", params);
			}
			else if(state == 1)
			{
				var_bad52796 = function_91b29d2a(targetname);
				var_bad52796 = arraysortclosest(var_bad52796, stashes[0].origin, var_bad52796.size, 0, 12);
				foreach(var_be90d3da in var_bad52796)
				{
					if(isdefined(var_be90d3da.var_a6762160) && var_be90d3da.var_8e092725 === -1)
					{
						return;
					}
				}
				var_c5c64633 = [];
				foreach(var_979cae3d in level.var_a4a4012e)
				{
					if(isdefined(var_979cae3d) && var_979cae3d.var_67169c0b === targetname)
					{
						var_c5c64633[var_c5c64633.size] = var_979cae3d;
					}
				}
				var_c5c64633 = arraysortclosest(var_c5c64633, stashes[0].origin, var_c5c64633.size, 0, 12);
				foreach(var_ae944413 in var_c5c64633)
				{
					if(var_ae944413.var_8e092725 === -1)
					{
						return;
					}
				}
				if(isdefined(stashes[0].var_1ed4b650) && stashes[0].var_1ed4b650 && activator !== level)
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
				stash callback::callback(#"hash_20eb78148e01f7c3", params);
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
				var_c5c64633 = [];
				foreach(var_979cae3d in level.var_a4a4012e)
				{
					if(isdefined(var_979cae3d) && var_979cae3d.var_67169c0b === targetname)
					{
						var_c5c64633[var_c5c64633.size] = var_979cae3d;
					}
				}
				var_c5c64633 = arraysortclosest(var_c5c64633, stashes[0].origin, var_c5c64633.size, 0, 12);
				foreach(var_ae944413 in var_c5c64633)
				{
					if(var_ae944413.var_8e092725 === -1)
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
private function function_7c84312d(origin, angles)
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
			var_47684cd2 = itemdef.origin - origin;
			if(itemdef.var_8e092725 !== -1)
			{
				continue;
			}
			var_1777205e = vectordot(var_75f6d739, vectornormalize((var_47684cd2[0], var_47684cd2[1], 0)));
			if(var_1777205e >= 0.5 && distancesquared(itemdef.origin, self.var_d7abc784) <= 12 * 12)
			{
				if(namespace_ad5a0cd6::function_2eb2c17c(origin, itemdef))
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
		var_9b882d22 = namespace_ad5a0cd6::function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe);
	}
	if(self inlaststand())
	{
		var_9b882d22 = undefined;
	}
	var_caafaa25 = #"";
	if(isdefined(var_9b882d22) && !self isinvehicle())
	{
		self.var_f0f7e918 = [];
		var_4f583f35 = self namespace_b376ff3f::has_backpack();
		var_be90d3da = var_9b882d22.var_8e092725 === -1;
		var_52bfa6e5 = !var_be90d3da && namespace_b376ff3f::function_550fcb41(var_9b882d22);
		var_f4b42fba = self namespace_b376ff3f::has_armor() && var_9b882d22.var_a6762160.itemtype == #"armor";
		isammo = var_9b882d22.var_a6762160.itemtype == #"ammo";
		var_de41d336 = !var_4f583f35 && var_9b882d22.var_a6762160.itemtype == #"backpack";
		if(var_be90d3da || (!isammo && !var_de41d336 && !var_52bfa6e5 && !var_f4b42fba))
		{
			var_433d429 = 14;
			self.var_f0f7e918 = function_2e3efdda(var_9b882d22.origin, undefined, 128, var_433d429);
			self.var_f0f7e918 = self array::filter(self.var_f0f7e918, 0, &namespace_ad5a0cd6::can_pick_up);
		}
		if(self.var_f0f7e918.size == 1)
		{
			var_be90d3da = self.var_f0f7e918[0].var_8e092725 === -1;
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
		if(var_be90d3da)
		{
			usetrigger setcursorhint("HINT_NOICON");
			usetrigger sethintstring(#"");
			usetrigger function_89fca53b(1);
			usetrigger function_49462027(0);
			stash = namespace_ad5a0cd6::function_31f5aa51(var_9b882d22);
			var_e30063d2 = isdefined(stash) && (isdefined(stash.var_1ed4b650) && stash.var_1ed4b650);
			currentstate = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
			if(currentstate != 2 || (currentstate == 2 && var_b46724f6))
			{
				if(distancesquared(origin, var_9b882d22.origin) > 128 * 128)
				{
					self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
				}
				else if(var_e30063d2 && !function_8bac489c(stash, self))
				{
					if(self namespace_b376ff3f::function_471897e2())
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
		else
		{
			usetrigger function_89fca53b(0);
			usetrigger function_49462027(1, 1 | 16 | 8388608 | 65536 | 4194304);
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
						var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"hash_64b3a5bc6b1aba8c");
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
		usetrigger.var_ba85cc6f = var_9b882d22;
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
				if(!namespace_b376ff3f::function_e106cbe9(var_9b882d22))
				{
					function_dae4ab9b(usetrigger, getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000);
				}
			}
			else if(!isdefined(namespace_b376ff3f::function_e66dcff5(var_9b882d22)))
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
		usetrigger.var_ba85cc6f = undefined;
		usetrigger triggerenable(0);
		self.var_f0f7e918 = undefined;
	}
	self.var_bb8abe86 = forward;
	self.var_1609622c = origin;
	self.var_34b00d0d = level.var_703d32de;
	self.var_cc586562 = undefined;
	self.var_bf3cabc9 = undefined;
	eyepos = self getplayercamerapos();
	if(isdefined(var_9b882d22) && (isdefined(var_9b882d22.var_5d97fed1) && var_9b882d22.var_5d97fed1))
	{
		var_caafaa25 = #"hash_1b179a759b7f05c8";
		var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, var_9b882d22.origin, 1, 0, 12);
		if(var_1ba7b9c8.size > 0 && isdefined(var_1ba7b9c8[0].displayname))
		{
			var_caafaa25 = var_1ba7b9c8[0].displayname;
		}
		var_c36bd68a = arraysortclosest(level.var_ace9fb52, var_9b882d22.origin, 1, 0, 12);
		if(var_c36bd68a.size > 0)
		{
			var_caafaa25 = #"hash_7b3fd580a423c4ef";
		}
		else
		{
			var_6594679a = arraysortclosest(level.var_a5f063d, var_9b882d22.origin, 1, 0, 12);
			if(var_6594679a.size > 0)
			{
				var_caafaa25 = #"hash_378637b14671886";
			}
		}
	}
	else if(!isdefined(var_9b882d22) || distance2dsquared(var_9b882d22.origin, eyepos) > 128 * 128)
	{
		angles = self getplayerangles();
		self.var_bf3cabc9 = namespace_ad5a0cd6::function_6af455de(0, eyepos, angles);
		hintstring = namespace_ad5a0cd6::function_c62ad9a7(self.var_bf3cabc9);
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
	Name: function_7730442c
	Namespace: item_world
	Checksum: 0x770370CD
	Offset: 0x6718
	Size: 0x3B4
	Parameters: 1
	Flags: Linked
*/
function function_7730442c(item)
{
	if(isdefined(level.var_ab396c31) && level.var_ab396c31)
	{
		return;
	}
	if(isentity(item))
	{
		item.var_8e092725 = gettime();
		if(isdefined(item.var_d783088e))
		{
			foreach(var_711e35e5 in item.var_d783088e)
			{
				if(!isdefined(var_711e35e5))
				{
					continue;
				}
				var_711e35e5 thread namespace_d81cee52::function_4db10465();
			}
			item.var_d783088e = undefined;
		}
	}
	else if(isdefined(item))
	{
		function_54ca5536(item.id, gettime());
		if(isdefined(item.var_a6762160) && (isdefined(item.var_a6762160.var_47f145b4) && item.var_a6762160.var_47f145b4))
		{
			var_3d2f8fc3 = spawnstruct();
			var_3d2f8fc3.id = item.id;
			var_3d2f8fc3.var_8e092725 = gettime();
			level.var_37a4536d[level.var_37a4536d.size] = var_3d2f8fc3;
		}
		if(level flagsys::get(#"hash_38a387462f3a9ad"))
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
	if(namespace_ad5a0cd6::function_d9648161(var_bd027dd9))
	{
		if(namespace_ad5a0cd6::function_2c7fc531(var_bd027dd9))
		{
			return function_b1702735(var_bd027dd9);
		}
		if(namespace_ad5a0cd6::function_da09de95(var_bd027dd9))
		{
			if(isdefined(level.var_a4a4012e[var_bd027dd9]))
			{
				return level.var_a4a4012e[var_bd027dd9];
			}
		}
		assert(0, "");
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
	var_f4b807cb = function_abaeb170(origin, dir, var_4e7bdb02, maxdistance, dot, var_bc1582aa, 2147483647);
	var_6665e24 = arraysortclosest(level.var_a4a4012e, origin, var_4e7bdb02, 0, maxdistance);
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
		var_5f8125a9 = level.var_66383953[var_a6762160.handler];
		if(isdefined(var_5f8125a9))
		{
			var_aec6fa7f = item.amount;
			if(!isdefined(var_aec6fa7f) || item.amount == 0)
			{
				if(var_a6762160.itemtype == #"ammo")
				{
				}
				else if(var_a6762160.itemtype == #"weapon")
				{
					if(!isdefined(item.amount))
					{
						weapon = namespace_ad5a0cd6::function_35e06774(var_a6762160);
						var_aec6fa7f = var_a6762160.amount;
						if(isdefined(weapon))
						{
							var_aec6fa7f = var_a6762160.amount * weapon.clipsize;
						}
					}
				}
				else if(var_a6762160.itemtype == #"armor")
				{
					var_aec6fa7f = var_a6762160.amount;
				}
				else if(var_a6762160.itemtype == #"equipment")
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
			var_d72b1a4b = function_c8ab2022(item, 0);
			var_8cd447d8 = function_c8ab2022(item, 1);
			var_c5781c22 = player [[var_5f8125a9]](item, player, item.var_bd027dd9, item.id, var_8cd447d8, var_aec6fa7f, slotid);
			var_c5781c22 = var_c5781c22 + var_d72b1a4b - var_8cd447d8;
			/#
				assert(isint(var_c5781c22) && var_c5781c22 >= 0);
			#/
			if(var_a6762160.itemtype == #"ammo" && var_d72b1a4b === var_c5781c22)
			{
			}
			else if(var_c5781c22 == var_d72b1a4b)
			{
			}
			else if(isdefined(player))
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
			if(var_c5781c22 != var_d72b1a4b)
			{
				var_fceba0ce = {#player:player, #count:var_8cd447d8, #item:item};
				self callback::callback(#"hash_56d1805bfff3e65b", var_fceba0ce);
			}
			return var_c5781c22;
		}
	}
	/#
		assertmsg("" + var_a6762160.name + "");
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
	if(!namespace_ad5a0cd6::can_pick_up(item))
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
			self playsoundtoplayer(#"hash_7527c43b92789608", self);
			return 0;
		}
	}
	self namespace_b6ee49c3::function_7f2040e8();
	if(var_22be503)
	{
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(item, var_26a492bc);
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
		var_77e61fc6 = var_77e61fc6 + var_d72b1a4b - var_8cd447d8;
		if(var_77e61fc6 == 0)
		{
			if(item.var_a6762160.itemtype != #"armor")
			{
				if(isdefined(item) && isdefined(item.var_a6762160))
				{
					function_1a46c8ae(self, undefined, undefined, item.var_a6762160, item.var_a6762160.amount);
				}
			}
			function_7730442c(item);
			return 1;
		}
		if(var_77e61fc6 < var_8cd447d8 && !isentity(item) && item.var_a6762160.itemtype != #"ammo")
		{
			var_be90d3da = item.var_8e092725 === -1;
			~item;
			var_be90d3da = var_be90d3da & (isdefined(item.var_4961f577) ? item.var_4961f577 : 0);
			dropitem = self item_drop::drop_item(item.var_a6762160.weapon, var_77e61fc6, item.amount, item.id, item.origin, item.angles, var_be90d3da, undefined, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname), undefined, undefined, 0);
			if(isdefined(dropitem))
			{
				dropitem.origin = item.origin;
				dropitem.angles = item.angles;
				function_7730442c(item);
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
		return 0;
	}
	if(!isdefined(usetrigger.var_ba85cc6f))
	{
		return 0;
	}
	if(var_4b0875ec && usetrigger.var_ba85cc6f.var_8e092725 === -1)
	{
		return 0;
	}
	origin = self getplayercamerapos();
	if(distance2dsquared(usetrigger.var_ba85cc6f.origin, origin) > 128 * 128)
	{
		return 0;
	}
	if(abs(usetrigger.var_ba85cc6f.origin[2] - origin[2]) > 128)
	{
		return 0;
	}
	return 1;
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
	data = {#hash_d1f97c0f:(isdefined(var_381f3b39) ? var_381f3b39 : 0), #hash_6789038:(isdefined(var_7089b458) ? hash(var_7089b458.name) : 0), #hash_5b8ff5e9:(isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0), #dropped_item:(isdefined(var_a1ca235e) ? hash(var_a1ca235e.name) : 0), #player_xuid:(isdefined(player) ? int(player getxuid(1)) : 0), #game_time:function_f8d53445()};
	/#
		if(isdefined(var_a1ca235e))
		{
			println("" + var_a1ca235e.name + "" + (isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0));
		}
		if(isdefined(var_7089b458))
		{
			println("" + var_7089b458.name + "" + (isdefined(var_381f3b39) ? var_381f3b39 : 0));
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
function function_83ddce0f(item, var_14f7206c)
{
	var_a1ca235e = undefined;
	var_3d1f9df4 = 0;
	var_8acbe1d0 = self namespace_b376ff3f::function_550fcb41(item) || item.var_a6762160.itemtype == #"hash_56d6621e6c4caf07" || item.var_a6762160.itemtype == #"resource" || item.var_a6762160.itemtype == #"ammo" || (item.var_a6762160.itemtype == #"backpack" && !self namespace_b376ff3f::has_backpack());
	var_be90d3da = item.var_8e092725 === -1;
	var_a692c6d6 = (isdefined(item.var_4961f577) ? item.var_4961f577 : 0);
	~var_a692c6d6;
	var_be90d3da = var_be90d3da & var_a692c6d6;
	dropitem = undefined;
	if(!var_8acbe1d0 && self namespace_b376ff3f::function_f62713c3(var_14f7206c))
	{
		var_69944179 = self.inventory.items[var_14f7206c];
		var_a1ca235e = var_69944179.var_a6762160;
		var_3d1f9df4 = var_a1ca235e.amount;
		dropitem = self namespace_b376ff3f::function_418f9eb8(var_69944179.var_bd027dd9, 0, item.origin, undefined, 0);
		if(!isdefined(dropitem))
		{
			return 0;
		}
		waitframe(1);
	}
	if(isdefined(item) && !isentity(item) && isdefined(item.id))
	{
		item = function_b1702735(item.id);
	}
	if(!isdefined(item) || !namespace_ad5a0cd6::can_pick_up(item))
	{
		if(isdefined(dropitem) && isdefined(item) && isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"backpack")
		{
			namespace_b376ff3f::function_ec238da8();
		}
		return 0;
	}
	var_77e61fc6 = function_de2018e3(item, self, var_14f7206c);
	if(var_77e61fc6 == 0)
	{
		if(isdefined(item) && isdefined(item.var_a6762160))
		{
			function_1a46c8ae(self, var_a1ca235e, var_3d1f9df4, item.var_a6762160, item.var_a6762160.amount);
			if(item.var_a6762160.itemtype == #"backpack")
			{
				namespace_b376ff3f::function_ec238da8();
			}
		}
		function_7730442c(item);
	}
	else if(!isentity(item) && item.var_a6762160.itemtype != #"ammo")
	{
		dropitem = self item_drop::drop_item(item.var_a6762160.weapon, item.count, item.amount, item.id, item.origin, item.angles, 0, undefined, (isdefined(item.var_67169c0b) ? item.var_67169c0b : item.targetname), undefined, undefined, 0);
		if(isdefined(dropitem))
		{
			dropitem.origin = item.origin;
			dropitem.angles = item.angles;
			function_7730442c(item);
		}
	}
	return 1;
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
function function_8eee98dd(var_f4cdfe08)
{
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	function_4de3ca98();
	/#
		assert(isdefined(var_f4cdfe08));
	#/
	if(!isdefined(var_f4cdfe08) || !isdefined(var_f4cdfe08.targetname))
	{
		return;
	}
	targetname = (isdefined(var_f4cdfe08.targetname) ? var_f4cdfe08.targetname : var_f4cdfe08.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(!isdefined(item.var_a6762160))
		{
			continue;
		}
		if(distancesquared(item.origin, var_f4cdfe08.origin) > 36)
		{
			continue;
		}
		function_54ca5536(item.id, -1);
		var_5a0fa544 = level flagsys::get(#"hash_38a387462f3a9ad");
		function_bfc28859(3, item.id, var_5a0fa544);
	}
	function_e2a06860(var_f4cdfe08, 0);
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
function function_160294c7(var_f4cdfe08)
{
	level flagsys::wait_till(#"hash_507a4486c4a79f1d");
	function_4de3ca98();
	/#
		assert(isdefined(var_f4cdfe08));
	#/
	if(!isdefined(var_f4cdfe08) || !isdefined(var_f4cdfe08.targetname))
	{
		return;
	}
	targetname = (isdefined(var_f4cdfe08.targetname) ? var_f4cdfe08.targetname : var_f4cdfe08.target);
	var_76c7cb8a = function_91b29d2a(targetname);
	foreach(item in var_76c7cb8a)
	{
		if(distancesquared(item.origin, var_f4cdfe08.origin) > 36)
		{
			continue;
		}
		if(namespace_ad5a0cd6::can_pick_up(item))
		{
			function_7730442c(item);
		}
	}
	var_1d722c21 = [];
	foreach(item in level.var_a4a4012e)
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
			if(namespace_ad5a0cd6::can_pick_up(item))
			{
				var_1d722c21[var_1d722c21.size] = item;
			}
		}
	}
	foreach(item in var_1d722c21)
	{
		if(isdefined(item))
		{
			function_7730442c(item);
		}
	}
	function_e2a06860(var_f4cdfe08, 3);
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
	Name: function_8da29c95
	Namespace: item_world
	Checksum: 0x9117BCD3
	Offset: 0x85A0
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function function_8da29c95()
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
			player thread namespace_b376ff3f::function_56a681fb();
		}
		if(index + 1 % 3 == 0)
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
	reset = isdefined(level flagsys::get(#"hash_38a387462f3a9ad"));
	level flagsys::wait_till(#"hash_51daecff754729dc");
	if(reset != isdefined(level flagsys::get(#"hash_38a387462f3a9ad")))
	{
		return 0;
	}
	return 1;
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
	level flagsys::wait_till(#"hash_51daecff754729dc");
	level flagsys::wait_till(#"hash_38a387462f3a9ad");
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
		var_12bd5f2d = getdvarstring(#"hash_7b2be9e03d9785f3", "");
		tokens = strtok(var_12bd5f2d, "");
		foreach(token in tokens)
		{
			item = function_4ba8fde(token);
			if(isdefined(item))
			{
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(item);
				self function_de2018e3(item, self, var_fa3df96);
			}
		}
	#/
}

