// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39c61335d85620af;
#using script_59f07c660e6710a5;

#namespace commanderinterface;

/*
	Name: registercommanderinterfaceattributes
	Namespace: commanderinterface
	Checksum: 0x3A2BFA2D
	Offset: 0x78
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function registercommanderinterfaceattributes()
{
	ai::registerentityinterface(#"commander", #"commander_force_goal", undefined, &plannercommanderutility::setforcegoalattribute);
	ai::registermatchedinterface(#"commander", #"commander_golden_path", 1, array(1, 0), &plannercommanderutility::setgoldenpathattribute);
}

