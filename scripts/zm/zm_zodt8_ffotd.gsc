// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace namespace_78d45989;

/*
	Name: function_89f2df9
	Namespace: namespace_78d45989
	Checksum: 0xC665204E
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_1776941ece88fdd8", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_78d45989
	Checksum: 0x80F724D1
	Offset: 0xF0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_78d45989
	Checksum: 0x1C80630A
	Offset: 0x100
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	spawncollision("collision_clip_wall_128x128x10", "collider", (190, -3839, 1149), vectorscale((0, 1, 0), 270));
}

