// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace zm_red_ffotd;

/*
	Name: __init__system__
	Namespace: zm_red_ffotd
	Checksum: 0x9409D69C
	Offset: 0x1D0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_red_ffotd", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_red_ffotd
	Checksum: 0x80F724D1
	Offset: 0x220
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: zm_red_ffotd
	Checksum: 0xCB6226A7
	Offset: 0x230
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	spawncollision("collision_clip_128x128x128", "cliff_ruins_spawn_closet", (-3199, 7000, 508), vectorscale((0, 1, 0), 245));
	spawncollision("collision_clip_ramp_128x24", "collider", (21527.5, 21421, 900), vectorscale((0, 1, 0), 126.3));
	spawncollision("collision_clip_64x64x256", "amphitheater_statue_top_1", (-2080, 1553, 512), (0, 0, 0));
	spawncollision("collision_clip_64x64x256", "amphitheater_statue_top_2", (-1944.54, 1468.39, 512), vectorscale((0, 1, 0), 347.199));
	spawncollision("collision_clip_wall_512x512x10", "temple_terrace_column", (-328, -533, 291), vectorscale((0, 1, 0), 280.2));
	spawncollision("collision_clip_256x256x256", "apollo_temple_stairs", (-1228, -801, -64), vectorscale((0, 1, 0), 10));
	spawncollision("collision_clip_wall_128x128x10", "river_of_sorrows_murder_door", (-689, 5442, 1376), vectorscale((0, 1, 0), 315));
}

