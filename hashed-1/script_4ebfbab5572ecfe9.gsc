// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_lightning_chain.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_4834f482;

/*
	Name: function_89f2df9
	Namespace: namespace_4834f482
	Checksum: 0x738EB1CD
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_75393613dd2d736f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4834f482
	Checksum: 0xCAE74D63
	Offset: 0x148
	Size: 0x27A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"gaia_impact_zombie", 16000, 1, "counter", &gaia_impact_zombie_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_90f855c336338af", 16000, 1, "counter", &function_e8dc2680, 0, 0);
	clientfield::register("scriptmover", "" + #"gaia_impact", 16000, 1, "counter", &gaia_impact_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"spike_explode", 16000, 1, "counter", &function_10485953, 0, 0);
	clientfield::register("scriptmover", "" + #"spike_spawn", 16000, 1, "counter", &function_3672d8a5, 0, 0);
	level._effect[#"hash_10c872875a19ee24"] = #"hash_5873b3e8eed6eece";
	level._effect[#"hash_4f90732b3df649ba"] = #"hash_d2b136a3d2607a0";
	level._effect[#"hash_4ca4891919d9a485"] = #"hash_13b6231a05889663";
	level._effect[#"hash_1404ac8767f62b8"] = #"hash_224a2a7d7295284";
}

/*
	Name: gaia_impact_zombie_fx
	Namespace: namespace_4834f482
	Checksum: 0x9E1E2731
	Offset: 0x3D0
	Size: 0x174
	Parameters: 7
	Flags: Linked
*/
function gaia_impact_zombie_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	if(isdefined(self) && isdefined(self gettagorigin("j_spine4")))
	{
		v_org = self gettagorigin("j_spine4");
	}
	else if(isdefined(self))
	{
		str_tag = self zm_utility::function_467efa7b();
		if(!isdefined(str_tag))
		{
			v_org = self.origin;
		}
		else
		{
			v_org = self gettagorigin(str_tag);
		}
	}
	if(!isdefined(v_org))
	{
		return;
	}
	playfx(localclientnum, level._effect[#"hash_4f90732b3df649ba"], v_org, anglestoforward(self.angles));
	self playsound(localclientnum, #"hash_3efca867dc76b512");
}

/*
	Name: function_e8dc2680
	Namespace: namespace_4834f482
	Checksum: 0xEAD6C9E0
	Offset: 0x550
	Size: 0xAA
	Parameters: 7
	Flags: Linked
*/
function function_e8dc2680(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_10c872875a19ee24"], self, "tag_origin");
	if(!isdefined(self.n_sfx))
	{
		self.n_sfx = self playloopsound(#"hash_bc432b7cd09e11d");
	}
}

/*
	Name: gaia_impact_fx
	Namespace: namespace_4834f482
	Checksum: 0x8A2F45F4
	Offset: 0x608
	Size: 0x21C
	Parameters: 7
	Flags: Linked
*/
function gaia_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
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
	playfx(localclientnum, level._effect[#"hash_4f90732b3df649ba"], v_org, v_ang);
	playsound(localclientnum, #"hash_3bf3dbe329c0568b", self.origin);
}

/*
	Name: function_10485953
	Namespace: namespace_4834f482
	Checksum: 0x814DBB11
	Offset: 0x830
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_10485953(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_1404ac8767f62b8"], self, "tag_origin");
}

/*
	Name: function_3672d8a5
	Namespace: namespace_4834f482
	Checksum: 0xDF913C8F
	Offset: 0x8B0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_3672d8a5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_4ca4891919d9a485"], self, "tag_origin");
}

