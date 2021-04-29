// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using script_7c8638603dcfd100;

#namespace namespace_7bed886b;

/*
	Name: function_ce64b76b
	Namespace: namespace_7bed886b
	Checksum: 0xC0DA991A
	Offset: 0x78
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_ce64b76b()
{
	ai::registermatchedinterface(#"gegenees", #"run", 0, array(1, 0));
	ai::registernumericinterface(#"gegenees", #"damage_multiplier", 1, 0, 100);
}

