// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_1a68a5da;

/*
	Name: preload
	Namespace: namespace_1a68a5da
	Checksum: 0x80F724D1
	Offset: 0x88
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
}

/*
	Name: function_6c0434ba
	Namespace: namespace_1a68a5da
	Checksum: 0x37450BE
	Offset: 0x98
	Size: 0x82
	Parameters: 7
	Flags: None
*/
function function_6c0434ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_b8a353a9 = util::playfxontag(localclientnum, level._effect[#"hash_3a4cca038b97b169"], self, "tag_origin");
	}
}

