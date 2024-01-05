// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\sensor_dart.gsc;
#using scripts\mp_common\player\player_loadout.gsc;
#using scripts\mp_common\item_world_util.gsc;
#using scripts\mp_common\item_world.gsc;
#using script_6b993fdc7adc35ec;
#using scripts\mp_common\item_drop.gsc;
#using scripts\mp_common\armor.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using script_67c87580908a0a00;
#using scripts\abilities\gadgets\gadget_health_regen.gsc;
#using scripts\abilities\ability_player.gsc;

#namespace item_inventory;

/*
	Name: __init__system__
	Namespace: item_inventory
	Checksum: 0xA5EE0F7C
	Offset: 0x550
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"item_inventory", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: item_inventory
	Checksum: 0x12678C07
	Offset: 0x5A0
	Size: 0x212
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	level.var_67f4fd41 = &function_38d1ea04;
	level.specialty_quieter_complete = &function_bdc03d88;
	level.var_cf16ff75 = &function_a2162b3b;
	level.var_6ec46eeb = &function_d85c5382;
	level.sensor_darts = [];
	clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 17000, 3, "int");
	clientfield::register_clientuimodel("hudItems.healthItemstackCount", 5000, 8, "int", 0);
	clientfield::register_clientuimodel("hudItems.equipmentStackCount", 5000, 8, "int", 0);
	ability_player::register_gadget_activation_callbacks(23, &_gadget_health_regen_on, &_gadget_health_regen_off);
	ability_player::register_gadget_primed_callbacks(23, &function_d116a346);
	level.var_d3b4a4db = &function_64d3e50;
	level thread function_d2f05352();
	level.var_5c14d2e6 = &function_3f7ef88;
	level.var_317fb13c = &function_3f7ef88;
	if(!isdefined(level.var_4cf92425))
	{
		level.var_4cf92425 = [];
	}
}

/*
	Name: function_64d3e50
	Namespace: item_inventory
	Checksum: 0x9A0CBDD0
	Offset: 0x7C0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_64d3e50()
{
	if(!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items) || !isdefined(self.inventory.items[10]))
	{
		return;
	}
	var_bd027dd9 = self.inventory.items[10].var_bd027dd9;
	if(isdefined(var_bd027dd9) && var_bd027dd9 != 32767)
	{
		item = get_inventory_item(var_bd027dd9);
		self thread use_inventory_item(var_bd027dd9, 1, 0);
	}
}

/*
	Name: function_299d2131
	Namespace: item_inventory
	Checksum: 0x81824B20
	Offset: 0x8A0
	Size: 0x124
	Parameters: 3
	Flags: Linked
*/
function function_299d2131(maxhealth, var_5af5a1bf, var_4465ef1e)
{
	self endon(#"death");
	while(self.heal.enabled)
	{
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	self.var_44d52546 = 1;
	self player::function_9080887a(maxhealth);
	self.heal.var_bc840360 = math::clamp(var_5af5a1bf + self.health, 0, maxhealth);
	self.heal.rate = var_5af5a1bf / var_4465ef1e;
	self gadget_health_regen::function_ddfdddb1();
	self gadget_health_regen::function_1e02d458();
	self callback::function_d8abfc3d(#"done_healing", &function_4a257174);
}

/*
	Name: function_4a257174
	Namespace: item_inventory
	Checksum: 0x852E15A5
	Offset: 0x9D0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_4a257174()
{
	if(isdefined(self))
	{
		self callback::function_52ac9652(#"done_healing", &function_4a257174);
		self.var_44d52546 = undefined;
		gadget_health_regen::function_7993d50e();
	}
}

/*
	Name: function_fc04b237
	Namespace: item_inventory
	Checksum: 0x94FA9792
	Offset: 0xA38
	Size: 0x252
	Parameters: 2
	Flags: Linked
*/
function function_fc04b237(weapon, weaponoptions)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(weapon));
	#/
	if(!isdefined(weaponoptions))
	{
		return;
	}
	if(!isdefined(self.pers) || !isdefined(self.pers[#"activecamo"]))
	{
		return weaponoptions;
	}
	camoindex = getcamoindex(weaponoptions);
	activecamoname = getactivecamo(camoindex);
	if(!isdefined(activecamoname) || !isdefined(self.pers[#"activecamo"][activecamoname]))
	{
		return weaponoptions;
	}
	activecamo = self.pers[#"activecamo"][activecamoname];
	if(!isdefined(activecamo) || !isdefined(activecamo.var_dd54a13b))
	{
		return weaponoptions;
	}
	var_28c04c49 = activecamo::function_c14cb514(weapon);
	weaponstate = activecamo.var_dd54a13b[var_28c04c49];
	if(!isdefined(weaponstate))
	{
		return weaponoptions;
	}
	stagenum = weaponstate.stagenum;
	if(!isdefined(stagenum))
	{
		return weaponoptions;
	}
	stage = activecamo.stages[stagenum];
	var_7df02232 = stage.var_19b6044e;
	if(!isdefined(var_7df02232))
	{
		return weaponoptions;
	}
	buildkitweapon = activecamo::function_385ef18d(weapon);
	weaponoptions = self getbuildkitweaponoptions(buildkitweapon, var_7df02232, stagenum);
	return weaponoptions;
}

/*
	Name: function_a2162b3b
	Namespace: item_inventory
	Checksum: 0x539C9C06
	Offset: 0xC98
	Size: 0xB2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a2162b3b(deployableweapon)
{
	if(isplayer(self))
	{
		if(deployableweapon === self.var_cc111ddc)
		{
			self.var_cc111ddc = undefined;
		}
		if(deployableweapon === self.var_8181d952)
		{
			self.var_8181d952 = undefined;
		}
		if(deployableweapon === self.var_cd3bc45b)
		{
			self.var_cd3bc45b = undefined;
		}
		if(deployableweapon === self.var_d0015cb3)
		{
			self.var_d0015cb3 = undefined;
		}
		if(deployableweapon === self.var_14c391cc)
		{
			self.var_14c391cc = undefined;
		}
	}
}

/*
	Name: function_d62822d5
	Namespace: item_inventory
	Checksum: 0x227C52F4
	Offset: 0xD58
	Size: 0x2E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d62822d5()
{
	self.var_cc111ddc = undefined;
	self.var_8181d952 = undefined;
	self.var_cd3bc45b = undefined;
	self.var_d0015cb3 = undefined;
	self.var_14c391cc = undefined;
}

/*
	Name: function_76646dad
	Namespace: item_inventory
	Checksum: 0xAE36013D
	Offset: 0xD90
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
function private function_76646dad(weapon)
{
	if(weapon.name == #"basketball")
	{
		return 1;
	}
	slot = self gadgetgetslot(weapon);
	return slot == 0;
}

/*
	Name: function_e72d56f9
	Namespace: item_inventory
	Checksum: 0x96057029
	Offset: 0xDF0
	Size: 0x124
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e72d56f9(weapon, usecount)
{
	/#
		assert(isdefined(weapon));
	#/
	if(isplayer(self) && isalive(self))
	{
		self function_d62822d5();
		var_bd027dd9 = self function_a33744de(weapon);
		if(var_bd027dd9 != 32767)
		{
			self use_inventory_item(var_bd027dd9, usecount, 0);
			item = self get_inventory_item(var_bd027dd9);
			if(isdefined(item) && item.count > 0)
			{
				self function_c6be9f7f(weapon, item.count);
			}
		}
	}
}

/*
	Name: function_9e4c68e2
	Namespace: item_inventory
	Checksum: 0x315A8FC0
	Offset: 0xF20
	Size: 0x82
	Parameters: 1
	Flags: Private, Event
*/
event private function_9e4c68e2(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_cd3bc45b = eventstruct.weapon;
	}
}

/*
	Name: function_2f677e9d
	Namespace: item_inventory
	Checksum: 0xFAC1EF84
	Offset: 0xFB0
	Size: 0x82
	Parameters: 1
	Flags: Event
*/
event function_2f677e9d(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_d0015cb3 = eventstruct.weapon;
	}
}

/*
	Name: function_4776caf4
	Namespace: item_inventory
	Checksum: 0x33E1C57D
	Offset: 0x1040
	Size: 0x7BC
	Parameters: 1
	Flags: Private, Event
*/
event private function_4776caf4(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_8181d952 = eventstruct.weapon;
		var_994e5c9a = 0;
		equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"eq_grapple", #"dart", #"eq_hawk", #"ultimate_turret");
		foreach(equipmentname in equipments)
		{
			if(eventstruct.weapon.name == equipmentname)
			{
				var_994e5c9a = 1;
				break;
			}
		}
		var_aec6fa7f = undefined;
		if(!var_994e5c9a)
		{
			weapon = eventstruct.weapon;
			var_bd027dd9 = self function_a33744de(weapon);
			if(var_bd027dd9 != 32767)
			{
				item = self get_inventory_item(var_bd027dd9);
				if(isdefined(item) && item.amount > 0)
				{
					var_aec6fa7f = item.amount;
				}
			}
			self function_e72d56f9(weapon, 1);
		}
		weaponname = eventstruct.weapon.name;
		if(weaponname == #"trophy_system" || weaponname == #"hatchet" || weaponname == #"tomahawk_t8" || weaponname == #"basketball" || weaponname == #"cymbal_monkey")
		{
			if(isdefined(eventstruct.projectile))
			{
				dropitem = eventstruct.projectile;
				dropitem endon(#"death");
				if(weaponname == #"basketball")
				{
					dropitem setinvisibletoplayer(self);
					wait(0.25);
					if(isdefined(self))
					{
						dropitem setvisibletoplayer(self);
					}
				}
				if(weaponname == #"cymbal_monkey")
				{
					waitframe(1);
					dropitem = dropitem.var_bdd70f6a;
				}
				if(weaponname == #"trophy_system")
				{
					if(isdefined(item))
					{
						self._trophy_system_ammo1 = var_aec6fa7f;
					}
				}
				wait(0.5);
				if(!isdefined(dropitem))
				{
					return;
				}
				itemspawnpoint = function_d08934c6(weaponname);
				if(!isdefined(itemspawnpoint))
				{
					return;
				}
				/#
					assert(itemspawnpoint.id < 1024);
				#/
				dropitem.id = itemspawnpoint.id;
				dropitem.var_bd027dd9 = item_world_util::function_1f0def85(dropitem);
				dropitem.var_a6762160 = itemspawnpoint.var_a6762160;
				dropitem.hidetime = 0;
				dropitem.amount = (eventstruct.weapon.weapon.name == #"basketball" ? 1 : 0);
				dropitem.count = 1;
				dropitem clientfield::set("dynamic_item_drop", 1);
				dropitem function_46d7f921(dropitem.id);
				level.item_spawn_drops[dropitem.var_bd027dd9] = dropitem;
			}
		}
		else if(weaponname == #"waterballoon")
		{
			if(isdefined(eventstruct.projectile))
			{
				camoindex = getcamoindex(self getweaponoptions(eventstruct.weapon));
				var_f94ce554 = array(111, 112, 113, 114, 115, 116);
				var_af7d7388 = array(#"hash_7306b72d120049f8", #"hash_27ae7cb403d5365b", #"hash_6add258ae958d31c", #"hash_6eb8f7ceb4627d9f", #"hash_228bf15c70137b61", #"hash_10c0ee53a36783e9");
				/#
					assert(var_f94ce554.size == var_af7d7388.size);
				#/
				for(index = 0; index < var_f94ce554.size && index < var_af7d7388.size; index++)
				{
					if(var_f94ce554[index] == camoindex)
					{
						eventstruct.projectile setmodel(var_af7d7388[index]);
						arrayremoveindex(var_f94ce554, index, 0);
						break;
					}
				}
				wait(0.5);
				if(isdefined(self) && self hasweapon(eventstruct.weapon, 1))
				{
					weaponoptions = self calcweaponoptions(var_f94ce554[randomintrange(0, var_f94ce554.size)], 0, 0);
					self updateweaponoptions(eventstruct.weapon, weaponoptions);
				}
			}
		}
	}
}

/*
	Name: function_f5883bb1
	Namespace: item_inventory
	Checksum: 0x52B806DB
	Offset: 0x1808
	Size: 0xAA
	Parameters: 1
	Flags: Private, Event
*/
event private function_f5883bb1(eventstruct)
{
	self.next_weapon = undefined;
	if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self))
	{
		if(eventstruct.weapon.isprimary && eventstruct.weapon != eventstruct.last_weapon)
		{
			self.next_weapon = eventstruct.weapon;
		}
	}
}

/*
	Name: function_a8c42ee4
	Namespace: item_inventory
	Checksum: 0xBD907045
	Offset: 0x18C0
	Size: 0x20A
	Parameters: 1
	Flags: Private, Event
*/
event private function_a8c42ee4(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self))
	{
		if(isdefined(self.var_8181d952))
		{
			weapon = self.var_8181d952;
			equipments = array();
			foreach(equipmentname in equipments)
			{
				if(weapon.name == equipmentname)
				{
					self function_e72d56f9(weapon, 1);
					return;
				}
			}
		}
		if(isdefined(self.var_d0015cb3))
		{
			weapon = self.var_d0015cb3;
			equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"ultimate_turret");
			foreach(equipmentname in equipments)
			{
				if(weapon.name == equipmentname)
				{
					self function_e72d56f9(weapon, 1);
					return;
				}
			}
		}
	}
}

/*
	Name: gadget_primed_callback
	Namespace: item_inventory
	Checksum: 0xDCE02222
	Offset: 0x1AD8
	Size: 0xB2
	Parameters: 1
	Flags: Event
*/
event gadget_primed_callback(eventstruct)
{
	player = eventstruct.entity;
	if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		function_d62822d5();
		player.var_cc111ddc = eventstruct.weapon;
	}
}

/*
	Name: gadget_on_callback
	Namespace: item_inventory
	Checksum: 0xC4E89291
	Offset: 0x1B98
	Size: 0x188
	Parameters: 1
	Flags: Event
*/
event gadget_on_callback(eventstruct)
{
	player = eventstruct.entity;
	if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		equipments = array(#"eq_grapple", #"dart", #"eq_hawk");
		foreach(equipmentname in equipments)
		{
			if(eventstruct.weapon.name == equipmentname)
			{
				weapon = eventstruct.weapon;
				player function_e72d56f9(weapon, 1);
			}
		}
	}
}

/*
	Name: function_40d8d1ec
	Namespace: item_inventory
	Checksum: 0x668EC505
	Offset: 0x1D28
	Size: 0x9E
	Parameters: 1
	Flags: Event
*/
event function_40d8d1ec(eventstruct)
{
	player = eventstruct.entity;
	if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		player.var_14c391cc = eventstruct.weapon;
	}
}

/*
	Name: function_2aa4e6cf
	Namespace: item_inventory
	Checksum: 0x6FA26A9E
	Offset: 0x1DD0
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event function_2aa4e6cf(eventstruct)
{
	player = self;
	if(sessionmodeiswarzonegame() && isplayer(player) && isalive(player))
	{
		if(eventstruct.seat_index == 0 && player function_2cceca7b())
		{
			player forceoffhandend();
		}
	}
}

/*
	Name: function_38d1ea04
	Namespace: item_inventory
	Checksum: 0x568F3FAD
	Offset: 0x1E78
	Size: 0x194
	Parameters: 0
	Flags: Linked, Private
*/
function private function_38d1ea04()
{
	if(isplayer(self) && isdefined(self.inventory))
	{
		inventoryitem = self.inventory.items[11];
		if(isdefined(inventoryitem) && isdefined(inventoryitem.var_a6762160))
		{
			armorshards = inventoryitem.var_a6762160.armorshards;
		}
		if(isdefined(armorshards) && armorshards > 0)
		{
			armorshard = function_4ba8fde(#"armor_shard_item");
			if(isdefined(armorshard))
			{
				var_7841fe31 = self give_inventory_item(armorshard, armorshards, undefined, 16);
				if(var_7841fe31 > 0)
				{
					function_d7944517(armorshard.id, undefined, var_7841fe31);
				}
			}
		}
		if(inventoryitem.var_bd027dd9 != 32767 && inventoryitem.var_a6762160.itemtype == #"armor")
		{
			self remove_inventory_item(inventoryitem.var_bd027dd9);
		}
	}
}

/*
	Name: function_bdc03d88
	Namespace: item_inventory
	Checksum: 0x85D6BBD9
	Offset: 0x2018
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_bdc03d88()
{
	if(isplayer(self) && isdefined(self.inventory))
	{
		inventoryitem = self.inventory.items[11];
		if(inventoryitem.var_bd027dd9 != 32767 && inventoryitem.var_a6762160.itemtype == #"armor")
		{
			inventoryitem.amount = armor::get_armor();
			if(function_27cd171b(inventoryitem))
			{
				self setperk(#"hash_4df21972dd2a3a87");
			}
		}
	}
}

/*
	Name: function_434d0c2b
	Namespace: item_inventory
	Checksum: 0xBEF2BBF4
	Offset: 0x2100
	Size: 0x2CC
	Parameters: 3
	Flags: Linked, Private
*/
function private function_434d0c2b(itemtype, var_da328e7b, var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(ishash(itemtype));
	#/
	/#
		assert(isarray(var_da328e7b));
	#/
	items = [];
	var_e3c48c83 = item_world_util::get_itemtype(var_ab9610ad);
	foreach(item in self.inventory.items)
	{
		if(item.id == 32767)
		{
			continue;
		}
		var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
		if(var_e3c48c83 === var_b74300d3)
		{
			return item;
		}
		if(item.var_a6762160.itemtype == itemtype)
		{
			if(isdefined(items[var_b74300d3]))
			{
				if(item.count > items[var_b74300d3].count)
				{
					items[var_b74300d3] = item;
				}
				continue;
			}
			items[var_b74300d3] = item;
		}
	}
	foreach(var_b74300d3 in var_da328e7b)
	{
		if(isdefined(items[var_b74300d3]))
		{
			return items[var_b74300d3];
		}
	}
	foreach(item in items)
	{
		if(isdefined(item))
		{
			return item;
		}
	}
}

/*
	Name: _cycle_item
	Namespace: item_inventory
	Checksum: 0x658930F9
	Offset: 0x23D8
	Size: 0x2CC
	Parameters: 3
	Flags: Linked, Private
*/
function private _cycle_item(itemtype, var_da328e7b, var_bcc2655a)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(ishash(itemtype));
	#/
	/#
		assert(isarray(var_da328e7b));
	#/
	if(!isdefined(var_bcc2655a))
	{
		return;
	}
	items = [];
	var_c7837092 = item_world_util::get_itemtype(var_bcc2655a);
	foreach(item in self.inventory.items)
	{
		if(item.id == 32767)
		{
			continue;
		}
		var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
		if(item.var_a6762160.itemtype == itemtype)
		{
			if(isdefined(items[var_b74300d3]))
			{
				if(item.count > items[var_b74300d3].count)
				{
					items[var_b74300d3] = item;
				}
				continue;
			}
			items[var_b74300d3] = item;
		}
	}
	for(currentindex = 0; currentindex < var_da328e7b.size; currentindex++)
	{
		if(var_da328e7b[currentindex] == var_c7837092)
		{
			break;
		}
	}
	for(index = currentindex + 1; index < var_da328e7b.size; index++)
	{
		var_b74300d3 = var_da328e7b[index];
		if(isdefined(items[var_b74300d3]))
		{
			return items[var_b74300d3];
		}
	}
	if(currentindex < var_da328e7b.size)
	{
		for(index = 0; index < currentindex; index++)
		{
			var_b74300d3 = var_da328e7b[index];
			if(isdefined(items[var_b74300d3]))
			{
				return items[var_b74300d3];
			}
		}
	}
}

/*
	Name: function_9da31874
	Namespace: item_inventory
	Checksum: 0x4A9525AF
	Offset: 0x26B0
	Size: 0x1E4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9da31874(itemtype)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(ishash(itemtype));
	#/
	items = [];
	foreach(index, item in self.inventory.items)
	{
		if(index >= 10)
		{
			break;
		}
		if(item.id == 32767 || item.var_a6762160.itemtype != itemtype)
		{
			continue;
		}
		items[items.size] = item;
	}
	currentindex = (isdefined(self.inventory.var_a0290b96[itemtype]) ? self.inventory.var_a0290b96[itemtype] : 0);
	if(currentindex < 0)
	{
		currentindex = 0;
	}
	else if(currentindex > items.size)
	{
		currentindex = items.size;
	}
	if(items.size > 0)
	{
		currentindex = (currentindex + 1) % items.size;
		self.inventory.var_a0290b96[itemtype] = currentindex;
	}
	return items[currentindex];
}

/*
	Name: function_283a29c8
	Namespace: item_inventory
	Checksum: 0x2A50DC8A
	Offset: 0x28A0
	Size: 0x2C4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_283a29c8(var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(function_fe402108())
	{
		return;
	}
	item = function_434d0c2b(#"equipment", array(#"frag_grenade_wz_item", #"hash_3074c41bb205ed8c", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"), var_ab9610ad);
	if(isdefined(item))
	{
		equip_equipment(item);
	}
}

/*
	Name: function_2e10e66e
	Namespace: item_inventory
	Checksum: 0x90AFECE1
	Offset: 0x2B70
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2e10e66e(var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(function_fe402108())
	{
		return;
	}
	item = function_434d0c2b(#"backpack", array(#"hash_7c3701ba5f0879c2"), var_ab9610ad);
	if(isdefined(item))
	{
		equip_backpack(item);
	}
}

/*
	Name: function_a7d62e18
	Namespace: item_inventory
	Checksum: 0x293B957
	Offset: 0x2C40
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a7d62e18(var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(function_fe402108())
	{
		return;
	}
	item = function_434d0c2b(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad"), var_ab9610ad);
	if(isdefined(item))
	{
		equip_health(item);
	}
}

/*
	Name: function_9d805044
	Namespace: item_inventory
	Checksum: 0xE6C59CF4
	Offset: 0x2D40
	Size: 0x13A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9d805044(itemtype, var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstring(itemtype) || ishash(itemtype));
	#/
	if(function_fe402108())
	{
		return;
	}
	switch(itemtype)
	{
		case "backpack":
		{
			function_2e10e66e(var_ab9610ad);
			break;
		}
		case "equipment":
		{
			function_283a29c8(var_ab9610ad);
			break;
		}
		case "health":
		{
			function_a7d62e18(var_ab9610ad);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_d08934c6
	Namespace: item_inventory
	Checksum: 0x2419E33D
	Offset: 0x2E88
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d08934c6(equipment)
{
	var_b74300d3 = undefined;
	switch(equipment)
	{
		case "hatchet":
		{
			var_b74300d3 = #"hatchet_wz_item";
			break;
		}
		case "tomahawk_t8":
		{
			var_b74300d3 = #"tomahawk_t8_wz_item";
			break;
		}
		case "basketball":
		{
			var_b74300d3 = #"wz_ball";
			break;
		}
		case "cymbal_monkey":
		{
			var_b74300d3 = #"cymbal_monkey_wz_item";
			break;
		}
		case "trophy_system":
		{
			var_b74300d3 = #"trophy_system_wz_item";
			break;
		}
	}
	if(isdefined(var_b74300d3))
	{
		return function_4ba8fde(var_b74300d3);
	}
}

/*
	Name: function_520b16d6
	Namespace: item_inventory
	Checksum: 0x88322A04
	Offset: 0x2FA0
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_520b16d6()
{
	item = spawnstruct();
	item.amount = 0;
	item.count = 0;
	item.id = 32767;
	item.var_bd027dd9 = 32767;
	item.var_a6762160 = undefined;
	item.var_627c698b = undefined;
	item.weaponoptions = undefined;
	item.charmindex = undefined;
	item.var_2febbde5 = undefined;
	return item;
}

/*
	Name: function_27cd171b
	Namespace: item_inventory
	Checksum: 0xD1C4B1F5
	Offset: 0x3040
	Size: 0x60
	Parameters: 1
	Flags: Linked, Private
*/
function private function_27cd171b(inventoryitem)
{
	if(!isdefined(inventoryitem.amount))
	{
		return 0;
	}
	if(inventoryitem.amount <= 0)
	{
		return 1;
	}
	return (inventoryitem.amount / inventoryitem.var_a6762160.amount) <= 0.5;
}

/*
	Name: function_d85c5382
	Namespace: item_inventory
	Checksum: 0xF2C1F03A
	Offset: 0x30A8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_d85c5382(sensordart, player)
{
	level.sensor_darts[level.sensor_darts.size] = sensordart;
	arrayremovevalue(level.sensor_darts, undefined);
}

/*
	Name: function_d2f05352
	Namespace: item_inventory
	Checksum: 0x610D4CAE
	Offset: 0x3100
	Size: 0x280
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d2f05352()
{
	level endon(#"game_ended");
	while(true)
	{
		players = getplayers();
		time = gettime();
		for(playerindex = 0; playerindex < players.size; playerindex++)
		{
			if(((playerindex + 1) % 15) == 0)
			{
				waitframe(1);
			}
			player = players[playerindex];
			if(!isdefined(player) || player.sessionstate != "playing" || !isalive(player) || !isdefined(player.inventory) || player.inventory.consumed.size <= 0)
			{
				continue;
			}
			consumed = player.inventory.consumed;
			var_1bc7a1b2 = 0;
			i = 0;
			while(i < consumed.size)
			{
				item = consumed[i];
				if(item.endtime <= time)
				{
					arrayremoveindex(consumed, i);
					var_1bc7a1b2 = 1;
				}
				else
				{
					i++;
				}
			}
			if(var_1bc7a1b2)
			{
				player function_6c36ab6b();
			}
			for(index = 0; index < 10; index++)
			{
				item = player.inventory.items[index];
				if(isdefined(item.endtime) && item.endtime <= time)
				{
					player use_inventory_item(item.var_bd027dd9, 1, 0);
				}
			}
		}
		players = undefined;
		waitframe(1);
	}
}

/*
	Name: function_a4413333
	Namespace: item_inventory
	Checksum: 0xE47B86FB
	Offset: 0x3388
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a4413333()
{
	/#
		assert(isplayer(self));
	#/
	healthitem = self.inventory.items[10];
	if(healthitem.var_bd027dd9 !== 32767)
	{
		self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(healthitem.var_a6762160));
	}
	equipmentitem = self.inventory.items[12];
	if(equipmentitem.var_bd027dd9 !== 32767)
	{
		self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(equipmentitem.var_a6762160));
	}
}

/*
	Name: function_6c36ab6b
	Namespace: item_inventory
	Checksum: 0x44B443D6
	Offset: 0x3490
	Size: 0x3E4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6c36ab6b()
{
	self function_e6f9e3cd();
	foreach(item in self.inventory.items)
	{
		var_a6762160 = item.var_a6762160;
		if(isdefined(var_a6762160) && (!(isdefined(var_a6762160.consumable) && var_a6762160.consumable)) && isarray(var_a6762160.talents))
		{
			foreach(var_9de7969b in var_a6762160.talents)
			{
				self function_b5feff95(var_9de7969b.talent);
			}
		}
	}
	foreach(item in self.inventory.consumed)
	{
		var_a6762160 = item.var_a6762160;
		if(isdefined(var_a6762160) && isarray(var_a6762160.talents))
		{
			foreach(var_9de7969b in var_a6762160.talents)
			{
				self function_b5feff95(var_9de7969b.talent);
			}
		}
	}
	if(isdefined(self.class_num))
	{
		self.specialty = self getloadoutperks(self.class_num);
	}
	else
	{
		self.specialty = [];
	}
	self loadout::register_perks();
	armoritem = self.inventory.items[11];
	if(armoritem.var_bd027dd9 != 32767 && armoritem.var_a6762160.itemtype == #"armor")
	{
		if(function_27cd171b(armoritem))
		{
			self setperk(#"hash_4df21972dd2a3a87");
		}
	}
	if((isdefined(getgametypesetting(#"wzheavymetalheroes")) ? getgametypesetting(#"wzheavymetalheroes") : 0))
	{
		self setperk(#"specialty_doublejump");
		self setperk(#"specialty_fallheight");
	}
}

/*
	Name: function_60706bdb
	Namespace: item_inventory
	Checksum: 0xB619EC1C
	Offset: 0x3880
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_60706bdb(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	item = get_inventory_item(var_bd027dd9);
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	if(item.var_a6762160.itemtype == #"weapon")
	{
		weapon = namespace_a0d533d1::function_2b83d3ff(item);
		ammoclip = self getweaponammoclip(weapon);
		item.amount = ammoclip;
	}
}

/*
	Name: function_d7944517
	Namespace: item_inventory
	Checksum: 0x24F6E5B7
	Offset: 0x3978
	Size: 0x19A
	Parameters: 8
	Flags: Linked, Private
*/
function private function_d7944517(itemid, weapon, count, amount, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, attachments = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(item_world_util::function_2c7fc531(itemid));
	#/
	self endon(#"death");
	droppos = var_7cab8e12;
	if(!stashitem)
	{
		forward = anglestoforward(self.angles);
		droppos = (self.origin + (36 * forward)) + vectorscale((0, 0, 1), 10);
	}
	return self item_drop::drop_item(weapon, count, amount, itemid, droppos, (0, randomintrange(0, 360), 0), stashitem, 0, targetname, undefined, attachments);
}

/*
	Name: function_d116a346
	Namespace: item_inventory
	Checksum: 0xFCEA93E9
	Offset: 0x3B20
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_d116a346(slot, weapon)
{
	if(sessionmodeiswarzonegame() && isplayer(self))
	{
		self.var_e42fb511 = weapon;
	}
}

/*
	Name: _gadget_health_regen_on
	Namespace: item_inventory
	Checksum: 0xBE6AA69B
	Offset: 0x3B78
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
function private _gadget_health_regen_on(slot, weapon)
{
	if(sessionmodeiswarzonegame() && isplayer(self))
	{
		self.var_d6cd7d80 = weapon;
	}
}

/*
	Name: _gadget_health_regen_off
	Namespace: item_inventory
	Checksum: 0xC7ECE76C
	Offset: 0x3BD0
	Size: 0x52
	Parameters: 2
	Flags: Linked, Private
*/
function private _gadget_health_regen_off(slot, weapon)
{
	if(sessionmodeiswarzonegame() && isplayer(self))
	{
		self.var_d6cd7d80 = undefined;
		self.var_e42fb511 = undefined;
	}
}

/*
	Name: function_2cceca7b
	Namespace: item_inventory
	Checksum: 0xBB6D03B0
	Offset: 0x3C30
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2cceca7b()
{
	return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

/*
	Name: function_c1cef1ec
	Namespace: item_inventory
	Checksum: 0x55AF7D17
	Offset: 0x3C90
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c1cef1ec(weapon)
{
	if(weapon != self getcurrentoffhand())
	{
		return 0;
	}
	return self function_2cceca7b();
}

/*
	Name: function_c6be9f7f
	Namespace: item_inventory
	Checksum: 0x4A7BD3CA
	Offset: 0x3CE0
	Size: 0x1F4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c6be9f7f(weapon, ammo)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(weapon));
	#/
	slot = self gadgetgetslot(weapon);
	if(slot >= 0 && slot < 3)
	{
		if("ammo" != weapon.gadget_powerusetype)
		{
			return;
		}
		if(weapon.name == #"eq_tripwire")
		{
			newpower = weapon.gadget_powermax;
			ammo = weapon.clipsize;
		}
		else
		{
			if(!weapon.clipsize)
			{
				var_35935a45 = weapon.gadget_powermax;
			}
			else
			{
				var_35935a45 = weapon.gadget_powermax / weapon.clipsize;
			}
			newammo = ammo;
			if(newammo > weapon.clipsize)
			{
				newammo = weapon.clipsize;
			}
			newpower = newammo * var_35935a45;
		}
		power = self gadgetpowerset(slot, newpower);
		self setweaponammoclip(weapon, ammo);
		debug_print((("set_gadget_power: " + power) + ", ammo: ") + ammo, weapon);
	}
}

/*
	Name: function_ee9ce1c4
	Namespace: item_inventory
	Checksum: 0x754AB80B
	Offset: 0x3EE0
	Size: 0x9E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ee9ce1c4(var_a6762160, var_dfe6c7e5 = 0)
{
	self endon(#"death");
	self.var_10abd91d = 1;
	self replace_weapon(item_world_util::function_35e06774(var_a6762160), level.nullprimaryoffhand);
	self function_c6be9f7f(level.nullprimaryoffhand, 0);
	self.var_10abd91d = 0;
}

/*
	Name: function_8214f1b6
	Namespace: item_inventory
	Checksum: 0xFDE038DA
	Offset: 0x3F88
	Size: 0xF6
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8214f1b6(var_a6762160, var_dfe6c7e5 = 0)
{
	self endon(#"death");
	self.var_10abd91d = 1;
	weapon = item_world_util::function_35e06774(var_a6762160);
	slot = self gadgetgetslot(weapon);
	if(slot >= 0 && slot < 3)
	{
		while(self function_af359de(slot))
		{
			waitframe(1);
		}
	}
	self replace_weapon(weapon, level.var_ef61b4b5);
	self.var_10abd91d = 0;
}

/*
	Name: function_bba770de
	Namespace: item_inventory
	Checksum: 0xE98A4991
	Offset: 0x4088
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function function_bba770de(var_a6762160)
{
	/#
		assert(isplayer(self));
	#/
	count = 0;
	if(!isdefined(var_a6762160))
	{
		return count;
	}
	if(!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items))
	{
		return count;
	}
	name = (isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name);
	for(index = 0; index < self.inventory.items.size && index < (16 + 1); index++)
	{
		inventoryitem = self.inventory.items[index];
		if(!isdefined(inventoryitem.var_a6762160))
		{
			continue;
		}
		if(name == (isdefined(inventoryitem.var_a6762160.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name))
		{
			count = count + inventoryitem.count;
		}
	}
	return count;
}

/*
	Name: can_pickup_ammo
	Namespace: item_inventory
	Checksum: 0x900EFE0C
	Offset: 0x4238
	Size: 0x14E
	Parameters: 2
	Flags: Linked
*/
function can_pickup_ammo(item, var_1326fcc7 = undefined)
{
	/#
		assert(isplayer(self));
	#/
	var_a6762160 = item.var_a6762160;
	ammoweapon = var_a6762160.weapon;
	var_1326fcc7 = (isdefined(var_1326fcc7) ? var_1326fcc7 : (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1));
	var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
	currentammostock = self getweaponammostock(ammoweapon);
	var_9b9ba643 = var_2f399b51 - currentammostock;
	addammo = int(min(var_1326fcc7, var_9b9ba643));
	return addammo > 0;
}

/*
	Name: function_550fcb41
	Namespace: item_inventory
	Checksum: 0xCF7A9905
	Offset: 0x4390
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_550fcb41(item)
{
	/#
		assert(isplayer(self));
	#/
	if(!(isdefined(item.var_a6762160.stackable) && item.var_a6762160.stackable))
	{
		return false;
	}
	maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
	if(maxstack <= 1)
	{
		return false;
	}
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].id == 32767)
		{
			continue;
		}
		if(self.inventory.items[i].var_a6762160.name != item.var_a6762160.name)
		{
			continue;
		}
		if(self.inventory.items[i].count < maxstack)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_85645978
	Namespace: item_inventory
	Checksum: 0x6E7A5921
	Offset: 0x4510
	Size: 0xCE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_85645978(item)
{
	currtime = gettime();
	foreach(consumeditem in self.inventory.consumed)
	{
		if(item.var_a6762160.name == consumeditem.var_a6762160.name && currtime < consumeditem.endtime)
		{
			return consumeditem;
		}
	}
	return undefined;
}

/*
	Name: function_3fe6ef04
	Namespace: item_inventory
	Checksum: 0x9B4606CF
	Offset: 0x45E8
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3fe6ef04()
{
	/#
		assert(isplayer(self));
	#/
	var_cfa0e915 = [];
	foreach(consumeditem in self.inventory.consumed)
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
	Name: consume_item
	Namespace: item_inventory
	Checksum: 0xBBA7AB5E
	Offset: 0x46E0
	Size: 0x5C8
	Parameters: 1
	Flags: Linked
*/
function consume_item(item)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return 0;
	}
	if(isdefined(item.starttime))
	{
		return 0;
	}
	if(self isinvehicle())
	{
		vehicle = self getvehicleoccupied();
		if(vehicle getoccupantseat(self) == 0)
		{
			self playsoundtoplayer(#"uin_unavailable_charging", self);
			return 0;
		}
		currentweapon = self getcurrentweapon();
		if(isdefined(currentweapon) && (isdefined(currentweapon.var_29d24e37) && currentweapon.var_29d24e37))
		{
			self playsoundtoplayer(#"uin_unavailable_charging", self);
			return 0;
		}
	}
	if(item.var_a6762160.itemtype == #"armor_shard")
	{
		return function_6d647220(item);
	}
	consumeditem = self function_85645978(item);
	if(!isdefined(consumeditem) && self function_3fe6ef04() >= 10)
	{
		self playsoundtoplayer(#"uin_unavailable_charging", self);
		return 0;
	}
	self callback::callback(#"hash_5775ae80fc576ea6", item);
	duration = int((isdefined(item.var_a6762160.duration) ? item.var_a6762160.duration : 0) * 1000);
	starttime = gettime();
	endtime = starttime + duration;
	item.starttime = starttime;
	item.endtime = endtime;
	if(isdefined(consumeditem))
	{
		consumeditem.endtime = consumeditem.endtime + duration;
		for(index = 0; index < 10; index++)
		{
			inventoryitem = self.inventory.items[index];
			if(!isdefined(inventoryitem.endtime))
			{
				continue;
			}
			if(inventoryitem.var_a6762160.name == item.var_a6762160.name)
			{
				inventoryitem.starttime = consumeditem.starttime;
				inventoryitem.endtime = consumeditem.endtime;
			}
		}
	}
	else
	{
		consumeditem = spawnstruct();
		consumeditem.id = item.id;
		consumeditem.var_a6762160 = item.var_a6762160;
		consumeditem.starttime = gettime();
		consumeditem.endtime = consumeditem.starttime + duration;
	}
	self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
	level callback::callback(#"on_drop_inventory", self);
	self function_b00db06(11, item.var_bd027dd9);
	self function_db2abc4(item);
	self function_6c36ab6b();
	if(isdefined(consumeditem.var_a6762160) && isdefined(consumeditem.var_a6762160.talents) && isarray(consumeditem.var_a6762160.talents))
	{
		foreach(talent in consumeditem.var_a6762160.talents)
		{
			if(talent.talent == #"hash_6b4f1f8c0c22026f")
			{
				self thread function_299d2131(300, 100, 0.1);
				break;
			}
		}
	}
	return 1;
}

/*
	Name: function_6d647220
	Namespace: item_inventory
	Checksum: 0xB63562DF
	Offset: 0x4CB0
	Size: 0x2E0
	Parameters: 1
	Flags: Linked
*/
function function_6d647220(item)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	if(!isdefined(item) || item.var_bd027dd9 == 32767)
	{
		return false;
	}
	if(!has_armor())
	{
		return false;
	}
	if(!isdefined(self.armor) || !isdefined(self.maxarmor))
	{
		return false;
	}
	if(self.armor == self.maxarmor)
	{
		return false;
	}
	self use_inventory_item(item.var_bd027dd9, 1);
	armoritem = undefined;
	if(isplayer(self) && isdefined(self.inventory))
	{
		armoritem = self.inventory.items[11];
		if(!isdefined(armoritem) || armoritem.var_bd027dd9 == 32767 || armoritem.var_a6762160.itemtype != #"armor")
		{
			return false;
		}
	}
	if(isdefined(self.var_3f1410dd))
	{
		self.var_3f1410dd.var_2b021e34 = self.var_3f1410dd.var_2b021e34 + (int(min((isdefined(armoritem.var_a6762160.var_a6762160.var_a3aa1ca2) ? armoritem.var_a6762160.var_a3aa1ca2 : 0), self.maxarmor - self.armor)));
		self.var_3f1410dd.var_7352c057++;
	}
	self.armor = int(min(self.armor + (isdefined(armoritem.var_a6762160.var_a6762160.var_a3aa1ca2) ? armoritem.var_a6762160.var_a3aa1ca2 : 0), self.maxarmor));
	function_bdc03d88();
	self function_6c36ab6b();
	self function_db2abc4(item);
	return true;
}

/*
	Name: cycle_equipment_item
	Namespace: item_inventory
	Checksum: 0x43C78276
	Offset: 0x4F98
	Size: 0x364
	Parameters: 0
	Flags: Linked
*/
function cycle_equipment_item()
{
	/#
		assert(isplayer(self));
	#/
	var_bcc2655a = undefined;
	equipmentitem = self.inventory.items[12];
	if(equipmentitem.var_bd027dd9 !== 32767)
	{
		var_bcc2655a = equipmentitem.var_a6762160;
	}
	if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1))
	{
		item = _cycle_item(#"equipment", array(#"frag_grenade_wz_item", #"hash_3074c41bb205ed8c", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"), var_bcc2655a);
	}
	else
	{
		item = function_9da31874(#"equipment");
	}
	if(isdefined(item))
	{
		equip_equipment(item);
	}
	else
	{
		self playsoundtoplayer(#"uin_unavailable_charging", self);
	}
}

/*
	Name: cycle_health_item
	Namespace: item_inventory
	Checksum: 0x3A11E4D0
	Offset: 0x5308
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function cycle_health_item()
{
	/#
		assert(isplayer(self));
	#/
	var_bcc2655a = undefined;
	healthitem = self.inventory.items[10];
	if(healthitem.var_bd027dd9 !== 32767)
	{
		var_bcc2655a = healthitem.var_a6762160;
	}
	if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1))
	{
		item = _cycle_item(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad"), var_bcc2655a);
	}
	else
	{
		item = function_9da31874(#"health");
	}
	if(isdefined(item))
	{
		equip_health(item);
	}
	else
	{
		self playsoundtoplayer(#"uin_unavailable_charging", self);
	}
}

/*
	Name: function_9ba10b94
	Namespace: item_inventory
	Checksum: 0x7180D5F9
	Offset: 0x54A8
	Size: 0x24E
	Parameters: 1
	Flags: Linked
*/
function function_9ba10b94(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death");
	slotid = function_b246c573(var_bd027dd9);
	if(!isdefined(slotid))
	{
		return;
	}
	attachmentweapons = [];
	var_8e198ed3 = [];
	foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
	{
		var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_259f58f3);
		item = self.inventory.items[var_f9f8c0b5];
		if(item.var_bd027dd9 != 32767)
		{
			attachmentweapons[attachmentweapons.size] = item_world_util::function_f4a8d375(item.id);
			var_8e198ed3[var_8e198ed3.size] = item.id;
			remove_inventory_item(item.var_bd027dd9, 0, 1);
		}
	}
	drop_inventory_item(self.inventory.items[slotid].var_bd027dd9);
	for(index = 0; index < var_8e198ed3.size; index++)
	{
		self thread function_d7944517(var_8e198ed3[index], attachmentweapons[index], 1, 1);
	}
}

/*
	Name: function_9d102bbd
	Namespace: item_inventory
	Checksum: 0x4C754138
	Offset: 0x5700
	Size: 0x810
	Parameters: 2
	Flags: Linked
*/
function function_9d102bbd(var_b72297c2, var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death");
	if(!item_world_util::can_pick_up(var_b72297c2))
	{
		return false;
	}
	if(!isdefined(var_b72297c2) || !isdefined(var_b72297c2.var_a6762160) || var_b72297c2.var_a6762160.itemtype !== #"weapon")
	{
		return false;
	}
	weaponitem = get_inventory_item(var_bd027dd9);
	if(!isdefined(weaponitem))
	{
		return false;
	}
	if(!isdefined(weaponitem.var_a6762160) || weaponitem.var_a6762160.itemtype != #"weapon")
	{
		return false;
	}
	slotid = function_b246c573(var_bd027dd9);
	if(!isdefined(slotid))
	{
		return false;
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(weaponitem);
	if(isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon)))
	{
		return false;
	}
	if(isentity(var_b72297c2))
	{
		var_b72297c2.hidetime = gettime();
	}
	else
	{
		function_54ca5536(var_b72297c2.id, gettime());
	}
	dropweapons = [];
	dropids = [];
	var_cc9e34fb = [];
	var_14174938 = [];
	if(namespace_a0d533d1::function_4bd83c04(var_b72297c2))
	{
		foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
		{
			var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_259f58f3);
			item = self.inventory.items[var_f9f8c0b5];
			if(item.var_bd027dd9 != 32767)
			{
				attachmentname = namespace_a0d533d1::function_2ced1d34(var_b72297c2, item.var_a6762160, 1);
				/#
					assert(!isdefined(var_cc9e34fb[var_259f58f3]));
				#/
				if(isdefined(attachmentname) && !isdefined(var_cc9e34fb[var_259f58f3]))
				{
					var_cc9e34fb[var_259f58f3] = item.var_a6762160;
				}
				else
				{
					dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(item.id);
					dropids[dropids.size] = item.id;
				}
				var_14174938[var_14174938.size] = item.var_bd027dd9;
			}
		}
	}
	if(isdefined(var_b72297c2.attachments) || isdefined(var_b72297c2.var_a6762160.attachments))
	{
		attachments = (isdefined(var_b72297c2.attachments) ? var_b72297c2.attachments : var_b72297c2.var_a6762160.attachments);
		foreach(attachment in attachments)
		{
			attachmentitem = attachment;
			if(!isdefined(attachmentitem))
			{
				continue;
			}
			if(!isdefined(attachmentitem.var_a6762160))
			{
				if(!item_world_util::function_7363384a(attachment.var_6be1bec7))
				{
					continue;
				}
				attachmentitem = function_4ba8fde(attachment.var_6be1bec7);
				if(!isdefined(attachmentitem))
				{
					continue;
				}
			}
			var_259f58f3 = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
			if(!isdefined(var_259f58f3))
			{
				continue;
			}
			if(!isdefined(var_cc9e34fb[var_259f58f3]))
			{
				var_cc9e34fb[var_259f58f3] = attachmentitem.var_a6762160;
				continue;
			}
			dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(attachmentitem.id);
			dropids[dropids.size] = attachmentitem.id;
		}
	}
	var_b72297c2.attachments = [];
	foreach(var_fe35755b in var_cc9e34fb)
	{
		if(isdefined(var_fe35755b.name))
		{
			attachmentitem = function_4ba8fde(var_fe35755b.name);
			var_e38a0464 = function_520b16d6();
			var_e38a0464.count = 1;
			var_e38a0464.id = attachmentitem.id;
			var_e38a0464.var_bd027dd9 = var_e38a0464.id;
			var_e38a0464.var_a6762160 = attachmentitem.var_a6762160;
			var_b72297c2.attachments[var_b72297c2.attachments.size] = var_e38a0464;
		}
	}
	for(index = 0; index < var_14174938.size; index++)
	{
		var_ddd377f2 = var_14174938[index];
		remove_inventory_item(var_ddd377f2, 0, 1);
	}
	self drop_inventory_item(var_bd027dd9);
	for(index = 0; index < dropids.size; index++)
	{
		self thread function_d7944517(dropids[index], dropweapons[index], 1, 1);
	}
	item_world::function_de2018e3(var_b72297c2, self, slotid);
	item_world::consume_item(var_b72297c2);
	return true;
}

/*
	Name: function_fba40e6c
	Namespace: item_inventory
	Checksum: 0xC7BCE48C
	Offset: 0x5F18
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_fba40e6c(item)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death");
	if(!item_world_util::can_pick_up(item))
	{
		return false;
	}
	itemslot = self function_e66dcff5(item, 1);
	dropitem = self.inventory.items[itemslot];
	self function_85287396(1);
	droppeditem = self drop_inventory_item(dropitem.var_bd027dd9);
	slotid = function_e66dcff5(item, 1);
	if(!isdefined(item))
	{
		self item_world::function_de2018e3(dropitem, self, itemslot);
		item_world::consume_item(droppeditem);
		inventoryitem = self function_8babc9f9(dropitem.var_a6762160);
		if(isdefined(inventoryitem))
		{
			self equip_item(inventoryitem.var_bd027dd9);
		}
		self function_85287396(0);
		return;
	}
	var_a6762160 = item.var_a6762160;
	self item_world::function_de2018e3(item, self, slotid);
	inventoryitem = self function_8babc9f9(var_a6762160);
	item_world::consume_item(item);
	if(isdefined(inventoryitem))
	{
		self equip_item(inventoryitem.var_bd027dd9);
	}
	self function_85287396(0);
}

/*
	Name: function_e66dcff5
	Namespace: item_inventory
	Checksum: 0x509BEC6B
	Offset: 0x6188
	Size: 0x6D2
	Parameters: 2
	Flags: Linked
*/
function function_e66dcff5(item, var_662e1704 = 0)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return undefined;
	}
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return undefined;
	}
	if(item.var_a6762160.itemtype == #"ammo")
	{
		return undefined;
	}
	if(item.var_a6762160.itemtype == #"weapon")
	{
		foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
		{
			if(self.inventory.items[slotid].var_bd027dd9 === 32767)
			{
				return slotid;
			}
		}
		weaponitem = function_230ceec4(self.currentweapon);
		if(!isdefined(weaponitem))
		{
			return;
		}
		return function_b246c573(weaponitem.var_bd027dd9);
	}
	if(item.var_a6762160.itemtype == #"backpack")
	{
		return 13;
	}
	if(item.var_a6762160.itemtype == #"armor")
	{
		return 11;
	}
	if(item.var_a6762160.itemtype == #"resource")
	{
		if(item_world_util::function_41f06d9d(item.var_a6762160))
		{
			return 14;
		}
		return 15;
	}
	if(item.var_a6762160.itemtype == #"armor_shard")
	{
		return 16;
	}
	if(item.var_a6762160.itemtype == #"equipment")
	{
		if(var_662e1704 || self.inventory.items[12].var_bd027dd9 === 32767)
		{
			return 12;
		}
	}
	if(item.var_a6762160.itemtype == #"health")
	{
		if(var_662e1704 || self.inventory.items[10].var_bd027dd9 === 32767)
		{
			return 10;
		}
	}
	if(item.var_a6762160.itemtype == #"attachment")
	{
		var_4838b749 = function_d768ea30();
		if(var_662e1704)
		{
			var_4838b749 = (var_4838b749 == (16 + 1) ? ((16 + 1) + 6) + 1 : 16 + 1);
		}
		if(isdefined(var_4838b749))
		{
			var_f0dc4e93 = item_world_util::function_970b8d86(self, var_4838b749);
			if(self.inventory.items[var_4838b749].var_bd027dd9 != 32767)
			{
				var_ceefbd10 = namespace_a0d533d1::function_837f4a57(item.var_a6762160);
				var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
				weaponitem = self get_inventory_item(var_f0dc4e93);
				attachmentname = namespace_a0d533d1::function_2ced1d34(weaponitem, item.var_a6762160, 1);
				if(isdefined(attachmentname))
				{
					return var_f9f8c0b5;
				}
			}
		}
	}
	if(isdefined(item.var_a6762160.stackable) && item.var_a6762160.stackable)
	{
		weapon = item_world_util::function_35e06774(item.var_a6762160);
		if(isdefined(weapon))
		{
			maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
			if(maxstack > 1)
			{
				foreach(i, spawnitem in self.inventory.items)
				{
					if(spawnitem.id == 32767)
					{
						continue;
					}
					inventoryitem = function_b1702735(spawnitem.id);
					if(inventoryitem.var_a6762160.name != item.var_a6762160.name)
					{
						continue;
					}
					if(self.inventory.items[i].count < maxstack)
					{
						return i;
					}
				}
			}
		}
	}
	for(index = 0; index < self.inventory.var_c212de25; index++)
	{
		if(self.inventory.items[index].id == 32767)
		{
			return index;
		}
	}
	return undefined;
}

/*
	Name: drop_armor
	Namespace: item_inventory
	Checksum: 0x8BCA08EB
	Offset: 0x6868
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function drop_armor(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(self has_armor())
	{
		item = self.inventory.items[11];
		self thread drop_inventory_item(item.var_bd027dd9, stashitem, var_7cab8e12, targetname);
		return true;
	}
	return false;
}

/*
	Name: function_d86d7ac7
	Namespace: item_inventory
	Checksum: 0x38C449ED
	Offset: 0x6958
	Size: 0x106
	Parameters: 3
	Flags: Linked
*/
function function_d86d7ac7(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined)
{
	/#
		assert(isplayer(self));
	#/
	for(index = self.inventory.var_c212de25; index < 10; index++)
	{
		inventoryitem = self.inventory.items[index];
		if(inventoryitem.var_bd027dd9 != 32767)
		{
			self thread drop_inventory_item(inventoryitem.var_bd027dd9, stashitem, var_7cab8e12, targetname);
		}
	}
}

/*
	Name: drop_inventory_item
	Namespace: item_inventory
	Checksum: 0x488E49E
	Offset: 0x6A68
	Size: 0x6C8
	Parameters: 5
	Flags: Linked
*/
function drop_inventory_item(var_bd027dd9, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, var_4a6f595d = 1)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death");
	dropitem = undefined;
	item = get_inventory_item(var_bd027dd9);
	if(!isdefined(item))
	{
		return dropitem;
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	if(isdefined(self) && isdefined(weapon) && self.currentweapon == weapon && self isfiring())
	{
		waitframe(1);
	}
	if(!isdefined(self) || (isdefined(weapon) && self.currentweapon == weapon && self isfiring()))
	{
		return dropitem;
	}
	/#
		if(!isdefined(var_7cab8e12) && getdvarint(#"hash_5f50ef95773c29b5", 0))
		{
			for(i = getdvarint(#"hash_5f50ef95773c29b5", 0); i > 0; i--)
			{
				dropitem = self function_d7944517(item.id, weapon, item.count, item.amount, stashitem, var_7cab8e12, targetname, (isdefined(item.attachments) ? item.attachments : array()));
			}
			return dropitem;
		}
	#/
	function_60706bdb(var_bd027dd9);
	count = (isdefined(item.count) ? item.count : 1);
	amount = (isdefined(item.amount) ? item.amount : 0);
	var_104acafa = isdefined(item.endtime);
	var_337ff88 = self.inventory.items[13].var_bd027dd9 === var_bd027dd9;
	if(self function_23335063(var_bd027dd9, 0))
	{
		if(var_337ff88 && var_4a6f595d)
		{
			function_d86d7ac7(stashitem, var_7cab8e12, targetname);
			function_ec238da8();
		}
		if(count > 0)
		{
			if(isdefined(item.var_42caf41a) && item.var_42caf41a)
			{
				item.var_42caf41a = 0;
			}
			namespace_a0d533d1::function_6e9e7169(item);
			if(!var_104acafa)
			{
				weapon = namespace_a0d533d1::function_2b83d3ff(item);
				dropitem = self function_d7944517(item.id, weapon, count, amount, stashitem, var_7cab8e12, targetname, (isdefined(item.attachments) ? item.attachments : array()));
			}
			else
			{
				consumeditem = function_85645978(item);
				if(isdefined(consumeditem))
				{
					var_ee0e9af9 = [];
					for(index = 0; index < 10; index++)
					{
						inventoryitem = self.inventory.items[index];
						if(!isdefined(inventoryitem.endtime))
						{
							continue;
						}
						if(inventoryitem.var_a6762160.name == item.var_a6762160.name)
						{
							var_ee0e9af9[var_ee0e9af9.size] = inventoryitem;
						}
					}
					remaining = consumeditem.endtime - gettime();
					consumeditem.endtime = consumeditem.endtime - (remaining / (var_ee0e9af9.size + 1));
					for(index = 0; index < var_ee0e9af9.size; index++)
					{
						inventoryitem = var_ee0e9af9[index];
						inventoryitem.starttime = consumeditem.starttime;
						inventoryitem.endtime = consumeditem.endtime;
					}
				}
			}
			if(isdefined(item.attachments))
			{
				attachments = arraycopy(item.attachments);
				foreach(attachment in attachments)
				{
					if(!isdefined(attachment))
					{
						continue;
					}
					remove_inventory_item(attachment.var_bd027dd9);
				}
			}
			if(isdefined(item.var_887db92c))
			{
				dropitem.var_887db92c = item.var_887db92c;
			}
			return dropitem;
		}
	}
	return dropitem;
}

/*
	Name: equip_ammo
	Namespace: item_inventory
	Checksum: 0xC4D0DCDB
	Offset: 0x7138
	Size: 0x22E
	Parameters: 2
	Flags: Linked
*/
function equip_ammo(item, var_aec6fa7f)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	self function_db2abc4(item);
	var_a6762160 = item.var_a6762160;
	ammoweapon = var_a6762160.weapon;
	var_1326fcc7 = (isdefined(var_aec6fa7f) ? var_aec6fa7f : (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1));
	var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
	currentammostock = self getweaponammostock(ammoweapon);
	var_9b9ba643 = var_2f399b51 - currentammostock;
	addammo = int(min(var_1326fcc7, var_9b9ba643));
	if(isdefined(ammoweapon) && ammoweapon != level.weaponnone)
	{
		self.inventory.ammo[ammoweapon.name] = item.id;
		self function_fc9f8b05(ammoweapon, addammo);
		if(isdefined(var_aec6fa7f))
		{
			return var_1326fcc7 - addammo;
		}
		return 0;
	}
	/#
		assertmsg(("" + var_a6762160.name) + "");
	#/
	return var_1326fcc7 - addammo;
}

/*
	Name: function_4cde30fa
	Namespace: item_inventory
	Checksum: 0x85EAEFE0
	Offset: 0x7370
	Size: 0x196
	Parameters: 2
	Flags: Linked
*/
function function_4cde30fa(inventoryitem, var_a6762160)
{
	if(game.state == "pregame" || !isplayer(self) || isdefined(self.var_3f1410dd) || !isdefined(inventoryitem) || !isdefined(var_a6762160))
	{
		return;
	}
	loc_00007454:
	self.var_3f1410dd = {#died:0, #broken:0, #hash_2b021e34:0, #hash_7352c057:0, #damage_taken:0, #tier:(isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1), #hash_4550558c:(isdefined(inventoryitem.amount) ? inventoryitem.amount : 0), #end_time:0, #start_time:function_f8d53445(), #player_xuid:int(self getxuid(1))};
}

/*
	Name: function_bef83dc6
	Namespace: item_inventory
	Checksum: 0x2DBD2144
	Offset: 0x7510
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function function_bef83dc6()
{
	if(game.state == "pregame" || !isplayer(self) || !isdefined(self.var_3f1410dd))
	{
		return;
	}
	self.var_3f1410dd.broken = isdefined(self.armor) && self.armor <= 0;
	self.var_3f1410dd.died = isdefined(self.health) && self.health <= 0;
	self.var_3f1410dd.end_time = function_f8d53445();
	function_92d1707f(#"hash_3d5d9b3e2bc86b28", self.var_3f1410dd);
	self.var_3f1410dd = undefined;
}

/*
	Name: equip_armor
	Namespace: item_inventory
	Checksum: 0xB0D6D5D1
	Offset: 0x7610
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function equip_armor(item)
{
	var_a6762160 = item.var_a6762160;
	inventoryitem = get_inventory_item(item.var_bd027dd9);
	if(!isdefined(inventoryitem))
	{
		return;
	}
	self function_db2abc4(item);
	loc_000076A4:
	loc_000076CC:
	loc_000076F4:
	loc_0000771C:
	loc_00007744:
	loc_0000776C:
	loc_00007794:
	loc_000077BC:
	loc_000077E4:
	loc_00007808:
	self armor::set_armor(inventoryitem.amount, (isdefined(var_a6762160.amount) ? var_a6762160.amount : 0), (isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1), (isdefined(var_a6762160.var_99c0cb08) ? var_a6762160.var_99c0cb08 : 1), (isdefined(var_a6762160.var_2ee21ae6) ? var_a6762160.var_2ee21ae6 : 1), (isdefined(var_a6762160.var_c690c73d) ? var_a6762160.var_c690c73d : 1), (isdefined(var_a6762160.var_99edb6a3) ? var_a6762160.var_99edb6a3 : 1), (isdefined(var_a6762160.var_22c3ab38) ? var_a6762160.var_22c3ab38 : 1), (isdefined(var_a6762160.var_9f307988) ? var_a6762160.var_9f307988 : 1), (isdefined(var_a6762160.var_7a80f06e) ? var_a6762160.var_7a80f06e : 1), (isdefined(var_a6762160.explosivedamagescale) ? var_a6762160.explosivedamagescale : 1), (isdefined(var_a6762160.var_f2902d7b) ? var_a6762160.var_f2902d7b : 1), var_a6762160.var_19f48bbe);
	self function_4cde30fa(inventoryitem, var_a6762160);
	self.inventory.items[11] = inventoryitem;
	self function_b00db06(6, item.var_bd027dd9);
	self clientfield::set_player_uimodel("hudItems.armorType", (isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1));
}

/*
	Name: function_e258cef5
	Namespace: item_inventory
	Checksum: 0x21C49B36
	Offset: 0x78F0
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function function_e258cef5(var_bd027dd9, itemtype)
{
	if(var_bd027dd9 == 32767)
	{
		return undefined;
	}
	item = get_inventory_item(var_bd027dd9);
	if(!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != itemtype)
	{
		return undefined;
	}
	return item;
}

/*
	Name: equip_attachment
	Namespace: item_inventory
	Checksum: 0x626C498B
	Offset: 0x7988
	Size: 0x45C
	Parameters: 5
	Flags: Linked
*/
function equip_attachment(item, var_610add8d, var_d6f68de7, var_a3a17c55 = 1, switchweapon = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	var_4e2a1ed8 = function_e258cef5(var_610add8d, #"weapon");
	if(!isdefined(var_4e2a1ed8))
	{
		return;
	}
	if(namespace_a0d533d1::function_9e9c82a6(var_4e2a1ed8, item, 0))
	{
		function_b3342af3(item, undefined, var_4e2a1ed8);
		offset = namespace_a0d533d1::function_837f4a57(item.var_a6762160);
		var_ac396b2f = function_d7dbfe3c(var_4e2a1ed8);
		if(!isdefined(var_ac396b2f))
		{
			return;
		}
		var_dd6937a8 = namespace_a0d533d1::function_dfaca25e(var_ac396b2f, offset);
		var_2134bf0d = self.inventory.items[var_dd6937a8];
		itemslotid = function_b246c573(item.var_bd027dd9);
		if(!isdefined(itemslotid))
		{
			return;
		}
		var_97cc940d = 0;
		if(isdefined(var_d6f68de7))
		{
			var_3f6f5f3c = function_e258cef5(var_d6f68de7, #"weapon");
			var_2134bf0d = self.inventory.items[var_dd6937a8];
			if(isdefined(var_3f6f5f3c) && isdefined(var_2134bf0d) && isdefined(function_e258cef5(var_2134bf0d.var_bd027dd9, #"attachment")) && function_f3195b3d(var_2134bf0d.var_bd027dd9))
			{
				var_97cc940d = 1;
			}
		}
		if(!var_97cc940d)
		{
			function_26c87da8(itemslotid, var_dd6937a8);
		}
		self function_b00db06(6, item.var_bd027dd9);
		foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock"))
		{
			if(isdefined(item.var_a6762160.(slot)) && item.var_a6762160.(slot))
			{
				function_41a57271(var_4e2a1ed8, slot, undefined, item);
			}
		}
		function_d019bf1d(var_610add8d, undefined, undefined, 0);
		namespace_a0d533d1::function_6e9e7169(var_4e2a1ed8);
		equip_weapon(var_4e2a1ed8, switchweapon, undefined, var_a3a17c55, 0);
		self function_db2abc4(item);
		if(var_97cc940d)
		{
			equip_attachment(var_2134bf0d, var_d6f68de7, undefined, var_a3a17c55, 1);
		}
	}
}

/*
	Name: equip_backpack
	Namespace: item_inventory
	Checksum: 0x81BA65E8
	Offset: 0x7DF0
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function equip_backpack(item)
{
	/#
		assert(isplayer(self));
	#/
	inventoryitem = get_inventory_item(item.var_bd027dd9);
	if(!isdefined(inventoryitem))
	{
		return;
	}
	slotid = function_b246c573(item.var_bd027dd9);
	if(!isdefined(slotid))
	{
		return;
	}
	self function_db2abc4(item);
	function_26c87da8(slotid, 13);
	self.inventory.var_7658cbec = namespace_a0d533d1::function_d8cebda3(item.var_a6762160);
	if(self.inventory.var_7658cbec & 1)
	{
		self.inventory.var_c212de25 = 10;
	}
	self.inventory.items[13] = inventoryitem;
	self function_b00db06(6, item.var_bd027dd9);
	self clientfield::set_player_uimodel("hudItems.hasBackpack", 1);
}

/*
	Name: debug_print
	Namespace: item_inventory
	Checksum: 0xAC12DAC
	Offset: 0x7F68
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function debug_print(message, weapon)
{
	/#
		if(getdvarint(#"inventory_debug", 0) > 0)
		{
			weaponname = "";
			if(isdefined(weapon))
			{
				weaponname = "" + function_9e72a96(weapon.name);
			}
			self iprintlnbold(("" + message) + weaponname);
			println(((("" + self.playername) + "") + message) + weaponname);
		}
	#/
}

/*
	Name: equip_equipment
	Namespace: item_inventory
	Checksum: 0x84C7782C
	Offset: 0x8058
	Size: 0x574
	Parameters: 1
	Flags: Linked
*/
function equip_equipment(item)
{
	self notify("44650fade24c857e");
	self endon("44650fade24c857e");
	/#
		assert(isplayer(self));
	#/
	while(isdefined(self) && (isdefined(self.var_10abd91d) && self.var_10abd91d))
	{
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	var_a6762160 = item.var_a6762160;
	weapon = var_a6762160.weapon;
	debug_print("equip_equipment:", weapon);
	if(isdefined(self) && isdefined(self.inventory) && isdefined(self.inventory.items))
	{
		equipmentitem = self.inventory.items[12];
	}
	if(isdefined(equipmentitem) && equipmentitem.id != 32767)
	{
		var_355db408 = function_b1702735(equipmentitem.id).var_a6762160.weapon;
		if(isdefined(var_355db408))
		{
			slot = self gadgetgetslot(var_355db408);
			if(slot >= 0 && slot < 3)
			{
				if(self gadgetisprimed(slot))
				{
					debug_print("equip_equipment: fail: GadgetIsPrimed", var_355db408);
					return;
				}
			}
			if(self function_c1cef1ec(var_355db408))
			{
				debug_print("equip_equipment: fail: offhand equipment in use", var_355db408);
				return;
			}
			if(isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === var_355db408)
			{
				debug_print("equip_equipment: fail: equipment waiting for removal", var_355db408);
				return;
			}
			if(equipmentitem.var_bd027dd9 != item.var_bd027dd9)
			{
				function_d019bf1d(equipmentitem.var_bd027dd9);
			}
		}
	}
	if(isdefined(weapon) && weapon != level.weaponnone)
	{
		self function_db2abc4(item);
		slotid = function_b246c573(item.var_bd027dd9);
		if(isdefined(slotid) && slotid < self.inventory.var_c212de25)
		{
			function_26c87da8(slotid, 12);
		}
		weaponoptions = undefined;
		if(weapon.name == #"waterballoon")
		{
			var_f94ce554 = array(111, 112, 113, 114, 115, 116);
			weaponoptions = self calcweaponoptions(var_f94ce554[randomintrange(0, var_f94ce554.size)], 0, 0);
		}
		self replace_weapon(level.nullprimaryoffhand, weapon, undefined, undefined, undefined, weaponoptions);
		self function_b00db06(6, item.var_bd027dd9);
		for(i = 0; i < self.inventory.items.size; i++)
		{
			if(self.inventory.items[i].var_bd027dd9 === item.var_bd027dd9)
			{
				self function_c6be9f7f(weapon, self.inventory.items[i].count);
				break;
			}
		}
		debug_print("equip_equipment: success", weapon);
		self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[12].var_a6762160));
		return;
	}
	/#
		assertmsg(("" + var_a6762160.name) + "");
	#/
}

/*
	Name: equip_health
	Namespace: item_inventory
	Checksum: 0x6B128728
	Offset: 0x85D8
	Size: 0x50C
	Parameters: 1
	Flags: Linked
*/
function equip_health(item)
{
	self notify("6243ac340a4d2698");
	self endon("6243ac340a4d2698");
	/#
		assert(isplayer(self));
	#/
	while(isdefined(self) && (isdefined(self.var_10abd91d) && self.var_10abd91d))
	{
		waitframe(1);
	}
	if(!isdefined(item) || !isdefined(self))
	{
		return;
	}
	var_a6762160 = item.var_a6762160;
	weapon = var_a6762160.weapon;
	debug_print("equip_health:", weapon);
	if(isdefined(self.var_d6cd7d80))
	{
		debug_print("equip_health: fail: offhand equipment casting", self.var_d6cd7d80);
		return;
	}
	if(isdefined(self.var_e42fb511))
	{
		debug_print("equip_health: fail: offhand equipment primed", self.var_e42fb511);
		return;
	}
	if(isdefined(self.inventory) && isdefined(self.inventory.items[10]))
	{
		var_b6edb3b2 = self.inventory.items[10].var_bd027dd9;
	}
	if(isdefined(var_b6edb3b2) && var_b6edb3b2 != 32767)
	{
		var_2337367a = get_inventory_item(var_b6edb3b2);
		if(isdefined(var_2337367a))
		{
			var_355db408 = namespace_a0d533d1::function_2b83d3ff(var_2337367a);
			if(isdefined(var_355db408))
			{
				slot = self gadgetgetslot(var_355db408);
				if(slot >= 0 && slot < 3)
				{
					if(self gadgetisprimed(slot))
					{
						debug_print("equip_health: fail: GadgetIsPrimed", var_355db408);
						return;
					}
					if(self gadgetisactive(slot))
					{
						debug_print("equip_health: fail: GadgetIsActive", var_355db408);
						return;
					}
				}
				if(self function_c1cef1ec(var_355db408))
				{
					debug_print("equip_health: fail: offhand equipment in use", var_355db408);
					return;
				}
				if(isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === var_355db408)
				{
					debug_print("equip_health: fail: equipment waiting for removal", var_355db408);
					return;
				}
			}
		}
		if(var_2337367a.var_bd027dd9 != item.var_bd027dd9)
		{
			function_d019bf1d(var_b6edb3b2);
		}
	}
	if(isdefined(weapon) && weapon != level.weaponnone)
	{
		self function_db2abc4(item);
		slotid = function_b246c573(item.var_bd027dd9);
		if(isdefined(slotid) && slotid < self.inventory.var_c212de25)
		{
			function_26c87da8(slotid, 10);
		}
		self replace_weapon(level.var_ef61b4b5, weapon);
		self function_b00db06(6, item.var_bd027dd9);
		self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(item.var_a6762160));
		slot = self gadgetgetslot(weapon);
		if(slot >= 0 && slot < 3)
		{
			self function_19ed70ca(slot, 0);
		}
		debug_print("equip_health: success", weapon);
		return;
	}
	/#
		assertmsg(("" + var_a6762160.name) + "");
	#/
}

/*
	Name: equip_item
	Namespace: item_inventory
	Checksum: 0x7BA64114
	Offset: 0x8AF0
	Size: 0x38A
	Parameters: 3
	Flags: Linked
*/
function equip_item(var_bd027dd9, quickequip = 0, weaponid = 0)
{
	/#
		assert(isplayer(self));
	#/
	item = get_inventory_item(var_bd027dd9);
	if(isdefined(item) && isdefined(item.var_a6762160))
	{
		if(isdefined(item.var_a6762160.consumable) && item.var_a6762160.consumable)
		{
			return self consume_item(item);
		}
		itemtype = item.var_a6762160.itemtype;
		switch(itemtype)
		{
			case "ammo":
			{
				self equip_ammo(item);
				break;
			}
			case "armor":
			{
				self equip_armor(item);
				break;
			}
			case "attachment":
			{
				if(weaponid == 0)
				{
					self equip_attachment(item, function_ec087745(), undefined, !quickequip, 1);
				}
				else
				{
					self equip_attachment(item, function_c3fb7a6e(), function_ec087745(), !quickequip, 0);
				}
				break;
			}
			case "backpack":
			{
				self equip_backpack(item);
				break;
			}
			case "equipment":
			{
				self equip_equipment(item);
				break;
			}
			case "generic":
			case "cash":
			{
				break;
			}
			case "health":
			{
				self equip_health(item);
				break;
			}
			case "killstreak":
			{
				self use_killstreak(var_bd027dd9, item);
				break;
			}
			case "weapon":
			{
				self equip_weapon(item);
				break;
			}
			default:
			{
				/#
					assertmsg(("" + (isdefined(item.var_a6762160.var_a6762160.itemtype) ? item.var_a6762160.itemtype : "")) + "");
				#/
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: can_switch_weapons
	Namespace: item_inventory
	Checksum: 0xB659893F
	Offset: 0x8E88
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private can_switch_weapons()
{
	if(self function_2cceca7b())
	{
		return false;
	}
	return true;
}

/*
	Name: function_bf2312f1
	Namespace: item_inventory
	Checksum: 0x2A6FBA05
	Offset: 0x8EB8
	Size: 0x8E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bf2312f1(weapon)
{
	currentweapon = self getcurrentweapon();
	if(isdefined(currentweapon) && currentweapon != level.weaponnone && currentweapon == weapon)
	{
		if(self function_55acff10())
		{
			return false;
		}
		if(self isfiring())
		{
			return false;
		}
	}
	return true;
}

/*
	Name: equip_weapon
	Namespace: item_inventory
	Checksum: 0x50455D7B
	Offset: 0x8F50
	Size: 0xA4C
	Parameters: 5
	Flags: Linked
*/
function equip_weapon(item, switchweapon = 1, var_9fa01da8 = 0, var_a3a17c55 = 0, initialweaponraise = 0)
{
	/#
		assert(isplayer(self));
	#/
	var_a6762160 = item.var_a6762160;
	itemtype = var_a6762160.itemtype;
	/#
		assert(itemtype == #"weapon");
	#/
	currentweapon = level.weaponbasemeleeheld;
	var_68dc9720 = 16 + 1;
	var_6073ab7b = 0;
	if(function_bad4a3a5() == 2)
	{
		if(var_9fa01da8)
		{
			currentweapon = self getstowedweapon();
		}
		else
		{
			currentweapon = self.currentweapon;
		}
		foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
		{
			var_b8c2759f = self.inventory.items[slotid];
			if(var_b8c2759f.var_bd027dd9 === 32767)
			{
				continue;
			}
			var_355db408 = namespace_a0d533d1::function_2b83d3ff(var_b8c2759f);
			if(currentweapon == var_355db408)
			{
				var_68dc9720 = slotid;
				function_60706bdb(var_b8c2759f.var_bd027dd9);
				function_d019bf1d(var_b8c2759f.var_bd027dd9);
				break;
			}
		}
		currentweapon = level.weaponbasemeleeheld;
	}
	else
	{
		if(function_bad4a3a5() == 0)
		{
			if(function_8b1a219a() && (self getcurrentweapon() != level.weaponnone || self getcurrentweapon() != currentweapon))
			{
				var_6073ab7b = 1;
			}
			else
			{
				currentweapon = level.weaponnone;
			}
		}
		var_68dc9720 = undefined;
		foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
		{
			if(self.inventory.items[slotid].var_bd027dd9 === item.var_bd027dd9)
			{
				var_68dc9720 = slotid;
				break;
			}
		}
		if(!isdefined(var_68dc9720))
		{
			foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
			{
				if(self.inventory.items[slotid].var_bd027dd9 === 32767)
				{
					var_68dc9720 = slotid;
					break;
				}
			}
		}
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	if(isdefined(weapon) && weapon != level.weaponnone)
	{
		var_346dc077 = self getweaponammostock(weapon);
		item.var_42caf41a = slotid == (((16 + 1) + 6) + 1);
		namespace_a0d533d1::function_6e9e7169(item);
		weapon = namespace_a0d533d1::function_2b83d3ff(item);
		slotid = function_b246c573(item.var_bd027dd9);
		if(!isdefined(slotid))
		{
			return;
		}
		self function_26c87da8(slotid, var_68dc9720);
		if(initialweaponraise && !isdefined(item.weaponoptions) && !isdefined(item.charmindex) && !isdefined(item.var_2febbde5))
		{
			weaponoptions = undefined;
			if((isdefined(getgametypesetting(#"wzrandomcamo")) ? getgametypesetting(#"wzrandomcamo") : 0))
			{
				renderoptions = function_ea647602("camo", weapon);
				if(renderoptions.size > 0)
				{
					var_9412af4a = randomint(renderoptions.size);
					weaponoptions = self calcweaponoptions(renderoptions[var_9412af4a].item_index, 0, 0);
				}
			}
			else
			{
				buildkitweapon = activecamo::function_385ef18d(weapon);
				weaponoptions = self getbuildkitweaponoptions(buildkitweapon);
				charmindex = self function_9826b353(buildkitweapon);
				var_2febbde5 = self function_74829bcf(buildkitweapon);
			}
			if(weaponoptions != self getbuildkitweaponoptions(level.weaponnone))
			{
				item.weaponoptions = weaponoptions;
			}
			item.charmindex = charmindex;
			item.var_2febbde5 = var_2febbde5;
		}
		item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
		self replace_weapon(currentweapon, weapon, 1, initialweaponraise, var_a3a17c55, item.weaponoptions, item.charmindex, item.var_2febbde5);
		if(var_6073ab7b)
		{
			self replace_weapon(level.weaponnone, level.weaponbasemeleeheld);
		}
		self function_b00db06(6, item.var_bd027dd9);
		inventoryitem = get_inventory_item(item.var_bd027dd9);
		if(!isdefined(inventoryitem))
		{
			return;
		}
		if(weapon !== currentweapon)
		{
			var_b917b36f = int(min(var_346dc077, weapon.clipsize));
			self function_fc9f8b05(weapon, var_b917b36f);
		}
		var_954e19c7 = get_weapon_count();
		if(var_a3a17c55)
		{
			self function_c9a111a(weapon);
		}
		else
		{
			self shoulddoinitialweaponraise(weapon, initialweaponraise);
		}
		self setweaponammoclip(weapon, int(inventoryitem.amount));
		if(switchweapon || var_954e19c7 == 1)
		{
			if(self can_switch_weapons())
			{
				self switchtoweapon(weapon, 1);
				self.currentweapon = weapon;
			}
		}
		self function_db2abc4(item);
		return;
	}
	/#
		assertmsg(("" + var_a6762160.name) + "");
	#/
}

/*
	Name: function_ec087745
	Namespace: item_inventory
	Checksum: 0xC8350AA6
	Offset: 0x99A8
	Size: 0x14A
	Parameters: 1
	Flags: Linked
*/
function function_ec087745(var_75e3ca7a = 0)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self) || !isplayer(self))
	{
		return 32767;
	}
	weapon = self.currentweapon;
	var_bd027dd9 = function_a33744de(weapon);
	if(self isswitchingweapons() && var_bd027dd9 == 32767)
	{
		var_bd027dd9 = function_a33744de(self.currentweapon);
	}
	return var_bd027dd9;
}

/*
	Name: function_c3fb7a6e
	Namespace: item_inventory
	Checksum: 0x8F9A8850
	Offset: 0x9B00
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_c3fb7a6e()
{
	/#
		assert(isplayer(self));
	#/
	var_53c16cb = self function_ec087745();
	foreach(weaponslot in array(16 + 1, ((16 + 1) + 6) + 1))
	{
		item = self.inventory.items[weaponslot];
		if(!isdefined(item) || item.var_bd027dd9 === 32767 || var_53c16cb === item.var_bd027dd9)
		{
			continue;
		}
		return item.var_bd027dd9;
	}
	return 32767;
}

/*
	Name: function_d768ea30
	Namespace: item_inventory
	Checksum: 0x3AD3FEBD
	Offset: 0x9C58
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_d768ea30()
{
	/#
		assert(isplayer(self));
	#/
	var_bd027dd9 = self function_ec087745();
	if(var_bd027dd9 === 32767)
	{
		return;
	}
	return item_world_util::function_808be9a3(self, var_bd027dd9);
}

/*
	Name: function_bad4a3a5
	Namespace: item_inventory
	Checksum: 0x8DFDABC
	Offset: 0x9CD8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_bad4a3a5()
{
	/#
		assert(isplayer(self));
	#/
	weaponcount = 0;
	weapons = self getweaponslistprimaries();
	foreach(weapon in weapons)
	{
		if(isdefined(weapon.var_29d24e37) && weapon.var_29d24e37)
		{
			continue;
		}
		if(weapon != level.weaponnone && weapon != level.weaponbasemeleeheld)
		{
			weaponcount++;
		}
	}
	return weaponcount;
}

/*
	Name: function_777cc133
	Namespace: item_inventory
	Checksum: 0x966EEE2A
	Offset: 0x9DF0
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_777cc133()
{
	/#
		assert(isplayer(self));
	#/
	for(index = 0; index < self.inventory.var_c212de25; index++)
	{
		if(self.inventory.items[index].var_bd027dd9 == 32767)
		{
			return index;
		}
	}
}

/*
	Name: function_2e711614
	Namespace: item_inventory
	Checksum: 0x896032C0
	Offset: 0x9E80
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_2e711614(slotid)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.inventory))
	{
		return;
	}
	if(!isdefined(self.inventory.items))
	{
		return;
	}
	return self.inventory.items[slotid];
}

/*
	Name: function_230ceec4
	Namespace: item_inventory
	Checksum: 0x991EFAF0
	Offset: 0x9F08
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function function_230ceec4(weapon)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isweapon(weapon));
	#/
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.inventory))
	{
		return;
	}
	if(!isdefined(self.inventory.items))
	{
		return;
	}
	foreach(weaponslot in array(10, 11, 12, 13, 16 + 1, ((16 + 1) + 6) + 1))
	{
		item = self.inventory.items[weaponslot];
		if(!isdefined(item))
		{
			continue;
		}
		if(item.var_bd027dd9 === 32767)
		{
			continue;
		}
		if(namespace_a0d533d1::function_2b83d3ff(item) === weapon)
		{
			return item;
		}
	}
}

/*
	Name: function_a33744de
	Namespace: item_inventory
	Checksum: 0x2CDF6574
	Offset: 0xA0A8
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_a33744de(weapon)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isweapon(weapon));
	#/
	weaponitem = function_230ceec4(weapon);
	return (isdefined(weaponitem) ? weaponitem.var_bd027dd9 : 32767);
}

/*
	Name: function_b246c573
	Namespace: item_inventory
	Checksum: 0xDC188879
	Offset: 0xA150
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_b246c573(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(item_world_util::function_db35e94f(var_bd027dd9));
	#/
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === var_bd027dd9)
		{
			return i;
		}
	}
}

/*
	Name: get_inventory_item
	Namespace: item_inventory
	Checksum: 0x821A4C47
	Offset: 0xA210
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function get_inventory_item(var_bd027dd9)
{
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.inventory))
	{
		return;
	}
	if(!isdefined(self.inventory.items))
	{
		return;
	}
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === var_bd027dd9)
		{
			return self.inventory.items[i];
		}
	}
}

/*
	Name: function_8babc9f9
	Namespace: item_inventory
	Checksum: 0x1F36689F
	Offset: 0xA2F8
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function function_8babc9f9(var_a6762160)
{
	/#
		assert(isplayer(self));
	#/
	name = (isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name);
	if(!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items))
	{
		return undefined;
	}
	for(index = 0; index < self.inventory.items.size && index < (16 + 1); index++)
	{
		inventoryitem = self.inventory.items[index];
		if(!isdefined(inventoryitem.var_a6762160))
		{
			continue;
		}
		if(name == (isdefined(inventoryitem.var_a6762160.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name))
		{
			return inventoryitem;
		}
	}
}

/*
	Name: function_c48cd17f
	Namespace: item_inventory
	Checksum: 0x31680D55
	Offset: 0xA470
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_c48cd17f(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(item_world_util::function_d9648161(var_bd027dd9));
	#/
	item = get_inventory_item(var_bd027dd9);
	if(isdefined(item))
	{
		return item.id;
	}
	return 32767;
}

/*
	Name: function_189a93f8
	Namespace: item_inventory
	Checksum: 0x18AA4E20
	Offset: 0xA510
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function function_189a93f8(weapon)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isweapon(weapon));
	#/
	item = function_230ceec4(weapon);
	if(isdefined(item))
	{
		return item.id;
	}
	return 32767;
}

/*
	Name: get_weapon_count
	Namespace: item_inventory
	Checksum: 0x56B97ECC
	Offset: 0xA5B0
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function get_weapon_count()
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return 0;
	}
	weaponcount = 0;
	foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
	{
		if(self.inventory.items[slotid].var_bd027dd9 != 32767)
		{
			weaponcount++;
		}
	}
	return weaponcount;
}

/*
	Name: function_d7dbfe3c
	Namespace: item_inventory
	Checksum: 0xE5FDD24A
	Offset: 0xA6C0
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function function_d7dbfe3c(item)
{
	if(item.var_bd027dd9 === 32767)
	{
		return;
	}
	foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
	{
		if(self.inventory.items[slotid].var_bd027dd9 == item.var_bd027dd9)
		{
			return slotid;
		}
	}
}

/*
	Name: function_3f7ef88
	Namespace: item_inventory
	Checksum: 0x23C1773C
	Offset: 0xA7A8
	Size: 0x386
	Parameters: 0
	Flags: Linked
*/
function function_3f7ef88()
{
	/#
		assert(isplayer(self));
	#/
	if(!isplayer(self) || !isalive(self))
	{
		return;
	}
	if(item_world::function_1b11e73c())
	{
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		pistol = function_4ba8fde(#"pistol_standard_t8_item");
		var_fa3df96 = self function_e66dcff5(pistol);
		pistol.attachments = [];
		attachment = function_4ba8fde(#"fastmag_wz_item");
		var_e38a0464 = function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		attachment = function_4ba8fde(#"reflex_wz_item");
		var_e38a0464 = function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		pistol.amount = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(pistol));
		self item_world::function_de2018e3(pistol, self, var_fa3df96);
		ammo = function_4ba8fde(#"ammo_type_45_item");
		var_fa3df96 = self function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_4ba8fde(#"health_item_small");
		health.count = 5;
		var_fa3df96 = self function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		self.var_554ec2e2 = undefined;
	}
}

/*
	Name: give_inventory_item
	Namespace: item_inventory
	Checksum: 0xE71CDC1B
	Offset: 0xAB38
	Size: 0xE80
	Parameters: 4
	Flags: Linked
*/
function give_inventory_item(item, itemcount = 1, var_aec6fa7f = 0, slotid = undefined)
{
	if(!isplayer(self) || !isdefined(self.inventory))
	{
		/#
			assert(0, "");
		#/
		return 0;
	}
	if(!isdefined(item))
	{
		/#
			assert(0, "");
		#/
		return 0;
	}
	if(isdefined(item.var_a6762160) && isdefined(item.var_887db92c))
	{
		item.var_a6762160.var_887db92c = item.var_887db92c;
	}
	var_a6762160 = item.var_a6762160;
	itemid = item.id;
	if(isdefined(item.var_a6762160.var_456aa154))
	{
		var_456aa154 = getscriptbundle(item.var_a6762160.var_456aa154);
		if(isdefined(var_456aa154))
		{
			var_a6762160 = var_456aa154;
		}
		var_8c36ae16 = function_4ba8fde(item.var_a6762160.var_456aa154);
		if(isdefined(var_8c36ae16))
		{
			itemid = var_8c36ae16.id;
		}
	}
	var_a057551d = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
	var_1393d318 = var_a057551d > 1;
	if(item.var_a6762160.itemtype == #"resource" && item_world_util::function_41f06d9d(item.var_a6762160))
	{
		var_92d652f2 = self.inventory.items[slotid];
		var_b41045b2 = int(max(150 - self stats::get_stat_global(#"items_paint_cans_collected"), 0));
		var_a057551d = var_b41045b2 + (isdefined(var_92d652f2.count) ? var_92d652f2.count : 0);
	}
	if(isdefined(var_a6762160.name) && var_1393d318)
	{
		for(i = 0; i < self.inventory.items.size; i++)
		{
			if(self.inventory.items[i].id != 32767)
			{
				if(self.inventory.items[i].var_a6762160.name != var_a6762160.name)
				{
					continue;
				}
				var_35f34839 = var_a057551d - self.inventory.items[i].count;
				if(var_35f34839 <= 0)
				{
					continue;
				}
				var_8c6165fc = int(min(itemcount, var_35f34839));
				self.inventory.items[i].count = self.inventory.items[i].count + var_8c6165fc;
				item.var_bd027dd9 = self.inventory.items[i].var_bd027dd9;
				self function_b00db06(9, self.inventory.items[i].var_bd027dd9, self.inventory.items[i].count);
				if(i == 10)
				{
					self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(self.inventory.items[i].var_a6762160));
				}
				else if(i == 12)
				{
					self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[i].var_a6762160));
				}
				inventoryweapon = namespace_a0d533d1::function_2b83d3ff(self.inventory.items[i]);
				if(isdefined(inventoryweapon))
				{
					self function_c6be9f7f(inventoryweapon, self.inventory.items[i].count);
				}
				itemcount = itemcount - var_8c6165fc;
				/#
					assert(itemcount >= 0);
				#/
				if(itemcount <= 0)
				{
					self function_b00db06(4, itemid, 0);
					self function_6c36ab6b();
					self function_a4413333();
					return 0;
				}
			}
		}
	}
	if(isdefined(slotid))
	{
		var_92d652f2 = undefined;
		if(slotid < self.inventory.items.size)
		{
			var_92d652f2 = self.inventory.items[slotid];
		}
		/#
			assert(isdefined(var_92d652f2));
		#/
		if(var_92d652f2.var_bd027dd9 == 32767)
		{
			var_8c6165fc = int(min(itemcount, var_a057551d));
			item.var_bd027dd9 = item_world_util::function_970b8d86(self, slotid);
			namespace_a0d533d1::function_6e9e7169(item);
			var_92d652f2.amount = var_aec6fa7f;
			var_92d652f2.count = var_8c6165fc;
			var_92d652f2.id = itemid;
			var_92d652f2.var_bd027dd9 = item.var_bd027dd9;
			var_92d652f2.var_a6762160 = var_a6762160;
			var_92d652f2.starttime = undefined;
			var_92d652f2.endtime = undefined;
			var_92d652f2.weaponoptions = undefined;
			var_92d652f2.charmindex = undefined;
			var_92d652f2.var_2febbde5 = undefined;
			self function_b00db06(4, item.id, var_8c6165fc, slotid + 1);
			itemcount = itemcount - var_8c6165fc;
			/#
				assert(itemcount >= 0);
			#/
			if(itemcount <= 0)
			{
				if(isdefined(item.attachments))
				{
					foreach(attachmentitem in item.attachments)
					{
						if(!isdefined(attachmentitem))
						{
							continue;
						}
						var_769a94ae = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
						if(!isdefined(var_769a94ae))
						{
							continue;
						}
						var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
						give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
						attachmentitem = get_inventory_item(attachmentitem.var_bd027dd9);
						namespace_a0d533d1::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
					}
					namespace_a0d533d1::function_6e9e7169(var_92d652f2);
				}
				else if(isdefined(var_a6762160.attachments))
				{
					if(namespace_a0d533d1::function_4bd83c04(item))
					{
						foreach(attachment in var_a6762160.attachments)
						{
							if(!item_world_util::function_7363384a(attachment.var_6be1bec7))
							{
								continue;
							}
							attachmentitem = function_4ba8fde(attachment.var_6be1bec7);
							if(!isdefined(attachmentitem))
							{
								continue;
							}
							var_769a94ae = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
							if(!isdefined(var_769a94ae))
							{
								continue;
							}
							var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
							give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
							attachmentitem = get_inventory_item(attachmentitem.var_bd027dd9);
							namespace_a0d533d1::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
						}
						namespace_a0d533d1::function_6e9e7169(var_92d652f2);
						weapon = namespace_a0d533d1::function_2b83d3ff(var_92d652f2);
						if(isdefined(weapon))
						{
							var_92d652f2.amount = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(var_92d652f2));
						}
					}
				}
				var_92d652f2.weaponoptions = item.weaponoptions;
				var_92d652f2.charmindex = item.charmindex;
				var_92d652f2.var_2febbde5 = item.var_2febbde5;
				self function_6c36ab6b();
				self function_a4413333();
				return 0;
			}
		}
		if(slotid === 14 || slotid === 15 || slotid == 16 && var_92d652f2.var_bd027dd9 != 32767)
		{
			return itemcount;
		}
	}
	for(i = 0; i < self.inventory.var_c212de25; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === 32767)
		{
			var_8c6165fc = int(min(itemcount, var_a057551d));
			item.var_bd027dd9 = item_world_util::function_970b8d86(self, i);
			self.inventory.items[i].amount = var_aec6fa7f;
			self.inventory.items[i].count = var_8c6165fc;
			self.inventory.items[i].id = itemid;
			self.inventory.items[i].var_bd027dd9 = item.var_bd027dd9;
			self.inventory.items[i].var_a6762160 = var_a6762160;
			self.inventory.items[i].starttime = undefined;
			self.inventory.items[i].endtime = undefined;
			namespace_a0d533d1::function_6e9e7169(self.inventory.items[i]);
			self function_b00db06(4, item.id, var_8c6165fc, i + 1);
			itemcount = itemcount - var_8c6165fc;
			/#
				assert(itemcount >= 0);
			#/
			if(itemcount <= 0)
			{
				break;
			}
		}
	}
	self function_6c36ab6b();
	self function_a4413333();
	return itemcount;
}

/*
	Name: function_461de298
	Namespace: item_inventory
	Checksum: 0xE2837E1F
	Offset: 0xB9C0
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_461de298()
{
	/#
		assert(isplayer(self));
	#/
	if(!(isdefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0))
	{
		return;
	}
	if(!isplayer(self))
	{
		return;
	}
	var_73869e24 = function_4ba8fde(#"resource_item_loot_locker_key");
	lootweapons = self namespace_a0d533d1::get_loot_weapons();
	var_51c5992 = min(lootweapons.size, 2);
	if(var_51c5992 > 0)
	{
		self give_inventory_item(var_73869e24, var_51c5992, 0, 15);
	}
}

/*
	Name: has_armor
	Namespace: item_inventory
	Checksum: 0xEE2C36FF
	Offset: 0xBB08
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function has_armor()
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isdefined(self.inventory))
	{
		return 0;
	}
	if(!isdefined(self.inventory.items))
	{
		return 0;
	}
	if(!isdefined(self.inventory.items[11]))
	{
		return 0;
	}
	hasarmor = self.inventory.items[11].var_bd027dd9 != 32767 && self.inventory.items[11].var_a6762160.itemtype == #"armor";
	return hasarmor;
}

/*
	Name: has_backpack
	Namespace: item_inventory
	Checksum: 0x9592CA44
	Offset: 0xBBF8
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function has_backpack()
{
	/#
		assert(isplayer(self));
	#/
	hasbackpack = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[13]) && isdefined(self.inventory.items[13].var_a6762160) && self.inventory.items[13].var_a6762160.itemtype == #"backpack";
	return hasbackpack;
}

/*
	Name: function_471897e2
	Namespace: item_inventory
	Checksum: 0x8DDC8677
	Offset: 0xBCD8
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_471897e2()
{
	/#
		assert(isplayer(self));
	#/
	var_22939dc4 = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[15]) && isdefined(self.inventory.items[15].var_a6762160) && self.inventory.items[15].var_a6762160.itemtype == #"resource" && self.inventory.items[15].var_a6762160.name == #"resource_item_loot_locker_key";
	return var_22939dc4;
}

/*
	Name: function_7fe4ce88
	Namespace: item_inventory
	Checksum: 0x1EE1CC0A
	Offset: 0xBDF0
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_7fe4ce88(item_name)
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return undefined;
	}
	foreach(item in self.inventory.items)
	{
		if(item.id == 32767)
		{
			continue;
		}
		var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
		if(item_name == var_b74300d3)
		{
			return item;
		}
	}
}

/*
	Name: has_inventory_item
	Namespace: item_inventory
	Checksum: 0x1F6702B
	Offset: 0xBEF8
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function has_inventory_item(slotid)
{
	/#
		assert(isplayer(self));
	#/
	return isdefined(self.inventory.items[slotid]) && self.inventory.items[slotid].var_bd027dd9 != 32767;
}

/*
	Name: init_inventory
	Namespace: item_inventory
	Checksum: 0x2AE96FBE
	Offset: 0xBF78
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function init_inventory()
{
	/#
		assert(isplayer(self));
	#/
	self.inventory = spawnstruct();
	self.inventory.items = [];
	for(i = 0; i < ((((16 + 1) + 6) + 1) + 6) + 1; i++)
	{
		self.inventory.items[i] = function_520b16d6();
	}
	self.inventory.ammo = [];
	self.inventory.consumed = [];
	self.inventory.var_c212de25 = 5;
	self.inventory.var_7658cbec = 0;
	self.inventory.var_a0290b96 = [];
	self function_85287396(0);
}

/*
	Name: function_fe402108
	Namespace: item_inventory
	Checksum: 0x31D2F6D8
	Offset: 0xC0B0
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_fe402108()
{
	return isdefined(self.var_11921c74) && self.var_11921c74;
}

/*
	Name: function_e7af31c6
	Namespace: item_inventory
	Checksum: 0x75242EC3
	Offset: 0xC0D0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_e7af31c6(slotid)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(slotid >= 0 && slotid < (((((16 + 1) + 6) + 1) + 6) + 1));
	#/
	return self.inventory.items[slotid].var_bd027dd9 != 32767;
}

/*
	Name: function_f3195b3d
	Namespace: item_inventory
	Checksum: 0x33173D01
	Offset: 0xC178
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function function_f3195b3d(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	foreach(slot in array(10, 11, 12, 13, 16 + 1, ((16 + 1) + 6) + 1))
	{
		if(self.inventory.items[slot].var_bd027dd9 === var_bd027dd9)
		{
			return true;
		}
	}
	foreach(weaponid in array(16 + 1, ((16 + 1) + 6) + 1))
	{
		foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
		{
			attachmentid = namespace_a0d533d1::function_dfaca25e(weaponid, var_259f58f3);
			if(self.inventory.items[attachmentid].var_bd027dd9 === var_bd027dd9)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_db2abc4
	Namespace: item_inventory
	Checksum: 0x50838D96
	Offset: 0xC418
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_db2abc4(item)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	if(isdefined(item) && isdefined(item.var_a6762160))
	{
		if(isdefined(item.var_a6762160.consumable) && item.var_a6762160.consumable)
		{
			if(isdefined(item.var_a6762160.var_3785127d))
			{
				self playsoundtoplayer(item.var_a6762160.var_3785127d, self);
				return;
			}
		}
		switch(item.var_a6762160.itemtype)
		{
			case "weapon":
			{
				break;
			}
			case "ammo":
			{
				break;
			}
			case "health":
			{
				break;
			}
			case "equipment":
			{
				break;
			}
			case "armor":
			{
				break;
			}
			case "backpack":
			{
				break;
			}
			case "attachment":
			{
				if(isdefined(item.var_a6762160.var_3785127d))
				{
					self playsoundtoplayer(item.var_a6762160.var_3785127d, self);
				}
				break;
			}
			case "generic":
			{
				break;
			}
		}
	}
}

/*
	Name: function_a24d6e36
	Namespace: item_inventory
	Checksum: 0x99C5A8D0
	Offset: 0xC608
	Size: 0x26C
	Parameters: 3
	Flags: Linked
*/
function function_a24d6e36(var_bd027dd9, notifyclient = 1, var_cda2ff12 = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	self endon(#"death");
	itemid = function_c48cd17f(var_bd027dd9);
	if(itemid == 32767)
	{
		return false;
	}
	item = get_inventory_item(var_bd027dd9);
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	if(isdefined(weapon))
	{
		self.var_6d2ad74f = weapon;
		slot = self gadgetgetslot(weapon);
		if(slot >= 0 && slot < 3)
		{
			self function_19ed70ca(slot, 1);
			self gadgetpowerset(slot, 0);
		}
		while(isdefined(self) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon)))
		{
			waitframe(1);
		}
	}
	if(item.count > 0 && isdefined(weapon))
	{
		self function_19ed70ca(slot, 0);
		self gadgetpowerset(slot, weapon.gadget_powermax);
	}
	else
	{
		self remove_inventory_item(var_bd027dd9, 0, notifyclient, var_cda2ff12);
	}
}

/*
	Name: function_eb70ad46
	Namespace: item_inventory
	Checksum: 0x7CEF5DEF
	Offset: 0xC880
	Size: 0x21C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_eb70ad46(var_bd027dd9, notifyclient = 1, var_cda2ff12 = 1)
{
	item = get_inventory_item(var_bd027dd9);
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	var_a6762160 = item.var_a6762160;
	self.inventory.items[13] = function_520b16d6();
	self.inventory.var_c212de25 = 5;
	self.inventory.var_7658cbec = 0;
	if(notifyclient)
	{
		self function_b00db06(5, var_bd027dd9);
	}
	function_9d805044(var_a6762160.itemtype, var_a6762160);
	if(var_cda2ff12)
	{
		for(index = self.inventory.var_c212de25; index < 10; index++)
		{
			inventoryitem = self.inventory.items[index];
			if(inventoryitem.var_bd027dd9 != 32767)
			{
				remove_inventory_item(inventoryitem.var_bd027dd9);
			}
		}
	}
	if(isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon)
	{
		self.var_6d2ad74f = undefined;
	}
	debug_print("remove_inventory_item: Success!", weapon);
	self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
}

/*
	Name: remove_inventory_item
	Namespace: item_inventory
	Checksum: 0xDAD23A3
	Offset: 0xCAA8
	Size: 0x4BE
	Parameters: 4
	Flags: Linked
*/
function remove_inventory_item(var_bd027dd9, var_dfe6c7e5 = 0, notifyclient = 1, var_cda2ff12 = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	itemid = function_c48cd17f(var_bd027dd9);
	if(itemid == 32767)
	{
		debug_print("remove_inventory_item: failed! No ItemId");
		return false;
	}
	item = get_inventory_item(var_bd027dd9);
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	var_a6762160 = item.var_a6762160;
	if(isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon)))
	{
		debug_print("remove_inventory_item: failed! Weapon in Use");
		return false;
	}
	if(self.inventory.items[13].var_bd027dd9 === var_bd027dd9)
	{
		function_eb70ad46(var_bd027dd9, notifyclient, var_cda2ff12);
		return true;
	}
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === var_bd027dd9)
		{
			unequipped = self function_d019bf1d(var_bd027dd9, var_dfe6c7e5, notifyclient, var_cda2ff12);
			self.inventory.items[i] = function_520b16d6();
			if(function_8b1a219a())
			{
				if(isdefined(array::find(array(16 + 1, ((16 + 1) + 6) + 1), i)) && get_weapon_count() == 0)
				{
					self sortheldweapons();
				}
			}
			self function_6c36ab6b();
			self function_a4413333();
			if(notifyclient)
			{
				self function_b00db06(5, var_bd027dd9);
			}
			if(i == 10)
			{
				self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
			}
			else if(i == 12)
			{
				self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
			}
			if(unequipped)
			{
				function_9d805044(var_a6762160.itemtype, var_a6762160);
			}
			if(isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon)
			{
				self.var_6d2ad74f = undefined;
			}
			if(var_a6762160.itemtype == #"cash")
			{
				self function_3d113bfb();
			}
			debug_print("remove_inventory_item: Success!", weapon);
			return true;
		}
		if(!isdefined(self.inventory))
		{
			return false;
		}
	}
	debug_print("remove_inventory_item: Failed!", weapon);
	return false;
}

/*
	Name: replace_weapon
	Namespace: item_inventory
	Checksum: 0xDC8A5501
	Offset: 0xCF70
	Size: 0x226
	Parameters: 8
	Flags: Linked
*/
function replace_weapon(old_weapon, new_weapon, primary_weapon = 0, var_e47b0bf = 1, var_6086c488 = 0, options = undefined, charmindex = undefined, var_2febbde5)
{
	/#
		assert(isdefined(old_weapon));
	#/
	/#
		assert(isdefined(new_weapon));
	#/
	if(isdefined(old_weapon) && old_weapon != level.weaponnone)
	{
		self replaceweapon(old_weapon, 0, new_weapon, options);
		self takeweapon(old_weapon);
	}
	else
	{
		self giveweapon(new_weapon, options);
	}
	if(!self hasweapon(new_weapon))
	{
		return;
	}
	if(isdefined(charmindex) && charmindex >= 0)
	{
		self function_3fb8b14(new_weapon, charmindex);
	}
	if(isdefined(var_2febbde5) && var_2febbde5 >= 0)
	{
		self function_a85d2581(new_weapon, var_2febbde5);
	}
	if(var_6086c488)
	{
		self function_c9a111a(new_weapon);
	}
	else
	{
		self shoulddoinitialweaponraise(new_weapon, var_e47b0bf);
	}
	if(primary_weapon && self isinvehicle())
	{
		self.currentweapon = new_weapon;
	}
}

/*
	Name: function_85287396
	Namespace: item_inventory
	Checksum: 0x7592386
	Offset: 0xD1A0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_85287396(enabled)
{
	if(isdefined(self))
	{
		self.var_11921c74 = enabled;
	}
}

/*
	Name: function_fba4a353
	Namespace: item_inventory
	Checksum: 0xF7E33DFE
	Offset: 0xD1D0
	Size: 0x2DA
	Parameters: 1
	Flags: Linked
*/
function function_fba4a353(item)
{
	if(!isplayer(self) || !isdefined(self.inventory))
	{
		/#
			assert(0, "");
		#/
		return false;
	}
	/#
		assert(isdefined(item));
	#/
	if(1 && isdefined(item) && isdefined(item.var_a6762160))
	{
		slotid = undefined;
		switch(item.var_a6762160.itemtype)
		{
			case "armor":
			{
				slotid = 11;
				break;
			}
			case "backpack":
			{
				slotid = 13;
				break;
			}
			case "equipment":
			{
				slotid = 12;
				break;
			}
			case "health":
			{
				slotid = 10;
				break;
			}
			case "weapon":
			{
				slotid = array(16 + 1, ((16 + 1) + 6) + 1);
			}
		}
		if(isarray(slotid))
		{
			emptyslot = 0;
			foreach(id in slotid)
			{
				if(self.inventory.items[id].var_bd027dd9 === 32767 || self.inventory.items[id].var_bd027dd9 === item.var_bd027dd9)
				{
					emptyslot = 1;
					break;
				}
			}
			if(!emptyslot)
			{
				return false;
			}
		}
		else if(self.inventory.items[slotid].var_bd027dd9 !== 32767 && self.inventory.items[slotid].var_bd027dd9 !== item.var_bd027dd9)
		{
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: function_ecd1c667
	Namespace: item_inventory
	Checksum: 0x1720D41C
	Offset: 0xD4B8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_ecd1c667(itemid, count)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(item_world_util::function_2c7fc531(itemid));
	#/
	self endon(#"death");
	item = function_b1702735(itemid);
	/#
		assert(item.var_a6762160.itemtype == #"ammo");
	#/
	weapon = item.var_a6762160.weapon;
	maxammo = self getweaponammostock(weapon);
	count = int(min((isdefined(count) ? count : maxammo), maxammo));
	if(count <= 0)
	{
		return;
	}
	self function_fc9f8b05(weapon, count * -1);
	self function_d7944517(item.id, item.var_a6762160.weapon, 1, count);
}

/*
	Name: function_cfe0e919
	Namespace: item_inventory
	Checksum: 0xAF25B111
	Offset: 0xD678
	Size: 0x1EC
	Parameters: 2
	Flags: Linked
*/
function function_cfe0e919(var_bd027dd9, count)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(count) && count > 0);
	#/
	self endon(#"death");
	item = get_inventory_item(var_bd027dd9);
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	if(self.inventory.items[12].var_bd027dd9 == var_bd027dd9 && isdefined(self.var_8181d952) && self.var_8181d952 == item.var_a6762160.weapon)
	{
		if(item.count == count)
		{
			count--;
		}
	}
	count = int(min(item.count, count));
	if(count <= 0)
	{
		return;
	}
	weapon = item.var_a6762160.weapon;
	self function_d7944517(item.id, item.var_a6762160.weapon, count, 0);
	self use_inventory_item(var_bd027dd9, count);
}

/*
	Name: function_23335063
	Namespace: item_inventory
	Checksum: 0xF58E0B17
	Offset: 0xD870
	Size: 0x4E
	Parameters: 2
	Flags: Linked
*/
function function_23335063(var_bd027dd9, var_cda2ff12 = 1)
{
	if(!self remove_inventory_item(var_bd027dd9, undefined, undefined, var_cda2ff12))
	{
		return false;
	}
	return true;
}

/*
	Name: function_c4468806
	Namespace: item_inventory
	Checksum: 0xFAB3E13B
	Offset: 0xD8C8
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_c4468806(player, item)
{
	if(game.state == "pregame" || !isdefined(item))
	{
		return;
	}
	data = {#item:hash(item.var_a6762160.name), #player_xuid:int(player getxuid(1)), #game_time:function_f8d53445()};
	/#
		println("" + item.var_a6762160.name);
	#/
	function_92d1707f(#"hash_50be59ef12074ce", data);
}

/*
	Name: function_394d85cd
	Namespace: item_inventory
	Checksum: 0xE9496862
	Offset: 0xDA00
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function function_394d85cd()
{
	/#
		assert(isplayer(self));
	#/
	var_13339abf = array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item");
	var_c2043143 = array(2, 4, 8, 16, 32, 64, 128, 256);
	for(index = 0; index < var_13339abf.size; index++)
	{
		if(self.inventory.var_7658cbec & var_c2043143[index])
		{
			continue;
		}
		ammoitem = var_13339abf[index];
		var_f415ce36 = getscriptbundle(ammoitem);
		weapon = var_f415ce36.weapon;
		/#
			assert(isdefined(weapon));
		#/
		if(!isdefined(weapon))
		{
			continue;
		}
		maxammo = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, weapon);
		var_346dc077 = self getweaponammostock(weapon);
		if(var_346dc077 > maxammo)
		{
			var_f580278d = function_4ba8fde(ammoitem).id;
			function_ecd1c667(var_f580278d, var_346dc077 - maxammo);
		}
	}
}

/*
	Name: function_a2c7ce35
	Namespace: item_inventory
	Checksum: 0xB621E701
	Offset: 0xDC70
	Size: 0x57A
	Parameters: 0
	Flags: Linked
*/
function function_a2c7ce35()
{
	/#
		assert(isplayer(self));
	#/
	var_3e9ef0a1 = array(array(#"frag_grenade_wz_item", #"hash_3074c41bb205ed8c", #"acid_bomb_wz_item", #"molotov_wz_item", #"wraithfire_wz_item", #"hatchet_wz_item", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item"), array(#"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"emp_grenade_wz_item", #"spectre_grenade_wz_item"), array(#"grapple_wz_item", #"unlimited_grapple_wz_item", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"flare_gun_veh_wz_item", #"wz_snowball", #"wz_waterballoon"));
	var_c77511ea = array(8192, 16384, 32768);
	var_710be50e = array(12);
	for(itemindex = 0; itemindex < 10; itemindex++)
	{
		var_710be50e[var_710be50e.size] = itemindex;
	}
	for(var_25c45152 = 0; var_25c45152 < var_3e9ef0a1.size; var_25c45152++)
	{
		if(self.inventory.var_7658cbec & var_c77511ea[var_25c45152])
		{
			continue;
		}
		equipmentitems = var_3e9ef0a1[var_25c45152];
		for(index = 0; index < equipmentitems.size; index++)
		{
			equipmentitem = equipmentitems[index];
			itemspawnpoint = function_4ba8fde(equipmentitem);
			if(!isdefined(itemspawnpoint))
			{
				continue;
			}
			maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.var_a6762160);
			for(itemindex = 0; itemindex < var_710be50e.size; itemindex++)
			{
				item = self.inventory.items[var_710be50e[itemindex]];
				if(item.var_bd027dd9 == 32767)
				{
					continue;
				}
				if(item.var_a6762160.name != equipmentitem)
				{
					continue;
				}
				if(item.count <= maxstack)
				{
					continue;
				}
				var_9311e423 = item.count - maxstack;
				self use_inventory_item(item.var_bd027dd9, var_9311e423);
				newitem = spawnstruct();
				newitem.id = item.id;
				newitem.var_a6762160 = item.var_a6762160;
				var_77e61fc6 = give_inventory_item(newitem, var_9311e423);
				if(var_77e61fc6 > 0)
				{
					self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
				}
			}
		}
	}
}

/*
	Name: function_2bb3a825
	Namespace: item_inventory
	Checksum: 0xAA715FFD
	Offset: 0xE1F8
	Size: 0x350
	Parameters: 0
	Flags: Linked
*/
function function_2bb3a825()
{
	/#
		assert(isplayer(self));
	#/
	var_9b624be0 = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad");
	var_448bc079 = array(512, 1024, 2048, 4096);
	var_5675add1 = array(10);
	for(itemindex = 0; itemindex < 10; itemindex++)
	{
		var_5675add1[var_5675add1.size] = itemindex;
	}
	for(index = var_9b624be0.size - 1; index >= 0; index--)
	{
		if(self.inventory.var_7658cbec & var_448bc079[index])
		{
			continue;
		}
		healthitem = var_9b624be0[index];
		itemspawnpoint = function_4ba8fde(healthitem);
		if(!isdefined(itemspawnpoint))
		{
			continue;
		}
		maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.var_a6762160);
		for(itemindex = 0; itemindex < var_5675add1.size; itemindex++)
		{
			item = self.inventory.items[var_5675add1[itemindex]];
			if(item.var_bd027dd9 == 32767)
			{
				continue;
			}
			if(item.var_a6762160.name != healthitem)
			{
				continue;
			}
			if(item.count <= maxstack)
			{
				continue;
			}
			var_9311e423 = item.count - maxstack;
			self use_inventory_item(item.var_bd027dd9, var_9311e423);
			newitem = spawnstruct();
			newitem.id = item.id;
			newitem.var_a6762160 = item.var_a6762160;
			var_77e61fc6 = give_inventory_item(newitem, var_9311e423);
			if(var_77e61fc6 > 0)
			{
				self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
			}
		}
	}
}

/*
	Name: function_2521e90f
	Namespace: item_inventory
	Checksum: 0xB9B13C22
	Offset: 0xE550
	Size: 0x166
	Parameters: 0
	Flags: Linked
*/
function function_2521e90f()
{
	for(index = self.inventory.var_c212de25; index < 10; index++)
	{
		item = self.inventory.items[index];
		if(item.var_bd027dd9 == 32767)
		{
			continue;
		}
		newitem = spawnstruct();
		newitem.id = item.id;
		newitem.var_a6762160 = item.var_a6762160;
		newitem.count = item.count;
		remove_inventory_item(item.var_bd027dd9, 0, 1, 1);
		var_77e61fc6 = give_inventory_item(newitem, newitem.count);
		if(var_77e61fc6 > 0)
		{
			self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
		}
	}
}

/*
	Name: function_ec238da8
	Namespace: item_inventory
	Checksum: 0xD53E3538
	Offset: 0xE6C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_ec238da8()
{
	function_394d85cd();
	function_a2c7ce35();
	function_2bb3a825();
	function_2521e90f();
}

/*
	Name: reset_inventory
	Namespace: item_inventory
	Checksum: 0xBEC69129
	Offset: 0xE710
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function reset_inventory()
{
	self endon(#"death", #"disconnect");
	/#
		assert(isplayer(self));
	#/
	self.var_7bba6210 = 1;
	self disableoffhandspecial();
	self disableoffhandweapons();
	self.var_6d2ad74f = undefined;
	while(self function_2cceca7b())
	{
		waitframe(1);
	}
	if(!isdefined(self) || !isdefined(self.inventory))
	{
		return;
	}
	self function_d62822d5();
	foreach(inventoryitem in self.inventory.items)
	{
		if(inventoryitem.var_bd027dd9 != 32767)
		{
			remove_inventory_item(inventoryitem.var_bd027dd9, 0, 0);
		}
	}
	foreach(ammoweapon, itemid in self.inventory.ammo)
	{
		weapon = getweapon(ammoweapon);
		self setweaponammostock(weapon, 0);
	}
	if(isdefined(level.givecustomloadout))
	{
		self [[level.givecustomloadout]](1);
	}
	self init_inventory();
	self function_6c36ab6b();
	self function_b00db06(10);
	self clientfield::set_player_uimodel("hudItems.armorType", 0);
	self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
	self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
	self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
	self.var_7bba6210 = undefined;
	self enableoffhandspecial();
	self enableoffhandweapons();
	self callback::callback(#"inventory_reset");
}

/*
	Name: function_26c87da8
	Namespace: item_inventory
	Checksum: 0x95F2A576
	Offset: 0xEA90
	Size: 0x214
	Parameters: 2
	Flags: Linked
*/
function function_26c87da8(var_c9293a27, var_8f194e5a)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(var_c9293a27) && isdefined(var_8f194e5a));
	#/
	if(!isdefined(var_c9293a27) || !isdefined(var_8f194e5a))
	{
		return;
	}
	if(var_c9293a27 == var_8f194e5a)
	{
		return;
	}
	fromitem = self.inventory.items[var_c9293a27];
	toitem = self.inventory.items[var_8f194e5a];
	self.inventory.items[var_c9293a27] = toitem;
	self.inventory.items[var_8f194e5a] = fromitem;
	if(isdefined(fromitem.var_a6762160))
	{
		fromitem.var_bd027dd9 = item_world_util::function_970b8d86(self, var_8f194e5a);
	}
	if(isdefined(toitem.var_a6762160))
	{
		toitem.var_bd027dd9 = item_world_util::function_970b8d86(self, var_c9293a27);
	}
	if(var_8f194e5a == 10)
	{
		self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(toitem.var_a6762160));
	}
	else if(var_8f194e5a == 12)
	{
		self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(toitem.var_a6762160));
	}
	self function_b00db06(12, var_c9293a27, var_8f194e5a);
}

/*
	Name: function_b3342af3
	Namespace: item_inventory
	Checksum: 0xD1F90272
	Offset: 0xECB0
	Size: 0x3A0
	Parameters: 3
	Flags: Linked
*/
function function_b3342af3(item, notifyclient = 1, var_2ea908ac = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
	{
		var_f0dc4e93 = self.inventory.items[slotid].var_bd027dd9;
		if(var_f0dc4e93 == 32767)
		{
			continue;
		}
		if(isdefined(var_2ea908ac) && var_2ea908ac.var_bd027dd9 === var_f0dc4e93)
		{
			continue;
		}
		weaponitem = get_inventory_item(var_f0dc4e93);
		if(!isdefined(weaponitem) || !isdefined(weaponitem.var_a6762160) || weaponitem.var_a6762160.itemtype != #"weapon")
		{
			/#
				assert(0);
			#/
			continue;
		}
		currentammo = self getweaponammoclip(namespace_a0d533d1::function_2b83d3ff(weaponitem));
		if(namespace_a0d533d1::function_31a0b1ef(weaponitem, item, 0))
		{
			itemtype = item.var_a6762160.itemtype;
			var_bd027dd9 = item.var_bd027dd9;
			if(notifyclient)
			{
				self function_b00db06(7, var_bd027dd9);
			}
			weapon = namespace_a0d533d1::function_2b83d3ff(weaponitem);
			iscurrentweapon = weapon == self.currentweapon;
			function_d019bf1d(var_f0dc4e93, undefined, notifyclient, 0);
			namespace_a0d533d1::function_6e9e7169(weaponitem);
			equip_weapon(weaponitem, iscurrentweapon, undefined, 1, 0);
			newammo = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(weaponitem));
			var_b917b36f = currentammo - newammo;
			if(var_b917b36f > 0)
			{
				self function_fc9f8b05(weapon, var_b917b36f);
			}
			return true;
		}
	}
	return false;
}

/*
	Name: function_41a57271
	Namespace: item_inventory
	Checksum: 0xD202BE7C
	Offset: 0xF058
	Size: 0x1E0
	Parameters: 4
	Flags: Linked
*/
function function_41a57271(item, slot, notifyclient = 1, ignoreattachment = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	if(!isdefined(item.attachments))
	{
		return false;
	}
	attachments = arraycopy(item.attachments);
	foreach(attachment in attachments)
	{
		if(!isdefined(attachment) || !isdefined(attachment.var_a6762160))
		{
			continue;
		}
		if(isdefined(ignoreattachment) && ignoreattachment.var_bd027dd9 == attachment.var_bd027dd9)
		{
			continue;
		}
		if(isdefined(attachment.var_a6762160.(slot)) && attachment.var_a6762160.(slot))
		{
			function_b3342af3(get_inventory_item(attachment.var_bd027dd9), notifyclient);
		}
	}
}

/*
	Name: function_d019bf1d
	Namespace: item_inventory
	Checksum: 0x3D6B155F
	Offset: 0xF240
	Size: 0x298
	Parameters: 4
	Flags: Linked
*/
function function_d019bf1d(var_bd027dd9, var_dfe6c7e5 = 0, notifyclient = 1, var_8eb4edca = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	if(!function_f3195b3d(var_bd027dd9))
	{
		return 0;
	}
	item = get_inventory_item(var_bd027dd9);
	if(!isdefined(item))
	{
		return 0;
	}
	var_a6762160 = item.var_a6762160;
	itemtype = var_a6762160.itemtype;
	if(itemtype == #"weapon")
	{
		return function_3f5b2e2e(item, notifyclient, var_8eb4edca);
	}
	if(itemtype == #"attachment")
	{
		return function_b3342af3(item, notifyclient);
	}
	if(itemtype == #"armor")
	{
		self function_bef83dc6();
		self armor::set_armor(0, 0, 0, 1, 0);
		self clientfield::set_player_uimodel("hudItems.armorType", 0);
	}
	else
	{
		if(itemtype == #"equipment")
		{
			self thread function_ee9ce1c4(var_a6762160, var_dfe6c7e5);
		}
		else if(itemtype == #"health")
		{
			self thread function_8214f1b6(var_a6762160, var_dfe6c7e5);
		}
	}
	if(notifyclient)
	{
		self function_b00db06(7, var_bd027dd9);
	}
	return 1;
}

/*
	Name: function_3f5b2e2e
	Namespace: item_inventory
	Checksum: 0x6BE79B8A
	Offset: 0xF4E8
	Size: 0x4F0
	Parameters: 3
	Flags: Linked
*/
function function_3f5b2e2e(item, notifyclient = 1, var_8eb4edca = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	itemtype = item.var_a6762160.itemtype;
	var_bd027dd9 = item.var_bd027dd9;
	function_60706bdb(var_bd027dd9);
	if(isdefined(item.attachments) && var_8eb4edca)
	{
		attachmentitems = [];
		foreach(attachment in item.attachments)
		{
			if(!isdefined(attachment))
			{
				continue;
			}
			attachmentitem = get_inventory_item(attachment.var_bd027dd9);
			attachmentitems[attachmentitems.size] = attachmentitem;
		}
		foreach(attachmentitem in attachmentitems)
		{
			function_b3342af3(attachmentitem, 1);
		}
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
	if(get_weapon_count() > 1)
	{
		self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
		foreach(slotid in array(16 + 1, ((16 + 1) + 6) + 1))
		{
			if(self.inventory.items[slotid].var_bd027dd9 != 32767 && self.inventory.items[slotid].var_bd027dd9 != item.var_bd027dd9)
			{
				altweapon = namespace_a0d533d1::function_2b83d3ff(self.inventory.items[slotid]);
				currentweapon = self getcurrentweapon();
				if(altweapon != currentweapon)
				{
					self switchtoweapon(altweapon, 1);
				}
				self.currentweapon = altweapon;
				break;
			}
		}
	}
	else
	{
		self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
		if(weapon == self.currentweapon)
		{
			currentweapon = self getcurrentweapon();
			if(level.weaponbasemeleeheld != currentweapon)
			{
				self switchtoweapon(level.weaponbasemeleeheld, 1);
			}
			self.currentweapon = level.weaponbasemeleeheld;
		}
	}
	self clearstowedweapon();
	if(notifyclient)
	{
		self function_b00db06(7, var_bd027dd9);
	}
	return true;
}

/*
	Name: use_inventory_item
	Namespace: item_inventory
	Checksum: 0xD2614EED
	Offset: 0xF9E0
	Size: 0x2EA
	Parameters: 3
	Flags: Linked
*/
function use_inventory_item(var_bd027dd9, usecount = 1, var_dfe6c7e5 = 1)
{
	self endon(#"death");
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === var_bd027dd9)
		{
			if(isdefined(self.inventory.items[i].var_a6762160.unlimited) && self.inventory.items[i].var_a6762160.unlimited)
			{
				break;
			}
			self.inventory.items[i].count = self.inventory.items[i].count - usecount;
			if(self.inventory.items[i].count < 0)
			{
				self.inventory.items[i].count = 0;
				break;
			}
			var_641929a7 = {#item:self.inventory.items[i]};
			self callback::callback(#"on_item_use", var_641929a7);
			self function_b00db06(9, var_bd027dd9, self.inventory.items[i].count);
			function_a4413333();
			function_c4468806(self, self.inventory.items[i]);
			if(self.inventory.items[i].count <= 0)
			{
				self thread function_a24d6e36(var_bd027dd9, 1);
			}
			break;
		}
	}
}

/*
	Name: function_956a8ecd
	Namespace: item_inventory
	Checksum: 0xFA8988A2
	Offset: 0xFCD8
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function function_956a8ecd()
{
	/#
		assert(isentity(self));
	#/
	if(!isentity(self))
	{
		return;
	}
	self waittill(#"hash_363004a4e0ccc1f", #"hawk_settled", #"death", #"stationary");
	var_d783088e = [];
	foreach(sensordart in level.sensor_darts)
	{
		if(!isdefined(sensordart))
		{
			continue;
		}
		parentent = sensordart getlinkedent();
		if(isdefined(parentent) && parentent == self)
		{
			var_d783088e[var_d783088e.size] = sensordart;
		}
	}
	if(!isdefined(self) || self.health <= 0)
	{
		foreach(sensordart in var_d783088e)
		{
			sensordart thread sensor_dart::function_4db10465();
		}
		return;
	}
	angles = self.angles;
	origin = self.origin;
	dropitem = item_drop::drop_item(undefined, 1, 0, self.id, origin, angles);
	if(isdefined(dropitem) && item_world_util::function_74e1e547(origin))
	{
		dropitem.var_d783088e = var_d783088e;
	}
	else
	{
		foreach(sensordart in var_d783088e)
		{
			sensordart thread sensor_dart::function_4db10465();
		}
	}
	util::wait_network_frame(1);
	if(isdefined(self))
	{
		self delete();
		arrayremovevalue(level.item_vehicles, undefined, 0);
	}
}

/*
	Name: function_d8ceeeec
	Namespace: item_inventory
	Checksum: 0x979BE032
	Offset: 0x10010
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d8ceeeec(notifyhash)
{
	self val::reset(#"item_killstreak", "freezecontrols_allowlook");
}

/*
	Name: use_killstreak
	Namespace: item_inventory
	Checksum: 0xE047272
	Offset: 0x10050
	Size: 0x89C
	Parameters: 2
	Flags: Linked
*/
function use_killstreak(var_bd027dd9, item)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	self endoncallback(&function_d8ceeeec, #"death");
	if(self isinvehicle())
	{
		return;
	}
	if(self function_2cceca7b())
	{
		return;
	}
	if(self inlaststand())
	{
		return;
	}
	if(self isonladder())
	{
		return;
	}
	vehicletype = item.var_a6762160.vehicle;
	if(item.var_a6762160.weapon.deployable)
	{
		traceresults = self function_242060b9(item.var_a6762160.weapon);
		if(traceresults.isvalid)
		{
			if(isdefined(level.var_1f020f16) && isdefined(vehicletype) && isdefined(level.var_1f020f16[vehicletype]))
			{
				traceresults.isvalid = self [[level.var_1f020f16[vehicletype]]](item.var_a6762160.vehicle, item.var_a6762160.weapon, traceresults);
			}
		}
	}
	else
	{
		if(isdefined(level.var_4cf92425[vehicletype]))
		{
			traceresults = self [[level.var_4cf92425[vehicletype]]](item.var_a6762160.vehicle);
		}
		else
		{
			eyeangle = self getplayerangles();
			forward = anglestoforward(eyeangle);
			eyepos = self getplayercamerapos();
			endpos = eyepos + (forward * 50);
			var_f45df727 = eyepos + (forward * 100);
			traceresults = {};
			traceresults.trace = bullettrace(eyepos, var_f45df727, 1, self, 1, 1);
			traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
			traceresults.waterdepth = 0;
			traceresults.origin = endpos;
			traceresults.angles = eyeangle;
		}
	}
	if(traceresults.isvalid)
	{
		remoteweapon = getweapon(#"warzone_remote");
		if(self hasweapon(remoteweapon))
		{
			return;
		}
		if(self isswitchingweapons())
		{
			self waittilltimeout(2, #"weapon_change");
		}
		self val::set(#"item_killstreak", "freezecontrols_allowlook", 1);
		self giveweapon(remoteweapon);
		self switchtoweapon(remoteweapon, 1);
		self waittilltimeout(2, #"weapon_change");
		if(self getcurrentweapon() != remoteweapon)
		{
			self takeweapon(remoteweapon);
			self val::reset(#"item_killstreak", "freezecontrols_allowlook");
			return;
		}
		remove_inventory_item(var_bd027dd9);
		self closeingamemenu();
		var_7f11909d = undefined;
		var_2e2dbfa3 = undefined;
		if(isdefined(traceresults.hitent))
		{
			var_7f11909d = traceresults.origin - traceresults.hitent.origin;
			var_2e2dbfa3 = traceresults.hitent.angles;
		}
		spawnorigin = traceresults.origin;
		if(isdefined(traceresults.hitent) && isdefined(var_7f11909d))
		{
			anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
			spawnorigin = traceresults.hitent.origin + rotatepoint(var_7f11909d, anglesdelta);
		}
		vehicle = spawnvehicle(vehicletype, spawnorigin, traceresults.angles);
		if(isdefined(vehicle))
		{
			if(isdefined(vehicle.vehicleclass) && vehicle.vehicleclass == #"helicopter")
			{
				vehicle.origin = vehicle.origin + (0, 0, vehicle.height);
			}
			level.item_vehicles[level.item_vehicles.size] = vehicle;
		}
		util::wait_network_frame(1);
		if(isdefined(vehicle))
		{
			vehicle.id = item.id;
			if(isdefined(vehicle.vehicleclass) && vehicle.vehicleclass != #"helicopter")
			{
				vehicle thread function_956a8ecd();
			}
			vehicle setteam(self.team);
			vehicle.team = self.team;
			if(!isai(vehicle))
			{
				vehicle setowner(self);
			}
			vehicle.owner = self;
			vehicle.ownerentnum = self.entnum;
			if(vehicle isremotecontrol())
			{
				self val::reset(#"item_killstreak", "freezecontrols_allowlook");
				vehicle usevehicle(self, 0);
				self waittill(#"exit_vehicle");
			}
			else if(isdefined(vehicle.var_7feead71))
			{
				vehicle [[vehicle.var_7feead71]](self);
			}
		}
		self val::reset(#"item_killstreak", "freezecontrols_allowlook");
		self takeweapon(remoteweapon);
	}
	else
	{
		self sethintstring(#"hash_37605398dce96965");
		wait(1.5);
		if(isdefined(self))
		{
			self sethintstring(#"");
		}
	}
}

/*
	Name: function_3d113bfb
	Namespace: item_inventory
	Checksum: 0x59D2DDDF
	Offset: 0x108F8
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_3d113bfb()
{
	if(!isplayer(self))
	{
		return;
	}
	if(!isdefined(self.var_a097ccb7))
	{
		self.var_a097ccb7 = 0;
	}
	if(!isstruct(self.inventory) || !isarray(self.inventory.items))
	{
		return;
	}
	cash = 0;
	foreach(item in self.inventory.items)
	{
		if(!isdefined(item) || !isstruct(item.var_a6762160) || item.var_a6762160.itemtype !== #"cash")
		{
			continue;
		}
		cash = cash + (isdefined(item.var_a6762160.var_a6762160.amount) ? item.var_a6762160.amount : 0);
	}
	self.var_a097ccb7 = cash;
	if(self.var_a097ccb7 > 0)
	{
		self clientfield::set("wz_cash_carrying", 1);
	}
	else
	{
		self clientfield::set("wz_cash_carrying", 0);
	}
}

