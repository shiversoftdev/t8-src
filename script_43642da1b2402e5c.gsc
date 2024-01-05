// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_a9e73d8d;

/*
	Name: __init__system__
	Namespace: namespace_a9e73d8d
	Checksum: 0x2CF16A42
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_1f1fd12b1b87ef2c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a9e73d8d
	Checksum: 0x89007523
	Offset: 0x170
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
	zm_trial::register_challenge(#"hash_3ad5e71a03ad70c1", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_a9e73d8d
	Checksum: 0x4038CF6E
	Offset: 0x1D8
	Size: 0x16C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	level.var_375482b5 = 1;
	callback::on_ai_killed(&on_ai_killed);
	callback::function_33f0ddd3(&function_33f0ddd3);
	callback::on_weapon_change(&zm_trial_util::function_79518194);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_bf710271(1, 1, 1, 0, 0);
		player thread zm_trial_util::function_dc9ab223(1, 0);
		player thread lock_shield();
		player thread function_29ee24dd();
	}
	level zm_trial::function_25ee130(1);
}

/*
	Name: on_end
	Namespace: namespace_a9e73d8d
	Checksum: 0x50C94472
	Offset: 0x350
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	level.var_375482b5 = undefined;
	callback::remove_on_ai_killed(&on_ai_killed);
	callback::function_824d206(&function_33f0ddd3);
	callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
	level zm_trial::function_25ee130(0);
	level thread refill_ammo();
}

/*
	Name: refill_ammo
	Namespace: namespace_a9e73d8d
	Checksum: 0x42BD558B
	Offset: 0x400
	Size: 0x214
	Parameters: 0
	Flags: Linked, Private
*/
function private refill_ammo()
{
	self notify("416a437667c7c600");
	self endon("416a437667c7c600");
	while(is_active())
	{
		waitframe(1);
	}
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_dc0859e();
		a_w_weapons = player getweaponslist(0);
		foreach(w_weapon in a_w_weapons)
		{
			if(zm_loadout::is_lethal_grenade(w_weapon) || zm_loadout::is_melee_weapon(w_weapon) || zm_loadout::is_hero_weapon(w_weapon))
			{
				continue;
			}
			if(isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[w_weapon]) && (!(isdefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)))
			{
				continue;
			}
			player zm_weapons::ammo_give(w_weapon, 0);
		}
	}
}

/*
	Name: lock_shield
	Namespace: namespace_a9e73d8d
	Checksum: 0x3836240F
	Offset: 0x620
	Size: 0x118
	Parameters: 0
	Flags: Linked, Private
*/
function private lock_shield()
{
	foreach(weapon in zm_loadout::function_5a5a742a("tactical_grenade"))
	{
		self function_28602a03(weapon, 1, 1);
		if(weapon.dualwieldweapon != level.weaponnone)
		{
			self function_28602a03(weapon.dualwieldweapon, 1, 1);
		}
		if(weapon.altweapon != level.weaponnone)
		{
			self function_28602a03(weapon.altweapon, 1, 1);
		}
	}
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_a9e73d8d
	Checksum: 0xCEE7B4C4
	Offset: 0x740
	Size: 0x184
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(s_event.weapon.inventorytype === "item")
		{
			return;
		}
		if(zm_loadout::is_lethal_grenade(s_event.weapon) || zm_loadout::is_tactical_grenade(s_event.weapon, 1))
		{
			self function_28602a03(s_event.weapon, 1, 1);
			if(s_event.weapon.dualwieldweapon != level.weaponnone)
			{
				self function_28602a03(s_event.weapon.dualwieldweapon, 1, 1);
			}
			if(s_event.weapon.altweapon != level.weaponnone)
			{
				self function_28602a03(s_event.weapon.altweapon, 1, 1);
			}
		}
		else
		{
			waitframe(1);
			self setweaponammostock(s_event.weapon, 0);
		}
	}
}

/*
	Name: function_29ee24dd
	Namespace: namespace_a9e73d8d
	Checksum: 0xE35582F0
	Offset: 0x8D0
	Size: 0x1F4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_29ee24dd()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	a_w_weapons = self getweaponslist(0);
	self reset_ammo(1);
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = self waittill(#"zmb_max_ammo", #"hash_278526d0bbdb4ce7", #"melee_reload", #"wallbuy_done");
		w_current = self getcurrentweapon();
		if(s_waitresult._notify == "melee_reload")
		{
			self setweaponammoclip(w_current, w_current.clipsize);
		}
		else
		{
			a_weapons = self getweaponslist(0);
			foreach(weapon in a_weapons)
			{
				if(!(zm_loadout::is_lethal_grenade(weapon) || zm_loadout::is_hero_weapon(weapon)))
				{
					self setweaponammostock(weapon, 0);
				}
			}
		}
	}
}

/*
	Name: is_active
	Namespace: namespace_a9e73d8d
	Checksum: 0x6A381480
	Offset: 0xAD0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_3ad5e71a03ad70c1");
	return isdefined(s_challenge);
}

/*
	Name: on_ai_killed
	Namespace: namespace_a9e73d8d
	Checksum: 0xA7843761
	Offset: 0xB10
	Size: 0x60
	Parameters: 1
	Flags: Linked, Private
*/
function private on_ai_killed(params)
{
	if(isplayer(params.eattacker) && params.smeansofdeath === "MOD_MELEE")
	{
		params.eattacker notify(#"melee_reload");
	}
}

/*
	Name: reset_ammo
	Namespace: namespace_a9e73d8d
	Checksum: 0x38076A49
	Offset: 0xB78
	Size: 0x1B0
	Parameters: 1
	Flags: Linked, Private
*/
function private reset_ammo(var_f2c84b6b)
{
	self notify("70d94e798e24bb1e");
	self endon("70d94e798e24bb1e");
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
		if(zm_loadout::is_hero_weapon(weapon) || zm_loadout::is_lethal_grenade(weapon))
		{
			continue;
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

