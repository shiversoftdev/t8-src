// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_708634f09dc66b3;
#using scripts\core_common\system_shared.gsc;

#namespace proximity_grenade;

/*
	Name: function_89f2df9
	Namespace: proximity_grenade
	Checksum: 0xFEA2A705
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"proximity_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: proximity_grenade
	Checksum: 0x1224CDF0
	Offset: 0xC0
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	level.trackproximitygrenadesonowner = 1;
}

