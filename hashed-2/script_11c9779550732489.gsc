// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_42cc2819;

/*
	Name: __init__system__
	Namespace: namespace_42cc2819
	Checksum: 0x2D48C24F
	Offset: 0x150
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_77ae506b4db4f2ce", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_42cc2819
	Checksum: 0x9C33050E
	Offset: 0x198
	Size: 0x462
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_11ff39a3100ac894", 1, 1, "int", &function_e7b6c72b, 0, 0);
	clientfield::register("toplayer", "" + #"hash_37c33178198d54e4", 1, 1, "int", &function_2a127860, 0, 0);
	clientfield::register("toplayer", "" + #"hash_5d9808a62579e894", 1, 1, "int", &function_f0e07568, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4ec2b359458774e4", 1, 1, "int", &function_7353e021, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4724376be4e925a3", 1, 1, "int", &function_3b405536, 0, 0);
	clientfield::register("toplayer", "" + #"hash_1aa1c7790dc67d1e", 1, 1, "int", &function_46b21d8a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7cdfc8f4819bab2e", 1, 1, "int", &function_73ca75df, 0, 0);
	clientfield::register("toplayer", "" + #"hash_61ed2f45564d54f9", 1, 1, "int", &function_fa6bb35e, 0, 0);
	clientfield::register("toplayer", "" + #"totem_fall", 1, 1, "int", &totem_fall, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2a7ceb22f84e5aa9", 1, 1, "int", &function_85aab97f, 0, 0);
	level._effect[#"hash_1aa1c7790dc67d1e"] = #"hash_2a9ea20e6cb5f0fb";
	level._effect[#"hash_7cdfc8f4819bab2e"] = #"hash_e1bfaf62712f587";
	level._effect[#"hash_61ed2f45564d54f9"] = #"hash_5531980ba0ce0b70";
	level._effect[#"blood_rise"] = #"hash_56628b3f5bc6da0d";
	level._effect[#"blood_splash"] = #"hash_4d27fd6de25c639b";
}

/*
	Name: function_e7b6c72b
	Namespace: namespace_42cc2819
	Checksum: 0xF8BCE323
	Offset: 0x608
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function function_e7b6c72b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_8d97f43e))
	{
		var_1eaed254 = struct::get("s_g_r_sp2");
		self.var_8d97f43e = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
	}
	if(newval)
	{
		self.var_8d97f43e show();
	}
	else
	{
		self.var_8d97f43e hide();
	}
}

/*
	Name: function_2a127860
	Namespace: namespace_42cc2819
	Checksum: 0x20BC3E68
	Offset: 0x700
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function function_2a127860(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_c7b21349))
	{
		var_1eaed254 = struct::get("s_r_s_sp2");
		self.var_c7b21349 = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
	}
	if(newval)
	{
		self.var_c7b21349 show();
	}
	else
	{
		self.var_c7b21349 hide();
	}
}

/*
	Name: function_f0e07568
	Namespace: namespace_42cc2819
	Checksum: 0x98A74B05
	Offset: 0x7F8
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function function_f0e07568(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_477a641f))
	{
		var_1eaed254 = struct::get("s_acid_trap_place_loc");
		self.var_477a641f = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin, var_1eaed254.angles);
	}
	if(newval)
	{
		self.var_477a641f show();
		playsound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
	}
	else
	{
		self.var_477a641f hide();
	}
}

/*
	Name: function_7353e021
	Namespace: namespace_42cc2819
	Checksum: 0x6F2108CB
	Offset: 0x918
	Size: 0x124
	Parameters: 7
	Flags: Linked
*/
function function_7353e021(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_a86cb7e0))
	{
		var_1eaed254 = struct::get("s_spin_trap_place_loc");
		self.var_a86cb7e0 = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin - vectorscale((0, 0, 1), 3), var_1eaed254.angles);
	}
	if(newval)
	{
		self.var_a86cb7e0 show();
		playsound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
	}
	else
	{
		self.var_a86cb7e0 hide();
	}
}

/*
	Name: function_3b405536
	Namespace: namespace_42cc2819
	Checksum: 0x372963F6
	Offset: 0xA48
	Size: 0x124
	Parameters: 7
	Flags: Linked
*/
function function_3b405536(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_40bb11af))
	{
		var_1eaed254 = struct::get("s_fan_trap_place_loc");
		self.var_40bb11af = util::spawn_model(localclientnum, var_1eaed254.model, var_1eaed254.origin - vectorscale((0, 0, 1), 3), var_1eaed254.angles);
	}
	if(newval)
	{
		self.var_40bb11af show();
		playsound(0, #"hash_52b00c7836adfd1e", var_1eaed254.origin);
	}
	else
	{
		self.var_40bb11af hide();
	}
}

/*
	Name: function_46b21d8a
	Namespace: namespace_42cc2819
	Checksum: 0x68F369C4
	Offset: 0xB78
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function function_46b21d8a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_1eaed254 = struct::get("s_spin_trap_place_loc");
	self.var_73fb3946 = playfx(localclientnum, level._effect[#"hash_1aa1c7790dc67d1e"], var_1eaed254.origin - vectorscale((0, 0, 1), 3));
	playsound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

/*
	Name: function_73ca75df
	Namespace: namespace_42cc2819
	Checksum: 0x982B7B06
	Offset: 0xC60
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function function_73ca75df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_1eaed254 = struct::get("s_acid_trap_place_loc");
	self.var_9c0a6f6d = playfx(localclientnum, level._effect[#"hash_7cdfc8f4819bab2e"], var_1eaed254.origin);
	playsound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

/*
	Name: function_fa6bb35e
	Namespace: namespace_42cc2819
	Checksum: 0x37A1F68C
	Offset: 0xD38
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function function_fa6bb35e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_1eaed254 = struct::get("s_fan_trap_place_loc");
	self.var_c61d3d80 = playfx(localclientnum, level._effect[#"hash_61ed2f45564d54f9"], var_1eaed254.origin - vectorscale((0, 0, 1), 3));
	playsound(0, #"hash_3375efdd38e50fb8", var_1eaed254.origin);
}

/*
	Name: totem_fall
	Namespace: namespace_42cc2819
	Checksum: 0x11B86D86
	Offset: 0xE20
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function totem_fall(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_e9af628d = struct::get("mdl_d_w_i_k_t");
	s_destination = struct::get(var_e9af628d.target);
	var_326289fb = util::spawn_model(localclientnum, #"hash_3964c81546296b78", var_e9af628d.origin, var_e9af628d.angles);
	var_326289fb moveto(s_destination.origin, 1);
}

/*
	Name: function_85aab97f
	Namespace: namespace_42cc2819
	Checksum: 0xEB31128
	Offset: 0xF18
	Size: 0x14A
	Parameters: 7
	Flags: Linked
*/
function function_85aab97f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_f383d0c1))
	{
		killfx(localclientnum, self.var_f383d0c1);
		self.var_f383d0c1 = undefined;
	}
	if(isdefined(self.var_53b18c8d))
	{
		killfx(localclientnum, self.var_53b18c8d);
		self.var_53b18c8d = undefined;
	}
	if(newval)
	{
		var_3bda41ab = struct::get("s_white_metal_splash");
		self.var_f383d0c1 = util::playfxontag(localclientnum, level._effect[#"blood_rise"], self, "tag_spork");
		self.var_53b18c8d = playfx(localclientnum, level._effect[#"blood_splash"], var_3bda41ab.origin);
	}
}

