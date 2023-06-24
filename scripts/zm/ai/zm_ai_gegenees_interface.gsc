// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\zm\ai\zm_ai_gegenees.gsc;

#namespace zm_ai_gegenees_interface;

/*
	Name: registergegeneesinterfaceattributes
	Namespace: zm_ai_gegenees_interface
	Checksum: 0xC0DA991A
	Offset: 0x78
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function registergegeneesinterfaceattributes()
{
	ai::registermatchedinterface(#"gegenees", #"run", 0, array(1, 0));
	ai::registernumericinterface(#"gegenees", #"damage_multiplier", 1, 0, 100);
}

