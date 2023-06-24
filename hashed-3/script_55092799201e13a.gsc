// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_480b4ef11b7c73ec;
#using scripts\core_common\system_shared.csc;

#namespace mute_smoke;

/*
	Name: __init__system__
	Namespace: mute_smoke
	Checksum: 0xFFD81B72
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"mute_smoke", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: mute_smoke
	Checksum: 0xE53EE743
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

