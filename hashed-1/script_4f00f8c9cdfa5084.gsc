// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_be178848;

/*
	Name: init
	Namespace: namespace_be178848
	Checksum: 0xBF37CFDC
	Offset: 0xD8
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_281c546a716f0d89"] = #"hash_29df8e00a5429cf0";
	level._effect[#"dynamite_explosion"] = #"hash_eb0cf9b1e7697fb";
	level._effect[#"hash_463a8d75b304b3d5"] = #"hash_e52765b1b6a1c81";
	clientfield::register("scriptmover", "" + #"dynamite_explosion_fx", 24000, 1, "counter", &play_dynamite_explosion_fx, 0, 0);
	clientfield::register("actor", "" + #"hash_6adfdd12c9656e1c", 24000, 1, "int", &function_ee32b1b8, 0, 0);
	clientfield::register("actor", "" + #"hash_147a734966a62e10", 24000, 1, "counter", &function_baf2de8d, 0, 0);
	forcestreamxmodel("p8_zm_ora_dynamite_barrier_destroyed");
}

/*
	Name: play_dynamite_explosion_fx
	Namespace: namespace_be178848
	Checksum: 0xFDFC0A2C
	Offset: 0x290
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function play_dynamite_explosion_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"dynamite_explosion"], self.origin, anglestoright(self.angles));
}

/*
	Name: function_ee32b1b8
	Namespace: namespace_be178848
	Checksum: 0x47B14BA1
	Offset: 0x328
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_ee32b1b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_31d7361d))
	{
		stopfx(localclientnum, self.var_31d7361d);
		self.var_31d7361d = undefined;
	}
	if(newval > 0)
	{
		self.var_31d7361d = util::playfxontag(localclientnum, level._effect[#"hash_281c546a716f0d89"], self, "j_spine4");
	}
}

/*
	Name: function_baf2de8d
	Namespace: namespace_be178848
	Checksum: 0xB1AF7DB
	Offset: 0x3F0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_baf2de8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_463a8d75b304b3d5"], self, "j_spine4");
}

