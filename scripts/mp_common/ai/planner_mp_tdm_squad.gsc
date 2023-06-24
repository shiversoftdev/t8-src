// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16b1c195c0b9a9c;
#using script_31e56101095f174b;
#using scripts\core_common\ai\planner_commander.gsc;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using scripts\core_common\ai\planner_commander_utility.gsc;

#namespace plannermptdmsquad;

/*
	Name: createsquadplanner
	Namespace: plannermptdmsquad
	Checksum: 0xAAAE6DF0
	Offset: 0xA8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function createsquadplanner(team)
{
	planner = plannerutility::createplannerfromasset("mp_tdm_squad.ai_htn");
	return planner;
}

