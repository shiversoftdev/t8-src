// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b4af057274ffcd0;
#using script_31e56101095f174b;
#using script_387c92656e7ac7d1;
#using script_39c61335d85620af;
#using script_55cdac8f3eaa44cd;
#using script_7312bc36741c9418;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_42cba673;

/*
	Name: function_89f2df9
	Namespace: namespace_42cba673
	Checksum: 0x1B6E5BF6
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_233e4730c6fdfb2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_42cba673
	Checksum: 0x420D61
	Offset: 0xE8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread createcommander();
}

/*
	Name: function_cdaddee
	Namespace: namespace_42cba673
	Checksum: 0xDD1A2186
	Offset: 0x110
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_cdaddee(team)
{
	planner = plannerutility::createplannerfromasset(#"zm_commander.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: namespace_42cba673
	Checksum: 0x50C2EF89
	Offset: 0x158
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function createcommander()
{
	team = #"allies";
	commander = plannercommanderutility::createcommander(team, function_cdaddee(team), function_ce59625f(team));
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, #"hash_62f9340b8f782bd5");
	plannercommanderutility::adddaemon(commander, #"daemonzmblockers");
	plannercommanderutility::adddaemon(commander, #"hash_5fb7ec66ffe3b9d2");
	plannercommanderutility::adddaemon(commander, #"hash_290aa7564003048d");
	plannercommanderutility::adddaemon(commander, #"hash_5021ab98d5068338");
	plannercommanderutility::adddaemon(commander, #"daemonzmwallbuys");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscorebotpresence");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreescortpathing");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreforcegoal");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreteam");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreviableescort");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreage", [#"hash_2fe4d5f6cd1c7ca8":6000]);
}

