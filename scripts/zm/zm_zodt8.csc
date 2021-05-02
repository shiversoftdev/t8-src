// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_13e019f139d2aa4e;
#using script_234f79e7e5737561;
#using script_27ba6748d83412fd;
#using script_2a907fffc74a075d;
#using script_2c454d63a96d2d0b;
#using script_52ab76d6216ed2cc;
#using script_54a67b7ed7b385e6;
#using script_5504fe574aed77a8;
#using script_67051bc8c81031aa;
#using script_67b98aa634d9decc;
#using script_74f5ae6ffc8bd614;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_zodt8_gamemodes.csc;
#using scripts\zm\zm_zodt8_pap_quest.csc;
#using scripts\zm\zm_zodt8_sound.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_zodt8;

/*
	Name: opt_in
	Namespace: zm_zodt8
	Checksum: 0x7119845E
	Offset: 0x640
	Size: 0x32
	Parameters: 0
	Flags: AutoExec
*/
autoexec function opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	level.clientfieldaicheck = 1;
}

/*
	Name: main
	Namespace: zm_zodt8
	Checksum: 0xFD01DCBD
	Offset: 0x680
	Size: 0x864
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
	clientfield::register("vehicle", "pap_projectile_fx", 1, 1, "int", &pap_projectile_fx, 0, 0);
	clientfield::register("vehicle", "pap_projectile_end_fx", 1, 1, "counter", &pap_projectile_end_fx, 0, 0);
	clientfield::register("world", "narrative_trigger", 1, 1, "int", &function_94a217a5, 0, 0);
	clientfield::register("world", "sfx_waterdrain_fore", 1, 1, "int", &sfx_waterdrain_fore, 0, 0);
	clientfield::register("world", "sfx_waterdrain_aft", 1, 1, "int", &sfx_waterdrain_aft, 0, 0);
	clientfield::register("world", "" + #"hash_2994a957c49bf321", 1, 1, "int", &function_f31c22d6, 0, 0);
	clientfield::register("world", "" + #"hash_7e91637e80ad93", 1, 1, "int", &function_1e917f6a, 0, 0);
	clientfield::register("world", "" + #"hash_16cc25b3f87f06ad", 1, 1, "int", &function_53da552d, 0, 0);
	clientfield::register("world", "" + #"hash_7f2f74f05d1f1b75", 1, 2, "int", &function_5b0384a, 0, 0);
	clientfield::register("scriptmover", "tilt", 1, 1, "int", &tilt, 0, 0);
	clientfield::register("scriptmover", "change_wave_water_height", 1, 1, "int", &change_wave_water_height, 0, 0);
	clientfield::register("scriptmover", "update_wave_water_height", 1, 1, "counter", &update_wave_water_height, 0, 0);
	clientfield::register("scriptmover", "activate_sentinel_artifact", 1, 2, "int", &sentinel_artifact_activated, 0, 0);
	clientfield::register("scriptmover", "ocean_water", 1, 1, "int", &function_b7fc06b2, 0, 0);
	clientfield::register("toplayer", "water_splashies", 1, 1, "counter", &water_splashies, 0, 0);
	clientfield::register("toplayer", "water_drippies", 1, 1, "int", &water_drippies, 0, 0);
	clientfield::register("actor", "sndActorUnderwater", 1, 1, "int", &sndactorunderwater, 0, 1);
	setdvar(#"player_shallowwaterwadescale", 1);
	setdvar(#"player_waistwaterwadescale", 1);
	setdvar(#"hash_70d60913dea5aadd", 1);
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"hash_51c7bc3539ed5540"] = #"hash_6009053e911b946a";
	level._effect[#"hash_68213763a7707b92"] = #"hash_6c0eb029adb5f6c6";
	level.var_24cb6ae8 = findvolumedecalindexarray("cargo_hold_water_puddles");
	level.var_ec4c3b67 = findvolumedecalindexarray("engine_room_water_puddles");
	level.var_59d3631c = #"hash_129339f4a4da8ea2";
	level.var_d0ab70a2 = #"hash_3180c9ba4da02927";
	namespace_e80d0291::init();
	namespace_74905749::init();
	namespace_4a807bff::init();
	namespace_b45e3f05::init();
	namespace_57873b62::init();
	namespace_8f39dfb1::init();
	load::main();
	function_99e9d1fa();
	init_flags();
	namespace_64be5677::main();
	level thread setup_personality_character_exerts();
	callback::on_localplayer_spawned(&on_localplayer_spawned);
}

/*
	Name: on_localplayer_spawned
	Namespace: zm_zodt8
	Checksum: 0x85B54E1F
	Offset: 0xEF0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	var_71714553 = function_5c10bd79(localclientnum);
	var_71714553 function_24f8e5f9();
	var_630fc8b = var_71714553 isplayerswimmingunderwater();
	var_71714553 function_33eae096(localclientnum, var_630fc8b);
	if(function_65b9eb0f(localclientnum))
	{
		var_71714553 thread function_2dca9b5b(localclientnum, var_630fc8b);
		return;
	}
	var_71714553 thread function_efae9657(localclientnum, var_630fc8b);
}

/*
	Name: function_2dca9b5b
	Namespace: zm_zodt8
	Checksum: 0xC498BD49
	Offset: 0xFD8
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function function_2dca9b5b(localclientnum, var_630fc8b)
{
	level endon(#"game_ended");
	self endon_callback(&function_853e8354, #"death");
	var_50a1494c = var_630fc8b;
	while(isalive(self))
	{
		if(self isplayerswimmingunderwater())
		{
			if(!var_50a1494c)
			{
				self function_33eae096(localclientnum, 1);
				var_50a1494c = 1;
			}
		}
		else if(var_50a1494c)
		{
			self function_33eae096(localclientnum, 0);
			var_50a1494c = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_efae9657
	Namespace: zm_zodt8
	Checksum: 0x625F15DF
	Offset: 0x10D8
	Size: 0x230
	Parameters: 2
	Flags: Linked
*/
function function_efae9657(localclientnum, var_630fc8b)
{
	self notify("505c3419935f4f3e");
	self endon("505c3419935f4f3e");
	level endon(#"game_ended");
	self endon_callback(&function_853e8354, #"death");
	var_50a1494c = var_630fc8b;
	if(isalive(self))
	{
		var_8eeea2b6 = postfx::function_556665f2(#"hash_5249b3ef8b2f1988");
		if(var_50a1494c)
		{
			setpbgactivebank(localclientnum, 2);
			if(!var_8eeea2b6)
			{
				self thread postfx::playpostfxbundle(#"hash_5249b3ef8b2f1988");
			}
		}
		else if(self clientfield::get_to_player("" + #"hash_2c247373d6b00b33"))
		{
			setpbgactivebank(localclientnum, 4);
		}
		else
		{
			setpbgactivebank(localclientnum, 1);
		}
		if(var_8eeea2b6)
		{
			self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
		}
	}
	while(isalive(self))
	{
		if(var_50a1494c)
		{
			self waittill(#"underwater_end");
			self function_33eae096(localclientnum, 0);
			var_50a1494c = 0;
		}
		else
		{
			self waittill(#"underwater_begin");
			self function_33eae096(localclientnum, 1);
			var_50a1494c = 1;
		}
	}
}

/*
	Name: function_33eae096
	Namespace: zm_zodt8
	Checksum: 0x6CB745B7
	Offset: 0x1310
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function function_33eae096(localclientnum, var_50a1494c)
{
	if(var_50a1494c)
	{
		setpbgactivebank(localclientnum, 2);
		self thread postfx::playpostfxbundle(#"hash_5249b3ef8b2f1988");
		setsoundcontext("water_global", "under");
		self thread function_3353845b(localclientnum);
	}
	else
	{
		self notify(#"hash_32c7af154e6c4ded");
		if(self clientfield::get_to_player("" + #"hash_2c247373d6b00b33"))
		{
			setpbgactivebank(localclientnum, 4);
		}
		else
		{
			setpbgactivebank(localclientnum, 1);
		}
		self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
		setsoundcontext("water_global", "over");
	}
}

/*
	Name: function_24f8e5f9
	Namespace: zm_zodt8
	Checksum: 0x4848AC47
	Offset: 0x1468
	Size: 0x292
	Parameters: 0
	Flags: Linked
*/
function function_24f8e5f9()
{
	self.var_655d9e4b = 0;
	self.var_25e6f383 = 0;
	self.var_e95193b8 = [];
	self.var_e95193b8[0] = array(#"hash_505479d5e2f48a6", #"hash_505489d5e2f4a59", #"hash_505459d5e2f4540", #"hash_505469d5e2f46f3", #"hash_5054b9d5e2f4f72", #"hash_5054c9d5e2f5125", #"hash_505499d5e2f4c0c", #"hash_5054a9d5e2f4dbf", #"hash_5054f9d5e2f563e", #"hash_505509d5e2f57f1", #"hash_3744cc670a5b706b");
	self.var_e95193b8[1] = array(#"hash_3ecc851af829fe68", #"hash_3ecc861af82a001b", #"hash_3ecc871af82a01ce", #"hash_3ecc881af82a0381", #"hash_3ecc891af82a0534", #"hash_3ecc8a1af82a06e7", #"hash_3ecc8b1af82a089a", #"hash_3ecc8c1af82a0a4d", #"hash_3ecc7d1af829f0d0", #"hash_3ecc7e1af829f283", #"hash_5f880ad3af5e4911");
	self.var_e95193b8[2] = array(#"hash_5edf278d3c3f5192", #"hash_5edf288d3c3f5345", #"hash_5edf258d3c3f4e2c", #"hash_5edf268d3c3f4fdf", #"hash_5edf238d3c3f4ac6", #"hash_5edf248d3c3f4c79", #"hash_5edf218d3c3f4760", #"hash_5edf228d3c3f4913", #"hash_5edf2f8d3c3f5f2a", #"hash_5edf308d3c3f60dd", #"hash_74855cfd5f9acfcf");
}

/*
	Name: function_3353845b
	Namespace: zm_zodt8
	Checksum: 0xEE635593
	Offset: 0x1708
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_3353845b(localclientnum)
{
	level endon(#"game_ended");
	self endon_callback(&function_853e8354, #"death");
	self endon(#"hash_32c7af154e6c4ded");
	n_waittime = 5;
	var_d82f94cd = int(180 * 1000);
	n_chance = 3;
	if(self.var_25e6f383 > 10)
	{
		return;
	}
	while(true)
	{
		wait(n_waittime);
		if(n_chance >= randomint(100))
		{
			if(self.var_655d9e4b === 0 || gettime() - var_d82f94cd >= self.var_655d9e4b)
			{
				self playsound(localclientnum, self.var_e95193b8[function_21a3a673(0, 2)][self.var_25e6f383]);
				self.var_655d9e4b = gettime();
				self.var_25e6f383++;
				if(self.var_25e6f383 > 10)
				{
					return;
				}
			}
		}
	}
}

/*
	Name: function_853e8354
	Namespace: zm_zodt8
	Checksum: 0x621DD113
	Offset: 0x1888
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_853e8354(str_notify)
{
	self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
}

/*
	Name: init_flags
	Namespace: zm_zodt8
	Checksum: 0xFF34AD4E
	Offset: 0x18C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_13dc8f128d50bada");
}

/*
	Name: function_5b0384a
	Namespace: zm_zodt8
	Checksum: 0x4F2BF3CA
	Offset: 0x18F0
	Size: 0x16A
	Parameters: 7
	Flags: Linked
*/
function function_5b0384a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			level scene::stop(#"hash_1c8acc6c63abae2b", 1);
			level scene::delete_scene_spawned_ents(localclientnum, #"hash_1c8acc6c63abae2b");
			break;
		}
		case 1:
		{
			level thread scene::init(#"hash_1c8acc6c63abae2b");
			break;
		}
		case 2:
		{
			level thread scene::play(#"hash_1c8acc6c63abae2b", "Shot 2");
			break;
		}
		case 3:
		{
			level thread scene::play(#"hash_1c8acc6c63abae2b", "Shot 3");
			break;
		}
	}
}

/*
	Name: function_53da552d
	Namespace: zm_zodt8
	Checksum: 0x945EF126
	Offset: 0x1A68
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_53da552d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_a1b31107 = #"hash_d3b7cb6eb2177fb";
	var_cfa35904 = getweapon(#"hash_5b8d1ff4b772bd85");
	addzombieboxweapon(var_cfa35904, var_a1b31107, 0);
}

/*
	Name: function_94a217a5
	Namespace: zm_zodt8
	Checksum: 0x5C363EE6
	Offset: 0x1B10
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_94a217a5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "bunk_room");
	}
	else
	{
		function_73b1f242(localclientnum, "bunk_room");
	}
}

/*
	Name: function_99e9d1fa
	Namespace: zm_zodt8
	Checksum: 0xF53A68F5
	Offset: 0x1BA0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_99e9d1fa()
{
	setdvar(#"phys_buoyancy", 1);
	setdvar(#"hash_7016ead6b3c7a246", 1);
	function_d57eff0c("e_wave_water_mid", 3);
}

/*
	Name: function_f31c22d6
	Namespace: zm_zodt8
	Checksum: 0xE17C01FE
	Offset: 0x1C20
	Size: 0x138
	Parameters: 7
	Flags: Linked
*/
function function_f31c22d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, var_1e231644)
{
	if(newval)
	{
		foreach(index in level.var_24cb6ae8)
		{
			hidevolumedecal(index);
		}
	}
	else
	{
		foreach(index in level.var_24cb6ae8)
		{
			unhidevolumedecal(index);
		}
	}
}

/*
	Name: function_1e917f6a
	Namespace: zm_zodt8
	Checksum: 0x85E4869F
	Offset: 0x1D60
	Size: 0x138
	Parameters: 7
	Flags: Linked
*/
function function_1e917f6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, var_1e231644)
{
	if(newval)
	{
		foreach(index in level.var_ec4c3b67)
		{
			hidevolumedecal(index);
		}
	}
	else
	{
		foreach(index in level.var_ec4c3b67)
		{
			unhidevolumedecal(index);
		}
	}
}

/*
	Name: update_wave_water_height
	Namespace: zm_zodt8
	Checksum: 0xCA9EA6F9
	Offset: 0x1EA0
	Size: 0x17C
	Parameters: 7
	Flags: Linked
*/
function update_wave_water_height(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, var_1e231644)
{
	player = function_5c10bd79(localclientnum);
	player endon(#"death");
	player util::waittill_dobj(localclientnum);
	if(!self flag::exists("update_water"))
	{
		self flag::init("update_water");
	}
	if(self flag::get("update_water"))
	{
		self thread function_6749eef5(localclientnum);
	}
	else
	{
		var_b965688c = function_67b634e6(self.origin);
		setwavewaterheight(var_b965688c, self.origin[2]);
		function_d57eff0c(var_b965688c, self.angles[2] * -1);
	}
}

/*
	Name: change_wave_water_height
	Namespace: zm_zodt8
	Checksum: 0xFF167E3E
	Offset: 0x2028
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function change_wave_water_height(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, var_1e231644)
{
	level endon(#"demo_jump");
	if(newval)
	{
		if(!self flag::exists("update_water"))
		{
			self flag::init("update_water");
		}
		self flag::set("update_water");
		if(!self flag::exists("water_drained"))
		{
			self flag::init("water_drained");
		}
		self function_6749eef5(localclientnum);
		if(!self flag::get("water_drained"))
		{
			self flag::set("water_drained");
		}
		else
		{
			self flag::clear("water_drained");
		}
	}
	else
	{
		self flag::clear("update_water");
	}
}

/*
	Name: function_6749eef5
	Namespace: zm_zodt8
	Checksum: 0x16AB2EBE
	Offset: 0x21C0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_6749eef5(localclientnum)
{
	self notify("318e077d5d5c0461");
	self endon("318e077d5d5c0461");
	level endon(#"end_game");
	var_b965688c = function_67b634e6(self.origin);
	if(!self flag::get("water_drained"))
	{
		function_c1129a39(var_b965688c, (0, 0, -1), 30);
	}
	while(isdefined(self) && self flag::get("update_water"))
	{
		setwavewaterheight(var_b965688c, self.origin[2]);
		function_d57eff0c(var_b965688c, self.angles[2] * -1);
		waitframe(1);
	}
	function_c1129a39(var_b965688c, (0, 0, 0), 0);
}

/*
	Name: tilt
	Namespace: zm_zodt8
	Checksum: 0xA1000CC6
	Offset: 0x2308
	Size: 0x1A4
	Parameters: 7
	Flags: Linked
*/
function tilt(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify("17ae9b8c780a6d06");
	self endon("17ae9b8c780a6d06");
	if(newval)
	{
		while(isdefined(self) && isdefined(self.angles))
		{
			self set_gravity(5);
			n_pitch = self.angles[0];
			n_yaw = self.angles[1];
			n_roll = self.angles[2];
			function_bc159e32(localclientnum, n_pitch);
			function_ca443a8f(localclientnum, -1 * n_roll);
			function_1862912(localclientnum, -1 * n_yaw);
			waitframe(1);
		}
	}
	setdvar(#"phys_gravity_dir", (0, 0, 1));
	function_bc159e32(localclientnum, 0);
	function_ca443a8f(localclientnum, 0);
	function_1862912(localclientnum, 0);
}

/*
	Name: set_gravity
	Namespace: zm_zodt8
	Checksum: 0x414ED166
	Offset: 0x24B8
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function set_gravity(n_wait)
{
	if(!isdefined(level.var_566ca3af))
	{
		level.var_566ca3af = n_wait;
	}
	if(level.var_566ca3af >= n_wait)
	{
		if(level flag::get(#"hash_13dc8f128d50bada"))
		{
			return;
		}
		inversion = 1;
		if(level clientfield::get("newtonian_negation"))
		{
			inversion = -1;
		}
		if(isdefined(self) && isdefined(self.angles))
		{
			function_a1c09ed(-800 * inversion * anglestoup(self.angles));
		}
		level.var_566ca3af = 0;
	}
	else
	{
		level.var_566ca3af++;
	}
}

/*
	Name: sfx_waterdrain_fore
	Namespace: zm_zodt8
	Checksum: 0xC0A2D7BF
	Offset: 0x25C8
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function sfx_waterdrain_fore(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_origin = (-5, -5176, 574);
	str_notify = "change_water_height_fore";
	str_suffix = "_fore";
	if(newval)
	{
		function_46a22d9e(str_suffix, str_notify, a_origin);
	}
	else
	{
		function_f1d5b30a(str_suffix, str_notify, a_origin);
	}
}

/*
	Name: sfx_waterdrain_aft
	Namespace: zm_zodt8
	Checksum: 0x7B2351B9
	Offset: 0x2698
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function sfx_waterdrain_aft(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_origin = (0, 1145, 136);
	str_notify = "change_water_height_aft";
	str_suffix = "_aft";
	if(newval)
	{
		function_46a22d9e(str_suffix, str_notify, a_origin);
	}
	else
	{
		function_f1d5b30a(str_suffix, str_notify, a_origin);
	}
}

/*
	Name: function_46a22d9e
	Namespace: zm_zodt8
	Checksum: 0xC546A4DE
	Offset: 0x2760
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function function_46a22d9e(str_suffix, str_notify, a_origin)
{
	level notify(str_notify);
	playsound(0, "zmb_waterdrain_quad_start" + str_suffix, a_origin);
	audio::playloopat("zmb_waterdrain_quad_lp" + str_suffix, a_origin);
}

/*
	Name: function_f1d5b30a
	Namespace: zm_zodt8
	Checksum: 0x2E4E70FF
	Offset: 0x27D8
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function function_f1d5b30a(str_suffix, str_notify, a_origin)
{
	level notify(str_notify);
	playsound(0, "zmb_waterdrain_quad_end" + str_suffix, a_origin);
	audio::stoploopat("zmb_waterdrain_quad_lp" + str_suffix, a_origin);
}

/*
	Name: pap_projectile_fx
	Namespace: zm_zodt8
	Checksum: 0x4962E904
	Offset: 0x2850
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function pap_projectile_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_4b7a5b1b))
		{
			self.var_4b7a5b1b = util::playfxontag(localclientnum, level._effect[#"hash_51c7bc3539ed5540"], self, "tag_origin");
		}
		if(!isdefined(self.var_353ff2a))
		{
			self.var_353ff2a = self playloopsound(#"hash_2ac2bbbfef2face4");
		}
	}
	else if(newval == 0)
	{
		if(isdefined(self.var_4b7a5b1b))
		{
			stopfx(localclientnum, self.var_4b7a5b1b);
		}
		if(isdefined(self.var_353ff2a))
		{
			self stoploopsound(self.var_353ff2a);
		}
	}
}

/*
	Name: pap_projectile_end_fx
	Namespace: zm_zodt8
	Checksum: 0x5DFAF644
	Offset: 0x2990
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function pap_projectile_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_68213763a7707b92"], self, "tag_origin");
	}
}

/*
	Name: sentinel_artifact_activated
	Namespace: zm_zodt8
	Checksum: 0xFCE2DA2C
	Offset: 0x2A20
	Size: 0x2EC
	Parameters: 7
	Flags: Linked
*/
function sentinel_artifact_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"hash_4e794284db75a3f5"], self, "tag_fx_x_pos");
		self function_bf9d3071(#"hash_1589a47f2fdc6c67");
		self.sfx_id = self playloopsound(#"hash_66df9cab2c64f968");
	}
	else if(newval == 2)
	{
		if(isdefined(self.sfx_id))
		{
			self stoploopsound(self.sfx_id);
		}
		self playsound(localclientnum, #"hash_75b9c9ad6ebe8af2");
		self function_5d482e78(#"hash_1589a47f2fdc6c67");
		if(isdefined(self.fx))
		{
			stopfx(localclientnum, self.fx);
			self.fx = undefined;
		}
		util::playfxontag(localclientnum, level._effect[#"hash_493ce8ba1e437ab7"], self, "tag_fx_x_pos");
		while(isdefined(self) && self.model !== #"hash_2c0078538e398b4f")
		{
			waitframe(1);
		}
		self.fx = util::playfxontag(localclientnum, level._effect[#"hash_2b40b14fc8577053"], self, "tag_fx_x_pos");
		waitframe(1);
		self function_bf9d3071(#"hash_111d3e86bf2007e4");
	}
	else if(isdefined(self.fx))
	{
		stopfx(localclientnum, self.fx);
		self.fx = undefined;
	}
	self playsound(localclientnum, #"hash_5de064f33e9e49b8");
	self playsound(localclientnum, #"hash_3d8fef5997663b17");
}

/*
	Name: sndactorunderwater
	Namespace: zm_zodt8
	Checksum: 0x117B6112
	Offset: 0x2D18
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function sndactorunderwater(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self setsoundentcontext("water", "under");
	}
	else
	{
		self setsoundentcontext("water", "over");
	}
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_zodt8
	Checksum: 0xD3B63179
	Offset: 0x2DB8
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[1][#"playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
	level.exert_sounds[2][#"playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
	level.exert_sounds[3][#"playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
	level.exert_sounds[4][#"playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
	level.exert_sounds[1][#"playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
	level.exert_sounds[2][#"playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
	level.exert_sounds[3][#"playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
	level.exert_sounds[4][#"playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
	level.exert_sounds[1][#"playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
	level.exert_sounds[2][#"playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
	level.exert_sounds[3][#"playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
	level.exert_sounds[4][#"playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
	level.exert_sounds[1][#"meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
	level.exert_sounds[2][#"meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
	level.exert_sounds[3][#"meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
	level.exert_sounds[4][#"meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

/*
	Name: function_b7fc06b2
	Namespace: zm_zodt8
	Checksum: 0x870693B8
	Offset: 0x3048
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_b7fc06b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_17e1650c(4);
	wait(25);
	var_17623425 = 4;
	n_time = 0;
	var_1713b028 = 4 - 1 / 45 - 25 / 1;
	while(var_17623425 > 1)
	{
		n_time = n_time + 1;
		var_17623425 = var_17623425 - var_1713b028;
		function_17e1650c(var_17623425);
		wait(1);
	}
	function_17e1650c(1);
}

/*
	Name: water_splashies
	Namespace: zm_zodt8
	Checksum: 0xC4BB793B
	Offset: 0x3170
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function water_splashies(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self postfx::playpostfxbundle(#"hash_50d5d465e2b9b355");
}

/*
	Name: water_drippies
	Namespace: zm_zodt8
	Checksum: 0xE4566A83
	Offset: 0x31D8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function water_drippies(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_6fb10f5e27bb70c1");
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_6fb10f5e27bb70c1");
	}
}

