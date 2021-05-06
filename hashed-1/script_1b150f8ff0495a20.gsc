// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace namespace_9803cd81;

/*
	Name: function_89f2df9
	Namespace: namespace_9803cd81
	Checksum: 0x462601AE
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_66a97b1c4426c728", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9803cd81
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
	Namespace: namespace_9803cd81
	Checksum: 0x588703EF
	Offset: 0x128
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	var_8a44c43c = (6512, 5109, 874);
	var_a9430bbc = vectorscale((0, 1, 0), 324);
	var_5774de71 = spawncollision("collision_clip_wall_256x256x10", "hack_collider", var_8a44c43c, var_a9430bbc);
	var_5774de71 disconnectpaths(0, 0);
	var_5774de71 notsolid();
	spawncollision("p8_col_rock_large_04", "collider", (-7044.5, -5855.5, 63.2374), (359.701, 349.702, 0.437607));
}

