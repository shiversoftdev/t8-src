// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace global_fx;

/*
	Name: __init__system__
	Namespace: global_fx
	Checksum: 0x20F4789
	Offset: 0x70
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"global_fx", &__init__, &main, undefined);
}

/*
	Name: __init__
	Namespace: global_fx
	Checksum: 0x80F724D1
	Offset: 0xC0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: main
	Namespace: global_fx
	Checksum: 0x3C990C0F
	Offset: 0xD0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function main()
{
	check_for_wind_override();
}

/*
	Name: check_for_wind_override
	Namespace: global_fx
	Checksum: 0xCAC6A371
	Offset: 0xF0
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function check_for_wind_override()
{
	if(isdefined(level.custom_wind_callback))
	{
		level thread [[level.custom_wind_callback]]();
	}
}

