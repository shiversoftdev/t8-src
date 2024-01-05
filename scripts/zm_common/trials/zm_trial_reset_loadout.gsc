// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace zm_trial_reset_loadout;

/*
	Name: __init__system__
	Namespace: zm_trial_reset_loadout
	Checksum: 0xE12BA31D
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_reset_loadout", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_reset_loadout
	Checksum: 0x25E818E9
	Offset: 0x140
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"reset_loadout", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_reset_loadout
	Checksum: 0x29539A95
	Offset: 0x1A8
	Size: 0x130
	Parameters: 2
	Flags: Linked, Private
*/
function private on_begin(var_30dbb2e5, var_f2c84b6b)
{
	self.var_f2c84b6b = var_f2c84b6b;
	self.var_30dbb2e5 = var_30dbb2e5;
	if(var_30dbb2e5 === "zombie_fists")
	{
		level thread function_d1dabace();
	}
	foreach(player in getplayers())
	{
		if(var_30dbb2e5 === "ammo")
		{
			player thread reset_ammo(var_f2c84b6b);
			continue;
		}
		if(var_30dbb2e5 === "zombie_fists")
		{
			player thread reset_loadout(1);
			continue;
		}
		player thread reset_loadout();
	}
}

/*
	Name: is_active
	Namespace: zm_trial_reset_loadout
	Checksum: 0xEA892081
	Offset: 0x2E0
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function is_active(var_61ee083c = 0)
{
	s_challenge = zm_trial::function_a36e8c38(#"reset_loadout");
	if(var_61ee083c)
	{
		if(isdefined(s_challenge) && isdefined(s_challenge.var_f2c84b6b))
		{
			return 1;
		}
		return 0;
	}
	return isdefined(s_challenge);
}

/*
	Name: reset_ammo
	Namespace: zm_trial_reset_loadout
	Checksum: 0xEE9DC483
	Offset: 0x360
	Size: 0x320
	Parameters: 1
	Flags: Linked, Private
*/
function private reset_ammo(var_f2c84b6b)
{
	self notify("31521b89b82403a5");
	self endon("31521b89b82403a5");
	self endon(#"disconnect");
	if(!self zm_laststand::laststand_has_players_weapons_returned())
	{
		self waittill(#"hash_9b426cce825928d");
	}
	if(isdefined(self.var_9b0383f5) && self.var_9b0383f5)
	{
		self waittill(#"hash_1ac4338b0d419091");
	}
	a_weapons = self getweaponslist(0);
	foreach(weapon in a_weapons)
	{
		if(zm_loadout::is_hero_weapon(weapon))
		{
			n_slot = self gadgetgetslot(weapon);
			self gadgetpowerset(n_slot, 0);
			continue;
		}
		if(zm_loadout::is_lethal_grenade(weapon))
		{
			n_slot = self gadgetgetslot(weapon);
			if(weapon == getweapon(#"tomahawk_t8") || weapon == getweapon(#"tomahawk_t8_upgraded"))
			{
				while(self function_36dfc05f(n_slot))
				{
					waitframe(1);
				}
				self notify(#"hash_3d73720d4588203c");
				self gadgetpowerset(n_slot, 0);
				if(isdefined(level.var_6d0e2c1b) && isdefined(level.var_6d0e2c1b[weapon]))
				{
					self thread [[level.var_6d0e2c1b[weapon]]](weapon);
					self notify(#"hash_1a7714f0d7e25f27");
				}
			}
			else
			{
				self gadgetpowerset(n_slot, 0);
			}
			continue;
		}
		self setweaponammostock(weapon, 0);
		if(isdefined(var_f2c84b6b))
		{
			self setweaponammoclip(weapon, weapon.clipsize);
			continue;
		}
		self setweaponammoclip(weapon, 0);
	}
}

/*
	Name: reset_loadout
	Namespace: zm_trial_reset_loadout
	Checksum: 0x3020E30
	Offset: 0x688
	Size: 0x1CE
	Parameters: 1
	Flags: Linked, Private
*/
function private reset_loadout(var_96288bc8 = 0)
{
	self notify("48ec1afa4e1f3b29");
	self endon("48ec1afa4e1f3b29");
	self endon(#"disconnect");
	if(!self zm_laststand::laststand_has_players_weapons_returned())
	{
		self waittill(#"hash_9b426cce825928d");
	}
	if(isdefined(self.var_9b0383f5) && self.var_9b0383f5)
	{
		self waittill(#"hash_1ac4338b0d419091");
	}
	if(level flag::get("round_reset"))
	{
		return;
	}
	self takeallweapons();
	self.var_2a62e678 = undefined;
	self.var_64f51f65 = undefined;
	if(var_96288bc8)
	{
		self zm_weapons::weapon_give(level.weaponzmfists, 1);
		if(isdefined(level.var_7f7fd2ac))
		{
			level waittill(#"enable_equipment", #"hash_7646638df88a3656");
		}
	}
	self zm_loadout::give_start_weapon(1);
	self zm_loadout::init_player_offhand_weapons();
	for(slot = 0; slot < 3; slot++)
	{
		if(isdefined(self._gadgets_player[slot]))
		{
			self gadgetcharging(slot, 1);
		}
	}
}

/*
	Name: on_end
	Namespace: zm_trial_reset_loadout
	Checksum: 0xC5409DFA
	Offset: 0x860
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	if(self.var_30dbb2e5 === "zombie_fists")
	{
		function_59d771f7();
	}
}

/*
	Name: function_d1dabace
	Namespace: zm_trial_reset_loadout
	Checksum: 0xBCA08149
	Offset: 0x8A0
	Size: 0x194
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d1dabace(n_time = 30)
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	level.var_236b9f7a = &function_37fe3e07;
	level.func_override_wallbuy_prompt = &function_3d4fea64;
	level.func_magicbox_update_prompt_use_override = &function_bf591b5a;
	level.var_7f7fd2ac = gettime() + (int(n_time * 1000));
	wait(12);
	level.var_7f7fd2ac = gettime() + (int(n_time * 1000));
	foreach(player in getplayers())
	{
		player zm_trial_util::function_128378c9(n_time);
		player.var_838c00de = 1;
	}
	wait(n_time);
	function_59d771f7();
}

/*
	Name: function_59d771f7
	Namespace: zm_trial_reset_loadout
	Checksum: 0xF79A8E01
	Offset: 0xA40
	Size: 0xD2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_59d771f7()
{
	level notify(#"enable_equipment");
	level.var_236b9f7a = undefined;
	level.func_override_wallbuy_prompt = undefined;
	level.var_7f7fd2ac = undefined;
	level.func_magicbox_update_prompt_use_override = undefined;
	foreach(player in getplayers())
	{
		player zm_trial_util::function_885fb2c8();
		player.var_838c00de = undefined;
	}
}

/*
	Name: function_37fe3e07
	Namespace: zm_trial_reset_loadout
	Checksum: 0x34009759
	Offset: 0xB20
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function function_37fe3e07(e_player, var_957235ca)
{
	return true;
}

/*
	Name: function_3d4fea64
	Namespace: zm_trial_reset_loadout
	Checksum: 0x7E22EA71
	Offset: 0xB40
	Size: 0x16
	Parameters: 2
	Flags: Linked
*/
function function_3d4fea64(e_player, player_has_weapon)
{
	return false;
}

/*
	Name: function_bf591b5a
	Namespace: zm_trial_reset_loadout
	Checksum: 0xE197192B
	Offset: 0xB60
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_bf591b5a(e_player)
{
	return false;
}

