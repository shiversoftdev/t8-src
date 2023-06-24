// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace zm_orange_trial_shoot_from_water;

/*
	Name: __init__system__
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0x8476ED18
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_orange_trial_shoot_from_water", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0x4F80B1BF
	Offset: 0x130
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"shoot_from_water", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0x176E1326
	Offset: 0x198
	Size: 0xC8
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	str_targetname = "trials_shoot_from_water";
	callback::function_33f0ddd3(&function_33f0ddd3);
	level zm_trial::function_25ee130(1);
	foreach(player in getplayers())
	{
		player thread function_9e0e99e1();
	}
}

/*
	Name: on_end
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0x426C24ED
	Offset: 0x268
	Size: 0xE2
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	callback::function_824d206(&function_33f0ddd3);
	level zm_trial::function_25ee130(0);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_dc0859e();
		player thread zm_trial_util::function_73ff0096();
	}
	level.var_7f31a12d = undefined;
}

/*
	Name: function_9e0e99e1
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0xF2983A14
	Offset: 0x358
	Size: 0x2F2
	Parameters: 0
	Flags: Private
*/
function private function_9e0e99e1()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	var_407eb07 = 0;
	while(true)
	{
		var_f2b6fe6e = 0;
		if(self.b_in_water === 1)
		{
			var_f2b6fe6e = 1;
		}
		if(var_f2b6fe6e && var_407eb07)
		{
			foreach(weapon in self getweaponslist(1))
			{
				self unlockweapon(weapon);
				if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
				{
					self unlockweapon(weapon.dualwieldweapon);
				}
			}
			self zm_trial_util::function_dc0859e();
			var_407eb07 = 0;
		}
		else if(!var_f2b6fe6e && !var_407eb07)
		{
			self zm_trial_util::function_bf710271();
			foreach(weapon in self getweaponslist(1))
			{
				if(zm_loadout::function_2ff6913(weapon) == 1)
				{
					self unlockweapon(weapon);
					if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
					{
						self unlockweapon(weapon.dualwieldweapon);
					}
					continue;
				}
				self function_28602a03(weapon);
				if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
				{
					self function_28602a03(weapon.dualwieldweapon, 1, 1);
				}
			}
			var_407eb07 = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_33f0ddd3
	Namespace: zm_orange_trial_shoot_from_water
	Checksum: 0xE43D1D6E
	Offset: 0x658
	Size: 0x1E0
	Parameters: 1
	Flags: Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon" || s_event.event === "give_weapon_alt" || s_event.event == "give_weapon_dual")
	{
		var_f2b6fe6e = 0;
		if(self.b_in_water === 1)
		{
			var_f2b6fe6e = 1;
		}
		else if(!var_f2b6fe6e)
		{
			foreach(weapon in self getweaponslist(1))
			{
				if(zm_loadout::function_2ff6913(weapon) == 1)
				{
					self unlockweapon(weapon);
					if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
					{
						self unlockweapon(weapon.dualwieldweapon);
					}
					continue;
				}
				self function_28602a03(weapon);
				if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
				{
					self function_28602a03(weapon.dualwieldweapon, 1, 1);
				}
			}
		}
	}
}

