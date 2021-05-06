// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_240ef62ff60b2694;
#using script_5da9076b8e4f6d28;
#using script_68264f587357ea51;
#using script_c1eebdc8cad5d78;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_b376ff3f;

/*
	Name: function_89f2df9
	Namespace: namespace_b376ff3f
	Checksum: 0xB2B95669
	Offset: 0xA68
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_568e72715a5f3355", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: namespace_b376ff3f
	Checksum: 0xB643FBBF
	Offset: 0xAB8
	Size: 0x18C
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	callback::on_localplayer_spawned(&function_1877f414);
	clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 1, 2, "int", &function_38ebb2a1, 0, 1);
	clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 17000, 3, "int", &function_38ebb2a1, 0, 1);
	clientfield::register("clientuimodel", "hudItems.healthItemstackCount", 5000, 8, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.equipmentStackCount", 5000, 8, "int", undefined, 0, 0);
	level thread function_d2f05352();
}

/*
	Name: function_1877f414
	Namespace: namespace_b376ff3f
	Checksum: 0xB87E777
	Offset: 0xC50
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1877f414(localclientnum)
{
	if(self function_da43934d())
	{
		self thread function_3e624606(localclientnum);
		self thread function_ac4df751(localclientnum);
		self thread function_ca87f318(localclientnum);
		self thread function_7f35a045(localclientnum);
		self thread function_d1e6731e(localclientnum);
		self thread function_2ae9881d(localclientnum);
		if(ispc())
		{
			self thread function_9b83c65d(localclientnum);
		}
	}
}

/*
	Name: function_a5c2a6b8
	Namespace: namespace_b376ff3f
	Checksum: 0x34514119
	Offset: 0xD38
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_a5c2a6b8(localclientnum)
{
	return isdefined(level.var_102be329) && level.var_102be329 || !gamepadusedlast(localclientnum);
}

/*
	Name: function_38ebb2a1
	Namespace: namespace_b376ff3f
	Checksum: 0x40E80674
	Offset: 0xD88
	Size: 0x302
	Parameters: 7
	Flags: Linked, Private
*/
private function function_38ebb2a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	if(newval == 2)
	{
		var_8040e225.var_ff9e7e43 = 1;
		if(function_a5c2a6b8(localclientnum))
		{
			var_8040e225.var_f0f7e918 = [];
			if(isdefined(level.var_102be329) && level.var_102be329)
			{
				setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 0);
			}
		}
	}
	else if(newval == 0)
	{
		var_8040e225.var_f0f7e918 = [];
		player = function_27673a7(localclientnum);
		if(isplayer(player) && isalive(player))
		{
			player function_9116bb0e(localclientnum, 1);
		}
	}
	if(isdefined(level.var_102be329) && level.var_102be329 && oldval == 2)
	{
		for(i = 0; i < var_8040e225.inventory.var_c212de25; i++)
		{
			if(var_8040e225.inventory.items[i].var_bd027dd9 != 32767)
			{
				if(var_8040e225.inventory.items[i].availableaction == 1 || var_8040e225.inventory.items[i].availableaction == 4 || var_8040e225.inventory.items[i].availableaction == 2 || var_8040e225.inventory.items[i].availableaction == 6)
				{
					setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 1);
					break;
				}
			}
		}
	}
}

/*
	Name: function_3fe6ef04
	Namespace: namespace_b376ff3f
	Checksum: 0xA88B8819
	Offset: 0x1098
	Size: 0xF8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3fe6ef04(localclientnum)
{
	data = item_world::function_a7e98a1a(localclientnum);
	var_cfa0e915 = [];
	foreach(consumeditem in data.inventory.consumed.items)
	{
		if(isdefined(var_cfa0e915[consumeditem.var_a6762160.name]))
		{
			continue;
		}
		var_cfa0e915[consumeditem.var_a6762160.name] = 1;
	}
	return var_cfa0e915.size;
}

/*
	Name: function_88da0c8e
	Namespace: namespace_b376ff3f
	Checksum: 0x2E31E24B
	Offset: 0x1198
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_88da0c8e(localclientnum)
{
	var_8b39f54e = stats::function_441050ca(localclientnum, #"hash_7bb5510daa652f5e");
	return (isdefined(var_8b39f54e) ? var_8b39f54e : 0) >= 150;
}

/*
	Name: function_99b22bbc
	Namespace: namespace_b376ff3f
	Checksum: 0xCE764531
	Offset: 0x11F0
	Size: 0x5E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_99b22bbc(localclientnum)
{
	if(function_96d4f30e(localclientnum))
	{
		return 0;
	}
	if(isgrappling(localclientnum))
	{
		return 0;
	}
	if(function_d5f07a6e(localclientnum))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_ca87f318
	Namespace: namespace_b376ff3f
	Checksum: 0xC4D434E6
	Offset: 0x1258
	Size: 0x3FE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ca87f318(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("8b67206b631ec6e");
	self endon("8b67206b631ec6e");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_790695cc = "inventory_equip" + localclientnum;
	var_6e7b39bc = "inventory_detach" + localclientnum;
	var_8040e225.var_b9730e2b = gettime();
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_790695cc, var_6e7b39bc);
		if(gettime() - var_8040e225.var_b9730e2b < 300)
		{
			continue;
		}
		if(waitresult._notify === var_790695cc)
		{
			var_bd027dd9 = waitresult.id;
			quickequip = (isdefined(waitresult.var_d9b84a57) ? waitresult.var_d9b84a57 : 0);
			if(quickequip)
			{
				var_ed98a5fe = function_15d578f4(localclientnum, var_bd027dd9);
				if(isdefined(var_ed98a5fe))
				{
					var_a6762160 = var_ed98a5fe.var_a6762160;
				}
				if(isdefined(var_a6762160) && (var_a6762160.itemtype == #"generic" || var_a6762160.itemtype == #"killstreak"))
				{
					data = item_world::function_a7e98a1a(localclientnum);
					name = (isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name);
					for(index = 0; index < data.inventory.items.size && index < 16 + 1; index++)
					{
						var_b619c089 = data.inventory.items[index];
						if(!isdefined(var_b619c089.var_a6762160) || isdefined(var_b619c089.endtime))
						{
							continue;
						}
						if(var_b619c089.var_bd027dd9 == var_bd027dd9)
						{
							continue;
						}
						if(name == (isdefined(var_b619c089.var_a6762160.var_a6762160.parentname) ? var_b619c089.var_a6762160.parentname : var_b619c089.var_a6762160.name))
						{
							var_bd027dd9 = var_b619c089.var_bd027dd9;
							break;
						}
					}
				}
			}
			if(isdefined(waitresult.var_31a0fb28))
			{
				function_97fedb0d(localclientnum, 11, var_bd027dd9, quickequip);
			}
			else
			{
				function_97fedb0d(localclientnum, 4, var_bd027dd9, quickequip);
			}
		}
		else if(waitresult._notify === var_6e7b39bc)
		{
			var_bd027dd9 = waitresult.id;
			function_97fedb0d(localclientnum, 6, var_bd027dd9);
		}
		var_8040e225.var_b9730e2b = gettime();
	}
}

/*
	Name: function_10861362
	Namespace: namespace_b376ff3f
	Checksum: 0x684B268
	Offset: 0x1660
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
private function function_10861362(localclientnum)
{
	vehicle = getplayervehicle(self);
	if(!isdefined(vehicle))
	{
		return 1;
	}
	var_88fa0205 = vehicle getoccupantseat(localclientnum, self);
	if(isdefined(var_88fa0205) && (var_88fa0205 == 0 || var_88fa0205 == 4))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_ee44351a
	Namespace: namespace_b376ff3f
	Checksum: 0xE56082C5
	Offset: 0x1700
	Size: 0x98
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ee44351a(localclientnum, var_b619c089)
{
	weapon = namespace_ad5a0cd6::function_35e06774(var_b619c089.var_a6762160);
	if(!isdefined(weapon))
	{
		return 1;
	}
	if(weapon == getcurrentweapon(localclientnum) || weapon == function_e9fe14ee(localclientnum))
	{
		return function_99b22bbc(localclientnum);
	}
	return 1;
}

/*
	Name: function_e23e5e85
	Namespace: namespace_b376ff3f
	Checksum: 0x33CE7BEC
	Offset: 0x17A0
	Size: 0x1CA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e23e5e85(localclientnum)
{
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	if(!isdefined(var_8040e225) || !isdefined(var_8040e225.inventory) || !isdefined(var_8040e225.inventory.items))
	{
		return 0;
	}
	var_344a1b3d = var_8040e225.inventory.items[11];
	if(!isdefined(var_344a1b3d) || var_344a1b3d.var_bd027dd9 === 32767 || var_344a1b3d.var_a6762160.itemtype !== #"armor")
	{
		return 0;
	}
	var_35b0780f = getuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "predictedClientModel"));
	var_a4d193fa = getuimodel(var_35b0780f, "armor");
	var_15663411 = getuimodel(var_344a1b3d.var_e4130a92, "armorMax");
	if(!isdefined(var_a4d193fa) || !isdefined(var_15663411) || getuimodelvalue(var_a4d193fa) == getuimodelvalue(var_15663411))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e094fd92
	Namespace: namespace_b376ff3f
	Checksum: 0xB0604881
	Offset: 0x1978
	Size: 0xA2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e094fd92(item)
{
	if(!isdefined(item) || !isdefined(item.var_bd027dd9) || item.var_bd027dd9 == 32767 || !isdefined(item.quickequip) || item.quickequip != 1 || !isdefined(item.consumable) || item.consumable != 1)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_f3ef5269
	Namespace: namespace_b376ff3f
	Checksum: 0xA5B4223E
	Offset: 0x1A28
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f3ef5269(localclientnum)
{
	var_b25b2894 = [];
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	for(i = 0; i < 10; i++)
	{
		var_a638d314 = var_8040e225.inventory.items[i];
		if(function_e094fd92(var_a638d314))
		{
			if(!isdefined(var_b25b2894))
			{
				var_b25b2894 = [];
			}
			else if(!isarray(var_b25b2894))
			{
				var_b25b2894 = array(var_b25b2894);
			}
			var_b25b2894[var_b25b2894.size] = var_a638d314;
		}
	}
	return var_b25b2894;
}

/*
	Name: function_e090a831
	Namespace: namespace_b376ff3f
	Checksum: 0xFEB06CDA
	Offset: 0x1B20
	Size: 0xCE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e090a831(localclientnum, var_bd027dd9)
{
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	perkindex = 0;
	for(i = 0; i < 10; i++)
	{
		var_a638d314 = var_8040e225.inventory.items[i];
		if(function_e094fd92(var_a638d314))
		{
			if(var_a638d314.var_bd027dd9 == var_bd027dd9)
			{
				return perkindex;
			}
			perkindex++;
		}
	}
	return -1;
}

/*
	Name: function_535a5a06
	Namespace: namespace_b376ff3f
	Checksum: 0x63AD370C
	Offset: 0x1BF8
	Size: 0x188
	Parameters: 2
	Flags: Linked, Private
*/
private function function_535a5a06(localclientnum, var_6e51c00)
{
	/#
		assert(var_6e51c00 >= -1 && var_6e51c00 <= 1);
	#/
	var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
	var_f99434b1 = createuimodel(var_dcb56aa8, "quickConsumeIndex");
	var_b25b2894 = function_f3ef5269(localclientnum);
	var_be32fa6d = var_b25b2894.size;
	if(var_be32fa6d < 2)
	{
		setuimodelvalue(var_f99434b1, 0);
		return 0;
	}
	quickconsumeindex = getuimodelvalue(var_f99434b1);
	if(!isdefined(quickconsumeindex))
	{
		quickconsumeindex = 0;
	}
	quickconsumeindex = quickconsumeindex + var_6e51c00;
	if(quickconsumeindex >= var_be32fa6d)
	{
		quickconsumeindex = 0;
	}
	else if(quickconsumeindex < 0)
	{
		quickconsumeindex = var_be32fa6d - 1;
	}
	setuimodelvalue(var_f99434b1, quickconsumeindex);
	return quickconsumeindex;
}

/*
	Name: function_91483494
	Namespace: namespace_b376ff3f
	Checksum: 0x8E5C5792
	Offset: 0x1D88
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
private function function_91483494(localclientnum)
{
	return function_1606ff3(localclientnum, 1);
}

/*
	Name: function_9f5d2dc8
	Namespace: namespace_b376ff3f
	Checksum: 0x883921C5
	Offset: 0x1DB8
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9f5d2dc8(localclientnum)
{
	return function_1606ff3(localclientnum, 0);
}

/*
	Name: function_1606ff3
	Namespace: namespace_b376ff3f
	Checksum: 0x456BE26D
	Offset: 0x1DE8
	Size: 0x13C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1606ff3(localclientnum, var_6e51c00)
{
	var_b25b2894 = function_f3ef5269(localclientnum);
	currentindex = function_535a5a06(localclientnum, var_6e51c00);
	var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
	var_98d32f1c = createuimodel(var_dcb56aa8, "quickConsumeNetworkId");
	if(isdefined(var_b25b2894[currentindex]))
	{
		setuimodelvalue(var_98d32f1c, var_b25b2894[currentindex].var_bd027dd9);
	}
	else
	{
		setuimodelvalue(var_98d32f1c, 32767);
	}
	if(var_b25b2894.size > 1)
	{
		playsound(localclientnum, #"hash_4d31bd9927d823c3");
	}
}

/*
	Name: function_22759012
	Namespace: namespace_b376ff3f
	Checksum: 0x37FA1322
	Offset: 0x1F30
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_22759012(localclientnum, var_bd027dd9)
{
	perkindex = function_e090a831(localclientnum, var_bd027dd9);
	if(perkindex > -1)
	{
		var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
		var_f99434b1 = createuimodel(var_dcb56aa8, "quickConsumeIndex");
		setuimodelvalue(var_f99434b1, perkindex);
		var_98d32f1c = createuimodel(var_dcb56aa8, "quickConsumeNetworkId");
		setuimodelvalue(var_98d32f1c, var_bd027dd9);
	}
	else
	{
		function_9f5d2dc8(localclientnum);
	}
}

/*
	Name: function_1470ccfe
	Namespace: namespace_b376ff3f
	Checksum: 0x733A5A4A
	Offset: 0x2048
	Size: 0x104
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1470ccfe(localclientnum, item)
{
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	for(i = 0; i < 10; i++)
	{
		var_a638d314 = var_8040e225.inventory.items[i];
		if(var_a638d314.var_bd027dd9 == 32767 || !namespace_a0d533d1::function_73593286(item.var_a6762160, var_a638d314.var_a6762160) || !isdefined(var_a638d314.availableaction) || item.availableaction != var_a638d314.availableaction)
		{
			continue;
		}
		return var_a638d314.var_bd027dd9;
	}
	return undefined;
}

/*
	Name: function_9b83c65d
	Namespace: namespace_b376ff3f
	Checksum: 0x40A4C33C
	Offset: 0x2158
	Size: 0xCAE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9b83c65d(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("7448ede5a4a225c6");
	self endon("7448ede5a4a225c6");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_ca4fc719 = "inventory_consume" + localclientnum;
	var_e2d1f454 = "inventory_armor_repair_pressed" + localclientnum;
	var_3731e165 = "inventory_armor_repair_released" + localclientnum;
	var_6a10d173 = "inventory_quick_consume" + localclientnum;
	var_ce5c0b10 = "inventory_cycle_quick_consumable" + localclientnum;
	var_17bdd1c3 = "inventory_equip_quick_consumable" + localclientnum;
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_ca4fc719, var_e2d1f454, var_3731e165, var_6a10d173, var_ce5c0b10, var_17bdd1c3);
		if(waitresult._notify === var_ca4fc719)
		{
			if(!function_10861362(localclientnum))
			{
				self playsound(localclientnum, #"hash_7527c43b92789608");
				continue;
			}
			var_b619c089 = function_15d578f4(localclientnum, waitresult.id);
			function_22759012(localclientnum, var_b619c089.var_bd027dd9);
		}
		else if(waitresult._notify === var_17bdd1c3)
		{
			var_b619c089 = function_15d578f4(localclientnum, waitresult.id);
			var_bd027dd9 = function_1470ccfe(localclientnum, var_b619c089);
			function_22759012(localclientnum, (isdefined(var_bd027dd9) ? var_b619c089.var_bd027dd9 : var_bd027dd9));
			continue;
		}
		else if(waitresult._notify === var_6a10d173)
		{
			currentindex = function_535a5a06(localclientnum, 0);
			var_b25b2894 = function_f3ef5269(localclientnum);
			if(isdefined(var_b25b2894[currentindex]))
			{
				var_b619c089 = var_b25b2894[currentindex];
			}
			else
			{
				continue;
			}
		}
		else if(waitresult._notify === var_ce5c0b10)
		{
			function_91483494(localclientnum);
			continue;
		}
		else
		{
			var_b619c089 = var_8040e225.inventory.items[16];
			if(!isdefined(var_b619c089) || var_b619c089.var_bd027dd9 === 32767 || var_b619c089.var_a6762160.itemtype !== #"hash_56d6621e6c4caf07")
			{
				if(waitresult._notify === var_e2d1f454)
				{
					var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
					var_3ea10284 = createuimodel(var_dcb56aa8, "armorShardNotAvailable");
					function_9a227103(var_3ea10284);
				}
				continue;
			}
			var_b3d8c077 = function_ab88dbd2(localclientnum, #"hash_da23f5f536ee5f2");
			var_a3162739 = isdefined(var_8040e225.inventory.var_f3518190) && var_b619c089 == var_8040e225.inventory.var_f3518190.item;
			if(waitresult._notify === var_e2d1f454)
			{
				if(!function_e23e5e85(localclientnum) || var_b619c089.count == 0 || !function_10861362(localclientnum) && (isdefined(var_b3d8c077) && !var_b3d8c077 || (isdefined(var_b3d8c077) && var_b3d8c077 && !var_a3162739)))
				{
					self playsound(localclientnum, #"hash_7527c43b92789608");
					var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
					var_3ea10284 = createuimodel(var_dcb56aa8, "armorShardNotAvailable");
					function_9a227103(var_3ea10284);
					continue;
				}
			}
			else if(isdefined(var_b3d8c077) && var_b3d8c077 || !var_a3162739)
			{
				continue;
			}
		}
		if(!isdefined(var_b619c089.var_a6762160.casttime) || var_b619c089.var_a6762160.casttime <= 0)
		{
			function_97fedb0d(localclientnum, 4, var_b619c089.var_bd027dd9);
			continue;
		}
		var_eaae8ced = 0;
		if(isdefined(var_8040e225.inventory.consumed.items) && isarray(var_8040e225.inventory.consumed.items))
		{
			foreach(consumeditem in var_8040e225.inventory.consumed.items)
			{
				if(isdefined(consumeditem.var_a6762160.var_7e21e375) && isarray(consumeditem.var_a6762160.var_7e21e375))
				{
					foreach(talent in consumeditem.var_a6762160.var_7e21e375)
					{
						if(talent.talent == #"hash_20c8c24a2156176c")
						{
							var_eaae8ced = 1;
							break;
						}
					}
				}
				if(var_eaae8ced)
				{
					break;
				}
			}
		}
		if(isdefined(var_8040e225.inventory.var_f3518190))
		{
			if(var_b619c089 != var_8040e225.inventory.var_f3518190.item)
			{
				setuimodelvalue(createuimodel(var_8040e225.inventory.var_f3518190.item.var_e4130a92, "castTimeFraction"), 0, 0);
				playsound(localclientnum, #"hash_4d31bd9927d823c3");
				var_f3518190 = spawnstruct();
				var_f3518190.item = var_b619c089;
				var_f3518190.caststart = gettime();
				var_f3518190.castend = var_f3518190.caststart + int((isdefined((var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime)) ? (var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime) : 0) * 1000);
				var_8040e225.inventory.var_f3518190 = var_f3518190;
				function_de74158f(localclientnum, var_f3518190.item.var_bd027dd9);
				var_8040e225.inventory.var_4d4ec560 = var_b619c089.var_bd027dd9;
			}
			else
			{
				setuimodelvalue(createuimodel(var_8040e225.inventory.var_f3518190.item.var_e4130a92, "castTimeFraction"), 0, 0);
				setuimodelvalue(var_8040e225.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
				var_8040e225.inventory.var_f3518190 = undefined;
				var_8040e225.inventory.var_4d4ec560 = undefined;
			}
		}
		else if(!isdefined(var_8040e225.inventory.var_4d4ec560) || var_8040e225.inventory.var_4d4ec560 != var_b619c089.var_bd027dd9)
		{
			playsound(localclientnum, #"hash_4d31bd9927d823c3");
			var_f3518190 = spawnstruct();
			var_f3518190.item = var_b619c089;
			var_f3518190.caststart = gettime();
			var_f3518190.castend = var_f3518190.caststart + int((isdefined((var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime)) ? (var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime) : 0) * 1000);
			var_8040e225.inventory.var_f3518190 = var_f3518190;
			function_de74158f(localclientnum, var_f3518190.item.var_bd027dd9);
			var_8040e225.inventory.var_4d4ec560 = var_b619c089.var_bd027dd9;
		}
	}
}

/*
	Name: function_ac4df751
	Namespace: namespace_b376ff3f
	Checksum: 0x8B9F6C1D
	Offset: 0x2E10
	Size: 0x4A8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ac4df751(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("697b03f7ded5069f");
	self endon("697b03f7ded5069f");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_5054e2f7 = "inventory_drop" + localclientnum;
	var_ffec0c46 = "inventory_drop_current_weapon" + localclientnum;
	var_46a7a0e3 = "inventory_drop_current_weapon_and_detach" + localclientnum;
	var_fcd005cc = "inventory_drop_weapon_in_slot" + localclientnum;
	var_3d759450 = "inventory_drop_weapon_in_slot_and_detach" + localclientnum;
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_5054e2f7, var_ffec0c46, var_46a7a0e3, var_fcd005cc, var_3d759450);
		if(waitresult._notify === var_5054e2f7)
		{
			var_bd027dd9 = waitresult.id;
			count = waitresult.var_d9b84a57;
			var_d8138db2 = item_world::function_28b42f1c(localclientnum, var_bd027dd9);
			if(var_d8138db2 != 32767)
			{
				if(function_6d9d9cd7(waitresult.selectedindex))
				{
					var_b619c089 = var_8040e225.inventory.items[waitresult.selectedindex];
					if(isdefined(var_b619c089) && !function_ee44351a(localclientnum, var_b619c089))
					{
						continue;
					}
				}
				if(ispc())
				{
					if(isdefined(var_8040e225.inventory.var_f3518190) && var_8040e225.inventory.var_f3518190.item.id == var_d8138db2)
					{
						var_8040e225.inventory.var_f3518190 = undefined;
						var_8040e225.inventory.var_4d4ec560 = undefined;
						setuimodelvalue(var_8040e225.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
					}
				}
				function_97fedb0d(localclientnum, 5, var_bd027dd9, count);
			}
		}
		else if(waitresult._notify === var_ffec0c46 || waitresult._notify === var_fcd005cc)
		{
			var_4838b749 = (isdefined(waitresult.slotid) ? array(16 + 1, 16 + 1 + 6 + 1)[waitresult.slotid] : function_d768ea30(localclientnum));
			if(isdefined(var_4838b749))
			{
				var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, var_4838b749);
				function_97fedb0d(localclientnum, 5, var_bd027dd9);
			}
		}
		else if(waitresult._notify === var_46a7a0e3 || waitresult._notify === var_3d759450)
		{
			var_4838b749 = (isdefined(waitresult.slotid) ? array(16 + 1, 16 + 1 + 6 + 1)[waitresult.slotid] : function_d768ea30(localclientnum));
			if(isdefined(var_4838b749))
			{
				var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, var_4838b749);
				function_97fedb0d(localclientnum, 8, var_bd027dd9);
			}
		}
	}
}

/*
	Name: function_8edef5cc
	Namespace: namespace_b376ff3f
	Checksum: 0xC02400A8
	Offset: 0x32C0
	Size: 0x1EA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8edef5cc(localclientnum, var_b619c089)
{
	data = item_world::function_a7e98a1a(localclientnum);
	slot = function_daf3ebda(localclientnum, var_b619c089.var_a6762160);
	if(!isdefined(slot))
	{
		slot = self function_78ed4455(localclientnum, var_b619c089.var_a6762160);
	}
	if(isdefined(slot))
	{
		if(var_b619c089.var_a6762160.type != #"attachment")
		{
			item = data.inventory.items[slot];
			setuimodelvalue(createuimodel(item.var_e4130a92, "focusTarget"), 1);
		}
	}
	else if(function_ad4c6116(localclientnum, var_b619c089.var_a6762160))
	{
		for(i = 0; i < data.inventory.var_c212de25; i++)
		{
			if(data.inventory.items[i].var_bd027dd9 === 32767)
			{
				setuimodelvalue(createuimodel(data.inventory.items[i].var_e4130a92, "focusTarget"), 1);
				break;
			}
		}
	}
}

/*
	Name: function_96ce9058
	Namespace: namespace_b376ff3f
	Checksum: 0x50C80B4F
	Offset: 0x34B8
	Size: 0x19A
	Parameters: 4
	Flags: Linked, Private
*/
private function function_96ce9058(localclientnum, var_6c2b2289, var_b619c089, item)
{
	level endon(var_6c2b2289);
	self notify("7357e9cab2fc6298");
	self endon("7357e9cab2fc6298");
	if(isdefined(item.var_a6762160.unlockableitemref))
	{
		var_1ce96a13 = array(0, 0, 0, 0, 0);
		while(true)
		{
			waitframe(1);
			for(i = 0; i < 5; i++)
			{
				if(isdefined(item.var_a6762160.objectives[i]) && isdefined(item.var_a6762160.objectives[i].var_7e835304))
				{
					value = stats::function_441050ca(localclientnum, item.var_a6762160.objectives[i].var_7e835304);
					if(isdefined(value) && value != var_1ce96a13[i])
					{
						var_1ce96a13[i] = value;
						function_39b663b7(localclientnum, var_b619c089, item);
					}
				}
			}
		}
	}
}

/*
	Name: function_7f35a045
	Namespace: namespace_b376ff3f
	Checksum: 0xEC4EECA3
	Offset: 0x3660
	Size: 0x994
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7f35a045(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("70f223fcee367f6f");
	self endon("70f223fcee367f6f");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_6c2b2289 = "inventory_item_focus" + localclientnum;
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_6c2b2289);
		data = item_world::function_a7e98a1a(localclientnum);
		function_534dcb9c(localclientnum);
		if(isdefined(level.var_6d21daaf[localclientnum]))
		{
			setuimodelvalue(level.var_6d21daaf[localclientnum], 0);
		}
		foreach(var_4838b749 in array(16 + 1, 16 + 1 + 6 + 1))
		{
			foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
			{
				var_f9f8c0b5 = var_4838b749 + var_259f58f3;
				item = data.inventory.items[var_f9f8c0b5];
				setuimodelvalue(createuimodel(item.var_e4130a92, "focusTarget"), 0);
				setuimodelvalue(createuimodel(item.var_e4130a92, "notAvailable"), 0);
			}
		}
		setuimodelvalue(createuimodel(data.inventory.items[11].var_e4130a92, "focusTarget"), 0);
		setuimodelvalue(createuimodel(data.inventory.items[13].var_e4130a92, "focusTarget"), 0);
		setuimodelvalue(createuimodel(data.inventory.items[12].var_e4130a92, "focusTarget"), 0);
		setuimodelvalue(createuimodel(data.inventory.items[10].var_e4130a92, "focusTarget"), 0);
		for(i = 0; i < 10; i++)
		{
			setuimodelvalue(createuimodel(data.inventory.items[i].var_e4130a92, "focusTarget"), 0);
		}
		if(waitresult._notify !== var_6c2b2289)
		{
			continue;
		}
		var_bd027dd9 = waitresult.id;
		data.inventory.var_9d51958c = var_bd027dd9;
		if(var_bd027dd9 === 32767)
		{
			continue;
		}
		var_b619c089 = function_15d578f4(localclientnum, var_bd027dd9);
		if(isdefined(var_b619c089) && 32767 != var_b619c089.id)
		{
			item = function_b1702735(var_b619c089.id);
			if(isdefined(item) && isdefined(item.var_a6762160))
			{
				self thread function_96ce9058(localclientnum, var_6c2b2289, var_b619c089, item);
			}
		}
		if(!isdefined(var_b619c089) && function_a5c2a6b8(localclientnum) && self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2)
		{
			arrayremovevalue(data.var_f0f7e918, undefined, 0);
			for(index = 0; index < data.var_f0f7e918.size; index++)
			{
				var_81bb13f5 = data.var_f0f7e918[index];
				if(var_81bb13f5.var_bd027dd9 === var_bd027dd9)
				{
					if(var_81bb13f5.var_a6762160.itemtype != #"ammo" && var_81bb13f5.var_a6762160.itemtype != #"weapon")
					{
						var_b619c089 = var_81bb13f5;
						function_8edef5cc(localclientnum, var_b619c089);
					}
					break;
				}
			}
		}
		if(!isdefined(var_b619c089) || !isdefined(var_b619c089.var_a6762160) || var_b619c089.var_a6762160.itemtype !== #"attachment")
		{
			continue;
		}
		var_a4250c2b = function_d768ea30(localclientnum);
		foreach(var_4838b749 in array(16 + 1, 16 + 1 + 6 + 1))
		{
			var_64d58696 = data.inventory.items[var_4838b749];
			if(var_64d58696.id === 32767)
			{
				continue;
			}
			var_ceefbd10 = namespace_a0d533d1::function_837f4a57(var_b619c089.var_a6762160);
			var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
			attachmentname = namespace_a0d533d1::function_2ced1d34(var_64d58696, var_b619c089.var_a6762160);
			var_86364446 = data.inventory.items[var_f9f8c0b5];
			if(isdefined(attachmentname))
			{
				if(var_bd027dd9 != var_86364446.var_bd027dd9)
				{
					setuimodelvalue(createuimodel(var_86364446.var_e4130a92, "focusTarget"), 1);
				}
				var_fdc9fcff = (var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1);
				if(var_fdc9fcff == var_4838b749)
				{
					setuimodelvalue(level.var_6d21daaf[localclientnum], 1);
				}
				continue;
			}
			setuimodelvalue(createuimodel(var_86364446.var_e4130a92, "notAvailable"), 1);
		}
	}
}

/*
	Name: function_2ae9881d
	Namespace: namespace_b376ff3f
	Checksum: 0xD06BE2F7
	Offset: 0x4000
	Size: 0x166
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2ae9881d(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("62a25a832b1d0cff");
	self endon("62a25a832b1d0cff");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_f3efb06b = "cycle_health" + localclientnum;
	var_db83305d = "cycle_equipment" + localclientnum;
	var_8040e225.var_cb55ac3c = gettime();
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_f3efb06b, var_db83305d);
		if(gettime() - var_8040e225.var_cb55ac3c < 200)
		{
			continue;
		}
		if(waitresult._notify === var_f3efb06b)
		{
			function_97fedb0d(localclientnum, 10);
		}
		else if(waitresult._notify === var_db83305d)
		{
			function_97fedb0d(localclientnum, 9);
		}
		var_8040e225.var_cb55ac3c = gettime();
	}
}

/*
	Name: function_d1e6731e
	Namespace: namespace_b376ff3f
	Checksum: 0x1F403EF3
	Offset: 0x4170
	Size: 0x3B8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d1e6731e(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("1eaaee589e299bd6");
	self endon("1eaaee589e299bd6");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_bd0cdac3 = "attachment_pickup";
	var_b784f644 = var_bd0cdac3 + localclientnum;
	while(true)
	{
		util::waittill_any_ents(self, var_bd0cdac3, level, var_b784f644);
		var_a638d314 = self.var_9b882d22;
		if(!isdefined(var_a638d314) || !isdefined(var_a638d314.var_a6762160))
		{
			continue;
		}
		var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
		if(self.var_9b882d22.var_8e092725 === -1 && !var_512ddf16)
		{
			continue;
		}
		if(var_512ddf16 && self.var_54d9f4a6)
		{
			continue;
		}
		origin = getlocalclienteyepos(localclientnum);
		if(distance2dsquared(origin, var_a638d314.origin) > 128 * 128 || abs(origin[2] - var_a638d314.origin[2]) > 128)
		{
			continue;
		}
		if(!isdefined(var_a638d314.var_a6762160))
		{
			continue;
		}
		var_fc7876fd = 0;
		if(!function_ad4c6116(localclientnum, var_a638d314.var_a6762160))
		{
			swap = 0;
			data = item_world::function_a7e98a1a(localclientnum);
			switch(var_a638d314.var_a6762160.itemtype)
			{
				case "equipment":
				{
					swap = 1;
					break;
				}
				case "health":
				{
					swap = 1;
					break;
				}
				default:
				{
					break;
				}
			}
			if(!swap)
			{
				continue;
			}
			function_97fedb0d(localclientnum, 7, var_a638d314.var_bd027dd9, 2);
			continue;
		}
		else
		{
			switch(var_a638d314.var_a6762160.itemtype)
			{
				case "equipment":
				{
					var_fc7876fd = 1;
				}
				var_fc7876fd = 1;
				var_fc7876fd = 1;
			}
		}
		function_97fedb0d(localclientnum, 7, var_a638d314.var_bd027dd9, var_fc7876fd);
	}
}

/*
	Name: function_6d9d9cd7
	Namespace: namespace_b376ff3f
	Checksum: 0x31FDB695
	Offset: 0x4530
	Size: 0xE2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6d9d9cd7(slotid)
{
	/#
		assert(isint(slotid));
	#/
	foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1))
	{
		if(slot == slotid)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_d2f05352
	Namespace: namespace_b376ff3f
	Checksum: 0xA5100D8B
	Offset: 0x4620
	Size: 0x7B8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d2f05352()
{
	level endon(#"shutdown");
	waitframe(1);
	while(true)
	{
		players = getlocalplayers();
		time = gettime();
		foreach(player in players)
		{
			if(!isalive(player))
			{
				continue;
			}
			localclientnum = player getlocalclientnumber();
			if(!isdefined(localclientnum))
			{
				continue;
			}
			data = item_world::function_a7e98a1a(localclientnum);
			if(!isdefined(data) || !isdefined(data.inventory) || !isdefined(data.inventory.items))
			{
				continue;
			}
			consumed = data.inventory.consumed;
			var_3ef517e = data.inventory.consumed.items;
			var_95dcc077 = 0;
			i = 0;
			while(i < var_3ef517e.size)
			{
				item = var_3ef517e[i];
				if(item.endtime <= time)
				{
					var_95dcc077 = 1;
					arrayremoveindex(var_3ef517e, i);
					playsound(localclientnum, #"hash_4c7a6e162e2f26a0");
				}
				else
				{
					i++;
				}
			}
			var_cfa0e915 = [];
			for(i = 0; i < var_3ef517e.size; i++)
			{
				item = var_3ef517e[i];
				if(isdefined(var_cfa0e915[item.var_a6762160.name]))
				{
					continue;
				}
				var_cfa0e915[item.var_a6762160.name] = 1;
				duration = item.endtime - item.starttime;
				timeremaining = item.endtime - time;
				if(var_95dcc077)
				{
					item.var_e4130a92 = createuimodel(consumed.uimodel, "item" + var_cfa0e915.size - 1);
					function_1a99656a(localclientnum, item, item.var_bd027dd9, item.id, 0, 0, 0, 0);
				}
				frac = 1;
				if(duration > 0)
				{
					frac = 1 - timeremaining / duration;
				}
				setuimodelvalue(createuimodel(item.var_e4130a92, "endStartFraction"), frac, 0);
			}
			if(ispc())
			{
				var_f3518190 = data.inventory.var_f3518190;
				if(isdefined(var_f3518190) && var_f3518190.item.id != 32767)
				{
					duration = var_f3518190.castend - var_f3518190.caststart;
					timeremaining = var_f3518190.castend - time;
					if(timeremaining <= 0)
					{
						function_97fedb0d(localclientnum, 4, var_f3518190.item.var_bd027dd9);
						setuimodelvalue(createuimodel(var_f3518190.item.var_e4130a92, "castTimeFraction"), 0, 0);
						data.inventory.var_f3518190 = undefined;
						if(var_f3518190.item.var_bd027dd9 == data.inventory.items[16].var_bd027dd9)
						{
							var_95dcc077 = 1;
							if(!function_e23e5e85(localclientnum))
							{
								data.inventory.var_4d4ec560 = undefined;
							}
						}
					}
					else
					{
						setuimodelvalue(createuimodel(var_f3518190.item.var_e4130a92, "castTimeFraction"), 1 - timeremaining / duration, 0);
						uimodel = getuimodel(data.inventory.consumed.uimodel, "item" + function_3fe6ef04(localclientnum));
						if(isdefined(uimodel))
						{
							setuimodelvalue(createuimodel(uimodel, "castTimeFraction"), 1 - timeremaining / duration, 0);
						}
					}
				}
			}
			for(index = 0; index < 10; index++)
			{
				item = data.inventory.items[index];
				if(!isdefined(item.endtime))
				{
					continue;
				}
				duration = item.endtime - item.starttime;
				timeremaining = item.endtime - time;
				frac = 1;
				if(duration > 0)
				{
					frac = 1 - timeremaining / duration;
				}
				setuimodelvalue(createuimodel(item.var_e4130a92, "endStartFraction"), frac, 0);
			}
			if(var_95dcc077)
			{
				setuimodelvalue(consumed.var_a25538fb, var_cfa0e915.size);
				function_9f5d2dc8(localclientnum);
			}
		}
		players = undefined;
		waitframe(1);
	}
}

/*
	Name: function_fe189514
	Namespace: namespace_b376ff3f
	Checksum: 0x3B091694
	Offset: 0x4DE0
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
private function function_fe189514(var_a6762160)
{
	if(isdefined(var_a6762160) && isdefined(var_a6762160.weapon))
	{
		return (isdefined(var_a6762160.weapon.weapon.name) ? var_a6762160.weapon.name : #"");
	}
	return #"";
}

/*
	Name: function_1a99656a
	Namespace: namespace_b376ff3f
	Checksum: 0xC9B9FA8F
	Offset: 0x4E60
	Size: 0x1FCC
	Parameters: 10
	Flags: Linked, Private
*/
private function function_1a99656a(localclientnum, var_b619c089, var_bd027dd9, var_d8138db2, count, totalcount, availableaction, var_e35261f6 = 1, var_189fcf49 = 0, var_1204dfe9 = 1)
{
	data = undefined;
	if(var_d8138db2 == 32767 && isdefined(var_b619c089.var_bd027dd9) && var_b619c089.var_bd027dd9 != 32767)
	{
		data = level.var_d342a3fd[localclientnum];
	}
	else if(var_d8138db2 != 32767 && var_b619c089.var_bd027dd9 === 32767)
	{
		data = level.var_d342a3fd[localclientnum];
	}
	else if(isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype === #"hash_56d6621e6c4caf07")
	{
		data = level.var_d342a3fd[localclientnum];
	}
	var_dbce1e30 = 0;
	if(var_b619c089.id === var_d8138db2 && isdefined(var_b619c089.count) && var_b619c089.count > count)
	{
		var_dbce1e30 = 1;
		if(isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype === #"hash_56d6621e6c4caf07")
		{
			var_8040e225 = item_world::function_a7e98a1a(localclientnum);
			if(isdefined(var_8040e225) && isdefined(var_8040e225.inventory) && var_bd027dd9 === var_8040e225.inventory.var_4d4ec560)
			{
				var_8040e225.inventory.var_4d4ec560 = undefined;
			}
		}
	}
	player = function_27673a7(localclientnum);
	var_1bd87f37 = 1;
	if(isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype == #"hash_56d6621e6c4caf07" && var_bd027dd9 == 32767 && var_1204dfe9 == 0)
	{
		var_1bd87f37 = 0;
	}
	var_d5042302 = isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype === #"attachment";
	var_1c54cff7 = var_b619c089.var_a6762160;
	if(var_1bd87f37)
	{
		var_b619c089.id = var_d8138db2;
		var_b619c089.var_bd027dd9 = var_bd027dd9;
	}
	else
	{
		var_d8138db2 = var_b619c089.id;
		var_bd027dd9 = var_b619c089.var_bd027dd9;
	}
	var_b619c089.count = count;
	var_b619c089.var_a6762160 = (32767 == var_d8138db2 ? undefined : function_b1702735(var_d8138db2).var_a6762160);
	var_b619c089.availableaction = availableaction;
	var_b619c089.consumable = (isdefined(var_b619c089.var_a6762160) ? var_b619c089.var_a6762160.consumable : undefined);
	var_b619c089.quickequip = 0;
	if(var_e35261f6)
	{
		var_b619c089.starttime = undefined;
		var_b619c089.endtime = undefined;
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "endStartFraction"), 0, 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "castTimeFraction"), 0, 0);
	}
	setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "id"), var_b619c089.var_bd027dd9);
	setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "realId"), var_b619c089.id);
	setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "stackCount"), count);
	if(isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "totalCount"), count);
	}
	else
	{
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "totalCount"), totalcount);
	}
	item = undefined;
	if(var_d8138db2 != 32767)
	{
		item = function_b1702735(var_d8138db2);
	}
	if(var_d8138db2 == 32767 || !isdefined(item.var_a6762160))
	{
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "name"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "icon"), #"blacktransparent");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "rarity"), "None");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "availableAction"), availableaction);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "stowedAvailableAction"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "canTransferAttachment"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "consumable"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "assetName"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "description"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "castTime"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "type"), "");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "equipped"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "endStartFraction"), 0, 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "castTimeFraction"), 0, 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "notAvailable"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "notAccessible"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "focusTarget"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quickEquip"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "cycle"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "armorMax"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "hasAttachments"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "supportsAttachments"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "unlockableItemRef"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quote"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "rewardName"), #"");
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "ammoType"), #"");
		function_442857e2(localclientnum, var_1c54cff7);
	}
	else
	{
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "name"), item_world::get_item_name(item.var_a6762160));
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "icon"), (isdefined(item.var_a6762160.icon) ? item.var_a6762160.icon : #"blacktransparent"));
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "rarity"), (isdefined(item.var_a6762160.rarity) ? item.var_a6762160.rarity : "None"));
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "assetName"), function_fe189514(item.var_a6762160));
		armormax = 0;
		if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"armor")
		{
			armormax = (isdefined(item.var_a6762160.var_a6762160.amount) ? item.var_a6762160.amount : 0);
		}
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "armorMax"), armormax);
		description = (isdefined(item.var_a6762160.var_a6762160.description) ? item.var_a6762160.description : #"");
		if(getdvar(#"hash_4a5fd7d94cfc9dfd", 0) == 1)
		{
			if(isdefined(item.var_a6762160.unlockableitemref))
			{
				if(isdefined(item.var_a6762160.var_a51bc1f7))
				{
					description = (isdefined(item.var_a6762160.var_a6762160.var_a51bc1f7) ? item.var_a6762160.var_a51bc1f7 : #"");
				}
			}
		}
		if(description == #"" && isdefined(item.var_a6762160.weapon))
		{
			itemindex = getitemindexfromref(item.var_a6762160.weapon.name);
			var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);
			if(isdefined(var_97dcd0a5) && isdefined(var_97dcd0a5.description))
			{
				description = var_97dcd0a5.description;
			}
		}
		if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"resource")
		{
			if(function_88da0c8e(localclientnum))
			{
				setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "notAccessible"), 1);
				description = (isdefined(item.var_a6762160.var_a6762160.var_3b8219fd) ? item.var_a6762160.var_3b8219fd : description);
			}
		}
		if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"weapon")
		{
			supportsattachments = namespace_a0d533d1::function_4bd83c04(item);
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "supportsAttachments"), supportsattachments);
			var_754fe8c5 = function_e36b5f2c(item.var_a6762160.weapon);
			if(isdefined(level.var_c53d118f) && isdefined(level.var_c53d118f[var_754fe8c5]))
			{
				setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "ammoType"), level.var_c53d118f[var_754fe8c5]);
			}
			else
			{
				setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "ammoType"), #"");
			}
		}
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "description"), description);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "castTime"), (isdefined(item.var_a6762160.casttime) ? item.var_a6762160.casttime : 0));
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "type"), item.var_a6762160.itemtype);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "equipped"), isdefined(var_b619c089.endtime));
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "availableAction"), availableaction);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "stowedAvailableAction"), 0);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "consumable"), 0);
		if(isdefined(item.var_a6762160.unlockableitemref))
		{
			function_39b663b7(localclientnum, var_b619c089, item);
		}
		else
		{
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "unlockableItemRef"), #"");
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quote"), #"");
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "rewardName"), #"");
		}
		if(!var_189fcf49)
		{
			function_442857e2(localclientnum, (isdefined(var_b619c089.var_a6762160) ? var_b619c089.var_a6762160 : var_1c54cff7));
		}
		if(count != 0 && !var_dbce1e30)
		{
			function_8ffee46f(localclientnum, var_b619c089);
		}
	}
	if(isdefined(data))
	{
		canusequickinventory = 0;
		filledslots = 0;
		for(i = 0; i < data.inventory.var_c212de25; i++)
		{
			if(data.inventory.items[i].var_bd027dd9 != 32767)
			{
				if(data.inventory.items[i].availableaction == 1 || data.inventory.items[i].availableaction == 4 || data.inventory.items[i].availableaction == 2 || data.inventory.items[i].availableaction == 6)
				{
					if(isdefined(data.inventory.items[i].quickequip) && data.inventory.items[i].quickequip)
					{
						canusequickinventory = canusequickinventory | 1;
					}
				}
				filledslots++;
			}
		}
		shardcount = 0;
		if(data.inventory.items[16].var_bd027dd9 != 32767 && data.inventory.items[16].count > 0)
		{
			filledslots++;
			canusequickinventory = canusequickinventory | 1;
		}
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.filledSlots"), filledslots);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), canusequickinventory);
		var_a966c73b = data.inventory.items[15];
		var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
		if(var_a966c73b.var_bd027dd9 != 32767)
		{
			setuimodelvalue(createuimodel(var_dcb56aa8, "resourceCount"), 2);
		}
		else
		{
			setuimodelvalue(createuimodel(var_dcb56aa8, "resourceCount"), 1);
		}
		if(var_d8138db2 !== 32767 && isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype === #"weapon")
		{
			foreach(var_4838b749 in array(16 + 1, 16 + 1 + 6 + 1))
			{
				if(data.inventory.items[var_4838b749].var_bd027dd9 === var_bd027dd9)
				{
					var_2a311ae = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");
					foreach(index, var_259f58f3 in array(1, 2, 3, 4, 5, 6))
					{
						slot = var_2a311ae[index];
						var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
						var_84704ed7 = data.inventory.items[var_f9f8c0b5];
						if(!isdefined(var_b619c089.var_a6762160.(slot)))
						{
							setuimodelvalue(createuimodel(var_84704ed7.var_e4130a92, "disabled"), 1);
							continue;
						}
						setuimodelvalue(createuimodel(var_84704ed7.var_e4130a92, "disabled"), 0);
					}
					break;
				}
			}
		}
		if(var_d8138db2 !== 32767 && isdefined(var_b619c089.var_a6762160) && var_b619c089.var_a6762160.itemtype === #"attachment")
		{
			var_f9f8c0b5 = namespace_ad5a0cd6::function_808be9a3(player, var_b619c089.var_bd027dd9);
			var_2cf6fb05 = undefined;
			foreach(var_4838b749 in array(16 + 1, 16 + 1 + 6 + 1))
			{
				if(namespace_a0d533d1::function_398b9770(var_4838b749, var_f9f8c0b5))
				{
					var_2cf6fb05 = var_4838b749;
					break;
				}
			}
			if(isdefined(var_2cf6fb05))
			{
				function_cb7cfe5b(localclientnum, var_2cf6fb05, var_b619c089);
				hasattachments = function_850588f4(localclientnum, var_2cf6fb05);
				var_508262d4 = data.inventory.items[var_2cf6fb05];
				if(hasattachments)
				{
					setuimodelvalue(createuimodel(var_508262d4.var_e4130a92, "hasAttachments"), 1);
				}
				else
				{
					setuimodelvalue(createuimodel(var_508262d4.var_e4130a92, "hasAttachments"), 0);
				}
			}
			else
			{
				var_a4250c2b = player function_d768ea30(localclientnum);
				function_cb7cfe5b(localclientnum, var_a4250c2b, var_b619c089);
			}
			function_ce628f27(localclientnum);
		}
		else if(var_d5042302)
		{
			var_a4250c2b = player function_d768ea30(localclientnum);
			hasattachments = function_850588f4(localclientnum, var_a4250c2b);
			if(isdefined(var_a4250c2b))
			{
				var_508262d4 = data.inventory.items[var_a4250c2b];
				if(hasattachments)
				{
					setuimodelvalue(createuimodel(var_508262d4.var_e4130a92, "hasAttachments"), 1);
				}
				else
				{
					setuimodelvalue(createuimodel(var_508262d4.var_e4130a92, "hasAttachments"), 0);
				}
			}
			function_deddbdf0(localclientnum, var_a4250c2b);
			function_ce628f27(localclientnum);
		}
	}
}

/*
	Name: function_8bb02a48
	Namespace: namespace_b376ff3f
	Checksum: 0x571BACD2
	Offset: 0x6E38
	Size: 0x4BE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8bb02a48(localclientnum)
{
	data = item_world::function_a7e98a1a(localclientnum);
	if(!isdefined(data))
	{
		return;
	}
	var_b8f1b496 = data.inventory.items[12];
	var_7007b688 = [];
	if(isdefined(var_b8f1b496.var_a6762160))
	{
		var_7007b688 = namespace_ad5a0cd6::function_4cbb6617(data.inventory, #"equipment", array(#"hash_53a2516ec1d3a096", #"hash_3074c41bb205ed8c", #"hash_2b5027622c0b6d07", #"hash_4cec712579f1202f", #"hash_57504010ce1814dc", #"hash_5752a7e130ea202a", #"hash_4edf613e9b9032da", #"hash_28da32d9304b6296", #"hash_4a2739676c12d92a", #"hash_140318e970e711ce", #"hash_50b970644e43947b", #"hash_627144159973c325", #"hash_1a7edb90a484158b", #"hash_745d80b3e4f28da1", #"hash_56e573d15c6402bc", #"hash_213093d947c30be6", #"hash_7e8c84081fafaea4", #"hash_665eccfe5d58f636", #"hash_68b64725de40edae", #"hash_2b06a3f530395182", #"hash_16a1f841da0b877d", #"hash_1242946e889704c7", #"hash_14b578e446580ad5", #"hash_300914db9caf4033", #"hash_3a3d830a9a4559d4", #"hash_743b859c2367ff54", #"hash_5e5f2ed57ac4601f", #"hash_105f32560e2fb0fe", #"hash_18056dab055a44c9", #"hash_2e8b13391f6544", #"hash_735d22a674b7f8c0", #"hash_7f877a112c8c4187", #"hash_7aca06dcd83beef3"), var_b8f1b496.var_a6762160);
	}
	for(index = 0; index < var_7007b688.size && index < 2; index++)
	{
		var_7f695eed = data.inventory.var_a101f33c[index];
		var_b619c089 = var_7007b688[index];
		function_1a99656a(localclientnum, var_7f695eed, var_b619c089.var_bd027dd9, var_b619c089.id, var_b619c089.count, function_bba770de(localclientnum, var_b619c089.var_a6762160), var_b619c089.availableaction, undefined, 1);
		setuimodelvalue(createuimodel(var_7f695eed.var_e4130a92, "cycle"), 1);
		function_9a227103(createuimodel(var_7f695eed.var_e4130a92, "totalCount"));
	}
	for(index = var_7007b688.size; index < 2; index++)
	{
		var_7f695eed = data.inventory.var_a101f33c[index];
		function_1a99656a(localclientnum, var_7f695eed, 32767, 32767, 0, 0, 0, undefined, 1);
		setuimodelvalue(createuimodel(var_7f695eed.var_e4130a92, "cycle"), 0);
	}
}

/*
	Name: function_5c2fff73
	Namespace: namespace_b376ff3f
	Checksum: 0xB9239457
	Offset: 0x7300
	Size: 0x2EE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5c2fff73(localclientnum)
{
	data = item_world::function_a7e98a1a(localclientnum);
	if(!isdefined(data))
	{
		return;
	}
	var_765bac06 = data.inventory.items[10];
	var_7007b688 = [];
	if(isdefined(var_765bac06.var_a6762160))
	{
		var_7007b688 = namespace_ad5a0cd6::function_4cbb6617(data.inventory, #"health", array(#"hash_1abfcce0e9955057", #"hash_ff50c93155e445f", #"hash_80292d121740f6f", #"hash_45ced3880667df22"), var_765bac06.var_a6762160);
	}
	for(index = 0; index < var_7007b688.size && index < 2; index++)
	{
		var_78d7ac4a = data.inventory.healthitems[index];
		var_b619c089 = var_7007b688[index];
		function_1a99656a(localclientnum, var_78d7ac4a, var_b619c089.var_bd027dd9, var_b619c089.id, var_b619c089.count, function_bba770de(localclientnum, var_b619c089.var_a6762160), var_b619c089.availableaction, undefined, 1);
		setuimodelvalue(createuimodel(var_78d7ac4a.var_e4130a92, "cycle"), 1);
		function_9a227103(createuimodel(var_78d7ac4a.var_e4130a92, "totalCount"));
	}
	for(index = var_7007b688.size; index < 2; index++)
	{
		var_78d7ac4a = data.inventory.healthitems[index];
		function_1a99656a(localclientnum, var_78d7ac4a, 32767, 32767, 0, 0, 0, undefined, 1);
		setuimodelvalue(createuimodel(var_78d7ac4a.var_e4130a92, "cycle"), 0);
	}
}

/*
	Name: function_442857e2
	Namespace: namespace_b376ff3f
	Checksum: 0xC05ACEEF
	Offset: 0x75F8
	Size: 0x644
	Parameters: 2
	Flags: Linked, Private
*/
private function function_442857e2(localclientnum, var_a6762160)
{
	if(!isdefined(var_a6762160))
	{
		return;
	}
	if(var_a6762160.itemtype !== #"equipment" && var_a6762160.itemtype !== #"generic" && var_a6762160.itemtype !== #"health" && var_a6762160.itemtype !== #"killstreak" && var_a6762160.itemtype !== #"attachment" && var_a6762160.itemtype !== #"hash_56d6621e6c4caf07")
	{
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	if(!isdefined(data))
	{
		return;
	}
	var_6962e967 = 0;
	if(var_a6762160.itemtype == #"attachment")
	{
		player = function_27673a7(localclientnum);
		var_a4250c2b = player function_d768ea30(localclientnum);
		if(isdefined(var_a4250c2b))
		{
			var_55022c4f = array(1, 2, 3, 4, 5, 6);
			for(attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++)
			{
				var_259f58f3 = var_55022c4f[attachmentindex];
				var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_a4250c2b, var_259f58f3);
				var_b619c089 = data.inventory.items[var_f9f8c0b5];
				if(var_b619c089.var_bd027dd9 != 32767 && namespace_a0d533d1::function_73593286(var_a6762160, var_b619c089.var_a6762160))
				{
					var_6962e967 = 1;
					break;
				}
			}
		}
	}
	else if(var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		var_b619c089 = data.inventory.items[16];
	}
	else
	{
		foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1))
		{
			var_b619c089 = data.inventory.items[slot];
			if(var_b619c089.var_bd027dd9 != 32767 && namespace_a0d533d1::function_73593286(var_a6762160, var_b619c089.var_a6762160))
			{
				var_6962e967 = 1;
				break;
			}
		}
	}
	totalcount = function_bba770de(localclientnum, var_a6762160);
	if(var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quickEquip"), totalcount > 0);
	}
	else
	{
		var_6d4bb070 = 0;
		for(index = 0; index < 10; index++)
		{
			var_b619c089 = data.inventory.items[index];
			if(var_b619c089.var_bd027dd9 == 32767 || !namespace_a0d533d1::function_73593286(var_a6762160, var_b619c089.var_a6762160))
			{
				continue;
			}
			if(var_6962e967 || var_6d4bb070 || isdefined(var_b619c089.endtime))
			{
				setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quickEquip"), 0);
				var_b619c089.quickequip = 0;
			}
			else if(!var_6d4bb070)
			{
				setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quickEquip"), 1);
				var_b619c089.quickequip = 1;
				var_6d4bb070 = 1;
			}
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "totalCount"), totalcount);
		}
	}
	if(var_a6762160.itemtype === #"health")
	{
		function_5c2fff73(localclientnum);
	}
	else if(var_a6762160.itemtype === #"equipment")
	{
		function_8bb02a48(localclientnum);
	}
}

/*
	Name: function_39b663b7
	Namespace: namespace_b376ff3f
	Checksum: 0xB6A69205
	Offset: 0x7C48
	Size: 0x5AC
	Parameters: 3
	Flags: Linked, Private
*/
private function function_39b663b7(localclientnum, var_b619c089, item)
{
	var_409a5960 = createuimodel(getuimodelforcontroller(localclientnum), "questInfo");
	itemindex = getitemindexfromref(item.var_a6762160.unlockableitemref);
	if(itemindex !== 0)
	{
		var_10d25c94 = createuimodel(var_409a5960, itemindex);
		if(!isdefined(getuimodel(var_10d25c94, "completed")))
		{
			setuimodelvalue(createuimodel(var_10d25c94, "completed"), 0);
		}
		for(i = 0; i < 5; i++)
		{
			description = undefined;
			var_1bd2adc2 = createuimodel(var_10d25c94, "objective" + i + 1);
			if(!isdefined(var_1bd2adc2))
			{
				continue;
			}
			if(!isdefined(getuimodel(var_1bd2adc2, "state")))
			{
				setuimodelvalue(createuimodel(var_1bd2adc2, "state"), 0);
			}
			if(isdefined(item.var_a6762160.objectives[i]))
			{
				if(isdefined(item.var_a6762160.objectives[i].var_eea04f51) && item.var_a6762160.objectives[i].var_eea04f51.size > 0)
				{
					numplayers = getgametypesetting("maxTeamPlayers");
					foreach(objectivestruct in item.var_a6762160.objectives[i].var_eea04f51)
					{
						if(objectivestruct.teamsize == numplayers)
						{
							description = objectivestruct.description;
							break;
						}
					}
				}
				if(!isdefined(description))
				{
					description = item.var_a6762160.objectives[i].description;
				}
				var_2571317b = 0;
				if(isdefined(item.var_a6762160.objectives[i].var_7e835304))
				{
					var_2571317b = setuimodelvalue(createuimodel(var_1bd2adc2, "unlockProgress"), stats::function_441050ca(localclientnum, item.var_a6762160.objectives[i].var_7e835304));
				}
				else
				{
					setuimodelvalue(createuimodel(var_1bd2adc2, "unlockProgress"), -1);
				}
				if(!setuimodelvalue(createuimodel(var_1bd2adc2, "description"), description) && var_2571317b)
				{
					function_9a227103(createuimodel(var_1bd2adc2, "description"));
				}
				continue;
			}
			setuimodelvalue(createuimodel(var_1bd2adc2, "unlockProgress"), -1);
			setuimodelvalue(createuimodel(var_1bd2adc2, "description"), #"");
		}
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "unlockableItemRef"), item.var_a6762160.unlockableitemref);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "quote"), item.var_a6762160.var_e8b98a8a);
		setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "rewardName"), item.var_a6762160.rewardname);
	}
}

/*
	Name: function_cb7cfe5b
	Namespace: namespace_b376ff3f
	Checksum: 0x57BCC2D
	Offset: 0x8200
	Size: 0x684
	Parameters: 3
	Flags: Linked, Private
*/
private function function_cb7cfe5b(localclientnum, var_a4250c2b, var_ac517de7)
{
	if(var_ac517de7.var_bd027dd9 === 32767 || !isdefined(var_ac517de7.var_a6762160) || var_ac517de7.var_a6762160.itemtype !== #"attachment")
	{
		return;
	}
	if(!isdefined(var_a4250c2b))
	{
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "availableAction"), 0);
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "notAvailable"), 1);
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	var_ac044d12 = undefined;
	var_fdc9fcff = undefined;
	var_ffd2f6e4 = undefined;
	var_ac044d12 = data.inventory.items[var_a4250c2b];
	var_fdc9fcff = (var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1);
	var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];
	noweapon = !isdefined(var_ac044d12) || var_ac044d12.var_bd027dd9 === 32767 || !isdefined(var_ac044d12.var_a6762160) || var_ac044d12.var_a6762160.itemtype !== #"weapon";
	var_cdef462d = !isdefined(var_ffd2f6e4) || var_ffd2f6e4.var_bd027dd9 === 32767 || !isdefined(var_ffd2f6e4.var_a6762160) || var_ffd2f6e4.var_a6762160.itemtype !== #"weapon";
	if(noweapon)
	{
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "availableAction"), 0);
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "notAvailable"), 1);
		if(var_cdef462d)
		{
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "stowedAvailableAction"), 0);
			return;
		}
	}
	var_ceefbd10 = namespace_a0d533d1::function_837f4a57(var_ac517de7.var_a6762160);
	if(isdefined(namespace_a0d533d1::function_2ced1d34(var_ac044d12, var_ac517de7.var_a6762160)))
	{
		var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_a4250c2b, var_ceefbd10);
		if(data.inventory.items[var_f9f8c0b5].var_bd027dd9 !== 32767)
		{
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "availableAction"), 3);
		}
		else
		{
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "availableAction"), 2);
		}
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "notAvailable"), 0);
		function_442857e2(localclientnum, var_ac517de7.var_a6762160);
	}
	else
	{
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "availableAction"), 0);
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "notAvailable"), 1);
	}
	if(var_cdef462d)
	{
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "stowedAvailableAction"), 0);
		return;
	}
	if(isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160)))
	{
		var_50f8a92d = namespace_a0d533d1::function_dfaca25e(var_fdc9fcff, var_ceefbd10);
		if(data.inventory.items[var_50f8a92d].var_bd027dd9 !== 32767)
		{
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "stowedAvailableAction"), 3);
		}
		else
		{
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "stowedAvailableAction"), 2);
		}
	}
	else
	{
		setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "stowedAvailableAction"), 0);
	}
}

/*
	Name: function_deddbdf0
	Namespace: namespace_b376ff3f
	Checksum: 0x9DB5ED77
	Offset: 0x8890
	Size: 0xAE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_deddbdf0(localclientnum, var_f7956021)
{
	data = item_world::function_a7e98a1a(localclientnum);
	for(itemindex = 0; itemindex < data.inventory.var_c212de25; itemindex++)
	{
		var_b619c089 = data.inventory.items[itemindex];
		function_cb7cfe5b(localclientnum, var_f7956021, var_b619c089);
	}
}

/*
	Name: function_ce628f27
	Namespace: namespace_b376ff3f
	Checksum: 0x6F8EB1A9
	Offset: 0x8948
	Size: 0x40C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ce628f27(localclientnum)
{
	data = item_world::function_a7e98a1a(localclientnum);
	foreach(var_a4250c2b in array(16 + 1, 16 + 1 + 6 + 1))
	{
		var_ac044d12 = data.inventory.items[var_a4250c2b];
		var_fdc9fcff = (var_a4250c2b == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1);
		var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];
		foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
		{
			var_f9f8c0b5 = var_a4250c2b + var_259f58f3;
			var_50f8a92d = var_fdc9fcff + var_259f58f3;
			var_ac517de7 = data.inventory.items[var_f9f8c0b5];
			var_3c2da577 = data.inventory.items[var_50f8a92d];
			if(var_ac517de7.var_bd027dd9 === 32767 || !isdefined(var_ac517de7.var_a6762160))
			{
				continue;
			}
			if(var_3c2da577.var_bd027dd9 === 32767 || !isdefined(var_3c2da577.var_a6762160))
			{
				if(isdefined(var_ffd2f6e4) && isdefined(var_ffd2f6e4.var_a6762160) && isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160)))
				{
					setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "canTransferAttachment"), 2);
					continue;
				}
				setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "canTransferAttachment"), 0);
				continue;
			}
			if(isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160)) && isdefined(namespace_a0d533d1::function_2ced1d34(var_ac044d12, var_3c2da577.var_a6762160)))
			{
				setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "canTransferAttachment"), 3);
				continue;
			}
			setuimodelvalue(createuimodel(var_ac517de7.var_e4130a92, "canTransferAttachment"), 0);
		}
	}
}

/*
	Name: function_7146ceb2
	Namespace: namespace_b376ff3f
	Checksum: 0xE536ED02
	Offset: 0x8D60
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function function_7146ceb2(localclientnum, var_a6762160)
{
	data = item_world::function_a7e98a1a(localclientnum);
	if(var_a6762160.itemtype == #"ammo")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a4a6f064
	Namespace: namespace_b376ff3f
	Checksum: 0x6C57826D
	Offset: 0x8DC8
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a4a6f064(localclientnum, var_a6762160)
{
	return isdefined(function_daf3ebda(localclientnum, var_a6762160));
}

/*
	Name: function_daf3ebda
	Namespace: namespace_b376ff3f
	Checksum: 0x9B62B8AE
	Offset: 0x8E00
	Size: 0x348
	Parameters: 2
	Flags: Linked
*/
function function_daf3ebda(localclientnum, var_a6762160)
{
	if(!(isdefined(var_a6762160.stackable) && var_a6762160.stackable))
	{
		return undefined;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	var_590b4c51 = namespace_a0d533d1::function_cfa794ca(data.inventory.var_7658cbec, var_a6762160);
	if(var_590b4c51 <= 1)
	{
		return undefined;
	}
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	if(var_a6762160.itemtype == #"resource")
	{
		if(namespace_ad5a0cd6::function_41f06d9d(var_a6762160) && var_8040e225.inventory.items[14].count < var_590b4c51)
		{
			return 14;
		}
		var_ee79c3a4 = var_8040e225.inventory.items[15];
		if(!isdefined(var_ee79c3a4.id) || var_ee79c3a4.id == 32767)
		{
			return 15;
		}
		if(var_ee79c3a4.var_a6762160.name !== var_a6762160.name)
		{
			return undefined;
		}
		if(var_ee79c3a4.count < var_590b4c51)
		{
			return 15;
		}
		return undefined;
	}
	if(var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		if(var_8040e225.inventory.items[16].count < var_590b4c51)
		{
			return 16;
		}
		return undefined;
	}
	for(i = 0; i < var_8040e225.inventory.items.size; i++)
	{
		if(!isdefined(var_8040e225.inventory.items[i].id) || var_8040e225.inventory.items[i].id == 32767)
		{
			continue;
		}
		var_b619c089 = function_b1702735(var_8040e225.inventory.items[i].id);
		if(!isdefined(var_b619c089) || !isdefined(var_b619c089.var_a6762160))
		{
			continue;
		}
		if(var_b619c089.var_a6762160.name !== var_a6762160.name)
		{
			continue;
		}
		if(var_8040e225.inventory.items[i].count < var_590b4c51)
		{
			return i;
		}
	}
	return undefined;
}

/*
	Name: function_3e624606
	Namespace: namespace_b376ff3f
	Checksum: 0xE65ADD8B
	Offset: 0x9150
	Size: 0x23E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3e624606(localclientnum)
{
	self endon(#"shutdown", #"death");
	self notify("3260d2bc5ad24d7b");
	self endon("3260d2bc5ad24d7b");
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_99fe8c78 = "multi_item_pickup" + localclientnum;
	var_dab12fb1 = "multi_item_pickup_stowed_weapon" + localclientnum;
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(var_99fe8c78, var_dab12fb1);
		if(self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2)
		{
			var_bd027dd9 = waitresult.id;
			index = item_world::function_73436347(var_8040e225.var_f0f7e918, var_bd027dd9);
			var_d8138db2 = item_world::function_28b42f1c(localclientnum, var_bd027dd9);
			if(var_d8138db2 == 32767)
			{
				continue;
			}
			if(isdefined(index))
			{
				item = function_b1702735(var_d8138db2);
				if(!function_ad4c6116(localclientnum, item.var_a6762160))
				{
					continue;
				}
				if(waitresult._notify === var_dab12fb1)
				{
					function_97fedb0d(localclientnum, 12, var_bd027dd9);
				}
				else
				{
					function_97fedb0d(localclientnum, 3, var_bd027dd9);
				}
				function_7f056944(localclientnum, index);
				if(!function_7146ceb2(localclientnum, item.var_a6762160))
				{
					continue;
				}
			}
		}
	}
}

/*
	Name: function_30697356
	Namespace: namespace_b376ff3f
	Checksum: 0xFFE25392
	Offset: 0x9398
	Size: 0x182
	Parameters: 2
	Flags: Linked, Private
*/
private function function_30697356(localclientnum, var_a6762160)
{
	if(!isdefined(var_a6762160))
	{
		return 0;
	}
	if(var_a6762160.itemtype === #"hash_56d6621e6c4caf07")
	{
		return 6;
	}
	if(isdefined(var_a6762160.consumable) && var_a6762160.consumable)
	{
		return 4;
	}
	if(var_a6762160.itemtype === #"generic")
	{
		return 0;
	}
	if(var_a6762160.itemtype === #"cash")
	{
		return 0;
	}
	if(var_a6762160.itemtype === #"killstreak")
	{
		return 4;
	}
	if(var_a6762160.itemtype === #"armor")
	{
		return 0;
	}
	if(var_a6762160.itemtype === #"ammo")
	{
		return 0;
	}
	if(var_a6762160.itemtype == #"weapon")
	{
		return 0;
	}
	if(var_a6762160.itemtype == #"quest")
	{
		return 0;
	}
	if(var_a6762160.itemtype === #"attachment")
	{
		return 2;
	}
	return 1;
}

/*
	Name: function_ad4c6116
	Namespace: namespace_b376ff3f
	Checksum: 0xAFC87175
	Offset: 0x9528
	Size: 0x256
	Parameters: 2
	Flags: Linked
*/
function function_ad4c6116(localclientnum, var_a6762160)
{
	if(var_a6762160.itemtype == #"weapon")
	{
		return 1;
	}
	if(!function_7146ceb2(localclientnum, var_a6762160))
	{
		return 1;
	}
	if(var_a6762160.itemtype == #"resource")
	{
		if(namespace_ad5a0cd6::function_41f06d9d(var_a6762160))
		{
			return !function_88da0c8e(localclientnum);
		}
	}
	if(var_a6762160.itemtype == #"armor")
	{
		return 1;
	}
	if(var_a6762160.itemtype == #"attachment")
	{
		slotid = function_1415f8f1(localclientnum, var_a6762160);
		if(isdefined(slotid))
		{
			return 1;
		}
	}
	if(function_a243ddd6(localclientnum, var_a6762160))
	{
		return 1;
	}
	if(function_a4a6f064(localclientnum, var_a6762160))
	{
		return 1;
	}
	if(var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		return 0;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	if(var_a6762160.itemtype == #"resource")
	{
		if(data.inventory.items[15].var_bd027dd9 === 32767)
		{
			return 1;
		}
		return 0;
	}
	for(i = 0; i < data.inventory.var_c212de25; i++)
	{
		if(data.inventory.items[i].var_bd027dd9 === 32767)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a243ddd6
	Namespace: namespace_b376ff3f
	Checksum: 0xD292775D
	Offset: 0x9788
	Size: 0x26C
	Parameters: 2
	Flags: Linked
*/
function function_a243ddd6(localclientnum, var_a6762160)
{
	data = item_world::function_a7e98a1a(localclientnum);
	switch(var_a6762160.itemtype)
	{
		case "attachment":
		{
			slotid = function_1415f8f1(localclientnum, var_a6762160);
			if(!isdefined(slotid))
			{
				return 0;
			}
			return data.inventory.items[slotid].var_bd027dd9 == 32767;
		}
		case "armor":
		{
			return data.inventory.items[11].var_bd027dd9 == 32767;
		}
		case "backpack":
		{
			return data.inventory.items[13].var_bd027dd9 == 32767;
		}
		case "equipment":
		{
			return data.inventory.items[12].var_bd027dd9 == 32767;
		}
		case "health":
		{
			return data.inventory.items[10].var_bd027dd9 == 32767;
		}
		case "weapon":
		{
			return data.inventory.items[16 + 1].var_bd027dd9 == 32767 || data.inventory.items[16 + 1 + 6 + 1].var_bd027dd9 == 32767;
		}
		case "ammo":
		case "generic":
		case "killstreak":
		case "cash":
		default:
		{
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_d768ea30
	Namespace: namespace_b376ff3f
	Checksum: 0x3D52BA44
	Offset: 0x9A00
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_d768ea30(localclientnum)
{
	/#
		assert(isplayer(self));
	#/
	var_b4322d52 = 0;
	currentweapon = (isdefined(self.currentweapon) ? self.currentweapon : self.weapon);
	if(currentweapon == level.weaponbasemeleeheld)
	{
		data = item_world::function_a7e98a1a(localclientnum);
		return;
	}
	foreach(attachment in currentweapon.attachments)
	{
		if(attachment == #"null")
		{
			var_b4322d52 = 1;
			break;
		}
	}
	return (var_b4322d52 ? 16 + 1 + 6 + 1 : 16 + 1);
}

/*
	Name: function_78ed4455
	Namespace: namespace_b376ff3f
	Checksum: 0xE2B3EBE6
	Offset: 0x9B60
	Size: 0x20C
	Parameters: 2
	Flags: Linked
*/
function function_78ed4455(localclientnum, var_a6762160)
{
	/#
		assert(isplayer(self));
	#/
	data = item_world::function_a7e98a1a(localclientnum);
	switch(var_a6762160.itemtype)
	{
		case "armor":
		{
			return 11;
		}
		case "backpack":
		{
			return 13;
		}
		case "equipment":
		{
			if(data.inventory.items[12].var_bd027dd9 == 32767)
			{
				return 12;
			}
			break;
		}
		case "health":
		{
			if(data.inventory.items[10].var_bd027dd9 == 32767)
			{
				return 10;
			}
			break;
		}
		case "weapon":
		{
			if(data.inventory.items[16 + 1].var_bd027dd9 == 32767)
			{
				return 16 + 1;
			}
			else if(data.inventory.items[16 + 1 + 6 + 1].var_bd027dd9 == 32767)
			{
				return 16 + 1 + 6 + 1;
			}
			break;
		}
	}
	if(var_a6762160.itemtype == #"attachment")
	{
		return function_1415f8f1(localclientnum, var_a6762160);
	}
}

/*
	Name: function_9c4460e0
	Namespace: namespace_b376ff3f
	Checksum: 0x8535FE41
	Offset: 0x9D78
	Size: 0x294
	Parameters: 4
	Flags: Linked
*/
function function_9c4460e0(localclientnum, var_d8138db2, count = 1, slotid = undefined)
{
	/#
		assert(isint(var_d8138db2));
	#/
	if(!isdefined(var_d8138db2))
	{
		return;
	}
	point = function_b1702735(var_d8138db2);
	if(!isdefined(point))
	{
		return;
	}
	var_a6762160 = point.var_a6762160;
	availableaction = function_30697356(localclientnum, var_a6762160);
	data = item_world::function_a7e98a1a(localclientnum);
	selectedindex = undefined;
	if(count == 0)
	{
		return;
	}
	if(!isdefined(selectedindex) && isdefined(slotid))
	{
		selectedindex = slotid;
	}
	if(!isdefined(selectedindex))
	{
		selectedindex = item_world::function_73436347(data.inventory.items, 32767);
		if(!isdefined(selectedindex))
		{
			/#
				println("" + var_d8138db2 + "");
			#/
			return;
		}
	}
	player = function_27673a7(localclientnum);
	var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(player, selectedindex);
	var_b619c089 = undefined;
	if(selectedindex < data.inventory.items.size)
	{
		var_b619c089 = data.inventory.items[selectedindex];
	}
	/#
		assert(isdefined(var_b619c089));
	#/
	totalcount = function_bba770de(localclientnum, var_a6762160);
	totalcount = totalcount + count;
	player function_1a99656a(localclientnum, var_b619c089, var_bd027dd9, var_d8138db2, count, totalcount, availableaction);
}

/*
	Name: function_1415f8f1
	Namespace: namespace_b376ff3f
	Checksum: 0x590ECE32
	Offset: 0xA018
	Size: 0x184
	Parameters: 2
	Flags: Linked
*/
function function_1415f8f1(localclientnum, var_a6762160)
{
	/#
		assert(isplayer(self));
	#/
	data = item_world::function_a7e98a1a(localclientnum);
	if(var_a6762160.itemtype == #"attachment")
	{
		var_4838b749 = function_d768ea30(localclientnum);
		if(!isdefined(var_4838b749))
		{
			return;
		}
		var_f0dc4e93 = namespace_ad5a0cd6::function_970b8d86(self, var_4838b749);
		if(data.inventory.items[var_4838b749].var_bd027dd9 == 32767)
		{
			return;
		}
		var_ceefbd10 = namespace_a0d533d1::function_837f4a57(var_a6762160);
		var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
		var_64d58696 = self function_15d578f4(localclientnum, var_f0dc4e93);
		attachmentname = namespace_a0d533d1::function_2ced1d34(var_64d58696, var_a6762160);
		if(isdefined(attachmentname))
		{
			return var_f9f8c0b5;
		}
	}
}

/*
	Name: function_bba770de
	Namespace: namespace_b376ff3f
	Checksum: 0x3A105ED8
	Offset: 0xA1A8
	Size: 0x18A
	Parameters: 2
	Flags: Linked
*/
function function_bba770de(localclientnum, var_a6762160)
{
	data = item_world::function_a7e98a1a(localclientnum);
	count = 0;
	if(!isdefined(var_a6762160))
	{
		return count;
	}
	name = (isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name);
	for(index = 0; index < data.inventory.items.size && index < 16 + 1; index++)
	{
		var_b619c089 = data.inventory.items[index];
		if(!isdefined(var_b619c089.var_a6762160) || isdefined(var_b619c089.endtime))
		{
			continue;
		}
		if(name == (isdefined(var_b619c089.var_a6762160.var_a6762160.parentname) ? var_b619c089.var_a6762160.parentname : var_b619c089.var_a6762160.name))
		{
			count = count + var_b619c089.count;
		}
	}
	return count;
}

/*
	Name: function_e106cbe9
	Namespace: namespace_b376ff3f
	Checksum: 0x5DF81870
	Offset: 0xA340
	Size: 0x186
	Parameters: 3
	Flags: Linked
*/
function function_e106cbe9(localclientnum, item, var_1326fcc7 = undefined)
{
	/#
		assert(isplayer(self));
	#/
	data = item_world::function_a7e98a1a(localclientnum);
	var_a6762160 = item.var_a6762160;
	var_95162a97 = var_a6762160.weapon;
	var_1326fcc7 = (isdefined(var_1326fcc7) ? var_1326fcc7 : (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1));
	var_2f399b51 = namespace_a0d533d1::function_2879cbe0(data.inventory.var_7658cbec, var_95162a97);
	currentammostock = self getweaponammostock(localclientnum, var_95162a97);
	var_9b9ba643 = var_2f399b51 - currentammostock;
	addammo = int(min(var_1326fcc7, var_9b9ba643));
	return addammo > 0;
}

/*
	Name: function_85645978
	Namespace: namespace_b376ff3f
	Checksum: 0x719E41FB
	Offset: 0xA4D0
	Size: 0xE2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_85645978(data, item)
{
	currtime = gettime();
	foreach(consumeditem in data.inventory.consumed.items)
	{
		if(item.var_a6762160.name == consumeditem.var_a6762160.name && currtime < consumeditem.endtime)
		{
			return consumeditem;
		}
	}
	return undefined;
}

/*
	Name: function_52e537be
	Namespace: namespace_b376ff3f
	Checksum: 0xC989F842
	Offset: 0xA5C0
	Size: 0x136
	Parameters: 2
	Flags: Linked
*/
function function_52e537be(localclientnum, var_bd027dd9)
{
	item = function_15d578f4(localclientnum, var_bd027dd9);
	if(isdefined(item))
	{
		setuimodelvalue(createuimodel(item.var_e4130a92, "castTimeFraction"), 0, 0);
	}
	data = item_world::function_a7e98a1a(localclientnum);
	if(isdefined(data) && isdefined(data.inventory) && var_bd027dd9 === data.inventory.var_4d4ec560)
	{
		setuimodelvalue(data.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
		data.inventory.var_4d4ec560 = undefined;
	}
}

/*
	Name: function_7730442c
	Namespace: namespace_b376ff3f
	Checksum: 0x28255535
	Offset: 0xA700
	Size: 0x56C
	Parameters: 2
	Flags: Linked
*/
function function_7730442c(localclientnum, var_bd027dd9)
{
	/#
		assert(var_bd027dd9 != 32767);
	#/
	if(var_bd027dd9 == 32767)
	{
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	item = function_15d578f4(localclientnum, var_bd027dd9);
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	duration = int((isdefined(item.var_a6762160.duration) ? item.var_a6762160.duration : 0) * 1000);
	starttime = gettime();
	endtime = starttime + duration;
	item.starttime = starttime;
	item.endtime = endtime;
	totalcount = function_bba770de(localclientnum, item.var_a6762160);
	function_1a99656a(localclientnum, item, var_bd027dd9, item.id, 1, totalcount, 5, 0);
	var_3285d88f = data.inventory.consumed.items.size;
	var_cfa0e915 = [];
	foreach(consumeditem in data.inventory.consumed.items)
	{
		if(isdefined(var_cfa0e915[consumeditem.var_a6762160.name]))
		{
			continue;
		}
		var_cfa0e915[consumeditem.var_a6762160.name] = 1;
	}
	consumeditem = function_85645978(data, item);
	if(isdefined(consumeditem))
	{
		consumeditem.endtime = consumeditem.endtime + duration;
		for(index = 0; index < 10; index++)
		{
			var_b619c089 = data.inventory.items[index];
			if(!isdefined(var_b619c089.endtime))
			{
				continue;
			}
			if(var_b619c089.var_a6762160.name == item.var_a6762160.name)
			{
				var_b619c089.starttime = consumeditem.starttime;
				var_b619c089.endtime = consumeditem.endtime;
			}
		}
	}
	else
	{
		consumeditem = spawnstruct();
		consumeditem.id = item.id;
		consumeditem.var_a6762160 = item.var_a6762160;
		consumeditem.var_e4130a92 = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
		consumeditem.starttime = gettime();
		consumeditem.endtime = consumeditem.starttime + duration;
		var_cfa0e915[consumeditem.var_a6762160.name] = 1;
	}
	data.inventory.consumed.items[var_3285d88f] = consumeditem;
	var_31c78e6f = consumeditem.var_a6762160;
	function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
	function_1a99656a(localclientnum, consumeditem, var_bd027dd9, item.id, 0, 0, 0, 0);
	setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
	function_442857e2(localclientnum, var_31c78e6f);
	level thread function_451ebd83(localclientnum, consumeditem.var_a6762160, var_bd027dd9);
}

/*
	Name: function_de74158f
	Namespace: namespace_b376ff3f
	Checksum: 0xC6E47B53
	Offset: 0xAC78
	Size: 0x2BC
	Parameters: 2
	Flags: Linked
*/
function function_de74158f(localclientnum, var_bd027dd9)
{
	/#
		assert(var_bd027dd9 != 32767);
	#/
	if(var_bd027dd9 == 32767)
	{
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	item = function_15d578f4(localclientnum, var_bd027dd9);
	if(!isdefined(item))
	{
		return;
	}
	var_cfa0e915 = [];
	foreach(consumeditem in data.inventory.consumed.items)
	{
		if(isdefined(var_cfa0e915[consumeditem.var_a6762160.name]))
		{
			continue;
		}
		var_cfa0e915[consumeditem.var_a6762160.name] = 1;
	}
	consumeditem = spawnstruct();
	consumeditem.id = item.id;
	consumeditem.var_a6762160 = item.var_a6762160;
	consumeditem.var_e4130a92 = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
	var_cfa0e915[consumeditem.var_a6762160.name] = 1;
	function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
	function_1a99656a(localclientnum, consumeditem, var_bd027dd9, item.id, 0, 0, 0, 0);
	setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
	level thread function_451ebd83(localclientnum, item.var_a6762160, undefined);
}

/*
	Name: function_7f056944
	Namespace: namespace_b376ff3f
	Checksum: 0x3D52104F
	Offset: 0xAF40
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_7f056944(localclientnum, index)
{
	var_6e2c91d0 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
	setuimodelvalue(createuimodel(var_6e2c91d0, "item" + index + ".disabled"), 1);
}

/*
	Name: function_3bd1836f
	Namespace: namespace_b376ff3f
	Checksum: 0x26AF18C0
	Offset: 0xAFE0
	Size: 0x142
	Parameters: 2
	Flags: Linked
*/
function function_3bd1836f(localclientnum, var_bd027dd9)
{
	if(var_bd027dd9 == namespace_ad5a0cd6::function_970b8d86(function_27673a7(localclientnum), 13))
	{
		function_5f44b06(localclientnum, var_bd027dd9);
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	foreach(var_b619c089 in data.inventory.items)
	{
		if(var_b619c089.var_bd027dd9 === var_bd027dd9)
		{
			function_8063170(var_b619c089, 1);
			playsound(localclientnum, #"hash_4d31bd9927d823c3");
			return;
		}
	}
}

/*
	Name: function_5f44b06
	Namespace: namespace_b376ff3f
	Checksum: 0xC2E9F35C
	Offset: 0xB130
	Size: 0x224
	Parameters: 2
	Flags: Linked
*/
function function_5f44b06(localclientnum, var_bd027dd9)
{
	data = item_world::function_a7e98a1a(localclientnum);
	if(!isdefined(data))
	{
		return;
	}
	item = function_15d578f4(localclientnum, var_bd027dd9);
	if(!isdefined(item))
	{
		waittillframeend();
		item = function_15d578f4(localclientnum, var_bd027dd9);
		if(!isdefined(item))
		{
			return;
		}
	}
	data.inventory.var_7658cbec = namespace_a0d533d1::function_d8cebda3(item.var_a6762160);
	if(data.inventory.var_7658cbec & 1 && data.inventory.var_c212de25 != 10)
	{
		for(index = data.inventory.var_c212de25; index < 10; index++)
		{
			var_b619c089 = data.inventory.items[index];
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "disabled"), 0);
		}
		data.inventory.var_c212de25 = 10;
		var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
		setuimodelvalue(createuimodel(var_dcb56aa8, "count"), data.inventory.var_c212de25);
	}
}

/*
	Name: function_15d578f4
	Namespace: namespace_b376ff3f
	Checksum: 0x2B881ED5
	Offset: 0xB360
	Size: 0x108
	Parameters: 2
	Flags: Linked
*/
function function_15d578f4(localclientnum, var_bd027dd9)
{
	/#
		assert(isdefined(localclientnum));
	#/
	/#
		assert(namespace_ad5a0cd6::function_d9648161(var_bd027dd9));
	#/
	data = item_world::function_a7e98a1a(localclientnum);
	/#
		assert(isdefined(data));
	#/
	for(index = 0; index < data.inventory.items.size; index++)
	{
		var_b619c089 = data.inventory.items[index];
		if(var_b619c089.var_bd027dd9 === var_bd027dd9)
		{
			return var_b619c089;
		}
	}
}

/*
	Name: function_c48cd17f
	Namespace: namespace_b376ff3f
	Checksum: 0xDA3B54E1
	Offset: 0xB470
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function function_c48cd17f(localclientnum, var_bd027dd9)
{
	item = function_15d578f4(localclientnum, var_bd027dd9);
	if(isdefined(item))
	{
		return item.id;
	}
	return 32767;
}

/*
	Name: function_850588f4
	Namespace: namespace_b376ff3f
	Checksum: 0x26A347D1
	Offset: 0xB4C8
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_850588f4(localclientnum, var_4838b749)
{
	/#
		assert(isdefined(localclientnum));
	#/
	if(!isdefined(var_4838b749))
	{
		return 0;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
	{
		slotid = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
		if(data.inventory.items[slotid].var_bd027dd9 != 32767)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_42e2bb1a
	Namespace: namespace_b376ff3f
	Checksum: 0x307FF005
	Offset: 0xB608
	Size: 0xCBC
	Parameters: 1
	Flags: Linked
*/
function function_42e2bb1a(localclientnum)
{
	data = item_world::function_a7e98a1a(localclientnum);
	var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
	pickedupammotypes = createuimodel(var_dcb56aa8, "pickedUpAmmoTypes");
	setuimodelvalue(createuimodel(pickedupammotypes, "count"), 0);
	data.inventory = spawnstruct();
	data.inventory.consumed = {};
	data.inventory.consumed.items = [];
	data.inventory.count = 16 + 1 + 6 + 1 + 6 + 1;
	data.inventory.items = [];
	data.inventory.var_a7a2b773 = 0;
	data.inventory.var_c212de25 = 5;
	data.inventory.var_7658cbec = 0;
	if(ispc())
	{
		data.inventory.var_f3518190 = undefined;
		data.inventory.var_4d4ec560 = undefined;
	}
	for(index = 0; index < data.inventory.count; index++)
	{
		data.inventory.items[index] = spawnstruct();
	}
	for(index = 0; index < 5; index++)
	{
		data.inventory.items[index].var_e4130a92 = createuimodel(var_dcb56aa8, "item" + index);
		setuimodelvalue(createuimodel(data.inventory.items[index].var_e4130a92, "backpackSlot"), 0);
		setuimodelvalue(createuimodel(data.inventory.items[index].var_e4130a92, "disabled"), 0);
	}
	for(index = 5; index < 10; index++)
	{
		data.inventory.items[index].var_e4130a92 = createuimodel(var_dcb56aa8, "item" + index);
		setuimodelvalue(createuimodel(data.inventory.items[index].var_e4130a92, "backpackSlot"), 1);
		setuimodelvalue(createuimodel(data.inventory.items[index].var_e4130a92, "disabled"), 1);
	}
	data.inventory.items[10].var_e4130a92 = createuimodel(var_dcb56aa8, "health");
	data.inventory.items[11].var_e4130a92 = createuimodel(var_dcb56aa8, "gear");
	data.inventory.items[13].var_e4130a92 = createuimodel(var_dcb56aa8, "storage");
	data.inventory.items[12].var_e4130a92 = createuimodel(var_dcb56aa8, "equipment");
	data.inventory.items[14].var_e4130a92 = createuimodel(var_dcb56aa8, "resource0");
	data.inventory.items[15].var_e4130a92 = createuimodel(var_dcb56aa8, "resource1");
	data.inventory.items[16].var_e4130a92 = createuimodel(var_dcb56aa8, "shard0");
	var_d42bc614 = array(16 + 1, 16 + 1 + 6 + 1);
	for(index = 0; index < var_d42bc614.size; index++)
	{
		var_4838b749 = var_d42bc614[index];
		data.inventory.items[var_4838b749].var_e4130a92 = createuimodel(var_dcb56aa8, "weapon" + index);
		var_55022c4f = array(1, 2, 3, 4, 5, 6);
		for(attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++)
		{
			var_259f58f3 = var_55022c4f[attachmentindex];
			var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
			var_cdc380b6 = attachmentindex + index * var_55022c4f.size;
			data.inventory.items[var_f9f8c0b5].var_e4130a92 = createuimodel(var_dcb56aa8, "attachment" + var_cdc380b6);
		}
	}
	for(index = 0; index < data.inventory.items.size; index++)
	{
		if(!isdefined(data.inventory.items[index].var_e4130a92))
		{
			continue;
		}
		function_1a99656a(localclientnum, data.inventory.items[index], 32767, 32767, 0, 0, 0);
	}
	data.inventory.healthitems = [];
	for(index = 0; index < 2; index++)
	{
		data.inventory.healthitems[index] = spawnstruct();
		data.inventory.healthitems[index].var_e4130a92 = createuimodel(var_dcb56aa8, "health" + index);
		function_1a99656a(localclientnum, data.inventory.healthitems[index], 32767, 32767, 0, 0, 0);
	}
	data.inventory.var_a101f33c = [];
	for(index = 0; index < 2; index++)
	{
		data.inventory.var_a101f33c[index] = spawnstruct();
		data.inventory.var_a101f33c[index].var_e4130a92 = createuimodel(var_dcb56aa8, "equipment" + index);
		function_1a99656a(localclientnum, data.inventory.var_a101f33c[index], 32767, 32767, 0, 0, 0);
	}
	setuimodelvalue(createuimodel(var_dcb56aa8, "count"), 5);
	setuimodelvalue(createuimodel(var_dcb56aa8, "filledSlots"), 0);
	setuimodelvalue(createuimodel(var_dcb56aa8, "attachmentCount"), 6);
	setuimodelvalue(createuimodel(var_dcb56aa8, "resourceCount"), 1);
	setuimodelvalue(createuimodel(var_dcb56aa8, "shardCount"), 1);
	setuimodelvalue(createuimodel(var_dcb56aa8, "canUseQuickInventory"), 0);
	if(function_88da0c8e(localclientnum))
	{
		setuimodelvalue(createuimodel(data.inventory.items[14].var_e4130a92, "notAccessible"), 1);
	}
	data.inventory.consumed.uimodel = createuimodel(var_dcb56aa8, "consumed");
	data.inventory.consumed.var_a25538fb = createuimodel(data.inventory.consumed.uimodel, "count");
	setuimodelvalue(data.inventory.consumed.var_a25538fb, 0);
	level thread function_dab42db1(localclientnum);
	level thread function_d7869556(localclientnum);
	level thread function_cf96d951(localclientnum);
	function_9a227103(createuimodel(var_dcb56aa8, "initialize"));
}

/*
	Name: function_dab42db1
	Namespace: namespace_b376ff3f
	Checksum: 0x3BAE278
	Offset: 0xC2D0
	Size: 0x20C
	Parameters: 1
	Flags: Linked
*/
function function_dab42db1(localclientnum)
{
	level flagsys::wait_till(#"hash_51daecff754729dc");
	foreach(ammotype in array(#"hash_182fdef2ad243e20", #"hash_212b01feaa916a00", #"hash_3bf6ed4e3a22e9f3", #"hash_1f72dec518451f8c", #"hash_3b5119f663e783b1", #"hash_7ebaa4e1e2f5d8a2", #"hash_46dd75a1a3f70780", #"hash_394e9478cf4f8d9d"))
	{
		point = function_4ba8fde(ammotype);
		if(isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"ammo")
		{
			function_4f16aa30(localclientnum, point.id);
		}
	}
	var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
	pickedupammotypes = createuimodel(var_dcb56aa8, "pickedUpAmmoTypes");
	function_9a227103(pickedupammotypes);
}

/*
	Name: function_cf96d951
	Namespace: namespace_b376ff3f
	Checksum: 0x620B5233
	Offset: 0xC4E8
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_cf96d951(localclientnum)
{
	level flagsys::wait_till(#"hash_51daecff754729dc");
	data = item_world::function_a7e98a1a(localclientnum);
	point = function_4ba8fde(#"hash_2e33ce38d6cda617");
	if(isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		if(data.inventory.items[16].var_bd027dd9 == 32767)
		{
			function_1a99656a(localclientnum, data.inventory.items[16], point.var_bd027dd9, point.id, 0, 0, 0);
		}
	}
}

/*
	Name: function_d7869556
	Namespace: namespace_b376ff3f
	Checksum: 0xA451C122
	Offset: 0xC628
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_d7869556(localclientnum)
{
	level flagsys::wait_till(#"hash_51daecff754729dc");
	data = item_world::function_a7e98a1a(localclientnum);
	point = function_4ba8fde(#"hash_5e9c3f9821e1ee0a");
	if(isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"resource")
	{
		function_1a99656a(localclientnum, data.inventory.items[14], point.var_bd027dd9, point.id, 0, 0, 0);
	}
}

/*
	Name: function_534dcb9c
	Namespace: namespace_b376ff3f
	Checksum: 0x3B687E69
	Offset: 0xC740
	Size: 0x466
	Parameters: 1
	Flags: Linked, Private
*/
private function function_534dcb9c(localclientnum)
{
	if(!isdefined(level.var_af8f97c8) || !isdefined(level.var_af8f97c8[localclientnum]))
	{
		if(!isdefined(level.var_aa75d3e))
		{
			level.var_aa75d3e = [];
		}
		else if(!isarray(level.var_aa75d3e))
		{
			level.var_aa75d3e = array(level.var_aa75d3e);
		}
		if(!isdefined(level.var_af8f97c8))
		{
			level.var_af8f97c8 = [];
		}
		else if(!isarray(level.var_af8f97c8))
		{
			level.var_af8f97c8 = array(level.var_af8f97c8);
		}
		if(!isdefined(level.var_53cbbb33))
		{
			level.var_53cbbb33 = [];
		}
		else if(!isarray(level.var_53cbbb33))
		{
			level.var_53cbbb33 = array(level.var_53cbbb33);
		}
		if(!isdefined(level.var_3a0390dd))
		{
			level.var_3a0390dd = [];
		}
		else if(!isarray(level.var_3a0390dd))
		{
			level.var_3a0390dd = array(level.var_3a0390dd);
		}
		if(!isdefined(level.var_c8a5f79b))
		{
			level.var_c8a5f79b = [];
		}
		else if(!isarray(level.var_c8a5f79b))
		{
			level.var_c8a5f79b = array(level.var_c8a5f79b);
		}
		if(!isdefined(level.var_7086ad4f))
		{
			level.var_7086ad4f = [];
		}
		else if(!isarray(level.var_7086ad4f))
		{
			level.var_7086ad4f = array(level.var_7086ad4f);
		}
		level.var_aa75d3e[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeaponIndex");
		level.var_af8f97c8[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon");
		level.var_c8a5f79b[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.ammoType");
		level.var_53cbbb33[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.isOperator");
		level.var_3a0390dd[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.currentWeapon.isTactical");
		level.var_7086ad4f[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.showAttachments");
		level.var_6d21daaf[localclientnum] = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canTransferFromStash");
	}
}

/*
	Name: function_6231c19
	Namespace: namespace_b376ff3f
	Checksum: 0xDAA38EFE
	Offset: 0xCBB0
	Size: 0x8EC
	Parameters: 1
	Flags: Linked
*/
function function_6231c19(params)
{
	if(params.weapon.name == #"none")
	{
		return;
	}
	if(isstruct(self))
	{
		return;
	}
	if(!self function_da43934d() || !isplayer(self) || !isalive(self))
	{
		return;
	}
	function_534dcb9c(params.localclientnum);
	if(isdefined(params.weapon))
	{
		data = item_world::function_a7e98a1a(params.localclientnum);
		if(!isdefined(data) || !isdefined(data.inventory) || !isdefined(data.inventory.items) || data.inventory.items.size == 0)
		{
			return;
		}
		self.currentweapon = params.weapon;
		if(params.weapon == level.weaponbasemeleeheld)
		{
			setuimodelvalue(level.var_7086ad4f[params.localclientnum], 0);
			itemindex = getbaseweaponitemindex(getweapon(#"none"));
			foreach(slot in array(16 + 1, 16 + 1 + 6 + 1))
			{
				if(data.inventory.items[slot].var_bd027dd9 == 32767)
				{
					break;
				}
			}
			if(!isdefined(index))
			{
				return;
			}
			setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
			setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
			if(!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index))
			{
				function_9a227103(level.var_aa75d3e[params.localclientnum]);
			}
			if(!setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex))
			{
				function_9a227103(level.var_af8f97c8[params.localclientnum]);
			}
			function_deddbdf0(params.localclientnum);
			function_ce628f27(params.localclientnum);
			return;
		}
		var_a4250c2b = self function_d768ea30(params.localclientnum);
		foreach(index, slot in array(16 + 1, 16 + 1 + 6 + 1))
		{
			if(slot === var_a4250c2b)
			{
				if(!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index))
				{
					function_9a227103(level.var_aa75d3e[params.localclientnum]);
				}
				break;
			}
		}
		var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, var_a4250c2b);
		item = function_15d578f4(params.localclientnum, var_bd027dd9);
		if(isdefined(item) && isdefined(item.var_a6762160) && (isdefined(item.var_a6762160.var_340eac1f) && item.var_a6762160.var_340eac1f))
		{
			setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
			setuimodelvalue(level.var_3a0390dd[params.localclientnum], 1);
		}
		else if(isdefined(item) && isdefined(item.var_a6762160) && (isdefined(item.var_a6762160.var_dc6c5d3b) && item.var_a6762160.var_dc6c5d3b))
		{
			setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
			setuimodelvalue(level.var_53cbbb33[params.localclientnum], 1);
		}
		else
		{
			setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
			setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
		}
		if(isdefined(params.weapon.statname) && params.weapon.statname != #"")
		{
			itemindex = getbaseweaponitemindex(getweapon(params.weapon.statname));
		}
		else
		{
			itemindex = getbaseweaponitemindex(params.weapon);
		}
		var_754fe8c5 = function_e36b5f2c(params.weapon);
		if(isdefined(level.var_c53d118f) && isdefined(level.var_c53d118f[var_754fe8c5]))
		{
			setuimodelvalue(level.var_c8a5f79b[params.localclientnum], level.var_c53d118f[var_754fe8c5]);
		}
		else
		{
			setuimodelvalue(level.var_c8a5f79b[params.localclientnum], #"");
		}
		setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex);
		function_9a227103(level.var_af8f97c8[params.localclientnum]);
		supportsattachments = 0;
		if(isdefined(item))
		{
			supportsattachments = namespace_a0d533d1::function_4bd83c04(item);
		}
		setuimodelvalue(level.var_7086ad4f[params.localclientnum], supportsattachments);
		function_deddbdf0(params.localclientnum, var_a4250c2b);
		function_ce628f27(params.localclientnum);
	}
}

/*
	Name: function_8ffee46f
	Namespace: namespace_b376ff3f
	Checksum: 0xD3D7D9B3
	Offset: 0xD4A8
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_8ffee46f(localclientnum, item)
{
	var_f9b70cae = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
	itemname = item_world::get_item_name(item.var_a6762160);
	if(!setuimodelvalue(var_f9b70cae, itemname))
	{
		function_9a227103(var_f9b70cae);
	}
	if(item.var_a6762160.itemtype == #"weapon")
	{
		var_d9659d2a = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpWeapon");
		if(!setuimodelvalue(var_d9659d2a, itemname))
		{
			function_9a227103(var_d9659d2a);
		}
	}
	else if(item.var_a6762160.itemtype == #"generic")
	{
		function_22759012(localclientnum, item.var_bd027dd9);
	}
}

/*
	Name: function_c9764f6d
	Namespace: namespace_b376ff3f
	Checksum: 0xF0BAD28C
	Offset: 0xD628
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_c9764f6d(localclientnum)
{
	var_80c295ff = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.droppedWeapon");
	function_9a227103(var_80c295ff);
}

/*
	Name: function_451ebd83
	Namespace: namespace_b376ff3f
	Checksum: 0xA2BC4C12
	Offset: 0xD690
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function function_451ebd83(localclientnum, item, var_bd027dd9)
{
	itemname = item_world::get_item_name(item);
	waittillframeend();
	var_e16dbee1 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.consumedItem");
	if(!setuimodelvalue(var_e16dbee1, itemname))
	{
		function_9a227103(var_e16dbee1);
	}
	data = item_world::function_a7e98a1a(localclientnum);
	if(isdefined(data) && isdefined(data.inventory) && var_bd027dd9 === data.inventory.var_4d4ec560)
	{
		data.inventory.var_4d4ec560 = undefined;
	}
	function_9f5d2dc8(localclientnum);
}

/*
	Name: function_4f16aa30
	Namespace: namespace_b376ff3f
	Checksum: 0x2D039DED
	Offset: 0xD7C8
	Size: 0x4D4
	Parameters: 2
	Flags: Linked
*/
function function_4f16aa30(localclientnum, var_d8138db2)
{
	if(!isdefined(level.var_c53d118f))
	{
		level.var_c53d118f = [];
	}
	/#
		assert(namespace_ad5a0cd6::function_2c7fc531(var_d8138db2));
	#/
	item = function_b1702735(var_d8138db2);
	if(!isdefined(item.var_a6762160))
	{
		return;
	}
	var_754fe8c5 = function_e36b5f2c(item.var_a6762160.weapon);
	if(!isdefined(var_754fe8c5) || item.var_a6762160.itemtype !== #"ammo")
	{
		return;
	}
	var_f9b70cae = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
	var_7268d07 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpAmmoTypes");
	var_5a2db7bb = createuimodel(var_7268d07, "count");
	var_b4676aed = getuimodelvalue(var_5a2db7bb);
	for(i = 0; i < var_b4676aed; i++)
	{
		var_acd2831f = createuimodel(var_7268d07, "" + i + 1);
		if(getuimodelvalue(createuimodel(var_acd2831f, "assetName")) == var_754fe8c5)
		{
			if(item.var_a6762160.itemtype == #"ammo" && !getuimodelvalue(createuimodel(var_acd2831f, "canDrop")))
			{
				setuimodelvalue(createuimodel(var_acd2831f, "id"), var_d8138db2);
				setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), item.var_a6762160.itemtype == #"ammo");
			}
			return;
		}
	}
	level.var_c53d118f[var_754fe8c5] = item.var_a6762160.displayname;
	var_acd2831f = createuimodel(var_7268d07, "" + var_b4676aed + 1);
	setuimodelvalue(createuimodel(var_acd2831f, "assetName"), var_754fe8c5);
	setuimodelvalue(createuimodel(var_acd2831f, "id"), var_d8138db2);
	setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), 1);
	setuimodelvalue(createuimodel(var_acd2831f, "name"), item.var_a6762160.displayname);
	setuimodelvalue(createuimodel(var_acd2831f, "icon"), item.var_a6762160.icon);
	setuimodelvalue(createuimodel(var_acd2831f, "description"), item.var_a6762160.description);
	setuimodelvalue(var_5a2db7bb, var_b4676aed + 1);
}

/*
	Name: function_b1136fc8
	Namespace: namespace_b376ff3f
	Checksum: 0xAB9A6106
	Offset: 0xDCA8
	Size: 0x332
	Parameters: 2
	Flags: Linked
*/
function function_b1136fc8(localclientnum, item)
{
	if(isdefined(item) && isdefined(item.origin) && isdefined(item.var_a6762160))
	{
		if(isdefined(item.var_a6762160.var_36781d9f))
		{
			playsound(localclientnum, item.var_a6762160.var_36781d9f, item.origin);
			return;
		}
		switch(item.var_a6762160.itemtype)
		{
			case "weapon":
			{
				playsound(localclientnum, #"hash_67fed8a52accbb23", item.origin);
				break;
			}
			case "ammo":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
			case "health":
			{
				playsound(localclientnum, #"hash_4d393a136d0df945", item.origin);
				break;
			}
			case "equipment":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
			case "armor":
			{
				playsound(localclientnum, #"hash_6bd51d5a531ff32", item.origin);
				break;
			}
			case "backpack":
			{
				playsound(localclientnum, #"hash_60e9138ddc9660ed", item.origin);
				break;
			}
			case "attachment":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
			case "quest":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
			case "generic":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
			case "cash":
			{
				playsound(localclientnum, #"hash_24fef443bbac697c", item.origin);
				break;
			}
		}
	}
}

/*
	Name: function_31868137
	Namespace: namespace_b376ff3f
	Checksum: 0x113C832C
	Offset: 0xDFE8
	Size: 0x332
	Parameters: 2
	Flags: Linked
*/
function function_31868137(localclientnum, item)
{
	if(isdefined(item) && isdefined(item.origin) && isdefined(item.var_a6762160))
	{
		if(isdefined(item.var_a6762160.pickupsound))
		{
			playsound(localclientnum, item.var_a6762160.pickupsound, item.origin);
			return;
		}
		switch(item.var_a6762160.itemtype)
		{
			case "weapon":
			{
				playsound(localclientnum, #"hash_62fabedcce13774c", item.origin);
				break;
			}
			case "ammo":
			{
				playsound(localclientnum, #"hash_36c9bf9c68a692f6", item.origin);
				break;
			}
			case "health":
			{
				playsound(localclientnum, #"hash_7cb9f9cf7068ccee", item.origin);
				break;
			}
			case "equipment":
			{
				playsound(localclientnum, #"hash_615c575c66ed8695", item.origin);
				break;
			}
			case "armor":
			{
				playsound(localclientnum, #"hash_2d8e1c5a5387840f", item.origin);
				break;
			}
			case "backpack":
			{
				playsound(localclientnum, #"hash_69949bb7db9ef21e", item.origin);
				break;
			}
			case "attachment":
			{
				playsound(localclientnum, #"hash_48ae9b1190e79fc5", item.origin);
				break;
			}
			case "quest":
			{
				playsound(localclientnum, #"hash_5738a0fcb2e4efca", item.origin);
				break;
			}
			case "generic":
			{
				playsound(localclientnum, #"hash_615c575c66ed8695", item.origin);
				break;
			}
			case "cash":
			{
				playsound(localclientnum, #"hash_615c575c66ed8695", item.origin);
				break;
			}
		}
	}
}

/*
	Name: function_c6ff0aa2
	Namespace: namespace_b376ff3f
	Checksum: 0x2EA5B8BB
	Offset: 0xE328
	Size: 0x53C
	Parameters: 2
	Flags: Linked
*/
function function_c6ff0aa2(localclientnum, var_bd027dd9)
{
	data = item_world::function_a7e98a1a(localclientnum);
	index = item_world::function_73436347(data.inventory.items, var_bd027dd9);
	if(!isdefined(index))
	{
		/#
			println("" + var_bd027dd9 + "");
		#/
		return;
	}
	item = data.inventory.items[index];
	isweapon = isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"weapon";
	var_53aa3063 = isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"generic";
	var_ac3edb34 = item.var_a6762160;
	if(isdefined(item.endtime))
	{
		consumeditem = function_85645978(data, item);
		if(isdefined(consumeditem))
		{
			var_ee0e9af9 = [];
			for(index = 0; index < 10; index++)
			{
				var_b619c089 = data.inventory.items[index];
				if(!isdefined(var_b619c089.endtime))
				{
					continue;
				}
				if(var_b619c089.var_a6762160.name == item.var_a6762160.name)
				{
					var_ee0e9af9[var_ee0e9af9.size] = var_b619c089;
				}
			}
			remaining = consumeditem.endtime - gettime();
			consumeditem.endtime = consumeditem.endtime - remaining / var_ee0e9af9.size;
			for(index = 0; index < var_ee0e9af9.size; index++)
			{
				var_b619c089 = var_ee0e9af9[index];
				var_b619c089.starttime = consumeditem.starttime;
				var_b619c089.endtime = consumeditem.endtime;
			}
		}
	}
	function_1a99656a(localclientnum, item, 32767, 32767, 0, 0, 0, 1, 0, 0);
	player = function_27673a7(localclientnum);
	if(player.weapon.name == #"none" || player.weapon.name == #"bare_hands")
	{
		var_a4250c2b = player function_d768ea30(localclientnum);
		if(isdefined(var_a4250c2b) && var_a4250c2b == index)
		{
			primaryweapons = player getweaponslistprimaries();
			nextweapon = level.weaponbasemeleeheld;
			foreach(weapon in primaryweapons)
			{
				if(weapon !== player.currentweapon)
				{
					nextweapon = weapon;
					break;
				}
			}
			var_a3eec6f2 = spawnstruct();
			var_a3eec6f2.localclientnum = localclientnum;
			var_a3eec6f2.weapon = nextweapon;
			player function_6231c19(var_a3eec6f2);
		}
	}
	if(index == 13)
	{
		function_687852e(localclientnum, var_bd027dd9);
	}
	if(isweapon)
	{
		function_c9764f6d(localclientnum);
		function_ce628f27(localclientnum);
	}
	else if(var_53aa3063)
	{
		function_9f5d2dc8(localclientnum);
	}
}

/*
	Name: function_8063170
	Namespace: namespace_b376ff3f
	Checksum: 0x856C9C6C
	Offset: 0xE870
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function function_8063170(var_b619c089, equipped)
{
	if(!isdefined(var_b619c089) || !isdefined(var_b619c089.var_a6762160))
	{
		return;
	}
	if(var_b619c089.var_a6762160.itemtype === #"hash_56d6621e6c4caf07")
	{
		return;
	}
	if(var_b619c089.var_a6762160.itemtype === #"attachment" || var_b619c089.var_a6762160.itemtype === #"weapon")
	{
		availableaction = var_b619c089.availableaction;
	}
	else
	{
		availableaction = var_b619c089.availableaction && !equipped;
	}
	setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "availableAction"), availableaction);
}

/*
	Name: function_26c87da8
	Namespace: namespace_b376ff3f
	Checksum: 0xC039D53A
	Offset: 0xE9A0
	Size: 0x33C
	Parameters: 3
	Flags: Linked
*/
function function_26c87da8(localclientnum, var_c9293a27, var_8f194e5a)
{
	/#
		assert(isdefined(var_c9293a27) && isdefined(var_8f194e5a));
	#/
	if(var_c9293a27 == var_8f194e5a)
	{
		return;
	}
	data = item_world::function_a7e98a1a(localclientnum);
	var_48e276d5 = data.inventory.items[var_c9293a27];
	var_47684cd2 = data.inventory.items[var_8f194e5a];
	var_23501832 = var_48e276d5.var_bd027dd9;
	var_a2dd129a = var_48e276d5.id;
	var_b208c7e1 = var_48e276d5.var_a6762160;
	var_3907299e = var_48e276d5.count;
	var_57b0c2f = var_48e276d5.availableaction;
	var_9269cd0a = var_47684cd2.var_bd027dd9;
	var_d3a45360 = var_47684cd2.id;
	var_ec763bb2 = var_47684cd2.var_a6762160;
	var_532f304 = var_47684cd2.count;
	var_ad138826 = var_47684cd2.availableaction;
	player = function_27673a7(localclientnum);
	player function_1a99656a(localclientnum, var_47684cd2, (var_23501832 != 32767 ? namespace_ad5a0cd6::function_970b8d86(player, var_8f194e5a) : 32767), var_a2dd129a, var_3907299e, function_bba770de(localclientnum, var_b208c7e1), var_57b0c2f, undefined, 1);
	player function_1a99656a(localclientnum, var_48e276d5, (var_9269cd0a != 32767 ? namespace_ad5a0cd6::function_970b8d86(player, var_c9293a27) : 32767), var_d3a45360, var_532f304, function_bba770de(localclientnum, var_ec763bb2), var_ad138826, undefined, 1);
	function_442857e2(localclientnum, var_ec763bb2);
	function_442857e2(localclientnum, var_b208c7e1);
	function_ce628f27(localclientnum);
	var_a4250c2b = player function_d768ea30(localclientnum);
	function_deddbdf0(localclientnum, var_a4250c2b);
}

/*
	Name: function_687852e
	Namespace: namespace_b376ff3f
	Checksum: 0x5CD94FC3
	Offset: 0xECE8
	Size: 0x17C
	Parameters: 2
	Flags: Linked
*/
function function_687852e(localclientnum, var_bd027dd9)
{
	data = item_world::function_a7e98a1a(localclientnum);
	data.inventory.var_7658cbec = 0;
	if(data.inventory.var_c212de25 == 10)
	{
		for(index = 5; index < 10; index++)
		{
			var_b619c089 = data.inventory.items[index];
			setuimodelvalue(createuimodel(var_b619c089.var_e4130a92, "disabled"), 1);
		}
		data.inventory.var_c212de25 = 5;
		var_dcb56aa8 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
		setuimodelvalue(createuimodel(var_dcb56aa8, "count"), data.inventory.var_c212de25);
	}
}

/*
	Name: function_fa372100
	Namespace: namespace_b376ff3f
	Checksum: 0x473035F8
	Offset: 0xEE70
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_fa372100(localclientnum, var_bd027dd9)
{
	data = item_world::function_a7e98a1a(localclientnum);
	foreach(var_b619c089 in data.inventory.items)
	{
		if(var_b619c089.var_bd027dd9 === var_bd027dd9)
		{
			function_8063170(var_b619c089, 0);
			break;
		}
	}
}

/*
	Name: function_6490a112
	Namespace: namespace_b376ff3f
	Checksum: 0x5C1068C8
	Offset: 0xEF50
	Size: 0x1C4
	Parameters: 3
	Flags: Linked
*/
function function_6490a112(localclientnum, var_bd027dd9, count)
{
	data = item_world::function_a7e98a1a(localclientnum);
	player = function_27673a7(localclientnum);
	foreach(var_14f7206c, var_b619c089 in data.inventory.items)
	{
		if(var_b619c089.var_bd027dd9 === var_bd027dd9)
		{
			var_338e8597 = (isdefined(var_b619c089.count) ? var_b619c089.count : 0);
			totalcount = function_bba770de(localclientnum, var_b619c089.var_a6762160);
			totalcount = totalcount + max(0, count - var_338e8597);
			function_1a99656a(localclientnum, var_b619c089, var_b619c089.var_bd027dd9, var_b619c089.id, count, totalcount, var_b619c089.availableaction);
			function_8063170(var_b619c089, function_6d9d9cd7(var_14f7206c));
			break;
		}
	}
}

/*
	Name: function_9116bb0e
	Namespace: namespace_b376ff3f
	Checksum: 0xB883D5F5
	Offset: 0xF120
	Size: 0xE84
	Parameters: 2
	Flags: Linked
*/
function function_9116bb0e(localclientnum, closed = 0)
{
	/#
		assert(isplayer(self));
	#/
	var_8040e225 = item_world::function_a7e98a1a(localclientnum);
	var_6e2c91d0 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
	var_cc67e8b = createuimodel(var_6e2c91d0, "count");
	if(isdefined(var_8040e225.var_f0f7e918) && !closed)
	{
		arrayremovevalue(var_8040e225.var_f0f7e918, undefined, 0);
		foreach(i, itemdef in var_8040e225.var_f0f7e918)
		{
			var_23c48bd3 = createuimodel(var_6e2c91d0, "item" + i);
			setuimodelvalue(createuimodel(var_23c48bd3, "id"), itemdef.var_bd027dd9);
			if(!isdefined(itemdef.var_a6762160))
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "inventoryFull"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "icon"), #"blacktransparent");
				setuimodelvalue(createuimodel(var_23c48bd3, "rarity"), "none");
				setuimodelvalue(createuimodel(var_23c48bd3, "name"), #"");
				setuimodelvalue(createuimodel(var_23c48bd3, "claimsInventorySlot"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "stackCount"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "stashStackSize"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "armorTier"), 1);
				setuimodelvalue(createuimodel(var_23c48bd3, "armor"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "armorMax"), 1);
				setuimodelvalue(createuimodel(var_23c48bd3, "itemtype"), "none");
				setuimodelvalue(createuimodel(var_23c48bd3, "specialItem"), 0);
				if(ispc())
				{
					setuimodelvalue(createuimodel(var_23c48bd3, "description"), #"");
				}
				continue;
			}
			setuimodelvalue(createuimodel(var_23c48bd3, "itemtype"), itemdef.var_a6762160.itemtype);
			if(itemdef.var_a6762160.itemtype === #"ammo")
			{
				var_75c2784 = self function_e106cbe9(localclientnum, itemdef);
				setuimodelvalue(createuimodel(var_23c48bd3, "inventoryFull"), !var_75c2784);
			}
			else if(itemdef.var_a6762160.itemtype === #"hash_56d6621e6c4caf07")
			{
				var_75c2784 = self function_ad4c6116(localclientnum, itemdef.var_a6762160);
				setuimodelvalue(createuimodel(var_23c48bd3, "inventoryFull"), !var_75c2784);
			}
			else
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "inventoryFull"), 0);
			}
			if(ispc())
			{
				description = (isdefined(itemdef.var_a6762160.var_a6762160.description) ? itemdef.var_a6762160.description : #"");
				if(description == #"" && isdefined(itemdef.var_a6762160.weapon))
				{
					itemindex = getitemindexfromref(itemdef.var_a6762160.weapon.name);
					var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);
					if(isdefined(var_97dcd0a5) && isdefined(var_97dcd0a5.description))
					{
						description = var_97dcd0a5.description;
					}
				}
				setuimodelvalue(createuimodel(var_23c48bd3, "description"), (isdefined(description) ? description : #""));
			}
			pickupicon = (isdefined(itemdef.var_a6762160.var_a6762160.pickupicon) ? itemdef.var_a6762160.pickupicon : itemdef.var_a6762160.icon);
			var_9507cf45 = (isdefined(itemdef.var_a6762160.var_a6762160.var_9507cf45) ? itemdef.var_a6762160.var_9507cf45 : pickupicon);
			setuimodelvalue(createuimodel(var_23c48bd3, "icon"), (isdefined(var_9507cf45) ? var_9507cf45 : #"blacktransparent"));
			setuimodelvalue(createuimodel(var_23c48bd3, "rarity"), itemdef.var_a6762160.rarity);
			setuimodelvalue(createuimodel(var_23c48bd3, "name"), item_world::get_item_name(itemdef.var_a6762160));
			setuimodelvalue(createuimodel(var_23c48bd3, "claimsInventorySlot"), function_7146ceb2(localclientnum, itemdef.var_a6762160) && !function_a4a6f064(localclientnum, itemdef.var_a6762160));
			setuimodelvalue(createuimodel(var_23c48bd3, "stackCount"), 0);
			setuimodelvalue(createuimodel(var_23c48bd3, "stashStackSize"), 0);
			if(itemdef.var_a6762160.itemtype === #"armor")
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "armorTier"), itemdef.var_a6762160.armortier);
				setuimodelvalue(createuimodel(var_23c48bd3, "armor"), (isdefined((isdefined(itemdef.amount) ? itemdef.amount : itemdef.var_a6762160.amount)) ? (isdefined(itemdef.amount) ? itemdef.amount : itemdef.var_a6762160.amount) : 0));
				setuimodelvalue(createuimodel(var_23c48bd3, "armorMax"), (isdefined(itemdef.var_a6762160.amount) ? itemdef.var_a6762160.amount : 1));
			}
			else
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "armorTier"), 1);
				setuimodelvalue(createuimodel(var_23c48bd3, "armor"), 0);
				setuimodelvalue(createuimodel(var_23c48bd3, "armorMax"), 1);
			}
			if(isdefined(itemdef.var_a6762160.stackable) && itemdef.var_a6762160.stackable || itemdef.var_a6762160.itemtype === #"ammo")
			{
				if(itemdef.var_a6762160.itemtype === #"ammo" || isstruct(itemdef) && !isdefined(itemdef.amount))
				{
					setuimodelvalue(createuimodel(var_23c48bd3, "stackCount"), (isdefined(itemdef.var_a6762160.amount) ? itemdef.var_a6762160.amount : 1));
				}
				else
				{
					loc_0000FDE4:
					setuimodelvalue(createuimodel(var_23c48bd3, "stackCount"), int(max((isdefined(itemdef.amount) ? itemdef.amount : 1), (isdefined(itemdef.count) ? itemdef.count : 1))));
				}
			}
			else
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "stashStackSize"), (isdefined(itemdef.count) ? itemdef.count : 1));
			}
			if(isdefined(itemdef.var_41f13734) && itemdef.var_41f13734)
			{
				setuimodelvalue(createuimodel(var_23c48bd3, "specialItem"), 1);
			}
		}
		currentcount = getuimodelvalue(var_cc67e8b);
		setuimodelvalue(var_cc67e8b, var_8040e225.var_f0f7e918.size);
		var_aaa1adcb = createuimodel(var_6e2c91d0, "forceNotifyAmmoList");
		function_9a227103(var_aaa1adcb);
	}
	else
	{
		setuimodelvalue(var_cc67e8b, 0);
	}
}

