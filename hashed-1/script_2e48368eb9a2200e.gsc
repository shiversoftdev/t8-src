// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_31e56101095f174b;
#using script_387c92656e7ac7d1;
#using script_39c61335d85620af;
#using script_3d2e260ec67fded8;
#using script_522aeb6ae906391e;
#using script_60f1433e7c9a921c;
#using script_6c3d8db095c51b5e;
#using script_7312bc36741c9418;

#namespace namespace_16057557;

/*
	Name: function_cdaddee
	Namespace: namespace_16057557
	Checksum: 0x40DC25DB
	Offset: 0x168
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cdaddee(team)
{
	planner = plannerutility::createplannerfromasset("mp_koth_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: namespace_16057557
	Checksum: 0x82DEEEC3
	Offset: 0x1A8
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, function_cdaddee(team), namespace_939fc294::function_ce59625f(team), (float(function_60d95f53()) / 1000) * 40, (float(function_60d95f53()) / 1000) * 100, 3, 3);
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, "daemonKothZone");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreKothZone");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"hash_2fe4d5f6cd1c7ca8":15000]);
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
	return commander;
}

