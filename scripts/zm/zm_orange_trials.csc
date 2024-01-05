// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_orange_trials;

/*
	Name: preload
	Namespace: zm_orange_trials
	Checksum: 0xCDE04808
	Offset: 0xA0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"trials_lighthouse_beam"] = #"hash_7249b8c6a93aa3a3";
	clientfield::register("scriptmover", "" + #"hash_71906a124221219", 24000, 1, "int", &function_8532d13f, 0, 0);
	clientfield::register("scriptmover", "" + #"trials_lighthouse_beam", 24000, 1, "int", &function_804015d2, 0, 0);
}

/*
	Name: function_8532d13f
	Namespace: zm_orange_trials
	Checksum: 0xB7804C10
	Offset: 0x188
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_8532d13f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_573d289))
	{
		self stoploopsound(self.var_573d289);
		self.var_573d289 = undefined;
	}
	if(newval == 1)
	{
		self util::waittill_dobj(localclientnum);
		self.buff_fx = util::playfxontag(localclientnum, level._effect[#"hash_69e92b9c52f7fe12"], self, "tag_origin");
		self.var_573d289 = self playloopsound(#"hash_218e114cfa2b9a4");
	}
	else if(isdefined(self.buff_fx))
	{
		stopfx(localclientnum, self.buff_fx);
	}
}

/*
	Name: function_804015d2
	Namespace: zm_orange_trials
	Checksum: 0x4202CF6B
	Offset: 0x2C0
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_804015d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"trials_lighthouse_beam"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx);
	}
}

