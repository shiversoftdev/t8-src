// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_6158278c8647d8a9;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_8c6426a5;

/*
	Name: function_89f2df9
	Namespace: namespace_8c6426a5
	Checksum: 0x5D749675
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_78b8c19649955958", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8c6426a5
	Checksum: 0xAC67FBE3
	Offset: 0x110
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_b20b4885::function_e9e03d6f(#"zombie_in_combat", &zombie_in_combat);
	namespace_b20b4885::function_e9e03d6f(#"hash_7cf5d8ae94c74382", &function_6300517d);
	namespace_b20b4885::function_e9e03d6f(#"hash_26e050bc0c121f1b", &function_a3d8f155);
	namespace_b20b4885::function_e9e03d6f(#"zombie_interact", &zombie_interact);
	namespace_b20b4885::function_e9e03d6f(#"zombie_weapon_upgrade", &zombie_weapon_upgrade);
	namespace_b20b4885::function_aa8c6854(#"zombie_interact", &function_a0b3c01e);
	namespace_b20b4885::function_aa8c6854(#"zombie_weapon_upgrade", &function_957ba503);
}

/*
	Name: zombie_in_combat
	Namespace: namespace_8c6426a5
	Checksum: 0xD51D8BE1
	Offset: 0x270
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function zombie_in_combat(params, tacbundle)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_6300517d
	Namespace: namespace_8c6426a5
	Checksum: 0x7E45F191
	Offset: 0x2B8
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_6300517d(params, tacbundle)
{
	if(isdefined(self.enemy))
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_a3d8f155
	Namespace: namespace_8c6426a5
	Checksum: 0x546FD46F
	Offset: 0x300
	Size: 0x188
	Parameters: 2
	Flags: Linked
*/
function function_a3d8f155(params, tacbundle)
{
	allies = [];
	foreach(player in getplayers())
	{
		if(player == self)
		{
			continue;
		}
		if(!isalive(player) || isdefined(player.revivetrigger))
		{
			continue;
		}
		if(!isdefined(player.sessionstate) || player.sessionstate != "playing" || self.team != player.team)
		{
			continue;
		}
		allies[allies.size] = player;
	}
	if(allies.size <= 0)
	{
		return 0;
	}
	var_6836ac55 = arraygetclosest(self.origin, allies);
	self namespace_b20b4885::set_position(var_6836ac55.origin);
	return 1;
}

/*
	Name: zombie_interact
	Namespace: namespace_8c6426a5
	Checksum: 0xC1A86CB5
	Offset: 0x490
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function zombie_interact(params, tacbundle)
{
	if(!self bot::function_43a720c7())
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: zombie_weapon_upgrade
	Namespace: namespace_8c6426a5
	Checksum: 0xAA9A7CB2
	Offset: 0x4E8
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function zombie_weapon_upgrade(params, tacbundle)
{
	if(!self bot::function_914feddd())
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_a0b3c01e
	Namespace: namespace_8c6426a5
	Checksum: 0x45D1DE10
	Offset: 0x540
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_a0b3c01e()
{
	if(!self bot::function_43a720c7())
	{
		return undefined;
	}
	var_efad0f6 = self getpathfindingradius();
	interact = self bot::function_f47bf51d();
	if(isentity(interact))
	{
		return self bot::function_f0c35734(interact);
	}
	if(isdefined(interact.trigger_stub))
	{
		return self bot::function_52947b70(interact.trigger_stub);
	}
	if(isdefined(interact.unitrigger_stub))
	{
		return self bot::function_52947b70(interact.unitrigger_stub);
	}
	return self bot::function_52947b70(interact);
}

/*
	Name: function_957ba503
	Namespace: namespace_8c6426a5
	Checksum: 0xA6A5E8D9
	Offset: 0x650
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_957ba503()
{
	if(!self bot::function_914feddd())
	{
		return undefined;
	}
	upgrade = self bot::function_f47bf51d();
	return self bot::function_52947b70(upgrade.trigger_stub);
}

