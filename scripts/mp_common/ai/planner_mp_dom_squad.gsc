// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16b1c195c0b9a9c;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using scripts\core_common\ai\planner_commander_utility.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using script_31e56101095f174b;

#namespace plannermpdomsquad;

/*
	Name: createsquadplanner
	Namespace: plannermpdomsquad
	Checksum: 0xBA33DAB
	Offset: 0xA8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function createsquadplanner(team)
{
	planner = plannerutility::createplannerfromasset("mp_dom_squad.ai_htn");
	return planner;
}

