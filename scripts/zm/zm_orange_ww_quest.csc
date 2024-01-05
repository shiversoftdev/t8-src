// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_orange_ww_quest;

/*
	Name: init
	Namespace: zm_orange_ww_quest
	Checksum: 0xDFB8588A
	Offset: 0xC8
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_64578452d3392d94"] = #"hash_26f4e63105355909";
	level._effect[#"hash_171687586f676b43"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_7567992d6a81fd89"] = #"hash_1a06427eff8dfe13";
	clientfield::register("scriptmover", "vril_device_glow", 24000, 1, "int", &_target_saving, 0, 0);
	namespace_617a54f4::function_d8383812(#"sc_ww_quest", 24000, "sc_ww_quest", 200, level._effect[#"hash_171687586f676b43"], level._effect[#"hash_7567992d6a81fd89"], undefined, undefined, 1);
}

/*
	Name: soul_release
	Namespace: zm_orange_ww_quest
	Checksum: 0x9B12259D
	Offset: 0x210
	Size: 0xBC
	Parameters: 7
	Flags: None
*/
function soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_171687586f676b43"], self, "tag_origin");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_7567992d6a81fd89"], self, "tag_origin");
	}
}

/*
	Name: _target_saving
	Namespace: zm_orange_ww_quest
	Checksum: 0x10F461DC
	Offset: 0x2D8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function _target_saving(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_64578452d3392d94"], self, "tag_origin");
	}
}

