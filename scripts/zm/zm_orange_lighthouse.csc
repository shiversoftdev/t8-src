// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_orange_lighthouse;

/*
	Name: __init__system__
	Namespace: zm_orange_lighthouse
	Checksum: 0x840A44B3
	Offset: 0x168
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_orange_lighthouse", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_orange_lighthouse
	Checksum: 0xB57B77D3
	Offset: 0x1B0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	init_fx();
	forcestreamxmodel("p8_zm_ora_soapstone_01_hot");
}

/*
	Name: init_clientfields
	Namespace: zm_orange_lighthouse
	Checksum: 0x69B98C7D
	Offset: 0x1F8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "lighthouse_on", 24000, 3, "int", &function_6a10478, 0, 0);
	clientfield::register("vehicle", "" + #"hash_19bce46b8ab82440", 24000, 1, "int", &function_c7fb0e97, 0, 0);
	clientfield::register("actor", "" + #"hash_5af1cd27f90895ae", 24000, 1, "counter", &function_a177b2da, 0, 0);
}

/*
	Name: init_fx
	Namespace: zm_orange_lighthouse
	Checksum: 0xF3470A9F
	Offset: 0x300
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"lighthouse_beam"] = #"hash_5549637de48b4ff5";
	level._effect[#"hash_4eeea3cde4956976"] = #"hash_52b7a2fb71b00d26";
	level._effect[#"hash_33dbdabd23d73303"] = #"hash_1806470e7079c133";
	level._effect[#"hash_21a180bd19425da5"] = #"hash_5cd0d0e65e6d535";
	level._effect[#"hash_58fef59f738c6315"] = #"explosions/fx8_exp_elec_killstreak";
	level._effect[#"hash_48d5d5ee69c7e417"] = #"hash_64be6c1537ad552e";
	level._effect[#"hash_4d1abbf031ca2c63"] = #"hash_6144e721b78e74a4";
}

/*
	Name: function_6a10478
	Namespace: zm_orange_lighthouse
	Checksum: 0x1E96745D
	Offset: 0x460
	Size: 0x51A
	Parameters: 7
	Flags: Linked
*/
function function_6a10478(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.fx_id))
	{
		stopfx(localclientnum, self.fx_id);
		if(isdefined(self.var_190322ee))
		{
			self.var_190322ee stoploopsound(1);
			self.var_190322ee delete();
		}
	}
	switch(newval)
	{
		case 1:
		{
			if(isdefined(self.var_190322ee))
			{
				self.var_190322ee stoploopsound(1);
				self.var_190322ee delete();
			}
			self.fx_id = util::playfxontag(localclientnum, level._effect[#"lighthouse_beam"], self, "tag_origin");
			self playsound(localclientnum, #"hash_c28cead5117620");
			self.var_190322ee = spawn(0, self.origin, "script_origin");
			self.var_190322ee playloopsound(#"hash_6181b0e69ec35a3b");
			break;
		}
		case 2:
		{
			if(isdefined(self.var_190322ee))
			{
				self.var_190322ee stoploopsound(1);
				self.var_190322ee delete();
			}
			self.fx_id = util::playfxontag(localclientnum, level._effect[#"hash_4eeea3cde4956976"], self, "tag_origin");
			self playsound(localclientnum, #"hash_261c471e4722bb37");
			self.var_190322ee = spawn(0, self.origin, "script_origin");
			self.var_190322ee playloopsound(#"hash_b838aafaa7056a0");
			break;
		}
		case 3:
		{
			if(isdefined(self.var_190322ee))
			{
				self.var_190322ee stoploopsound(1);
				self.var_190322ee delete();
			}
			self.fx_id = util::playfxontag(localclientnum, level._effect[#"hash_33dbdabd23d73303"], self, "tag_origin");
			self playsound(localclientnum, #"hash_153e70c4ae966276");
			self.var_190322ee = spawn(0, self.origin, "script_origin");
			self.var_190322ee playloopsound(#"hash_764437252a54048d");
			break;
		}
		case 4:
		{
			if(isdefined(self.var_190322ee))
			{
				self.var_190322ee stoploopsound(1);
				self.var_190322ee delete();
			}
			self.fx_id = util::playfxontag(localclientnum, level._effect[#"hash_21a180bd19425da5"], self, "tag_origin");
			self playsound(localclientnum, #"hash_3734fecc702f7cd0");
			self.var_190322ee = spawn(0, self.origin, "script_origin");
			self.var_190322ee playloopsound(#"hash_518712532057a8b");
			break;
		}
	}
}

/*
	Name: function_a177b2da
	Namespace: zm_orange_lighthouse
	Checksum: 0xA1F475FC
	Offset: 0x988
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_a177b2da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_4d1abbf031ca2c63"], self, "j_spine4");
	self playsound(localclientnum, #"hash_24925b24b30b3991");
}

/*
	Name: function_c7fb0e97
	Namespace: zm_orange_lighthouse
	Checksum: 0x99C8C73F
	Offset: 0xA30
	Size: 0x152
	Parameters: 7
	Flags: Linked
*/
function function_c7fb0e97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_85adeb8c))
	{
		beamkill(localclientnum, self.var_85adeb8c);
		self.var_85adeb8c = undefined;
	}
	if(isdefined(self.var_9c7e4ef8))
	{
		stopfx(localclientnum, self.var_9c7e4ef8);
	}
	if(newval > 0)
	{
		var_ab11c23d = getent(localclientnum, "lighthouse_light", "targetname");
		self.var_85adeb8c = level beam::function_cfb2f62a(localclientnum, var_ab11c23d, "tag_origin", self, "tag_origin", "beam8_zm_orange_lighthouse_trap_strike");
		self.var_9c7e4ef8 = util::playfxontag(localclientnum, level._effect[#"hash_48d5d5ee69c7e417"], self, "tag_origin");
	}
}

