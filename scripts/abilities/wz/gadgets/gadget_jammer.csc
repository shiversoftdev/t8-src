// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\abilities\gadgets\gadget_jammer_shared.csc;

#namespace jammer;

/*
	Name: __init__system__
	Namespace: jammer
	Checksum: 0x5AC515A5
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gadget_jammer", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: jammer
	Checksum: 0x82D05B92
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

