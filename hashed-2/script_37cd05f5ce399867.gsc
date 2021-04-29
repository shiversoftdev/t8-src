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

#namespace namespace_58fa9f4;

/*
	Name: function_89f2df9
	Namespace: namespace_58fa9f4
	Checksum: 0x6A6ECAC1
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_18466e57383383c9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_58fa9f4
	Checksum: 0xFD5EB051
	Offset: 0x110
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_coagulant", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_58fa9f4
	Checksum: 0x353675D9
	Offset: 0x148
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self.var_5c4f1263 = 1.5;
}

