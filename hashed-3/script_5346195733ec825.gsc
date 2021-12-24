// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_200b13b5d57385c9;
#using script_31e56101095f174b;
#using script_387c92656e7ac7d1;
#using script_39c61335d85620af;
#using script_3d2e260ec67fded8;
#using script_522aeb6ae906391e;
#using script_60f1433e7c9a921c;
#using script_7312bc36741c9418;

#namespace namespace_f4b94322;

/*
	Name: function_cdaddee
	Namespace: namespace_f4b94322
	Checksum: 0xB9512CD
	Offset: 0x170
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
private function function_cdaddee(team)
{
	planner = plannerutility::createplannerfromasset("mp_control_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: namespace_f4b94322
	Checksum: 0x1FAB739D
	Offset: 0x1B0
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, function_cdaddee(team), namespace_1aa9e8f3::function_ce59625f(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonControlZones");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"hash_2fe4d5f6cd1c7ca8":20000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreControlZones");
	return commander;
}

