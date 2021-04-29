// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_31903fa50a95575;
#using script_70ab01a7690ea256;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_blockers.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_31170709;

/*
	Name: init
	Namespace: namespace_31170709
	Checksum: 0x6A0E5AE5
	Offset: 0x2B8
	Size: 0x1F02
	Parameters: 0
	Flags: Linked
*/
function init()
{
	var_7551dff2 = getminbitcountfornum(4);
	var_b7863a03 = getminbitcountfornum(3);
	clientfield::register("allplayers", "" + #"hash_72bd7a6af2ba1c5e", 16000, 1, "int", &function_d087b08c, 0, 1);
	clientfield::register("allplayers", "" + #"hash_4a149c9daff159cd", 16000, 1, "int", &function_d02ccc7c, 0, 1);
	clientfield::register("toplayer", "" + #"hash_7343b1cdab1f31c5", 16000, 1, "counter", &function_3d3614aa, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2a17f2993036fab4", 16000, 1, "counter", &function_6a9e68bf, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1af6f489b6868e7a", 16000, 1, "int", &function_659d8180, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3cc2dfd1a3c36ae3", 16000, var_7551dff2, "int", &function_d55ae74b, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_78fa79d021d86cb6", 16000, 1, "int", &function_27f4136d, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4f90c0f4c5bc1c42", 16000, 1, "int", &function_31d064c0, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_784f06b253332f8f", 16000, 1, "counter", &function_148f3698, 0, 0);
	clientfield::register("toplayer", "" + #"hash_491027931a3fc18f", 16000, 1, "int", &function_efc5ca9d, 0, 0);
	clientfield::register("world", "" + #"hash_682b7b65432b7746", 16000, var_b7863a03, "int", &function_fb3b37f4, 0, 0);
	clientfield::register("toplayer", "" + #"hash_214549d33d068451", 16000, 1, "counter", &function_405ead09, 0, 0);
	clientfield::register("world", "" + #"hash_51858e923e750c33", 16000, 2, "int", &function_8d3c45d8, 0, 0);
	clientfield::register("world", "" + #"hash_2b05d4c6217bac22", 16000, 2, "int", &function_e8ce5b81, 0, 0);
	clientfield::register("world", "" + #"hash_3836d3a94cf05642", 16000, 2, "int", &function_5dbd965d, 0, 0);
	clientfield::register("world", "" + #"hash_53e684a319647b40", 16000, 2, "int", &function_89251662, 0, 0);
	clientfield::register("world", "" + #"hash_70e157c389c1c02f", 16000, 1, "int", &function_4e17725a, 0, 0);
	clientfield::register("world", "" + #"hash_4f59799617fef9c7", 16000, 1, "int", &function_ab5633d2, 0, 0);
	clientfield::register("world", "" + #"hash_31a10d565ae05ddb", 16000, 2, "int", &function_1935c66a, 0, 0);
	clientfield::register("world", "" + #"hash_1c97c11fb59eb4bf", 16000, 2, "int", &function_dee06e64, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_797e7381ba62ff8a", 16000, 1, "counter", &function_d7aac18b, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_30660c47aae060a9", 16000, 1, "int", &function_138c09b6, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_22acf133b0aa208a", 16000, 1, "int", &function_9dbc7c12, 0, 0);
	clientfield::register("world", "" + #"hash_530e1caa1a8c81d2", 16000, 1, "counter", &function_613a43b6, 0, 0);
	clientfield::register("toplayer", "" + #"hash_11480c2b11f0c92f", 16000, 1, "counter", &function_b1017eda, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6d76e4b7a31537af", 16000, 1, "int", &function_ddf8e6d7, 0, 0);
	clientfield::register("world", "" + #"hash_4d77ba61cd7f3eb7", 16000, 1, "counter", &function_81289c69, 0, 0);
	clientfield::register("world", "" + #"hash_43972920fa314daa", 16000, 2, "int", &function_73a5ca1a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_25cfe5e9786d97e7", 16000, 1, "int", &function_4d61e8ab, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_125706eb7b363924", 16000, 1, "int", &function_c6c41fb1, 0, 0);
	clientfield::register("vehicle", "" + #"hash_7fc7f7b5958831d4", 16000, 1, "int", &function_ad6b5484, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_431f319e4b8fe9db", 16000, 1, "int", &function_f3c6c429, 0, 0);
	clientfield::register("world", "" + #"hash_158233cdc645bef6", 16000, 1, "int", &function_6fd9deaa, 0, 0);
	clientfield::register("toplayer", "" + #"hash_492a33037a532fe0", 16000, 1, "counter", &function_6d38ea52, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4aeb7fcdd8302eaa", 16000, 1, "int", &function_70e5b4bd, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7a99ff005314c5fc", 16000, 1, "int", &function_f648d45a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7f85dc0ce20a6f2c", 16000, 1, "int", &function_40cc4833, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4e3e66f200f76f34", 16000, 1, "int", &function_83c7dece, 0, 0);
	clientfield::register("toplayer", "" + #"hash_565ca9982285f23e", 16000, 1, "int", &function_530c191c, 0, 0);
	clientfield::register("actor", "" + #"hash_415416bf220de94", 16000, 1, "int", &function_cb766634, 0, 0);
	clientfield::register("actor", "" + #"hash_3e2b1092de25c2dd", 16000, 1, "int", &function_3e4aa1cc, 0, 0);
	clientfield::register("actor", "" + #"hash_24b5302c2f39ebc2", 16000, 1, "int", &function_fac1b5c7, 0, 0);
	clientfield::register("actor", "" + #"hash_6a8479b5a5b359a7", 16000, 1, "int", &function_106dc737, 0, 0);
	clientfield::register("actor", "" + #"hash_4feb66128e57d092", 16000, 1, "int", &function_343099ca, 0, 0);
	clientfield::register("actor", "" + #"hash_7552d5567ab25417", 16000, 1, "int", &function_c5443282, 0, 0);
	clientfield::register("actor", "" + #"hash_4e1b58f05f69a65a", 16000, 1, "int", &function_f39e44d7, 0, 0);
	clientfield::register("actor", "" + #"hash_5a6761fe764bdccf", 16000, 1, "int", &function_6bd8c915, 0, 0);
	var_ff76a259 = getminbitcountfornum(5);
	clientfield::register("world", "" + #"hash_74aaba5c17a71e0d", 16000, var_ff76a259, "int", &function_af9f249c, 0, 0);
	clientfield::register("world", "" + #"hash_7e49e921c4dd052f", 16000, var_ff76a259, "int", &function_704042f5, 0, 0);
	clientfield::register("world", "" + #"hash_9d4aab5c25b93ff", 16000, var_ff76a259, "int", &function_a1833637, 0, 0);
	clientfield::register("world", "" + #"hash_58e58259618537e7", 16000, var_ff76a259, "int", &function_52659f14, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_155f8a4473c5849f", 16000, 1, "int", &function_3b28f66e, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4400550c9847a1c5", 16000, 1, "int", &function_dc8d97eb, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1f0dd5bf6862e335", 16000, 1, "int", &function_71c2f197, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_ab97fcf2b12187d", 16000, 1, "int", &function_4f14ca28, 0, 0);
	clientfield::register("world", "" + #"hash_d80665c22fafd1e", 16000, 1, "int", &function_141a55a4, 0, 0);
	var_995dd8bf = getminbitcountfornum(9);
	clientfield::register("world", "" + #"hash_516899418a30cd4d", 16000, var_995dd8bf, "int", &function_9a1a1728, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4c6d342dccfd6d73", 16000, 1, "counter", &function_6518ff8d, 0, 0);
	clientfield::register("allplayers", "" + #"hash_67b317587e795ec2", 16000, 1, "int", &function_bb7443e, 0, 0);
	clientfield::register("allplayers", "" + #"hash_10275bcd47e53936", 16000, 1, "int", &function_f5ec271e, 0, 0);
	clientfield::register("toplayer", "" + #"hash_49068d48a9eb7b89", 16000, 2, "int", &function_9b5699b4, 0, 0);
	clientfield::register("world", "" + #"hash_51e28147388ee3d8", 16000, 1, "int", &function_59ea1144, 0, 0);
	clientfield::register("world", "" + #"hash_16e27bea0cc1b56b", 16000, 1, "int", &function_806b16b7, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_297c800c6e18f746", 16000, 1, "int", &function_995ba4d9, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_26ddf1f70bd1f67a", 16000, 1, "int", &function_efb8d988, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_508fc6409c815104", 16000, 1, "counter", &function_842fb5d0, 0, 0);
	clientfield::register("world", "" + #"hash_7525e43acf9ca679", 16000, 1, "int", &function_f800f4d2, 0, 0);
	clientfield::register("world", "" + #"hash_5474fbb93aebbb65", 16000, 1, "int", &function_e6ce9708, 0, 0);
	level._effect[#"hash_7209746af2213da9"] = #"hash_528248a4206b00af";
	level._effect[#"hash_7210806af22770bb"] = #"hash_527b5ca4206503fd";
	level._effect[#"hash_48f9a29daf00294a"] = #"hash_752bfcf80c9da234";
	level._effect[#"hash_48f3969daefba938"] = #"hash_7531e8f80ca1ebe6";
	level._effect[#"hash_2a17f2993036fab4"] = #"hash_6638fd8cf4876df";
	level._effect[#"hash_1af6f489b6868e7a"] = #"hash_7504bcf503817eb2";
	level._effect[#"hash_784f06b253332f8f"] = #"hash_7d24820ee5231fef";
	level._effect[#"hash_797e7381ba62ff8a"] = #"hash_795ee7d89d6f10d2";
	level._effect[#"hash_30660c47aae060a9"] = #"zm_ai/fx8_elec_bolt";
	level._effect[#"hash_22acf133b0aa208a"] = #"hash_4d09e042a77cfba3";
	level._effect[#"hash_530e1caa1a8c81d2"] = #"hash_4bbfe2d612f8393d";
	level._effect[#"hash_6d76e4b7a31537af"] = #"hash_2b71a6c9f08cfe3b";
	level._effect[#"hash_4d77ba61cd7f3eb7"] = #"hash_25c4a39b373bfc67";
	level._effect[#"hash_7fc7f7b5958831d4"] = #"hash_520fd2427c5fcea3";
	level._effect[#"hash_431f319e4b8fe9db"] = #"hash_37bc7da216893b77";
	level._effect[#"hash_415416bf220de94"] = #"hash_7b7ba0ac0755a064";
	level._effect[#"hash_3e2b1092de25c2dd"] = #"hash_318aaa12f9dc7fd4";
	level._effect[#"hash_24b5302c2f39ebc2"] = #"hash_569b6effe4db6f54";
	level._effect[#"hash_6a8479b5a5b359a7"] = #"hash_513bda1b67490064";
	level._effect[#"hash_4feb66128e57d092"] = #"hash_194fead3457d21f5";
	level._effect[#"hash_7552d5567ab25417"] = #"hash_17e9105690c8500d";
	level._effect[#"hash_4e1b58f05f69a65a"] = #"hash_7e9736ee8b5ec443";
	level._effect[#"hash_5a6761fe764bdccf"] = #"hash_72d74d75e679897b";
	level._effect[#"hash_579a1ad0a61119fc"] = #"hash_150e82f10596be24";
	level._effect[#"hash_257185644d8c28b0"] = #"hash_31c3c5542f095358";
	level._effect[#"hash_79910e1d73c43922"] = #"hash_39c7de58cd57bf14";
	level._effect[#"hash_3d71b8c8036f8a4e"] = #"hash_7e78428dbf4099a8";
	level._effect[#"hash_2b1f96b3ed3451d2"] = #"hash_7519a614333f0ab5";
	level._effect[#"hash_1caa39c10fd546be"] = #"hash_3a840f89285e77e9";
	level._effect[#"hash_151f6238e261520a"] = #"hash_2c5e782929758203";
	level._effect[#"hash_5c18b169297a5116"] = #"hash_698145b245c1bff";
	level._effect[#"hash_516899418a30cd4d"] = #"maps/zm_towers/fx8_crowd_reward_flower_exp";
	level._effect[#"hash_4c6d342dccfd6d73"] = #"hash_570e356dcecf7c0f";
	level._effect[#"hash_51e28147388ee3d8"] = #"hash_1ce96a401d67fe8f";
	level._effect[#"hash_297c800c6e18f746"] = #"hash_34fb31ef6c57f845";
	level._effect[#"hash_44330c38e995c437"] = #"hash_5ff2bd993dcf28d3";
	level._effect[#"hash_76947a7b04c592a6"] = #"hash_567c5a1dcc540804";
	level._effect[#"hash_7525e43acf9ca679"] = #"hash_47156cf8a794bef0";
}

/*
	Name: function_8d3c45d8
	Namespace: namespace_31170709
	Checksum: 0x4283E5F
	Offset: 0x21C8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_8d3c45d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"oil");
}

/*
	Name: function_e8ce5b81
	Namespace: namespace_31170709
	Checksum: 0xE7A6091C
	Offset: 0x2238
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_e8ce5b81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"reflect");
}

/*
	Name: function_5dbd965d
	Namespace: namespace_31170709
	Checksum: 0x77675B21
	Offset: 0x22A8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_5dbd965d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"hash_503647be6a449ea");
}

/*
	Name: function_89251662
	Namespace: namespace_31170709
	Checksum: 0xFABA6FF9
	Offset: 0x2318
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_89251662(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"hash_53adf923a9aa1018");
}

/*
	Name: function_4e17725a
	Namespace: namespace_31170709
	Checksum: 0x99A4A2ED
	Offset: 0x2388
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_4e17725a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"hash_162fe3b17b2752e7");
}

/*
	Name: function_ab5633d2
	Namespace: namespace_31170709
	Checksum: 0xBD3D768E
	Offset: 0x23F8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_ab5633d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"light");
}

/*
	Name: function_1935c66a
	Namespace: namespace_31170709
	Checksum: 0x6E616509
	Offset: 0x2468
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_1935c66a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"play");
}

/*
	Name: function_dee06e64
	Namespace: namespace_31170709
	Checksum: 0xD94336AD
	Offset: 0x24D8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_dee06e64(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_70f269cd(localclientnum, newval, #"blood");
}

/*
	Name: function_70f269cd
	Namespace: namespace_31170709
	Checksum: 0xC5B251F4
	Offset: 0x2548
	Size: 0x352
	Parameters: 3
	Flags: Linked
*/
function function_70f269cd(localclientnum, newval, var_de782fc6)
{
	switch(var_de782fc6)
	{
		case "oil":
		{
			a_s_points = function_cc7e9fc3(#"hash_219b4f20890b177b");
			break;
		}
		case "reflect":
		{
			a_s_points = function_cc7e9fc3(#"hash_6ae79ecdde61ddea", #"hash_219b4f20890b177b");
			break;
		}
		case "hash_503647be6a449ea":
		{
			a_s_points = function_cc7e9fc3(#"hash_64f85050330547ca", #"hash_6ae79ecdde61ddea");
			break;
		}
		case "hash_53adf923a9aa1018":
		{
			a_s_points = function_cc7e9fc3(#"hash_218b3395cd5cfd78", #"hash_6ae79ecdde61ddea");
			break;
		}
		case "hash_162fe3b17b2752e7":
		{
			a_s_points = function_cc7e9fc3(#"hash_215626beb36c1b07", #"hash_64f85050330547ca");
			break;
		}
		case "light":
		{
			a_s_points = function_cc7e9fc3(#"hash_20ba31ada21bdeaf", #"hash_218b3395cd5cfd78");
			break;
		}
		case "play":
		{
			a_s_points = function_cc7e9fc3(#"hash_30d4d7a6ef033383");
			break;
		}
		case "blood":
		{
			a_s_points = function_cc7e9fc3(#"hash_196c59af72f28307", #"hash_30d4d7a6ef033383");
			break;
		}
	}
	switch(newval)
	{
		case 0:
		{
			function_ed4ed5e(localclientnum, var_de782fc6);
			break;
		}
		case 1:
		{
			function_77072f95(localclientnum, var_de782fc6, a_s_points);
			break;
		}
		case 2:
		{
			if(var_de782fc6 == #"blood")
			{
				s_final = struct::get(#"hash_74c74fa352fbfa70");
				a_s_points[a_s_points.size - 1] = s_final;
			}
			function_c6f495b3(localclientnum, var_de782fc6, a_s_points);
			break;
		}
	}
}

/*
	Name: function_cc7e9fc3
	Namespace: namespace_31170709
	Checksum: 0x85F9DE72
	Offset: 0x28A8
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function function_cc7e9fc3(var_aead7d20, var_4309a155)
{
	var_2cf32b2b = struct::get_array(var_aead7d20);
	var_2cf32b2b = array::sort_by_script_int(var_2cf32b2b, 1);
	if(isdefined(var_4309a155))
	{
		s_start = function_640e138d(var_4309a155);
		array::push_front(var_2cf32b2b, s_start);
	}
	return var_2cf32b2b;
}

/*
	Name: function_640e138d
	Namespace: namespace_31170709
	Checksum: 0xDD2B5DD2
	Offset: 0x2948
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_640e138d(str_targetname)
{
	var_2cf32b2b = struct::get_array(str_targetname);
	var_2cf32b2b = array::sort_by_script_int(var_2cf32b2b, 1);
	return var_2cf32b2b[var_2cf32b2b.size - 1];
}

/*
	Name: function_77072f95
	Namespace: namespace_31170709
	Checksum: 0xAF8E4244
	Offset: 0x29B0
	Size: 0x2E4
	Parameters: 3
	Flags: Linked
*/
function function_77072f95(localclientnum, var_de782fc6, a_s_points)
{
	if(!isdefined(level.var_b20dd024))
	{
		level.var_b20dd024 = [];
	}
	if(isdefined(level.var_b20dd024[var_de782fc6]))
	{
		return;
	}
	foreach(i, s_point in a_s_points)
	{
		s_start = s_point;
		s_end = a_s_points[i + 1];
		if(!isdefined(s_end))
		{
			break;
		}
		if(isdefined(s_end.target))
		{
			s_end = struct::get(s_end.target);
		}
		v_start_origin = s_start.origin;
		var_e64db026 = s_end.origin;
		v_start_angles = vectortoangles(v_start_origin - var_e64db026);
		v_end_angles = vectortoangles(var_e64db026 - v_start_origin);
		var_360148 = util::spawn_model(localclientnum, #"tag_origin", v_start_origin, v_start_angles);
		var_b5d35012 = util::spawn_model(localclientnum, #"tag_origin", var_e64db026, v_end_angles);
		level beam::launch(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_mirror_light", 1);
		if(!isdefined(level.var_b20dd024[var_de782fc6]))
		{
			level.var_b20dd024[var_de782fc6] = [];
		}
		else if(!isarray(level.var_b20dd024[var_de782fc6]))
		{
			level.var_b20dd024[var_de782fc6] = array(level.var_b20dd024[var_de782fc6]);
		}
		level.var_b20dd024[var_de782fc6][level.var_b20dd024[var_de782fc6].size] = array(var_360148, var_b5d35012);
	}
}

/*
	Name: function_c6f495b3
	Namespace: namespace_31170709
	Checksum: 0xD2EB97C
	Offset: 0x2CA0
	Size: 0x196
	Parameters: 3
	Flags: Linked
*/
function function_c6f495b3(localclientnum, var_de782fc6, a_s_points)
{
	function_77072f95(localclientnum, var_de782fc6, a_s_points);
	var_9c2546ae = level.var_b20dd024[var_de782fc6];
	s_start = a_s_points[a_s_points.size - 2];
	s_end = a_s_points[a_s_points.size - 1];
	var_95bce808 = var_9c2546ae[var_9c2546ae.size - 1];
	var_360148 = var_95bce808[0];
	var_b5d35012 = var_95bce808[1];
	v_start_origin = s_start.origin;
	var_e64db026 = s_end.origin;
	var_360148.origin = v_start_origin;
	var_b5d35012.origin = var_e64db026;
	v_start_angles = vectortoangles(v_start_origin - var_e64db026);
	v_end_angles = vectortoangles(var_e64db026 - v_start_origin);
	var_360148.angles = v_start_angles;
	var_b5d35012.angles = v_end_angles;
}

/*
	Name: function_ed4ed5e
	Namespace: namespace_31170709
	Checksum: 0xBF096912
	Offset: 0x2E40
	Size: 0x148
	Parameters: 2
	Flags: Linked
*/
function function_ed4ed5e(localclientnum, var_de782fc6)
{
	if(!isdefined(level.var_b20dd024))
	{
		return;
	}
	var_d3f5af49 = level.var_b20dd024[var_de782fc6];
	if(isdefined(var_d3f5af49))
	{
		foreach(var_95bce808 in var_d3f5af49)
		{
			var_360148 = var_95bce808[0];
			var_b5d35012 = var_95bce808[1];
			level beam::kill(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_mirror_light");
			var_360148 delete();
			var_b5d35012 delete();
		}
		level.var_b20dd024[var_de782fc6] = undefined;
	}
}

/*
	Name: function_659d8180
	Namespace: namespace_31170709
	Checksum: 0x8DA730C5
	Offset: 0x2F90
	Size: 0x112
	Parameters: 7
	Flags: Linked
*/
function function_659d8180(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_forward = anglestoforward(self.angles);
		v_up = anglestoup(self.angles);
		playfx(localclientnum, level._effect[#"hash_1af6f489b6868e7a"], self.origin, v_forward, v_up);
		self playsound(localclientnum, #"hash_5b3374cdce8e1865");
		self.sfx_id = self playloopsound(#"hash_2b3e9902ba3d0282");
	}
}

/*
	Name: function_31d064c0
	Namespace: namespace_31170709
	Checksum: 0x25DF5133
	Offset: 0x30B0
	Size: 0x166
	Parameters: 7
	Flags: Linked
*/
function function_31d064c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_105309c))
		{
			self.var_105309c = util::playfxontag(localclientnum, level._effect[#"hash_13ec9477957fe921"], self, "tag_origin");
		}
		if(!isdefined(self.var_1cfdd45e))
		{
			self playsound(localclientnum, #"hash_10f7dee939554f61");
			self.var_1cfdd45e = self playloopsound(#"hash_474d2ea03ea86530");
		}
	}
	else if(isdefined(self.var_105309c))
	{
		stopfx(localclientnum, self.var_105309c);
		self.var_105309c = undefined;
	}
	if(isdefined(self.var_1cfdd45e))
	{
		self stoploopsound(self.var_1cfdd45e);
		self.var_1cfdd45e = undefined;
	}
}

/*
	Name: function_d087b08c
	Namespace: namespace_31170709
	Checksum: 0x8E560646
	Offset: 0x3220
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function function_d087b08c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_e4bbc6ac))
		{
			if(zm_utility::function_f8796df3(localclientnum))
			{
				if(viewmodelhastag(localclientnum, "tag_flash"))
				{
					self.var_e4bbc6ac = playviewmodelfx(localclientnum, level._effect[#"hash_7209746af2213da9"], "tag_flash");
				}
			}
			else
			{
				self.var_e4bbc6ac = util::playfxontag(localclientnum, level._effect[#"hash_7210806af22770bb"], self, "tag_flash");
			}
		}
		if(!isdefined(self.var_eb8d44ea))
		{
			self playsound(localclientnum, #"hash_aed5c123abb41e");
			self.var_eb8d44ea = self playloopsound(#"hash_581b3b27da3ead87");
		}
	}
	else if(isdefined(self.var_e4bbc6ac))
	{
		deletefx(localclientnum, self.var_e4bbc6ac);
		self.var_e4bbc6ac = undefined;
	}
	if(isdefined(self.var_eb8d44ea))
	{
		self playsound(localclientnum, #"hash_5ab27086e5a04d18");
		self stoploopsound(self.var_eb8d44ea);
		self.var_eb8d44ea = undefined;
	}
}

/*
	Name: function_d02ccc7c
	Namespace: namespace_31170709
	Checksum: 0xB96653B1
	Offset: 0x3428
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function function_d02ccc7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_f5e35678))
		{
			if(zm_utility::function_f8796df3(localclientnum))
			{
				if(viewmodelhastag(localclientnum, "tag_flash"))
				{
					self.var_f5e35678 = playviewmodelfx(localclientnum, level._effect[#"hash_48f9a29daf00294a"], "tag_flash");
				}
			}
			else
			{
				self.var_f5e35678 = util::playfxontag(localclientnum, level._effect[#"hash_48f3969daefba938"], self, "tag_flash");
			}
		}
		if(!isdefined(self.var_d8fc8527))
		{
			self playsound(localclientnum, #"hash_3c19e72698ac95d0");
			self.var_d8fc8527 = self playloopsound(#"hash_24af8554667c6b49");
		}
	}
	else if(isdefined(self.var_f5e35678))
	{
		deletefx(localclientnum, self.var_f5e35678);
		self.var_f5e35678 = undefined;
	}
	if(isdefined(self.var_d8fc8527))
	{
		self playsound(localclientnum, #"hash_5bcd3088193f642e");
		self stoploopsound(self.var_d8fc8527);
		self.var_d8fc8527 = undefined;
	}
}

/*
	Name: function_3d3614aa
	Namespace: namespace_31170709
	Checksum: 0xB94EA77E
	Offset: 0x3630
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_3d3614aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self playrumbleonentity(localclientnum, #"hash_230077451d7197c1");
}

/*
	Name: function_6a9e68bf
	Namespace: namespace_31170709
	Checksum: 0x15965299
	Offset: 0x36A0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_6a9e68bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_2a17f2993036fab4"], self, "tag_origin");
}

/*
	Name: function_d7aac18b
	Namespace: namespace_31170709
	Checksum: 0x102067A9
	Offset: 0x3720
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function function_d7aac18b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	n_fx = playfx(localclientnum, level._effect[#"hash_797e7381ba62ff8a"], self.origin);
	playsound(localclientnum, #"hash_3bf3dbe329c0568b", self.origin);
	wait(0.1);
	stopfx(localclientnum, n_fx);
}

/*
	Name: function_138c09b6
	Namespace: namespace_31170709
	Checksum: 0x7A90D711
	Offset: 0x37F0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_138c09b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.n_fx = util::playfxontag(localclientnum, level._effect[#"hash_30660c47aae060a9"], self, "tag_origin");
	}
	else if(isdefined(self.n_fx))
	{
		stopfx(localclientnum, self.n_fx);
		self.n_fx = undefined;
	}
}

/*
	Name: function_9dbc7c12
	Namespace: namespace_31170709
	Checksum: 0xCE5FB2A6
	Offset: 0x38B8
	Size: 0x12E
	Parameters: 7
	Flags: Linked
*/
function function_9dbc7c12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.n_fx = util::playfxontag(localclientnum, level._effect[#"hash_22acf133b0aa208a"], self, "tag_origin");
		if(!isdefined(self.var_5c130831))
		{
			self.var_5c130831 = self playloopsound(#"hash_895096b873c07a7");
		}
	}
	else if(isdefined(self.n_fx))
	{
		stopfx(localclientnum, self.n_fx);
		self.n_fx = undefined;
	}
	if(isdefined(self.var_5c130831))
	{
		self stoploopsound(self.var_5c130831);
		self.var_5c130831 = undefined;
	}
}

/*
	Name: function_613a43b6
	Namespace: namespace_31170709
	Checksum: 0x1C96948
	Offset: 0x39F0
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_613a43b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	s_fx = struct::get(#"hash_1ccb47ff147a81f4");
	playfx(localclientnum, level._effect[#"hash_530e1caa1a8c81d2"], s_fx.origin, anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
}

/*
	Name: function_b1017eda
	Namespace: namespace_31170709
	Checksum: 0xE34F1FDA
	Offset: 0x3AD0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_b1017eda(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self playrumbleonentity(localclientnum, #"hash_112f9d14b803778e");
}

/*
	Name: function_fb3b37f4
	Namespace: namespace_31170709
	Checksum: 0xDE46C10A
	Offset: 0x3B40
	Size: 0xE0
	Parameters: 7
	Flags: Linked
*/
function function_fb3b37f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		var_eb22c4da = findvolumedecalindexarray("oil_trail_" + newval);
		foreach(n_index in var_eb22c4da)
		{
			hidevolumedecal(n_index);
		}
	}
}

/*
	Name: function_405ead09
	Namespace: namespace_31170709
	Checksum: 0x8D63C5CD
	Offset: 0x3C28
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_405ead09(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self playrumbleonentity(localclientnum, #"hash_2a21e56240a0c6a2");
}

/*
	Name: function_d55ae74b
	Namespace: namespace_31170709
	Checksum: 0x49BEB3C7
	Offset: 0x3C98
	Size: 0x174
	Parameters: 7
	Flags: Linked
*/
function function_d55ae74b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		self function_5d482e78(#"hash_1e7d0ce25eb2b583");
		if(isdefined(self.var_5c130831))
		{
			self.var_5c130831 = undefined;
			self playsound(localclientnum, #"hash_266abe875511476f");
		}
	}
	else
	{
		e_player = getentbynum(localclientnum, newval - 1);
		var_79fd5c81 = function_5c10bd79(localclientnum);
		if(!isdefined(e_player) || e_player !== var_79fd5c81)
		{
			return;
		}
		self function_bf9d3071(#"hash_1e7d0ce25eb2b583");
		if(!isdefined(self.var_5c130831))
		{
			self.var_5c130831 = 1;
			self playsound(localclientnum, #"hash_2b9cdcb1738afacb");
		}
	}
}

/*
	Name: function_efc5ca9d
	Namespace: namespace_31170709
	Checksum: 0x61AB2BC3
	Offset: 0x3E18
	Size: 0x166
	Parameters: 7
	Flags: Linked
*/
function function_efc5ca9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(newval == 1)
	{
		self postfx::playpostfxbundle(#"hash_94349498b041929");
		if(!isdefined(self.var_7fae5704))
		{
			self playsound(localclientnum, #"hash_246b0331273b8963");
			self.var_7fae5704 = self playloopsound(#"hash_190de0e3d0106035");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_94349498b041929");
		if(isdefined(self.var_7fae5704))
		{
			self playsound(localclientnum, #"hash_53ce051a5ea76c76");
			self stoploopsound(self.var_7fae5704);
			self.var_7fae5704 = undefined;
		}
	}
}

/*
	Name: function_27f4136d
	Namespace: namespace_31170709
	Checksum: 0x2FB61C67
	Offset: 0x3F88
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_27f4136d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self function_bf9d3071(#"hash_7ba1b67ed61ae142");
	}
	else
	{
		self function_5d482e78(#"hash_7ba1b67ed61ae142");
	}
}

/*
	Name: function_148f3698
	Namespace: namespace_31170709
	Checksum: 0x4795D0CA
	Offset: 0x4020
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_148f3698(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	self.var_abbe7dc9 = util::playfxontag(localclientnum, level._effect[#"hash_784f06b253332f8f"], self, "tag_origin");
	playsound(localclientnum, #"hash_4dc90b0a7990f309", self.origin);
}

/*
	Name: function_ddf8e6d7
	Namespace: namespace_31170709
	Checksum: 0x678BAE75
	Offset: 0x40D0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_ddf8e6d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.n_fx = util::playfxontag(localclientnum, level._effect[#"hash_6d76e4b7a31537af"], self, "tag_origin");
	}
	else if(isdefined(self.n_fx))
	{
		stopfx(localclientnum, self.n_fx);
		self.n_fx = undefined;
	}
}

/*
	Name: function_81289c69
	Namespace: namespace_31170709
	Checksum: 0x53788786
	Offset: 0x4198
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_81289c69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	s_fx = struct::get(#"hash_16d7f49b344088ee");
	playfx(localclientnum, level._effect[#"hash_4d77ba61cd7f3eb7"], s_fx.origin, anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
}

/*
	Name: function_73a5ca1a
	Namespace: namespace_31170709
	Checksum: 0xA3DC9F64
	Offset: 0x4278
	Size: 0x53C
	Parameters: 7
	Flags: Linked
*/
function function_73a5ca1a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_94068374))
	{
		level.var_94068374 = util::spawn_model(localclientnum, #"tag_origin");
		level.var_94068374.var_5a8d6651 = level.var_94068374 playloopsound(#"hash_289b15dba7547241");
	}
	if(!isdefined(level.var_656f903a))
	{
		level.var_656f903a = util::spawn_model(localclientnum, #"tag_origin");
		level.var_656f903a.var_5a8d6651 = level.var_656f903a playloopsound(#"hash_289b15dba7547241");
	}
	var_360148 = level.var_94068374;
	var_b5d35012 = level.var_656f903a;
	switch(newval)
	{
		case 0:
		{
			level.var_534f1bad = undefined;
			level beam::kill(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_ra_ray");
			if(isdefined(var_360148.var_5a8d6651))
			{
				var_360148 playsound(localclientnum, #"hash_7aeea3d29c1624a");
				var_360148 stoploopsound(var_360148.var_5a8d6651);
			}
			if(isdefined(var_b5d35012.var_5a8d6651))
			{
				var_b5d35012 stoploopsound(var_b5d35012.var_5a8d6651);
			}
			if(isdefined(var_b5d35012.var_85c90678))
			{
				var_b5d35012 stoploopsound(var_b5d35012.var_85c90678);
				var_b5d35012.var_85c90678 = undefined;
			}
			var_360148 delete();
			var_b5d35012 delete();
			return;
		}
		case 1:
		{
			if(isdefined(var_b5d35012.var_85c90678))
			{
				var_b5d35012 stoploopsound(var_b5d35012.var_85c90678);
				var_b5d35012.var_85c90678 = undefined;
			}
			s_end = struct::get(#"hash_120883658590601c");
			break;
		}
		case 2:
		{
			if(!isdefined(var_b5d35012.var_85c90678))
			{
				var_b5d35012.var_85c90678 = var_b5d35012 playloopsound(#"hash_11855496f2ae0456");
			}
			s_end = struct::get(#"hash_7e325197a32f4394");
			break;
		}
		case 3:
		{
			if(!isdefined(var_b5d35012.var_85c90678))
			{
				var_b5d35012.var_85c90678 = var_b5d35012 playloopsound(#"hash_11855496f2ae0456");
			}
			s_end = struct::get(#"hash_394e0d84e8666511");
			break;
		}
	}
	s_start = struct::get(#"hash_28652987572c5885");
	v_start_origin = s_start.origin;
	var_e64db026 = s_end.origin;
	v_start_angles = vectortoangles(v_start_origin - var_e64db026);
	v_end_angles = vectortoangles(var_e64db026 - v_start_origin);
	var_360148.origin = v_start_origin;
	var_360148.angles = v_start_angles;
	var_b5d35012.origin = var_e64db026;
	var_b5d35012.angles = v_end_angles;
	if(!(isdefined(level.var_534f1bad) && level.var_534f1bad))
	{
		level.var_534f1bad = 1;
		level beam::launch(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_ra_ray", 1);
	}
}

/*
	Name: function_4d61e8ab
	Namespace: namespace_31170709
	Checksum: 0x372C4D3A
	Offset: 0x47C0
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function function_4d61e8ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"pstfx_zm_hellhole");
		self postfx::playpostfxbundle(#"pstfx_gaussian_blur");
		self playrumblelooponentity(localclientnum, "damage_heavy");
	}
	else
	{
		self postfx::stoppostfxbundle(#"pstfx_zm_hellhole");
		self postfx::stoppostfxbundle(#"pstfx_gaussian_blur");
		self stoprumble(localclientnum, "damage_heavy");
	}
}

/*
	Name: function_c6c41fb1
	Namespace: namespace_31170709
	Checksum: 0x947CD80E
	Offset: 0x48D8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_c6c41fb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071(#"hash_5b016c114ead2591");
	}
	else
	{
		self function_5d482e78(#"hash_5b016c114ead2591");
	}
}

/*
	Name: function_ad6b5484
	Namespace: namespace_31170709
	Checksum: 0xBCE40D40
	Offset: 0x4970
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_ad6b5484(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_c4c53839))
		{
			self.var_c4c53839 = util::playfxontag(localclientnum, level._effect[#"hash_7fc7f7b5958831d4"], self, "tag_origin");
		}
	}
	else if(isdefined(self.var_c4c53839))
	{
		stopfx(localclientnum, self.var_c4c53839);
		self.var_c4c53839 = undefined;
	}
}

/*
	Name: function_f3c6c429
	Namespace: namespace_31170709
	Checksum: 0xC1B0588F
	Offset: 0x4A48
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_f3c6c429(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_431f319e4b8fe9db"], self, "tag_origin");
}

/*
	Name: function_6fd9deaa
	Namespace: namespace_31170709
	Checksum: 0x7C126707
	Offset: 0x4AC8
	Size: 0x2DC
	Parameters: 7
	Flags: Linked
*/
function function_6fd9deaa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_player = function_5c10bd79(localclientnum);
	if(newval)
	{
		s_start = struct::get(#"hash_6873469a7f41e2af");
		s_end = struct::get(#"hash_258b38a5968b7b5a");
		v_start_origin = s_start.origin;
		var_e64db026 = s_end.origin;
		v_start_angles = vectortoangles(var_e64db026 - v_start_origin);
		var_360148 = util::spawn_model(localclientnum, #"tag_origin", v_start_origin, v_start_angles);
		var_b5d35012 = util::spawn_model(localclientnum, #"tag_origin", var_e64db026);
		var_360148 playsound(localclientnum, #"hash_3765e25049981166");
		var_360148.sfx_id = var_360148 playloopsound(#"hash_170aa1970243fc4a");
		e_player.var_636aecd9 = var_360148;
		e_player.var_2667ae26 = var_b5d35012;
		level beam::launch(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_ra_ray_bath", 1);
	}
	else
	{
		var_360148 = e_player.var_636aecd9;
		var_b5d35012 = e_player.var_2667ae26;
		if(!isdefined(var_360148) || !isdefined(var_b5d35012))
		{
			return;
		}
		var_360148 playsound(localclientnum, #"hash_3126b098b980b5a3");
		level beam::kill(var_360148, "tag_origin", var_b5d35012, "tag_origin", "beam8_zm_red_ra_ray_bath");
		var_360148 delete();
		var_b5d35012 delete();
	}
}

/*
	Name: function_6d38ea52
	Namespace: namespace_31170709
	Checksum: 0xA81F0D7D
	Offset: 0x4DB0
	Size: 0x3B4
	Parameters: 7
	Flags: Linked
*/
function function_6d38ea52(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	s_center = struct::get(#"hash_258b38a5968b7b5a");
	v_center = s_center.origin;
	var_eeb3ecc2 = util::spawn_model(localclientnum, #"tag_origin", v_center);
	var_90b58ce = 0;
	var_5f70b16e = 0;
	var_1a66f701 = 0;
	while(true)
	{
		waitframe(1);
		n_current_time = gettime();
		n_time_passed = float(n_current_time - n_start_time) / 1000;
		n_percent = n_time_passed / 10;
		var_693d3fcc = 0.25 * n_percent;
		if(var_693d3fcc > 0.01)
		{
			earthquake(localclientnum, var_693d3fcc, 0.016, v_center, 2048);
		}
		if(n_percent >= 0.66 && !var_1a66f701)
		{
			var_1a66f701 = 1;
			var_eeb3ecc2 playrumblelooponentity(localclientnum, #"hash_7549b81fb3f26c47");
			var_eeb3ecc2 stoprumble(localclientnum, #"hash_2578b3deb6dd485a");
		}
		else if(n_percent >= 0.33 && !var_5f70b16e)
		{
			var_5f70b16e = 1;
			var_eeb3ecc2 playrumblelooponentity(localclientnum, #"hash_2578b3deb6dd485a");
			var_eeb3ecc2 stoprumble(localclientnum, #"hash_753c961fb3e7a825");
		}
		else if(!var_90b58ce)
		{
			var_90b58ce = 1;
			var_eeb3ecc2 playrumblelooponentity(localclientnum, #"hash_753c961fb3e7a825");
		}
		if(n_percent >= 1)
		{
			break;
		}
	}
	var_eeb3ecc2 stoprumble(localclientnum, #"hash_7549b81fb3f26c47");
	var_eeb3ecc2 stoprumble(localclientnum, #"hash_2578b3deb6dd485a");
	var_eeb3ecc2 stoprumble(localclientnum, #"hash_753c961fb3e7a825");
	var_eeb3ecc2 delete();
}

/*
	Name: function_70e5b4bd
	Namespace: namespace_31170709
	Checksum: 0xBAB7FE49
	Offset: 0x5170
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_70e5b4bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_2f87fbd2e3e9dda");
		if(!isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_4cde391232649006");
			self.var_b3673abf = self playloopsound(#"hash_6d36c32b83f1376a");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_2f87fbd2e3e9dda");
		if(isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_47f89ff10ff89743");
			self stoploopsound(self.var_b3673abf);
			self.var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_f648d45a
	Namespace: namespace_31170709
	Checksum: 0xECD9163F
	Offset: 0x52C0
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_f648d45a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_61f8641fde4dd9ca");
		if(!isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_4cde391232649006");
			self.var_b3673abf = self playloopsound(#"hash_6d36c32b83f1376a");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_61f8641fde4dd9ca");
		if(isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_47f89ff10ff89743");
			self stoploopsound(self.var_b3673abf);
			self.var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_40cc4833
	Namespace: namespace_31170709
	Checksum: 0x819B8487
	Offset: 0x5410
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_40cc4833(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_39e179f1497e8a2f");
		if(!isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_4cde391232649006");
			self.var_b3673abf = self playloopsound(#"hash_6d36c32b83f1376a");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_39e179f1497e8a2f");
		if(isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_47f89ff10ff89743");
			self stoploopsound(self.var_b3673abf);
			self.var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_83c7dece
	Namespace: namespace_31170709
	Checksum: 0x6E1C8396
	Offset: 0x5560
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_83c7dece(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_5d1d9f246fa51331");
		if(!isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_4cde391232649006");
			self.var_b3673abf = self playloopsound(#"hash_6d36c32b83f1376a");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_5d1d9f246fa51331");
		if(isdefined(self.var_b3673abf))
		{
			self playsound(localclientnum, #"hash_47f89ff10ff89743");
			self stoploopsound(self.var_b3673abf);
			self.var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_530c191c
	Namespace: namespace_31170709
	Checksum: 0xB866D1A4
	Offset: 0x56B0
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function function_530c191c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_2caf3cb56ac5fd8f");
		if(!isdefined(self.var_b3673abf))
		{
			self.var_b3673abf = self playloopsound(#"hash_4e916bea4aecf6ed");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_2caf3cb56ac5fd8f");
		if(isdefined(self.var_b3673abf))
		{
			self stoploopsound(self.var_b3673abf);
			self.var_b3673abf = undefined;
		}
	}
}

/*
	Name: function_cb766634
	Namespace: namespace_31170709
	Checksum: 0x5772277E
	Offset: 0x57A8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_cb766634(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_415416bf220de94"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_3e4aa1cc
	Namespace: namespace_31170709
	Checksum: 0x9218B016
	Offset: 0x5830
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_3e4aa1cc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_3e2b1092de25c2dd"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_fac1b5c7
	Namespace: namespace_31170709
	Checksum: 0x4B006F65
	Offset: 0x58B8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_fac1b5c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_24b5302c2f39ebc2"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_106dc737
	Namespace: namespace_31170709
	Checksum: 0xB8493D4B
	Offset: 0x5940
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_106dc737(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_6a8479b5a5b359a7"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_343099ca
	Namespace: namespace_31170709
	Checksum: 0x474176FC
	Offset: 0x59C8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_343099ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_4feb66128e57d092"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_c5443282
	Namespace: namespace_31170709
	Checksum: 0x6056E57B
	Offset: 0x5A50
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_c5443282(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_7552d5567ab25417"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_f39e44d7
	Namespace: namespace_31170709
	Checksum: 0x10D55A99
	Offset: 0x5AD8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_f39e44d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_4e1b58f05f69a65a"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_6bd8c915
	Namespace: namespace_31170709
	Checksum: 0x90D23ABF
	Offset: 0x5B60
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_6bd8c915(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = level._effect[#"hash_5a6761fe764bdccf"];
	self function_95d76b40(localclientnum, newval, str_fx);
}

/*
	Name: function_95d76b40
	Namespace: namespace_31170709
	Checksum: 0x8E8CFCE7
	Offset: 0x5BE8
	Size: 0xC6
	Parameters: 3
	Flags: Linked
*/
function function_95d76b40(localclientnum, newval, str_fx)
{
	if(newval)
	{
		if(!isdefined(self.var_31b927aa))
		{
			self playsound(localclientnum, #"hash_3c0dc8688620ea73");
			self.var_31b927aa = util::playfxontag(localclientnum, str_fx, self, "j_spine4");
		}
	}
	else if(isdefined(self.var_31b927aa))
	{
		stopfx(localclientnum, self.var_31b927aa);
		self.var_31b927aa = undefined;
	}
}

/*
	Name: function_af9f249c
	Namespace: namespace_31170709
	Checksum: 0x1E05F915
	Offset: 0x5CB8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_af9f249c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_b750bd91(localclientnum, newval, #"death");
}

/*
	Name: function_704042f5
	Namespace: namespace_31170709
	Checksum: 0xEAB514C4
	Offset: 0x5D28
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_704042f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_b750bd91(localclientnum, newval, #"earth");
}

/*
	Name: function_a1833637
	Namespace: namespace_31170709
	Checksum: 0x5BA3D214
	Offset: 0x5D98
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_a1833637(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_b750bd91(localclientnum, newval, #"air");
}

/*
	Name: function_52659f14
	Namespace: namespace_31170709
	Checksum: 0xC47DACB1
	Offset: 0x5E08
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_52659f14(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_b750bd91(localclientnum, newval, #"light");
}

/*
	Name: function_b750bd91
	Namespace: namespace_31170709
	Checksum: 0xA901589E
	Offset: 0x5E78
	Size: 0x65E
	Parameters: 3
	Flags: Linked
*/
function function_b750bd91(localclientnum, newval, var_2c03c1e4)
{
	if(!isdefined(level.var_6ca19725))
	{
		level.var_6ca19725 = [];
	}
	n_fx = level.var_6ca19725[var_2c03c1e4];
	if(!isdefined(level.var_39ab105d))
	{
		level.var_39ab105d = [];
	}
	var_740e1e0e = level.var_39ab105d[var_2c03c1e4];
	var_408c2f30 = "";
	var_f5257d20 = "";
	if(newval <= 0)
	{
		if(isdefined(n_fx))
		{
			stopfx(localclientnum, n_fx);
			level.var_6ca19725[var_2c03c1e4] = undefined;
		}
		if(isdefined(var_740e1e0e))
		{
			if(isdefined(var_740e1e0e.var_f5257d20))
			{
				var_740e1e0e playsound(localclientnum, var_740e1e0e.var_f5257d20);
			}
			var_740e1e0e delete();
			level.var_39ab105d[var_2c03c1e4] = undefined;
		}
	}
	else if(!isdefined(n_fx) && !isdefined(var_740e1e0e))
	{
		if(newval == 1)
		{
			switch(var_2c03c1e4)
			{
				case "death":
				{
					s_pos = struct::get(#"hash_11302005e130b7eb");
					str_fx = level._effect[#"hash_579a1ad0a61119fc"];
					break;
				}
				case "earth":
				{
					s_pos = struct::get(#"hash_2b292979020933aa");
					str_fx = level._effect[#"hash_79910e1d73c43922"];
					break;
				}
				case "air":
				{
					s_pos = struct::get(#"hash_286a392e24892dee");
					str_fx = level._effect[#"hash_2b1f96b3ed3451d2"];
					break;
				}
				case "light":
				{
					s_pos = struct::get(#"hash_5ae30fa5823821ee");
					str_fx = level._effect[#"hash_151f6238e261520a"];
					break;
				}
			}
			var_408c2f30 = #"hash_5c827c8b5d6786d0";
			var_f5257d20 = #"hash_4e0f49a6de027614";
			var_88dfc0c9 = 0.37;
		}
		else
		{
			switch(newval)
			{
				case 2:
				{
					s_pos = struct::get(#"hash_2038ad2a6cbb9188");
					break;
				}
				case 3:
				{
					s_pos = struct::get(#"hash_2038b02a6cbb96a1");
					break;
				}
				case 4:
				{
					s_pos = struct::get(#"hash_2038af2a6cbb94ee");
					break;
				}
				case 5:
				{
					s_pos = struct::get(#"hash_2038b22a6cbb9a07");
					break;
				}
			}
			switch(var_2c03c1e4)
			{
				case "death":
				{
					str_fx = level._effect[#"hash_257185644d8c28b0"];
					break;
				}
				case "earth":
				{
					str_fx = level._effect[#"hash_3d71b8c8036f8a4e"];
					break;
				}
				case "air":
				{
					str_fx = level._effect[#"hash_1caa39c10fd546be"];
					break;
				}
				case "light":
				{
					str_fx = level._effect[#"hash_5c18b169297a5116"];
					break;
				}
			}
			var_408c2f30 = #"hash_57f7a8a10722c251";
			var_f5257d20 = #"";
			var_88dfc0c9 = 0.75;
		}
		n_fx = playfx(localclientnum, str_fx, s_pos.origin, anglestoforward(s_pos.angles), anglestoup(s_pos.angles));
		var_cfc545ad = function_985f4598(var_2c03c1e4);
		var_740e1e0e = util::spawn_model(localclientnum, var_cfc545ad, s_pos.origin);
		var_740e1e0e setscale(var_88dfc0c9);
		var_740e1e0e thread namespace_b7e8677a::function_58806d4f(localclientnum, undefined, 1);
		var_740e1e0e playsound(localclientnum, var_408c2f30);
		var_740e1e0e.var_b3673abf = var_740e1e0e playloopsound(#"hash_bd407bab72c8280");
		var_740e1e0e.var_f5257d20 = var_f5257d20;
		level.var_6ca19725[var_2c03c1e4] = n_fx;
		level.var_39ab105d[var_2c03c1e4] = var_740e1e0e;
	}
}

/*
	Name: function_985f4598
	Namespace: namespace_31170709
	Checksum: 0x7D0FBBAC
	Offset: 0x64E0
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_985f4598(var_2c03c1e4)
{
	switch(var_2c03c1e4)
	{
		case "death":
		{
			var_cfc545ad = #"hash_639fb0b334dba041";
			break;
		}
		case "earth":
		{
			var_cfc545ad = #"hash_36c43975c0f01294";
			break;
		}
		case "air":
		{
			var_cfc545ad = #"hash_3b9943a1d5cb16f9";
			break;
		}
		case "light":
		{
			var_cfc545ad = #"hash_31a411dafa5678e2";
			break;
		}
	}
	return var_cfc545ad;
}

/*
	Name: function_3b28f66e
	Namespace: namespace_31170709
	Checksum: 0xD84527D4
	Offset: 0x65B0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_3b28f66e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_67b43987(localclientnum, newval, #"death");
}

/*
	Name: function_dc8d97eb
	Namespace: namespace_31170709
	Checksum: 0x15A7138E
	Offset: 0x6620
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_dc8d97eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_67b43987(localclientnum, newval, #"earth");
}

/*
	Name: function_71c2f197
	Namespace: namespace_31170709
	Checksum: 0x72A208A6
	Offset: 0x6690
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_71c2f197(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_67b43987(localclientnum, newval, #"air");
}

/*
	Name: function_4f14ca28
	Namespace: namespace_31170709
	Checksum: 0x378B6169
	Offset: 0x6700
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_4f14ca28(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_67b43987(localclientnum, newval, #"light");
}

/*
	Name: function_67b43987
	Namespace: namespace_31170709
	Checksum: 0xC600B55B
	Offset: 0x6770
	Size: 0x2AE
	Parameters: 3
	Flags: Linked
*/
function function_67b43987(localclientnum, newval, var_2c03c1e4)
{
	if(newval)
	{
		switch(var_2c03c1e4)
		{
			case "death":
			{
				str_fx = level._effect[#"hash_257185644d8c28b0"];
				break;
			}
			case "earth":
			{
				str_fx = level._effect[#"hash_3d71b8c8036f8a4e"];
				break;
			}
			case "air":
			{
				str_fx = level._effect[#"hash_1caa39c10fd546be"];
				break;
			}
			case "light":
			{
				str_fx = level._effect[#"hash_5c18b169297a5116"];
				break;
			}
		}
		var_cfc545ad = function_985f4598(var_2c03c1e4);
		if(!isdefined(self.var_31b927aa))
		{
			self.var_31b927aa = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
		}
		if(!isdefined(self.var_2ebd37a3))
		{
			var_2ebd37a3 = util::spawn_model(localclientnum, var_cfc545ad, self.origin);
			var_2ebd37a3 setscale(0.75);
			var_2ebd37a3 linkto(self);
			var_2ebd37a3 playsound(localclientnum, #"hash_a4627a5894c615a");
			var_2ebd37a3.var_b3673abf = var_2ebd37a3 playloopsound(#"hash_bd407bab72c8280");
			var_2ebd37a3 thread namespace_b7e8677a::function_58806d4f(localclientnum, undefined, 1);
			self.var_2ebd37a3 = var_2ebd37a3;
		}
	}
	else if(isdefined(self.var_31b927aa))
	{
		stopfx(localclientnum, self.var_31b927aa);
		self.var_31b927aa = undefined;
	}
	if(isdefined(self.var_2ebd37a3))
	{
		self.var_2ebd37a3 delete();
		self.var_2ebd37a3 = undefined;
	}
}

/*
	Name: function_141a55a4
	Namespace: namespace_31170709
	Checksum: 0xF7A70F6
	Offset: 0x6A28
	Size: 0x346
	Parameters: 7
	Flags: Linked
*/
function function_141a55a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_a62803a3 = struct::get_array(#"hash_61ba778e4f6ae3e");
	if(newval)
	{
		foreach(var_af0a8dfc in var_a62803a3)
		{
			if(!isdefined(var_af0a8dfc.var_3cd87194))
			{
				var_3cd87194 = [];
				for(i = 0; i < 2; i++)
				{
					var_6eb21a54 = util::spawn_model(localclientnum, #"p8_zm_power_door_symbol_01", var_af0a8dfc.origin);
					if(i == 0)
					{
						var_6eb21a54.angles = var_af0a8dfc.angles;
					}
					else
					{
						var_6eb21a54.angles = var_af0a8dfc.angles + vectorscale((0, 1, 0), 180);
					}
					var_6eb21a54 zm_blockers::power_door_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
					if(!isdefined(var_3cd87194))
					{
						var_3cd87194 = [];
					}
					else if(!isarray(var_3cd87194))
					{
						var_3cd87194 = array(var_3cd87194);
					}
					var_3cd87194[var_3cd87194.size] = var_6eb21a54;
				}
				var_af0a8dfc.var_3cd87194 = var_3cd87194;
			}
		}
	}
	else
	{
		foreach(var_af0a8dfc in var_a62803a3)
		{
			if(isdefined(var_af0a8dfc.var_3cd87194))
			{
				foreach(var_6eb21a54 in var_af0a8dfc.var_3cd87194)
				{
					var_6eb21a54 zm_blockers::power_door_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
					var_6eb21a54 delete();
				}
				var_af0a8dfc.var_3cd87194 = undefined;
			}
		}
	}
}

/*
	Name: function_9a1a1728
	Namespace: namespace_31170709
	Checksum: 0x68B7D2C5
	Offset: 0x6D78
	Size: 0x54
	Parameters: 7
	Flags: Linked
*/
function function_9a1a1728(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_d482f96b(localclientnum, newval);
}

/*
	Name: function_d482f96b
	Namespace: namespace_31170709
	Checksum: 0x51B41C7
	Offset: 0x6DD8
	Size: 0x378
	Parameters: 2
	Flags: Linked
*/
function function_d482f96b(localclientnum, newval)
{
	function_180e26e2();
	var_ce04469b = 1;
	b_immediate = 1;
	var_1a458c97 = 1;
	switch(newval)
	{
		case 0:
		{
			var_54b5dd3f = #"center";
			break;
		}
		case 1:
		{
			var_54b5dd3f = #"center";
			b_immediate = 0;
			break;
		}
		case 2:
		{
			var_54b5dd3f = #"center";
			b_immediate = 0;
			var_1a458c97 = 0;
			break;
		}
		case 3:
		{
			var_54b5dd3f = #"close";
			break;
		}
		case 4:
		{
			var_54b5dd3f = #"close";
			b_immediate = 0;
			break;
		}
		case 5:
		{
			var_54b5dd3f = #"close";
			b_immediate = 0;
			var_1a458c97 = 0;
			break;
		}
		case 6:
		{
			var_54b5dd3f = #"far";
			break;
		}
		case 7:
		{
			var_54b5dd3f = #"far";
			b_immediate = 0;
			break;
		}
		case 8:
		{
			var_54b5dd3f = #"far";
			b_immediate = 0;
			var_1a458c97 = 0;
			break;
		}
		case 9:
		{
			var_54b5dd3f = #"all";
			var_ce04469b = 0;
			b_immediate = 0;
			break;
		}
	}
	var_8f971dba = level.var_bbe677e8[var_54b5dd3f];
	if(var_ce04469b)
	{
		var_8f971dba = array::randomize(var_8f971dba);
	}
	else
	{
		var_8f971dba = array::sort_by_script_int(var_8f971dba, math::cointoss());
	}
	foreach(var_4045808d in var_8f971dba)
	{
		playfx(localclientnum, level._effect[#"hash_516899418a30cd4d"], var_4045808d.origin);
		playsound(localclientnum, #"hash_3ee7d77f646a378d", var_4045808d.origin);
		if(!b_immediate)
		{
			n_wait = 1;
			if(var_1a458c97)
			{
				n_wait = 0.5;
			}
			wait(n_wait);
		}
	}
}

/*
	Name: function_180e26e2
	Namespace: namespace_31170709
	Checksum: 0xE3D7D25F
	Offset: 0x7158
	Size: 0x380
	Parameters: 0
	Flags: Linked
*/
function function_180e26e2()
{
	if(isdefined(level.var_bf987634) && level.var_bf987634)
	{
		return;
	}
	level.var_bf987634 = 1;
	level.var_bbe677e8[#"center"] = [];
	level.var_bbe677e8[#"close"] = [];
	level.var_bbe677e8[#"far"] = [];
	level.var_bbe677e8[#"all"] = [];
	a_s_pos = struct::get_array(#"hash_7c9fecc7da908461");
	foreach(s_pos in a_s_pos)
	{
		str_type = s_pos.script_noteworthy;
		switch(str_type)
		{
			case "center":
			{
				var_c167c750 = #"center";
				break;
			}
			case "close":
			{
				var_c167c750 = #"close";
				break;
			}
			case "far":
			{
				var_c167c750 = #"far";
				break;
			}
		}
		if(!isdefined(level.var_bbe677e8[var_c167c750]))
		{
			level.var_bbe677e8[var_c167c750] = [];
		}
		else if(!isarray(level.var_bbe677e8[var_c167c750]))
		{
			level.var_bbe677e8[var_c167c750] = array(level.var_bbe677e8[var_c167c750]);
		}
		level.var_bbe677e8[var_c167c750][level.var_bbe677e8[var_c167c750].size] = s_pos;
		if(str_type != "center")
		{
			if(!isdefined(level.var_bbe677e8[#"all"]))
			{
				level.var_bbe677e8[#"all"] = [];
			}
			else if(!isarray(level.var_bbe677e8[#"all"]))
			{
				level.var_bbe677e8[#"all"] = array(level.var_bbe677e8[#"all"]);
			}
			level.var_bbe677e8[#"all"][level.var_bbe677e8[#"all"].size] = s_pos;
		}
	}
}

/*
	Name: function_6518ff8d
	Namespace: namespace_31170709
	Checksum: 0xD1DF8580
	Offset: 0x74E0
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_6518ff8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"hash_4c6d342dccfd6d73"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}

/*
	Name: function_bb7443e
	Namespace: namespace_31170709
	Checksum: 0x44D16699
	Offset: 0x7590
	Size: 0x13A
	Parameters: 7
	Flags: Linked
*/
function function_bb7443e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_74b9b03b = 1;
	}
	else
	{
		self.var_74b9b03b = undefined;
	}
	maxclients = getmaxlocalclients();
	for(localclientnum = 0; localclientnum < maxclients; localclientnum++)
	{
		if(isdefined(function_5c10bd79(localclientnum)))
		{
			foreach(e_player in getplayers(localclientnum))
			{
				e_player zm::function_92f0c63(localclientnum);
			}
		}
	}
}

/*
	Name: function_f5ec271e
	Namespace: namespace_31170709
	Checksum: 0x190E0C7A
	Offset: 0x76D8
	Size: 0x124
	Parameters: 7
	Flags: Linked
*/
function function_f5ec271e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_19dea648(localclientnum);
	}
	else
	{
		foreach(e_player in getplayers(localclientnum))
		{
			if(e_player postfx::function_556665f2(#"hash_5db75fc1c857c7cd"))
			{
				e_player postfx::exitpostfxbundle(#"hash_5db75fc1c857c7cd");
				e_player notify(#"hash_5b73690bab0457f4");
			}
		}
	}
}

/*
	Name: function_19dea648
	Namespace: namespace_31170709
	Checksum: 0x8953DB76
	Offset: 0x7808
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function function_19dea648(localclientnum)
{
	self endon(#"death");
	if(self getlocalclientnumber() === localclientnum)
	{
		if(!isdemoplaying() && !namespace_a6aea2c6::is_active(#"hash_65cfe78dc61dd3af"))
		{
			if(!util::is_mature() || !util::function_fa1da5cb())
			{
				self thread postfx::playpostfxbundle(#"hash_5db75fc1c857c7cd");
				a_e_players = getlocalplayers();
				foreach(e_player in a_e_players)
				{
					if(!e_player util::function_50ed1561(localclientnum))
					{
						e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_5db75fc1c857c7cd", #"hash_5b73690bab0457f4");
					}
				}
			}
		}
	}
}

/*
	Name: function_9b5699b4
	Namespace: namespace_31170709
	Checksum: 0x1E39F3F4
	Offset: 0x79A8
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_9b5699b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		audio::snd_set_snapshot("zmb_red_midigc_duck_all");
	}
	else if(newval == 2)
	{
		audio::snd_set_snapshot("zmb_red_midigc_duck_igc");
	}
	else
	{
		audio::snd_set_snapshot("default");
	}
}

/*
	Name: function_59ea1144
	Namespace: namespace_31170709
	Checksum: 0x1EA43FF7
	Offset: 0x7A60
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_59ea1144(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_11914b53 = struct::get(#"hash_2ea39900a13a8305");
	if(newval)
	{
		if(!isdefined(var_11914b53.var_2f2435ec))
		{
			var_11914b53.var_2f2435ec = playfx(localclientnum, level._effect[#"hash_51e28147388ee3d8"], var_11914b53.origin, anglestoforward(var_11914b53.angles), anglestoup(var_11914b53.angles));
		}
	}
	else if(isdefined(var_11914b53.var_2f2435ec))
	{
		stopfx(localclientnum, var_11914b53.var_2f2435ec);
	}
}

/*
	Name: function_806b16b7
	Namespace: namespace_31170709
	Checksum: 0xD2661E57
	Offset: 0x7B98
	Size: 0x1A0
	Parameters: 7
	Flags: Linked
*/
function function_806b16b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_11914b53 = struct::get(#"hash_2ea39900a13a8305");
	if(!isdefined(var_11914b53.var_eeb3ecc2))
	{
		var_11914b53.var_eeb3ecc2 = util::spawn_model(localclientnum, #"tag_origin", var_11914b53.origin, var_11914b53.angles);
	}
	var_11914b53.var_eeb3ecc2 stoprumble(localclientnum, #"hash_538859ec24e61dee");
	if(newval)
	{
		var_11914b53.var_eeb3ecc2 playrumblelooponentity(localclientnum, #"hash_538859ec24e61dee");
		var_11914b53.var_eeb3ecc2.var_b3673abf = var_11914b53.var_eeb3ecc2 playloopsound(#"hash_6e30f1761b6645a4");
		var_11914b53 thread function_5b807116(localclientnum);
	}
	else
	{
		var_11914b53.var_eeb3ecc2 delete();
		var_11914b53 notify(#"hash_7e024090b699d99f");
	}
}

/*
	Name: function_5b807116
	Namespace: namespace_31170709
	Checksum: 0x37B98548
	Offset: 0x7D40
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_5b807116(localclientnum)
{
	self notify("41f2ff915f63437b");
	self endon("41f2ff915f63437b");
	level endon(#"end_game");
	self endon(#"death", #"hash_7e024090b699d99f");
	while(true)
	{
		e_player = function_5c10bd79(localclientnum);
		if(isplayer(e_player))
		{
			n_dist = distance2dsquared(self.origin, e_player.origin);
			if(n_dist <= 512 * 512)
			{
				n_percent = 1 - n_dist / 512 * 512;
				var_693d3fcc = 0.15 * n_percent;
				if(var_693d3fcc > 0.01)
				{
					earthquake(localclientnum, var_693d3fcc, 0.016, e_player.origin, 1024);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_995ba4d9
	Namespace: namespace_31170709
	Checksum: 0x1ABE1E28
	Offset: 0x7EC0
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_995ba4d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_5ff65ab4))
		{
			self.var_5ff65ab4 = playfx(localclientnum, level._effect[#"hash_297c800c6e18f746"], self.origin);
		}
	}
	else if(isdefined(self.var_5ff65ab4))
	{
		stopfx(localclientnum, self.var_5ff65ab4);
		self.var_5ff65ab4 = undefined;
	}
}

/*
	Name: function_efb8d988
	Namespace: namespace_31170709
	Checksum: 0xBBDFBD58
	Offset: 0x7F98
	Size: 0x6E
	Parameters: 7
	Flags: Linked
*/
function function_efb8d988(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_83a7c416(localclientnum);
	}
	else
	{
		level.var_656b74db = 1;
	}
}

/*
	Name: function_83a7c416
	Namespace: namespace_31170709
	Checksum: 0xE14B5FB5
	Offset: 0x8010
	Size: 0x236
	Parameters: 1
	Flags: Linked
*/
function function_83a7c416(localclientnum)
{
	self notify("4cde9c02a6d66818");
	self endon("4cde9c02a6d66818");
	level endon(#"end_game");
	s_fx = struct::get(#"hash_3ad02ac72362ec5c");
	var_4c53e2d7 = 0;
	while(!(isdefined(level.var_656b74db) && level.var_656b74db))
	{
		n_offset = randomfloatrange(128 * -1, 128);
		v_fx = s_fx.origin + (n_offset, n_offset, 0);
		mdl_fx = util::spawn_model(localclientnum, #"tag_origin", v_fx);
		str_tag = "j_wingulna_le";
		if(var_4c53e2d7)
		{
			str_tag = "j_wingulna_ri";
		}
		var_4c53e2d7 = !var_4c53e2d7;
		if(isdefined(self))
		{
			level beam::launch(self, str_tag, mdl_fx, "tag_origin", "beam8_zm_red_peg_lightning_strike", 1);
			if(var_43997e53 >= 2)
			{
				self playsound(localclientnum, #"hash_61c057ffadb7a5af");
				var_43997e53 = 0;
			}
			self thread function_9631e11c(mdl_fx, str_tag);
			n_random_wait = randomfloatrange(0.1, 0.25);
			wait(n_random_wait);
			var_43997e53 = var_43997e53 + n_random_wait;
		}
	}
}

/*
	Name: function_9631e11c
	Namespace: namespace_31170709
	Checksum: 0xBEF6F578
	Offset: 0x8250
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_9631e11c(mdl_fx, str_tag)
{
	n_random_wait = randomfloatrange(1, 2);
	wait(n_random_wait);
	if(isdefined(self))
	{
		level beam::kill(self, str_tag, mdl_fx, "tag_origin", "beam8_zm_red_peg_lightning_strike");
	}
	mdl_fx delete();
}

/*
	Name: function_842fb5d0
	Namespace: namespace_31170709
	Checksum: 0x3B03BF3C
	Offset: 0x82E8
	Size: 0x14C
	Parameters: 7
	Flags: Linked
*/
function function_842fb5d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	util::playfxontag(localclientnum, level._effect[#"hash_44330c38e995c437"], self, "link_p8_zm_red_ballista");
	playsound(localclientnum, #"hash_39c2296cc1b913b9", self gettagorigin("link_p8_zm_red_ballista"));
	wait(1);
	util::playfxontag(localclientnum, level._effect[#"hash_76947a7b04c592a6"], self, "link_p8_zm_red_ballista_arrow_whole");
	playsound(localclientnum, #"hash_39c2296cc1b913b9", self gettagorigin("link_p8_zm_red_ballista_arrow_whole"));
}

/*
	Name: function_f800f4d2
	Namespace: namespace_31170709
	Checksum: 0x3938F35C
	Offset: 0x8440
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function function_f800f4d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get(#"hash_2ea39900a13a8305");
	if(newval)
	{
		if(!isdefined(s_fx.var_8928e499))
		{
			s_fx.var_8928e499 = playfx(localclientnum, level._effect[#"hash_7525e43acf9ca679"], s_fx.origin, anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
		}
		audio::playloopat(#"hash_6ebedb6190c4ee87", s_fx.origin);
	}
	else if(isdefined(s_fx.var_8928e499))
	{
		stopfx(localclientnum, s_fx.var_8928e499);
		s_fx.var_8928e499 = undefined;
	}
	audio::stoploopat(#"hash_6ebedb6190c4ee87", s_fx.origin);
}

/*
	Name: function_e6ce9708
	Namespace: namespace_31170709
	Checksum: 0xFFFFDFED
	Offset: 0x85D8
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_e6ce9708(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "visgroup_portico");
	}
	else
	{
		function_73b1f242(localclientnum, "visgroup_portico");
	}
}

