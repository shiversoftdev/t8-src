// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\util_shared.csc;

#namespace namespace_a01a2431;

/*
	Name: preload
	Namespace: namespace_a01a2431
	Checksum: 0x5A3CB8F7
	Offset: 0xC8
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_445a09d57b925de2"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_22616c5de5b8bbf4"] = #"hash_1a06427eff8dfe13";
	namespace_617a54f4::function_d8383812(#"sc_ww_screen1", 20000, "sc_ww_screen1", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen2", 20000, "sc_ww_screen2", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen3", 20000, "sc_ww_screen3", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen4", 20000, "sc_ww_screen4", 400, level._effect[#"hash_445a09d57b925de2"], level._effect[#"hash_22616c5de5b8bbf4"], undefined, undefined, 1);
}

/*
	Name: soul_release
	Namespace: namespace_a01a2431
	Checksum: 0xD04F460C
	Offset: 0x2D8
	Size: 0xBC
	Parameters: 7
	Flags: None
*/
function soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_445a09d57b925de2"], self, "tag_origin");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_22616c5de5b8bbf4"], self, "tag_origin");
	}
}

