// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2f2404e80f3ea88c;
#using script_31e56101095f174b;
#using script_387c92656e7ac7d1;
#using script_39c61335d85620af;
#using script_3d2e260ec67fded8;
#using script_522aeb6ae906391e;
#using script_60f1433e7c9a921c;
#using script_7312bc36741c9418;

#namespace namespace_ccb7bb29;

/*
	Name: function_cdaddee
	Namespace: namespace_ccb7bb29
	Checksum: 0xCD5775F9
	Offset: 0x188
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cdaddee(team)
{
	planner = plannerutility::createplannerfromasset("mp_dom_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: namespace_ccb7bb29
	Checksum: 0xF46738E5
	Offset: 0x1C8
	Size: 0x1E0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, function_cdaddee(team), namespace_cbb007b6::function_ce59625f(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonDomFlags");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreDomFlags");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"hash_2fe4d5f6cd1c7ca8":15000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreStopWanderingDom");
	return commander;
}

