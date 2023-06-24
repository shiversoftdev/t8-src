// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace killstreak_detect;

/*
	Name: init_shared
	Namespace: killstreak_detect
	Checksum: 0xD9D84755
	Offset: 0xD0
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.cathedral_sitting))
	{
		level.cathedral_sitting = {};
		clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
		clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
		clientfield::register("missile", "enemyvehicle", 1, 2, "int");
		clientfield::register("actor", "enemyvehicle", 1, 2, "int");
		clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
	}
}

/*
	Name: killstreaktargetset
	Namespace: killstreak_detect
	Checksum: 0xF9D64B71
	Offset: 0x1F0
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function killstreaktargetset(killstreakentity, offset = (0, 0, 0))
{
	target_set(killstreakentity, offset);
	/#
		killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
	#/
}

/*
	Name: killstreaktargetclear
	Namespace: killstreak_detect
	Checksum: 0xD7230992
	Offset: 0x258
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function killstreaktargetclear(killstreakentity)
{
	target_remove(killstreakentity);
	/#
		killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
	#/
}

