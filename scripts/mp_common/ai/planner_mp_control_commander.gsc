// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\ai\planner_mp_control_squad.gsc;
#using script_31e56101095f174b;
#using scripts\core_common\ai\planner_generic_commander.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using script_522aeb6ae906391e;
#using script_60f1433e7c9a921c;
#using scripts\core_common\ai\planner_commander_utility.gsc;

#namespace plannermpcontrolcommander;

/*
	Name: createcommanderplanner
	Namespace: plannermpcontrolcommander
	Checksum: 0xB9512CD
	Offset: 0x170
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private createcommanderplanner(team)
{
	planner = plannerutility::createplannerfromasset("mp_control_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: plannermpcontrolcommander
	Checksum: 0x1FAB739D
	Offset: 0x1B0
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpcontrolsquad::createsquadplanner(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonControlZones");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage":20000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreControlZones");
	return commander;
}

