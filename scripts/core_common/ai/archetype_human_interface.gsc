// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\ai\archetype_human.gsc;

#namespace humaninterface;

/*
	Name: registerhumaninterfaceattributes
	Namespace: humaninterface
	Checksum: 0x29EEA6AC
	Offset: 0xD8
	Size: 0x60C
	Parameters: 0
	Flags: Linked
*/
function registerhumaninterfaceattributes()
{
	ai::registermatchedinterface(#"human", #"can_be_meleed", 1, array(1, 0), &aiutility::meleeattributescallback);
	ai::registermatchedinterface(#"human", #"can_melee", 1, array(1, 0), &aiutility::meleeattributescallback);
	ai::registermatchedinterface(#"human", #"can_initiateaivsaimelee", 1, array(1, 0));
	ai::registermatchedinterface(#"human", #"coveridleonly", 0, array(1, 0));
	ai::registermatchedinterface(#"human", #"cqb", 0, array(1, 0), &humansoldierserverutils::cqbattributecallback);
	ai::registermatchedinterface(#"human", #"forcetacticalwalk", 0, array(1, 0), &humansoldierserverutils::forcetacticalwalkcallback);
	ai::registermatchedinterface(#"human", #"move_mode", "normal", array("normal", "escort", "guard", "normal", "marching", "rambo", "rusher", "squadmember"), &humansoldierserverutils::movemodeattributecallback);
	ai::registermatchedinterface(#"human", #"useanimationoverride", 0, array(1, 0), &humansoldierserverutils::useanimationoverridecallback);
	ai::registermatchedinterface(#"human", #"sprint", 0, array(1, 0), &humansoldierserverutils::forcesprintcallback);
	ai::registermatchedinterface(#"human", #"patrol", 0, array(1, 0));
	ai::registermatchedinterface(#"human", #"disablearrivals", 0, array(1, 0), &aiutility::arrivalattributescallback);
	ai::registermatchedinterface(#"human", #"disablesprint", 0, array(1, 0), &humansoldierserverutils::disablesprintcallback);
	ai::registermatchedinterface(#"human", #"stealth", 0, array(1, 0));
	ai::registermatchedinterface(#"human", #"vignette_mode", "off", array("off", "slow", "fast"), &humansoldierserverutils::vignettemodecallback);
	ai::registermatchedinterface(#"human", #"usegrenades", 1, array(1, 0));
	ai::registermatchedinterface(#"human", #"usegrenadelauncher", 0, array(1, 0));
	ai::registermatchedinterface(#"human", #"uselightninggun", 0, array(1, 0));
	ai::registermatchedinterface(#"human", #"useannihilator", 0, array(1, 0));
}

