// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_67594c4a;

/*
	Name: init
	Namespace: namespace_67594c4a
	Checksum: 0x80F724D1
	Offset: 0x90
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: function_dfa13c3a
	Namespace: namespace_67594c4a
	Checksum: 0xE326E6C4
	Offset: 0xA0
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function function_dfa13c3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_552871668c8801c2"], self, "tag_origin");
}

/*
	Name: function_ee32b1b8
	Namespace: namespace_67594c4a
	Checksum: 0x9B0A4335
	Offset: 0x120
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function function_ee32b1b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_281c546a716f0d89"], self, "j_spine4");
}

