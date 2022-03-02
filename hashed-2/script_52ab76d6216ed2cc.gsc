// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\water_surface.csc;
#using scripts\zm_common\zm_powerups.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_74905749;

/*
	Name: init
	Namespace: namespace_74905749
	Checksum: 0xB69F00EA
	Offset: 0x1E8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	init_flags();
	init_fx();
	function_91be5845();
}

/*
	Name: init_clientfields
	Namespace: namespace_74905749
	Checksum: 0xFE08CC6E
	Offset: 0x238
	Size: 0x8CC
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int", &function_503f6096, 0, 0);
	clientfield::register("scriptmover", "" + #"land_fx", 1, 1, "int", &function_48719840, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1f082a274b1fb6e8", 1, 1, "int", &function_92436a06, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_599b6bf8d2df1c68", 1, getminbitcountfornum(9), "int", &function_e7c0fb8c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4b07b3e5d4729ba", 1, getminbitcountfornum(9), "int", &function_ab685dea, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3ce85d1dce53873e", 1, 1, "int", &function_14dcccc6, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4e114afae67f749f", 1, 1, "int", &function_b59986cf, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3400ccffbd3d73b3", 1, 2, "int", &function_49661954, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_15b23de7589e61a", 1, 1, "int", &function_25a6443, 0, 0);
	clientfield::register("scriptmover", "" + #"blocker_fx", 1, 1, "int", &function_74e395f7, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_68e2384b254175da", 1, 1, "counter", &function_9a686624, 0, 0);
	clientfield::register("scriptmover", "" + #"pipe_fx", 1, 2, "int", &pipe_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4ddbb35b49d9bb61", 1, 1, "int", &function_a0798cf4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_46e2ed49fb0f55c6", 1, 1, "int", &function_9f92e675, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_60291a1e604377a9", 1, 1, "int", &function_2d798d9a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6e41de51a0092771", 1, 1, "int", &function_dd0c6ccb, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_53c7d27cc9130e8f", 1, getminbitcountfornum(4), "int", &function_33aa16f0, 0, 0);
	clientfield::register("toplayer", "" + #"boiler_fx", 1, 1, "int", &function_d592393d, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2bde374c37c3f679", 1, 1, "int", &function_94822f89, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7e72564bf065f2df", 1, 1, "int", &function_ac4395b, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7a927551ca199a1c", 1, 1, "counter", &function_9491a41e, 0, 0);
	clientfield::register("toplayer", "" + #"hash_77165188f21e5ca0", 1, 1, "int", &function_c6880d07, 0, 0);
	clientfield::register("toplayer", "" + #"hash_58b44c320123e829", 1, 1, "int", &function_1697bc59, 0, 0);
	clientfield::register("toplayer", "" + #"hash_6f4c448cda667cc8", 1, 1, "int", &function_eacfeb8, 0, 0);
	clientfield::register("vehicle", "" + #"orb_fx", 1, 1, "int", &function_57196646, 0, 0);
}

/*
	Name: init_flags
	Namespace: namespace_74905749
	Checksum: 0x80F724D1
	Offset: 0xB10
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
}

/*
	Name: init_fx
	Namespace: namespace_74905749
	Checksum: 0x4A86F69D
	Offset: 0xB20
	Size: 0x9F2
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_2e7f9a3bff90af4a"] = #"hash_7b0d80c48289dd0b";
	level._effect[#"hash_573af1567956ac69"] = #"hash_661da9149933ecf9";
	level._effect[#"hash_538a9337bb9927da"] = #"zm_ai/fx8_cata_elec_aura";
	level._effect[#"hash_3dba8e7d212e4382"] = #"hash_641c2257723638c2";
	level._effect[#"hash_59916e76378fa3d8"] = #"hash_62eafc17a432322a";
	level._effect[#"hash_1e6b4bfa36f9487b"] = #"hash_1832a0ef5af0040d";
	level._effect[#"hash_4b9011909a431ac8"] = #"hash_619361bb6a9a5d2d";
	level._effect[#"hash_50a595992ac285d0"] = #"hash_3009e42178ffd484";
	level._effect[#"hash_4ab2496c89a7d871"] = #"hash_4a305119bc50ca3d";
	level._effect[#"hash_4c972c53bdb84540"] = #"zombie/fx_ritual_glow_relic_zod_zmb";
	level._effect[#"hash_5d6a93a7922b821b"] = #"hash_5b773dbbac0012ff";
	level._effect[#"hash_4e794284db75a3f5"] = #"hash_3def678deb7f4078";
	level._effect[#"sentinel_activate"] = #"hash_464f27bfbf0ce7bf";
	level._effect[#"hash_2b40b14fc8577053"] = #"hash_41b2c270f26faabc";
	level._effect[#"hash_51b3154a00c79a96"] = #"hash_55ea6f0ddba66d44";
	level._effect[#"hash_4725bfd390369cc6"] = #"hash_69afd734b3a42e4";
	level._effect[#"hash_1f313271f8982c73"] = #"hash_3f6350484ab2986b";
	level._effect[#"hash_778e13d419e6244c"] = #"hash_ae75b80f4484d6a";
	level._effect[#"hash_47bfdf8ef26cf09e"] = #"hash_53011431a4abc4d0";
	level._effect[#"hash_3e85368d0aae4e37"] = #"hash_7ff11c8ee1217d6f";
	level._effect[#"hash_53e257eb5e950096"] = #"hash_22922c09fc971250";
	level._effect[#"hash_28ae96e5e5900d42"] = #"hash_74fd337197b421f8";
	level._effect[#"glyph_activate"] = #"hash_6a4db7ffc84cf7fc";
	level._effect[#"orb_trail"] = #"hash_6d900123df67f4ce";
	level._effect[#"hash_503bcedb83031e6b"] = #"hash_2aac2efa85bfb786";
	level._effect[#"hash_2dd4629ae81753e5"] = #"hash_203548b984de70a4";
	level._effect[#"hash_23c18b717592a89d"] = #"hash_43cec289a09441e9";
	level._effect[#"hash_2bb182b164a2d789"] = #"hash_71fc8c15d53b5fe2";
	level._effect[#"hash_4274dc30c3876166"] = #"hash_2f27882b95a820fd";
	level._effect[#"hash_5db2fc2462df751d"] = #"hash_55a1d3ce6c554a7a";
	level._effect[#"hash_53533bf74eb74209"] = #"hash_2909be1122353509";
	level._effect[#"hash_535338f74eb73cf0"] = #"hash_28b4c41121ecff3c";
	level._effect[#"hash_452505f92d084e74"] = #"hash_7fb7de4ea65f1b9d";
	level._effect[#"hash_6160e75bd4d4852"] = #"hash_369788360ca4879d";
	level._effect[#"hash_3316f2b0a2dcecda"] = #"hash_56e16e07d428fead";
	level._effect[#"hash_5cdecfbbde808a22"] = #"hash_d778729ca762c5a";
	level._effect[#"hash_65dea9072b2e59ab"] = #"hash_618dd5f64c043c98";
	level._effect[#"hash_2bc90d4640220149"] = #"hash_c02fd55105bf590";
	level._effect[#"hash_1aba0de61c3cec7a"] = #"hash_28b92cc776e22757";
	level._effect[#"hash_75064604c0377403"] = #"hash_7f0ec9b1b2e75c04";
	level._effect[#"hash_4fc3dd13e23cd08f"] = #"hash_1a3f1102ecab4c66";
	level._effect[#"hash_473f56cfe6464b13"] = #"hash_762bfc3142f1039c";
	level._effect[#"hash_2273f55210ee77b3"] = #"hash_68cc20f5cb8f2474";
	level._effect[#"hash_5bf3ead674380860"] = #"hash_7d600aa6483d645b";
	level._effect[#"hash_4ada101428781d93"] = #"hash_7111a6031de7ead2";
	level._effect[#"hash_5c7f484e340fdde6"] = #"hash_728126700110e700";
	level._effect[#"hash_331f4a597e6c0189"] = #"hash_1899ecdfcd7daa00";
	level._effect[#"hash_345b045ea57a58e8"] = #"hash_231dd4d8a69cc3b2";
	level._effect[#"sigil_on"] = #"hash_454a052cba35b654";
	level._effect[#"sigil_off"] = #"hash_22f995964a88d0e0";
	level._effect[#"tree_impact"] = #"hash_39b325729fc733ae";
	level._effect[#"tree_trail"] = #"hash_4d7b9b72e10c3737";
	level._effect[#"tree_activate"] = #"hash_6776cc88134ba740";
}

/*
	Name: function_91be5845
	Namespace: namespace_74905749
	Checksum: 0xB727E42F
	Offset: 0x1520
	Size: 0x344
	Parameters: 0
	Flags: Linked
*/
function function_91be5845()
{
	namespace_617a54f4::function_d8383812(#"hash_41a5c5168ffb2a97", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_2e7f9a3bff90af4a"], level._effect[#"hash_59916e76378fa3d8"], undefined, &function_7729e81c);
	namespace_617a54f4::function_d8383812(#"hash_400a481490a4e390", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_573af1567956ac69"], level._effect[#"hash_1e6b4bfa36f9487b"], undefined, &function_7729e81c);
	namespace_617a54f4::function_d8383812(#"hash_5562e324d230f057", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_538a9337bb9927da"], level._effect[#"hash_4b9011909a431ac8"], undefined, &function_7729e81c);
	namespace_617a54f4::function_d8383812(#"hash_41fae186552f1259", 1, #"hash_3d7f94e7862a63ab", 50, level._effect[#"hash_3dba8e7d212e4382"], level._effect[#"hash_50a595992ac285d0"], undefined, &function_7729e81c);
	namespace_617a54f4::function_d8383812(#"hash_7182a46bb3cdf577", 1, #"hash_7182a46bb3cdf577", 111, level._effect[#"hash_2e7f9a3bff90af4a"], level._effect[#"hash_59916e76378fa3d8"], undefined);
	namespace_617a54f4::function_d8383812(#"hash_466c2764cc790370", 1, #"hash_466c2764cc790370", 111, level._effect[#"hash_573af1567956ac69"], level._effect[#"hash_1e6b4bfa36f9487b"], undefined);
	namespace_617a54f4::function_d8383812(#"hash_34f2b4c4f7d74137", 1, #"hash_34f2b4c4f7d74137", 111, level._effect[#"hash_538a9337bb9927da"], level._effect[#"hash_4b9011909a431ac8"], undefined);
	namespace_617a54f4::function_d8383812(#"hash_49ad34a64ecaebb9", 1, #"hash_49ad34a64ecaebb9", 111, level._effect[#"hash_3dba8e7d212e4382"], level._effect[#"hash_50a595992ac285d0"], undefined);
}

/*
	Name: function_7729e81c
	Namespace: namespace_74905749
	Checksum: 0x5D153DA3
	Offset: 0x1870
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function function_7729e81c(localclientnum, def, s_capture_point)
{
}

/*
	Name: function_33aa16f0
	Namespace: namespace_74905749
	Checksum: 0x208F7165
	Offset: 0x1898
	Size: 0x124
	Parameters: 7
	Flags: Linked
*/
function function_33aa16f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			str_fx = #"hash_2e7f9a3bff90af4a";
			break;
		}
		case 2:
		{
			str_fx = #"hash_573af1567956ac69";
			break;
		}
		case 3:
		{
			str_fx = #"hash_538a9337bb9927da";
			break;
		}
		case 4:
		{
			str_fx = #"hash_3dba8e7d212e4382";
			break;
		}
	}
	util::playfxontag(localclientnum, level._effect[str_fx], self, "tag_fx_x_pos");
}

/*
	Name: function_dd0c6ccb
	Namespace: namespace_74905749
	Checksum: 0xB85D1915
	Offset: 0x19C8
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_dd0c6ccb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071("rob_zod_vista_light_fade");
	}
	else
	{
		self function_5d482e78("rob_zod_vista_light_fade");
	}
}

/*
	Name: function_ab685dea
	Namespace: namespace_74905749
	Checksum: 0x15C4350F
	Offset: 0x1A58
	Size: 0x202
	Parameters: 7
	Flags: Linked
*/
function function_ab685dea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			str_fx = level._effect[#"hash_3e85368d0aae4e37"];
			break;
		}
		case 2:
		{
			str_fx = level._effect[#"hash_47bfdf8ef26cf09e"];
			break;
		}
		case 3:
		{
			str_fx = level._effect[#"hash_53e257eb5e950096"];
			break;
		}
		case 5:
		{
			str_fx = level._effect[#"hash_778e13d419e6244c"];
			break;
		}
		case 6:
		{
			str_fx = level._effect[#"hash_51b3154a00c79a96"];
			break;
		}
		case 7:
		{
			str_fx = level._effect[#"hash_4725bfd390369cc6"];
			break;
		}
		case 8:
		{
			str_fx = level._effect[#"hash_1f313271f8982c73"];
			break;
		}
		case 9:
		{
			str_fx = level._effect[#"hash_28ae96e5e5900d42"];
			break;
		}
	}
	if(isdefined(str_fx))
	{
		self.var_ed5e3059 = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
	}
}

/*
	Name: function_eacfeb8
	Namespace: namespace_74905749
	Checksum: 0xE20AEBE3
	Offset: 0x1C68
	Size: 0x13C
	Parameters: 7
	Flags: Linked
*/
function function_eacfeb8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify("28d26c912677b144");
	self endon("28d26c912677b144");
	if(newval)
	{
		while(true)
		{
			if(isalive(self) && self util::function_50ed1561(localclientnum))
			{
				self.var_77f256b5 = playfxoncamera(localclientnum, level._effect[#"hash_5cdecfbbde808a22"], undefined, anglestoforward(self.angles), anglestoup(self.angles));
			}
			wait(0.25);
		}
	}
	else if(isdefined(self.var_77f256b5))
	{
		stopfx(localclientnum, self.var_77f256b5);
	}
}

/*
	Name: function_2d798d9a
	Namespace: namespace_74905749
	Checksum: 0x2C132C70
	Offset: 0x1DB0
	Size: 0x172
	Parameters: 7
	Flags: Linked
*/
function function_2d798d9a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self util::waittill_dobj(localclientnum);
		while(isdefined(self))
		{
			var_5a5f5d36 = randomintrange(-64, 64);
			var_4cf7f9d1 = randomintrange(-64, 64);
			var_c53a4cdc = randomintrange(-64, 64);
			self moveto(self.origin + (var_5a5f5d36, var_4cf7f9d1, var_c53a4cdc), randomintrange(10, 20));
			s_result = undefined;
			s_result = self waittill(#"movedone", #"death");
			if(s_result._notify == "death")
			{
				return;
			}
		}
	}
}

/*
	Name: function_1697bc59
	Namespace: namespace_74905749
	Checksum: 0xD3E81C66
	Offset: 0x1F30
	Size: 0x236
	Parameters: 7
	Flags: Linked
*/
function function_1697bc59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		a_s_locs = struct::get_array(#"hash_7cfdc1f7a70901f5");
		foreach(s_loc in a_s_locs)
		{
			n_x_offset = randomintrange(-32, 32);
			n_y_offset = randomintrange(-32, 32);
			physicsexplosionsphere(localclientnum, s_loc.origin + (n_x_offset, n_y_offset, 32), 64, 32, 0.15, undefined, undefined, 1, 1, 1);
			waitframe(1);
		}
		s_loc = struct::get(#"hash_1f307b5cf6d83aff");
		n_z_offset = 400;
		while(level flag::get(#"hash_13dc8f128d50bada"))
		{
			physicsexplosionsphere(localclientnum, s_loc.origin + (0, 0, n_z_offset), 3200, 32, 0.1, undefined, undefined, 1, 1, 1);
			wait(randomintrange(3, 6));
			n_z_offset = n_z_offset * -1;
		}
	}
}

/*
	Name: function_89ecbecc
	Namespace: namespace_74905749
	Checksum: 0xD54EB1AF
	Offset: 0x2170
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_89ecbecc(localclientnum)
{
	self endon(#"hash_6dfb95cf5dcbfbb5");
	waitframe(1);
	while(isalive(self))
	{
		n_speed = self getspeed();
		if(n_speed > 64)
		{
			n_radius = max(64, n_speed * 0.7);
		}
		else
		{
			n_radius = 64;
		}
		n_magnitude = n_radius / 80;
		physicsexplosionsphere(localclientnum, self geteye(), n_radius, n_radius, n_magnitude);
		waitframe(1);
	}
}

/*
	Name: function_c6880d07
	Namespace: namespace_74905749
	Checksum: 0x2E088DCE
	Offset: 0x2270
	Size: 0x28C
	Parameters: 7
	Flags: Linked
*/
function function_c6880d07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"underwaterwatchbegin");
	self endon(#"death");
	if(newval)
	{
		self thread function_89ecbecc(localclientnum);
		level flag::set(#"hash_13dc8f128d50bada");
		function_a1c09ed(-800 * vectorscale((0, 0, 1), 0.005));
		self thread function_9ecc1074(localclientnum);
		self notify(#"hash_6aa4f28f27ab4c64");
		do
		{
			waitframe(1);
		}
		while(self postfx::function_556665f2(#"pstfx_zm_wormhole"));
		n_val = 0.1;
		self thread postfx::playpostfxbundle(#"pstfx_frost_loop");
		while(n_val <= 0.33)
		{
			self function_116b95e5(#"pstfx_frost_loop", "Reveal Threshold", n_val);
			wait(0.25);
			n_val = n_val + 0.01;
		}
	}
	else
	{
		function_a1c09ed(-800 * (0, 0, 1));
		level flag::clear(#"hash_13dc8f128d50bada");
		self notify(#"hash_6dfb95cf5dcbfbb5");
		if(self util::function_50ed1561(localclientnum))
		{
			if(isdefined(self.firstperson_water_fx))
			{
				stopfx(localclientnum, self.firstperson_water_fx);
				self.firstperson_water_fx = undefined;
			}
			self thread water_surface::underwaterwatchbegin();
		}
		self postfx::stoppostfxbundle(#"pstfx_frost_loop");
	}
}

/*
	Name: function_9ecc1074
	Namespace: namespace_74905749
	Checksum: 0x953AD43A
	Offset: 0x2508
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function function_9ecc1074(localclientnum)
{
	self endon(#"underwaterwatchbegin");
	s_result = undefined;
	s_result = self waittill(#"underwater_begin", #"death");
	if(s_result._notify == "underwater_begin")
	{
		while(isalive(self))
		{
			if(self util::function_50ed1561(localclientnum))
			{
				self.var_733dd716 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
			}
			wait(randomintrange(15, 20));
		}
	}
}

/*
	Name: function_9491a41e
	Namespace: namespace_74905749
	Checksum: 0xCD4C9917
	Offset: 0x2610
	Size: 0xB0
	Parameters: 7
	Flags: Linked
*/
function function_9491a41e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!self postfx::function_556665f2(#"pstfx_frost_loop"))
	{
		self thread postfx::playpostfxbundle(#"pstfx_frost_loop");
		self thread function_bcb676b9();
		waitframe(1);
	}
	level notify(#"hash_5010527c7518e767");
}

/*
	Name: function_bcb676b9
	Namespace: namespace_74905749
	Checksum: 0x293D4891
	Offset: 0x26C8
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_bcb676b9()
{
	self endon(#"hash_6aa4f28f27ab4c64", #"death");
	n_val = 0.1;
	while(true)
	{
		s_result = undefined;
		s_result = level waittilltimeout(20, #"hash_5010527c7518e767");
		if(isalive(self) && s_result._notify == #"hash_5010527c7518e767")
		{
			self function_116b95e5(#"pstfx_frost_loop", "Reveal Threshold", n_val);
			n_val = n_val + 0.1;
			if(n_val > 1)
			{
				break;
			}
		}
		else
		{
			break;
		}
	}
	waitframe(1);
	n_val = n_val - 0.1;
	while(n_val > 0)
	{
		self function_116b95e5(#"pstfx_frost_loop", "Reveal Threshold", n_val);
		n_val = n_val - 0.1;
		wait(3);
	}
	self postfx::stoppostfxbundle(#"pstfx_frost_loop");
}

/*
	Name: function_a0798cf4
	Namespace: namespace_74905749
	Checksum: 0x92481BC2
	Offset: 0x2858
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_a0798cf4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_2880a6b3))
	{
		killfx(localclientnum, self.var_2880a6b3);
		self.var_2880a6b3 = undefined;
	}
	if(newval == 1)
	{
		self.var_2880a6b3 = playfx(localclientnum, level._effect[#"sigil_off"], self.origin, (1, 0, 0));
	}
	else
	{
		self.var_2880a6b3 = playfx(localclientnum, level._effect[#"sigil_on"], self.origin, (1, 0, 0));
	}
	level thread function_8b8f2a41(localclientnum, self, self.var_2880a6b3);
}

/*
	Name: function_8b8f2a41
	Namespace: namespace_74905749
	Checksum: 0xED95F88C
	Offset: 0x2990
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function function_8b8f2a41(localclientnum, var_96346c22, var_2880a6b3)
{
	self notify("2f09079d0cfe9c7f");
	self endon("2f09079d0cfe9c7f");
	var_96346c22 waittill(#"death");
	if(isdefined(var_2880a6b3))
	{
		killfx(localclientnum, var_2880a6b3);
	}
}

/*
	Name: pipe_fx
	Namespace: namespace_74905749
	Checksum: 0x1B8C4F4E
	Offset: 0x2A08
	Size: 0x20A
	Parameters: 7
	Flags: Linked
*/
function pipe_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_240d8445))
	{
		stopfx(localclientnum, self.var_240d8445);
	}
	if(isdefined(self.var_143576dc))
	{
		self stoploopsound(self.var_143576dc);
	}
	if(newval == 1)
	{
		self.var_240d8445 = util::playfxontag(localclientnum, level._effect[#"hash_5c7f484e340fdde6"], self, "tag_origin");
		self.var_143576dc = self playloopsound(#"hash_1d4b0119c9f1d519");
	}
	else
	{
		if(newval == 2)
		{
			self.var_240d8445 = util::playfxontag(localclientnum, level._effect[#"hash_331f4a597e6c0189"], self, "tag_origin");
			self playsound(localclientnum, #"hash_581cce02962580b7");
			self.var_143576dc = self playloopsound(#"hash_5518d837f78963fc");
		}
		else
		{
			self.var_240d8445 = util::playfxontag(localclientnum, level._effect[#"hash_345b045ea57a58e8"], self, "tag_origin");
			self.var_143576dc = self playloopsound(#"hash_5557e7b7271b8aff");
		}
	}
}

/*
	Name: function_25a6443
	Namespace: namespace_74905749
	Checksum: 0xA61CB5F1
	Offset: 0x2C20
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_25a6443(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(newval == 1)
	{
		self.fx_iceberg = util::playfxontag(localclientnum, level._effect[#"hash_3316f2b0a2dcecda"], self, "tag_origin");
	}
	else if(isdefined(self.fx_iceberg))
	{
		stopfx(localclientnum, self.fx_iceberg);
	}
}

/*
	Name: function_49661954
	Namespace: namespace_74905749
	Checksum: 0xFA529367
	Offset: 0x2D10
	Size: 0x2CC
	Parameters: 7
	Flags: Linked
*/
function function_49661954(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_9176527d = util::playfxontag(localclientnum, level._effect[#"hash_5db2fc2462df751d"], self, "tag_origin");
		self playsound(localclientnum, #"hash_3f083cd717314926");
		if(!isdefined(self.var_dbd58e36))
		{
			self.var_dbd58e36 = self playloopsound(#"hash_cbff0b64fa402d7");
		}
	}
	else
	{
		if(newval == 2)
		{
			self playsound(localclientnum, #"hash_1892310a436314b2");
			util::playfxontag(localclientnum, level._effect[#"hash_53533bf74eb74209"], self, "tag_origin");
		}
		else
		{
			if(newval == 3)
			{
				self playsound(localclientnum, #"hash_1892310a436314b2");
				util::playfxontag(localclientnum, level._effect[#"hash_535338f74eb73cf0"], self, "tag_origin");
			}
			else
			{
				if(isdefined(self.var_9176527d))
				{
					killfx(localclientnum, self.var_9176527d);
					self.var_9176527d = undefined;
				}
				if(isdefined(self.var_dbd58e36))
				{
					self stoploopsound(self.var_dbd58e36);
				}
				self playsound(localclientnum, #"hash_28d76e47e3d57bf6");
				util::playfxontag(localclientnum, level._effect[#"hash_535338f74eb73cf0"], self, "tag_origin");
				util::playfxontag(localclientnum, level._effect[#"hash_452505f92d084e74"], self, "tag_origin");
			}
		}
	}
}

/*
	Name: function_94822f89
	Namespace: namespace_74905749
	Checksum: 0x6E21F28F
	Offset: 0x2FE8
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_94822f89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle("pstfx_zodt8_screenflash");
	}
	else
	{
		self thread postfx::stoppostfxbundle("pstfx_zodt8_screenflash");
	}
}

/*
	Name: function_ac4395b
	Namespace: namespace_74905749
	Checksum: 0x58A2522E
	Offset: 0x3078
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_ac4395b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, #"hash_67ca45018833af1d");
	}
	else
	{
		self playrumbleonentity(localclientnum, #"hash_55b8ea7312be930e");
	}
}

/*
	Name: function_9a686624
	Namespace: namespace_74905749
	Checksum: 0x6BF2AB46
	Offset: 0x3120
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_9a686624(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		fx = util::playfxontag(localclientnum, level._effect[#"glyph_activate"], self, "tag_origin");
		playsound(localclientnum, #"hash_6dfc68e5f7739824", self.origin);
		wait(3.5);
		if(isdefined(fx))
		{
			stopfx(localclientnum, fx);
		}
	}
}

/*
	Name: function_74e395f7
	Namespace: namespace_74905749
	Checksum: 0xD71E5100
	Offset: 0x3200
	Size: 0x19E
	Parameters: 7
	Flags: Linked
*/
function function_74e395f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_forward = anglestoforward(self.angles);
		self.blocker_fx = playfx(localclientnum, level._effect[#"hash_5d6a93a7922b821b"], self.origin, v_forward);
		if(!isdefined(self.var_99a9007b))
		{
			self playsound(localclientnum, #"hash_2c71df73b17cd28a");
			self.var_99a9007b = self playloopsound(#"hash_7e4a7312ab58161e");
		}
	}
	else
	{
		if(isdefined(self.blocker_fx))
		{
			stopfx(localclientnum, self.blocker_fx);
		}
		if(isdefined(self.var_99a9007b))
		{
			self playsound(localclientnum, #"hash_3366b1b903dc96bf");
			self stoploopsound(self.var_99a9007b);
			self.var_99a9007b = undefined;
		}
	}
}

/*
	Name: function_b59986cf
	Namespace: namespace_74905749
	Checksum: 0x102FCFB9
	Offset: 0x33A8
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_b59986cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_32a8bada = util::playfxontag(localclientnum, level._effect[#"hash_4c972c53bdb84540"], self, "tag_origin");
	}
	else if(isdefined(self.var_32a8bada))
	{
		stopfx(localclientnum, self.var_32a8bada);
		self.var_32a8bada = undefined;
	}
}

/*
	Name: function_d592393d
	Namespace: namespace_74905749
	Checksum: 0x1D4FDB71
	Offset: 0x3470
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function function_d592393d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	b_underwater = self isplayerswimmingunderwater();
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_5513ce472ffeb0f3");
		if(!b_underwater)
		{
			setpbgactivebank(localclientnum, 4);
		}
	}
	else
	{
		if(!b_underwater)
		{
			setpbgactivebank(localclientnum, 1);
		}
		self postfx::stoppostfxbundle(#"hash_5513ce472ffeb0f3");
	}
}

/*
	Name: function_48719840
	Namespace: namespace_74905749
	Checksum: 0xBEC11B8
	Offset: 0x3568
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_48719840(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_23c18b717592a89d"], self, "tag_origin");
		function_36e4ebd4(localclientnum, #"hash_2e8bb4e737eaf9b0");
	}
	else
	{
		playfx(localclientnum, level._effect[#"hash_2bb182b164a2d789"], self.origin);
	}
}

/*
	Name: function_92436a06
	Namespace: namespace_74905749
	Checksum: 0x410FFD36
	Offset: 0x3658
	Size: 0x21E
	Parameters: 7
	Flags: Linked
*/
function function_92436a06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_ed5e3059))
	{
		stopfx(localclientnum, self.var_ed5e3059);
	}
	if(newval == 1)
	{
		self endon(#"death");
		self util::waittill_dobj(localclientnum);
		util::playfxontag(localclientnum, level._effect[#"hash_4274dc30c3876166"], self, "tag_origin");
		if(self.origin[2] < 2000)
		{
			self.var_92d5024f = util::playfxontag(localclientnum, level._effect[#"hash_2dd4629ae81753e5"], self, "tag_origin");
		}
		else
		{
			self.var_92d5024f = util::playfxontag(localclientnum, level._effect[#"hash_503bcedb83031e6b"], self, "tag_origin");
		}
		self.var_ad85891 = util::playfxontag(localclientnum, level._effect[#"orb_trail"], self, "tag_origin");
	}
	else
	{
		if(isdefined(self.var_92d5024f))
		{
			killfx(localclientnum, self.var_92d5024f);
			self.var_92d5024f = undefined;
		}
		if(isdefined(self.var_ad85891))
		{
			killfx(localclientnum, self.var_ad85891);
			self.var_ad85891 = undefined;
		}
	}
}

/*
	Name: function_e7c0fb8c
	Namespace: namespace_74905749
	Checksum: 0x2E130280
	Offset: 0x3880
	Size: 0x2E4
	Parameters: 7
	Flags: Linked
*/
function function_e7c0fb8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_46730a76))
	{
		killfx(localclientnum, self.var_46730a76);
	}
	if(newval == 0)
	{
		playsound(localclientnum, #"hash_5dea4034a9243dbc", self.origin);
		return;
	}
	switch(newval)
	{
		case 1:
		{
			str_fx = #"hash_5bf3ead674380860";
			break;
		}
		case 2:
		{
			str_fx = #"hash_2273f55210ee77b3";
			break;
		}
		case 3:
		{
			str_fx = #"hash_473f56cfe6464b13";
			break;
		}
		case 4:
		{
			str_fx = #"hash_4ada101428781d93";
			break;
		}
		case 5:
		{
			str_fx = #"hash_4fc3dd13e23cd08f";
			break;
		}
		case 6:
		{
			str_fx = #"hash_65dea9072b2e59ab";
			break;
		}
		case 7:
		{
			str_fx = #"hash_2bc90d4640220149";
			break;
		}
		case 8:
		{
			str_fx = #"hash_1aba0de61c3cec7a";
			break;
		}
		case 9:
		{
			str_fx = #"hash_75064604c0377403";
			break;
		}
	}
	str_tag = struct::get(str_fx).str_tag_name;
	self.var_46730a76 = util::playfxontag(localclientnum, level._effect[str_fx], self, str_tag);
	if(newval == 1)
	{
		playsound(localclientnum, #"hash_5b84a753cb771ae0", self.origin);
	}
	else
	{
		playsound(localclientnum, #"hash_6be991aa330022ca", self.origin);
	}
}

/*
	Name: function_14dcccc6
	Namespace: namespace_74905749
	Checksum: 0x9CD1CA03
	Offset: 0x3B70
	Size: 0x1E4
	Parameters: 7
	Flags: Linked
*/
function function_14dcccc6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"hash_628b6c90517cab87");
	n_pulse = 0.4;
	while(isdefined(self))
	{
		n_cycle_time = randomfloatrange(2, 8);
		n_pulse_increment = (1 - 0.4) / (n_cycle_time / 0.1);
		while(n_pulse < 1 && isdefined(self))
		{
			self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
			n_pulse = n_pulse + n_pulse_increment;
			wait(0.1);
		}
		n_cycle_time = randomfloatrange(2, 8);
		n_pulse_increment = (1 - 0.4) / (n_cycle_time / 0.1);
		while(0.4 < n_pulse && isdefined(self))
		{
			self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
			n_pulse = n_pulse - n_pulse_increment;
			wait(0.1);
		}
	}
}

/*
	Name: function_9f92e675
	Namespace: namespace_74905749
	Checksum: 0x6C57A3E9
	Offset: 0x3D60
	Size: 0x168
	Parameters: 7
	Flags: Linked
*/
function function_9f92e675(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify("43af242cd886e3af");
	self endon("43af242cd886e3af");
	self endon(#"death");
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"tree_activate"], self, "tag_origin");
		self playsound(localclientnum, #"hash_35bdc93fbbad3294");
		self.var_3765ceb0 = self playloopsound(#"hash_453bd80432d8f383");
		wait(0.25);
		while(isdefined(self))
		{
			physicsexplosionsphere(localclientnum, self.origin, 3000, 1, 4, 1, 1, 1, 1, 1);
			waitframe(randomintrange(5, 10));
		}
	}
}

/*
	Name: function_57196646
	Namespace: namespace_74905749
	Checksum: 0x45B66331
	Offset: 0x3ED0
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_57196646(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"tree_trail"], self, "tag_origin");
		self playsound(localclientnum, #"hash_c5737dedcdad3a8");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"tree_impact"], self, "tag_origin");
		self playsound(localclientnum, #"hash_3d9dcef3d979480b");
		function_36e4ebd4(localclientnum, #"hash_2e8bb4e737eaf9b0");
	}
}

/*
	Name: function_503f6096
	Namespace: namespace_74905749
	Checksum: 0x8CF79EE
	Offset: 0x4010
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_503f6096(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "ee_space");
	}
	else
	{
		function_73b1f242(localclientnum, "ee_space");
	}
}

