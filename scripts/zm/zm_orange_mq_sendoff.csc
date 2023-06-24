// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_orange_mq_sendoff;

/*
	Name: preload
	Namespace: zm_orange_mq_sendoff
	Checksum: 0xFCEB41B0
	Offset: 0x98
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_490bb70162069301"] = #"hash_406e48055b40a506";
	clientfield::register("vehicle", "" + #"wisp_fx", 24000, 1, "int", &function_e5ecfa90, 0, 0);
}

/*
	Name: function_e5ecfa90
	Namespace: zm_orange_mq_sendoff
	Checksum: 0xC90F837B
	Offset: 0x128
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_e5ecfa90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_490bb70162069301"], self, "tag_origin");
}

