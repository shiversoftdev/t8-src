// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_1063645;

/*
	Name: init_clientfields
	Namespace: namespace_1063645
	Checksum: 0x652FA2FE
	Offset: 0xB0
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_3e57db9b106dff0a", 1, 1, "int", &function_10675d52, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4ccf2ce25e0dc836", 1, 1, "int", &function_c6b07c39, 0, 0);
	level._effect[#"hash_62343c2144d3f8d1"] = #"hash_e567a706dafea31";
}

/*
	Name: function_10675d52
	Namespace: namespace_1063645
	Checksum: 0x94E8020D
	Offset: 0x1A0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_10675d52(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"powerup_on_solo"], self, "tag_origin");
	}
	else if(isdefined(self.n_fx_id))
	{
		stopfx(localclientnum, self.n_fx_id);
	}
}

/*
	Name: function_c6b07c39
	Namespace: namespace_1063645
	Checksum: 0xF0F19F41
	Offset: 0x260
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_c6b07c39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_3c43a180 = util::playfxontag(localclientnum, level._effect[#"hash_62343c2144d3f8d1"], self, "tag_animate");
		forcestreamxmodel(#"p8_zm_esc_nixie_tubes");
		forcestreamxmodel(#"p8_zm_esc_nixie_tubes_on");
	}
	else
	{
		if(isdefined(self.var_3c43a180))
		{
			stopfx(localclientnum, self.var_3c43a180);
		}
		stopforcestreamingxmodel(#"p8_zm_esc_nixie_tubes");
		stopforcestreamingxmodel(#"p8_zm_esc_nixie_tubes_on");
	}
}

