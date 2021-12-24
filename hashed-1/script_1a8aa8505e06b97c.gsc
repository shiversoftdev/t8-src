// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\serverfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_lightning_chain.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_7a119950;

/*
	Name: function_89f2df9
	Namespace: namespace_7a119950
	Checksum: 0x72B86176
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1f48680a4fda250c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7a119950
	Checksum: 0x3ECE80AA
	Offset: 0x228
	Size: 0x35A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "ouranos_shoot", 16000, 1, "counter", &function_b3ffbfd, 0, 0);
	clientfield::register("scriptmover", "ouranos_impact", 16000, 1, "counter", &ouranos_impact_fx, 0, 0);
	clientfield::register("allplayers", "" + #"hash_494799612e85ee2f", 16000, 1, "int", &skull_turret_beam_fire, 0, 1);
	clientfield::register("allplayers", "" + #"hash_4fb73e88d45af0ef", 16000, 1, "int", &function_98b06f97, 0, 1);
	clientfield::register("actor", "" + #"hash_c5b1d12b0fd3651", 16000, getminbitcountfornum(3), "int", &function_a1d614f9, 0, 1);
	clientfield::register("actor", "" + #"hash_28af05433c1d1a2e", 16000, 1, "counter", &function_1322534b, 0, 0);
	serverfield::register("ouranos_feather_hit", 16000, getminbitcountfornum(3), "int");
	level._effect[#"hash_7a9b30609a5988e3"] = #"hash_3ee5b689d09f0824";
	level._effect[#"ouranos_trail"] = #"hash_62f4ee1a2e3c46fc";
	level._effect[#"ouranos_impact"] = #"hash_5869597389a55f7b";
	level._effect[#"hash_c5b1d12b0fd3651"] = #"hash_215ead487c4bef59";
	level._effect[#"hash_74ba9d1683d64d68"] = #"hash_4cc40e13ee8dff61";
	level._effect[#"hash_31736c99409b40ef"] = #"hash_44bd80522ac100e7";
}

/*
	Name: function_1322534b
	Namespace: namespace_7a119950
	Checksum: 0xDFD609EC
	Offset: 0x590
	Size: 0x14C
	Parameters: 7
	Flags: Linked
*/
function function_1322534b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self gettagorigin("j_spine4")))
	{
		v_org = self gettagorigin("j_spine4");
	}
	else
	{
		str_tag = self zm_utility::function_467efa7b();
		if(!isdefined(str_tag))
		{
			str_tag = "tag_origin";
		}
		else
		{
			v_org = self gettagorigin(str_tag);
		}
	}
	playfx(localclientnum, level._effect[#"ouranos_impact"], v_org, anglestoforward(self.angles));
	playsound(localclientnum, #"hash_3360f981ac697bfe", self.origin);
}

/*
	Name: function_a1d614f9
	Namespace: namespace_7a119950
	Checksum: 0xADECF2D6
	Offset: 0x6E8
	Size: 0x20C
	Parameters: 7
	Flags: Linked
*/
function function_a1d614f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self gettagorigin("j_spine4")))
	{
		str_tag = "j_spine4";
	}
	else
	{
		str_tag = self zm_utility::function_467efa7b();
		if(!isdefined(str_tag))
		{
			str_tag = "tag_origin";
		}
	}
	if(newval == 1)
	{
		self playsound(localclientnum, #"hash_3360f981ac697bfe");
		util::playfxontag(localclientnum, level._effect[#"hash_c5b1d12b0fd3651"], self, str_tag);
	}
	else if(newval == 2)
	{
		self playsound(localclientnum, #"hash_3360f981ac697bfe");
		util::playfxontag(localclientnum, level._effect[#"hash_74ba9d1683d64d68"], self, str_tag);
	}
	else if(newval == 3)
	{
		self playsound(localclientnum, #"hash_3360f981ac697bfe");
		util::playfxontag(localclientnum, level._effect[#"hash_c5b1d12b0fd3651"], self, str_tag);
		self thread function_f89a4434(localclientnum);
	}
}

/*
	Name: function_f89a4434
	Namespace: namespace_7a119950
	Checksum: 0xED05AE75
	Offset: 0x900
	Size: 0x202
	Parameters: 1
	Flags: Linked
*/
function function_f89a4434(localclientnum)
{
	waitframe(1);
	if(!isdefined(self) || !isdefined(self.enemy))
	{
		return;
	}
	self endon(#"death");
	self.enemy endon(#"death");
	vol_center = getent(localclientnum, "vol_ww_ouranos_center_fletching", "targetname");
	vol_cliff = getent(localclientnum, "vol_ww_ouranos_cliff_fletching", "targetname");
	vol_serpent = getent(localclientnum, "vol_ww_ouranos_serpent_fletching", "targetname");
	while(isdefined(self))
	{
		if(isdefined(vol_center) && istouching(self.origin, vol_center))
		{
			if(isdefined(self.enemy))
			{
				self.enemy thread function_1ebdc841(1);
				break;
			}
		}
		else if(isdefined(vol_cliff) && istouching(self.origin, vol_cliff))
		{
			if(isdefined(self.enemy))
			{
				self.enemy thread function_1ebdc841(2);
				break;
			}
		}
		else if(isdefined(vol_serpent) && istouching(self.origin, vol_serpent))
		{
			if(isdefined(self.enemy))
			{
				self.enemy thread function_1ebdc841(3);
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_1ebdc841
	Namespace: namespace_7a119950
	Checksum: 0x919C7098
	Offset: 0xB10
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_1ebdc841(n_feather)
{
	self endon(#"death");
	self serverfield::set("ouranos_feather_hit", n_feather);
	waitframe(1);
	self serverfield::set("ouranos_feather_hit", 0);
}

/*
	Name: function_b3ffbfd
	Namespace: namespace_7a119950
	Checksum: 0xAE0979
	Offset: 0xB80
	Size: 0xAA
	Parameters: 7
	Flags: Linked
*/
function function_b3ffbfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"ouranos_trail"], self, "tag_origin");
	if(!isdefined(self.n_sfx))
	{
		self.n_sfx = self playloopsound(#"hash_166762facd657625");
	}
}

/*
	Name: ouranos_impact_fx
	Namespace: namespace_7a119950
	Checksum: 0x752E63E2
	Offset: 0xC38
	Size: 0x21C
	Parameters: 7
	Flags: Linked
*/
function ouranos_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self gettagorigin("j_wingulna_le")))
	{
		v_org = self gettagorigin("j_h_neck_lower");
	}
	else if(isdefined(self gettagorigin("j_spine4")))
	{
		v_org = self gettagorigin("j_spine4");
	}
	else
	{
		v_org = self.origin;
	}
	v_forward = (anglestoforward(self.angles) * 1000) + self.origin;
	v_back = (anglestoforward(self.angles) * -100) + self.origin;
	a_trace = bullettrace(v_back, v_forward, 0, self);
	if(isdefined(a_trace[#"normal"]))
	{
		v_ang = a_trace[#"normal"];
	}
	else
	{
		v_ang = anglestoforward(self.angles) * -1;
	}
	playfx(localclientnum, level._effect[#"ouranos_impact"], v_org, v_ang);
	playsound(localclientnum, #"hash_d09856cb05b1a39", self.origin);
}

/*
	Name: skull_turret_beam_fire
	Namespace: namespace_7a119950
	Checksum: 0x475F6A7F
	Offset: 0xE60
	Size: 0x1F6
	Parameters: 7
	Flags: Linked
*/
function skull_turret_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death", #"disconnect");
	if(newval == 1)
	{
		if(isdefined(self.var_c400cdd5))
		{
			killfx(localclientnum, self.var_c400cdd5);
			self.var_c400cdd5 = undefined;
		}
		if(!self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_c400cdd5 = util::playfxontag(localclientnum, level._effect[#"hash_31736c99409b40ef"], self, "tag_weapon_right");
		}
		if(!isdefined(self.var_76c23e4c))
		{
			self playsound(localclientnum, #"hash_5e5e7d42f62fb92d");
			self.var_76c23e4c = self playloopsound(#"hash_14ac86ceee99d2f3");
		}
	}
	else if(isdefined(self.var_c400cdd5))
	{
		killfx(localclientnum, self.var_c400cdd5);
		self.var_c400cdd5 = undefined;
	}
	if(isdefined(self.var_76c23e4c))
	{
		self playsound(localclientnum, #"hash_6b91419f41fc8d34");
		self stoploopsound(self.var_76c23e4c);
		self.var_76c23e4c = undefined;
	}
}

/*
	Name: function_98b06f97
	Namespace: namespace_7a119950
	Checksum: 0x2D87370E
	Offset: 0x1060
	Size: 0x10E
	Parameters: 7
	Flags: Linked
*/
function function_98b06f97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_76c23e4c))
		{
			self playsound(localclientnum, #"hash_5e5e7d42f62fb92d");
			self.var_76c23e4c = self playloopsound(#"hash_14ac86ceee99d2f3");
		}
	}
	else if(isdefined(self.var_76c23e4c))
	{
		self playsound(localclientnum, #"hash_6b91419f41fc8d34");
		self stoploopsound(self.var_76c23e4c);
		self.var_76c23e4c = undefined;
	}
}

