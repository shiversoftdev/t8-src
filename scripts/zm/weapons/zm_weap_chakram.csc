// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_weap_chakram;

/*
	Name: __init__system__
	Namespace: zm_weap_chakram
	Checksum: 0x5C0D729B
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_chakram", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_chakram
	Checksum: 0x3727BCAD
	Offset: 0x1C0
	Size: 0x74A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"zombie_slice_right", 1, 2, "counter", &function_8e1552b1, 1, 0);
	clientfield::register("actor", "" + #"zombie_slice_left", 1, 2, "counter", &function_6831ee4b, 1, 0);
	clientfield::register("allplayers", "" + #"hash_aefa3d014b0fa1b", 1, 1, "counter", &function_97e2da8c, 1, 0);
	clientfield::register("actor", "" + #"hash_1e22d429435cc148", 1, 1, "int", &function_f8183854, 1, 0);
	clientfield::register("vehicle", "" + #"hash_1e22d429435cc148", 1, 1, "int", &function_f8183854, 1, 0);
	clientfield::register("scriptmover", "" + #"hash_2a55372ad04eb0e5", 1, 1, "int", &function_29f91f81, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_302e96545259ba6b", 1, 1, "int", &function_852afbe9, 0, 0);
	clientfield::register("actor", "" + #"hash_56421723ef2ac2fb", 1, 1, "counter", &function_b0c5c975, 0, 0);
	clientfield::register("allplayers", "" + #"hash_9d9fb6cf3d5d3a6", 1, 1, "int", &function_522aa0e9, 0, 0);
	clientfield::register("actor", "" + #"hash_3c3af9a781191429", 1, 1, "counter", &function_ab57c715, 1, 0);
	clientfield::register("vehicle", "" + #"hash_3c3af9a781191429", 1, 1, "counter", &function_ab57c715, 1, 0);
	clientfield::register("toplayer", "" + #"hash_7287b37a40c4ae6f", 1, 1, "counter", &function_24ce643c, 0, 0);
	clientfield::register("toplayer", "" + #"chakram_rumble", 1, 3, "counter", &chakram_rumble, 0, 0);
	level._effect[#"sword_bloodswipe_r_1p"] = #"zombie/fx_sword_slash_right_1p_zod_zmb";
	level._effect[#"sword_bloodswipe_l_1p"] = #"zombie/fx_sword_slash_left_1p_zod_zmb";
	level._effect[#"hash_720f204e4406ddbf"] = #"hash_59cdb0226e644934";
	level._effect[#"hash_15593b3f860346f5"] = #"hash_1e957556dba822e6";
	level._effect[#"hash_5f9bb382a47d637d"] = #"hash_68100f653a5baf2f";
	level._effect[#"hash_6dca5478f1baf5ce"] = #"hash_1ff88e4b147015b2";
	level._effect[#"hash_3364e81f269deca0"] = #"hash_656272f0184ae1fc";
	level._effect[#"hash_5c2ba805602ea484"] = #"hash_3904517ed3636935";
	level._effect[#"hash_455a47023bc1da46"] = #"hash_2109d3278a7b54fa";
	level._effect[#"hash_bc1e5225071e47d"] = #"hash_2ca473741924f0c";
	level._effect[#"hash_29c798afb4256dc0"] = #"hash_37cfda7fcc57f0f";
	level._effect[#"hash_6759261c70e31d0a"] = #"hash_2103c7278a76d4e8";
	level._effect[#"hash_6ac964121fa8b4bf"] = #"hash_212ef7da466574ba";
	level._effect[#"hash_49a09babc9ee918a"] = #"hash_1ac3342ef816a481";
	level._effect[#"hash_c995c57914ab2b4"] = #"hash_1157c7544a4dd8cf";
}

/*
	Name: function_8e1552b1
	Namespace: zm_weap_chakram
	Checksum: 0xE5F89BE3
	Offset: 0x918
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_8e1552b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(util::is_mature() && !util::is_gib_restricted_build())
	{
		if(newval == 1)
		{
			util::playfxontag(localclientnum, level._effect[#"sword_bloodswipe_r_1p"], self, "j_spine4");
		}
	}
}

/*
	Name: function_6831ee4b
	Namespace: zm_weap_chakram
	Checksum: 0x2B483689
	Offset: 0x9D8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_6831ee4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(util::is_mature() && !util::is_gib_restricted_build())
	{
		if(newval == 1)
		{
			util::playfxontag(localclientnum, level._effect[#"sword_bloodswipe_l_1p"], self, "j_spine4");
		}
	}
}

/*
	Name: function_97e2da8c
	Namespace: zm_weap_chakram
	Checksum: 0x86D4524D
	Offset: 0xA98
	Size: 0x90
	Parameters: 7
	Flags: Linked
*/
function function_97e2da8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_15593b3f860346f5"], "tag_fx8");
	}
}

/*
	Name: function_f8183854
	Namespace: zm_weap_chakram
	Checksum: 0xF3A43AC3
	Offset: 0xB30
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_f8183854(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_5f9bb382a47d637d"], self, "j_head");
	}
}

/*
	Name: function_29f91f81
	Namespace: zm_weap_chakram
	Checksum: 0x21EA6BBB
	Offset: 0xBB8
	Size: 0x126
	Parameters: 7
	Flags: Linked
*/
function function_29f91f81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.fx_trail = util::playfxontag(localclientnum, level._effect[#"hash_6dca5478f1baf5ce"], self, "tag_fx");
		if(!isdefined(self.snd_looper))
		{
			self.snd_looper = self playloopsound(#"hash_3cd6bae1469848f1", 1);
		}
	}
	else
	{
		if(isdefined(self.fx_trail))
		{
			killfx(localclientnum, self.fx_trail);
		}
		if(isdefined(self.snd_looper))
		{
			self stoploopsound(self.snd_looper);
			self.snd_looper = undefined;
		}
	}
}

/*
	Name: function_852afbe9
	Namespace: zm_weap_chakram
	Checksum: 0xFC72BDFC
	Offset: 0xCE8
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_852afbe9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playfx(localclientnum, level._effect[#"hash_3364e81f269deca0"], self.origin, anglestoforward(self.angles));
		playsound(localclientnum, #"hash_72a17706cb2656cd", self.origin);
	}
}

/*
	Name: function_b0c5c975
	Namespace: zm_weap_chakram
	Checksum: 0xD51B0A62
	Offset: 0xDB0
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_b0c5c975(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_3364e81f269deca0"], self, "j_spine4");
		playsound(localclientnum, #"hash_72a17706cb2656cd", self.origin);
	}
}

/*
	Name: function_24ce643c
	Namespace: zm_weap_chakram
	Checksum: 0xA8C89E7E
	Offset: 0xE60
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_24ce643c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(!namespace_a6aea2c6::is_active(#"silent_film"))
	{
		self thread postfx::playpostfxbundle(#"hash_1663ca7cc81f9b17");
	}
}

/*
	Name: function_522aa0e9
	Namespace: zm_weap_chakram
	Checksum: 0x369D252B
	Offset: 0xEE8
	Size: 0x6DC
	Parameters: 7
	Flags: Linked
*/
function function_522aa0e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_779b5b35))
	{
		self.var_779b5b35 = [];
	}
	if(!isdefined(self.var_1c7e53dd))
	{
		self.var_1c7e53dd = [];
	}
	if(!isdefined(self.var_4316c62f))
	{
		self.var_4316c62f = [];
	}
	if(isdefined(self.var_779b5b35[localclientnum]))
	{
		deletefx(localclientnum, self.var_779b5b35[localclientnum]);
		self.var_779b5b35[localclientnum] = undefined;
	}
	if(isdefined(self.var_1c7e53dd[localclientnum]))
	{
		self stoploopsound(self.var_1c7e53dd[localclientnum]);
		self.var_1c7e53dd[localclientnum] = undefined;
	}
	if(isdefined(self.var_4316c62f[localclientnum]))
	{
		stopfx(localclientnum, self.var_4316c62f[localclientnum]);
		self.var_4316c62f[localclientnum] = undefined;
	}
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(!e_player util::function_50ed1561(localclientnum))
		{
			e_player notify(#"hash_1b4803a2f50e48ce");
		}
	}
	if(newval == 1)
	{
		self.var_1c7e53dd[localclientnum] = self playloopsound(#"hash_75e91bf08cd631e8");
		var_c2545ba4 = self.var_1c7e53dd[localclientnum];
		self.var_4316c62f[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_c995c57914ab2b4"], self, "j_spine4");
		var_4316c62f = self.var_4316c62f[localclientnum];
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_779b5b35[localclientnum] = playfxoncamera(localclientnum, level._effect[#"hash_6759261c70e31d0a"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
			var_779b5b35 = self.var_779b5b35[localclientnum];
			self thread postfx::playpostfxbundle(#"hash_42f753d2a430d5b5");
			self playrumblelooponentity(localclientnum, #"hash_2415ce1fdc3f50c5");
		}
		else
		{
			util::playfxontag(localclientnum, level._effect[#"hash_5c2ba805602ea484"], self, "tag_origin");
			wait(1);
			if(isdefined(self) && self.weapon === getweapon(#"hero_chakram_lv3"))
			{
				self.var_779b5b35[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_455a47023bc1da46"], self, "tag_origin");
				var_779b5b35 = self.var_779b5b35[localclientnum];
			}
		}
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				if(isdefined(e_player))
				{
					if(isdefined(var_779b5b35))
					{
						e_player thread zm_utility::function_ae3780f1(localclientnum, var_779b5b35, #"hash_1b4803a2f50e48ce");
					}
					e_player thread zm_utility::function_ae3780f1(localclientnum, var_4316c62f, #"hash_1b4803a2f50e48ce");
					e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_42f753d2a430d5b5", #"hash_1b4803a2f50e48ce");
					e_player thread function_cfefd76a(localclientnum, var_c2545ba4, #"hash_1b4803a2f50e48ce");
				}
			}
		}
	}
	else
	{
		self playsound(localclientnum, #"hash_4f78bd85d9a43e3c");
		if(self postfx::function_556665f2(#"hash_42f753d2a430d5b5"))
		{
			self postfx::stoppostfxbundle(#"hash_42f753d2a430d5b5");
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self stoprumble(localclientnum, #"hash_2415ce1fdc3f50c5");
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			playfxoncamera(localclientnum, level._effect[#"hash_6ac964121fa8b4bf"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
		}
		else
		{
			util::playfxontag(localclientnum, level._effect[#"hash_bc1e5225071e47d"], self, "tag_origin");
		}
	}
}

/*
	Name: function_cfefd76a
	Namespace: zm_weap_chakram
	Checksum: 0xFADB0E62
	Offset: 0x15D0
	Size: 0xF6
	Parameters: 3
	Flags: Linked, Private
*/
function private function_cfefd76a(localclientnum, var_b3673abf, var_3ab46b9)
{
	self endon(var_3ab46b9);
	s_result = undefined;
	s_result = level waittill(#"respawn");
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(isdefined(var_b3673abf))
		{
			e_player stoploopsound(var_b3673abf);
			var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_ab57c715
	Namespace: zm_weap_chakram
	Checksum: 0x2076129E
	Offset: 0x16D0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_ab57c715(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_49a09babc9ee918a"], self, "j_spine4");
}

/*
	Name: chakram_rumble
	Namespace: zm_weap_chakram
	Checksum: 0xAFE3FD62
	Offset: 0x1750
	Size: 0xFA
	Parameters: 7
	Flags: Linked
*/
function chakram_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		switch(newvalue)
		{
			case 2:
			{
				self playrumbleonentity(localclientnum, "zm_weap_chakram_catch_rumble");
				break;
			}
			case 4:
			{
				self playrumbleonentity(localclientnum, "zm_weap_chakram_melee_rumble");
				break;
			}
			case 5:
			{
				self playrumbleonentity(localclientnum, "zm_weap_chakram_throw_rumble");
				break;
			}
		}
	}
}

