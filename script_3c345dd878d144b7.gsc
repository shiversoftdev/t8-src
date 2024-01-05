// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_b99141ed;

/*
	Name: init_clientfields
	Namespace: namespace_b99141ed
	Checksum: 0x7AB361F6
	Offset: 0xB8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_275c4e6783b917f8", 1, 1, "int", &function_9997d53a, 0, 0);
}

/*
	Name: function_9997d53a
	Namespace: namespace_b99141ed
	Checksum: 0xA9BF4E2C
	Offset: 0x120
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_9997d53a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self playrumblelooponentity(localclientnum, "zm_escape_fast_travel");
	}
	else
	{
		self stoprumble(localclientnum, "zm_escape_fast_travel");
	}
}

