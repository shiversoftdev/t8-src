// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace wz_escape_ffotd;

/*
	Name: __init__system__
	Namespace: wz_escape_ffotd
	Checksum: 0x462601AE
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_escape_ffotd", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: wz_escape_ffotd
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
	Namespace: wz_escape_ffotd
	Checksum: 0x588703EF
	Offset: 0x128
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	col_origin = (6512, 5109, 874);
	var_a9430bbc = vectorscale((0, 1, 0), 324);
	hack_col = spawncollision("collision_clip_wall_256x256x10", "hack_collider", col_origin, var_a9430bbc);
	hack_col disconnectpaths(0, 0);
	hack_col notsolid();
	spawncollision("p8_col_rock_large_04", "collider", (-7044.5, -5855.5, 63.2374), (359.701, 349.702, 0.437607));
}

