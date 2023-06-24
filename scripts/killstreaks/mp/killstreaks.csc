// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\mp\killstreak_vehicle.csc;
#using scripts\killstreaks\killstreaks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace killstreaks;

/*
	Name: __init__system__
	Namespace: killstreaks
	Checksum: 0x5043BA20
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"killstreaks", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: killstreaks
	Checksum: 0x6983C6E6
	Offset: 0xC8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	killstreak_vehicle::init();
}

