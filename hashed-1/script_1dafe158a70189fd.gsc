// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4ee0ccb42a9d88f5;
#using script_59f07c660e6710a5;

#namespace namespace_1f694fcd;

/*
	Name: function_587ece09
	Namespace: namespace_1f694fcd
	Checksum: 0xB4CE821A
	Offset: 0x78
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_587ece09()
{
	ai::registermatchedinterface(#"brutus", #"can_ground_slam", 0, array(1, 0));
	ai::registermatchedinterface(#"brutus", #"scripted_mode", 0, array(1, 0), &namespace_363fe686::function_f8aa76ea);
	ai::registermatchedinterface(#"brutus", #"patrol", 0, array(1, 0));
}

