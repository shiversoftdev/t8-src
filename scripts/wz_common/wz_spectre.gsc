// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_role.gsc;
#using scripts\mp_common\item_inventory.gsc;
#using script_6b993fdc7adc35ec;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace wz_spectre;

/*
	Name: __init__system__
	Namespace: wz_spectre
	Checksum: 0x4AB039A0
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_5bea4c43846046ef", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_spectre
	Checksum: 0xAC586286
	Offset: 0x1C0
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising")))
	{
		return;
	}
	clientfield::register("allplayers", "hasspectrebody", 16000, 1, "int");
	clientfield::register("toplayer", "spectrebladebonus", 16000, 1, "int");
	clientfield::register("clientuimodel", "hudItems.isSpectre", 16000, 1, "int");
	clientfield::register("world", "showSpectreSwordBeams", 16000, 1, "int");
	callback::add_callback(#"inventory_reset", &function_4467066e);
	callback::add_callback(#"on_drop_item", &function_4467066e);
	callback::on_item_pickup(&function_4467066e);
	callback::add_callback(#"on_player_downed", &function_ef53914c);
	callback::on_player_killed_with_params(&function_de83cc91);
	callback::add_callback(#"hash_405e46788e83af41", &start_beams);
}

/*
	Name: start_beams
	Namespace: wz_spectre
	Checksum: 0xE571041C
	Offset: 0x3E0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function start_beams()
{
	level clientfield::set("showSpectreSwordBeams", 1);
}

/*
	Name: function_4467066e
	Namespace: wz_spectre
	Checksum: 0xD12E856D
	Offset: 0x410
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4467066e(params)
{
	var_ec8e239d = 0;
	if(isstruct(self.inventory) && isarray(self.inventory.items))
	{
		foreach(item in self.inventory.items)
		{
			var_a6762160 = item.var_a6762160;
			if(isdefined(item.var_a6762160) && item.var_a6762160.name == #"sig_blade_wz_item")
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
	Namespace: wz_spectre
	Checksum: 0x3FA46083
	Offset: 0x548
	Size: 0x28C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f82142f8(isSpectre)
{
	self notify(#"hash_2e4cc87f4b3a6396");
	self endon(#"death", #"hash_2e4cc87f4b3a6396");
	level endon(#"game_playing");
	self function_1edd6e9e(isSpectre);
	if(!isalive(self))
	{
		return;
	}
	self clientfield::set("hasspectrebody", isSpectre);
	role = self player_role::get();
	if(isSpectre)
	{
		if(role != 57)
		{
			wait(0.5);
			self.var_fcb62e3f = role;
			self player_role::set(57);
			self setcharacteroutfit(0);
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
	self clientfield::set_player_uimodel("hudItems.isSpectre", isSpectre);
}

/*
	Name: function_9299d039
	Namespace: wz_spectre
	Checksum: 0x845746AA
	Offset: 0x7E0
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9299d039()
{
	if(isdefined(self.var_fcb62e3f))
	{
		self player_role::set(self.var_fcb62e3f);
	}
}

/*
	Name: function_1edd6e9e
	Namespace: wz_spectre
	Checksum: 0xE203AF7D
	Offset: 0x818
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1edd6e9e(isSpectre)
{
	var_91de0487 = 0;
	if(isSpectre && isalive(self))
	{
		var_91de0487 = 1;
	}
}

/*
	Name: function_ef53914c
	Namespace: wz_spectre
	Checksum: 0xEB9F8C1F
	Offset: 0x860
	Size: 0x1C0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ef53914c()
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
	Namespace: wz_spectre
	Checksum: 0x4FACE8C3
	Offset: 0xA28
	Size: 0x25C
	Parameters: 1
	Flags: Linked, Private
*/
function private give_max_ammo(weaponslot)
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
		ammoitem = getscriptbundle(ammo);
		if(!isdefined(ammoitem.weapon) || ammoitem.weapon.ammoindex !== weapon.ammoindex)
		{
			continue;
		}
		var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, ammoitem.weapon);
		currentammostock = self getweaponammostock(ammoitem.weapon);
		var_9b9ba643 = var_2f399b51 - currentammostock;
		self function_fc9f8b05(weapon, var_9b9ba643);
		break;
	}
}

/*
	Name: function_124f7ba3
	Namespace: wz_spectre
	Checksum: 0x5FC0CEFD
	Offset: 0xC90
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_124f7ba3()
{
	self endon(#"disconnect");
	self clientfield::set_to_player("spectrebladebonus", 1);
	util::wait_network_frame();
	self clientfield::set_to_player("spectrebladebonus", 0);
}

/*
	Name: function_de83cc91
	Namespace: wz_spectre
	Checksum: 0xD54B1C9A
	Offset: 0xD08
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_de83cc91(params)
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

