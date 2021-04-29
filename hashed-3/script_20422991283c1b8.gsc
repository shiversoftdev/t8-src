// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_bfc8ee03;

/*
	Name: preload
	Namespace: namespace_bfc8ee03
	Checksum: 0xD5AF1BAD
	Offset: 0x1B0
	Size: 0x694
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_2b1060af0c8f9976"] = #"hash_73e8d2cf76175901";
	level._effect[#"hash_3f0f201f556a272f"] = #"hash_4f1f3e18228ac0a0";
	level._effect[#"hash_62ef18672d041a6f"] = #"hash_7af8fa2d13abeeb1";
	level._effect[#"hash_c7009c612824425"] = #"hash_306c49d67fca8485";
	level._effect[#"hash_5f479f0ba680df7b"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_7336b7a4cc9d2581"] = #"hash_1a06427eff8dfe13";
	clientfield::register("scriptmover", "" + #"hash_6aaf03a4358f45f5", 24000, 1, "counter", &function_f1749965, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6a4317183d0ca452", 24000, 1, "counter", &function_44aa40e0, 0, 0);
	clientfield::register("world", "" + #"hash_96866bbb1f4c6fe", 24000, 1, "int", &function_56336c80, 0, 0);
	clientfield::register("world", "" + #"hash_3e034844d2b9d971", 24000, 2, "int", &function_50d386b6, 0, 0);
	clientfield::register("world", "" + #"hash_72b5b0359ca48427", 24000, 1, "int", &function_bd0807f3, 0, 0);
	clientfield::register("world", "" + #"hash_5e69ee96304ec40b", 24000, 1, "int", &function_eb481d38, 0, 0);
	clientfield::register("vehicle", "" + #"lantern_fx", 24000, 2, "int", &function_f490f0e5, 0, 0);
	clientfield::register("vehicle", "" + #"hash_7d7ccc494e9c4580", 24000, 1, "counter", &function_8c0856ff, 0, 0);
	clientfield::register("toplayer", "" + #"hash_78b8d89d34b32241", 24000, 2, "int", &function_19f2f0f2, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_54e24ec6e84ad6e6", 24000, 1, "int", &function_cbc22c9d, 0, 0);
	namespace_617a54f4::function_d8383812(#"sc_lantern_1", 24000, "sc_lantern_1", 400, level._effect[#"hash_5f479f0ba680df7b"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_2", 24000, "sc_lantern_2", 400, level._effect[#"hash_5f479f0ba680df7b"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_3", 24000, "sc_lantern_3", 400, level._effect[#"hash_5f479f0ba680df7b"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_4", 24000, "sc_lantern_4", 400, level._effect[#"hash_5f479f0ba680df7b"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_end", 24000, "sc_lantern_end", 400, level._effect[#"hash_5f479f0ba680df7b"], level._effect[#"hash_7336b7a4cc9d2581"], undefined, undefined, 1);
}

/*
	Name: function_f1749965
	Namespace: namespace_bfc8ee03
	Checksum: 0xEB3C02A9
	Offset: 0x850
	Size: 0x82
	Parameters: 7
	Flags: Linked
*/
function function_f1749965(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_bf9d3071(#"hash_75168376918f5ab7");
	self function_e378599(500);
	self.var_4156bf58 = 1;
}

/*
	Name: function_44aa40e0
	Namespace: namespace_bfc8ee03
	Checksum: 0xC05F8332
	Offset: 0x8E0
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function function_44aa40e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_4156bf58))
	{
		self function_e378599(self.n_radius - 1);
	}
}

/*
	Name: function_e378599
	Namespace: namespace_bfc8ee03
	Checksum: 0x7AA98724
	Offset: 0x958
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_e378599(n_radius)
{
	self.n_radius = max(200, n_radius);
	n_scale = self.n_radius / 150000;
	self function_78233d29(#"hash_75168376918f5ab7", "", "Scale", n_scale);
}

/*
	Name: function_56336c80
	Namespace: namespace_bfc8ee03
	Checksum: 0x7075690A
	Offset: 0x9E0
	Size: 0x100
	Parameters: 7
	Flags: Linked
*/
function function_56336c80(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.var_eb7fcc70 = getentarray(localclientnum, "lava_entity", "targetname");
	foreach(var_59bd23de in level.var_eb7fcc70)
	{
		var_59bd23de hide();
		var_59bd23de notsolid();
	}
}

/*
	Name: function_50d386b6
	Namespace: namespace_bfc8ee03
	Checksum: 0xF94EB21E
	Offset: 0xAE8
	Size: 0x224
	Parameters: 7
	Flags: Linked
*/
function function_50d386b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_eb7fcc70))
	{
		level.var_eb7fcc70 = getentarray(localclientnum, "lava_entity", "targetname");
	}
	if(newval == 1)
	{
		foreach(var_59bd23de in level.var_eb7fcc70)
		{
			var_59bd23de show();
			var_59bd23de solid();
		}
		exploder::exploder("exp_lava_event_ambient");
		exploder::exploder("exp_lava_event_ambient_2");
	}
	else if(newval == 0)
	{
		foreach(var_59bd23de in level.var_eb7fcc70)
		{
			var_59bd23de hide();
			var_59bd23de notsolid();
		}
		exploder::stop_exploder("exp_lava_event_ambient");
		exploder::stop_exploder("exp_lava_event_ambient_2");
	}
}

/*
	Name: function_f490f0e5
	Namespace: namespace_bfc8ee03
	Checksum: 0x2EC5FA9A
	Offset: 0xD18
	Size: 0x144
	Parameters: 7
	Flags: Linked
*/
function function_f490f0e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_b75f11cd))
	{
		stopfx(localclientnum, self.var_b75f11cd);
		self.var_b75f11cd = undefined;
	}
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_2b1060af0c8f9976"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_3f0f201f556a272f"], self, "tag_origin");
	}
	else if(newval == 3)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_62ef18672d041a6f"], self, "tag_origin");
	}
}

/*
	Name: function_19f2f0f2
	Namespace: namespace_bfc8ee03
	Checksum: 0x39FAA9B1
	Offset: 0xE68
	Size: 0x1A6
	Parameters: 7
	Flags: Linked
*/
function function_19f2f0f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self postfx::function_556665f2(#"hash_470febc4af661700"))
	{
		self postfx::stoppostfxbundle(#"hash_470febc4af661700");
	}
	else if(self postfx::function_556665f2(#"hash_6864d9fc4517ec45"))
	{
		self postfx::stoppostfxbundle(#"hash_6864d9fc4517ec45");
	}
	if(newval == 1)
	{
		self postfx::playpostfxbundle(#"hash_470febc4af661700");
	}
	else if(newval == 2)
	{
		self postfx::playpostfxbundle(#"hash_6864d9fc4517ec45");
	}
	if(newval == 2)
	{
		if(!isdefined(self.var_9480d4b2))
		{
			self.var_9480d4b2 = self playloopsound(#"evt_death_circle_strong");
		}
	}
	else if(isdefined(self.var_9480d4b2))
	{
		self stoploopsound(self.var_9480d4b2);
		self.var_9480d4b2 = undefined;
	}
}

/*
	Name: function_cbc22c9d
	Namespace: namespace_bfc8ee03
	Checksum: 0xA4A6BB68
	Offset: 0x1018
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_cbc22c9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_bf9d3071(#"rob_sonar_set_friendly_zm");
}

/*
	Name: function_8c0856ff
	Namespace: namespace_bfc8ee03
	Checksum: 0xFCB79ABF
	Offset: 0x1080
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_8c0856ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_c7009c612824425"], self, "tag_origin");
}

/*
	Name: function_bd0807f3
	Namespace: namespace_bfc8ee03
	Checksum: 0x31EF962B
	Offset: 0x1100
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_bd0807f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		audio::snd_set_snapshot("cmn_duck_aux_4");
	}
	else
	{
		audio::snd_set_snapshot("");
	}
}

/*
	Name: function_eb481d38
	Namespace: namespace_bfc8ee03
	Checksum: 0x7CE1068F
	Offset: 0x1190
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_eb481d38(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		setsoundcontext("orange_hell", "active");
	}
	else
	{
		setsoundcontext("orange_hell", "");
	}
}

