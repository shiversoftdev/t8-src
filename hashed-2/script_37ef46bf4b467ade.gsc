// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_93a948d8;

/*
	Name: function_89f2df9
	Namespace: namespace_93a948d8
	Checksum: 0xDCB58083
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_62481f126a275788", &function_f0f91440, undefined, undefined);
}

/*
	Name: function_f0f91440
	Namespace: namespace_93a948d8
	Checksum: 0xA4F6B0F2
	Offset: 0x2D0
	Size: 0x4AA
	Parameters: 0
	Flags: Linked
*/
function function_f0f91440()
{
	clientfield::register("actor", "" + #"hash_2f305a0bea20d6ed", 1, 1, "int", &function_16d503c6, 0, 0);
	clientfield::register("actor", "" + #"hash_757f891a37d3db00", 1, 1, "int", &function_64927e54, 0, 0);
	clientfield::register("actor", "" + #"hash_26d3eeef96a2291e", 1, 1, "int", &function_89a4ffa9, 0, 0);
	clientfield::register("actor", "" + #"hash_32ec41222f58aa75", 1, 1, "int", &function_407434d9, 0, 0);
	clientfield::register("actor", "" + #"hash_1aa3522b88c2b76f", 1, 1, "int", &function_7cdb7d7f, 0, 0);
	clientfield::register("actor", "" + #"hash_259cdeffe60fe48f", 1, 1, "int", &function_bf0f2e8f, 0, 0);
	clientfield::register("actor", "" + #"hash_5ad28d5f104a6e3b", 1, 1, "int", &function_3b23bb2f, 0, 0);
	level._effect[#"hash_2f305a0bea20d6ed"] = #"hash_6910f1de979f539f";
	level._effect[#"hash_757f891a37d3db00"] = #"hash_3da4857b4b1553dc";
	level._effect[#"hash_26d3eeef96a2291e"] = #"hash_35e2193ab697e2f1";
	level._effect[#"hash_32ec41222f58aa75"] = #"hash_3de16b7e3bd7e5ce";
	level._effect[#"hash_4a12914ab0026a9d"] = #"hash_50599e96f376b4fa";
	level._effect[#"hash_1aa3522b88c2b76f"] = #"hash_7bd6bc3aea3ff42f";
	level._effect[#"hash_485f1b39da0ca6ca"] = #"hash_58c96eb815e5079c";
	level._effect[#"hash_57c210bb97cf187c"] = #"hash_58c964b815e4f69e";
	level._effect[#"hash_211384df1c05676c"] = #"hash_434ed0cd342c0caa";
	level._effect[#"hash_3cf697eb0a408b2e"] = #"hash_432cd0cd340f2644";
	level._effect[#"hash_390d70fef1885250"] = #"hash_7af6b9564f0fbeca";
	level._effect[#"hash_3864bbc0912cb852"] = #"hash_6d51d7c934576ac8";
}

/*
	Name: function_16d503c6
	Namespace: namespace_93a948d8
	Checksum: 0xC0CC8ADE
	Offset: 0x788
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_16d503c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_2ee2fcd8(localclientnum);
		self thread function_9babbcd9(localclientnum);
	}
	self thread util::playfxontag(localclientnum, level._effect[#"hash_2f305a0bea20d6ed"], self, "J_SpineLower");
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self function_3b6be5ed(localclientnum);
	}
	else
	{
		self hide();
	}
}

/*
	Name: function_89a4ffa9
	Namespace: namespace_93a948d8
	Checksum: 0x429383A7
	Offset: 0x8C8
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_89a4ffa9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_2ee2fcd8(localclientnum);
		self thread function_9babbcd9(localclientnum);
	}
	self thread util::playfxontag(localclientnum, level._effect[#"hash_26d3eeef96a2291e"], self, "J_SpineLower");
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self function_3b6be5ed(localclientnum);
	}
	else
	{
		self hide();
	}
}

/*
	Name: function_64927e54
	Namespace: namespace_93a948d8
	Checksum: 0x39DC0F69
	Offset: 0xA08
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_64927e54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_2ee2fcd8(localclientnum);
		self thread function_9babbcd9(localclientnum);
	}
	self thread util::playfxontag(localclientnum, level._effect[#"hash_757f891a37d3db00"], self, "J_SpineLower");
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self function_f0236487(localclientnum);
	}
}

/*
	Name: function_407434d9
	Namespace: namespace_93a948d8
	Checksum: 0x370BE01D
	Offset: 0xB30
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_407434d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_2ee2fcd8(localclientnum);
		self thread function_9babbcd9(localclientnum);
	}
	self thread util::playfxontag(localclientnum, level._effect[#"hash_32ec41222f58aa75"], self, "J_SpineLower");
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self function_f0236487(localclientnum);
	}
}

/*
	Name: function_7cdb7d7f
	Namespace: namespace_93a948d8
	Checksum: 0x3725F014
	Offset: 0xC58
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_7cdb7d7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_3022a1c2(localclientnum);
	}
	else
	{
		self thread function_2ee2fcd8(localclientnum);
	}
}

/*
	Name: function_3022a1c2
	Namespace: namespace_93a948d8
	Checksum: 0x6F2C5719
	Offset: 0xCD8
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function function_3022a1c2(localclientnum)
{
	if(!isdefined(self.var_c2fa696b))
	{
		self.var_c2fa696b = [];
	}
	if(isdefined(self.var_c2fa696b[localclientnum]))
	{
		return;
	}
	self.var_c2fa696b[localclientnum] = [];
	if(!self gibclientutils::isgibbed(localclientnum, self, 16))
	{
		function_ad4b7a78(localclientnum, level._effect[#"hash_1aa3522b88c2b76f"], "right_arm", "j_elbow_ri");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 32))
	{
		function_ad4b7a78(localclientnum, level._effect[#"hash_1aa3522b88c2b76f"], "left_arm", "j_elbow_le");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 128))
	{
		function_ad4b7a78(localclientnum, level._effect[#"hash_1aa3522b88c2b76f"], "right_leg", "j_knee_ri");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 256))
	{
		function_ad4b7a78(localclientnum, level._effect[#"hash_1aa3522b88c2b76f"], "left_leg", "j_knee_le");
	}
}

/*
	Name: function_ad4b7a78
	Namespace: namespace_93a948d8
	Checksum: 0x4BFF0457
	Offset: 0xEB0
	Size: 0x58
	Parameters: 4
	Flags: Linked
*/
function function_ad4b7a78(localclientnum, fx, key, tag)
{
	self.var_c2fa696b[localclientnum][key] = util::playfxontag(localclientnum, fx, self, tag);
}

/*
	Name: function_2ee2fcd8
	Namespace: namespace_93a948d8
	Checksum: 0xE136BE2C
	Offset: 0xF10
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function function_2ee2fcd8(localclientnum)
{
	self endon(#"death");
	if(isdefined(self.var_c2fa696b))
	{
		keys = getarraykeys(self.var_c2fa696b[localclientnum]);
		for(i = 0; i < keys.size; i++)
		{
			function_d4bf34b7(localclientnum, keys[i]);
		}
	}
}

/*
	Name: function_d4bf34b7
	Namespace: namespace_93a948d8
	Checksum: 0xB62F5200
	Offset: 0xFB8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d4bf34b7(localclientnum, key)
{
	deletefx(localclientnum, self.var_c2fa696b[localclientnum][key]);
}

/*
	Name: function_bf0f2e8f
	Namespace: namespace_93a948d8
	Checksum: 0xE33F9A10
	Offset: 0x1000
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_bf0f2e8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_de5f3855(localclientnum);
	}
	else
	{
		self thread function_9babbcd9(localclientnum);
	}
}

/*
	Name: function_de5f3855
	Namespace: namespace_93a948d8
	Checksum: 0xF3E472E4
	Offset: 0x1080
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function function_de5f3855(localclientnum)
{
	if(!isdefined(self.var_dc23481f))
	{
		self.var_dc23481f = [];
	}
	if(isdefined(self.var_dc23481f[localclientnum]))
	{
		return;
	}
	self.var_dc23481f[localclientnum] = [];
	function_637a31ed(localclientnum, level._effect[#"hash_4a12914ab0026a9d"], "torso", "j_spinelower");
	if(!self gibclientutils::isgibbed(localclientnum, self, 8))
	{
		function_637a31ed(localclientnum, level._effect[#"hash_390d70fef1885250"], "chin", "j_head");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 16))
	{
		function_637a31ed(localclientnum, level._effect[#"hash_57c210bb97cf187c"], "right_arm", "j_elbow_ri");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 32))
	{
		function_637a31ed(localclientnum, level._effect[#"hash_485f1b39da0ca6ca"], "left_arm", "j_elbow_le");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 128))
	{
		function_637a31ed(localclientnum, level._effect[#"hash_3cf697eb0a408b2e"], "right_leg", "j_knee_ri");
	}
	if(!self gibclientutils::isgibbed(localclientnum, self, 256))
	{
		function_637a31ed(localclientnum, level._effect[#"hash_211384df1c05676c"], "left_leg", "j_knee_le");
	}
}

/*
	Name: function_637a31ed
	Namespace: namespace_93a948d8
	Checksum: 0x29C6BA49
	Offset: 0x12F8
	Size: 0x58
	Parameters: 4
	Flags: Linked
*/
function function_637a31ed(localclientnum, fx, key, tag)
{
	self.var_dc23481f[localclientnum][key] = util::playfxontag(localclientnum, fx, self, tag);
}

/*
	Name: function_9babbcd9
	Namespace: namespace_93a948d8
	Checksum: 0x782C64FA
	Offset: 0x1358
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_9babbcd9(localclientnum)
{
	self endon(#"death");
	if(isdefined(self.var_dc23481f) && isdefined(self.var_dc23481f[localclientnum]))
	{
		keys = getarraykeys(self.var_dc23481f[localclientnum]);
		for(i = 0; i < keys.size; i++)
		{
			function_90674103(localclientnum, keys[i]);
		}
		self.var_dc23481f[localclientnum] = undefined;
	}
}

/*
	Name: function_90674103
	Namespace: namespace_93a948d8
	Checksum: 0xCA9CD2AA
	Offset: 0x1420
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_90674103(localclientnum, key)
{
	deletefx(localclientnum, self.var_dc23481f[localclientnum][key]);
}

/*
	Name: function_f0236487
	Namespace: namespace_93a948d8
	Checksum: 0xADCE3459
	Offset: 0x1468
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_f0236487(localclientnum)
{
	function_3ab6779c(localclientnum, 0);
}

/*
	Name: function_3b6be5ed
	Namespace: namespace_93a948d8
	Checksum: 0xB8CBDB68
	Offset: 0x1498
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_3b6be5ed(localclientnum)
{
	function_3ab6779c(localclientnum, 1);
}

/*
	Name: function_91bb8595
	Namespace: namespace_93a948d8
	Checksum: 0x53D7C4BF
	Offset: 0x14C8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_91bb8595(var_32a420b0)
{
	start_pos = self.origin;
	force = vectornormalize(var_32a420b0 - start_pos);
	force = force + (0, 0, randomfloatrange(0.4, 0.6));
	force = force * randomfloatrange(0.8, 1.2);
	return force;
}

/*
	Name: function_3ab6779c
	Namespace: namespace_93a948d8
	Checksum: 0x7211C520
	Offset: 0x1578
	Size: 0xC4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3ab6779c(localclientnum, var_44146a38)
{
	if(util::is_mature())
	{
		function_c4fded40(localclientnum, "j_elbow_ri", 16, var_44146a38);
		function_c4fded40(localclientnum, "j_elbow_le", 32, var_44146a38);
		function_c4fded40(localclientnum, "j_knee_ri", 128, var_44146a38);
		function_c4fded40(localclientnum, "j_knee_le", 256, var_44146a38);
		self hide();
	}
}

/*
	Name: function_3386e437
	Namespace: namespace_93a948d8
	Checksum: 0x62840936
	Offset: 0x1648
	Size: 0x19E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3386e437(gibflag)
{
	var_a1a553e5 = undefined;
	if(isdefined(self.archetype) && self.archetype == #"nova_crawler")
	{
		switch(gibflag)
		{
			case 16:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_quadcrawler_s_rarmspawn";
				break;
			}
			case 32:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_quadcrawler_s_larmspawn";
				break;
			}
			case 128:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_quadcrawler_s_rlegspawn";
				break;
			}
			case 256:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_quadcrawler_s_llegspawn";
				break;
			}
			default:
			{
				break;
			}
		}
	}
	else
	{
		switch(gibflag)
		{
			case 16:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_zombie_male_s_rarmoff";
				break;
			}
			case 32:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_zombie_male_s_larmoff";
				break;
			}
			case 128:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_zombie_male_s_rlegoff";
				break;
			}
			case 256:
			{
				var_a1a553e5 = "c_t8_zmb_ofc_zombie_male_s_llegoff";
				break;
			}
			default:
			{
				break;
			}
		}
	}
	return var_a1a553e5;
}

/*
	Name: function_c4fded40
	Namespace: namespace_93a948d8
	Checksum: 0xCACC6A16
	Offset: 0x17F0
	Size: 0x134
	Parameters: 4
	Flags: Linked, Private
*/
private function function_c4fded40(localclientnum, tag_name, gibflag, var_44146a38)
{
	var_32a420b0 = self gettagorigin(tag_name);
	if(!self gibclientutils::isgibbed(localclientnum, self, gibflag) && isdefined(var_32a420b0))
	{
		var_91b70bd5 = self gettagangles(tag_name);
		var_481f0c84 = (var_44146a38 ? function_91bb8595(var_32a420b0) : (0, 0, 0));
		var_a1a553e5 = function_3386e437(gibflag);
		if(isdefined(var_a1a553e5))
		{
			createdynentandlaunch(localclientnum, var_a1a553e5, var_32a420b0, var_91b70bd5, var_32a420b0, var_481f0c84, level._effect[#"hash_3864bbc0912cb852"], 1);
		}
	}
}

/*
	Name: function_3b23bb2f
	Namespace: namespace_93a948d8
	Checksum: 0xB9D0ABAA
	Offset: 0x1930
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_3b23bb2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071("rob_tricannon_classified_zombie_ice");
	}
	else
	{
		self function_5d482e78("rob_tricannon_classified_zombie_ice");
	}
}

