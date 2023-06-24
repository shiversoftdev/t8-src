// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_transformation.csc;
#using scripts\core_common\ai\archetype_blight_father.csc;
#using scripts\zm\weapons\zm_weap_riotshield.csc;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_grappler.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_ai_blight_father;

/*
	Name: __init__system__
	Namespace: zm_ai_blight_father
	Checksum: 0x583617C3
	Offset: 0x778
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_blight_father", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_blight_father
	Checksum: 0x19CDF998
	Offset: 0x7C0
	Size: 0x7A4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"fx8_blightfather_weakspot_sack_amb"] = "zm_ai/fx8_blightfather_weakspot_sack_amb";
	level._effect[#"fx8_blightfather_weakspot_elbow_amb"] = "zm_ai/fx8_blightfather_weakspot_elbow_amb";
	level._effect[#"fx8_blightfather_weakspot_jaw_amb"] = "zm_ai/fx8_blightfather_weakspot_jaw_amb";
	level._effect[#"fx8_plyr_pstfx_vomit_loop"] = "player/fx8_plyr_pstfx_vomit_loop";
	level._effect[#"fx8_blightfather_vomit"] = "zm_ai/fx8_blightfather_vomit";
	level._effect[#"fx8_blightfather_vomit_object"] = "zm_ai/fx8_blightfather_vomit_object";
	level._effect[#"fx8_blightfather_vomit_purchase"] = "zm_ai/fx8_blightfather_vomit_purchase";
	level._effect[#"fx8_blightfather_vomit_statue_purchase"] = "zm_ai/fx8_blightfather_vomit_statue_purchase";
	level._effect[#"fx8_blightfather_vomit_box_purchase"] = "zm_ai/fx8_blightfather_vomit_box_purchase";
	level._effect[#"fx8_blightfather_vomit_craft_purchase"] = "zm_ai/fx8_blightfather_vomit_craft_purchase";
	level._effect[#"fx8_blightfather_maggot_spawn_burst"] = "zm_ai/fx8_blightfather_maggot_spawn_burst";
	level._effect[#"fx8_blightfather_chaos_missle"] = "zm_ai/fx8_blightfather_chaos_missle";
	level._effect[#"fx8_blightfather_maggot_death_exp"] = "zm_ai/fx8_blightfather_maggot_death_exp";
	level.grappler_beam = "zod_blight_father_grapple_beam";
	footsteps::registeraitypefootstepcb(#"blight_father", &function_958ba8d1);
	clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int", &function_192c82f8, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int", &function_c6aa29ea, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int", &function_caf74103, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int", &function_bc64a2a, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int", &function_c4fff539, 0, 0);
	clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int", &function_de0a50df, 0, 0);
	clientfield::register("scriptmover", "blight_father_purchase_lockdown_vomit_fx", 1, 3, "int", &function_2c098ccc, 0, 0);
	clientfield::register("toplayer", "tongueGrabPostFx", 1, 1, "int", &tonguegrabpostfx, 0, 0);
	clientfield::register("toplayer", "tongueGrabRumble", 1, 1, "int", &tonguegrabrumble, 0, 0);
	clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int", &function_59f8f265, 0, 0);
	clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter", &function_67ad42f3, 0, 0);
	clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter", &function_f102952d, 0, 0);
	clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int", &function_75be2854, 0, 0);
	clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int", &function_e47c2324, 0, 0);
	clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int", &function_f02b0934, 0, 0);
	clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter", &function_7d5e27f4, 0, 0);
	clientfield::register("toplayer", "blight_father_vomit_postfx_clientfield", 1, 1, "int", &function_2d7f68ab, 0, 0);
	clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int", &function_7d5fa1ae, 0, 0);
	clientfield::register("actor", "blight_father_death_fx", 17000, 6, "int", &blightfatherdeathfx, 0, 0);
}

/*
	Name: blightfatherdeathfx
	Namespace: zm_ai_blight_father
	Checksum: 0xA9071F3F
	Offset: 0xF70
	Size: 0xDC
	Parameters: 7
	Flags: Linked, Private
*/
function private blightfatherdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		death_fx = function_4b885950(newval, 2, 3);
		origin = self gettagorigin("J_Spine4");
		if(!isdefined(origin))
		{
			origin = self.origin;
		}
		playfx(localclientnum, death_fx, origin);
	}
}

/*
	Name: function_7d5fa1ae
	Namespace: zm_ai_blight_father
	Checksum: 0xB9864878
	Offset: 0x1058
	Size: 0xBC
	Parameters: 7
	Flags: Linked, Private
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
	Namespace: zm_ai_blight_father
	Checksum: 0xE0DA6106
	Offset: 0x1120
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c6aa29ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_cc8c05d5 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_le");
	}
	else if(isdefined(self.var_cc8c05d5))
	{
		stopfx(localclientnum, self.var_cc8c05d5);
		self.var_cc8c05d5 = undefined;
	}
}

/*
	Name: function_caf74103
	Namespace: zm_ai_blight_father
	Checksum: 0xB26EA22D
	Offset: 0x11E8
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_caf74103(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_e844c6a2 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_ri");
	}
	else if(isdefined(self.var_e844c6a2))
	{
		stopfx(localclientnum, self.var_e844c6a2);
		self.var_e844c6a2 = undefined;
	}
}

/*
	Name: function_bc64a2a
	Namespace: zm_ai_blight_father
	Checksum: 0xD5F23433
	Offset: 0x12B0
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_bc64a2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_81531422 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_le_fx");
	}
	else if(isdefined(self.var_81531422))
	{
		stopfx(localclientnum, self.var_81531422);
		self.var_81531422 = undefined;
	}
}

/*
	Name: function_c4fff539
	Namespace: zm_ai_blight_father
	Checksum: 0xA5D89D1E
	Offset: 0x1378
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c4fff539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_40cb39ba = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_ri_fx");
	}
	else if(isdefined(self.var_40cb39ba))
	{
		stopfx(localclientnum, self.var_40cb39ba);
		self.var_40cb39ba = undefined;
	}
}

/*
	Name: function_de0a50df
	Namespace: zm_ai_blight_father
	Checksum: 0x78065E4C
	Offset: 0x1440
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_de0a50df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_2beadf7 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_jaw_amb"], self, "tag_jaw");
	}
	else if(isdefined(self.var_2beadf7))
	{
		stopfx(localclientnum, self.var_2beadf7);
		self.var_2beadf7 = undefined;
	}
}

/*
	Name: function_2c098ccc
	Namespace: zm_ai_blight_father
	Checksum: 0x1ED47521
	Offset: 0x1508
	Size: 0x1DA
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2c098ccc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			self.var_32caa02 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_purchase"], self, "tag_origin");
			break;
		}
		case 2:
		{
			self.var_32caa02 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_statue_purchase"], self, "tag_origin");
			break;
		}
		case 3:
		{
			self.var_32caa02 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_box_purchase"], self, "tag_origin");
			break;
		}
		case 4:
		{
			self.var_32caa02 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_craft_purchase"], self, "tag_origin");
			break;
		}
		default:
		{
			if(isdefined(self.var_32caa02))
			{
				stopfx(localclientnum, self.var_32caa02);
				self.var_32caa02 = undefined;
			}
		}
	}
}

/*
	Name: tonguegrabpostfx
	Namespace: zm_ai_blight_father
	Checksum: 0xC830EAC1
	Offset: 0x16F0
	Size: 0x84
	Parameters: 7
	Flags: Linked, Private
*/
function private tonguegrabpostfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self thread postfx::playpostfxbundle(#"pstfx_zm_tongue_grab");
	}
	else
	{
		self postfx::stoppostfxbundle("pstfx_zm_tongue_grab");
	}
}

/*
	Name: tonguegrabrumble
	Namespace: zm_ai_blight_father
	Checksum: 0x3159A754
	Offset: 0x1780
	Size: 0x114
	Parameters: 7
	Flags: Linked, Private
*/
function private tonguegrabrumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		if(self function_21c0fa55())
		{
			function_36e4ebd4(localclientnum, "grapple_collision");
			function_fe0ad36e(localclientnum, "grapple_reel");
		}
	}
	else if(self function_21c0fa55())
	{
		function_36e4ebd4(localclientnum, "grapple_detach");
		self stoprumble(localclientnum, "grapple_collision");
		self stoprumble(localclientnum, "grapple_reel");
	}
}

/*
	Name: function_59f8f265
	Namespace: zm_ai_blight_father
	Checksum: 0x4BC13E64
	Offset: 0x18A0
	Size: 0x116
	Parameters: 7
	Flags: Linked, Private
*/
function private function_59f8f265(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_b0d99f6 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit"], self, "tag_jaw");
	}
	else
	{
		if(newval == 2)
		{
			self.var_b0d99f6 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_jaw");
		}
		else if(isdefined(self.var_b0d99f6))
		{
			stopfx(localclientnum, self.var_b0d99f6);
			self.var_b0d99f6 = undefined;
		}
	}
}

/*
	Name: function_67ad42f3
	Namespace: zm_ai_blight_father
	Checksum: 0x3D6C50A0
	Offset: 0x19C0
	Size: 0x74
	Parameters: 7
	Flags: Linked, Private
*/
function private function_67ad42f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_le");
}

/*
	Name: function_f102952d
	Namespace: zm_ai_blight_father
	Checksum: 0x7AB2CF0E
	Offset: 0x1A40
	Size: 0x74
	Parameters: 7
	Flags: Linked, Private
*/
function private function_f102952d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_ri");
}

/*
	Name: function_192c82f8
	Namespace: zm_ai_blight_father
	Checksum: 0xBC6129B8
	Offset: 0x1AC0
	Size: 0xCC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_192c82f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		if(newval)
		{
			self setanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 1, 0.1, 1);
		}
		else
		{
			self clearanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 0.2);
		}
	}
}

/*
	Name: function_e47c2324
	Namespace: zm_ai_blight_father
	Checksum: 0xF35317D0
	Offset: 0x1B98
	Size: 0xB4
	Parameters: 7
	Flags: Linked, Private
*/
function private function_e47c2324(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_f2668f6d = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_chaos_missle"], self, "tag_origin");
	}
	else if(isdefined(self.var_f2668f6d))
	{
		stopfx(localclientnum, self.var_f2668f6d);
	}
}

/*
	Name: function_f02b0934
	Namespace: zm_ai_blight_father
	Checksum: 0xAB6EC5B0
	Offset: 0x1C58
	Size: 0x11C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_f02b0934(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	position = self.origin;
	angles = self.angles;
	if(isdefined(position) && isdefined(angles))
	{
		playfx(localclientnum, level._effect[#"fx8_blightfather_maggot_death_exp"], position, anglestoforward(angles), anglestoup(angles));
		function_2a9101fe(localclientnum, #"hash_7867f8f9aaaa0c40", position);
	}
	earthquake(localclientnum, 0.4, 0.8, self.origin, 300);
}

/*
	Name: function_7d5e27f4
	Namespace: zm_ai_blight_father
	Checksum: 0x3C8384A8
	Offset: 0x1D80
	Size: 0x5C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_7d5e27f4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	function_36e4ebd4(localclientnum, "damage_heavy");
}

/*
	Name: function_75be2854
	Namespace: zm_ai_blight_father
	Checksum: 0x3FA9999A
	Offset: 0x1DE8
	Size: 0x74
	Parameters: 7
	Flags: Linked, Private
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
	Namespace: zm_ai_blight_father
	Checksum: 0xC4CD524D
	Offset: 0x1E68
	Size: 0x1BC
	Parameters: 5
	Flags: Linked
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

/*
	Name: function_2d7f68ab
	Namespace: zm_ai_blight_father
	Checksum: 0x6941BCB6
	Offset: 0x2030
	Size: 0x13E
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2d7f68ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!self zm_utility::function_f8796df3(localclientnum))
	{
		return;
	}
	if(newval)
	{
		self.var_185f551 = playfxoncamera(localclientnum, level._effect[#"fx8_plyr_pstfx_vomit_loop"]);
		self postfx::playpostfxbundle("pstfx_zm_caustic_glob");
		self thread function_1a4f64a();
		self notify(#"hash_6bc06e9af30f987");
	}
	else
	{
		if(isdefined(self.var_185f551))
		{
			stopfx(localclientnum, self.var_185f551);
		}
		self postfx::exitpostfxbundle("pstfx_zm_caustic_glob");
		self notify(#"hash_3af6fe8d4a8fac02");
	}
}

/*
	Name: function_1a4f64a
	Namespace: zm_ai_blight_father
	Checksum: 0x3BFA437F
	Offset: 0x2178
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_1a4f64a()
{
	self notify("6dcd79d7489a1b1");
	self endon("6dcd79d7489a1b1");
	self endoncallback(&function_43ec7ca3, #"death");
	self.var_7fd3b200 = 0;
	self thread function_cf88b888();
	self waittill(#"hash_3af6fe8d4a8fac02");
	wait(1);
	self thread function_1ca2497b();
}

/*
	Name: function_cf88b888
	Namespace: zm_ai_blight_father
	Checksum: 0xE35416B2
	Offset: 0x2210
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_cf88b888()
{
	self notify("77cd1973e51a1a17");
	self endon("77cd1973e51a1a17");
	self endoncallback(&function_43ec7ca3, #"death", #"hash_3af6fe8d4a8fac02");
	var_893a571 = 0;
	self playrenderoverridebundle("rob_zm_viewarm_vomit");
	while(!var_893a571)
	{
		var_37159c8c = self.var_7fd3b200;
		var_72840ba5 = min(var_37159c8c + 0.05, 1);
		self.var_7fd3b200 = var_72840ba5;
		self function_78233d29("rob_zm_viewarm_vomit", "", "Threshold", var_72840ba5);
		if(var_72840ba5 >= 1)
		{
			var_893a571 = 1;
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_1ca2497b
	Namespace: zm_ai_blight_father
	Checksum: 0xA73DF2A2
	Offset: 0x2350
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_1ca2497b()
{
	self notify("6b4310a91dda8e0b");
	self endon("6b4310a91dda8e0b");
	self endoncallback(&function_43ec7ca3, #"death", #"hash_6bc06e9af30f987");
	var_e935ecce = 0;
	while(!var_e935ecce)
	{
		var_37159c8c = self.var_7fd3b200;
		var_72840ba5 = max(var_37159c8c - 0.025, 0);
		self.var_7fd3b200 = var_72840ba5;
		self function_78233d29("rob_zm_viewarm_vomit", "", "Threshold", var_72840ba5);
		if(var_72840ba5 <= 0)
		{
			self stoprenderoverridebundle("rob_zm_viewarm_vomit");
			var_e935ecce = 1;
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_43ec7ca3
	Namespace: zm_ai_blight_father
	Checksum: 0x3E947845
	Offset: 0x2488
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_43ec7ca3(str_notify)
{
	if(isdefined(self) && str_notify === "death")
	{
		if(self function_d2503806("rob_zm_viewarm_vomit"))
		{
			self function_f6e99a8d("rob_zm_viewarm_vomit");
		}
		localclientnum = self getlocalclientnumber();
		if(isdefined(self.var_185f551) && isdefined(localclientnum))
		{
			killfx(localclientnum, self.var_185f551);
			self.var_185f551 = undefined;
		}
		if(postfx::function_556665f2("pstfx_zm_caustic_glob"))
		{
			self postfx::stoppostfxbundle("pstfx_zm_caustic_glob");
		}
	}
}

