// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\proximity_grenade.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace proximity_grenade;

/*
	Name: __init__system__
	Namespace: proximity_grenade
	Checksum: 0x84490A0F
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"proximity_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: proximity_grenade
	Checksum: 0x5DD3857F
	Offset: 0xD8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	level.trackproximitygrenadesonowner = 1;
}

