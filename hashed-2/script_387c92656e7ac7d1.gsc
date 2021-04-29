// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_31e56101095f174b;
#using script_39c61335d85620af;
#using script_522aeb6ae906391e;
#using script_aa63c66acbb23e;

#namespace plannergenericcommander;

/*
	Name: _createcommanderplanner
	Namespace: plannergenericcommander
	Checksum: 0xC3567989
	Offset: 0x290
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
private function _createcommanderplanner(team)
{
	planner = plannerutility::createplannerfromasset("strategic_commander.ai_htn");
	return planner;
}

/*
	Name: _createsquadplanner
	Namespace: plannergenericcommander
	Checksum: 0x86FC34B1
	Offset: 0x2D0
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
private function _createsquadplanner(team)
{
	planner = plannerutility::createplannerfromasset("strategic_squad.ai_htn");
	return planner;
}

/*
	Name: createcommander
	Namespace: plannergenericcommander
	Checksum: 0x36501048
	Offset: 0x310
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function createcommander(team)
{
	commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
	commanderdaemons(commander);
	commanderutilityevaluators(commander);
	blackboard::setstructblackboardattribute(commander, #"gameobjects_exclude", array("ammo_cache", "mobile_armory", "trap"));
	return commander;
}

/*
	Name: commanderdaemons
	Namespace: plannergenericcommander
	Checksum: 0xB8FCB612
	Offset: 0x3E0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function commanderdaemons(commander)
{
	/#
		assert(isstruct(commander));
	#/
	plannercommanderutility::adddaemon(commander, "daemonClients");
	plannercommanderutility::adddaemon(commander, "daemonGameobjects");
}

/*
	Name: commanderutilityevaluators
	Namespace: plannergenericcommander
	Checksum: 0x2738D30C
	Offset: 0x460
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function commanderutilityevaluators(commander)
{
	/#
		assert(isstruct(commander));
	#/
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotChain");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotVehiclePresence");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreEscortPathing");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectsValidity");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPathing");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreNoTarget");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreViableEscort");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreProgressThrottling");
	plannercommanderutility::addsquadevaluator(commander, "commanderScoreTarget");
}

/*
	Name: function_6549878f
	Namespace: plannergenericcommander
	Checksum: 0x420CB40D
	Offset: 0x620
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_6549878f()
{
	function_321afadc();
	level.var_c2ba4b3d = createcommander(#"axis");
	level.var_6e68e2a4 = createcommander(#"allies");
}

/*
	Name: function_321afadc
	Namespace: plannergenericcommander
	Checksum: 0x1342A587
	Offset: 0x690
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_321afadc()
{
	strategiccommandutility::function_1852d313("default_strategicbundle", "sidea");
	strategiccommandutility::function_1852d313("default_strategicbundle", "sideb");
}

