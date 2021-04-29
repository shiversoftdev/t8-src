// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1611421ee9b880d3;
#using script_624a704d0f6bf28d;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_8260c80e;

/*
	Name: function_89f2df9
	Namespace: namespace_8260c80e
	Checksum: 0xD5200CD2
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5fe698dbef775801", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8260c80e
	Checksum: 0x7358344F
	Offset: 0x1B8
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
	Namespace: namespace_8260c80e
	Checksum: 0xAFA924B0
	Offset: 0x1E8
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "" + #"hash_2709d50a7b0a2b01", 8000, 1, "int", &function_6e123c7b, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_87483ed44cb2791", 8000, 1, "int", &function_a346a156, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_69c1868b7a8a7beb", 8000, 1, "int", &function_72efa790, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1bf2c2f62ad1bf56", 8000, 1, "int", &function_931bac5a, 0, 0);
	clientfield::register("scriptmover", "bs_sigil_fx", 8000, 3, "int", &function_1d15a456, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5cca35fc43fa51e6", 8000, 3, "int", &function_444660d9, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6ad20bd0d84e8602", 8000, 1, "int", &function_abea158a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4ca506515aec02d3", 8000, 1, "int", &function_b5901c02, 0, 0);
	clientfield::register("allplayers", "pstfx_zm_man_targeted_cf", 8000, 1, "int", &function_2a48bf1c, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_8260c80e
	Checksum: 0x3C7D5B7C
	Offset: 0x4F0
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_1e4fa83f4db14c46"] = #"hash_40a93ef9da58e006";
	level._effect[#"hash_3704ab5bf4ec1957"] = #"hash_1cd0bfd0a3ff1817";
	level._effect[#"hash_420110993bafb86b"] = #"hash_4edfb7b10f36a12b";
	level._effect[#"hash_3665813f5609df50"] = #"hash_105035871586710";
	level._effect[#"hash_2699e8762805fbdc"] = #"hash_f378b1b7c38569c";
	level._effect[#"hash_4cd18caca0e2880b"] = #"hash_155810298f5c76cb";
	level._effect[#"hash_4d8984a98c0beba2"] = #"hash_ea19875e4f1d962";
	level._effect[#"hash_24ce7f381d2f1ff5"] = #"hash_4ca6f513f26662b5";
}

/*
	Name: function_6e123c7b
	Namespace: namespace_8260c80e
	Checksum: 0xD6E9A896
	Offset: 0x680
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_6e123c7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_a5777754(localclientnum, "boss_arena");
}

/*
	Name: function_a346a156
	Namespace: namespace_8260c80e
	Checksum: 0x654A1BAE
	Offset: 0x6E8
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_a346a156(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self thread function_f389e70d(localclientnum);
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_c5c4890c94eb1c7");
		playsound(localclientnum, #"hash_8fc267f3e184882", self.origin);
	}
	else
	{
		self function_5d482e78(#"hash_c5c4890c94eb1c7");
		playsound(localclientnum, #"hash_f5264369f84b89b", self.origin);
	}
}

/*
	Name: function_72efa790
	Namespace: namespace_8260c80e
	Checksum: 0xB1E18A5D
	Offset: 0x7F8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_72efa790(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self thread function_f389e70d(localclientnum);
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_6a2d3edbb0f2c98d");
	}
	else
	{
		self function_5d482e78(#"hash_6a2d3edbb0f2c98d");
	}
}

/*
	Name: function_f389e70d
	Namespace: namespace_8260c80e
	Checksum: 0x28BCA168
	Offset: 0x8B8
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_f389e70d(localclientnum)
{
	self endon(#"death");
	if(!isdefined(self.var_aac4aa35))
	{
		self.var_aac4aa35 = util::playfxontag(localclientnum, level._effect[#"hash_3704ab5bf4ec1957"], self, "tag_eye");
	}
	else if(isdefined(self.var_aac4aa35))
	{
		stopfx(localclientnum, self.var_aac4aa35);
	}
	self.var_aac4aa35 = undefined;
	self.var_e0580f33 = util::playfxontag(localclientnum, level._effect[#"hash_1e4fa83f4db14c46"], self, "j_spine4");
	wait(0.5);
	if(isdefined(self.var_e0580f33))
	{
		stopfx(localclientnum, self.var_e0580f33);
	}
	self.var_e0580f33 = undefined;
}

/*
	Name: function_931bac5a
	Namespace: namespace_8260c80e
	Checksum: 0x6D3B7F75
	Offset: 0x9E0
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_931bac5a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 1, 0, 0);
	}
	else
	{
		self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 0, 0, 0);
	}
}

/*
	Name: function_1d15a456
	Namespace: namespace_8260c80e
	Checksum: 0xC938E6FA
	Offset: 0xA90
	Size: 0x38A
	Parameters: 7
	Flags: Linked
*/
function function_1d15a456(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_aa8c0343))
	{
		stopfx(localclientnum, self.var_aa8c0343);
	}
	switch(newval)
	{
		case 1:
		{
			self.var_aa8c0343 = playfx(localclientnum, level._effect[#"hash_2699e8762805fbdc"], self.origin, anglestoforward(self.angles));
			audio::playloopat(#"hash_868fc0612e15eaf", self.origin + vectorscale((0, 0, 1), 50));
			audio::stoploopat(#"hash_3fdf4ea8be67182e", self.origin + vectorscale((0, 0, 1), 50));
			playsound(localclientnum, #"hash_c22b771ecbf8bb6", self.origin + vectorscale((0, 0, 1), 50));
			break;
		}
		case 2:
		{
			self.var_aa8c0343 = playfx(localclientnum, level._effect[#"hash_3665813f5609df50"], self.origin, anglestoforward(self.angles));
			audio::stoploopat(#"hash_868fc0612e15eaf", self.origin + vectorscale((0, 0, 1), 50));
			audio::playloopat(#"hash_3fdf4ea8be67182e", self.origin + vectorscale((0, 0, 1), 50));
			playsound(localclientnum, #"hash_24d107d1b3a13829", self.origin + vectorscale((0, 0, 1), 50));
			break;
		}
		case 3:
		{
			self.var_aa8c0343 = playfx(localclientnum, level._effect[#"hash_4cd18caca0e2880b"], self.origin, anglestoforward(self.angles));
			audio::stoploopat(#"hash_868fc0612e15eaf", self.origin + vectorscale((0, 0, 1), 50));
			audio::stoploopat(#"hash_3fdf4ea8be67182e", self.origin + vectorscale((0, 0, 1), 50));
			break;
		}
	}
}

/*
	Name: function_444660d9
	Namespace: namespace_8260c80e
	Checksum: 0x10171374
	Offset: 0xE28
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function function_444660d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_69ab30d0))
	{
		self function_5d482e78(self.var_69ab30d0, "ROOT");
	}
	self.var_69ab30d0 = undefined;
	switch(newval)
	{
		case 0:
		{
			return;
		}
		case 1:
		{
			self.var_69ab30d0 = #"hash_7de33b7647f4c33a";
			break;
		}
		case 2:
		{
			self.var_69ab30d0 = #"hash_7de33a7647f4c187";
			break;
		}
		case 3:
		{
			self.var_69ab30d0 = #"hash_7de3397647f4bfd4";
			break;
		}
	}
	if(!isdefined(self.var_69ab30d0))
	{
		self.var_69ab30d0 = #"hash_7de33b7647f4c33a";
	}
	self function_bf9d3071(self.var_69ab30d0, "ROOT");
}

/*
	Name: function_abea158a
	Namespace: namespace_8260c80e
	Checksum: 0xFF02DC54
	Offset: 0xF90
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_abea158a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_e6b19280 = util::playfxontag(localclientnum, level._effect[#"hash_4d8984a98c0beba2"], self, "tag_fx");
	}
	else if(isdefined(self.var_e6b19280))
	{
		stopfx(localclientnum, self.var_e6b19280);
	}
	self.var_e6b19280 = undefined;
}

/*
	Name: function_b5901c02
	Namespace: namespace_8260c80e
	Checksum: 0x6A83682E
	Offset: 0x1060
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_b5901c02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_7a21c346 = util::playfxontag(localclientnum, level._effect[#"hash_24ce7f381d2f1ff5"], self, "tag_fx");
	}
	else if(isdefined(self.var_7a21c346))
	{
		stopfx(localclientnum, self.var_7a21c346);
	}
	self.var_7a21c346 = undefined;
}

/*
	Name: function_2a48bf1c
	Namespace: namespace_8260c80e
	Checksum: 0xAFA813C4
	Offset: 0x1130
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_2a48bf1c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!self zm_utility::function_f8796df3(localclientnum))
	{
		return;
	}
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_7859457bbea5aa02");
	}
	else
	{
		self thread postfx::exitpostfxbundle(#"hash_7859457bbea5aa02");
	}
}

