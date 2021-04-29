// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_19424da8b32cedc;
#using script_59f07c660e6710a5;

#namespace namespace_ec52743e;

/*
	Name: function_66e26b6f
	Namespace: namespace_ec52743e
	Checksum: 0x8E01950C
	Offset: 0x78
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_66e26b6f()
{
	ai::registermatchedinterface(#"gladiator", #"run", 0, array(1, 0));
	ai::registermatchedinterface(#"gladiator", #"axe_throw", 1, array(1, 0));
	ai::registernumericinterface(#"gladiator", #"damage_multiplier", 1, 0, 100);
}

