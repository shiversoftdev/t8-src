// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_ebc3fc57;

/*
	Name: function_89f2df9
	Namespace: namespace_ebc3fc57
	Checksum: 0x4E0D000A
	Offset: 0x490
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7f418a238d76b74f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ebc3fc57
	Checksum: 0xAC167EB9
	Offset: 0x4D8
	Size: 0x4CC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level._effect[#"hash_372b98426a030ba5"] = "zm_ai/fx8_blightfather_weakspot_sack_amb";
	level._effect[#"hash_53d2fc33c0f691f4"] = "zm_ai/fx8_blightfather_weakspot_elbow_amb";
	level._effect[#"hash_1ce2f3394fd60355"] = "zm_ai/fx8_blightfather_weakspot_jaw_amb";
	level._effect[#"hash_12f12714214cc841"] = "zm_ai/fx8_blightfather_maggot_spawn_burst";
	level._effect[#"hash_1dad8364594fae5d"] = "zm_ai/fx8_blightfather_chaos_missle";
	level._effect[#"hash_648523e9c72ac0c9"] = "zm_ai/fx8_blightfather_maggot_death_exp";
	footsteps::registeraitypefootstepcb(#"blight_father", &function_958ba8d1);
	clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int", &function_192c82f8, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int", &function_c6aa29ea, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int", &function_caf74103, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int", &function_bc64a2a, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int", &function_c4fff539, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int", &function_de0a50df, 0, 0);
	clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter", &function_67ad42f3, 0, 0);
	clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter", &function_f102952d, 0, 0);
	clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int", &function_75be2854, 0, 0);
	clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int", &function_e47c2324, 0, 0);
	clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int", &function_f02b0934, 0, 0);
	clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter", &function_7d5e27f4, 0, 0);
	clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int", &function_7d5fa1ae, 0, 0);
}

/*
	Name: function_7d5fa1ae
	Namespace: namespace_ebc3fc57
	Checksum: 0x9D7C3A7
	Offset: 0x9B0
	Size: 0xBC
	Parameters: 7
	Flags: Private
*/
function private function_7d5fa1ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		origin = self gettagorigin("J_Spine4");
		if(!isdefined(origin))
		{
			origin = self.origin;
		}
		physicsexplosionsphere(localclientnum, origin, 200, 0, 2);
	}
}

/*
	Name: function_c6aa29ea
	Namespace: namespace_ebc3fc57
	Checksum: 0x813F348E
	Offset: 0xA78
	Size: 0xBE
	Parameters: 7
	Flags: Private
*/
function private function_c6aa29ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_cc8c05d5 = util::playfxontag(localclientnum, level._effect[#"hash_53d2fc33c0f691f4"], self, "tag_elbow_weakspot_le");
	}
	else if(isdefined(self.var_cc8c05d5))
	{
		stopfx(localclientnum, self.var_cc8c05d5);
		self.var_cc8c05d5 = undefined;
	}
}

/*
	Name: function_caf74103
	Namespace: namespace_ebc3fc57
	Checksum: 0xDEDA83C8
	Offset: 0xB40
	Size: 0xBE
	Parameters: 7
	Flags: Private
*/
function private function_caf74103(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_e844c6a2 = util::playfxontag(localclientnum, level._effect[#"hash_53d2fc33c0f691f4"], self, "tag_elbow_weakspot_ri");
	}
	else if(isdefined(self.var_e844c6a2))
	{
		stopfx(localclientnum, self.var_e844c6a2);
		self.var_e844c6a2 = undefined;
	}
}

/*
	Name: function_bc64a2a
	Namespace: namespace_ebc3fc57
	Checksum: 0xF0237B4D
	Offset: 0xC08
	Size: 0xBE
	Parameters: 7
	Flags: Private
*/
function private function_bc64a2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_81531422 = util::playfxontag(localclientnum, level._effect[#"hash_372b98426a030ba5"], self, "tag_eggsack_weakspot_le_fx");
	}
	else if(isdefined(self.var_81531422))
	{
		stopfx(localclientnum, self.var_81531422);
		self.var_81531422 = undefined;
	}
}

/*
	Name: function_c4fff539
	Namespace: namespace_ebc3fc57
	Checksum: 0x46118C44
	Offset: 0xCD0
	Size: 0xBE
	Parameters: 7
	Flags: Private
*/
function private function_c4fff539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_40cb39ba = util::playfxontag(localclientnum, level._effect[#"hash_372b98426a030ba5"], self, "tag_eggsack_weakspot_ri_fx");
	}
	else if(isdefined(self.var_40cb39ba))
	{
		stopfx(localclientnum, self.var_40cb39ba);
		self.var_40cb39ba = undefined;
	}
}

/*
	Name: function_de0a50df
	Namespace: namespace_ebc3fc57
	Checksum: 0x7D84F471
	Offset: 0xD98
	Size: 0xBE
	Parameters: 7
	Flags: Private
*/
function private function_de0a50df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_2beadf7 = util::playfxontag(localclientnum, level._effect[#"hash_1ce2f3394fd60355"], self, "tag_jaw");
	}
	else if(isdefined(self.var_2beadf7))
	{
		stopfx(localclientnum, self.var_2beadf7);
		self.var_2beadf7 = undefined;
	}
}

/*
	Name: function_67ad42f3
	Namespace: namespace_ebc3fc57
	Checksum: 0x925F1F75
	Offset: 0xE60
	Size: 0x74
	Parameters: 7
	Flags: Private
*/
function private function_67ad42f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_12f12714214cc841"], self, "tag_sac_fx_le");
}

/*
	Name: function_f102952d
	Namespace: namespace_ebc3fc57
	Checksum: 0x9D5EDDBC
	Offset: 0xEE0
	Size: 0x74
	Parameters: 7
	Flags: Private
*/
function private function_f102952d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_12f12714214cc841"], self, "tag_sac_fx_ri");
}

/*
	Name: function_192c82f8
	Namespace: namespace_ebc3fc57
	Checksum: 0xF69EAFD5
	Offset: 0xF60
	Size: 0xCC
	Parameters: 7
	Flags: Private
*/
function private function_192c82f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self setanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 1, 0.1, 1);
	}
	else
	{
		self clearanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 0.2);
	}
}

/*
	Name: function_e47c2324
	Namespace: namespace_ebc3fc57
	Checksum: 0x95B36EF
	Offset: 0x1038
	Size: 0xB4
	Parameters: 7
	Flags: Private
*/
function private function_e47c2324(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_f2668f6d = util::playfxontag(localclientnum, level._effect[#"hash_1dad8364594fae5d"], self, "tag_origin");
	}
	else if(isdefined(self.var_f2668f6d))
	{
		stopfx(localclientnum, self.var_f2668f6d);
	}
}

/*
	Name: function_f02b0934
	Namespace: namespace_ebc3fc57
	Checksum: 0xBA77B7F
	Offset: 0x10F8
	Size: 0x11C
	Parameters: 7
	Flags: Private
*/
function private function_f02b0934(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	position = self.origin;
	angles = self.angles;
	if(isdefined(position) && isdefined(angles))
	{
		playfx(localclientnum, level._effect[#"hash_648523e9c72ac0c9"], position, anglestoforward(angles), anglestoup(angles));
		function_2a9101fe(localclientnum, #"hash_7867f8f9aaaa0c40", position);
	}
	earthquake(localclientnum, 0.4, 0.8, self.origin, 300);
}

/*
	Name: function_7d5e27f4
	Namespace: namespace_ebc3fc57
	Checksum: 0x2C6225A7
	Offset: 0x1220
	Size: 0x5C
	Parameters: 7
	Flags: Private
*/
function private function_7d5e27f4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	function_36e4ebd4(localclientnum, "damage_heavy");
}

/*
	Name: function_75be2854
	Namespace: namespace_ebc3fc57
	Checksum: 0xB2E1515B
	Offset: 0x1288
	Size: 0x74
	Parameters: 7
	Flags: Private
*/
function private function_75be2854(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
	}
}

/*
	Name: function_958ba8d1
	Namespace: namespace_ebc3fc57
	Checksum: 0xCD83B78E
	Offset: 0x1308
	Size: 0x1BC
	Parameters: 5
	Flags: None
*/
function function_958ba8d1(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	var_166f3552 = 1000000;
	if(var_166f3552 > 0)
	{
		n_scale = (var_166f3552 - n_dist) / var_166f3552;
	}
	else
	{
		return;
	}
	if(n_scale > 1 || n_scale < 0)
	{
		return;
	}
	n_scale = n_scale * 0.25;
	if(n_scale <= 0.01)
	{
		return;
	}
	earthquake(localclientnum, n_scale, 0.1, pos, n_dist);
	if(n_scale <= 0.25 && n_scale > 0.2)
	{
		function_36e4ebd4(localclientnum, "anim_med");
	}
	else
	{
		if(n_scale <= 0.2 && n_scale > 0.1)
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
		else
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
	}
}

