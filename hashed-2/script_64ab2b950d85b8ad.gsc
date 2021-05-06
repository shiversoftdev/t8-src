// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_2dc48f46bfeac894;
#using script_39bd5b6b799b1c9c;
#using script_3f65948f90646f7c;
#using script_4663ec59d864e437;
#using script_47fb62300ac0bd60;
#using script_67c87580908a0a00;
#using script_6b993fdc7adc35ec;
#using script_6e26f2d648dc4251;
#using script_788472602edbe3b9;
#using script_8abfb58852911dd;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\armor.gsc;

#namespace namespace_b376ff3f;

/*
	Name: function_89f2df9
	Namespace: namespace_b376ff3f
	Checksum: 0xA5EE0F7C
	Offset: 0x550
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
	Checksum: 0x12678C07
	Offset: 0x5A0
	Size: 0x212
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	level.var_67f4fd41 = &function_38d1ea04;
	level.var_dea62998 = &function_bdc03d88;
	level.var_cf16ff75 = &function_a2162b3b;
	level.var_6ec46eeb = &function_d85c5382;
	level.var_f208fb92 = [];
	clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 17000, 3, "int");
	clientfield::function_a8bbc967("hudItems.healthItemstackCount", 5000, 8, "int", 0);
	clientfield::function_a8bbc967("hudItems.equipmentStackCount", 5000, 8, "int", 0);
	ability_player::register_gadget_activation_callbacks(23, &function_f7d084ce, &function_cb475dfc);
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
	Namespace: namespace_b376ff3f
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
		item = function_dfcacdc2(var_bd027dd9);
		self thread function_6e376bb1(var_bd027dd9, 1, 0);
	}
}

/*
	Name: function_299d2131
	Namespace: namespace_b376ff3f
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
	self callback::function_d8abfc3d(#"hash_25663702210244cc", &function_4a257174);
}

/*
	Name: function_4a257174
	Namespace: namespace_b376ff3f
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
		self callback::function_52ac9652(#"hash_25663702210244cc", &function_4a257174);
		self.var_44d52546 = undefined;
		gadget_health_regen::function_7993d50e();
	}
}

/*
	Name: function_fc04b237
	Namespace: namespace_b376ff3f
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
	if(!isdefined(self.pers) || !isdefined(self.pers[#"hash_50096a2a31e9111b"]))
	{
		return weaponoptions;
	}
	camoindex = getcamoindex(weaponoptions);
	var_8968c2ce = function_11c873a(camoindex);
	if(!isdefined(var_8968c2ce) || !isdefined(self.pers[#"hash_50096a2a31e9111b"][var_8968c2ce]))
	{
		return weaponoptions;
	}
	var_bd02cf1 = self.pers[#"hash_50096a2a31e9111b"][var_8968c2ce];
	if(!isdefined(var_bd02cf1) || !isdefined(var_bd02cf1.var_dd54a13b))
	{
		return weaponoptions;
	}
	var_28c04c49 = namespace_bd02cf1::function_c14cb514(weapon);
	weaponstate = var_bd02cf1.var_dd54a13b[var_28c04c49];
	if(!isdefined(weaponstate))
	{
		return weaponoptions;
	}
	var_d1a848d9 = weaponstate.var_d1a848d9;
	if(!isdefined(var_d1a848d9))
	{
		return weaponoptions;
	}
	stage = var_bd02cf1.stages[var_d1a848d9];
	var_7df02232 = stage.var_19b6044e;
	if(!isdefined(var_7df02232))
	{
		return weaponoptions;
	}
	var_b7659ba0 = namespace_bd02cf1::function_385ef18d(weapon);
	weaponoptions = self getbuildkitweaponoptions(var_b7659ba0, var_7df02232, var_d1a848d9);
	return weaponoptions;
}

/*
	Name: function_a2162b3b
	Namespace: namespace_b376ff3f
	Checksum: 0x539C9C06
	Offset: 0xC98
	Size: 0xB2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a2162b3b(var_de56bf19)
{
	if(isplayer(self))
	{
		if(var_de56bf19 === self.var_cc111ddc)
		{
			self.var_cc111ddc = undefined;
		}
		if(var_de56bf19 === self.var_8181d952)
		{
			self.var_8181d952 = undefined;
		}
		if(var_de56bf19 === self.var_cd3bc45b)
		{
			self.var_cd3bc45b = undefined;
		}
		if(var_de56bf19 === self.var_d0015cb3)
		{
			self.var_d0015cb3 = undefined;
		}
		if(var_de56bf19 === self.var_14c391cc)
		{
			self.var_14c391cc = undefined;
		}
	}
}

/*
	Name: function_d62822d5
	Namespace: namespace_b376ff3f
	Checksum: 0x227C52F4
	Offset: 0xD58
	Size: 0x2E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d62822d5()
{
	self.var_cc111ddc = undefined;
	self.var_8181d952 = undefined;
	self.var_cd3bc45b = undefined;
	self.var_d0015cb3 = undefined;
	self.var_14c391cc = undefined;
}

/*
	Name: function_76646dad
	Namespace: namespace_b376ff3f
	Checksum: 0xAE36013D
	Offset: 0xD90
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_76646dad(weapon)
{
	if(weapon.name == #"hash_7cd9fb78e5309f96")
	{
		return 1;
	}
	slot = self gadgetgetslot(weapon);
	return slot == 0;
}

/*
	Name: function_e72d56f9
	Namespace: namespace_b376ff3f
	Checksum: 0x96057029
	Offset: 0xDF0
	Size: 0x124
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e72d56f9(weapon, usecount)
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
			self function_6e376bb1(var_bd027dd9, usecount, 0);
			item = self function_dfcacdc2(var_bd027dd9);
			if(isdefined(item) && item.count > 0)
			{
				self function_c6be9f7f(weapon, item.count);
			}
		}
	}
}

/*
	Name: function_9e4c68e2
	Namespace: namespace_b376ff3f
	Checksum: 0x315A8FC0
	Offset: 0xF20
	Size: 0x82
	Parameters: 1
	Flags: Private, Event
*/
private event function_9e4c68e2(eventstruct)
{
	if(function_f99d2668() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_cd3bc45b = eventstruct.weapon;
	}
}

/*
	Name: function_2f677e9d
	Namespace: namespace_b376ff3f
	Checksum: 0xFAC1EF84
	Offset: 0xFB0
	Size: 0x82
	Parameters: 1
	Flags: Event
*/
event function_2f677e9d(eventstruct)
{
	if(function_f99d2668() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_d0015cb3 = eventstruct.weapon;
	}
}

/*
	Name: function_4776caf4
	Namespace: namespace_b376ff3f
	Checksum: 0x33E1C57D
	Offset: 0x1040
	Size: 0x7BC
	Parameters: 1
	Flags: Private, Event
*/
private event function_4776caf4(eventstruct)
{
	if(function_f99d2668() && isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon))
	{
		self.var_8181d952 = eventstruct.weapon;
		var_994e5c9a = 0;
		equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"hash_3a19c6a9c8caef33", #"dart", #"eq_hawk", #"ultimate_turret");
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
				item = self function_dfcacdc2(var_bd027dd9);
				if(isdefined(item) && item.amount > 0)
				{
					var_aec6fa7f = item.amount;
				}
			}
			self function_e72d56f9(weapon, 1);
		}
		weaponname = eventstruct.weapon.name;
		if(weaponname == #"trophy_system" || weaponname == #"hatchet" || weaponname == #"tomahawk_t8" || weaponname == #"hash_7cd9fb78e5309f96" || weaponname == #"cymbal_monkey")
		{
			if(isdefined(eventstruct.projectile))
			{
				dropitem = eventstruct.projectile;
				dropitem endon(#"death");
				if(weaponname == #"hash_7cd9fb78e5309f96")
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
				var_f77e15f6 = function_d08934c6(weaponname);
				if(!isdefined(var_f77e15f6))
				{
					return;
				}
				/#
					assert(var_f77e15f6.id < 1024);
				#/
				dropitem.id = var_f77e15f6.id;
				dropitem.var_bd027dd9 = namespace_ad5a0cd6::function_1f0def85(dropitem);
				dropitem.var_a6762160 = var_f77e15f6.var_a6762160;
				dropitem.var_8e092725 = 0;
				dropitem.amount = (eventstruct.weapon.weapon.name == #"hash_7cd9fb78e5309f96" ? 1 : 0);
				dropitem.count = 1;
				dropitem clientfield::set("dynamic_item_drop", 1);
				dropitem function_46d7f921(dropitem.id);
				level.var_a4a4012e[dropitem.var_bd027dd9] = dropitem;
			}
		}
		else if(weaponname == #"hash_1888d1367d69b3a7")
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
	Namespace: namespace_b376ff3f
	Checksum: 0x52B806DB
	Offset: 0x1808
	Size: 0xAA
	Parameters: 1
	Flags: Private, Event
*/
private event function_f5883bb1(eventstruct)
{
	self.next_weapon = undefined;
	if(function_f99d2668() && isplayer(self) && isalive(self))
	{
		if(eventstruct.weapon.isprimary && eventstruct.weapon != eventstruct.last_weapon)
		{
			self.next_weapon = eventstruct.weapon;
		}
	}
}

/*
	Name: function_a8c42ee4
	Namespace: namespace_b376ff3f
	Checksum: 0xBD907045
	Offset: 0x18C0
	Size: 0x20A
	Parameters: 1
	Flags: Private, Event
*/
private event function_a8c42ee4(eventstruct)
{
	if(function_f99d2668() && isplayer(self) && isalive(self))
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
	Namespace: namespace_b376ff3f
	Checksum: 0xDCE02222
	Offset: 0x1AD8
	Size: 0xB2
	Parameters: 1
	Flags: Event
*/
event gadget_primed_callback(eventstruct)
{
	player = eventstruct.entity;
	if(function_f99d2668() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		function_d62822d5();
		player.var_cc111ddc = eventstruct.weapon;
	}
}

/*
	Name: gadget_on_callback
	Namespace: namespace_b376ff3f
	Checksum: 0xC4E89291
	Offset: 0x1B98
	Size: 0x188
	Parameters: 1
	Flags: Event
*/
event gadget_on_callback(eventstruct)
{
	player = eventstruct.entity;
	if(function_f99d2668() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		equipments = array(#"hash_3a19c6a9c8caef33", #"dart", #"eq_hawk");
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
	Namespace: namespace_b376ff3f
	Checksum: 0x668EC505
	Offset: 0x1D28
	Size: 0x9E
	Parameters: 1
	Flags: Event
*/
event function_40d8d1ec(eventstruct)
{
	player = eventstruct.entity;
	if(function_f99d2668() && isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon))
	{
		player.var_14c391cc = eventstruct.weapon;
	}
}

/*
	Name: function_2aa4e6cf
	Namespace: namespace_b376ff3f
	Checksum: 0x6FA26A9E
	Offset: 0x1DD0
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event function_2aa4e6cf(eventstruct)
{
	player = self;
	if(function_f99d2668() && isplayer(player) && isalive(player))
	{
		if(eventstruct.seat_index == 0 && player function_2cceca7b())
		{
			player forceoffhandend();
		}
	}
}

/*
	Name: function_38d1ea04
	Namespace: namespace_b376ff3f
	Checksum: 0x568F3FAD
	Offset: 0x1E78
	Size: 0x194
	Parameters: 0
	Flags: Linked, Private
*/
private function function_38d1ea04()
{
	if(isplayer(self) && isdefined(self.inventory))
	{
		var_b619c089 = self.inventory.items[11];
		if(isdefined(var_b619c089) && isdefined(var_b619c089.var_a6762160))
		{
			var_39c78394 = var_b619c089.var_a6762160.var_39c78394;
		}
		if(isdefined(var_39c78394) && var_39c78394 > 0)
		{
			var_dd88a936 = function_4ba8fde(#"hash_2e33ce38d6cda617");
			if(isdefined(var_dd88a936))
			{
				var_7841fe31 = self function_e274f1fe(var_dd88a936, var_39c78394, undefined, 16);
				if(var_7841fe31 > 0)
				{
					function_d7944517(var_dd88a936.id, undefined, var_7841fe31);
				}
			}
		}
		if(var_b619c089.var_bd027dd9 != 32767 && var_b619c089.var_a6762160.itemtype == #"armor")
		{
			self function_5852cb7b(var_b619c089.var_bd027dd9);
		}
	}
}

/*
	Name: function_bdc03d88
	Namespace: namespace_b376ff3f
	Checksum: 0x85D6BBD9
	Offset: 0x2018
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bdc03d88()
{
	if(isplayer(self) && isdefined(self.inventory))
	{
		var_b619c089 = self.inventory.items[11];
		if(var_b619c089.var_bd027dd9 != 32767 && var_b619c089.var_a6762160.itemtype == #"armor")
		{
			var_b619c089.amount = armor::function_4f977182();
			if(function_27cd171b(var_b619c089))
			{
				self setperk(#"hash_4df21972dd2a3a87");
			}
		}
	}
}

/*
	Name: function_434d0c2b
	Namespace: namespace_b376ff3f
	Checksum: 0xBEF2BBF4
	Offset: 0x2100
	Size: 0x2CC
	Parameters: 3
	Flags: Linked, Private
*/
private function function_434d0c2b(itemtype, var_da328e7b, var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(function_7a600918(itemtype));
	#/
	/#
		assert(isarray(var_da328e7b));
	#/
	items = [];
	var_e3c48c83 = namespace_ad5a0cd6::function_d73e17cb(var_ab9610ad);
	foreach(item in self.inventory.items)
	{
		if(item.id == 32767)
		{
			continue;
		}
		var_b74300d3 = namespace_ad5a0cd6::function_d73e17cb(item.var_a6762160);
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
	Name: function_c42f2717
	Namespace: namespace_b376ff3f
	Checksum: 0x658930F9
	Offset: 0x23D8
	Size: 0x2CC
	Parameters: 3
	Flags: Linked, Private
*/
private function function_c42f2717(itemtype, var_da328e7b, var_bcc2655a)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(function_7a600918(itemtype));
	#/
	/#
		assert(isarray(var_da328e7b));
	#/
	if(!isdefined(var_bcc2655a))
	{
		return;
	}
	items = [];
	var_c7837092 = namespace_ad5a0cd6::function_d73e17cb(var_bcc2655a);
	foreach(item in self.inventory.items)
	{
		if(item.id == 32767)
		{
			continue;
		}
		var_b74300d3 = namespace_ad5a0cd6::function_d73e17cb(item.var_a6762160);
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
	Namespace: namespace_b376ff3f
	Checksum: 0x4A9525AF
	Offset: 0x26B0
	Size: 0x1E4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9da31874(itemtype)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(function_7a600918(itemtype));
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
		currentindex = currentindex + 1 % items.size;
		self.inventory.var_a0290b96[itemtype] = currentindex;
	}
	return items[currentindex];
}

/*
	Name: function_283a29c8
	Namespace: namespace_b376ff3f
	Checksum: 0x2A50DC8A
	Offset: 0x28A0
	Size: 0x2C4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_283a29c8(var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(function_fe402108())
	{
		return;
	}
	item = function_434d0c2b(#"equipment", array(#"hash_53a2516ec1d3a096", #"hash_3074c41bb205ed8c", #"hash_2b5027622c0b6d07", #"hash_4cec712579f1202f", #"hash_57504010ce1814dc", #"hash_5752a7e130ea202a", #"hash_4edf613e9b9032da", #"hash_28da32d9304b6296", #"hash_4a2739676c12d92a", #"hash_140318e970e711ce", #"hash_50b970644e43947b", #"hash_627144159973c325", #"hash_1a7edb90a484158b", #"hash_745d80b3e4f28da1", #"hash_56e573d15c6402bc", #"hash_213093d947c30be6", #"hash_7e8c84081fafaea4", #"hash_665eccfe5d58f636", #"hash_68b64725de40edae", #"hash_2b06a3f530395182", #"hash_16a1f841da0b877d", #"hash_1242946e889704c7", #"hash_14b578e446580ad5", #"hash_300914db9caf4033", #"hash_3a3d830a9a4559d4", #"hash_743b859c2367ff54", #"hash_5e5f2ed57ac4601f", #"hash_105f32560e2fb0fe", #"hash_18056dab055a44c9", #"hash_2e8b13391f6544", #"hash_735d22a674b7f8c0", #"hash_7f877a112c8c4187", #"hash_7aca06dcd83beef3"), var_ab9610ad);
	if(isdefined(item))
	{
		function_c8bedf1b(item);
	}
}

/*
	Name: function_2e10e66e
	Namespace: namespace_b376ff3f
	Checksum: 0x90AFECE1
	Offset: 0x2B70
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2e10e66e(var_ab9610ad = undefined)
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
		function_2dab8a7f(item);
	}
}

/*
	Name: function_a7d62e18
	Namespace: namespace_b376ff3f
	Checksum: 0x293B957
	Offset: 0x2C40
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a7d62e18(var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(function_fe402108())
	{
		return;
	}
	item = function_434d0c2b(#"health", array(#"hash_1abfcce0e9955057", #"hash_ff50c93155e445f", #"hash_80292d121740f6f", #"hash_45ced3880667df22"), var_ab9610ad);
	if(isdefined(item))
	{
		function_11fc9fa9(item);
	}
}

/*
	Name: function_9d805044
	Namespace: namespace_b376ff3f
	Checksum: 0xE6C59CF4
	Offset: 0x2D40
	Size: 0x13A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9d805044(itemtype, var_ab9610ad = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstring(itemtype) || function_7a600918(itemtype));
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
	Namespace: namespace_b376ff3f
	Checksum: 0x2419E33D
	Offset: 0x2E88
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d08934c6(equipment)
{
	var_b74300d3 = undefined;
	switch(equipment)
	{
		case "hatchet":
		{
			var_b74300d3 = #"hash_5752a7e130ea202a";
			break;
		}
		case "tomahawk_t8":
		{
			var_b74300d3 = #"hash_4edf613e9b9032da";
			break;
		}
		case "hash_7cd9fb78e5309f96":
		{
			var_b74300d3 = #"hash_65e1752e269c2960";
			break;
		}
		case "cymbal_monkey":
		{
			var_b74300d3 = #"hash_5e5f2ed57ac4601f";
			break;
		}
		case "trophy_system":
		{
			var_b74300d3 = #"hash_1242946e889704c7";
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
	Namespace: namespace_b376ff3f
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
	item.var_3a7d925b = undefined;
	item.var_2febbde5 = undefined;
	return item;
}

/*
	Name: function_27cd171b
	Namespace: namespace_b376ff3f
	Checksum: 0xD1C4B1F5
	Offset: 0x3040
	Size: 0x60
	Parameters: 1
	Flags: Linked, Private
*/
private function function_27cd171b(var_b619c089)
{
	if(!isdefined(var_b619c089.amount))
	{
		return 0;
	}
	if(var_b619c089.amount <= 0)
	{
		return 1;
	}
	return var_b619c089.amount / var_b619c089.var_a6762160.amount <= 0.5;
}

/*
	Name: function_d85c5382
	Namespace: namespace_b376ff3f
	Checksum: 0xF2C1F03A
	Offset: 0x30A8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_d85c5382(var_711e35e5, player)
{
	level.var_f208fb92[level.var_f208fb92.size] = var_711e35e5;
	arrayremovevalue(level.var_f208fb92, undefined);
}

/*
	Name: function_d2f05352
	Namespace: namespace_b376ff3f
	Checksum: 0x610D4CAE
	Offset: 0x3100
	Size: 0x280
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d2f05352()
{
	level endon(#"game_ended");
	while(true)
	{
		players = getplayers();
		time = gettime();
		for(playerindex = 0; playerindex < players.size; playerindex++)
		{
			if(playerindex + 1 % 15 == 0)
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
					player function_6e376bb1(item.var_bd027dd9, 1, 0);
				}
			}
		}
		players = undefined;
		waitframe(1);
	}
}

/*
	Name: function_a4413333
	Namespace: namespace_b376ff3f
	Checksum: 0xE47B86FB
	Offset: 0x3388
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a4413333()
{
	/#
		assert(isplayer(self));
	#/
	var_78d7ac4a = self.inventory.items[10];
	if(var_78d7ac4a.var_bd027dd9 !== 32767)
	{
		self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(var_78d7ac4a.var_a6762160));
	}
	var_7f695eed = self.inventory.items[12];
	if(var_7f695eed.var_bd027dd9 !== 32767)
	{
		self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(var_7f695eed.var_a6762160));
	}
}

/*
	Name: function_6c36ab6b
	Namespace: namespace_b376ff3f
	Checksum: 0x44B443D6
	Offset: 0x3490
	Size: 0x3E4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6c36ab6b()
{
	self function_e6f9e3cd();
	foreach(item in self.inventory.items)
	{
		var_a6762160 = item.var_a6762160;
		if(isdefined(var_a6762160) && (!(isdefined(var_a6762160.consumable) && var_a6762160.consumable)) && isarray(var_a6762160.var_7e21e375))
		{
			foreach(var_9de7969b in var_a6762160.var_7e21e375)
			{
				self function_b5feff95(var_9de7969b.talent);
			}
		}
	}
	foreach(item in self.inventory.consumed)
	{
		var_a6762160 = item.var_a6762160;
		if(isdefined(var_a6762160) && isarray(var_a6762160.var_7e21e375))
		{
			foreach(var_9de7969b in var_a6762160.var_7e21e375)
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
	var_344a1b3d = self.inventory.items[11];
	if(var_344a1b3d.var_bd027dd9 != 32767 && var_344a1b3d.var_a6762160.itemtype == #"armor")
	{
		if(function_27cd171b(var_344a1b3d))
		{
			self setperk(#"hash_4df21972dd2a3a87");
		}
	}
	if((isdefined(getgametypesetting(#"hash_24918193d72a5866")) ? getgametypesetting(#"hash_24918193d72a5866") : 0))
	{
		self setperk(#"hash_1a1660312a4db585");
		self setperk(#"specialty_fallheight");
	}
}

/*
	Name: function_60706bdb
	Namespace: namespace_b376ff3f
	Checksum: 0xB619EC1C
	Offset: 0x3880
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_60706bdb(var_bd027dd9)
{
	/#
		assert(isplayer(self));
	#/
	item = function_dfcacdc2(var_bd027dd9);
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
	Namespace: namespace_b376ff3f
	Checksum: 0x24F6E5B7
	Offset: 0x3978
	Size: 0x19A
	Parameters: 8
	Flags: Linked, Private
*/
private function function_d7944517(var_d8138db2, weapon, count, amount, var_be90d3da = 0, var_7cab8e12 = undefined, targetname = undefined, attachments = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(namespace_ad5a0cd6::function_2c7fc531(var_d8138db2));
	#/
	self endon(#"death");
	droppos = var_7cab8e12;
	if(!var_be90d3da)
	{
		forward = anglestoforward(self.angles);
		droppos = self.origin + 36 * forward + vectorscale((0, 0, 1), 10);
	}
	return self item_drop::drop_item(weapon, count, amount, var_d8138db2, droppos, (0, randomintrange(0, 360), 0), var_be90d3da, 0, targetname, undefined, attachments);
}

/*
	Name: function_d116a346
	Namespace: namespace_b376ff3f
	Checksum: 0xFCEA93E9
	Offset: 0x3B20
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d116a346(slot, weapon)
{
	if(function_f99d2668() && isplayer(self))
	{
		self.var_e42fb511 = weapon;
	}
}

/*
	Name: function_f7d084ce
	Namespace: namespace_b376ff3f
	Checksum: 0xBE6AA69B
	Offset: 0x3B78
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f7d084ce(slot, weapon)
{
	if(function_f99d2668() && isplayer(self))
	{
		self.var_d6cd7d80 = weapon;
	}
}

/*
	Name: function_cb475dfc
	Namespace: namespace_b376ff3f
	Checksum: 0xC7ECE76C
	Offset: 0x3BD0
	Size: 0x52
	Parameters: 2
	Flags: Linked, Private
*/
private function function_cb475dfc(slot, weapon)
{
	if(function_f99d2668() && isplayer(self))
	{
		self.var_d6cd7d80 = undefined;
		self.var_e42fb511 = undefined;
	}
}

/*
	Name: function_2cceca7b
	Namespace: namespace_b376ff3f
	Checksum: 0xBB6D03B0
	Offset: 0x3C30
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2cceca7b()
{
	return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

/*
	Name: function_c1cef1ec
	Namespace: namespace_b376ff3f
	Checksum: 0x55AF7D17
	Offset: 0x3C90
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c1cef1ec(weapon)
{
	if(weapon != self getcurrentoffhand())
	{
		return 0;
	}
	return self function_2cceca7b();
}

/*
	Name: function_c6be9f7f
	Namespace: namespace_b376ff3f
	Checksum: 0x4A7BD3CA
	Offset: 0x3CE0
	Size: 0x1F4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c6be9f7f(weapon, ammo)
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
		if("ammo" != weapon.var_11389297)
		{
			return;
		}
		if(weapon.name == #"eq_tripwire")
		{
			newpower = weapon.gadget_powermax;
			ammo = weapon.clipsize;
		}
		else if(!weapon.clipsize)
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
		power = self gadgetpowerset(slot, newpower);
		self setweaponammoclip(weapon, ammo);
		debug_print("set_gadget_power: " + power + ", ammo: " + ammo, weapon);
	}
}

/*
	Name: function_ee9ce1c4
	Namespace: namespace_b376ff3f
	Checksum: 0x754AB80B
	Offset: 0x3EE0
	Size: 0x9E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ee9ce1c4(var_a6762160, var_dfe6c7e5 = 0)
{
	self endon(#"death");
	self.var_10abd91d = 1;
	self function_5110caa3(namespace_ad5a0cd6::function_35e06774(var_a6762160), level.nullprimaryoffhand);
	self function_c6be9f7f(level.nullprimaryoffhand, 0);
	self.var_10abd91d = 0;
}

/*
	Name: function_8214f1b6
	Namespace: namespace_b376ff3f
	Checksum: 0xFDE038DA
	Offset: 0x3F88
	Size: 0xF6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8214f1b6(var_a6762160, var_dfe6c7e5 = 0)
{
	self endon(#"death");
	self.var_10abd91d = 1;
	weapon = namespace_ad5a0cd6::function_35e06774(var_a6762160);
	slot = self gadgetgetslot(weapon);
	if(slot >= 0 && slot < 3)
	{
		while(self function_af359de(slot))
		{
			waitframe(1);
		}
	}
	self function_5110caa3(weapon, level.var_ef61b4b5);
	self.var_10abd91d = 0;
}

/*
	Name: function_bba770de
	Namespace: namespace_b376ff3f
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
	for(index = 0; index < self.inventory.items.size && index < 16 + 1; index++)
	{
		var_b619c089 = self.inventory.items[index];
		if(!isdefined(var_b619c089.var_a6762160))
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
	Checksum: 0x900EFE0C
	Offset: 0x4238
	Size: 0x14E
	Parameters: 2
	Flags: Linked
*/
function function_e106cbe9(item, var_1326fcc7 = undefined)
{
	/#
		assert(isplayer(self));
	#/
	var_a6762160 = item.var_a6762160;
	var_95162a97 = var_a6762160.weapon;
	var_1326fcc7 = (isdefined(var_1326fcc7) ? var_1326fcc7 : (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1));
	var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, var_95162a97);
	currentammostock = self getweaponammostock(var_95162a97);
	var_9b9ba643 = var_2f399b51 - currentammostock;
	addammo = int(min(var_1326fcc7, var_9b9ba643));
	return addammo > 0;
}

/*
	Name: function_550fcb41
	Namespace: namespace_b376ff3f
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
		return 0;
	}
	var_590b4c51 = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
	if(var_590b4c51 <= 1)
	{
		return 0;
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
		if(self.inventory.items[i].count < var_590b4c51)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_85645978
	Namespace: namespace_b376ff3f
	Checksum: 0x6E7A5921
	Offset: 0x4510
	Size: 0xCE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_85645978(item)
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
	Namespace: namespace_b376ff3f
	Checksum: 0x9B4606CF
	Offset: 0x45E8
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3fe6ef04()
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
	Name: function_7730442c
	Namespace: namespace_b376ff3f
	Checksum: 0xBBA7AB5E
	Offset: 0x46E0
	Size: 0x5C8
	Parameters: 1
	Flags: Linked
*/
function function_7730442c(item)
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
			self playsoundtoplayer(#"hash_7527c43b92789608", self);
			return 0;
		}
		currentweapon = self getcurrentweapon();
		if(isdefined(currentweapon) && (isdefined(currentweapon.var_29d24e37) && currentweapon.var_29d24e37))
		{
			self playsoundtoplayer(#"hash_7527c43b92789608", self);
			return 0;
		}
	}
	if(item.var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
	{
		return function_6d647220(item);
	}
	consumeditem = self function_85645978(item);
	if(!isdefined(consumeditem) && self function_3fe6ef04() >= 10)
	{
		self playsoundtoplayer(#"hash_7527c43b92789608", self);
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
			var_b619c089 = self.inventory.items[index];
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
		consumeditem.starttime = gettime();
		consumeditem.endtime = consumeditem.starttime + duration;
	}
	self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
	level callback::callback(#"hash_27e13b9438e33053", self);
	self function_b00db06(11, item.var_bd027dd9);
	self function_db2abc4(item);
	self function_6c36ab6b();
	if(isdefined(consumeditem.var_a6762160) && isdefined(consumeditem.var_a6762160.var_7e21e375) && isarray(consumeditem.var_a6762160.var_7e21e375))
	{
		foreach(talent in consumeditem.var_a6762160.var_7e21e375)
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
	Namespace: namespace_b376ff3f
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
		return 0;
	}
	if(!has_armor())
	{
		return 0;
	}
	if(!isdefined(self.armor) || !isdefined(self.maxarmor))
	{
		return 0;
	}
	if(self.armor == self.maxarmor)
	{
		return 0;
	}
	self function_6e376bb1(item.var_bd027dd9, 1);
	var_344a1b3d = undefined;
	if(isplayer(self) && isdefined(self.inventory))
	{
		var_344a1b3d = self.inventory.items[11];
		if(!isdefined(var_344a1b3d) || var_344a1b3d.var_bd027dd9 == 32767 || var_344a1b3d.var_a6762160.itemtype != #"armor")
		{
			return 0;
		}
	}
	if(isdefined(self.var_3f1410dd))
	{
		self.var_3f1410dd.var_2b021e34 = self.var_3f1410dd.var_2b021e34 + int(min((isdefined(var_344a1b3d.var_a6762160.var_a6762160.var_a3aa1ca2) ? var_344a1b3d.var_a6762160.var_a3aa1ca2 : 0), self.maxarmor - self.armor));
		self.var_3f1410dd.var_7352c057++;
	}
	self.armor = int(min(self.armor + (isdefined(var_344a1b3d.var_a6762160.var_a6762160.var_a3aa1ca2) ? var_344a1b3d.var_a6762160.var_a3aa1ca2 : 0), self.maxarmor));
	function_bdc03d88();
	self function_6c36ab6b();
	self function_db2abc4(item);
	return 1;
}

/*
	Name: function_20ecd64d
	Namespace: namespace_b376ff3f
	Checksum: 0x43C78276
	Offset: 0x4F98
	Size: 0x364
	Parameters: 0
	Flags: Linked
*/
function function_20ecd64d()
{
	/#
		assert(isplayer(self));
	#/
	var_bcc2655a = undefined;
	var_7f695eed = self.inventory.items[12];
	if(var_7f695eed.var_bd027dd9 !== 32767)
	{
		var_bcc2655a = var_7f695eed.var_a6762160;
	}
	if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1))
	{
		item = function_c42f2717(#"equipment", array(#"hash_53a2516ec1d3a096", #"hash_3074c41bb205ed8c", #"hash_2b5027622c0b6d07", #"hash_4cec712579f1202f", #"hash_57504010ce1814dc", #"hash_5752a7e130ea202a", #"hash_4edf613e9b9032da", #"hash_28da32d9304b6296", #"hash_4a2739676c12d92a", #"hash_140318e970e711ce", #"hash_50b970644e43947b", #"hash_627144159973c325", #"hash_1a7edb90a484158b", #"hash_745d80b3e4f28da1", #"hash_56e573d15c6402bc", #"hash_213093d947c30be6", #"hash_7e8c84081fafaea4", #"hash_665eccfe5d58f636", #"hash_68b64725de40edae", #"hash_2b06a3f530395182", #"hash_16a1f841da0b877d", #"hash_1242946e889704c7", #"hash_14b578e446580ad5", #"hash_300914db9caf4033", #"hash_3a3d830a9a4559d4", #"hash_743b859c2367ff54", #"hash_5e5f2ed57ac4601f", #"hash_105f32560e2fb0fe", #"hash_18056dab055a44c9", #"hash_2e8b13391f6544", #"hash_735d22a674b7f8c0", #"hash_7f877a112c8c4187", #"hash_7aca06dcd83beef3"), var_bcc2655a);
	}
	else
	{
		item = function_9da31874(#"equipment");
	}
	if(isdefined(item))
	{
		function_c8bedf1b(item);
	}
	else
	{
		self playsoundtoplayer(#"hash_7527c43b92789608", self);
	}
}

/*
	Name: function_e46ef859
	Namespace: namespace_b376ff3f
	Checksum: 0x3A11E4D0
	Offset: 0x5308
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_e46ef859()
{
	/#
		assert(isplayer(self));
	#/
	var_bcc2655a = undefined;
	var_78d7ac4a = self.inventory.items[10];
	if(var_78d7ac4a.var_bd027dd9 !== 32767)
	{
		var_bcc2655a = var_78d7ac4a.var_a6762160;
	}
	if(getdvarint(#"hash_4cd4e3d15cf4ee7e", 1))
	{
		item = function_c42f2717(#"health", array(#"hash_1abfcce0e9955057", #"hash_ff50c93155e445f", #"hash_80292d121740f6f", #"hash_45ced3880667df22"), var_bcc2655a);
	}
	else
	{
		item = function_9da31874(#"health");
	}
	if(isdefined(item))
	{
		function_11fc9fa9(item);
	}
	else
	{
		self playsoundtoplayer(#"hash_7527c43b92789608", self);
	}
}

/*
	Name: function_9ba10b94
	Namespace: namespace_b376ff3f
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
	var_ad3db3b1 = [];
	var_8e198ed3 = [];
	foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
	{
		var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_259f58f3);
		item = self.inventory.items[var_f9f8c0b5];
		if(item.var_bd027dd9 != 32767)
		{
			var_ad3db3b1[var_ad3db3b1.size] = namespace_ad5a0cd6::function_f4a8d375(item.id);
			var_8e198ed3[var_8e198ed3.size] = item.id;
			function_5852cb7b(item.var_bd027dd9, 0, 1);
		}
	}
	function_418f9eb8(self.inventory.items[slotid].var_bd027dd9);
	for(index = 0; index < var_8e198ed3.size; index++)
	{
		self thread function_d7944517(var_8e198ed3[index], var_ad3db3b1[index], 1, 1);
	}
}

/*
	Name: function_9d102bbd
	Namespace: namespace_b376ff3f
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
	if(!namespace_ad5a0cd6::can_pick_up(var_b72297c2))
	{
		return 0;
	}
	if(!isdefined(var_b72297c2) || !isdefined(var_b72297c2.var_a6762160) || var_b72297c2.var_a6762160.itemtype !== #"weapon")
	{
		return 0;
	}
	var_64d58696 = function_dfcacdc2(var_bd027dd9);
	if(!isdefined(var_64d58696))
	{
		return 0;
	}
	if(!isdefined(var_64d58696.var_a6762160) || var_64d58696.var_a6762160.itemtype != #"weapon")
	{
		return 0;
	}
	slotid = function_b246c573(var_bd027dd9);
	if(!isdefined(slotid))
	{
		return 0;
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(var_64d58696);
	if(isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon)))
	{
		return 0;
	}
	if(isentity(var_b72297c2))
	{
		var_b72297c2.var_8e092725 = gettime();
	}
	else
	{
		function_54ca5536(var_b72297c2.id, gettime());
	}
	dropweapons = [];
	var_cf804066 = [];
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
					dropweapons[dropweapons.size] = namespace_ad5a0cd6::function_f4a8d375(item.id);
					var_cf804066[var_cf804066.size] = item.id;
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
			var_84704ed7 = attachment;
			if(!isdefined(var_84704ed7))
			{
				continue;
			}
			if(!isdefined(var_84704ed7.var_a6762160))
			{
				if(!namespace_ad5a0cd6::function_7363384a(attachment.var_6be1bec7))
				{
					continue;
				}
				var_84704ed7 = function_4ba8fde(attachment.var_6be1bec7);
				if(!isdefined(var_84704ed7))
				{
					continue;
				}
			}
			var_259f58f3 = namespace_a0d533d1::function_837f4a57(var_84704ed7.var_a6762160);
			if(!isdefined(var_259f58f3))
			{
				continue;
			}
			if(!isdefined(var_cc9e34fb[var_259f58f3]))
			{
				var_cc9e34fb[var_259f58f3] = var_84704ed7.var_a6762160;
				continue;
			}
			dropweapons[dropweapons.size] = namespace_ad5a0cd6::function_f4a8d375(var_84704ed7.id);
			var_cf804066[var_cf804066.size] = var_84704ed7.id;
		}
	}
	var_b72297c2.attachments = [];
	foreach(var_fe35755b in var_cc9e34fb)
	{
		if(isdefined(var_fe35755b.name))
		{
			var_84704ed7 = function_4ba8fde(var_fe35755b.name);
			var_e38a0464 = function_520b16d6();
			var_e38a0464.count = 1;
			var_e38a0464.id = var_84704ed7.id;
			var_e38a0464.var_bd027dd9 = var_e38a0464.id;
			var_e38a0464.var_a6762160 = var_84704ed7.var_a6762160;
			var_b72297c2.attachments[var_b72297c2.attachments.size] = var_e38a0464;
		}
	}
	for(index = 0; index < var_14174938.size; index++)
	{
		var_ddd377f2 = var_14174938[index];
		function_5852cb7b(var_ddd377f2, 0, 1);
	}
	self function_418f9eb8(var_bd027dd9);
	for(index = 0; index < var_cf804066.size; index++)
	{
		self thread function_d7944517(var_cf804066[index], dropweapons[index], 1, 1);
	}
	item_world::function_de2018e3(var_b72297c2, self, slotid);
	item_world::function_7730442c(var_b72297c2);
	return 1;
}

/*
	Name: function_fba40e6c
	Namespace: namespace_b376ff3f
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
	if(!namespace_ad5a0cd6::can_pick_up(item))
	{
		return 0;
	}
	var_158e86a3 = self function_e66dcff5(item, 1);
	dropitem = self.inventory.items[var_158e86a3];
	self function_85287396(1);
	droppeditem = self function_418f9eb8(dropitem.var_bd027dd9);
	slotid = function_e66dcff5(item, 1);
	if(!isdefined(item))
	{
		self item_world::function_de2018e3(dropitem, self, var_158e86a3);
		item_world::function_7730442c(droppeditem);
		var_b619c089 = self function_8babc9f9(dropitem.var_a6762160);
		if(isdefined(var_b619c089))
		{
			self function_5a0ba107(var_b619c089.var_bd027dd9);
		}
		self function_85287396(0);
		return;
	}
	var_a6762160 = item.var_a6762160;
	self item_world::function_de2018e3(item, self, slotid);
	var_b619c089 = self function_8babc9f9(var_a6762160);
	item_world::function_7730442c(item);
	if(isdefined(var_b619c089))
	{
		self function_5a0ba107(var_b619c089.var_bd027dd9);
	}
	self function_85287396(0);
}

/*
	Name: function_e66dcff5
	Namespace: namespace_b376ff3f
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
		foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
		{
			if(self.inventory.items[slotid].var_bd027dd9 === 32767)
			{
				return slotid;
			}
		}
		var_64d58696 = function_230ceec4(self.currentweapon);
		if(!isdefined(var_64d58696))
		{
			return;
		}
		return function_b246c573(var_64d58696.var_bd027dd9);
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
		if(namespace_ad5a0cd6::function_41f06d9d(item.var_a6762160))
		{
			return 14;
		}
		return 15;
	}
	if(item.var_a6762160.itemtype == #"hash_56d6621e6c4caf07")
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
			var_4838b749 = (var_4838b749 == 16 + 1 ? 16 + 1 + 6 + 1 : 16 + 1);
		}
		if(isdefined(var_4838b749))
		{
			var_f0dc4e93 = namespace_ad5a0cd6::function_970b8d86(self, var_4838b749);
			if(self.inventory.items[var_4838b749].var_bd027dd9 != 32767)
			{
				var_ceefbd10 = namespace_a0d533d1::function_837f4a57(item.var_a6762160);
				var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
				var_64d58696 = self function_dfcacdc2(var_f0dc4e93);
				attachmentname = namespace_a0d533d1::function_2ced1d34(var_64d58696, item.var_a6762160, 1);
				if(isdefined(attachmentname))
				{
					return var_f9f8c0b5;
				}
			}
		}
	}
	if(isdefined(item.var_a6762160.stackable) && item.var_a6762160.stackable)
	{
		weapon = namespace_ad5a0cd6::function_35e06774(item.var_a6762160);
		if(isdefined(weapon))
		{
			var_590b4c51 = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
			if(var_590b4c51 > 1)
			{
				foreach(i, spawnitem in self.inventory.items)
				{
					if(spawnitem.id == 32767)
					{
						continue;
					}
					var_b619c089 = function_b1702735(spawnitem.id);
					if(var_b619c089.var_a6762160.name != item.var_a6762160.name)
					{
						continue;
					}
					if(self.inventory.items[i].count < var_590b4c51)
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
	Namespace: namespace_b376ff3f
	Checksum: 0x8BCA08EB
	Offset: 0x6868
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function drop_armor(var_be90d3da = 0, var_7cab8e12 = undefined, targetname = undefined)
{
	/#
		assert(isplayer(self));
	#/
	if(self has_armor())
	{
		item = self.inventory.items[11];
		self thread function_418f9eb8(item.var_bd027dd9, var_be90d3da, var_7cab8e12, targetname);
		return 1;
	}
	return 0;
}

/*
	Name: function_d86d7ac7
	Namespace: namespace_b376ff3f
	Checksum: 0x38C449ED
	Offset: 0x6958
	Size: 0x106
	Parameters: 3
	Flags: Linked
*/
function function_d86d7ac7(var_be90d3da = 0, var_7cab8e12 = undefined, targetname = undefined)
{
	/#
		assert(isplayer(self));
	#/
	for(index = self.inventory.var_c212de25; index < 10; index++)
	{
		var_b619c089 = self.inventory.items[index];
		if(var_b619c089.var_bd027dd9 != 32767)
		{
			self thread function_418f9eb8(var_b619c089.var_bd027dd9, var_be90d3da, var_7cab8e12, targetname);
		}
	}
}

/*
	Name: function_418f9eb8
	Namespace: namespace_b376ff3f
	Checksum: 0x488E49E
	Offset: 0x6A68
	Size: 0x6C8
	Parameters: 5
	Flags: Linked
*/
function function_418f9eb8(var_bd027dd9, var_be90d3da = 0, var_7cab8e12 = undefined, targetname = undefined, var_4a6f595d = 1)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death");
	dropitem = undefined;
	item = function_dfcacdc2(var_bd027dd9);
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
				dropitem = self function_d7944517(item.id, weapon, item.count, item.amount, var_be90d3da, var_7cab8e12, targetname, (isdefined(item.attachments) ? item.attachments : array()));
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
			function_d86d7ac7(var_be90d3da, var_7cab8e12, targetname);
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
				dropitem = self function_d7944517(item.id, weapon, count, amount, var_be90d3da, var_7cab8e12, targetname, (isdefined(item.attachments) ? item.attachments : array()));
			}
			else
			{
				consumeditem = function_85645978(item);
				if(isdefined(consumeditem))
				{
					var_ee0e9af9 = [];
					for(index = 0; index < 10; index++)
					{
						var_b619c089 = self.inventory.items[index];
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
					consumeditem.endtime = consumeditem.endtime - remaining / var_ee0e9af9.size + 1;
					for(index = 0; index < var_ee0e9af9.size; index++)
					{
						var_b619c089 = var_ee0e9af9[index];
						var_b619c089.starttime = consumeditem.starttime;
						var_b619c089.endtime = consumeditem.endtime;
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
					function_5852cb7b(attachment.var_bd027dd9);
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
	Name: function_11089ed8
	Namespace: namespace_b376ff3f
	Checksum: 0xC4D0DCDB
	Offset: 0x7138
	Size: 0x22E
	Parameters: 2
	Flags: Linked
*/
function function_11089ed8(item, var_aec6fa7f)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(item));
	#/
	self function_db2abc4(item);
	var_a6762160 = item.var_a6762160;
	var_95162a97 = var_a6762160.weapon;
	var_1326fcc7 = (isdefined(var_aec6fa7f) ? var_aec6fa7f : (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1));
	var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, var_95162a97);
	currentammostock = self getweaponammostock(var_95162a97);
	var_9b9ba643 = var_2f399b51 - currentammostock;
	addammo = int(min(var_1326fcc7, var_9b9ba643));
	if(isdefined(var_95162a97) && var_95162a97 != level.weaponnone)
	{
		self.inventory.ammo[var_95162a97.name] = item.id;
		self function_fc9f8b05(var_95162a97, addammo);
		if(isdefined(var_aec6fa7f))
		{
			return var_1326fcc7 - addammo;
		}
		return 0;
	}
	/#
		assertmsg("" + var_a6762160.name + "");
	#/
	return var_1326fcc7 - addammo;
}

/*
	Name: function_4cde30fa
	Namespace: namespace_b376ff3f
	Checksum: 0x85EAEFE0
	Offset: 0x7370
	Size: 0x196
	Parameters: 2
	Flags: Linked
*/
function function_4cde30fa(var_b619c089, var_a6762160)
{
	if(game.state == "pregame" || !isplayer(self) || isdefined(self.var_3f1410dd) || !isdefined(var_b619c089) || !isdefined(var_a6762160))
	{
		return;
	}
	self.var_3f1410dd = {#died:0, #broken:0, #hash_2b021e34:0, #hash_7352c057:0, #damage_taken:0, #tier:(isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1), #hash_4550558c:(isdefined(var_b619c089.amount) ? var_b619c089.amount : 0), #end_time:0, #start_time:function_f8d53445(), #player_xuid:int(self getxuid(1))};
}

/*
	Name: function_bef83dc6
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
	Checksum: 0xB0D6D5D1
	Offset: 0x7610
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function equip_armor(item)
{
	var_a6762160 = item.var_a6762160;
	var_b619c089 = function_dfcacdc2(item.var_bd027dd9);
	if(!isdefined(var_b619c089))
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
	self armor::set_armor(var_b619c089.amount, (isdefined(var_a6762160.amount) ? var_a6762160.amount : 0), (isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1), (isdefined(var_a6762160.var_99c0cb08) ? var_a6762160.var_99c0cb08 : 1), (isdefined(var_a6762160.var_2ee21ae6) ? var_a6762160.var_2ee21ae6 : 1), (isdefined(var_a6762160.var_c690c73d) ? var_a6762160.var_c690c73d : 1), (isdefined(var_a6762160.var_99edb6a3) ? var_a6762160.var_99edb6a3 : 1), (isdefined(var_a6762160.var_22c3ab38) ? var_a6762160.var_22c3ab38 : 1), (isdefined(var_a6762160.var_9f307988) ? var_a6762160.var_9f307988 : 1), (isdefined(var_a6762160.var_7a80f06e) ? var_a6762160.var_7a80f06e : 1), (isdefined(var_a6762160.var_da5a2805) ? var_a6762160.var_da5a2805 : 1), (isdefined(var_a6762160.var_f2902d7b) ? var_a6762160.var_f2902d7b : 1), var_a6762160.var_19f48bbe);
	self function_4cde30fa(var_b619c089, var_a6762160);
	self.inventory.items[11] = var_b619c089;
	self function_b00db06(6, item.var_bd027dd9);
	self clientfield::set_player_uimodel("hudItems.armorType", (isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1));
}

/*
	Name: function_e258cef5
	Namespace: namespace_b376ff3f
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
	item = function_dfcacdc2(var_bd027dd9);
	if(!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != itemtype)
	{
		return undefined;
	}
	return item;
}

/*
	Name: function_224c09c9
	Namespace: namespace_b376ff3f
	Checksum: 0x626C498B
	Offset: 0x7988
	Size: 0x45C
	Parameters: 5
	Flags: Linked
*/
function function_224c09c9(item, var_610add8d, var_d6f68de7, var_a3a17c55 = 1, switchweapon = 1)
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
		var_4767e61d = function_b246c573(item.var_bd027dd9);
		if(!isdefined(var_4767e61d))
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
			function_26c87da8(var_4767e61d, var_dd6937a8);
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
		function_2b4d7b66(var_4e2a1ed8, switchweapon, undefined, var_a3a17c55, 0);
		self function_db2abc4(item);
		if(var_97cc940d)
		{
			function_224c09c9(var_2134bf0d, var_d6f68de7, undefined, var_a3a17c55, 1);
		}
	}
}

/*
	Name: function_2dab8a7f
	Namespace: namespace_b376ff3f
	Checksum: 0x81BA65E8
	Offset: 0x7DF0
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_2dab8a7f(item)
{
	/#
		assert(isplayer(self));
	#/
	var_b619c089 = function_dfcacdc2(item.var_bd027dd9);
	if(!isdefined(var_b619c089))
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
	self.inventory.items[13] = var_b619c089;
	self function_b00db06(6, item.var_bd027dd9);
	self clientfield::set_player_uimodel("hudItems.hasBackpack", 1);
}

/*
	Name: debug_print
	Namespace: namespace_b376ff3f
	Checksum: 0xAC12DAC
	Offset: 0x7F68
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function debug_print(message, weapon)
{
	/#
		if(getdvarint(#"hash_33bb7d70dd139207", 0) > 0)
		{
			weaponname = "";
			if(isdefined(weapon))
			{
				weaponname = "" + function_9e72a96(weapon.name);
			}
			self iprintlnbold("" + message + weaponname);
			println("" + self.playername + "" + message + weaponname);
		}
	#/
}

/*
	Name: function_c8bedf1b
	Namespace: namespace_b376ff3f
	Checksum: 0x84C7782C
	Offset: 0x8058
	Size: 0x574
	Parameters: 1
	Flags: Linked
*/
function function_c8bedf1b(item)
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
		var_7f695eed = self.inventory.items[12];
	}
	if(isdefined(var_7f695eed) && var_7f695eed.id != 32767)
	{
		var_355db408 = function_b1702735(var_7f695eed.id).var_a6762160.weapon;
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
			if(var_7f695eed.var_bd027dd9 != item.var_bd027dd9)
			{
				function_d019bf1d(var_7f695eed.var_bd027dd9);
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
		if(weapon.name == #"hash_1888d1367d69b3a7")
		{
			var_f94ce554 = array(111, 112, 113, 114, 115, 116);
			weaponoptions = self calcweaponoptions(var_f94ce554[randomintrange(0, var_f94ce554.size)], 0, 0);
		}
		self function_5110caa3(level.nullprimaryoffhand, weapon, undefined, undefined, undefined, weaponoptions);
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
		assertmsg("" + var_a6762160.name + "");
	#/
}

/*
	Name: function_11fc9fa9
	Namespace: namespace_b376ff3f
	Checksum: 0x6B128728
	Offset: 0x85D8
	Size: 0x50C
	Parameters: 1
	Flags: Linked
*/
function function_11fc9fa9(item)
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
		var_2337367a = function_dfcacdc2(var_b6edb3b2);
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
		self function_5110caa3(level.var_ef61b4b5, weapon);
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
		assertmsg("" + var_a6762160.name + "");
	#/
}

/*
	Name: function_5a0ba107
	Namespace: namespace_b376ff3f
	Checksum: 0x7BA64114
	Offset: 0x8AF0
	Size: 0x38A
	Parameters: 3
	Flags: Linked
*/
function function_5a0ba107(var_bd027dd9, quickequip = 0, weaponid = 0)
{
	/#
		assert(isplayer(self));
	#/
	item = function_dfcacdc2(var_bd027dd9);
	if(isdefined(item) && isdefined(item.var_a6762160))
	{
		if(isdefined(item.var_a6762160.consumable) && item.var_a6762160.consumable)
		{
			return self function_7730442c(item);
		}
		itemtype = item.var_a6762160.itemtype;
		switch(itemtype)
		{
			case "ammo":
			{
				self function_11089ed8(item);
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
					self function_224c09c9(item, function_ec087745(), undefined, !quickequip, 1);
				}
				else
				{
					self function_224c09c9(item, function_c3fb7a6e(), function_ec087745(), !quickequip, 0);
				}
				break;
			}
			case "backpack":
			{
				self function_2dab8a7f(item);
				break;
			}
			case "equipment":
			{
				self function_c8bedf1b(item);
				break;
			}
			case "generic":
			case "cash":
			{
				break;
			}
			case "health":
			{
				self function_11fc9fa9(item);
				break;
			}
			case "killstreak":
			{
				self use_killstreak(var_bd027dd9, item);
				break;
			}
			case "weapon":
			{
				self function_2b4d7b66(item);
				break;
			}
			default:
			{
				/#
					assertmsg("" + (isdefined(item.var_a6762160.var_a6762160.itemtype) ? item.var_a6762160.itemtype : "") + "");
				#/
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_a7f76892
	Namespace: namespace_b376ff3f
	Checksum: 0xB659893F
	Offset: 0x8E88
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a7f76892()
{
	if(self function_2cceca7b())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_bf2312f1
	Namespace: namespace_b376ff3f
	Checksum: 0x2A6FBA05
	Offset: 0x8EB8
	Size: 0x8E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bf2312f1(weapon)
{
	currentweapon = self getcurrentweapon();
	if(isdefined(currentweapon) && currentweapon != level.weaponnone && currentweapon == weapon)
	{
		if(self function_55acff10())
		{
			return 0;
		}
		if(self isfiring())
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_2b4d7b66
	Namespace: namespace_b376ff3f
	Checksum: 0x50455D7B
	Offset: 0x8F50
	Size: 0xA4C
	Parameters: 5
	Flags: Linked
*/
function function_2b4d7b66(item, switchweapon = 1, var_9fa01da8 = 0, var_a3a17c55 = 0, initialweaponraise = 0)
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
		foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
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
	else if(function_bad4a3a5() == 0)
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
	foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
	{
		if(self.inventory.items[slotid].var_bd027dd9 === item.var_bd027dd9)
		{
			var_68dc9720 = slotid;
			break;
		}
	}
	if(!isdefined(var_68dc9720))
	{
		foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
		{
			if(self.inventory.items[slotid].var_bd027dd9 === 32767)
			{
				var_68dc9720 = slotid;
				break;
			}
		}
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	if(isdefined(weapon) && weapon != level.weaponnone)
	{
		var_346dc077 = self getweaponammostock(weapon);
		item.var_42caf41a = slotid == 16 + 1 + 6 + 1;
		namespace_a0d533d1::function_6e9e7169(item);
		weapon = namespace_a0d533d1::function_2b83d3ff(item);
		slotid = function_b246c573(item.var_bd027dd9);
		if(!isdefined(slotid))
		{
			return;
		}
		self function_26c87da8(slotid, var_68dc9720);
		if(initialweaponraise && !isdefined(item.weaponoptions) && !isdefined(item.var_3a7d925b) && !isdefined(item.var_2febbde5))
		{
			weaponoptions = undefined;
			if((isdefined(getgametypesetting(#"hash_33c34a7d3c678e37")) ? getgametypesetting(#"hash_33c34a7d3c678e37") : 0))
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
				var_b7659ba0 = namespace_bd02cf1::function_385ef18d(weapon);
				weaponoptions = self getbuildkitweaponoptions(var_b7659ba0);
				var_3a7d925b = self function_9826b353(var_b7659ba0);
				var_2febbde5 = self function_74829bcf(var_b7659ba0);
			}
			if(weaponoptions != self getbuildkitweaponoptions(level.weaponnone))
			{
				item.weaponoptions = weaponoptions;
			}
			item.var_3a7d925b = var_3a7d925b;
			item.var_2febbde5 = var_2febbde5;
		}
		item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
		self function_5110caa3(currentweapon, weapon, 1, initialweaponraise, var_a3a17c55, item.weaponoptions, item.var_3a7d925b, item.var_2febbde5);
		if(var_6073ab7b)
		{
			self function_5110caa3(level.weaponnone, level.weaponbasemeleeheld);
		}
		self function_b00db06(6, item.var_bd027dd9);
		var_b619c089 = function_dfcacdc2(item.var_bd027dd9);
		if(!isdefined(var_b619c089))
		{
			return;
		}
		if(weapon !== currentweapon)
		{
			var_b917b36f = int(min(var_346dc077, weapon.clipsize));
			self function_fc9f8b05(weapon, var_b917b36f);
		}
		var_954e19c7 = function_57eac2ca();
		if(var_a3a17c55)
		{
			self function_c9a111a(weapon);
		}
		else
		{
			self shoulddoinitialweaponraise(weapon, initialweaponraise);
		}
		self setweaponammoclip(weapon, int(var_b619c089.amount));
		if(switchweapon || var_954e19c7 == 1)
		{
			if(self function_a7f76892())
			{
				self switchtoweapon(weapon, 1);
				self.currentweapon = weapon;
			}
		}
		self function_db2abc4(item);
		return;
	}
	/#
		assertmsg("" + var_a6762160.name + "");
	#/
}

/*
	Name: function_ec087745
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	foreach(weaponslot in array(16 + 1, 16 + 1 + 6 + 1))
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
	Namespace: namespace_b376ff3f
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
	return namespace_ad5a0cd6::function_808be9a3(self, var_bd027dd9);
}

/*
	Name: function_bad4a3a5
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	foreach(weaponslot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1))
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
	Namespace: namespace_b376ff3f
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
	var_64d58696 = function_230ceec4(weapon);
	return (isdefined(var_64d58696) ? var_64d58696.var_bd027dd9 : 32767);
}

/*
	Name: function_b246c573
	Namespace: namespace_b376ff3f
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
		assert(namespace_ad5a0cd6::function_db35e94f(var_bd027dd9));
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
	Name: function_dfcacdc2
	Namespace: namespace_b376ff3f
	Checksum: 0x821A4C47
	Offset: 0xA210
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_dfcacdc2(var_bd027dd9)
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
	Namespace: namespace_b376ff3f
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
	for(index = 0; index < self.inventory.items.size && index < 16 + 1; index++)
	{
		var_b619c089 = self.inventory.items[index];
		if(!isdefined(var_b619c089.var_a6762160))
		{
			continue;
		}
		if(name == (isdefined(var_b619c089.var_a6762160.var_a6762160.parentname) ? var_b619c089.var_a6762160.parentname : var_b619c089.var_a6762160.name))
		{
			return var_b619c089;
		}
	}
}

/*
	Name: function_c48cd17f
	Namespace: namespace_b376ff3f
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
		assert(namespace_ad5a0cd6::function_d9648161(var_bd027dd9));
	#/
	item = function_dfcacdc2(var_bd027dd9);
	if(isdefined(item))
	{
		return item.id;
	}
	return 32767;
}

/*
	Name: function_189a93f8
	Namespace: namespace_b376ff3f
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
	Name: function_57eac2ca
	Namespace: namespace_b376ff3f
	Checksum: 0x56B97ECC
	Offset: 0xA5B0
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_57eac2ca()
{
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(self.inventory))
	{
		return 0;
	}
	weaponcount = 0;
	foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
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
	Namespace: namespace_b376ff3f
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
	foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
	{
		if(self.inventory.items[slotid].var_bd027dd9 == item.var_bd027dd9)
		{
			return slotid;
		}
	}
}

/*
	Name: function_3f7ef88
	Namespace: namespace_b376ff3f
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
		pistol = function_4ba8fde(#"hash_5cc9b5e23093ac03");
		var_fa3df96 = self function_e66dcff5(pistol);
		pistol.attachments = [];
		attachment = function_4ba8fde(#"hash_513a787ad3a20198");
		var_e38a0464 = function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		attachment = function_4ba8fde(#"hash_19c5c6ca805715e5");
		var_e38a0464 = function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		pistol.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(pistol));
		self item_world::function_de2018e3(pistol, self, var_fa3df96);
		ammo = function_4ba8fde(#"hash_212b01feaa916a00");
		var_fa3df96 = self function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_4ba8fde(#"hash_1abfcce0e9955057");
		health.count = 5;
		var_fa3df96 = self function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		self.var_554ec2e2 = undefined;
	}
}

/*
	Name: function_e274f1fe
	Namespace: namespace_b376ff3f
	Checksum: 0xE71CDC1B
	Offset: 0xAB38
	Size: 0xE80
	Parameters: 4
	Flags: Linked
*/
function function_e274f1fe(item, itemcount = 1, var_aec6fa7f = 0, slotid = undefined)
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
	var_d8138db2 = item.id;
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
			var_d8138db2 = var_8c36ae16.id;
		}
	}
	var_a057551d = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
	var_1393d318 = var_a057551d > 1;
	if(item.var_a6762160.itemtype == #"resource" && namespace_ad5a0cd6::function_41f06d9d(item.var_a6762160))
	{
		var_92d652f2 = self.inventory.items[slotid];
		var_b41045b2 = int(max(150 - self stats::function_441050ca(#"hash_7bb5510daa652f5e"), 0));
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
					self function_b00db06(4, var_d8138db2, 0);
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
			item.var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, slotid);
			namespace_a0d533d1::function_6e9e7169(item);
			var_92d652f2.amount = var_aec6fa7f;
			var_92d652f2.count = var_8c6165fc;
			var_92d652f2.id = var_d8138db2;
			var_92d652f2.var_bd027dd9 = item.var_bd027dd9;
			var_92d652f2.var_a6762160 = var_a6762160;
			var_92d652f2.starttime = undefined;
			var_92d652f2.endtime = undefined;
			var_92d652f2.weaponoptions = undefined;
			var_92d652f2.var_3a7d925b = undefined;
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
					foreach(var_84704ed7 in item.attachments)
					{
						if(!isdefined(var_84704ed7))
						{
							continue;
						}
						var_769a94ae = namespace_a0d533d1::function_837f4a57(var_84704ed7.var_a6762160);
						if(!isdefined(var_769a94ae))
						{
							continue;
						}
						var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
						function_e274f1fe(var_84704ed7, undefined, undefined, var_f9f8c0b5);
						var_84704ed7 = function_dfcacdc2(var_84704ed7.var_bd027dd9);
						namespace_a0d533d1::function_9e9c82a6(var_92d652f2, var_84704ed7, 0);
					}
					namespace_a0d533d1::function_6e9e7169(var_92d652f2);
				}
				else if(isdefined(var_a6762160.attachments))
				{
					if(namespace_a0d533d1::function_4bd83c04(item))
					{
						foreach(attachment in var_a6762160.attachments)
						{
							if(!namespace_ad5a0cd6::function_7363384a(attachment.var_6be1bec7))
							{
								continue;
							}
							var_84704ed7 = function_4ba8fde(attachment.var_6be1bec7);
							if(!isdefined(var_84704ed7))
							{
								continue;
							}
							var_769a94ae = namespace_a0d533d1::function_837f4a57(var_84704ed7.var_a6762160);
							if(!isdefined(var_769a94ae))
							{
								continue;
							}
							var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
							function_e274f1fe(var_84704ed7, undefined, undefined, var_f9f8c0b5);
							var_84704ed7 = function_dfcacdc2(var_84704ed7.var_bd027dd9);
							namespace_a0d533d1::function_9e9c82a6(var_92d652f2, var_84704ed7, 0);
						}
						namespace_a0d533d1::function_6e9e7169(var_92d652f2);
						weapon = namespace_a0d533d1::function_2b83d3ff(var_92d652f2);
						if(isdefined(weapon))
						{
							var_92d652f2.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(var_92d652f2));
						}
					}
				}
				var_92d652f2.weaponoptions = item.weaponoptions;
				var_92d652f2.var_3a7d925b = item.var_3a7d925b;
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
			item.var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, i);
			self.inventory.items[i].amount = var_aec6fa7f;
			self.inventory.items[i].count = var_8c6165fc;
			self.inventory.items[i].id = var_d8138db2;
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
	Namespace: namespace_b376ff3f
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
	if(!(isdefined(getgametypesetting(#"hash_7c8ad12994670d63")) ? getgametypesetting(#"hash_7c8ad12994670d63") : 0))
	{
		return;
	}
	if(!isplayer(self))
	{
		return;
	}
	var_73869e24 = function_4ba8fde(#"hash_211559ff9a516b7d");
	var_bcb39afb = self namespace_a0d533d1::function_169cea63();
	var_51c5992 = min(var_bcb39afb.size, 2);
	if(var_51c5992 > 0)
	{
		self function_e274f1fe(var_73869e24, var_51c5992, 0, 15);
	}
}

/*
	Name: has_armor
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	var_4f583f35 = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[13]) && isdefined(self.inventory.items[13].var_a6762160) && self.inventory.items[13].var_a6762160.itemtype == #"backpack";
	return var_4f583f35;
}

/*
	Name: function_471897e2
	Namespace: namespace_b376ff3f
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
	var_22939dc4 = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[15]) && isdefined(self.inventory.items[15].var_a6762160) && self.inventory.items[15].var_a6762160.itemtype == #"resource" && self.inventory.items[15].var_a6762160.name == #"hash_211559ff9a516b7d";
	return var_22939dc4;
}

/*
	Name: function_7fe4ce88
	Namespace: namespace_b376ff3f
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
		var_b74300d3 = namespace_ad5a0cd6::function_d73e17cb(item.var_a6762160);
		if(item_name == var_b74300d3)
		{
			return item;
		}
	}
}

/*
	Name: function_f62713c3
	Namespace: namespace_b376ff3f
	Checksum: 0x1F6702B
	Offset: 0xBEF8
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_f62713c3(slotid)
{
	/#
		assert(isplayer(self));
	#/
	return isdefined(self.inventory.items[slotid]) && self.inventory.items[slotid].var_bd027dd9 != 32767;
}

/*
	Name: function_814b5785
	Namespace: namespace_b376ff3f
	Checksum: 0x2AE96FBE
	Offset: 0xBF78
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_814b5785()
{
	/#
		assert(isplayer(self));
	#/
	self.inventory = spawnstruct();
	self.inventory.items = [];
	for(i = 0; i < 16 + 1 + 6 + 1 + 6 + 1; i++)
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
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
		assert(slotid >= 0 && slotid < 16 + 1 + 6 + 1 + 6 + 1);
	#/
	return self.inventory.items[slotid].var_bd027dd9 != 32767;
}

/*
	Name: function_f3195b3d
	Namespace: namespace_b376ff3f
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
	foreach(slot in array(10, 11, 12, 13, 16 + 1, 16 + 1 + 6 + 1))
	{
		if(self.inventory.items[slot].var_bd027dd9 === var_bd027dd9)
		{
			return 1;
		}
	}
	foreach(weaponid in array(16 + 1, 16 + 1 + 6 + 1))
	{
		foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
		{
			var_2c3486a7 = namespace_a0d533d1::function_dfaca25e(weaponid, var_259f58f3);
			if(self.inventory.items[var_2c3486a7].var_bd027dd9 === var_bd027dd9)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_db2abc4
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
	Checksum: 0x99C5A8D0
	Offset: 0xC608
	Size: 0x26C
	Parameters: 3
	Flags: Linked
*/
function function_a24d6e36(var_bd027dd9, var_b44c0e7e = 1, var_cda2ff12 = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	self endon(#"death");
	var_d8138db2 = function_c48cd17f(var_bd027dd9);
	if(var_d8138db2 == 32767)
	{
		return 0;
	}
	item = function_dfcacdc2(var_bd027dd9);
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
		self function_5852cb7b(var_bd027dd9, 0, var_b44c0e7e, var_cda2ff12);
	}
}

/*
	Name: function_eb70ad46
	Namespace: namespace_b376ff3f
	Checksum: 0x7CEF5DEF
	Offset: 0xC880
	Size: 0x21C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_eb70ad46(var_bd027dd9, var_b44c0e7e = 1, var_cda2ff12 = 1)
{
	item = function_dfcacdc2(var_bd027dd9);
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	var_a6762160 = item.var_a6762160;
	self.inventory.items[13] = function_520b16d6();
	self.inventory.var_c212de25 = 5;
	self.inventory.var_7658cbec = 0;
	if(var_b44c0e7e)
	{
		self function_b00db06(5, var_bd027dd9);
	}
	function_9d805044(var_a6762160.itemtype, var_a6762160);
	if(var_cda2ff12)
	{
		for(index = self.inventory.var_c212de25; index < 10; index++)
		{
			var_b619c089 = self.inventory.items[index];
			if(var_b619c089.var_bd027dd9 != 32767)
			{
				function_5852cb7b(var_b619c089.var_bd027dd9);
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
	Name: function_5852cb7b
	Namespace: namespace_b376ff3f
	Checksum: 0xDAD23A3
	Offset: 0xCAA8
	Size: 0x4BE
	Parameters: 4
	Flags: Linked
*/
function function_5852cb7b(var_bd027dd9, var_dfe6c7e5 = 0, var_b44c0e7e = 1, var_cda2ff12 = 1)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isint(var_bd027dd9) && var_bd027dd9 != 32767);
	#/
	var_d8138db2 = function_c48cd17f(var_bd027dd9);
	if(var_d8138db2 == 32767)
	{
		debug_print("remove_inventory_item: failed! No ItemId");
		return 0;
	}
	item = function_dfcacdc2(var_bd027dd9);
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	var_a6762160 = item.var_a6762160;
	if(isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon)))
	{
		debug_print("remove_inventory_item: failed! Weapon in Use");
		return 0;
	}
	if(self.inventory.items[13].var_bd027dd9 === var_bd027dd9)
	{
		function_eb70ad46(var_bd027dd9, var_b44c0e7e, var_cda2ff12);
		return 1;
	}
	for(i = 0; i < self.inventory.items.size; i++)
	{
		if(self.inventory.items[i].var_bd027dd9 === var_bd027dd9)
		{
			unequipped = self function_d019bf1d(var_bd027dd9, var_dfe6c7e5, var_b44c0e7e, var_cda2ff12);
			self.inventory.items[i] = function_520b16d6();
			if(function_8b1a219a())
			{
				if(isdefined(array::find(array(16 + 1, 16 + 1 + 6 + 1), i)) && function_57eac2ca() == 0)
				{
					self sortheldweapons();
				}
			}
			self function_6c36ab6b();
			self function_a4413333();
			if(var_b44c0e7e)
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
			return 1;
		}
		if(!isdefined(self.inventory))
		{
			return 0;
		}
	}
	debug_print("remove_inventory_item: Failed!", weapon);
	return 0;
}

/*
	Name: function_5110caa3
	Namespace: namespace_b376ff3f
	Checksum: 0xDC8A5501
	Offset: 0xCF70
	Size: 0x226
	Parameters: 8
	Flags: Linked
*/
function function_5110caa3(old_weapon, new_weapon, primary_weapon = 0, var_e47b0bf = 1, var_6086c488 = 0, options = undefined, var_3a7d925b = undefined, var_2febbde5)
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
	if(isdefined(var_3a7d925b) && var_3a7d925b >= 0)
	{
		self function_3fb8b14(new_weapon, var_3a7d925b);
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
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
		return 0;
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
				slotid = array(16 + 1, 16 + 1 + 6 + 1);
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
				return 0;
			}
		}
		else if(self.inventory.items[slotid].var_bd027dd9 !== 32767 && self.inventory.items[slotid].var_bd027dd9 !== item.var_bd027dd9)
		{
			return 0;
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_ecd1c667
	Namespace: namespace_b376ff3f
	Checksum: 0x1720D41C
	Offset: 0xD4B8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_ecd1c667(var_d8138db2, count)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(namespace_ad5a0cd6::function_2c7fc531(var_d8138db2));
	#/
	self endon(#"death");
	item = function_b1702735(var_d8138db2);
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
	Namespace: namespace_b376ff3f
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
	item = function_dfcacdc2(var_bd027dd9);
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
	self function_6e376bb1(var_bd027dd9, count);
}

/*
	Name: function_23335063
	Namespace: namespace_b376ff3f
	Checksum: 0xF58E0B17
	Offset: 0xD870
	Size: 0x4E
	Parameters: 2
	Flags: Linked
*/
function function_23335063(var_bd027dd9, var_cda2ff12 = 1)
{
	if(!self function_5852cb7b(var_bd027dd9, undefined, undefined, var_cda2ff12))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c4468806
	Namespace: namespace_b376ff3f
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
	Namespace: namespace_b376ff3f
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
	var_13339abf = array(#"hash_182fdef2ad243e20", #"hash_212b01feaa916a00", #"hash_3bf6ed4e3a22e9f3", #"hash_1f72dec518451f8c", #"hash_3b5119f663e783b1", #"hash_7ebaa4e1e2f5d8a2", #"hash_46dd75a1a3f70780", #"hash_394e9478cf4f8d9d");
	var_c2043143 = array(2, 4, 8, 16, 32, 64, 128, 256);
	for(index = 0; index < var_13339abf.size; index++)
	{
		if(self.inventory.var_7658cbec & var_c2043143[index])
		{
			continue;
		}
		var_375298f3 = var_13339abf[index];
		var_f415ce36 = getscriptbundle(var_375298f3);
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
			var_f580278d = function_4ba8fde(var_375298f3).id;
			function_ecd1c667(var_f580278d, var_346dc077 - maxammo);
		}
	}
}

/*
	Name: function_a2c7ce35
	Namespace: namespace_b376ff3f
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
	var_3e9ef0a1 = array(array(#"hash_53a2516ec1d3a096", #"hash_3074c41bb205ed8c", #"hash_2b5027622c0b6d07", #"hash_4cec712579f1202f", #"hash_57504010ce1814dc", #"hash_5752a7e130ea202a", #"hash_4edf613e9b9032da", #"hash_28da32d9304b6296", #"hash_4a2739676c12d92a", #"hash_140318e970e711ce", #"hash_50b970644e43947b"), array(#"hash_627144159973c325", #"hash_1a7edb90a484158b", #"hash_745d80b3e4f28da1", #"hash_56e573d15c6402bc", #"hash_213093d947c30be6", #"hash_7e8c84081fafaea4"), array(#"hash_665eccfe5d58f636", #"hash_68b64725de40edae", #"hash_2b06a3f530395182", #"hash_16a1f841da0b877d", #"hash_1242946e889704c7", #"hash_14b578e446580ad5", #"hash_300914db9caf4033", #"hash_3a3d830a9a4559d4", #"hash_743b859c2367ff54", #"hash_5e5f2ed57ac4601f", #"hash_105f32560e2fb0fe", #"hash_18056dab055a44c9", #"hash_2e8b13391f6544", #"hash_735d22a674b7f8c0", #"hash_7f877a112c8c4187", #"hash_7aca06dcd83beef3"));
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
		var_a101f33c = var_3e9ef0a1[var_25c45152];
		for(index = 0; index < var_a101f33c.size; index++)
		{
			var_7f695eed = var_a101f33c[index];
			var_f77e15f6 = function_4ba8fde(var_7f695eed);
			if(!isdefined(var_f77e15f6))
			{
				continue;
			}
			var_590b4c51 = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, var_f77e15f6.var_a6762160);
			for(itemindex = 0; itemindex < var_710be50e.size; itemindex++)
			{
				item = self.inventory.items[var_710be50e[itemindex]];
				if(item.var_bd027dd9 == 32767)
				{
					continue;
				}
				if(item.var_a6762160.name != var_7f695eed)
				{
					continue;
				}
				if(item.count <= var_590b4c51)
				{
					continue;
				}
				var_9311e423 = item.count - var_590b4c51;
				self function_6e376bb1(item.var_bd027dd9, var_9311e423);
				newitem = spawnstruct();
				newitem.id = item.id;
				newitem.var_a6762160 = item.var_a6762160;
				var_77e61fc6 = function_e274f1fe(newitem, var_9311e423);
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
	Namespace: namespace_b376ff3f
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
	var_9b624be0 = array(#"hash_1abfcce0e9955057", #"hash_ff50c93155e445f", #"hash_80292d121740f6f", #"hash_45ced3880667df22");
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
		var_78d7ac4a = var_9b624be0[index];
		var_f77e15f6 = function_4ba8fde(var_78d7ac4a);
		if(!isdefined(var_f77e15f6))
		{
			continue;
		}
		var_590b4c51 = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, var_f77e15f6.var_a6762160);
		for(itemindex = 0; itemindex < var_5675add1.size; itemindex++)
		{
			item = self.inventory.items[var_5675add1[itemindex]];
			if(item.var_bd027dd9 == 32767)
			{
				continue;
			}
			if(item.var_a6762160.name != var_78d7ac4a)
			{
				continue;
			}
			if(item.count <= var_590b4c51)
			{
				continue;
			}
			var_9311e423 = item.count - var_590b4c51;
			self function_6e376bb1(item.var_bd027dd9, var_9311e423);
			newitem = spawnstruct();
			newitem.id = item.id;
			newitem.var_a6762160 = item.var_a6762160;
			var_77e61fc6 = function_e274f1fe(newitem, var_9311e423);
			if(var_77e61fc6 > 0)
			{
				self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
			}
		}
	}
}

/*
	Name: function_2521e90f
	Namespace: namespace_b376ff3f
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
		function_5852cb7b(item.var_bd027dd9, 0, 1, 1);
		var_77e61fc6 = function_e274f1fe(newitem, newitem.count);
		if(var_77e61fc6 > 0)
		{
			self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
		}
	}
}

/*
	Name: function_ec238da8
	Namespace: namespace_b376ff3f
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
	Name: function_56a681fb
	Namespace: namespace_b376ff3f
	Checksum: 0xBEC69129
	Offset: 0xE710
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function function_56a681fb()
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
	foreach(var_b619c089 in self.inventory.items)
	{
		if(var_b619c089.var_bd027dd9 != 32767)
		{
			function_5852cb7b(var_b619c089.var_bd027dd9, 0, 0);
		}
	}
	foreach(var_95162a97, var_d8138db2 in self.inventory.ammo)
	{
		weapon = getweapon(var_95162a97);
		self setweaponammostock(weapon, 0);
	}
	if(isdefined(level.givecustomloadout))
	{
		self [[level.givecustomloadout]](1);
	}
	self function_814b5785();
	self function_6c36ab6b();
	self function_b00db06(10);
	self clientfield::set_player_uimodel("hudItems.armorType", 0);
	self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
	self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
	self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
	self.var_7bba6210 = undefined;
	self enableoffhandspecial();
	self enableoffhandweapons();
	self callback::callback(#"hash_5acf7bf1a288eb9f");
}

/*
	Name: function_26c87da8
	Namespace: namespace_b376ff3f
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
	var_48e276d5 = self.inventory.items[var_c9293a27];
	var_47684cd2 = self.inventory.items[var_8f194e5a];
	self.inventory.items[var_c9293a27] = var_47684cd2;
	self.inventory.items[var_8f194e5a] = var_48e276d5;
	if(isdefined(var_48e276d5.var_a6762160))
	{
		var_48e276d5.var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, var_8f194e5a);
	}
	if(isdefined(var_47684cd2.var_a6762160))
	{
		var_47684cd2.var_bd027dd9 = namespace_ad5a0cd6::function_970b8d86(self, var_c9293a27);
	}
	if(var_8f194e5a == 10)
	{
		self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(var_47684cd2.var_a6762160));
	}
	else if(var_8f194e5a == 12)
	{
		self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(var_47684cd2.var_a6762160));
	}
	self function_b00db06(12, var_c9293a27, var_8f194e5a);
}

/*
	Name: function_b3342af3
	Namespace: namespace_b376ff3f
	Checksum: 0xD1F90272
	Offset: 0xECB0
	Size: 0x3A0
	Parameters: 3
	Flags: Linked
*/
function function_b3342af3(item, var_b44c0e7e = 1, var_2ea908ac = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
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
		var_64d58696 = function_dfcacdc2(var_f0dc4e93);
		if(!isdefined(var_64d58696) || !isdefined(var_64d58696.var_a6762160) || var_64d58696.var_a6762160.itemtype != #"weapon")
		{
			/#
				assert(0);
			#/
			continue;
		}
		currentammo = self getweaponammoclip(namespace_a0d533d1::function_2b83d3ff(var_64d58696));
		if(namespace_a0d533d1::function_31a0b1ef(var_64d58696, item, 0))
		{
			itemtype = item.var_a6762160.itemtype;
			var_bd027dd9 = item.var_bd027dd9;
			if(var_b44c0e7e)
			{
				self function_b00db06(7, var_bd027dd9);
			}
			weapon = namespace_a0d533d1::function_2b83d3ff(var_64d58696);
			iscurrentweapon = weapon == self.currentweapon;
			function_d019bf1d(var_f0dc4e93, undefined, var_b44c0e7e, 0);
			namespace_a0d533d1::function_6e9e7169(var_64d58696);
			function_2b4d7b66(var_64d58696, iscurrentweapon, undefined, 1, 0);
			newammo = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(var_64d58696));
			var_b917b36f = currentammo - newammo;
			if(var_b917b36f > 0)
			{
				self function_fc9f8b05(weapon, var_b917b36f);
			}
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_41a57271
	Namespace: namespace_b376ff3f
	Checksum: 0xD202BE7C
	Offset: 0xF058
	Size: 0x1E0
	Parameters: 4
	Flags: Linked
*/
function function_41a57271(item, slot, var_b44c0e7e = 1, var_b2bd0862 = undefined)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isstruct(item));
	#/
	if(!isdefined(item.attachments))
	{
		return 0;
	}
	attachments = arraycopy(item.attachments);
	foreach(attachment in attachments)
	{
		if(!isdefined(attachment) || !isdefined(attachment.var_a6762160))
		{
			continue;
		}
		if(isdefined(var_b2bd0862) && var_b2bd0862.var_bd027dd9 == attachment.var_bd027dd9)
		{
			continue;
		}
		if(isdefined(attachment.var_a6762160.(slot)) && attachment.var_a6762160.(slot))
		{
			function_b3342af3(function_dfcacdc2(attachment.var_bd027dd9), var_b44c0e7e);
		}
	}
}

/*
	Name: function_d019bf1d
	Namespace: namespace_b376ff3f
	Checksum: 0x3D6B155F
	Offset: 0xF240
	Size: 0x298
	Parameters: 4
	Flags: Linked
*/
function function_d019bf1d(var_bd027dd9, var_dfe6c7e5 = 0, var_b44c0e7e = 1, var_8eb4edca = 1)
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
	item = function_dfcacdc2(var_bd027dd9);
	if(!isdefined(item))
	{
		return 0;
	}
	var_a6762160 = item.var_a6762160;
	itemtype = var_a6762160.itemtype;
	if(itemtype == #"weapon")
	{
		return function_3f5b2e2e(item, var_b44c0e7e, var_8eb4edca);
	}
	if(itemtype == #"attachment")
	{
		return function_b3342af3(item, var_b44c0e7e);
	}
	if(itemtype == #"armor")
	{
		self function_bef83dc6();
		self armor::set_armor(0, 0, 0, 1, 0);
		self clientfield::set_player_uimodel("hudItems.armorType", 0);
	}
	else if(itemtype == #"equipment")
	{
		self thread function_ee9ce1c4(var_a6762160, var_dfe6c7e5);
	}
	else if(itemtype == #"health")
	{
		self thread function_8214f1b6(var_a6762160, var_dfe6c7e5);
	}
	if(var_b44c0e7e)
	{
		self function_b00db06(7, var_bd027dd9);
	}
	return 1;
}

/*
	Name: function_3f5b2e2e
	Namespace: namespace_b376ff3f
	Checksum: 0x6BE79B8A
	Offset: 0xF4E8
	Size: 0x4F0
	Parameters: 3
	Flags: Linked
*/
function function_3f5b2e2e(item, var_b44c0e7e = 1, var_8eb4edca = 1)
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
		var_687225b = [];
		foreach(attachment in item.attachments)
		{
			if(!isdefined(attachment))
			{
				continue;
			}
			var_84704ed7 = function_dfcacdc2(attachment.var_bd027dd9);
			var_687225b[var_687225b.size] = var_84704ed7;
		}
		foreach(var_84704ed7 in var_687225b)
		{
			function_b3342af3(var_84704ed7, 1);
		}
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
	if(function_57eac2ca() > 1)
	{
		self function_5110caa3(weapon, level.weaponbasemeleeheld, 1);
		foreach(slotid in array(16 + 1, 16 + 1 + 6 + 1))
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
		self function_5110caa3(weapon, level.weaponbasemeleeheld, 1);
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
	if(var_b44c0e7e)
	{
		self function_b00db06(7, var_bd027dd9);
	}
	return 1;
}

/*
	Name: function_6e376bb1
	Namespace: namespace_b376ff3f
	Checksum: 0xD2614EED
	Offset: 0xF9E0
	Size: 0x2EA
	Parameters: 3
	Flags: Linked
*/
function function_6e376bb1(var_bd027dd9, usecount = 1, var_dfe6c7e5 = 1)
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
			self callback::callback(#"hash_41c107b83320aba2", var_641929a7);
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
	Namespace: namespace_b376ff3f
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
	self waittill(#"hash_363004a4e0ccc1f", #"hash_47147249212b6a46", #"death", #"stationary");
	var_d783088e = [];
	foreach(var_711e35e5 in level.var_f208fb92)
	{
		if(!isdefined(var_711e35e5))
		{
			continue;
		}
		parentent = var_711e35e5 getlinkedent();
		if(isdefined(parentent) && parentent == self)
		{
			var_d783088e[var_d783088e.size] = var_711e35e5;
		}
	}
	if(!isdefined(self) || self.health <= 0)
	{
		foreach(var_711e35e5 in var_d783088e)
		{
			var_711e35e5 thread namespace_d81cee52::function_4db10465();
		}
		return;
	}
	angles = self.angles;
	origin = self.origin;
	dropitem = item_drop::drop_item(undefined, 1, 0, self.id, origin, angles);
	if(isdefined(dropitem) && namespace_ad5a0cd6::function_74e1e547(origin))
	{
		dropitem.var_d783088e = var_d783088e;
	}
	else
	{
		foreach(var_711e35e5 in var_d783088e)
		{
			var_711e35e5 thread namespace_d81cee52::function_4db10465();
		}
	}
	util::wait_network_frame(1);
	if(isdefined(self))
	{
		self delete();
		arrayremovevalue(level.var_d79f1ee4, undefined, 0);
	}
}

/*
	Name: function_d8ceeeec
	Namespace: namespace_b376ff3f
	Checksum: 0x979BE032
	Offset: 0x10010
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d8ceeeec(notifyhash)
{
	self val::reset(#"hash_546302f07800b5e5", "freezecontrols_allowlook");
}

/*
	Name: use_killstreak
	Namespace: namespace_b376ff3f
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
	self endon_callback(&function_d8ceeeec, #"death");
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
	else if(isdefined(level.var_4cf92425[vehicletype]))
	{
		traceresults = self [[level.var_4cf92425[vehicletype]]](item.var_a6762160.vehicle);
	}
	else
	{
		var_8d430fcb = self getplayerangles();
		forward = anglestoforward(var_8d430fcb);
		eyepos = self getplayercamerapos();
		endpos = eyepos + forward * 50;
		var_f45df727 = eyepos + forward * 100;
		traceresults = {};
		traceresults.trace = bullettrace(eyepos, var_f45df727, 1, self, 1, 1);
		traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
		traceresults.waterdepth = 0;
		traceresults.origin = endpos;
		traceresults.angles = var_8d430fcb;
	}
	if(traceresults.isvalid)
	{
		remoteweapon = getweapon(#"hash_8c773df059a6d5e");
		if(self hasweapon(remoteweapon))
		{
			return;
		}
		if(self isswitchingweapons())
		{
			self waittill_timeout(2, #"weapon_change");
		}
		self val::set(#"hash_546302f07800b5e5", "freezecontrols_allowlook", 1);
		self giveweapon(remoteweapon);
		self switchtoweapon(remoteweapon, 1);
		self waittill_timeout(2, #"weapon_change");
		if(self getcurrentweapon() != remoteweapon)
		{
			self takeweapon(remoteweapon);
			self val::reset(#"hash_546302f07800b5e5", "freezecontrols_allowlook");
			return;
		}
		function_5852cb7b(var_bd027dd9);
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
			level.var_d79f1ee4[level.var_d79f1ee4.size] = vehicle;
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
				self val::reset(#"hash_546302f07800b5e5", "freezecontrols_allowlook");
				vehicle usevehicle(self, 0);
				self waittill(#"exit_vehicle");
			}
			else if(isdefined(vehicle.var_7feead71))
			{
				vehicle [[vehicle.var_7feead71]](self);
			}
		}
		self val::reset(#"hash_546302f07800b5e5", "freezecontrols_allowlook");
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
	Namespace: namespace_b376ff3f
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

