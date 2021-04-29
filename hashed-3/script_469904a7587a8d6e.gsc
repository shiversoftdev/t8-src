// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_c3335ad0;

/*
	Name: function_89f2df9
	Namespace: namespace_c3335ad0
	Checksum: 0x2AF1DCF7
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1e9d64652f5b694e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c3335ad0
	Checksum: 0x55D40FA9
	Offset: 0x118
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_weapon_reducepapcost", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_c3335ad0
	Checksum: 0x8464C7CB
	Offset: 0x150
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self.talisman_weapon_reducepapcost = 1000;
}

