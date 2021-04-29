// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_48d025ef;

/*
	Name: function_89f2df9
	Namespace: namespace_48d025ef
	Checksum: 0x9B50718B
	Offset: 0x348
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_77bec2ab64ee4676", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_48d025ef
	Checksum: 0x59014363
	Offset: 0x390
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	init_fx();
}

/*
	Name: init_clientfields
	Namespace: namespace_48d025ef
	Checksum: 0xD0DCF7
	Offset: 0x3C0
	Size: 0x6C4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "engine_room_chillout_decals", 1, 1, "int", &function_1af2e865, 0, 0);
	clientfield::register("world", "state_rooms_chillout_decals", 1, 1, "int", &function_27b6baf4, 0, 0);
	clientfield::register("world", "promenade_chillout_decals", 1, 1, "int", &function_8df08eef, 0, 0);
	clientfield::register("world", "poop_deck_chillout_decals", 1, 1, "int", &quad_stage_roof_break, 0, 0);
	clientfield::register("scriptmover", "bs_bdy_base_cf", 1, 3, "int", &function_cfa8ca16, 0, 0);
	clientfield::register("scriptmover", "bs_bdy_fx_cf", 1, 2, "int", &function_2944b5ce, 0, 0);
	clientfield::register("scriptmover", "bs_bdy_dmg_fx_cf", 1, 3, "int", &function_9732f718, 0, 0);
	clientfield::register("scriptmover", "bs_dth_fx_cf", 1, 1, "counter", &function_f0174fdc, 0, 0);
	clientfield::register("scriptmover", "bs_bdy_str_cf", 1, 2, "int", &function_52672d29, 0, 0);
	clientfield::register("scriptmover", "bs_spn_fx_cf", 1, 1, "int", &function_3feb7449, 0, 0);
	clientfield::register("scriptmover", "bs_att_mst_tell_cf", 1, 1, "int", &function_f0b8ee2e, 0, 0);
	clientfield::register("scriptmover", "bs_att_mst_cf", 1, 1, "int", &function_64884362, 0, 0);
	clientfield::register("scriptmover", "bs_att_bm_targ_ini_cf", 1, 1, "int", &function_2c4b4a11, 0, 0);
	clientfield::register("scriptmover", "bs_att_bm_tell_cf", 1, 2, "int", &function_c6932c3b, 0, 0);
	clientfield::register("scriptmover", "bs_att_bm_tell_fx_cf", 1, 1, "int", &function_f5116ee2, 0, 0);
	clientfield::register("scriptmover", "bs_att_bm_cf", 1, 1, "int", &function_bf5b47d7, 0, 0);
	clientfield::register("allplayers", "bs_att_bm_targ_hit_cf", 1, 1, "int", &function_dac3a61d, 0, 0);
	clientfield::register("toplayer", "bs_att_bm_targ_frz_fx_cf", 1, 1, "int", &function_e1af20d7, 0, 0);
	clientfield::register("scriptmover", "bs_att_blst_tll", 1, 1, "int", &function_eb5c7406, 0, 0);
	clientfield::register("scriptmover", "bs_att_blst", 1, 1, "int", &function_50703d72, 0, 0);
	clientfield::register("world", "in_engine_room", 1, 1, "int", &function_218857fd, 0, 0);
	clientfield::register("world", "bs_gr_fog_fx_cf", 1, 1, "int", &function_b415e676, 0, 0);
	clientfield::register("allplayers", "bs_player_ice_br_cf", 1, 1, "int", &function_e3c6c272, 0, 0);
	clientfield::register("allplayers", "bs_player_snow_cf", 1, 3, "int", &function_7716b881, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_48d025ef
	Checksum: 0x93DED1B
	Offset: 0xA90
	Size: 0x722
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_3a7e3c711927a7c3"] = #"hash_79ffa4a673f5793b";
	level._effect[#"hash_4ae2fe21468d6415"] = #"hash_1c763e2ab2eae2d";
	level._effect[#"hash_3a7e3d711927a976"] = #"hash_79ffa5a673f57aee";
	level._effect[#"hash_3a7e3e711927ab29"] = #"hash_79ffa6a673f57ca1";
	level._effect[#"hash_18e0765b35d687e2"] = #"hash_4958a07a69145faa";
	level._effect[#"hash_18e0755b35d6862f"] = #"hash_49589f7a69145df7";
	level._effect[#"hash_18e0745b35d6847c"] = #"hash_49589e7a69145c44";
	level._effect[#"hash_22e302a3a629b9c5"] = #"hash_547e19d7efb5111d";
	level._effect[#"hash_22e2ffa3a629b4ac"] = #"hash_547e16d7efb50c04";
	level._effect[#"hash_5da2f8ba463838a7"] = #"hash_33d1bbba600a3baf";
	level._effect[#"hash_578d16a371861bf8"] = #"hash_51099a252cae240";
	level._effect[#"hash_5c6beca89bab7a09"] = #"hash_5bb2efa9ee678bb1";
	level._effect[#"hash_5d9fc9ba4635b2f3"] = #"hash_33ceccba600822bb";
	level._effect[#"hash_579039a371888d48"] = #"hash_513bca252cd5390";
	level._effect[#"hash_5c68c9a89ba908b9"] = #"hash_5bb00ca9ee658721";
	level._effect[#"hash_2605326ae3fedb78"] = #"hash_366330d81a1a6280";
	level._effect[#"hash_762024bd90ae81"] = #"hash_d289f9bdde6a4d9";
	level._effect[#"hash_43b082a97f3b9f23"] = #"hash_22f75cff6fc8279b";
	level._effect[#"hash_761d24bd90a968"] = #"hash_d289c9bdde69fc0";
	level._effect[#"hash_761e24bd90ab1b"] = #"hash_d289d9bdde6a173";
	level._effect[#"hash_4d839450cbef5d84"] = #"hash_2995f7f9d859901c";
	level._effect[#"hash_79943a1b52eab058"] = #"hash_4fdb4d96df507bb0";
	level._effect[#"hash_4d839750cbef629d"] = #"hash_2995faf9d8599535";
	level._effect[#"hash_4d839650cbef60ea"] = #"hash_2995f9f9d8599382";
	level._effect[#"hash_2568e622a63ee946"] = #"hash_76f4fd1c816279e";
	level._effect[#"hash_5c21a90a3a13ab3a"] = #"hash_14a03ad75e4665f2";
	level._effect[#"hash_2568e522a63ee793"] = #"hash_76f4ed1c81625eb";
	level._effect[#"hash_2568e422a63ee5e0"] = #"hash_76f4dd1c8162438";
	level._effect[#"hash_d64a32797383a44"] = #"hash_90d6010d0fb8a5c";
	level._effect[#"hash_1ac926b170f08ed4"] = #"hash_5518be03ef1238bc";
	level._effect[#"hash_14c7ae107e96344f"] = #"hash_35345b470c26af97";
	level._effect[#"hash_7f40415d2fd7eca7"] = #"hash_140d0b129306d6bf";
	level._effect[#"hash_139a09a4b1249370"] = #"hash_7881fc0381feec68";
	level._effect[#"hash_76da38284b0c73ed"] = #"hash_153286962fe0c0c5";
	level._effect[#"hash_76e124284b12709f"] = #"hash_153992962fe6f3d7";
	level._effect[#"hash_6788a08fe46cb4c4"] = #"hash_6bb32223711e216c";
	level._effect[#"hash_2b51d1fecfaa7ae6"] = #"hash_682ef6e33412958e";
	level._effect[#"hash_3a6842a4656de818"] = #"hash_2b2be81e66f5e3ea";
}

/*
	Name: function_1af2e865
	Namespace: namespace_48d025ef
	Checksum: 0x20F96F5A
	Offset: 0x11C0
	Size: 0x168
	Parameters: 7
	Flags: Linked
*/
function function_1af2e865(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_fc6303e5))
	{
		level.var_fc6303e5 = findvolumedecalindexarray("engine_room_chillout_decals");
	}
	if(newval)
	{
		foreach(n_index in level.var_fc6303e5)
		{
			hidevolumedecal(n_index);
		}
	}
	else
	{
		foreach(n_index in level.var_fc6303e5)
		{
			unhidevolumedecal(n_index);
		}
	}
}

/*
	Name: function_27b6baf4
	Namespace: namespace_48d025ef
	Checksum: 0x8CA0107C
	Offset: 0x1330
	Size: 0x168
	Parameters: 7
	Flags: Linked
*/
function function_27b6baf4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_42889feb))
	{
		level.var_42889feb = findvolumedecalindexarray("state_rooms_chillout_decals");
	}
	if(newval)
	{
		foreach(n_index in level.var_42889feb)
		{
			hidevolumedecal(n_index);
		}
	}
	else
	{
		foreach(n_index in level.var_42889feb)
		{
			unhidevolumedecal(n_index);
		}
	}
}

/*
	Name: function_8df08eef
	Namespace: namespace_48d025ef
	Checksum: 0xD948E8F
	Offset: 0x14A0
	Size: 0x168
	Parameters: 7
	Flags: Linked
*/
function function_8df08eef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_bc031054))
	{
		level.var_bc031054 = findvolumedecalindexarray("promenade_chillout_decals");
	}
	if(newval)
	{
		foreach(n_index in level.var_bc031054)
		{
			hidevolumedecal(n_index);
		}
	}
	else
	{
		foreach(n_index in level.var_bc031054)
		{
			unhidevolumedecal(n_index);
		}
	}
}

/*
	Name: quad_stage_roof_break
	Namespace: namespace_48d025ef
	Checksum: 0x1BC1BEE5
	Offset: 0x1610
	Size: 0x168
	Parameters: 7
	Flags: Linked
*/
function quad_stage_roof_break(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_45a67e82))
	{
		level.var_45a67e82 = findvolumedecalindexarray("poop_deck_chillout_decals");
	}
	if(newval)
	{
		foreach(n_index in level.var_45a67e82)
		{
			hidevolumedecal(n_index);
		}
	}
	else
	{
		foreach(n_index in level.var_45a67e82)
		{
			unhidevolumedecal(n_index);
		}
	}
}

/*
	Name: function_cfa8ca16
	Namespace: namespace_48d025ef
	Checksum: 0xE2A0E33F
	Offset: 0x1780
	Size: 0xCA
	Parameters: 7
	Flags: Linked
*/
function function_cfa8ca16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			self.mdl_base = #"hash_678aaf8e37498e9a";
			break;
		}
		case 2:
		{
			self.mdl_base = #"hash_32a51dafb1c7344f";
			break;
		}
		case 3:
		{
			self.mdl_base = #"hash_597bdc83a7c9e8c";
			break;
		}
	}
}

/*
	Name: function_2944b5ce
	Namespace: namespace_48d025ef
	Checksum: 0xE44A1696
	Offset: 0x1858
	Size: 0x3BC
	Parameters: 7
	Flags: Linked
*/
function function_2944b5ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_7a88b8b5))
	{
		deletefx(localclientnum, self.var_7a88b8b5);
		self.var_7a88b8b5 = undefined;
	}
	if(isdefined(self.var_9c3d3ec2))
	{
		deletefx(localclientnum, self.var_9c3d3ec2);
		self.var_9c3d3ec2 = undefined;
	}
	self function_5d482e78(#"hash_131484bd233d42ed");
	self function_5d482e78(#"hash_5eea61b7a4fc591f");
	if(newval != 2)
	{
		if(isdefined(level.var_6af9e868) && level.var_6af9e868)
		{
			self.var_9c3d3ec2 = util::playfxontag(localclientnum, level._effect[#"hash_4ae2fe21468d6415"], self, "tag_origin");
		}
		else if(self.mdl_base === #"hash_32a51dafb1c7344f")
		{
			self.var_9c3d3ec2 = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3d711927a976"], self, "tag_origin");
		}
		else if(self.mdl_base === #"hash_597bdc83a7c9e8c")
		{
			self.var_9c3d3ec2 = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3e711927ab29"], self, "tag_origin");
		}
		else
		{
			self.var_9c3d3ec2 = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3c711927a7c3"], self, "tag_origin");
		}
		if(newval == 0)
		{
			self.var_ad1388ef = 1;
			self function_bf9d3071(#"hash_131484bd233d42ed");
			if(self.mdl_base == #"hash_32a51dafb1c7344f")
			{
				self.var_7a88b8b5 = util::playfxontag(localclientnum, level._effect[#"hash_18e0755b35d6862f"], self, "tag_origin");
			}
			else if(self.mdl_base == #"hash_597bdc83a7c9e8c")
			{
				self.var_7a88b8b5 = util::playfxontag(localclientnum, level._effect[#"hash_18e0745b35d6847c"], self, "tag_origin");
			}
			else
			{
				self.var_7a88b8b5 = util::playfxontag(localclientnum, level._effect[#"hash_18e0765b35d687e2"], self, "tag_origin");
			}
		}
		else
		{
			self.var_ad1388ef = 0;
			self function_bf9d3071(#"hash_5eea61b7a4fc591f");
		}
	}
}

/*
	Name: function_9732f718
	Namespace: namespace_48d025ef
	Checksum: 0xA8638A3E
	Offset: 0x1C20
	Size: 0x3FC
	Parameters: 7
	Flags: Linked
*/
function function_9732f718(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_aafc7e9d))
	{
		deletefx(localclientnum, self.var_aafc7e9d);
		self.var_aafc7e9d = undefined;
	}
	if(newval == 1)
	{
		if(self.mdl_base == #"hash_32a51dafb1c7344f")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_5da2f8ba463838a7"], self, "tag_origin");
		}
		else if(self.mdl_base == #"hash_597bdc83a7c9e8c")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_5d9fc9ba4635b2f3"], self, "tag_origin");
		}
		else
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_22e302a3a629b9c5"], self, "tag_origin");
		}
	}
	else if(newval == 2)
	{
		if(self.mdl_base == #"hash_32a51dafb1c7344f")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_5c6beca89bab7a09"], self, "tag_origin");
		}
		else if(self.mdl_base == #"hash_597bdc83a7c9e8c")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_579039a371888d48"], self, "tag_origin");
		}
		else
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_22e2ffa3a629b4ac"], self, "tag_origin");
		}
	}
	else if(newval == 3)
	{
		if(self.mdl_base == #"hash_32a51dafb1c7344f")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_5c6beca89bab7a09"], self, "tag_origin");
		}
		else if(self.mdl_base == #"hash_597bdc83a7c9e8c")
		{
			self.var_aafc7e9d = util::playfxontag(localclientnum, level._effect[#"hash_5c68c9a89ba908b9"], self, "tag_origin");
		}
	}
	if(isdefined(self.var_ad1388ef) && self.var_ad1388ef)
	{
		self function_5d482e78(#"hash_5eea61b7a4fc591f");
		self function_bf9d3071(#"hash_131484bd233d42ed");
	}
	else
	{
		self function_5d482e78(#"hash_131484bd233d42ed");
		self function_bf9d3071(#"hash_5eea61b7a4fc591f");
	}
}

/*
	Name: function_3feb7449
	Namespace: namespace_48d025ef
	Checksum: 0xADEC9B6C
	Offset: 0x2028
	Size: 0x43A
	Parameters: 7
	Flags: Linked
*/
function function_3feb7449(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.var_8107b86f))
		{
			stopfx(localclientnum, self.var_8107b86f);
			self.var_8107b86f = undefined;
		}
		if(isdefined(level.var_6af9e868) && level.var_6af9e868)
		{
			self.var_8107b86f = playfx(localclientnum, level._effect[#"hash_43b082a97f3b9f23"], self.origin, anglestoforward(self.angles));
		}
		else if(self.mdl_base == #"hash_32a51dafb1c7344f")
		{
			self.var_8107b86f = playfx(localclientnum, level._effect[#"hash_761d24bd90a968"], self.origin, anglestoforward(self.angles));
		}
		else if(self.mdl_base == #"hash_597bdc83a7c9e8c")
		{
			self.var_8107b86f = playfx(localclientnum, level._effect[#"hash_761e24bd90ab1b"], self.origin, anglestoforward(self.angles));
		}
		else
		{
			self.var_8107b86f = playfx(localclientnum, level._effect[#"hash_762024bd90ae81"], self.origin, anglestoforward(self.angles));
		}
	}
	else if(isdefined(self.var_797217c7))
	{
		stopfx(localclientnum, self.var_797217c7);
		self.var_797217c7 = undefined;
	}
	if(isdefined(level.var_6af9e868) && level.var_6af9e868)
	{
		self.var_797217c7 = playfx(localclientnum, level._effect[#"hash_79943a1b52eab058"], self.origin, anglestoforward(self.angles));
	}
	else if(self.mdl_base === #"hash_32a51dafb1c7344f")
	{
		self.var_797217c7 = playfx(localclientnum, level._effect[#"hash_4d839750cbef629d"], self.origin, anglestoforward(self.angles));
	}
	else if(self.mdl_base === #"hash_597bdc83a7c9e8c")
	{
		self.var_797217c7 = playfx(localclientnum, level._effect[#"hash_4d839650cbef60ea"], self.origin, anglestoforward(self.angles));
	}
	else
	{
		self.var_797217c7 = playfx(localclientnum, level._effect[#"hash_4d839450cbef5d84"], self.origin, anglestoforward(self.angles));
	}
}

/*
	Name: function_f0174fdc
	Namespace: namespace_48d025ef
	Checksum: 0xA622943B
	Offset: 0x2470
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_f0174fdc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"hash_2605326ae3fedb78"], self.origin);
}

/*
	Name: function_52672d29
	Namespace: namespace_48d025ef
	Checksum: 0xF7EA37E9
	Offset: 0x24F0
	Size: 0x4DC
	Parameters: 7
	Flags: Linked
*/
function function_52672d29(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(self.model == #"hash_678aaf8e37498e9a")
		{
			forcestreamxmodel(#"hash_472c07eec6e91873");
		}
		else if(self.model == #"hash_472c07eec6e91873")
		{
			forcestreamxmodel(#"hash_6171eeb75fd1389a");
		}
		else if(self.model == #"hash_32a51dafb1c7344f")
		{
			forcestreamxmodel(#"hash_46aa8073bbd2e3d2");
		}
		else if(self.model == #"hash_46aa8073bbd2e3d2")
		{
			forcestreamxmodel(#"hash_5af2bec2a3aa53af");
		}
		else if(self.model == #"hash_597bdc83a7c9e8c")
		{
			forcestreamxmodel(#"hash_4458b3c865174731");
		}
		else if(self.model == #"hash_4458b3c865174731")
		{
			forcestreamxmodel(#"hash_5d304a67420d3dcc");
		}
	}
	else if(newval == 2)
	{
		if(self.model == #"hash_678aaf8e37498e9a")
		{
			forcestreamxmodel(#"hash_678aaf8e37498e9a");
		}
		else if(self.model == #"hash_32a51dafb1c7344f")
		{
			forcestreamxmodel(#"hash_32a51dafb1c7344f");
		}
		else if(self.model == #"hash_597bdc83a7c9e8c")
		{
			forcestreamxmodel(#"hash_597bdc83a7c9e8c");
		}
	}
	else if(self.model == #"hash_678aaf8e37498e9a")
	{
		stopforcestreamingxmodel(#"hash_678aaf8e37498e9a");
	}
	else if(self.model == #"hash_32a51dafb1c7344f")
	{
		stopforcestreamingxmodel(#"hash_32a51dafb1c7344f");
	}
	else if(self.model == #"hash_597bdc83a7c9e8c")
	{
		stopforcestreamingxmodel(#"hash_597bdc83a7c9e8c");
	}
	else if(self.model == #"hash_472c07eec6e91873")
	{
		stopforcestreamingxmodel(#"hash_472c07eec6e91873");
	}
	else if(self.model == #"hash_6171eeb75fd1389a")
	{
		stopforcestreamingxmodel(#"hash_6171eeb75fd1389a");
	}
	else if(self.model == #"hash_46aa8073bbd2e3d2")
	{
		stopforcestreamingxmodel(#"hash_46aa8073bbd2e3d2");
	}
	else if(self.model == #"hash_5af2bec2a3aa53af")
	{
		stopforcestreamingxmodel(#"hash_5af2bec2a3aa53af");
	}
	else if(self.model == #"hash_4458b3c865174731")
	{
		stopforcestreamingxmodel(#"hash_4458b3c865174731");
	}
	else if(self.model == #"hash_5d304a67420d3dcc")
	{
		stopforcestreamingxmodel(#"hash_5d304a67420d3dcc");
	}
}

/*
	Name: function_f0b8ee2e
	Namespace: namespace_48d025ef
	Checksum: 0x2667037A
	Offset: 0x29D8
	Size: 0x1DE
	Parameters: 7
	Flags: Linked
*/
function function_f0b8ee2e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(level.var_6af9e868) && level.var_6af9e868)
		{
			self.var_526f3513 = util::playfxontag(localclientnum, level._effect[#"hash_5c21a90a3a13ab3a"], self, "tag_origin");
		}
		else if(self.mdl_base === #"hash_32a51dafb1c7344f")
		{
			self.var_526f3513 = util::playfxontag(localclientnum, level._effect[#"hash_2568e522a63ee793"], self, "tag_origin");
		}
		else if(self.mdl_base === #"hash_597bdc83a7c9e8c")
		{
			self.var_526f3513 = util::playfxontag(localclientnum, level._effect[#"hash_2568e422a63ee5e0"], self, "tag_origin");
		}
		else
		{
			self.var_526f3513 = util::playfxontag(localclientnum, level._effect[#"hash_2568e622a63ee946"], self, "tag_origin");
		}
	}
	else if(isdefined(self.var_526f3513))
	{
		stopfx(localclientnum, self.var_526f3513);
		self.var_526f3513 = undefined;
	}
}

/*
	Name: function_64884362
	Namespace: namespace_48d025ef
	Checksum: 0xE5AF00
	Offset: 0x2BC0
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function function_64884362(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_cb2128e9 = util::playfxontag(localclientnum, level._effect[#"hash_d64a32797383a44"], self, "tag_origin");
		self.var_9b096724 = self playloopsound(#"hash_791cd998c9d4782b");
	}
	else if(isdefined(self.var_9b096724))
	{
		self stoploopsound(self.var_9b096724);
		self.var_9b096724 = undefined;
	}
	if(isdefined(self.var_cb2128e9))
	{
		stopfx(localclientnum, self.var_cb2128e9);
		self.var_cb2128e9 = undefined;
	}
}

/*
	Name: function_2c4b4a11
	Namespace: namespace_48d025ef
	Checksum: 0x81951508
	Offset: 0x2CE8
	Size: 0x5A
	Parameters: 7
	Flags: Linked
*/
function function_2c4b4a11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_90bda347))
	{
		level.var_90bda347 = self;
	}
}

/*
	Name: function_bf5b47d7
	Namespace: namespace_48d025ef
	Checksum: 0x17E6E3DF
	Offset: 0x2D50
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_bf5b47d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_8c5b87a7(localclientnum);
	if(newval)
	{
		self thread function_e8071e64(localclientnum);
	}
}

/*
	Name: function_f5116ee2
	Namespace: namespace_48d025ef
	Checksum: 0x5CB16155
	Offset: 0x2DD0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_f5116ee2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_18da5747 = util::playfxontag(localclientnum, level._effect[#"hash_1ac926b170f08ed4"], self, "tag_fx_beam");
	}
	else if(isdefined(self.var_18da5747))
	{
		stopfx(localclientnum, self.var_18da5747);
		self.var_18da5747 = undefined;
	}
}

/*
	Name: function_8c5b87a7
	Namespace: namespace_48d025ef
	Checksum: 0xDC587D2F
	Offset: 0x2E98
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function function_8c5b87a7(localclientnum)
{
	self notify(#"hash_2bb8be6b846aed93");
	if(isdefined(self.var_ca2681ca))
	{
		level beam::kill(self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a");
		level beam::kill(self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_a");
		level beam::kill(self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_b");
		var_62b51ea6 = spawn(localclientnum, self.origin, "script_origin");
		var_62b51ea6 playsound(localclientnum, #"hash_15ca81cba1081bc2");
		var_62b51ea6 thread function_e8a1c9e1();
		self.var_ca2681ca delete();
		self.var_ca2681ca = undefined;
	}
}

/*
	Name: function_e8a1c9e1
	Namespace: namespace_48d025ef
	Checksum: 0x29215A70
	Offset: 0x3020
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_e8a1c9e1()
{
	wait(3);
	self delete();
}

/*
	Name: function_c6932c3b
	Namespace: namespace_48d025ef
	Checksum: 0x6A04AD2E
	Offset: 0x3048
	Size: 0x88
	Parameters: 7
	Flags: Linked
*/
function function_c6932c3b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		level notify(#"hash_557a122dcb347759");
	}
	else if(newval == 2)
	{
		level notify(#"hash_47a81f08f1d6531a");
	}
}

/*
	Name: function_e8071e64
	Namespace: namespace_48d025ef
	Checksum: 0x12365B35
	Offset: 0x30D8
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_e8071e64(localclientnum)
{
	self notify(#"hash_2bb8be6b846aed93");
	self endon(#"hash_2bb8be6b846aed93", #"death");
	/#
		assert(isdefined(level.var_90bda347));
	#/
	if(!isdefined(level.var_90bda347))
	{
		return;
	}
	v_origin = self gettagorigin("tag_fx_beam");
	if(!isdefined(self.var_ca2681ca))
	{
		self.var_ca2681ca = util::spawn_model(localclientnum, "tag_origin", v_origin);
		if(!isdefined(self.var_ca2681ca))
		{
			return;
		}
	}
	self.var_ca2681ca.origin = v_origin;
	self thread function_a96b063f();
	self thread function_da0759d0();
	level beam::function_cfb2f62a(localclientnum, self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_a");
	level waittill(#"hash_557a122dcb347759");
	if(isdefined(self.var_ca2681ca) && isdefined(level.var_90bda347))
	{
		level beam::kill(self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_a");
		level beam::function_cfb2f62a(localclientnum, self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_b");
	}
	level waittill(#"hash_47a81f08f1d6531a");
	if(isdefined(self.var_ca2681ca) && isdefined(level.var_90bda347))
	{
		level beam::kill(self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a_t_b");
		level beam::function_cfb2f62a(localclientnum, self.var_ca2681ca, "tag_origin", level.var_90bda347, "tag_origin", "beam8_zm_be_a");
	}
	self playsound(localclientnum, #"hash_65dbdd02d1dccf42");
	self thread function_ff52ba5a(localclientnum);
}

/*
	Name: function_a96b063f
	Namespace: namespace_48d025ef
	Checksum: 0x9A8EDED
	Offset: 0x33E8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_a96b063f()
{
	level endon(#"hash_47a81f08f1d6531a", #"intermission");
	while(isdefined(self) && isdefined(self.var_ca2681ca))
	{
		self.var_ca2681ca.origin = self gettagorigin("tag_fx_beam");
		waitframe(1);
	}
}

/*
	Name: function_da0759d0
	Namespace: namespace_48d025ef
	Checksum: 0x169E17CC
	Offset: 0x3468
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_da0759d0()
{
	self endon(#"hash_2bb8be6b846aed93");
	while(isdefined(self.var_ca2681ca) && isdefined(level.var_90bda347))
	{
		self.var_ca2681ca function_25d9319(level.var_90bda347);
		level.var_90bda347 function_25d9319(self.var_ca2681ca);
		waitframe(1);
	}
}

/*
	Name: function_25d9319
	Namespace: namespace_48d025ef
	Checksum: 0x7DDA8F21
	Offset: 0x34F8
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_25d9319(var_49a313db)
{
	if(!isdefined(self) || !isdefined(var_49a313db))
	{
		return;
	}
	v_target_position = var_49a313db.origin;
	var_23ee4083 = vectortoangles(v_target_position - self.origin);
	self.angles = var_23ee4083;
}

/*
	Name: function_ff52ba5a
	Namespace: namespace_48d025ef
	Checksum: 0xFFC7FC78
	Offset: 0x3578
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_ff52ba5a(localclientnum)
{
	self.var_da4fd8df = self.var_ca2681ca gettagorigin("tag_origin");
	self.var_608d2b77 = level.var_90bda347 gettagorigin("tag_origin");
	if(!(isdefined(self.var_4f7e3c84) && self.var_4f7e3c84))
	{
		self.var_4f7e3c84 = 1;
		soundlineemitter(#"hash_3d5a33369bbe2308", self.var_da4fd8df, self.var_608d2b77);
		self thread function_1c341163(localclientnum);
		self thread function_2585c107();
	}
}

/*
	Name: function_2585c107
	Namespace: namespace_48d025ef
	Checksum: 0xBCBC36A6
	Offset: 0x3668
	Size: 0x150
	Parameters: 0
	Flags: Linked
*/
function function_2585c107()
{
	self endon(#"hash_2bb8be6b846aed93");
	level endon(#"intermission");
	while(true)
	{
		var_79fd35f9 = level.var_90bda347 gettagorigin("tag_origin");
		if(var_79fd35f9[0] != self.var_608d2b77[0] || var_79fd35f9[1] != self.var_608d2b77[1] || var_79fd35f9[2] != self.var_608d2b77[2])
		{
			var_f370dc28 = self.var_da4fd8df;
			var_37b53ba7 = self.var_608d2b77;
			self.var_da4fd8df = self.var_ca2681ca gettagorigin("tag_origin");
			self.var_608d2b77 = var_79fd35f9;
			soundupdatelineemitter(#"hash_3d5a33369bbe2308", var_f370dc28, var_37b53ba7, self.var_da4fd8df, self.var_608d2b77);
		}
		wait(0.1);
	}
}

/*
	Name: function_1c341163
	Namespace: namespace_48d025ef
	Checksum: 0x63019575
	Offset: 0x37C0
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_1c341163(localclientnum)
{
	level endon(#"intermission");
	self waittill(#"hash_2bb8be6b846aed93");
	soundstoplineemitter(#"hash_3d5a33369bbe2308", self.var_da4fd8df, self.var_608d2b77);
	if(isdefined(self))
	{
		self.var_4f7e3c84 = 0;
	}
}

/*
	Name: function_dac3a61d
	Namespace: namespace_48d025ef
	Checksum: 0x1104CB8F
	Offset: 0x3848
	Size: 0xD6
	Parameters: 7
	Flags: Linked
*/
function function_dac3a61d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_19849e = self playloopsound(#"hash_10c1592e20803fc0");
		}
	}
	else if(self zm_utility::function_f8796df3(localclientnum) && isdefined(self.var_19849e))
	{
		self stoploopsound(self.var_19849e);
		self.var_19849e = undefined;
	}
}

/*
	Name: function_e1af20d7
	Namespace: namespace_48d025ef
	Checksum: 0x8BE25FF1
	Offset: 0x3928
	Size: 0x1C4
	Parameters: 7
	Flags: Linked
*/
function function_e1af20d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_1c4bae784c38419");
		self function_116b95e5(#"hash_349a56ada2bc0bc8", "Reveal Threshold", 1);
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self playsound(localclientnum, #"hash_6448985393417e0c");
			self.var_8ff4b42c = self playloopsound(#"hash_3c4934dafbb5efee");
		}
	}
	else if(self zm_utility::function_f8796df3(localclientnum))
	{
		if(isdefined(self.var_8ff4b42c))
		{
			self stoploopsound(self.var_8ff4b42c);
			self.var_8ff4b42c = undefined;
		}
		self playsound(localclientnum, #"hash_286c32a151d527cf");
	}
	self function_116b95e5(#"hash_349a56ada2bc0bc8", "Reveal Threshold", 0);
	self thread postfx::exitpostfxbundle(#"hash_1c4bae784c38419");
}

/*
	Name: function_eb5c7406
	Namespace: namespace_48d025ef
	Checksum: 0xA508723D
	Offset: 0x3AF8
	Size: 0x136
	Parameters: 7
	Flags: Linked
*/
function function_eb5c7406(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_14f0c39a = util::playfxontag(localclientnum, level._effect[#"hash_14c7ae107e96344f"], self, "tag_origin");
		self.var_6593b374 = util::playfxontag(localclientnum, level._effect[#"hash_7f40415d2fd7eca7"], self, "tag_origin");
	}
	else if(isdefined(self.var_14f0c39a))
	{
		stopfx(localclientnum, self.var_14f0c39a);
		self.var_14f0c39a = undefined;
	}
	if(isdefined(self.var_6593b374))
	{
		stopfx(localclientnum, self.var_6593b374);
		self.var_6593b374 = undefined;
	}
}

/*
	Name: function_50703d72
	Namespace: namespace_48d025ef
	Checksum: 0x5282A9B6
	Offset: 0x3C38
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_50703d72(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_efc27744 = util::playfxontag(localclientnum, level._effect[#"hash_139a09a4b1249370"], self, "tag_origin");
	}
	else if(isdefined(self.var_efc27744))
	{
		stopfx(localclientnum, self.var_efc27744);
		self.var_efc27744 = undefined;
	}
}

/*
	Name: function_218857fd
	Namespace: namespace_48d025ef
	Checksum: 0xD946EB5D
	Offset: 0x3D00
	Size: 0x62
	Parameters: 7
	Flags: Linked
*/
function function_218857fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level.var_6af9e868 = 1;
	}
	else
	{
		level.var_6af9e868 = 0;
	}
}

/*
	Name: function_b415e676
	Namespace: namespace_48d025ef
	Checksum: 0x49B2E7DC
	Offset: 0x3D70
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_b415e676(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		setpbgactivebank(localclientnum, 8);
	}
	else
	{
		setpbgactivebank(localclientnum, 0);
	}
}

/*
	Name: function_e3c6c272
	Namespace: namespace_48d025ef
	Checksum: 0x590DA998
	Offset: 0x3DF8
	Size: 0x124
	Parameters: 7
	Flags: Linked
*/
function function_e3c6c272(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_7541447588c20db8");
	if(isdefined(self.var_c605c611) && self zm_utility::function_f8796df3(localclientnum))
	{
		deletefx(localclientnum, self.var_c605c611);
		self.var_c605c611 = undefined;
	}
	if(isdefined(self.var_b3341e1e) && self zm_utility::function_f8796df3(localclientnum))
	{
		deletefx(localclientnum, self.var_b3341e1e);
		self.var_b3341e1e = undefined;
	}
	if(newval)
	{
		if(function_65b9eb0f(localclientnum))
		{
			return;
		}
		self thread function_ae2a3a29(localclientnum);
	}
}

/*
	Name: function_ae2a3a29
	Namespace: namespace_48d025ef
	Checksum: 0x1AB95E81
	Offset: 0x3F28
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_ae2a3a29(localclientnum)
{
	self endon(#"hash_7541447588c20db8", #"death");
	while(true)
	{
		if(!isalive(self))
		{
			break;
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_c605c611 = playfxoncamera(localclientnum, level._effect[#"hash_76da38284b0c73ed"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
		}
		else
		{
			self.var_b3341e1e = util::playfxontag(localclientnum, level._effect[#"hash_76e124284b12709f"], self, "j_head");
		}
		wait(randomfloatrange(0.9, 1.1));
	}
}

/*
	Name: function_7716b881
	Namespace: namespace_48d025ef
	Checksum: 0x3ED768D8
	Offset: 0x4048
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function function_7716b881(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_23559a237b3202c3");
	if(isdefined(self.var_7716b881) && self zm_utility::function_f8796df3(localclientnum))
	{
		deletefx(localclientnum, self.var_7716b881);
		self.var_7716b881 = undefined;
	}
	if(newval)
	{
		if(function_65b9eb0f(localclientnum))
		{
			return;
		}
		switch(newval)
		{
			case 1:
			{
				str_type = #"hash_6788a08fe46cb4c4";
				break;
			}
			case 2:
			{
				str_type = #"hash_2b51d1fecfaa7ae6";
				break;
			}
			case 3:
			{
				str_type = #"hash_3a6842a4656de818";
				break;
			}
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self thread function_7f21fc5b(localclientnum, str_type);
		}
	}
}

/*
	Name: function_7f21fc5b
	Namespace: namespace_48d025ef
	Checksum: 0x9687A090
	Offset: 0x41E0
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_7f21fc5b(localclientnum, str_type)
{
	self endon(#"hash_23559a237b3202c3", #"death");
	while(true)
	{
		if(!isalive(self))
		{
			break;
		}
		self.var_7716b881 = playfxoncamera(localclientnum, level._effect[str_type], (0, 0, 0), anglestoforward(self.angles), anglestoup(self.angles));
		wait(randomfloatrange(0.4, 0.7));
	}
}

