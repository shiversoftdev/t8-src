// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\ai\planner_mp_dom_squad.gsc;
#using script_60f1433e7c9a921c;
#using scripts\core_common\ai\planner_squad_utility.gsc;
#using scripts\core_common\ai\planner_generic_commander.gsc;
#using scripts\core_common\ai\planner_commander_utility.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using script_31e56101095f174b;
#using script_522aeb6ae906391e;

#namespace plannermpdomcommander;

/*
	Name: createcommanderplanner
	Namespace: plannermpdomcommander
	Checksum: 0xCD5775F9
	Offset: 0x188
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private createcommanderplanner(team)
{
	planner = plannerutility::createplannerfromasset("mp_dom_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: plannermpdomcommander
	Checksum: 0xF46738E5
	Offset: 0x1C8
	Size: 0x1E0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpdomsquad::createsquadplanner(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonDomFlags");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreDomFlags");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage":15000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreStopWanderingDom");
	return commander;
}

