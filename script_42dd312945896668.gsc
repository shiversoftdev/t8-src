// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\animation_shared.csc;

#namespace namespace_82497b8a;

/*
	Name: __init__system__
	Namespace: namespace_82497b8a
	Checksum: 0xF50E6CF3
	Offset: 0x520
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"mansion_ww", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_82497b8a
	Checksum: 0xF229A58C
	Offset: 0x568
	Size: 0x584
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_64f62d9a3170948e", 1, 1, "int", &function_70d8acdd, 0, 0);
	clientfield::register("actor", "" + #"hash_6848ec3d200d443b", 1, 1, "int", &shrink_zombie, 0, 0);
	clientfield::register("vehicle", "" + #"hash_6848ec3d200d443b", 1, 1, "int", &shrink_zombie, 0, 0);
	clientfield::register("actor", "" + #"hash_6f59675863e19a50", 1, 1, "int", &function_d8cf1bd7, 0, 0);
	clientfield::register("vehicle", "" + #"hash_6f59675863e19a50", 1, 1, "int", &function_d8cf1bd7, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_32156a79f13e8c37", 1, 1, "int", &function_751c64a4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_30c86f39ae8ea002", 1, 1, "int", &function_7fe3e4c8, 0, 0);
	clientfield::register("actor", "" + #"hash_1dd40649a6474f30", 1, 1, "int", &function_1af615a9, 0, 0);
	clientfield::register("vehicle", "" + #"hash_1dd40649a6474f30", 1, 1, "int", &function_1af615a9, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_12b19992ccb300e7", 1, 1, "int", &function_ac54fdec, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_54fdcf7f8eb5449e", 1, 1, "int", &function_176a239f, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_69b312bcaae6308b", 1, 1, "int", &function_68a87cde, 0, 0);
	clientfield::register("actor", "" + #"hash_2ff818c8cb4c17ba", 1, 1, "int", &function_332e7c58, 0, 0);
	clientfield::register("vehicle", "" + #"hash_2ff818c8cb4c17ba", 1, 1, "int", &function_3b7e3b9, 0, 0);
	clientfield::register("actor", "" + #"hash_3bedaaea2c17af23", 1, 1, "int", &function_dd9a8d7c, 0, 0);
	clientfield::register("vehicle", "" + #"hash_3bedaaea2c17af23", 1, 1, "int", &function_51595e12, 0, 0);
}

/*
	Name: function_70d8acdd
	Namespace: namespace_82497b8a
	Checksum: 0x278F518B
	Offset: 0xAF8
	Size: 0x1CC
	Parameters: 7
	Flags: Linked
*/
function function_70d8acdd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	v_up = vectorscale((1, 0, 0), 360);
	v_forward = vectorscale((0, 0, 1), 360);
	if(newval == 1)
	{
		self.fx_globe = playfx(localclientnum, "zm_weapons/fx8_www_shrink_globe", self.origin, v_forward, v_up);
		if(!isdefined(self.var_66db8b1a))
		{
			self playsound(localclientnum, #"hash_fe927ec8b31e2d");
			self.var_66db8b1a = self playloopsound(#"hash_57b1409fb6e001f3");
		}
	}
	else
	{
		if(isdefined(self.fx_globe))
		{
			stopfx(localclientnum, self.fx_globe);
			self.fx_globe = undefined;
		}
		playfx(localclientnum, "zm_weapons/fx8_www_shrink_globe_death", self.origin, v_forward, v_up);
		if(isdefined(self.var_66db8b1a))
		{
			self stoploopsound(self.var_66db8b1a);
			self.var_66db8b1a = undefined;
			self playsound(localclientnum, #"hash_12c7ff63913e6a34");
		}
	}
}

/*
	Name: shrink_zombie
	Namespace: namespace_82497b8a
	Checksum: 0x3C18894
	Offset: 0xCD0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function shrink_zombie(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_847080fa(localclientnum);
	}
}

/*
	Name: function_847080fa
	Namespace: namespace_82497b8a
	Checksum: 0x7AB55644
	Offset: 0xD38
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function function_847080fa(localclientnum)
{
	e_model = util::spawn_anim_model(localclientnum, self.model, self.origin, self.angles);
	if(!isdefined(e_model))
	{
		return;
	}
	self.var_d8b9c4bf = 1;
	if(isdefined(self.head))
	{
		e_model attach(self.head, "J_Head");
	}
	playsound(localclientnum, #"hash_1b7646cdadf52c4d", self.origin + vectorscale((0, 0, 1), 35));
	switch(self.archetype)
	{
		case "zombie":
		{
			var_99d5ab4f = #"hash_468160681f4a3b5d";
			break;
		}
		case "nosferatu":
		{
			var_99d5ab4f = #"hash_301e2a321dba18b0";
			break;
		}
		case "bat":
		{
			var_99d5ab4f = #"hash_38d93968ebc6c95a";
			break;
		}
	}
	if(isdefined(var_99d5ab4f))
	{
		e_model thread scene::play(var_99d5ab4f, e_model);
	}
	var_1f698175 = 1;
	var_cf6d072d = 0.02;
	while(var_1f698175 > 0.1)
	{
		waitframe(1);
		var_1f698175 = var_1f698175 - var_cf6d072d;
		if(var_1f698175 > 0)
		{
			e_model setscale(var_1f698175);
		}
		var_cf6d072d = var_cf6d072d * 1.004333;
	}
	playsound(localclientnum, #"hash_6abe8c2d3548831c", e_model.origin + vectorscale((0, 0, 1), 35));
	playfx(localclientnum, "zm_weapons/fx8_www_shrink_enemy_death", e_model.origin + vectorscale((0, 0, 1), 35));
	e_model delete();
}

/*
	Name: function_d8cf1bd7
	Namespace: namespace_82497b8a
	Checksum: 0x438669C6
	Offset: 0xFD8
	Size: 0xA2
	Parameters: 7
	Flags: Linked
*/
function function_d8cf1bd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_121a6632))
	{
		stopfx(localclientnum, self.var_121a6632);
		self.var_121a6632 = undefined;
	}
	if(newval)
	{
		self.var_121a6632 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_shrink_enemy_torso", self, "j_spine4");
	}
}

/*
	Name: function_751c64a4
	Namespace: namespace_82497b8a
	Checksum: 0x103E7DC1
	Offset: 0x1088
	Size: 0x1F4
	Parameters: 7
	Flags: Linked
*/
function function_751c64a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	v_up = vectorscale((1, 0, 0), 360);
	v_forward = vectorscale((0, 0, 1), 360);
	if(!isdefined(self.sound_origin))
	{
		self.sound_origin = self.origin + vectorscale((0, 0, 1), 50);
	}
	if(newval == 1)
	{
		self.registerplayer_lift_clipbamfupdate = playfx(localclientnum, "zm_weapons/fx8_www_dazed_vortex", self.origin, v_forward, v_up);
		playsound(localclientnum, #"hash_65790bfd14f9d80e", self.sound_origin);
		audio::playloopat(#"hash_23133277b3364bd2", self.sound_origin);
	}
	else
	{
		if(isdefined(self.registerplayer_lift_clipbamfupdate))
		{
			stopfx(localclientnum, self.registerplayer_lift_clipbamfupdate);
			self.registerplayer_lift_clipbamfupdate = undefined;
		}
		v_origin = self.origin;
		playsound(localclientnum, #"hash_1bb8f665af965ffb", self.sound_origin);
		audio::stoploopat(#"hash_23133277b3364bd2", self.sound_origin);
		wait(1);
		playfx(localclientnum, "zm_weapons/fx8_www_dazed_vortex_end", v_origin, v_forward, v_up);
	}
}

/*
	Name: function_7fe3e4c8
	Namespace: namespace_82497b8a
	Checksum: 0xEC2CC353
	Offset: 0x1288
	Size: 0xAE
	Parameters: 7
	Flags: Linked
*/
function function_7fe3e4c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_22166a07 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_dazed_bubble_trail", self, "tag_eye");
	}
	else if(isdefined(self.var_22166a07))
	{
		stopfx(localclientnum, self.var_22166a07);
		self.var_22166a07 = undefined;
	}
}

/*
	Name: function_1af615a9
	Namespace: namespace_82497b8a
	Checksum: 0xCCB8F904
	Offset: 0x1340
	Size: 0xFE
	Parameters: 7
	Flags: Linked
*/
function function_1af615a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		sound_origin = self gettagorigin("j_head");
		playsound(localclientnum, #"hash_483ba5ccc74b82ae", sound_origin);
		self.var_3403f7a9 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_dazed_enemy_glow_eye", self, "j_head");
	}
	else if(isdefined(self.var_3403f7a9))
	{
		stopfx(localclientnum, self.var_3403f7a9);
		self.var_3403f7a9 = undefined;
	}
}

/*
	Name: function_ac54fdec
	Namespace: namespace_82497b8a
	Checksum: 0xD84E198B
	Offset: 0x1448
	Size: 0x1AE
	Parameters: 7
	Flags: Linked
*/
function function_ac54fdec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_up = vectorscale((1, 0, 0), 360);
		v_forward = vectorscale((0, 0, 1), 360);
		self.fx_tornado = playfx(localclientnum, "zm_weapons/fx8_www_spin_tornado", self.origin, v_forward, v_up);
		if(!isdefined(self.sound_origin))
		{
			self.sound_origin = self.origin + vectorscale((0, 0, 1), 50);
			playsound(localclientnum, #"hash_2d629f848398a470", self.sound_origin);
			audio::playloopat(#"hash_5a6410f04ce4b3a0", self.sound_origin);
		}
	}
	else
	{
		if(isdefined(self.sound_origin))
		{
			playsound(localclientnum, #"hash_49211352d3711451", self.sound_origin);
			audio::stoploopat(#"hash_5a6410f04ce4b3a0", self.sound_origin);
		}
		if(isdefined(self.fx_tornado))
		{
			stopfx(localclientnum, self.fx_tornado);
			self.fx_tornado = undefined;
		}
	}
}

/*
	Name: function_176a239f
	Namespace: namespace_82497b8a
	Checksum: 0xFAB3A711
	Offset: 0x1600
	Size: 0x1E4
	Parameters: 7
	Flags: Linked
*/
function function_176a239f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.fx_portal = util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_portal", self, "tag_origin");
		if(!isdefined(self.sound_origin))
		{
			self.sound_origin = self.origin + vectorscale((0, 0, 1), 50);
			playsound(localclientnum, #"hash_457eb103eafefe25", self.sound_origin);
			audio::playloopat(#"hash_31a9e607641ce8eb", self.sound_origin);
			self thread function_872ccd5b(#"hash_31a9e607641ce8eb", #"hash_3ab7968f3d5362bc");
		}
	}
	else
	{
		if(isdefined(self.sound_origin))
		{
			self notify(#"hash_d35390d5b5c613b");
			playsound(localclientnum, #"hash_3ab7968f3d5362bc", self.sound_origin);
			audio::stoploopat(#"hash_31a9e607641ce8eb", self.sound_origin);
		}
		if(isdefined(self.fx_portal))
		{
			killfx(localclientnum, self.fx_portal);
			self.fx_portal = undefined;
		}
		util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_portal_end", self, "tag_origin");
	}
}

/*
	Name: function_872ccd5b
	Namespace: namespace_82497b8a
	Checksum: 0x8C32FA82
	Offset: 0x17F0
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_872ccd5b(var_ff3c5ccc, var_fc01b069)
{
	self endon(#"hash_d35390d5b5c613b");
	a_origin = self.sound_origin;
	self waittill(#"death");
	playsound(0, var_fc01b069, a_origin);
	audio::stoploopat(var_ff3c5ccc, a_origin);
}

/*
	Name: function_68a87cde
	Namespace: namespace_82497b8a
	Checksum: 0x56CA364B
	Offset: 0x1880
	Size: 0xA2
	Parameters: 7
	Flags: Linked
*/
function function_68a87cde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_39a7e416))
	{
		stopfx(localclientnum, self.var_39a7e416);
		self.var_39a7e416 = undefined;
	}
	if(newval)
	{
		self.var_39a7e416 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_ash_trail", self, "tag_origin");
	}
}

/*
	Name: function_332e7c58
	Namespace: namespace_82497b8a
	Checksum: 0x47141094
	Offset: 0x1930
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_332e7c58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread function_9fe38370(localclientnum, newval, "j_spine4");
}

/*
	Name: function_3b7e3b9
	Namespace: namespace_82497b8a
	Checksum: 0xA3600CE3
	Offset: 0x19A0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_3b7e3b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread function_9fe38370(localclientnum, newval, "tag_chest_ws");
}

/*
	Name: function_9fe38370
	Namespace: namespace_82497b8a
	Checksum: 0xD4E5BB55
	Offset: 0x1A10
	Size: 0xF4
	Parameters: 3
	Flags: Linked
*/
function function_9fe38370(localclientnum, newval, str_tag)
{
	if(isdefined(self.var_4b8417f6))
	{
		stopfx(localclientnum, self.var_4b8417f6);
		self.var_4b8417f6 = undefined;
	}
	if(newval)
	{
		self.var_4b8417f6 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_torso", self, str_tag);
		if(self.archetype === #"zombie" || self.archetype === #"nosferatu")
		{
			self thread function_84884488(localclientnum);
		}
		self playsound(localclientnum, #"hash_71ccbe40ffaafe22");
	}
}

/*
	Name: function_84884488
	Namespace: namespace_82497b8a
	Checksum: 0xC162B4D4
	Offset: 0x1B10
	Size: 0x33C
	Parameters: 1
	Flags: Linked
*/
function function_84884488(localclientnum)
{
	self endon(#"death");
	self zm_utility::good_barricade_damaged(localclientnum);
	wait(0.7);
	self playrenderoverridebundle(#"hash_429426f01ad84c8b");
	wait(0.7);
	if(self.archetype === #"zombie" || self.archetype === #"catalyst" || self.archetype === #"nosferatu")
	{
		if(!isdefined(level.var_4fea6622))
		{
			level.var_4fea6622 = 0;
		}
		self thread function_30c6d85();
		util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_torso", self, "j_spine4");
		util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_waist", self, "j_spinelower");
		util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_head", self, "j_head");
		if(level.var_4fea6622 < 9)
		{
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_left", self, "j_elbow_le");
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_right", self, "j_elbow_ri");
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_left", self, "j_hip_le");
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_right", self, "j_hip_ri");
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_leg_left", self, "j_knee_le");
			util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_leg_right", self, "j_knee_ri");
		}
		else if(level.var_4fea6622 < 17)
		{
			if(math::cointoss())
			{
				util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_left", self, "j_elbow_le");
			}
			else
			{
				util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_right", self, "j_elbow_ri");
			}
			if(math::cointoss())
			{
				util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_left", self, "j_hip_le");
			}
			else
			{
				util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_right", self, "j_hip_ri");
			}
		}
	}
}

/*
	Name: function_30c6d85
	Namespace: namespace_82497b8a
	Checksum: 0x5D8DAE43
	Offset: 0x1E58
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_30c6d85()
{
	level.var_4fea6622++;
	/#
		iprintlnbold("" + level.var_4fea6622);
	#/
	self waittilltimeout(1.2, #"death");
	level.var_4fea6622--;
	/#
		iprintlnbold("" + level.var_4fea6622);
	#/
}

/*
	Name: function_dd9a8d7c
	Namespace: namespace_82497b8a
	Checksum: 0xB244000
	Offset: 0x1EF8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_dd9a8d7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread function_df636944(localclientnum, newval, "j_spine4");
}

/*
	Name: function_51595e12
	Namespace: namespace_82497b8a
	Checksum: 0x51031DFD
	Offset: 0x1F68
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_51595e12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread function_df636944(localclientnum, newval, "tag_chest_ws");
}

/*
	Name: function_df636944
	Namespace: namespace_82497b8a
	Checksum: 0x9CC045B4
	Offset: 0x1FD8
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_df636944(localclientnum, newval, str_tag)
{
	util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_death", self, str_tag);
}

