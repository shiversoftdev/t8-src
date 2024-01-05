// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_55cdac8f3eaa44cd;
#using script_1b4af057274ffcd0;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\ai\planner_generic_commander.gsc;
#using scripts\core_common\ai\planner_commander_utility.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using script_31e56101095f174b;

#namespace namespace_42cba673;

/*
	Name: __init__system__
	Namespace: namespace_42cba673
	Checksum: 0x1B6E5BF6
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	Name: createcommanderplanner
	Namespace: namespace_42cba673
	Checksum: 0xDD1A2186
	Offset: 0x110
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function createcommanderplanner(team)
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
	commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), createsquadplanner(team));
	plannergenericcommander::commanderdaemons(commander);
	plannercommanderutility::adddaemon(commander, #"daemonzmaltars");
	plannercommanderutility::adddaemon(commander, #"daemonzmblockers");
	plannercommanderutility::adddaemon(commander, #"daemonzmchests");
	plannercommanderutility::adddaemon(commander, #"daemonzmpowerups");
	plannercommanderutility::adddaemon(commander, #"daemonzmswitches");
	plannercommanderutility::adddaemon(commander, #"daemonzmwallbuys");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscorebotpresence");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreescortpathing");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreforcegoal");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreteam");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreviableescort");
	plannercommanderutility::addsquadevaluator(commander, #"commanderscoreage", [#"maxage":6000]);
}

