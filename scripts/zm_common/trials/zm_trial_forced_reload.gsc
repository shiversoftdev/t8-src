// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_forced_reload;

/*
	Name: __init__system__
	Namespace: zm_trial_forced_reload
	Checksum: 0x1E6F2A36
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_forced_reload", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_forced_reload
	Checksum: 0x2D5B2EA1
	Offset: 0x120
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"forced_reload", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_forced_reload
	Checksum: 0x9A889F82
	Offset: 0x188
	Size: 0x134
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	callback::on_weapon_fired(&on_weapon_fired);
	callback::function_33f0ddd3(&function_33f0ddd3);
	callback::on_weapon_change(&zm_trial_util::function_79518194);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_bf710271(1, 1, 1, 0, 1);
		player thread zm_trial_util::function_dc9ab223(1, 1);
	}
	level zm_trial::function_25ee130(1);
}

/*
	Name: on_end
	Namespace: zm_trial_forced_reload
	Checksum: 0xADACDEAB
	Offset: 0x2C8
	Size: 0x11C
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	callback::remove_on_weapon_fired(&on_weapon_fired);
	callback::function_824d206(&function_33f0ddd3);
	callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
	foreach(player in getplayers())
	{
		player notify(#"hash_1fbfdb0105f48f89");
		player thread zm_trial_util::function_dc0859e();
	}
	level zm_trial::function_25ee130(0);
}

/*
	Name: function_33f0ddd3
	Namespace: zm_trial_forced_reload
	Checksum: 0x70037877
	Offset: 0x3F0
	Size: 0x154
	Parameters: 1
	Flags: Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(zm_loadout::is_melee_weapon(s_event.weapon) || zm_loadout::is_lethal_grenade(s_event.weapon) || zm_loadout::is_tactical_grenade(s_event.weapon, 1))
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
	}
}

/*
	Name: on_weapon_fired
	Namespace: zm_trial_forced_reload
	Checksum: 0x166EF71
	Offset: 0x550
	Size: 0x104
	Parameters: 1
	Flags: Private
*/
function private on_weapon_fired(params)
{
	self notify("3a8478a97b3babfa");
	self endon("3a8478a97b3babfa");
	self endon(#"disconnect", #"hash_1fbfdb0105f48f89");
	n_clip_size = self getweaponammoclipsize(params.weapon);
	var_2cf11630 = self getweaponammoclip(params.weapon);
	if(n_clip_size > 1 && var_2cf11630 < n_clip_size)
	{
		if(params.weapon.isburstfire)
		{
			while(self isfiring())
			{
				waitframe(1);
			}
		}
		self thread function_29ee24dd(params.weapon);
	}
}

/*
	Name: function_29ee24dd
	Namespace: zm_trial_forced_reload
	Checksum: 0x45E7D74C
	Offset: 0x660
	Size: 0x1B4
	Parameters: 1
	Flags: Private
*/
function private function_29ee24dd(weapon)
{
	self endon(#"disconnect");
	self function_28602a03(weapon, 1, 1);
	self zm_trial_util::function_7dbb1712();
	n_clip_ammo = self getweaponammoclip(weapon);
	n_stock_ammo = self getweaponammostock(weapon);
	if(n_stock_ammo > 0)
	{
		while(true)
		{
			s_waitresult = undefined;
			s_waitresult = self waittill(#"reload", #"zmb_max_ammo", #"hash_278526d0bbdb4ce7", #"hash_1fbfdb0105f48f89", #"player_downed", #"death");
			w_current = self getcurrentweapon();
			if(s_waitresult._notify == "reload" && weapon != w_current)
			{
				continue;
			}
			else
			{
				break;
			}
		}
	}
	if(isdefined(self))
	{
		self unlockweapon(weapon);
		self zm_trial_util::function_7dbb1712(1);
	}
}

