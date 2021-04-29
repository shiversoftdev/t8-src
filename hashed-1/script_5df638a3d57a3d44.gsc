// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_3cf5e4cf;

/*
	Name: function_89f2df9
	Namespace: namespace_3cf5e4cf
	Checksum: 0x423DBC12
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7b573f6f3650105e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3cf5e4cf
	Checksum: 0xB039978C
	Offset: 0x120
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_extra_self_revive", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_3cf5e4cf
	Checksum: 0xA4A6CFD
	Offset: 0x158
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self zm_laststand::function_3a00302e(1);
}

