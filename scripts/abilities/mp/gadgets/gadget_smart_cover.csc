// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_util.csc;
#using scripts\abilities\ability_player.csc;
#using scripts\abilities\gadgets\gadget_smart_cover.csc;
#using scripts\abilities\ability_power.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace smart_cover;

/*
	Name: __init__system__
	Namespace: smart_cover
	Checksum: 0x38CFC11D
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gadget_smart_cover", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: smart_cover
	Checksum: 0x320A6F89
	Offset: 0xF8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

