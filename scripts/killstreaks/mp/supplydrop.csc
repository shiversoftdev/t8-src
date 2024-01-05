// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\killstreaks\supplydrop_shared.csc;

#namespace supplydrop;

/*
	Name: __init__system__
	Namespace: supplydrop
	Checksum: 0x7FAC4E7
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"supplydrop", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: supplydrop
	Checksum: 0xE1C7B52F
	Offset: 0xC8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

