// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_orange_audiologs;

/*
	Name: preload
	Namespace: zm_orange_audiologs
	Checksum: 0xD37C4039
	Offset: 0xA0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"sam_orb"] = #"hash_445f04139d92c61b";
	clientfield::register("scriptmover", "" + #"hash_4a18e1ea1950215d", 24000, 1, "int", &function_db7a9c9d, 0, 0);
}

/*
	Name: function_db7a9c9d
	Namespace: zm_orange_audiologs
	Checksum: 0x69B5261F
	Offset: 0x130
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_db7a9c9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		self.var_af793e2d = util::playfxontag(localclientnum, level._effect[#"sam_orb"], self, "tag_origin");
	}
	else if(isdefined(self.var_af793e2d))
	{
		stopfx(localclientnum, self.var_af793e2d);
	}
}

