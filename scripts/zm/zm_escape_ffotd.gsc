// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_d30e5d6;

/*
	Name: function_89f2df9
	Namespace: namespace_d30e5d6
	Checksum: 0x32D51B4B
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_60e7a4fa05470734", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d30e5d6
	Checksum: 0x80F724D1
	Offset: 0x118
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_d30e5d6
	Checksum: 0xADBA1690
	Offset: 0x128
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	spawncollision("collision_clip_ramp_256x24", "collider", (758, 6590, 495), (270, 0.2, 18.8));
	spawncollision("collision_clip_wall_256x256x10", "collider", (-1382.5, 5724, 177.5), vectorscale((0, 1, 0), 11.6));
	spawncollision("collision_clip_ramp_256x24", "collider", (376, 10144, 1568), vectorscale((1, 1, 0), 270));
}

