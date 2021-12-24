// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_64ab2b950d85b8ad;
#using script_6b993fdc7adc35ec;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace namespace_14c378fe;

/*
	Name: function_89f2df9
	Namespace: namespace_14c378fe
	Checksum: 0x4AB039A0
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5bea4c43846046ef", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_14c378fe
	Checksum: 0xAC586286
	Offset: 0x1C0
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312")))
	{
		return;
	}
	clientfield::register("allplayers", "hasspectrebody", 16000, 1, "int");
	clientfield::register("toplayer", "spectrebladebonus", 16000, 1, "int");
	clientfield::register("clientuimodel", "hudItems.isSpectre", 16000, 1, "int");
	clientfield::register("world", "showSpectreSwordBeams", 16000, 1, "int");
	callback::add_callback(#"hash_5acf7bf1a288eb9f", &function_4467066e);
	callback::add_callback(#"hash_4d3e34c3c8f8bb2a", &function_4467066e);
	callback::function_10a4dd0a(&function_4467066e);
	callback::add_callback(#"hash_65626f47d6c0717c", &function_ef53914c);
	callback::on_player_killed_with_params(&function_de83cc91);
	callback::add_callback(#"hash_405e46788e83af41", &function_fefefe2a);
}

/*
	Name: function_fefefe2a
	Namespace: namespace_14c378fe
	Checksum: 0xE571041C
	Offset: 0x3E0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_fefefe2a()
{
	level clientfield::set("showSpectreSwordBeams", 1);
}

/*
	Name: function_4467066e
	Namespace: namespace_14c378fe
	Checksum: 0xD12E856D
	Offset: 0x410
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4467066e(params)
{
	var_ec8e239d = 0;
	if(isstruct(self.inventory) && isarray(self.inventory.items))
	{
		foreach(item in self.inventory.items)
		{
			var_a6762160 = item.var_a6762160;
			if(isdefined(item.var_a6762160) && item.var_a6762160.name == #"hash_43aca7fcfd3e5949")
			{
				var_ec8e239d = 1;
				break;
			}
		}
	}
	function_f82142f8(var_ec8e239d);
}

/*
	Name: function_f82142f8
	Namespace: namespace_14c378fe
	Checksum: 0x3FA46083
	Offset: 0x548
	Size: 0x28C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f82142f8(var_b0e2f18c)
{
	self notify(#"hash_2e4cc87f4b3a6396");
	self endon(#"death", #"hash_2e4cc87f4b3a6396");
	level endon(#"hash_313ad43b34e74e96");
	self function_1edd6e9e(var_b0e2f18c);
	if(!isalive(self))
	{
		return;
	}
	self clientfield::set("hasspectrebody", var_b0e2f18c);
	role = self player_role::get();
	if(var_b0e2f18c)
	{
		if(role != 57)
		{
			wait(0.5);
			self.var_fcb62e3f = role;
			self player_role::set(57);
			self function_8fd843dd(0);
			self function_9b48a8e5(0);
			self function_ab96a9b5("head", 0);
			self function_ab96a9b5("headgear", 0);
			self function_ab96a9b5("arms", 0);
			self function_ab96a9b5("torso", 0);
			self function_ab96a9b5("legs", 0);
			self function_ab96a9b5("palette", 0);
			self function_ab96a9b5("warpaint", 0);
			self function_ab96a9b5("decal", 0);
		}
	}
	else if(role == 57)
	{
		wait(0.5);
		self function_9299d039();
	}
	self clientfield::set_player_uimodel("hudItems.isSpectre", var_b0e2f18c);
}

/*
	Name: function_9299d039
	Namespace: namespace_14c378fe
	Checksum: 0x845746AA
	Offset: 0x7E0
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9299d039()
{
	if(isdefined(self.var_fcb62e3f))
	{
		self player_role::set(self.var_fcb62e3f);
	}
}

/*
	Name: function_1edd6e9e
	Namespace: namespace_14c378fe
	Checksum: 0xE203AF7D
	Offset: 0x818
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1edd6e9e(var_b0e2f18c)
{
	var_91de0487 = 0;
	if(var_b0e2f18c && isalive(self))
	{
		var_91de0487 = 1;
	}
}

/*
	Name: function_ef53914c
	Namespace: namespace_14c378fe
	Checksum: 0xEB9F8C1F
	Offset: 0x860
	Size: 0x1C0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ef53914c()
{
	params = self.laststandparams;
	if(!isdefined(params))
	{
		return;
	}
	attacker = params.attacker;
	weapon = params.sweapon;
	if(!isplayer(attacker) || attacker.team == self.team || weapon.name != #"sig_blade")
	{
		return;
	}
	attacker thread function_124f7ba3();
	if(attacker.health < attacker.maxhealth)
	{
		attacker.health = attacker.maxhealth;
	}
	if(isdefined(attacker.inventory) && isdefined(attacker.inventory.items))
	{
		foreach(slot in array(16 + 1, ((16 + 1) + 6) + 1))
		{
			attacker give_max_ammo(slot);
		}
	}
}

/*
	Name: give_max_ammo
	Namespace: namespace_14c378fe
	Checksum: 0x4FACE8C3
	Offset: 0xA28
	Size: 0x25C
	Parameters: 1
	Flags: Linked, Private
*/
private function give_max_ammo(weaponslot)
{
	item = self.inventory.items[weaponslot];
	if(!isdefined(item))
	{
		return;
	}
	weapon = namespace_a0d533d1::function_2b83d3ff(item);
	if(!isdefined(weapon))
	{
		return;
	}
	self setweaponammoclip(weapon, weapon.clipsize);
	foreach(ammo in array(#"hash_182fdef2ad243e20", #"hash_212b01feaa916a00", #"hash_3bf6ed4e3a22e9f3", #"hash_1f72dec518451f8c", #"hash_3b5119f663e783b1", #"hash_7ebaa4e1e2f5d8a2", #"hash_46dd75a1a3f70780", #"hash_394e9478cf4f8d9d"))
	{
		var_375298f3 = getscriptbundle(ammo);
		if(!isdefined(var_375298f3.weapon) || var_375298f3.weapon.ammoindex !== weapon.ammoindex)
		{
			continue;
		}
		var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, var_375298f3.weapon);
		currentammostock = self getweaponammostock(var_375298f3.weapon);
		var_9b9ba643 = var_2f399b51 - currentammostock;
		self function_fc9f8b05(weapon, var_9b9ba643);
		break;
	}
}

/*
	Name: function_124f7ba3
	Namespace: namespace_14c378fe
	Checksum: 0x5FC0CEFD
	Offset: 0xC90
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_124f7ba3()
{
	self endon(#"disconnect");
	self clientfield::set_to_player("spectrebladebonus", 1);
	util::wait_network_frame();
	self clientfield::set_to_player("spectrebladebonus", 0);
}

/*
	Name: function_de83cc91
	Namespace: namespace_14c378fe
	Checksum: 0xD54B1C9A
	Offset: 0xD08
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_de83cc91(params)
{
	attacker = params.eattacker;
	weapon = params.weapon;
	if(isdefined(params.laststandparams))
	{
		attacker = params.laststandparams.attacker;
		weapon = params.laststandparams.sweapon;
	}
	if(!isplayer(attacker) || attacker.team == self.team || weapon.name != #"sig_blade")
	{
		return;
	}
}

