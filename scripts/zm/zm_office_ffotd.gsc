// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace zm_office_ffotd;

/*
	Name: __init__system__
	Namespace: zm_office_ffotd
	Checksum: 0x2657DA81
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_ffotd", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_ffotd
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
	Namespace: zm_office_ffotd
	Checksum: 0x52D9118E
	Offset: 0x100
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	spawncollision("collision_clip_wall_128x128x10", "collider", (-1683, 3653, -654), vectorscale((0, 1, 0), 357.6));
	spawncollision("collision_clip_wall_128x128x10", "collider", (-1519, 3594, -654), (0, 0, 0));
	spawncollision("collision_clip_wall_128x128x10", "collider", (-716, 4286, -654), vectorscale((0, 1, 0), 2));
}

