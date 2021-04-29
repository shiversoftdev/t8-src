// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace mission_utils;

/*
	Name: function_89f2df9
	Namespace: mission_utils
	Checksum: 0x73140705
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"mission", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: mission_utils
	Checksum: 0x88118A63
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

/*
	Name: start
	Namespace: mission_utils
	Checksum: 0xF930AD24
	Offset: 0x128
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function start(mission_index)
{
	if(!isdefined(level.mission_active_flags))
	{
		level.mission_active_flags = 0;
	}
	level.mission_active_flags = level.mission_active_flags | 1 << mission_index;
	clientfield::set("mission_active_flags", level.mission_active_flags);
	startmission(mission_index);
}

/*
	Name: stop
	Namespace: mission_utils
	Checksum: 0x62D5B06B
	Offset: 0x1B8
	Size: 0xEC
	Parameters: 1
	Flags: None
*/
function stop(mission_index)
{
	if(!isdefined(level.mission_active_flags))
	{
		level.mission_active_flags = 0;
		return;
	}
	if(!isdefined(mission_index))
	{
		for(i = 0; i < 8; i++)
		{
			stop(i);
		}
		return;
	}
	if(level.mission_active_flags & 1 << mission_index != 0)
	{
		~level;
		level.mission_active_flags = level.mission_active_flags & 1 << mission_index;
		clientfield::set("mission_active_flags", level.mission_active_flags);
		stopmission(mission_index);
	}
}

