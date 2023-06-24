// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5f90a0e71aee1dc4;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_3b2b9e06;

/*
	Name: preload
	Namespace: namespace_3b2b9e06
	Checksum: 0x78E9CD57
	Offset: 0xC0
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_707c26879c95b230"] = #"hash_40278bdd6f1bccd4";
	level._effect[#"hash_28331736982b6322"] = #"hash_23c866d50fb30876";
	level._effect[#"hash_5bfd50fb8c3b5ffb"] = #"hash_6b79a8fd6c76e84c";
	level._effect[#"mk2x_guard"] = #"hash_251307aa9b1c5042";
	namespace_bd74bbd2::register(#"sc_mk2x", 20000, "sc_mk2x", level._effect[#"hash_707c26879c95b230"], level._effect[#"hash_28331736982b6322"]);
	clientfield::register("scriptmover", "" + #"hash_56a1bc72bf8de8f1", 20000, 1, "int", &function_7cd6e78c, 0, 0);
	clientfield::register("actor", "" + #"hash_38c69da8fb2b74e4", 20000, 1, "int", &function_fab5ffa, 0, 0);
}

/*
	Name: function_7cd6e78c
	Namespace: namespace_3b2b9e06
	Checksum: 0x39DE75AA
	Offset: 0x298
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_7cd6e78c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_5bfd50fb8c3b5ffb"], self, "tag_origin");
	}
}

/*
	Name: function_fab5ffa
	Namespace: namespace_3b2b9e06
	Checksum: 0xC59D27DC
	Offset: 0x320
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_fab5ffa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_fx_tag = self zm_utility::function_467efa7b(1);
		util::playfxontag(localclientnum, level._effect[#"mk2x_guard"], self, str_fx_tag);
	}
}

