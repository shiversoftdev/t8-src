// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_13a302ecb87a29fe;
#using script_14d2d89964cae0b1;
#using script_168eb2ab39a74080;
#using script_1ebb85ae10368663;
#using script_21b99e2f421608bf;
#using script_27ba6748d83412fd;
#using script_2c454d63a96d2d0b;
#using script_2d9c4a173633aa72;
#using script_2e85434cebf2404b;
#using script_30ace59de1b1bb3a;
#using script_3cd7be071a3f1ce0;
#using script_42dd312945896668;
#using script_47c293f002042d7e;
#using script_5fb8da2731850d9e;
#using script_67051bc8c81031aa;
#using script_6b91760bb3045851;
#using script_6c494cd6189bb8dc;
#using script_74f5ae6ffc8bd614;
#using script_76b36ed1b7a51ed2;
#using script_7ef002db7fb88ad0;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\fx_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_mansion_pap_quest.csc;
#using scripts\zm\zm_mansion_sound.csc;
#using scripts\zm\zm_trap_electric.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_mansion;

/*
	Name: opt_in
	Namespace: zm_mansion
	Checksum: 0x41D971F3
	Offset: 0x348
	Size: 0x22
	Parameters: 0
	Flags: AutoExec
*/
autoexec function opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
}

/*
	Name: main
	Namespace: zm_mansion
	Checksum: 0xF975E723
	Offset: 0x378
	Size: 0xF24
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "player_lives", 8000, 2, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "zmhud.ammoModifierActive", 8000, 1, "int", undefined, 0, 0);
	clientfield::register("world", "" + #"hash_42e03f9ae74a1070", 8000, 1, "int", &function_64968a3c, 0, 0);
	clientfield::register("vehicle", "" + #"hash_602ae5683c010563", 8000, 1, "int", &function_94cf8d37, 0, 0);
	clientfield::register("vehicle", "" + #"hash_4bd91c5285da0899", 8000, 1, "counter", &function_cb417790, 0, 0);
	clientfield::register("scriptmover", "" + #"soul_fx", 8000, 1, "int", &namespace_b8f22955::soul_release, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_60051e21f8eb4af", 8000, 1, "int", &function_39b69f3f, 0, 0);
	clientfield::register("actor", "" + #"clock_zombie", 8000, 1, "int", &clock_zombie_fx, 0, 0);
	clientfield::register("actor", "" + #"hash_1d0080ad80fd0913", 8000, 1, "int", &function_8048af7e, 0, 0);
	clientfield::register("scriptmover", "" + #"blocker_fx", 8000, 1, "int", &function_328d64bd, 0, 0);
	clientfield::register("item", "" + #"hash_524ec892754aeb34", 8000, 1, "int", &function_d86e0cb2, 0, 0);
	clientfield::register("item", "" + #"hash_35ce4034ca7e543c", 8000, 3, "int", &function_46bf4199, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_487e544e29aa8e45", 8000, 1, "int", &function_97aef6ef, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_65180cdab951d111", 8000, getminbitcountfornum(3), "int", &function_be42dd6a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_44ee99a6591fe600", 8000, 1, "int", &function_9e061782, 0, 0);
	clientfield::register("toplayer", "" + #"hash_6a4f537da00ae3f9", 8000, 1, "int", &function_dba1f701, 0, 0);
	clientfield::register("world", "" + #"hash_7fcdc47572bdbafa", 8000, 1, "int", &function_ce859d3a, 0, 0);
	clientfield::register("scriptmover", "" + #"force_stream_model", 8000, 1, "int", &force_stream_model, 0, 0);
	clientfield::register("world", "" + #"hash_458d10e70473adfd", 8000, 1, "int", &function_8f06f775, 0, 0);
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"hash_6afea56d1e14f1c8"] = #"hash_6009053e911b946a";
	level._effect[#"hash_50da8a1de7ce18da"] = #"hash_6c0eb029adb5f6c6";
	level._effect[#"clock_zombie"] = #"hash_52239162cbb1d01f";
	level._effect[#"clock_zombie_le"] = #"hash_5a3bedd0f4e1fb20";
	level._effect[#"clock_zombie_ri"] = #"hash_5a7915d0f515ed36";
	level._effect[#"clock_zombie_eye"] = #"hash_482a9c9681f3db75";
	level._effect[#"wisp_impact"] = #"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm";
	level._effect[#"hash_60051e21f8eb4af"] = #"zombie/fx8_wallbuy_reveal";
	level._effect[#"hash_3bae53461accaa0b"] = #"hash_425c28d5fded81f2";
	level._effect[#"hash_1a4566b6595544b4"] = #"hash_5b773dbbac0012ff";
	level._effect[#"hash_1a46c58a5032bb15"] = #"zombie/fx_ritual_barrier_defend_door_wide_zod_zmb";
	level._effect[#"ww_pickup"] = #"hash_4b275679ef930b50";
	level._effect[#"hash_3e78192d5d719b68"] = #"hash_13ca5cb4f81f0469";
	level._effect[#"hash_6f8a5a3faaac0b2d"] = #"hash_531e5c5efe735df0";
	level._effect[#"hash_6e809770685a03ce"] = #"hash_57e793068bee3c8e";
	level._effect[#"hash_5b93caeacd0dbde4"] = #"hash_37a3c4156a246da4";
	level._effect[#"hash_6afea56d1e14f1c8"] = #"hash_6009053e911b946a";
	level._effect[#"hash_50da8a1de7ce18da"] = #"hash_6c0eb029adb5f6c6";
	level._effect[#"hash_55cc40c5ca8b259d"] = #"zombie/fx_ritual_sacrafice_glow_head_zod_zmb";
	level._effect[#"hash_679e221c06d83988"] = #"hash_3c61e7e3069ee8a7";
	level._effect[#"hash_85d57de38b76cc7"] = #"hash_10efddc69fbb6a0e";
	level._effect[#"hash_2568ad8792cec77f"] = #"hash_6596b5a56f027114";
	level._effect[#"hash_23cfdebb55c60d4f"] = #"hash_451dfa68b22333f2";
	level._effect[#"hash_5843ac84cb4761c0"] = #"hash_18ce7dc1f160283f";
	level._effect[#"hash_4f8200ee1c323836"] = #"hash_7f1680c009106243";
	level._effect[#"hash_5845fe8edb36108b"] = #"hash_674095d927cfe7cc";
	level._effect[#"hash_8f58d28b0b40b2d"] = #"hash_18d057b947ae0c00";
	level._effect[#"hash_36f6dd55e72db9a6"] = #"hash_59dbd1f9476a0415";
	level._effect[#"hash_487e544e29aa8e45"] = #"hash_7ad8856e251bee77";
	level._effect[#"hash_581c81003eac976f"] = #"hash_3def678deb7f4078";
	level._effect[#"artifact_activate"] = #"hash_464f27bfbf0ce7bf";
	level._effect[#"artifact_glow"] = #"hash_41b2c270f26faabc";
	level._effect[#"hash_6b03597da0a3c2ae"] = #"hash_43b3118edb88df8c";
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_d0ab70a2 = #"hash_67972fca091f2c13";
	namespace_a8113e97::init_clientfields();
	namespace_b6ca3ccc::init_clientfields();
	namespace_7922d3d4::init_clientfields();
	namespace_bfa7c2ed::init_clientfields();
	namespace_c2ad41c5::init();
	namespace_b8f22955::init_fx();
	namespace_b8f22955::init_clientfields();
	namespace_1bf74f9e::init();
	namespace_d0842c8b::init();
	namespace_59d4913f::init();
	namespace_a34af286::init();
	namespace_8f39dfb1::init();
	ai::add_archetype_spawn_function(#"zombie_dog", &zombie_dog_spawned);
	load::main();
	util::waitforclient(0);
	namespace_48607e17::main();
	setdvar(#"hash_6d05981efd5d8d74", 400);
}

/*
	Name: force_stream_model
	Namespace: zm_mansion
	Checksum: 0x589E6CF5
	Offset: 0x12A8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function force_stream_model(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(self.model);
	}
	else
	{
		stopforcestreamingxmodel(self.model);
	}
}

/*
	Name: function_8f06f775
	Namespace: zm_mansion
	Checksum: 0xACB6FE4D
	Offset: 0x1330
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_8f06f775(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreammaterial("t8_dirt_rocky_03_dark_rvl");
	}
	else
	{
		stopforcestreamingmaterial("t8_dirt_rocky_03_dark_rvl");
	}
}

/*
	Name: function_ce859d3a
	Namespace: zm_mansion
	Checksum: 0x28373510
	Offset: 0x13B8
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_ce859d3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_a5777754(localclientnum, "visgroup_mov");
}

/*
	Name: zombie_dog_spawned
	Namespace: zm_mansion
	Checksum: 0xE8B04CAC
	Offset: 0x1420
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function zombie_dog_spawned(localclientnum)
{
	self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"zm_ai/fx8_zombie_eye_glow_red");
	self callback::on_shutdown(&on_entity_shutdown);
}

/*
	Name: on_entity_shutdown
	Namespace: zm_mansion
	Checksum: 0x8469971
	Offset: 0x1488
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_entity_shutdown(localclientnum)
{
	if(isdefined(self))
	{
		self zm_utility::good_barricade_damaged(localclientnum);
	}
}

/*
	Name: function_64968a3c
	Namespace: zm_mansion
	Checksum: 0x6006253A
	Offset: 0x14C0
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function function_64968a3c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval == 1)
	{
		e_player = getlocalplayers()[localclientnum];
		e_player postfx::playpostfxbundle(#"hash_1d8a81ef0f5306db");
		e_player thread function_33593a44(localclientnum, 1, 2);
	}
	else
	{
		e_player = getlocalplayers()[localclientnum];
		e_player postfx::stoppostfxbundle(#"hash_1d8a81ef0f5306db");
		e_player thread function_33593a44(localclientnum, 2, 1);
	}
}

/*
	Name: function_33593a44
	Namespace: zm_mansion
	Checksum: 0x1A0B6062
	Offset: 0x15E0
	Size: 0x18C
	Parameters: 4
	Flags: Linked, Private
*/
private function function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3)
{
	self notify("6e700fd90329871b");
	self endon("6e700fd90329871b");
	n_blend = 0;
	n_increment = 1 / n_time / 0.016;
	if(var_312d65d1 == 1 && var_68f7ce2e == 2)
	{
		while(n_blend < 1)
		{
			function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, n_blend, 0, 0);
			n_blend = n_blend + n_increment;
			waitframe(1);
		}
	}
	else if(var_312d65d1 == 2 && var_68f7ce2e == 1)
	{
		while(n_blend < 1)
		{
			function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 1 - n_blend, 0, 0);
			n_blend = n_blend + n_increment;
			waitframe(1);
		}
	}
}

/*
	Name: function_8f945669
	Namespace: zm_mansion
	Checksum: 0xB9A84C15
	Offset: 0x1778
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function function_8f945669(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_3bae53461accaa0b"], self, "tag_origin");
}

/*
	Name: function_94cf8d37
	Namespace: zm_mansion
	Checksum: 0xDD536756
	Offset: 0x17F8
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_94cf8d37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_4b7a5b1b))
		{
			self.var_4b7a5b1b = util::playfxontag(localclientnum, level._effect[#"hash_6afea56d1e14f1c8"], self, "tag_origin");
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
	Name: function_cb417790
	Namespace: zm_mansion
	Checksum: 0x669E1058
	Offset: 0x1938
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_cb417790(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_50da8a1de7ce18da"], self, "tag_origin");
		playsound(localclientnum, #"hash_6da145d367ec64b2", self.origin);
	}
}

/*
	Name: function_39b69f3f
	Namespace: zm_mansion
	Checksum: 0x903813D2
	Offset: 0x19F0
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_39b69f3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_60051e21f8eb4af"], self, "tag_origin");
	}
}

/*
	Name: clock_zombie_fx
	Namespace: zm_mansion
	Checksum: 0x674D9A90
	Offset: 0x1A78
	Size: 0x270
	Parameters: 7
	Flags: Linked
*/
function clock_zombie_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self zm_utility::good_barricade_damaged(localclientnum);
	self.var_36d3ad0b = [];
	self.var_36d3ad0b[#"clock_zombie_le"] = util::playfxontag(localclientnum, level._effect[#"clock_zombie_le"], self, "j_ball_le");
	self.var_36d3ad0b[#"clock_zombie_ri"] = util::playfxontag(localclientnum, level._effect[#"clock_zombie_ri"], self, "j_ball_ri");
	self.var_36d3ad0b[#"clock_zombie_eye"] = util::playfxontag(localclientnum, level._effect[#"clock_zombie_eye"], self, "tag_eye");
	gibclientutils::addgibcallback(localclientnum, self, 8, &function_739703b0);
	gibclientutils::addgibcallback(localclientnum, self, 128, &function_739703b0);
	gibclientutils::addgibcallback(localclientnum, self, 256, &function_739703b0);
	self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	foreach(i, fx_clock in self.var_36d3ad0b)
	{
		stopfx(localclientnum, fx_clock);
		self.var_36d3ad0b[i] = undefined;
	}
}

/*
	Name: function_739703b0
	Namespace: zm_mansion
	Checksum: 0x47FBBD3F
	Offset: 0x1CF0
	Size: 0x104
	Parameters: 3
	Flags: Linked
*/
function function_739703b0(localclientnum, entity, gibflag)
{
	switch(gibflag)
	{
		case 8:
		{
			str_fx = "clock_zombie_eye";
			break;
		}
		case 128:
		{
			str_fx = "clock_zombie_ri";
			break;
		}
		case 256:
		{
			str_fx = "clock_zombie_le";
			break;
		}
		default:
		{
			return;
		}
	}
	if(isint(self.var_36d3ad0b[str_fx]))
	{
		stopfx(localclientnum, self.var_36d3ad0b[str_fx]);
		self.var_36d3ad0b[str_fx] = undefined;
	}
}

/*
	Name: function_8048af7e
	Namespace: zm_mansion
	Checksum: 0xAFABD675
	Offset: 0x1E00
	Size: 0x6AA
	Parameters: 7
	Flags: Linked
*/
function function_8048af7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isarray(self.var_d2ec7fbb))
		{
			self.var_d2ec7fbb = [];
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_679e221c06d83988"], self, "j_spine4");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_85d57de38b76cc7"], self, "j_head");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_2568ad8792cec77f"], self, "j_spinelower");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_23cfdebb55c60d4f"], self, "j_shoulder_le");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_5843ac84cb4761c0"], self, "j_shoulder_ri");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_4f8200ee1c323836"], self, "j_hip_le");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_5845fe8edb36108b"], self, "j_hip_ri");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_8f58d28b0b40b2d"], self, "j_knee_le");
			if(!isdefined(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = [];
			}
			else if(!isarray(self.var_d2ec7fbb))
			{
				self.var_d2ec7fbb = array(self.var_d2ec7fbb);
			}
			self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playfxontag(localclientnum, level._effect[#"hash_36f6dd55e72db9a6"], self, "j_knee_ri");
		}
	}
	else if(isarray(self.var_d2ec7fbb))
	{
		foreach(fx in self.var_d2ec7fbb)
		{
			stopfx(localclientnum, fx);
		}
		self.var_d2ec7fbb = undefined;
	}
}

/*
	Name: function_328d64bd
	Namespace: zm_mansion
	Checksum: 0x223F78A0
	Offset: 0x24B8
	Size: 0x24E
	Parameters: 7
	Flags: Linked
*/
function function_328d64bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_forward = anglestoforward(self.angles);
		self.blocker_fx = playfx(localclientnum, level._effect[#"hash_1a4566b6595544b4"], self.origin, v_forward);
		a_trace = bullettrace(self.origin, self.origin - vectorscale((0, 0, 1), 512), 0, self);
		self.var_3fc27ef3 = playfx(localclientnum, level._effect[#"hash_1a46c58a5032bb15"], a_trace[#"position"], v_forward);
		if(!isdefined(self.var_99a9007b))
		{
			self playsound(localclientnum, #"hash_2c71df73b17cd28a");
			self.var_99a9007b = self playloopsound(#"hash_7e4a7312ab58161e");
		}
	}
	else if(isdefined(self.blocker_fx))
	{
		stopfx(localclientnum, self.blocker_fx);
	}
	if(isdefined(self.var_3fc27ef3))
	{
		stopfx(localclientnum, self.var_3fc27ef3);
	}
	if(isdefined(self.var_99a9007b))
	{
		self playsound(localclientnum, #"hash_3366b1b903dc96bf");
		self stoploopsound(self.var_99a9007b);
		self.var_99a9007b = undefined;
	}
}

/*
	Name: function_d86e0cb2
	Namespace: zm_mansion
	Checksum: 0xB5C038C0
	Offset: 0x2710
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_d86e0cb2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.fx_ww_pickup))
		{
			self.fx_ww_pickup = util::playfxontag(localclientnum, level._effect[#"ww_pickup"], self, "tag_origin");
		}
	}
	else if(isdefined(self.fx_ww_pickup))
	{
		stopfx(localclientnum, self.fx_ww_pickup);
		self.fx_ww_pickup = undefined;
	}
}

/*
	Name: function_46bf4199
	Namespace: zm_mansion
	Checksum: 0xFBD1466E
	Offset: 0x27E8
	Size: 0x182
	Parameters: 7
	Flags: Linked
*/
function function_46bf4199(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_4dccfdf6))
	{
		stopfx(localclientnum, self.var_4dccfdf6);
		self.var_4dccfdf6 = undefined;
	}
	if(newval)
	{
		switch(newval)
		{
			case 1:
			{
				str_fx = level._effect[#"hash_3e78192d5d719b68"];
				break;
			}
			case 2:
			{
				str_fx = level._effect[#"hash_6f8a5a3faaac0b2d"];
				break;
			}
			case 3:
			{
				str_fx = level._effect[#"hash_6e809770685a03ce"];
				break;
			}
			case 4:
			{
				str_fx = level._effect[#"hash_5b93caeacd0dbde4"];
				break;
			}
		}
		if(isdefined(str_fx))
		{
			self.var_4dccfdf6 = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
		}
	}
}

/*
	Name: function_97aef6ef
	Namespace: zm_mansion
	Checksum: 0x660A8EF7
	Offset: 0x2978
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_97aef6ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_30b1857a))
	{
		stopfx(localclientnum, self.var_30b1857a);
		self.var_30b1857a = undefined;
	}
	if(newval)
	{
		self.var_30b1857a = util::playfxontag(localclientnum, level._effect[#"hash_487e544e29aa8e45"], self, "tag_origin");
	}
}

/*
	Name: function_be42dd6a
	Namespace: zm_mansion
	Checksum: 0xAA2C2B6
	Offset: 0x2A38
	Size: 0x31C
	Parameters: 7
	Flags: Linked
*/
function function_be42dd6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_2ea06178 = util::playfxontag(localclientnum, level._effect[#"hash_581c81003eac976f"], self, "tag_fx_x_pos");
		self function_bf9d3071(#"hash_8cb3b94ffea62fe");
		self.var_b3673abf = self playloopsound(#"hash_66df9cab2c64f968");
	}
	else if(newval == 2)
	{
		if(isdefined(self.var_b3673abf))
		{
			self stoploopsound(self.var_b3673abf);
		}
		if(isdefined(self.var_2ea06178))
		{
			stopfx(localclientnum, self.var_2ea06178);
			self.var_2ea06178 = undefined;
		}
		util::playfxontag(localclientnum, level._effect[#"artifact_activate"], self, "tag_fx_x_pos");
		self function_5d482e78(#"hash_8cb3b94ffea62fe");
	}
	else if(newval == 3)
	{
		self.var_f7a393 = util::playfxontag(localclientnum, level._effect[#"artifact_glow"], self, "tag_fx_x_pos");
		self function_bf9d3071(#"hash_4192ceb1c828492f");
		self playsound(localclientnum, #"zmb_sq_souls_release");
	}
	else if(isdefined(self.var_b3673abf))
	{
		self stoploopsound(self.var_b3673abf);
		self.var_b3673abf = undefined;
	}
	if(isdefined(self.var_2ea06178))
	{
		stopfx(localclientnum, self.var_2ea06178);
		self.var_2ea06178 = undefined;
	}
	if(isdefined(self.var_f7a393))
	{
		stopfx(localclientnum, self.var_f7a393);
		self.var_f7a393 = undefined;
	}
	self function_5d482e78(#"hash_4192ceb1c828492f");
	self playsound(localclientnum, #"hash_5de064f33e9e49b8");
}

/*
	Name: function_9e061782
	Namespace: zm_mansion
	Checksum: 0xA16E705B
	Offset: 0x2D60
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_9e061782(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_798166dc35b7e58");
	}
	else
	{
		self function_5d482e78(#"hash_798166dc35b7e58");
	}
}

/*
	Name: function_dba1f701
	Namespace: zm_mansion
	Checksum: 0x96365A36
	Offset: 0x2E00
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function function_dba1f701(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_5ca1805634bbfe66");
	if(isdefined(self.var_f89c3040))
	{
		killfx(localclientnum, self.var_f89c3040);
		self.var_f89c3040 = undefined;
	}
	if(isdefined(self.var_97c36aa4))
	{
		killfx(localclientnum, self.var_97c36aa4);
		self.var_97c36aa4 = undefined;
	}
	if(newval)
	{
		self thread function_6381f252(localclientnum);
	}
}

/*
	Name: function_6381f252
	Namespace: zm_mansion
	Checksum: 0x596F393D
	Offset: 0x2EE8
	Size: 0x268
	Parameters: 1
	Flags: Linked
*/
function function_6381f252(localclientnum)
{
	self endon_callback(&function_900bdca4, #"death", #"respawn", #"hash_5ca1805634bbfe66");
	self util::waittill_dobj(localclientnum);
	while(true)
	{
		if(zm_utility::function_f8796df3(localclientnum) && !isthirdperson(localclientnum))
		{
			if(viewmodelhastag(localclientnum, "tag_flash"))
			{
				if(!isdefined(self.var_f89c3040))
				{
					self.var_f89c3040 = playviewmodelfx(localclientnum, level._effect[#"hash_6b03597da0a3c2ae"], "tag_flash");
				}
			}
			else if(isdefined(self.var_f89c3040))
			{
				killfx(localclientnum, self.var_f89c3040);
				self.var_f89c3040 = undefined;
			}
			if(viewmodelhastag(localclientnum, "tag_flash_le"))
			{
				if(!isdefined(self.var_97c36aa4))
				{
					self.var_97c36aa4 = playviewmodelfx(localclientnum, level._effect[#"hash_6b03597da0a3c2ae"], "tag_flash_le");
				}
			}
			else if(isdefined(self.var_97c36aa4))
			{
				killfx(localclientnum, self.var_97c36aa4);
				self.var_97c36aa4 = undefined;
			}
		}
		else if(isdefined(self.var_f89c3040))
		{
			killfx(localclientnum, self.var_f89c3040);
			self.var_f89c3040 = undefined;
		}
		if(isdefined(self.var_97c36aa4))
		{
			killfx(localclientnum, self.var_97c36aa4);
			self.var_97c36aa4 = undefined;
		}
		waitframe(1);
	}
}

/*
	Name: function_900bdca4
	Namespace: zm_mansion
	Checksum: 0xD3C9A94E
	Offset: 0x3158
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_900bdca4(var_c34665fc)
{
	if(isdefined(self.var_f89c3040))
	{
		killfx(self.localclientnum, self.var_f89c3040);
		self.var_f89c3040 = undefined;
	}
	if(isdefined(self.var_97c36aa4))
	{
		killfx(self.localclientnum, self.var_97c36aa4);
		self.var_97c36aa4 = undefined;
	}
}

