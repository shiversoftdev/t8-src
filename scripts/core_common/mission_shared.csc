// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace mission_utils;

/*
	Name: __init__system__
	Namespace: mission_utils
	Checksum: 0x8EAD2693
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"mission", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: mission_utils
	Checksum: 0xDFD96586
	Offset: 0xE8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("world", "mission_active_flags", 1, 8, "int", &mission_active_changed, 0, 0);
}

/*
	Name: mission_active_changed
	Namespace: mission_utils
	Checksum: 0x1DBC5277
	Offset: 0x140
	Size: 0x16E
	Parameters: 7
	Flags: None
*/
function mission_active_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.mission_active_flags))
	{
		level.mission_active_flags = 0;
	}
	for(i = 0; i < 8; i++)
	{
		changedflags = level.mission_active_flags ^ newval;
		if((changedflags & (1 << i)) != 0)
		{
			if((level.mission_active_flags & (1 << i)) != 0)
			{
				stopmission(i);
			}
		}
	}
	for(i = 0; i < 8; i++)
	{
		changedflags = level.mission_active_flags ^ newval;
		if((changedflags & (1 << i)) != 0)
		{
			if((level.mission_active_flags & (1 << i)) == 0)
			{
				startmission(i);
			}
		}
	}
	level.mission_active_flags = newval;
}

