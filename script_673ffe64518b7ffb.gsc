// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_f2502da8;

/*
	Name: init_fx
	Namespace: namespace_f2502da8
	Checksum: 0x4F45D32E
	Offset: 0xA8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_46085f7d2bcd82c5"] = #"hash_404575a78667befd";
}

/*
	Name: init_clientfields
	Namespace: namespace_f2502da8
	Checksum: 0x9021423F
	Offset: 0xE8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_144c7c2895ed95c", 1, 1, "int", &function_a3874ae0, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_48f1f50c412d80c7", 1, 1, "counter", &function_1fe913e0, 0, 0);
}

/*
	Name: function_a3874ae0
	Namespace: namespace_f2502da8
	Checksum: 0x54E823F7
	Offset: 0x1A8
	Size: 0xAA
	Parameters: 7
	Flags: Linked
*/
function function_a3874ae0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.n_fx_id))
	{
		killfx(localclientnum, self.n_fx_id);
	}
	if(newval)
	{
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"hash_46085f7d2bcd82c5"], self, "tag_origin");
	}
}

/*
	Name: function_1fe913e0
	Namespace: namespace_f2502da8
	Checksum: 0x5C62DEDE
	Offset: 0x260
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_1fe913e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self playrumbleonentity(localclientnum, #"zm_escape_catwalk_door");
}

