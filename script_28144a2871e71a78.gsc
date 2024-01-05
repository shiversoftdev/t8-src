// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_7d8e6ec3;

/*
	Name: preload
	Namespace: namespace_7d8e6ec3
	Checksum: 0x6EF171A
	Offset: 0x88
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_7d8e6ec3
	Checksum: 0xDE59FE20
	Offset: 0xA8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_33c373888aa78dc2", 20000, 1, "counter", &function_e67464c1, 0, 0);
}

/*
	Name: function_e67464c1
	Namespace: namespace_7d8e6ec3
	Checksum: 0x881B2D84
	Offset: 0x110
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function function_e67464c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
	}
}

