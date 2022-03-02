// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace hero_weapon;

/*
	Name: function_89f2df9
	Namespace: hero_weapon
	Checksum: 0x191D9647
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"gadget_hero_weapon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hero_weapon
	Checksum: 0xD7140A5
	Offset: 0xF0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ability_player::register_gadget_activation_callbacks(11, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off);
	ability_player::register_gadget_possession_callbacks(11, &gadget_hero_weapon_on_give, &gadget_hero_weapon_on_take);
	ability_player::register_gadget_is_inuse_callbacks(11, &gadget_hero_weapon_is_inuse);
	ability_player::register_gadget_is_flickering_callbacks(11, &gadget_hero_weapon_is_flickering);
	ability_player::register_gadget_ready_callbacks(11, &gadget_hero_weapon_ready);
}

/*
	Name: gadget_hero_weapon_is_inuse
	Namespace: hero_weapon
	Checksum: 0xAAA66360
	Offset: 0x1C0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function gadget_hero_weapon_is_inuse(slot)
{
	return self gadgetisactive(slot);
}

/*
	Name: gadget_hero_weapon_is_flickering
	Namespace: hero_weapon
	Checksum: 0x6CC665A9
	Offset: 0x1F0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function gadget_hero_weapon_is_flickering(slot)
{
	return self gadgetflickering(slot);
}

/*
	Name: gadget_hero_weapon_on_give
	Namespace: hero_weapon
	Checksum: 0x4084A8AE
	Offset: 0x220
	Size: 0x1BC
	Parameters: 2
	Flags: Linked
*/
function gadget_hero_weapon_on_give(slot, weapon)
{
	if(!isdefined(self.pers[#"held_hero_weapon_ammo_count"]))
	{
		self.pers[#"held_hero_weapon_ammo_count"] = [];
	}
	if(weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b || !isdefined(self.pers[#"held_hero_weapon_ammo_count"][weapon]))
	{
		self.pers[#"held_hero_weapon_ammo_count"][weapon] = 0;
	}
	self setweaponammoclip(weapon, self.pers[#"held_hero_weapon_ammo_count"][weapon]);
	n_ammo = self getammocount(weapon);
	if(n_ammo > 0)
	{
		stock = self.pers[#"held_hero_weapon_ammo_count"][weapon] - n_ammo;
		if(stock > 0 && !weapon.iscliponly)
		{
			self setweaponammostock(weapon, stock);
		}
		self hero_handle_ammo_save(slot, weapon);
	}
	else
	{
		self gadgetcharging(slot, 1);
	}
}

/*
	Name: gadget_hero_weapon_on_take
	Namespace: hero_weapon
	Checksum: 0x4CFB2BBE
	Offset: 0x3E8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function gadget_hero_weapon_on_take(slot, weapon)
{
}

/*
	Name: gadget_hero_weapon_on_activate
	Namespace: hero_weapon
	Checksum: 0x61B78131
	Offset: 0x408
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function gadget_hero_weapon_on_activate(slot, weapon)
{
	self.heavyweaponkillcount = 0;
	self.heavyweaponshots = 0;
	self.heavyweaponhits = 0;
	self notify(#"hash_6706cbd0ce1c0c09");
	if(function_de324246(slot, weapon))
	{
		self hero_give_ammo(slot, weapon);
		self hero_handle_ammo_save(slot, weapon);
	}
}

/*
	Name: gadget_hero_weapon_on_off
	Namespace: hero_weapon
	Checksum: 0x6820680A
	Offset: 0x4A8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function gadget_hero_weapon_on_off(slot, weapon)
{
	self setweaponammoclip(weapon, 0);
	if(isalive(self) && isdefined(level.playgadgetoff))
	{
		self [[level.playgadgetoff]](weapon);
	}
}

/*
	Name: gadget_hero_weapon_ready
	Namespace: hero_weapon
	Checksum: 0x4EB470DC
	Offset: 0x520
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function gadget_hero_weapon_ready(slot, weapon)
{
	if(function_98056dc4(slot, weapon))
	{
		hero_give_ammo(slot, weapon);
	}
}

/*
	Name: function_de324246
	Namespace: hero_weapon
	Checksum: 0xFEB7AA7E
	Offset: 0x570
	Size: 0x16
	Parameters: 2
	Flags: Linked
*/
function function_de324246(slot, weapon)
{
	return false;
}

/*
	Name: function_98056dc4
	Namespace: hero_weapon
	Checksum: 0x9975C1CD
	Offset: 0x590
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_98056dc4(slot, weapon)
{
	return weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b;
}

/*
	Name: hero_give_ammo
	Namespace: hero_weapon
	Checksum: 0xB3772097
	Offset: 0x5C8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function hero_give_ammo(slot, weapon)
{
	self givemaxammo(weapon);
	self setweaponammoclip(weapon, weapon.clipsize);
}

/*
	Name: hero_handle_ammo_save
	Namespace: hero_weapon
	Checksum: 0xC71181A5
	Offset: 0x620
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function hero_handle_ammo_save(slot, weapon)
{
	self thread hero_wait_for_out_of_ammo(slot, weapon);
	self thread hero_wait_for_death(slot, weapon);
	self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
}

/*
	Name: on_end_game
	Namespace: hero_weapon
	Checksum: 0x4B6E6BE7
	Offset: 0x6A0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function on_end_game(slot, weapon)
{
	if(isalive(self))
	{
		self hero_save_ammo(slot, weapon);
	}
}

/*
	Name: hero_wait_for_death
	Namespace: hero_weapon
	Checksum: 0xF22E87BC
	Offset: 0x6F8
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function hero_wait_for_death(slot, weapon)
{
	self endon(#"disconnect");
	self endon(#"give_map");
	self notify(#"hero_ondeath");
	self endon(#"hero_ondeath");
	self waittill(#"death");
	gadgetslot = self gadgetgetslot(weapon);
	if(gadgetslot != slot)
	{
		return;
	}
	self hero_save_ammo(slot, weapon);
}

/*
	Name: hero_save_ammo
	Namespace: hero_weapon
	Checksum: 0x326852B8
	Offset: 0x7C8
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function hero_save_ammo(slot, weapon)
{
	if(isdefined(weapon))
	{
		self.pers[#"held_hero_weapon_ammo_count"][weapon] = self getammocount(weapon);
	}
}

/*
	Name: hero_wait_for_out_of_ammo
	Namespace: hero_weapon
	Checksum: 0x94875A66
	Offset: 0x820
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function hero_wait_for_out_of_ammo(slot, weapon)
{
	self endon(#"disconnect");
	self endon(#"death");
	self endon(#"give_map");
	self notify(#"hero_noammo");
	self endon(#"hero_noammo");
	while(true)
	{
		wait(0.1);
		gadgetslot = self gadgetgetslot(weapon);
		if(gadgetslot != slot)
		{
			return;
		}
		n_ammo = self getammocount(weapon);
		if(n_ammo == 0)
		{
			break;
		}
	}
	self gadgetpowerreset(slot);
	self gadgetcharging(slot, 1);
}

/*
	Name: set_gadget_hero_weapon_status
	Namespace: hero_weapon
	Checksum: 0xA9564C30
	Offset: 0x948
	Size: 0xB4
	Parameters: 3
	Flags: None
*/
function set_gadget_hero_weapon_status(weapon, status, time)
{
	timestr = "";
	if(isdefined(time))
	{
		timestr = (("^3") + ", time: ") + time;
	}
	if(getdvarint(#"scr_cpower_debug_prints", 0) > 0)
	{
		self iprintlnbold(((("Hero Weapon " + weapon.name) + ": ") + status) + timestr);
	}
}

