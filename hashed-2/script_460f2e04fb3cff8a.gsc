// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_25f0796c;

/*
	Name: function_89f2df9
	Namespace: namespace_25f0796c
	Checksum: 0x37451D23
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_771cd3c1dc16ee32", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_25f0796c
	Checksum: 0x86CFE75A
	Offset: 0x120
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
	zm_trial::register_challenge(#"headshots_only", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_25f0796c
	Checksum: 0xC9143673
	Offset: 0x188
	Size: 0x20C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d1de6a85(weapon_name)
{
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	zm_traps::function_6966417b();
	foreach(player in getplayers())
	{
		foreach(var_5a1e3e5b in level.hero_weapon)
		{
			foreach(w_hero in var_5a1e3e5b)
			{
				player function_28602a03(w_hero, 1, 1);
			}
		}
		player namespace_b22c99a5::function_9bf8e274();
		player namespace_b22c99a5::function_dc9ab223(1);
	}
	callback::function_33f0ddd3(&function_33f0ddd3);
	level zm_trial::function_44200d07(1);
	level zm_trial::function_cd75b690(1);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_25f0796c
	Checksum: 0x729DA5A0
	Offset: 0x3A0
	Size: 0x2A4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	level.var_153e9058 = 0;
	level.var_fe2bb2ac = 0;
	zm_traps::function_9d0c9706();
	foreach(player in getplayers())
	{
		foreach(var_5a1e3e5b in level.hero_weapon)
		{
			foreach(w_hero in var_5a1e3e5b)
			{
				player unlockweapon(w_hero);
			}
		}
		player namespace_b22c99a5::function_73ff0096();
		foreach(var_64225f6c in level.zombie_weapons)
		{
			if(var_64225f6c.weapon_classname === "equipment")
			{
				player unlockweapon(var_64225f6c.weapon);
			}
		}
		player namespace_b22c99a5::function_dc9ab223(0);
	}
	callback::function_824d206(&function_33f0ddd3);
	level zm_trial::function_44200d07(0);
	level zm_trial::function_cd75b690(0);
}

/*
	Name: is_active
	Namespace: namespace_25f0796c
	Checksum: 0x15525366
	Offset: 0x650
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"headshots_only");
	return isdefined(challenge);
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_25f0796c
	Checksum: 0x46A8B16E
	Offset: 0x690
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(zm_loadout::function_59b0ef71("lethal_grenade", s_event.weapon))
		{
			self function_28602a03(s_event.weapon, 1, 1);
		}
	}
}

