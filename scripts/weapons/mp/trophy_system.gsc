// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\trophy_system.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;

#namespace trophy_system;

/*
	Name: __init__system__
	Namespace: trophy_system
	Checksum: 0x4A548BD
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"trophy_system", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: trophy_system
	Checksum: 0xFD520EC0
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	function_720ddf7f(&function_ccfcde75);
}

/*
	Name: function_ccfcde75
	Namespace: trophy_system
	Checksum: 0xC0F62349
	Offset: 0x110
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_ccfcde75(trophy, grenade)
{
	self battlechatter::function_bd715920(trophy.weapon, grenade.owner, grenade.origin, trophy);
	self contracts::function_a54e2068(#"hash_369e3fd5caa5145b");
}

