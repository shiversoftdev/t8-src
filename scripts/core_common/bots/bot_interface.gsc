// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\bots\bot.gsc;
#using script_59f07c660e6710a5;

#namespace botinterface;

/*
	Name: registerbotinterfaceattributes
	Namespace: botinterface
	Checksum: 0x66209CC
	Offset: 0x98
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function registerbotinterfaceattributes()
{
	ai::registermatchedinterface(#"bot", #"control", "commander", array("commander", "autonomous"), &bot::function_b5dd2fd2);
	ai::registermatchedinterface(#"bot", #"sprint", 0, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"revive", 1, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"slide", 1, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"ignorepathenemyfightdist", 0, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"allowprimaryoffhand", 1, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"allowsecondaryoffhand", 1, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"allowspecialoffhand", 1, array(1, 0), undefined);
	ai::registermatchedinterface(#"bot", #"allowscorestreak", 1, array(1, 0), undefined);
}

