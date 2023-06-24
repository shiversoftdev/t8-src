// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace weaponobjects;

/*
	Name: __init__system__
	Namespace: weaponobjects
	Checksum: 0xAA31436
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"weaponobjects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weaponobjects
	Checksum: 0x56F1380A
	Offset: 0xE8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

