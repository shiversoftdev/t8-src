// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace zm_traps;

/*
	Name: __init__system__
	Namespace: zm_traps
	Checksum: 0x20992CE
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_traps", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_traps
	Checksum: 0x7585EDBD
	Offset: 0xE0
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	s_traps_array = struct::get_array("zm_traps", "targetname");
	a_registered_traps = [];
	foreach(trap in s_traps_array)
	{
		if(isdefined(trap.script_noteworthy))
		{
			if(!trap is_trap_registered(a_registered_traps))
			{
				a_registered_traps[trap.script_noteworthy] = 1;
			}
		}
	}
}

/*
	Name: is_trap_registered
	Namespace: zm_traps
	Checksum: 0xAA6B0984
	Offset: 0x1D0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_trap_registered(a_registered_traps)
{
	return isdefined(a_registered_traps[self.script_noteworthy]);
}

