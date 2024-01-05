// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\zm\ai\zm_ai_werewolf.gsc;

#namespace zm_ai_werewolf_interface;

/*
	Name: registerwerewolfinterfaceattributes
	Namespace: zm_ai_werewolf_interface
	Checksum: 0x1E64ECBC
	Offset: 0x78
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function registerwerewolfinterfaceattributes()
{
	ai::registermatchedinterface(#"werewolf", #"patrol", 0, array(1, 0), &zm_ai_werewolf::function_2341cdf0);
	ai::registermatchedinterface(#"werewolf", #"summon_wolves", 0, array(1, 0), &zm_ai_werewolf::function_2c67c3e1);
}

