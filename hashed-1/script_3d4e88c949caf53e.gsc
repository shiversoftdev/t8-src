// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;

#namespace bgb_pack;

/*
	Name: function_89f2df9
	Namespace: bgb_pack
	Checksum: 0x10419B8E
	Offset: 0x138
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"bgb_pack", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: bgb_pack
	Checksum: 0xB0CB3680
	Offset: 0x188
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("clientuimodel", "zmhud.bgb_carousel.global_cooldown", 1, 5, "float", undefined, 0, 0);
	for(i = 0; i < 4; i++)
	{
		clientfield::register("clientuimodel", ("zmhud.bgb_carousel." + i) + ".state", 1, 2, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", ("zmhud.bgb_carousel." + i) + ".gum_idx", 1, 7, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", ("zmhud.bgb_carousel." + i) + ".cooldown_perc", 1, 5, "float", undefined, 0, 0);
		clientfield::register("clientuimodel", ("zmhud.bgb_carousel." + i) + ".lockdown", 1, 1, "float", undefined, 0, 0);
		clientfield::register("clientuimodel", ("zmhud.bgb_carousel." + i) + ".unavailable", 1, 1, "float", undefined, 0, 0);
	}
}

/*
	Name: __main__
	Namespace: bgb_pack
	Checksum: 0xEE02267F
	Offset: 0x358
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
}

