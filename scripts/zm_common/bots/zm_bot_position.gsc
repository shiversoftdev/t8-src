// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\bots\bot_position.gsc;

#namespace zm_bot_position;

/*
	Name: __init__system__
	Namespace: zm_bot_position
	Checksum: 0x5D749675
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bot_position", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_bot_position
	Checksum: 0xAC67FBE3
	Offset: 0x110
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	bot_position::function_e9e03d6f(#"zombie_in_combat", &zombie_in_combat);
	bot_position::function_e9e03d6f(#"hash_7cf5d8ae94c74382", &function_6300517d);
	bot_position::function_e9e03d6f(#"hash_26e050bc0c121f1b", &function_a3d8f155);
	bot_position::function_e9e03d6f(#"zombie_interact", &zombie_interact);
	bot_position::function_e9e03d6f(#"zombie_weapon_upgrade", &zombie_weapon_upgrade);
	bot_position::function_aa8c6854(#"zombie_interact", &function_a0b3c01e);
	bot_position::function_aa8c6854(#"zombie_weapon_upgrade", &function_957ba503);
}

/*
	Name: zombie_in_combat
	Namespace: zm_bot_position
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
	return bot_position::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_6300517d
	Namespace: zm_bot_position
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
	return bot_position::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_a3d8f155
	Namespace: zm_bot_position
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
		return false;
	}
	closestally = arraygetclosest(self.origin, allies);
	self bot_position::set_position(closestally.origin);
	return true;
}

/*
	Name: zombie_interact
	Namespace: zm_bot_position
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
	return bot_position::function_d0cf287b(params, tacbundle);
}

/*
	Name: zombie_weapon_upgrade
	Namespace: zm_bot_position
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
	return bot_position::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_a0b3c01e
	Namespace: zm_bot_position
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
	pathfindingradius = self getpathfindingradius();
	interact = self bot::get_interact();
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
	Namespace: zm_bot_position
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
	upgrade = self bot::get_interact();
	return self bot::function_52947b70(upgrade.trigger_stub);
}

