// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_52d8d460;

/*
	Name: __init__system__
	Namespace: namespace_52d8d460
	Checksum: 0x77CDCFB4
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_7ca2cbd84515aff1", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_52d8d460
	Checksum: 0xBAC8897A
	Offset: 0x158
	Size: 0x83A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"hash_26af481b9a9d41ce", 1, 1, "counter", &function_618e1db4, 0, 0);
	clientfield::register("allplayers", "" + #"hash_18fc1da5f1785e6b", 1, 1, "counter", &function_311767a6, 0, 0);
	clientfield::register("allplayers", "" + #"charge_gem", 1, 2, "int", &function_8a2b203b, 0, 1);
	clientfield::register("allplayers", "" + #"hash_275debebcd185ea1", 1, 1, "int", &function_467afa20, 0, 1);
	clientfield::register("toplayer", "" + #"hash_dc971935944f005", 1, 1, "counter", &function_b975154f, 0, 0);
	clientfield::register("toplayer", "" + #"hash_6b725eefec5d09d1", 1, 1, "counter", &function_e8244a0c, 0, 0);
	clientfield::register("toplayer", "" + #"hash_73e9280f74528e8f", 1, 1, "counter", &function_3864f492, 0, 0);
	clientfield::register("toplayer", "" + #"hash_21ff5b4eccea85ff", 1, 1, "counter", &function_200650fb, 0, 0);
	clientfield::register("toplayer", "" + #"hash_64a830301c1adbf3", 1, 1, "counter", &function_781821bc, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4f32455c6a0286cd", 1, 1, "counter", &function_f6ec8d80, 0, 0);
	clientfield::register("toplayer", "" + #"hash_32ef1785f4e55e5c", 1, 1, "counter", &function_bee087e9, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2cd1bb15f71aedb8", 1, 1, "counter", &function_7faf18dd, 0, 0);
	clientfield::register("toplayer", "" + #"hash_1769e95fdb10dfae", 1, 1, "counter", &function_f2c5818e, 0, 0);
	level._effect[#"charged_eyes"] = #"hash_2d151fbde925d3e";
	level._effect[#"hash_5a722d93fee71051"] = #"hash_7a37d99aaa7057cf";
	level._effect[#"firestorm_1p"] = #"hash_5a45cca38c2dd6c8";
	level._effect[#"firestorm_3p"] = #"hash_5a4cd8a38c3409da";
	level._effect[#"hash_7f665a0db122bf39"] = #"hash_2c36c10b1ca1f825";
	level._effect[#"hash_7f6c660db1273f4b"] = #"hash_9dd3174f1e4d47b";
	level._effect[#"hash_75cfc1cd4cd9154"] = #"hash_2eeb08ff15dbd6b1";
	level._effect[#"hash_75cff1cd4cd966d"] = #"hash_5a07c709253f930e";
	level._effect[#"hash_75cfe1cd4cd94ba"] = #"hash_75bbd0f87c4680f";
	level._effect[#"hash_38570770cd6d813"] = #"hash_16d3d7ce6102593e";
	level._effect[#"hash_38571770cd6d9c6"] = #"hash_6d7100bc284c41bf";
	level._effect[#"hash_38572770cd6db79"] = #"hash_81acefeeab6c48";
	level._effect[#"hash_b6b43fcf47f973a"] = #"hash_459f76532c44d9de";
	level._effect[#"hash_b6437fcf4796428"] = #"hash_45986a532c3ea6cc";
	level._effect[#"hash_68b849e276bbf061"] = #"hash_7d92c5012968852f";
	level._effect[#"hash_68bf35e276c1ed13"] = #"hash_1cf28497519df049";
	level._effect[#"hash_1f529a78925e826b"] = #"hash_459f76532c44d9de";
	level._effect[#"hash_3e1099f1a91d23a9"] = #"hash_45986a532c3ea6cc";
	level._effect[#"hash_7df4212d44450442"] = #"hash_7d92c5012968852f";
	level._effect[#"hash_76550305a8accb7c"] = #"hash_1cf28497519df049";
}

/*
	Name: function_618e1db4
	Namespace: namespace_52d8d460
	Checksum: 0xE4F20D02
	Offset: 0x9A0
	Size: 0x16A
	Parameters: 7
	Flags: Linked
*/
function function_618e1db4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self.weapon == getweapon(#"hash_2f351450f2e936dc"))
	{
		var_27aa6343 = level._effect[#"hash_7f665a0db122bf39"];
		var_a1f103c8 = level._effect[#"hash_7f6c660db1273f4b"];
	}
	else
	{
		var_27aa6343 = level._effect[#"firestorm_1p"];
		var_a1f103c8 = level._effect[#"firestorm_3p"];
	}
	if(zm_utility::function_f8796df3(localclientnum))
	{
		if(viewmodelhastag(localclientnum, "tag_barrels_fx"))
		{
			self.fx_firestorm = playviewmodelfx(localclientnum, var_27aa6343, "tag_barrels_fx");
		}
	}
	else
	{
		self.fx_firestorm = util::playfxontag(localclientnum, var_a1f103c8, self, "tag_barrels_fx");
	}
}

/*
	Name: function_311767a6
	Namespace: namespace_52d8d460
	Checksum: 0xE4FB2C49
	Offset: 0xB18
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_311767a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.fx_firestorm))
	{
		killfx(localclientnum, self.fx_firestorm);
	}
}

/*
	Name: function_467afa20
	Namespace: namespace_52d8d460
	Checksum: 0xFDEDC047
	Offset: 0xB88
	Size: 0x1C4
	Parameters: 7
	Flags: Linked
*/
function function_467afa20(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_515e20e6 = 0;
	if(self.weapon == getweapon(#"hash_2f351450f2e936dc"))
	{
		var_515e20e6 = 1;
	}
	if(newval)
	{
		if(zm_utility::function_f8796df3(localclientnum))
		{
			var_a3229167 = level._effect[#"hash_1f529a78925e826b"];
			if(var_515e20e6)
			{
				var_a3229167 = level._effect[#"hash_7df4212d44450442"];
			}
			if(viewmodelhastag(localclientnum, "tag_blade_fx"))
			{
				self.fx_docked = playviewmodelfx(localclientnum, var_a3229167, "tag_blade_fx");
			}
		}
		else
		{
			var_2f34467b = level._effect[#"hash_3e1099f1a91d23a9"];
			if(var_515e20e6)
			{
				var_2f34467b = level._effect[#"hash_76550305a8accb7c"];
			}
			self.fx_docked = util::playfxontag(localclientnum, var_2f34467b, self, "tag_blade_fx");
		}
	}
	else if(isdefined(self.fx_docked))
	{
		killfx(localclientnum, self.fx_docked);
	}
}

/*
	Name: function_8a2b203b
	Namespace: namespace_52d8d460
	Checksum: 0xD80CEF55
	Offset: 0xD58
	Size: 0x6CA
	Parameters: 7
	Flags: Linked
*/
function function_8a2b203b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(!isdefined(self.fx_katar))
	{
		self.fx_katar = [];
	}
	else if(!isarray(self.fx_katar))
	{
		self.fx_katar = array(self.fx_katar);
	}
	foreach(fx in self.fx_katar)
	{
		killfx(localclientnum, fx);
	}
	if(isdefined(self.var_dc255e3b))
	{
		self stoploopsound(self.var_dc255e3b);
		self.var_dc255e3b = undefined;
	}
	var_515e20e6 = 0;
	if(self.weapon == getweapon(#"zhield_zword_dw_upgraded"))
	{
		var_515e20e6 = 1;
	}
	switch(newval)
	{
		case 0:
		{
			foreach(fx in self.fx_katar)
			{
				killfx(localclientnum, fx);
			}
			if(isdefined(self.var_d16b03db))
			{
				killfx(localclientnum, self.var_d16b03db);
			}
			break;
		}
		case 1:
		{
			if(var_515e20e6)
			{
				var_2b01a8ab = level._effect[#"hash_38570770cd6d813"];
			}
			else
			{
				var_2b01a8ab = level._effect[#"hash_75cfc1cd4cd9154"];
			}
			str_sound = #"hash_5bdfbb591ff7e29d";
			break;
		}
		case 2:
		{
			if(var_515e20e6)
			{
				var_2b01a8ab = level._effect[#"hash_38571770cd6d9c6"];
			}
			else
			{
				var_2b01a8ab = level._effect[#"hash_75cff1cd4cd966d"];
			}
			str_sound = #"hash_5bdfb8591ff7dd84";
			break;
		}
		case 3:
		{
			if(var_515e20e6)
			{
				var_2b01a8ab = level._effect[#"hash_38572770cd6db79"];
				var_43a627a8 = level._effect[#"hash_68b849e276bbf061"];
				var_c10d7c76 = level._effect[#"hash_68bf35e276c1ed13"];
			}
			else
			{
				var_2b01a8ab = level._effect[#"hash_75cfe1cd4cd94ba"];
				var_43a627a8 = level._effect[#"hash_b6b43fcf47f973a"];
				var_c10d7c76 = level._effect[#"hash_b6437fcf4796428"];
			}
			if(oldval != 0)
			{
				str_sound = #"hash_5bdfb9591ff7df37";
			}
			if(!isdefined(self.var_dc255e3b))
			{
				if(oldval != 0)
				{
					self playsound(localclientnum, #"hash_54365a8985bf4da9");
				}
				self.var_dc255e3b = self playloopsound(#"hash_5452ecceeecdc217");
			}
			break;
		}
	}
	if(zm_utility::function_f8796df3(localclientnum))
	{
		if(isdefined(var_43a627a8) && viewmodelhastag(localclientnum, "tag_blade_fx"))
		{
			self.fx_katar[#"flame_1p"] = playviewmodelfx(localclientnum, var_43a627a8, "tag_blade_fx");
		}
		if(isdefined(str_sound))
		{
			self playsound(localclientnum, str_sound);
		}
		if(isdefined(var_2b01a8ab) && viewmodelhastag(localclientnum, "tag_gem_right3_fx") && viewmodelhastag(localclientnum, "tag_gem_left3_fx"))
		{
			self.fx_katar[#"r"] = playviewmodelfx(localclientnum, var_2b01a8ab, "tag_gem_right3_fx");
			self.fx_katar[#"l"] = playviewmodelfx(localclientnum, var_2b01a8ab, "tag_gem_left3_fx");
		}
	}
	else if(isdefined(var_c10d7c76))
	{
		self.fx_katar[#"flame_3p"] = util::playfxontag(localclientnum, var_c10d7c76, self, "tag_blade_fx");
		if(var_515e20e6)
		{
			self.var_d16b03db = util::playfxontag(localclientnum, level._effect[#"hash_5a722d93fee71051"], self, "tag_barrels_fx");
		}
		else
		{
			self.var_d16b03db = util::playfxontag(localclientnum, level._effect[#"charged_eyes"], self, "tag_barrels_fx");
		}
	}
}

/*
	Name: function_b975154f
	Namespace: namespace_52d8d460
	Checksum: 0x92B34AAC
	Offset: 0x1430
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_b975154f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34260ecf();
	if(newval)
	{
		s_start = struct::get(#"hash_8f1fa9142d272b6");
		self thread function_103be84b(localclientnum, #"lower", s_start);
	}
}

/*
	Name: function_e8244a0c
	Namespace: namespace_52d8d460
	Checksum: 0x5CE83776
	Offset: 0x14F0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_e8244a0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_4752663d0689d2c2");
	}
}

/*
	Name: function_3864f492
	Namespace: namespace_52d8d460
	Checksum: 0xCD51735B
	Offset: 0x1560
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_3864f492(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_4d84827b8da5223d");
	}
}

/*
	Name: function_200650fb
	Namespace: namespace_52d8d460
	Checksum: 0x5F6C4893
	Offset: 0x15D0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_200650fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34260ecf();
	if(newval)
	{
		s_start = struct::get(#"hash_6ef4fc9a0ac3e3bc");
		self thread function_103be84b(localclientnum, #"katar", s_start);
	}
}

/*
	Name: function_781821bc
	Namespace: namespace_52d8d460
	Checksum: 0xE6B1A876
	Offset: 0x1690
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_781821bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_3c5ef4492a237f89");
	}
}

/*
	Name: function_f6ec8d80
	Namespace: namespace_52d8d460
	Checksum: 0xBA4815E7
	Offset: 0x1700
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_f6ec8d80(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_748199dab24b7972");
	}
}

/*
	Name: function_bee087e9
	Namespace: namespace_52d8d460
	Checksum: 0x56C17EE8
	Offset: 0x1770
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_bee087e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34260ecf();
	if(newval)
	{
		s_start = struct::get(#"hash_3c2d004790b50543");
		self thread function_103be84b(localclientnum, #"upper", s_start);
	}
}

/*
	Name: function_7faf18dd
	Namespace: namespace_52d8d460
	Checksum: 0xD3A2777E
	Offset: 0x1830
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_7faf18dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_5be88bdaaf36eedf");
	}
}

/*
	Name: function_f2c5818e
	Namespace: namespace_52d8d460
	Checksum: 0x67DDC861
	Offset: 0x18A0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_f2c5818e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self flag::set(#"hash_586e5d98fff291f8");
	}
}

/*
	Name: function_34260ecf
	Namespace: namespace_52d8d460
	Checksum: 0xCF06D6BF
	Offset: 0x1910
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_34260ecf()
{
	self endon(#"disconnect");
	if(!self flag::exists(#"hash_6f18405679f0d57"))
	{
		self flag::init(#"hash_6f18405679f0d57");
	}
	if(self flag::get(#"hash_6f18405679f0d57"))
	{
		return;
	}
	self flag::init(#"hash_4752663d0689d2c2");
	self flag::init(#"hash_3c5ef4492a237f89");
	self flag::init(#"hash_5be88bdaaf36eedf");
	self flag::init(#"hash_4d84827b8da5223d");
	self flag::init(#"hash_748199dab24b7972");
	self flag::init(#"hash_586e5d98fff291f8");
	self flag::set(#"hash_6f18405679f0d57");
}

/*
	Name: function_103be84b
	Namespace: namespace_52d8d460
	Checksum: 0x8681C3F0
	Offset: 0x1A80
	Size: 0x2F4
	Parameters: 3
	Flags: Linked
*/
function function_103be84b(localclientnum, str_piece, s_start)
{
	self endon(#"disconnect");
	switch(str_piece)
	{
		case "lower":
		{
			str_model = #"hash_534a8889633c5f83";
			var_6b518b80 = #"hash_4752663d0689d2c2";
			var_458142a9 = #"hash_4d84827b8da5223d";
			n_drop_time = 1;
			break;
		}
		case "katar":
		{
			str_model = #"hash_55f4b4dc9ecc95a5";
			var_6b518b80 = #"hash_3c5ef4492a237f89";
			var_458142a9 = #"hash_748199dab24b7972";
			n_drop_time = 0;
			break;
		}
		case "upper":
		{
			str_model = #"hash_a3555c0c041bd06";
			var_6b518b80 = #"hash_5be88bdaaf36eedf";
			var_458142a9 = #"hash_586e5d98fff291f8";
			n_drop_time = 0.5;
			break;
		}
	}
	forcestreamxmodel(str_model);
	mdl_piece = util::spawn_model(localclientnum, str_model, s_start.origin, s_start.angles);
	mdl_piece playloopsound(#"hash_1520069daa9734fd", 1);
	self flag::wait_till(var_6b518b80);
	if(str_piece != #"katar")
	{
		s_end = struct::get(s_start.target);
		mdl_piece moveto(s_end.origin, n_drop_time);
		mdl_piece rotateto(s_end.angles, n_drop_time);
	}
	if(isdefined(self))
	{
		self flag::wait_till(var_458142a9);
		mdl_piece stoploopsound(1);
	}
	if(isdefined(self))
	{
		self playsound(localclientnum, #"hash_230737b2535a3374");
	}
	mdl_piece delete();
	stopforcestreamingxmodel(str_model);
}

