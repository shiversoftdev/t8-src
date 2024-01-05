// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace zm_towers_ffotd;

/*
	Name: __init__system__
	Namespace: zm_towers_ffotd
	Checksum: 0xCB75C93E
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_towers_ffotd", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_towers_ffotd
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
	Namespace: zm_towers_ffotd
	Checksum: 0x9D9F7DFC
	Offset: 0x100
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	var_bb230d1 = spawncollision("collision_bullet_wall_128x128x10", "collider", (940, 948, -216), vectorscale((0, 1, 0), 45));
}

