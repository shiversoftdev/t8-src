// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_57f7003580bb15e0;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_74862d2d;

/*
	Name: function_89f2df9
	Namespace: namespace_74862d2d
	Checksum: 0x1C499757
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_48046696e6c2176f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_74862d2d
	Checksum: 0xEA476C41
	Offset: 0xE8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::function_6f4eaf88(function_4d1e7b48("explosive_damage"));
}

