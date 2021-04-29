// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5f90a0e71aee1dc4;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_825eac6b;

/*
	Name: preload
	Namespace: namespace_825eac6b
	Checksum: 0x78589827
	Offset: 0xB0
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_36b1de9b40bc33eb"] = #"hash_5a9fa59a025cd89f";
	level._effect[#"hash_6ad6ae6e60b08bd1"] = #"hash_d42f1006086e7c5";
	level._effect[#"hash_23968637a775eb2"] = #"hash_763113f4d90226b";
	level._effect[#"hash_b0298e980bd8da0"] = #"hash_4662965d7d3b5090";
	level._effect[#"hash_1e4555a911a24ab7"] = #"hash_4dcde9a03b654a7d";
	namespace_bd74bbd2::register(#"sc_mk2y", 20000, "sc_mk2y", level._effect[#"hash_36b1de9b40bc33eb"], level._effect[#"hash_6ad6ae6e60b08bd1"]);
	clientfield::register("scriptmover", "" + #"hash_70251001fe8c4abe", 20000, 1, "int", &function_7cd6e78c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_b0298e980bd8da0", 20000, 1, "int", &function_4b104fc5, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1e4555a911a24ab7", 20000, 1, "int", &function_37e7127e, 0, 0);
}

/*
	Name: function_7cd6e78c
	Namespace: namespace_825eac6b
	Checksum: 0x9FE11BB8
	Offset: 0x310
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_7cd6e78c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_23968637a775eb2"], self, "tag_origin");
	}
}

/*
	Name: function_4b104fc5
	Namespace: namespace_825eac6b
	Checksum: 0xBCF928A5
	Offset: 0x398
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_4b104fc5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.wisp_fx = util::playfxontag(localclientnum, level._effect[#"hash_b0298e980bd8da0"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.wisp_fx);
	}
}

/*
	Name: function_37e7127e
	Namespace: namespace_825eac6b
	Checksum: 0x68B7E236
	Offset: 0x450
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_37e7127e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_bb31eb27 = util::playfxontag(localclientnum, level._effect[#"hash_1e4555a911a24ab7"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.var_bb31eb27);
	}
}

