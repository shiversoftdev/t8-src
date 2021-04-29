// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_a34af286;

/*
	Name: init
	Namespace: namespace_a34af286
	Checksum: 0xF8C0623C
	Offset: 0xC0
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "" + #"hash_54cceab249a41cde", 8000, 1, "int", &function_5869f09a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_336942eaf5fcd809", 8000, 1, "int", &function_c51132ba, 0, 0);
	/#
		clientfield::register("", "" + #"hash_3efe70d8ad68a07d", 8000, 4, "", &function_230ff6dc, 0, 0);
		clientfield::register("", "" + #"hash_4d30672cd0a2ef31", 8000, 1, "", &function_bb6fcc6a, 0, 0);
	#/
}

/*
	Name: function_5869f09a
	Namespace: namespace_a34af286
	Checksum: 0xA25F171D
	Offset: 0x230
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_5869f09a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_5d1596c4))
	{
		killfx(localclientnum, self.var_5d1596c4);
		self.var_5d1596c4 = undefined;
		playsound(localclientnum, #"hash_3c3c2809ce13808", self.origin);
		self.var_5d1596c4 = undefined;
	}
	if(newval)
	{
		self.var_5d1596c4 = playfx(localclientnum, level._effect[#"hash_2d18ba139fbb02f"], self.origin + vectorscale((0, 0, 1), 6), anglestoforward(self.angles), anglestoup(self.angles));
		playsound(localclientnum, #"hash_6ab53d808ef366d5", self.origin);
	}
}

/*
	Name: function_c51132ba
	Namespace: namespace_a34af286
	Checksum: 0xEB6D3C7E
	Offset: 0x390
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_c51132ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_bf9d3071(#"hash_429426f01ad84c8b");
}

/*
	Name: function_bb6fcc6a
	Namespace: namespace_a34af286
	Checksum: 0xF8C9DE44
	Offset: 0x3F8
	Size: 0xBA
	Parameters: 7
	Flags: None
*/
function function_bb6fcc6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		if(isdefined(self.var_a0a8631e))
		{
			stopfx(localclientnum, self.var_a0a8631e);
			self.var_a0a8631e = undefined;
		}
		if(newval)
		{
			self.var_a0a8631e = util::playfxontag(localclientnum, level._effect[#"hash_51c7bc3539ed5540"], self, "");
		}
	#/
}

/*
	Name: function_230ff6dc
	Namespace: namespace_a34af286
	Checksum: 0x89ACB245
	Offset: 0x4C0
	Size: 0x98
	Parameters: 7
	Flags: None
*/
function function_230ff6dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		self endon(#"death");
		while(true)
		{
			print3d(self.origin, newval, (1, 1, 0), 1, 0.4, 15);
			wait(0.2);
		}
	#/
}

