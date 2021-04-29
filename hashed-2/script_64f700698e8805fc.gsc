// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_11ad1b0c8864ba5c;
#using script_59f07c660e6710a5;

#namespace namespace_6ecedca5;

/*
	Name: function_8ce69ab0
	Namespace: namespace_6ecedca5
	Checksum: 0x1E64ECBC
	Offset: 0x78
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_8ce69ab0()
{
	ai::registermatchedinterface(#"werewolf", #"patrol", 0, array(1, 0), &namespace_4719c045::function_2341cdf0);
	ai::registermatchedinterface(#"werewolf", #"summon_wolves", 0, array(1, 0), &namespace_4719c045::function_2c67c3e1);
}

