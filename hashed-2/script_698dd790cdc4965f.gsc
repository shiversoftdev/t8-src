// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_35d3717bf2cbee8f;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_83dc3729;

/*
	Name: function_89f2df9
	Namespace: namespace_83dc3729
	Checksum: 0x7E665A82
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_491590ee8fe06753", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_83dc3729
	Checksum: 0x9CDB43C6
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_7dd35595d2a7953a", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_83dc3729
	Checksum: 0xE66A79A2
	Offset: 0x140
	Size: 0x1C4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1de6a85()
{
	/#
		assert(isdefined(level.zombie_weapons_upgraded));
	#/
	level.var_af806901 = [];
	foreach(upgraded_weapon in getarraykeys(level.zombie_weapons_upgraded))
	{
		level.var_af806901[upgraded_weapon.name] = upgraded_weapon;
	}
	foreach(player in getplayers())
	{
		player function_6a8979c9();
		player callback::function_33f0ddd3(&function_33f0ddd3);
		player namespace_b22c99a5::function_7dbb1712(1);
		player callback::function_f77ced93(&namespace_b22c99a5::function_79518194);
	}
	namespace_b22c99a5::function_eea26e56();
	level zm_trial::function_8e2a923(1);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_83dc3729
	Checksum: 0x7FB58799
	Offset: 0x310
	Size: 0x1DC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::function_824d206(&function_33f0ddd3);
		player callback::function_5a753d97(&namespace_b22c99a5::function_79518194);
		foreach(weapon in player getweaponslist(1))
		{
			player unlockweapon(weapon);
			if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
			{
				player unlockweapon(weapon.dualwieldweapon);
			}
		}
		player namespace_b22c99a5::function_7dbb1712(1);
	}
	level.var_af806901 = undefined;
	namespace_b22c99a5::function_ef1fce77();
	level zm_trial::function_8e2a923(0);
}

/*
	Name: is_active
	Namespace: namespace_83dc3729
	Checksum: 0xF8E59557
	Offset: 0x4F8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_7dd35595d2a7953a");
	return isdefined(challenge);
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_83dc3729
	Checksum: 0x45195F85
	Offset: 0x538
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(eventstruct)
{
	self function_6a8979c9();
}

/*
	Name: function_6a8979c9
	Namespace: namespace_83dc3729
	Checksum: 0xB57119C5
	Offset: 0x568
	Size: 0x1C0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6a8979c9()
{
	/#
		assert(isdefined(level.var_af806901));
	#/
	foreach(weapon in self getweaponslist(1))
	{
		if(isdefined(level.var_af806901[weapon.name]))
		{
			self function_28602a03(weapon);
		}
		else if(!namespace_fc5170d1::is_active() || !isarray(level.var_3e2ac3b6) || !isdefined(level.var_3e2ac3b6[weapon.name]))
		{
			self unlockweapon(weapon);
		}
		if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
		{
			if(self function_635f9c02(weapon))
			{
				self function_28602a03(weapon.dualwieldweapon);
				continue;
			}
			self unlockweapon(weapon.dualwieldweapon);
		}
	}
}

