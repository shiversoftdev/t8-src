// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_11c9779550732489;
#using script_1611421ee9b880d3;
#using script_1de1583a62cc580f;
#using script_20bca15cf8b82d6b;
#using script_23037fdea02db280;
#using script_27ba6748d83412fd;
#using script_28d5e820ed15e2a7;
#using script_2c454d63a96d2d0b;
#using script_3619535866efa23a;
#using script_3a10f19f96036e97;
#using script_3c345dd878d144b7;
#using script_3d09dc1e349814c;
#using script_43de70169069c6ab;
#using script_4f8f41168a7c3ea8;
#using script_5db30ea2f37108d;
#using script_5e109f38777fc309;
#using script_5fb8da2731850d9e;
#using script_67051bc8c81031aa;
#using script_673ffe64518b7ffb;
#using script_675455e5e6c0c5ad;
#using script_6a0e50bc15d725a9;
#using script_711bbbba637da80;
#using script_76b36ed1b7a51ed2;
#using script_784bc1aee23dbf1f;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_escape_fx.csc;
#using scripts\zm\zm_escape_pap_quest.csc;
#using scripts\zm\zm_escape_traps.csc;
#using scripts\zm\zm_escape_util.csc;
#using scripts\zm\zm_escape_weap_quest.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_escape;

/*
	Name: opt_in
	Namespace: zm_escape
	Checksum: 0x7C6A5319
	Offset: 0x558
	Size: 0xC4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	system::ignore(#"hash_746f7956b9307f72");
	system::ignore(#"hash_1b45fa71df7a015f");
	system::ignore(#"hash_2aa13876578b1f89");
	system::ignore(#"hash_19637d14ae86b4ec");
	system::ignore(#"hash_2c7981ab6ce5ed74");
}

/*
	Name: main
	Namespace: zm_escape
	Checksum: 0xD6FC12BA
	Offset: 0x628
	Size: 0x78C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "" + #"player_lives", 1, 2, "int", undefined, 0, 0);
	clientfield::register("toplayer", "" + #"rumble_gondola", 1, 1, "int", &rumble_gondola, 0, 0);
	clientfield::register("toplayer", "" + #"hash_51b0de5e2b184c28", 1, 1, "int", &function_1bccf046, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4be2ce4248d80d22", 1, 1, "int", &function_e6537e9f, 0, 0);
	clientfield::register("world", "" + #"hash_24deaa9795e06d41", 1, 1, "int", &function_eef4ae09, 0, 0);
	clientfield::register("world", "" + #"hash_4a8a7b58bf6cd5d8", 1, 1, "int", &function_516663f8, 0, 0);
	clientfield::register("world", "" + #"hash_29fea4571b8649a0", 1, 1, "int", &function_d8b90aba, 0, 0);
	clientfield::register("world", "" + #"hash_cd028842e18845e", 1, 1, "counter", &function_a104a4cb, 0, 0);
	clientfield::register("allplayers", "" + #"hash_500a87b29014ef02", 1, 1, "int", &function_5e901c8c, 0, 1);
	clientfield::register("toplayer", "" + #"hash_237e298fc7414687", 1, 1, "int", &function_b06125f0, 0, 1);
	clientfield::register("vehicle", "" + #"hash_4fe04b8fa56a05c6", 1, 1, "int", &function_4b10227f, 0, 1);
	namespace_f2502da8::init_clientfields();
	namespace_9d58c1cd::init_clientfields();
	namespace_54386dac::init_clientfields();
	namespace_69ddf44f::init();
	namespace_1063645::init_clientfields();
	namespace_b99141ed::init_clientfields();
	zm_utility::function_beed5764("rob_zm_eyes_red", #"zm_ai/fx8_zombie_eye_glow_red");
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"hash_4d2e5c87bde94856"] = #"hash_4948d849a833ddd5";
	level._effect[#"hash_6dcb1f6ae15079d5"] = #"hash_52f9d9bb5648c0f3";
	level._effect[#"hash_4fe04b8fa56a05c6"] = #"hash_45dbe6888cf8a19c";
	namespace_f2502da8::init_fx();
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_d0ab70a2 = #"hash_241c0e86d7b363e9";
	level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_2ac7ec38d265c496";
	level._effect[#"chest_light_closed"] = #"hash_5b118cefec864e37";
	level._effect[#"hash_9d26763cbe16490"] = #"hash_5a9159bef624d260";
	level._effect[#"hash_3f4d31da2ef72dbe"] = #"hash_2b008afec3e70add";
	level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
	level.var_5603a802 = "pstfx_zm_hellhole";
	namespace_9d58c1cd::init();
	pap_quest::init();
	load::main();
	level thread setup_personality_character_exerts();
	exploder::exploder("lgt_vending_mulekick_on");
	util::waitforclient(0);
	level thread function_9290b227();
}

/*
	Name: rumble_gondola
	Namespace: zm_escape
	Checksum: 0xC1F046E8
	Offset: 0xDC0
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function rumble_gondola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	self endon(#"disconnect");
	if(newval == 1)
	{
		self endon(#"hash_6d7afe7c92e095d8");
		while(true)
		{
			if(isinarray(getlocalplayers(), self))
			{
				self playrumbleonentity(localclientnum, "reload_small");
			}
			wait(0.25);
		}
	}
	else
	{
		self notify(#"hash_6d7afe7c92e095d8");
		if(isinarray(getlocalplayers(), self))
		{
			self playrumbleonentity(localclientnum, "damage_heavy");
		}
	}
}

/*
	Name: function_1bccf046
	Namespace: zm_escape
	Checksum: 0xC0B49716
	Offset: 0xF00
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_1bccf046(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	self endon(#"disconnect");
	if(newval == 1)
	{
		self endon(#"hash_2e4f137d472e68e9");
		while(true)
		{
			self playrumbleonentity(localclientnum, "reload_small");
			wait(0.25);
		}
	}
	else
	{
		self notify(#"hash_2e4f137d472e68e9");
	}
}

/*
	Name: function_eef4ae09
	Namespace: zm_escape
	Checksum: 0x9E601F9A
	Offset: 0xFD8
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_eef4ae09(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
	playrumbleonposition(localclientnum, "zm_escape_warden_catwalk_rumble", s_catwalk_lava_exp.origin);
}

/*
	Name: function_a104a4cb
	Namespace: zm_escape
	Checksum: 0x53879E99
	Offset: 0x1068
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_a104a4cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_83771283 = struct::get("s_break_large_metal");
	playrumbleonposition(localclientnum, "zm_escape_metal_rumble1", var_83771283.origin);
	wait(3);
	playrumbleonposition(localclientnum, "zm_escape_metal_rumble2", var_83771283.origin);
	wait(5);
	playrumbleonposition(localclientnum, "zm_escape_metal_rumble3", var_83771283.origin);
}

/*
	Name: function_516663f8
	Namespace: zm_escape
	Checksum: 0x7BECEAAE
	Offset: 0x1158
	Size: 0x60
	Parameters: 7
	Flags: Linked
*/
function function_516663f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
	}
	else
	{
		level notify(#"hash_46a6202f04dd1722");
	}
}

/*
	Name: function_37c86e6e
	Namespace: zm_escape
	Checksum: 0xB7A33BAB
	Offset: 0x11C0
	Size: 0x70
	Parameters: 1
	Flags: Private
*/
private function function_37c86e6e(localclientnum)
{
	level endon(#"hash_46a6202f04dd1722");
	s_sound_origin = struct::get("s_b_64_sound");
	while(true)
	{
		wait(randomfloatrange(3, 5));
	}
}

/*
	Name: function_d8b90aba
	Namespace: zm_escape
	Checksum: 0xEFBDD6F9
	Offset: 0x1238
	Size: 0x78
	Parameters: 7
	Flags: Linked
*/
function function_d8b90aba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		level thread function_b2b92c61(localclientnum);
	}
	else
	{
		level notify(#"hash_63732bb5f380f042");
	}
}

/*
	Name: function_b2b92c61
	Namespace: zm_escape
	Checksum: 0x477054F6
	Offset: 0x12B8
	Size: 0x68
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b2b92c61(localclientnum)
{
	level endon(#"hash_63732bb5f380f042");
	while(true)
	{
		exploder::exploder("fxexp_building64_lightning");
		wait(randomfloatrange(1.5, 3));
	}
}

/*
	Name: function_e6537e9f
	Namespace: zm_escape
	Checksum: 0x807CEC85
	Offset: 0x1328
	Size: 0x13A
	Parameters: 7
	Flags: Linked
*/
function function_e6537e9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.n_fx_id))
	{
		stopfx(localclientnum, self.n_fx_id);
		self.n_fx_id = undefined;
	}
	if(isdefined(self.var_b3673abf))
	{
		self stoploopsound(self.var_b3673abf);
		self.var_b3673abf = undefined;
	}
	if(newval)
	{
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"switch_sparks"], self, "tag_origin");
		playsound(localclientnum, #"hash_3281ee130e7c69e", self.origin);
		self.var_b3673abf = self playloopsound(#"hash_27ae537b191e913d");
	}
}

/*
	Name: function_5e901c8c
	Namespace: zm_escape
	Checksum: 0x4D18C533
	Offset: 0x1470
	Size: 0x102
	Parameters: 7
	Flags: Linked
*/
function function_5e901c8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_7a27c968) && self zm_utility::function_f8796df3(localclientnum))
	{
		deletefx(localclientnum, self.var_7a27c968);
		self.var_7a27c968 = undefined;
	}
	if(newval)
	{
		if(function_65b9eb0f(localclientnum))
		{
			return;
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
		}
		else
		{
			self.var_7a27c968 = util::playfxontag(localclientnum, level._effect[#"hash_6dcb1f6ae15079d5"], self, "j_head");
		}
	}
}

/*
	Name: function_b06125f0
	Namespace: zm_escape
	Checksum: 0x70DF06EF
	Offset: 0x1580
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_b06125f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		setpbgactivebank(localclientnum, 4);
	}
	else
	{
		setpbgactivebank(localclientnum, 1);
	}
}

/*
	Name: function_9290b227
	Namespace: zm_escape
	Checksum: 0x12ECE5EF
	Offset: 0x1608
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_9290b227()
{
	wait(2);
	loopers = struct::get_array("spawn_location", "script_noteworthy");
	if(isdefined(loopers) && loopers.size > 0)
	{
		delay = 0;
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println("" + loopers.size + "");
			}
		#/
		for(i = 0; i < loopers.size; i++)
		{
			loopers[i] thread soundloopthink();
			delay = delay + 1;
			if(delay % 20 == 0)
			{
				waitframe(1);
			}
		}
	}
	println("");
}

/*
	Name: soundloopthink
	Namespace: zm_escape
	Checksum: 0xA4AFE521
	Offset: 0x1778
	Size: 0x18A
	Parameters: 0
	Flags: Linked
*/
function soundloopthink()
{
	if(!isdefined(self.origin))
	{
		return;
	}
	if(!isdefined(self.script_sound))
	{
		self.script_sound = "zmb_spawn_walla";
	}
	notifyname = "";
	/#
		assert(isdefined(notifyname));
	#/
	if(isdefined(self.script_string))
	{
		notifyname = self.script_string;
	}
	/#
		assert(isdefined(notifyname));
	#/
	started = 1;
	if(isdefined(self.script_int))
	{
		started = self.script_int != 0;
	}
	if(started)
	{
		soundloopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
	}
	if(notifyname != "")
	{
		for(;;)
		{
			level waittill(notifyname);
			if(started)
			{
				soundstoploopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
			}
			else
			{
				soundloopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
			}
			started = !started;
		}
	}
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_escape
	Checksum: 0xDCE52C85
	Offset: 0x1910
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[5][#"playerbreathinsound"] = "vox_plr_5_exert_sniper_hold";
	level.exert_sounds[6][#"playerbreathinsound"] = "vox_plr_6_exert_sniper_hold";
	level.exert_sounds[7][#"playerbreathinsound"] = "vox_plr_7_exert_sniper_hold";
	level.exert_sounds[8][#"playerbreathinsound"] = "vox_plr_8_exert_sniper_hold";
	level.exert_sounds[5][#"playerbreathoutsound"] = "vox_plr_5_exert_sniper_exhale";
	level.exert_sounds[6][#"playerbreathoutsound"] = "vox_plr_6_exert_sniper_exhale";
	level.exert_sounds[7][#"playerbreathoutsound"] = "vox_plr_7_exert_sniper_exhale";
	level.exert_sounds[8][#"playerbreathoutsound"] = "vox_plr_8_exert_sniper_exhale";
	level.exert_sounds[5][#"playerbreathgaspsound"] = "vox_plr_5_exert_sniper_gasp";
	level.exert_sounds[6][#"playerbreathgaspsound"] = "vox_plr_6_exert_sniper_gasp";
	level.exert_sounds[7][#"playerbreathgaspsound"] = "vox_plr_7_exert_sniper_gasp";
	level.exert_sounds[8][#"playerbreathgaspsound"] = "vox_plr_8_exert_sniper_gasp";
	level.exert_sounds[5][#"meleeswipesoundplayer"] = "vox_plr_5_exert_punch_give";
	level.exert_sounds[6][#"meleeswipesoundplayer"] = "vox_plr_6_exert_punch_give";
	level.exert_sounds[7][#"meleeswipesoundplayer"] = "vox_plr_7_exert_punch_give";
	level.exert_sounds[8][#"meleeswipesoundplayer"] = "vox_plr_8_exert_punch_give";
}

/*
	Name: function_4b10227f
	Namespace: zm_escape
	Checksum: 0xE00E6FE1
	Offset: 0x1BA0
	Size: 0x7A
	Parameters: 7
	Flags: Linked
*/
function function_4b10227f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self.var_c4c53839 = util::playfxontag(localclientnum, level._effect[#"hash_4fe04b8fa56a05c6"], self, "tag_origin");
}

