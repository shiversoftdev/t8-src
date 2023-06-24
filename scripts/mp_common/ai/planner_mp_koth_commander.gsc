// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_31e56101095f174b;
#using scripts\core_common\ai\planner_generic_commander.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using script_522aeb6ae906391e;
#using script_60f1433e7c9a921c;
#using scripts\mp_common\ai\planner_mp_koth_squad.gsc;
#using scripts\core_common\ai\planner_commander_utility.gsc;

#namespace plannermpkothcommander;

/*
	Name: createcommanderplanner
	Namespace: plannermpkothcommander
	Checksum: 0x40DC25DB
	Offset: 0x168
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private createcommanderplanner(team)
{
	planner = plannerutility::createplannerfromasset("mp_koth_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: plannermpkothcommander
	Checksum: 0x82DEEEC3
	Offset: 0x1A8
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpkothsquad::createsquadplanner(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonKothZone");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreKothZone");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage":15000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	return commander;
}

