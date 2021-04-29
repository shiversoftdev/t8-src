// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_29f39efb;

/*
	Name: init_clientfields
	Namespace: namespace_29f39efb
	Checksum: 0x1DF0C7E6
	Offset: 0xB0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("vehicle", "fx8_insanity_wisp", 18000, 1, "int", &function_4b104fc5, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_29f39efb
	Checksum: 0xBCDAAD3D
	Offset: 0x108
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"fx8_insanity_wisp"] = #"hash_75046ca8114af653";
}

/*
	Name: function_4b104fc5
	Namespace: namespace_29f39efb
	Checksum: 0xF2E2EF24
	Offset: 0x148
	Size: 0x15E
	Parameters: 7
	Flags: Linked
*/
function function_4b104fc5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"fx8_insanity_wisp"], self, "tag_origin");
		if(!isdefined(self.sfx))
		{
			self playsound(0, #"hash_7867b5508ce25848");
			self.sfx = self playloopsound(#"hash_2c5ad3d4cdc507c");
		}
	}
	else
	{
		stopfx(localclientnum, self.fx);
		if(isdefined(self.sfx))
		{
			self playsound(0, #"hash_6e263590089ef88e");
			self stoploopsound(self.sfx);
			self.sfx = undefined;
		}
	}
}

