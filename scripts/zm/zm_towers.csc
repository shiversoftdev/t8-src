// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1611421ee9b880d3;
#using script_2c454d63a96d2d0b;
#using script_3f48538738283547;
#using script_67051bc8c81031aa;
#using script_67b98aa634d9decc;
#using script_74bae32e2e91a208;
#using script_74f5ae6ffc8bd614;
#using script_76b36ed1b7a51ed2;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_towers_challenges.csc;
#using scripts\zm\zm_towers_gamemodes.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_towers;

/*
	Name: opt_in
	Namespace: zm_towers
	Checksum: 0x72B6CAE1
	Offset: 0xD68
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
	Namespace: zm_towers
	Checksum: 0xE386CAFA
	Offset: 0xD98
	Size: 0x29C2
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
	clientfield::register("scriptmover", "entry_gate_dust", 1, 1, "int", &function_ce727843, 0, 0);
	clientfield::register("scriptmover", "zombie_head_pickup_glow", 1, 1, "int", &function_b675c8b2, 0, 0);
	clientfield::register("scriptmover", "blue_glow", 1, 1, "int", &function_70307a31, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_32782b46ea19f365", 1, 1, "int", &function_f3866f6b, 0, 0);
	clientfield::register("scriptmover", "sentinel_artifact_fx_mist", 1, 1, "int", &function_46125384, 0, 0);
	clientfield::register("allplayers", "force_pap_models", 1, 1, "int", &function_5eaabec, 0, 1);
	clientfield::register("world", "special_round_smoke", 1, 1, "int", &function_94675baf, 0, 0);
	clientfield::register("allplayers", "special_round_camera", 1, 2, "int", &function_b3928b74, 0, 1);
	clientfield::register("world", "brazier_fire_blue", 1, 2, "int", &function_57f3914e, 0, 0);
	clientfield::register("world", "brazier_fire_green", 1, 2, "int", &function_6e6d4bfc, 0, 0);
	clientfield::register("world", "brazier_fire_purple", 1, 2, "int", &function_66050c9e, 0, 0);
	clientfield::register("world", "brazier_fire_red", 1, 2, "int", &function_1c231f3f, 0, 0);
	clientfield::register("scriptmover", "head_fire_blue", 1, 1, "int", &function_bdc63758, 0, 0);
	clientfield::register("scriptmover", "head_fire_green", 1, 1, "int", &function_c41817fc, 0, 0);
	clientfield::register("scriptmover", "head_fire_purple", 1, 1, "int", &function_27a7a3be, 0, 0);
	clientfield::register("scriptmover", "head_fire_red", 1, 1, "int", &function_d056a230, 0, 0);
	clientfield::register("scriptmover", "energy_soul", 1, 1, "int", &function_87e8980d, 0, 0);
	clientfield::register("scriptmover", "energy_soul_target", 1, 1, "int", &function_b29b7566, 0, 0);
	clientfield::register("scriptmover", "banner_soul_burst", 1, 1, "counter", &banner_soul_burst, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2bbcb9e09bd7bb26", 1, 1, "counter", &function_ee4f01d8, 0, 0);
	clientfield::register("allplayers", "force_challenge_model", 1, 1, "int", &function_a1d393ad, 0, 1);
	clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int", &acid_trap_death_fx, 0, 0);
	clientfield::register("scriptmover", "trap_switch_green", 1, 1, "int", &function_29bd0c51, 0, 0);
	clientfield::register("scriptmover", "trap_switch_red", 1, 1, "int", &function_75347b12, 0, 0);
	clientfield::register("scriptmover", "trap_switch_smoke", 1, 1, "int", &function_25ebc4f7, 0, 0);
	clientfield::register("toplayer", "acid_trap_postfx", 1, 1, "int", &acid_trap_postfx, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7478ffee8332e21e", 1, 1, "int", &function_d530f71, 0, 0);
	clientfield::register("world", "crowd_react", 1, 2, "int", &crowd_react, 0, 1);
	clientfield::register("world", "crowd_react_boss", 1, 1, "int", &crowd_react_boss, 0, 1);
	clientfield::register("world", "" + #"hash_2f895e916afde822", 1, 1, "int", &function_ceb8d00f, 0, 1);
	clientfield::register("toplayer", "snd_crowd_react", 1, 4, "int", &snd_crowd_react, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_42cc4bf5e47478c5", 1, 1, "int", &function_a8195148, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3b746cf6eec416b2", 1, 1, "int", &function_24673586, 0, 0);
	clientfield::register("world", "" + #"hash_584e8f7433246444", 1, 1, "int", &function_e9a85af, 0, 0);
	clientfield::register("world", "" + #"hash_418c1c843450232b", 1, 1, "int", &function_90076b73, 0, 0);
	clientfield::register("world", "" + #"hash_4d547bf36c6cb2d8", 1, 1, "int", &function_e26b1e6b, 0, 0);
	clientfield::register("world", "" + #"hash_38ba3ad0902aa355", 1, 1, "int", &function_25a6ede2, 0, 0);
	clientfield::register("world", "" + #"hash_24d7233bb17e6558", 1, 1, "int", &function_a2800857, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3dca6eaa62a8f783", 1, 1, "counter", &function_3fb29ca1, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2c6f04d08665dbda", 1, 1, "int", &function_76dd176c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2a332df32456c86f", 1, 1, "int", &function_5dc8b5fa, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_48ad84f9cf6a33f0", 1, 1, "counter", &function_91305947, 0, 0);
	clientfield::register("zbarrier", "" + #"hash_3974bea828fbf7f7", 1, 1, "int", &function_ba86af94, 0, 0);
	clientfield::register("zbarrier", "" + #"hash_3a51c9895d4afcf7", 1, 1, "int", &function_36469123, 0, 0);
	clientfield::register("zbarrier", "" + #"hash_1add6939914df65a", 1, 1, "int", &function_a7b41dea, 0, 0);
	clientfield::register("zbarrier", "" + #"hash_5dc6f97e5850e1d1", 1, 1, "int", &function_1941a5ca, 0, 0);
	clientfield::register("toplayer", "" + #"hash_47e0e1e96b037286", 1, 1, "counter", &function_ef17abb4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_333e3741e6552db3", 1, 1, "int", &function_e63747a9, 0, 0);
	clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int", &function_44a2fe02, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6ff3eb2dd0078a51", 1, 1, "counter", &function_8565be53, 0, 0);
	clientfield::register("world", "" + #"hash_445060dbbf244b04", 1, 1, "int", &function_35bf68a, 0, 0);
	clientfield::register("world", "" + #"hash_a2fb645044ed12e", 1, 1, "int", &function_605da720, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3f79f6da0222ebc2", 1, 1, "int", &function_2312778c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_c382c02584ba249", 1, 1, "int", &function_240a3342, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_273efcc293063e5e", 1, 1, "int", &function_9eb43a48, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4a963ca015392163", 1, 1, "int", &function_867fd05d, 0, 0);
	clientfield::register("world", "" + #"hash_5a3e1454226ef7a4", 1, 1, "int", &function_8fc72b02, 0, 0);
	clientfield::register("world", "" + #"hash_73088ea3053b96f1", 1, 1, "int", &function_70e21be0, 0, 0);
	clientfield::register("actor", "" + #"hash_233e31d0c2b47b1b", 1, 1, "int", &function_9cb4a774, 0, 0);
	clientfield::register("actor", "" + #"hash_12dfb8249f8212d2", 1, 1, "int", &function_eba8a203, 0, 0);
	clientfield::register("actor", "" + #"hash_17e3041649954b9f", 1, 1, "int", &function_1467cfe7, 0, 0);
	clientfield::register("scriptmover", "ra_eyes_beam_fire", 1, 1, "int", &ra_eyes_beam_fire, 0, 0);
	clientfield::register("scriptmover", "ra_rooftop_eyes_beam_fire", 1, 1, "int", &ra_rooftop_eyes_beam_fire, 0, 0);
	clientfield::register("world", "" + #"hash_57c08e5f4792690c", 1, 1, "int", &function_339af7bd, 0, 0);
	clientfield::register("world", "" + #"hash_440f23773f551a48", 1, 1, "int", &function_e131f9b8, 0, 0);
	clientfield::register("world", "" + #"hash_4e5e2b411c997804", 1, 1, "int", &function_98d53b6b, 0, 0);
	clientfield::register("toplayer", "" + #"hash_3b3d40b9e7427939", 1, 1, "counter", &function_a2128708, 0, 0);
	clientfield::register("world", "" + #"hash_6bc33c82908d4d2c", 1, 1, "int", &function_f7102023, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4e7b1766cc26a866", 1, 1, "int", &function_9d72720a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1814d4cc1867739c", 1, 1, "int", &function_e21e7dbe, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_314d3a2e542805c0", 1, 1, "int", &function_4a9243dc, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_522e903485969f46", 1, 1, "counter", &function_14c0b237, 0, 0);
	clientfield::register("actor", "" + #"hash_1ff85f67b6d93430", 1, 1, "counter", &function_45b8306b, 0, 0);
	clientfield::register("toplayer", "" + #"hash_17002d8f9d5c197b", 1, 1, "int", &function_e9192031, 0, 0);
	clientfield::register("toplayer", "" + #"hash_182c03ff2a21c07c", 1, 1, "counter", &function_2d6ec02, 0, 0);
	clientfield::register("toplayer", "" + #"hash_137bf198b0b91ba9", 1, 1, "int", &function_8ad1050e, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_63e758aa5387132a", 1, 1, "counter", &function_7dbeb0c5, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_23ba00d2f804acc2", 1, 1, "int", &function_fa2e6690, 0, 0);
	clientfield::register("world", "" + #"hash_16b9e3d69cb7a017", 1, 1, "int", &function_fc502d48, 0, 1);
	clientfield::register("world", "" + #"hash_1f09a5290d31eb37", 1, 1, "counter", &function_5b893414, 0, 0);
	clientfield::register("world", "" + #"hash_2383fd01b106ced8", 1, 1, "int", &function_4c2b87ed, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2407f687f7d24a83", 1, 1, "int", &function_5cdc8b28, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5afda864f8b64f5c", 1, 1, "int", &function_5c9f28ec, 0, 0);
	clientfield::register("world", "" + #"hash_39e6b14b9e5b0f3d", 1, 1, "int", &function_99220e91, 0, 0);
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"hash_73172b799c18404e"] = #"hash_7d94f7b4389cad84";
	level._effect[#"entry_gate_dust"] = #"hash_43b2eaf6037de947";
	level._effect[#"special_round_smoke"] = #"hash_7f90f442be248933";
	level._effect[#"hash_2a49b738100ad198"] = #"hash_573f4333a69a2e97";
	level._effect[#"special_round_camera_start"] = #"hash_5e456969dcb6d449";
	level._effect[#"special_round_camera_persist"] = #"hash_30a51086d1de2e56";
	level._effect[#"trap_switch_green"] = #"hash_24ce0898c3432283";
	level._effect[#"trap_switch_red"] = #"hash_1d6280fe28ef047";
	level._effect[#"trap_switch_smoke"] = #"hash_22722c91ebbd77f9";
	level._effect[#"hash_42cc4bf5e47478c5"] = #"hash_387c78244f5f45e5";
	level._effect[#"hash_3b746cf6eec416b2"] = #"hash_396a3bd29f816da1";
	level._effect[#"hash_36535f89ec2488d7"] = #"hash_5efc6976bcba1957";
	level._effect[#"hash_584e8f7433246444"] = #"hash_682f944518a1171c";
	level._effect[#"hash_33a4b9fa0803ab64"] = #"hash_2b4f2f30d115f02a";
	level._effect[#"hash_3dca6eaa62a8f783"] = #"hash_2947a74c2209d11";
	level._effect[#"hash_48ad84f9cf6a33f0"] = #"hash_232d6ea0cf34968b";
	level._effect[#"hash_3974bea828fbf7f7"] = #"hash_6fd3d30a984a4585";
	level._effect[#"hash_3a51c9895d4afcf7"] = #"hash_393af938c98cf4d0";
	level._effect[#"hash_1add6939914df65a"] = #"hash_24d0d45080034da";
	level._effect[#"hash_5dc6f97e5850e1d1"] = #"hash_14d7c3ad478543a";
	level._effect[#"hash_56c34d8ec9a098c2"] = #"hash_266633b36a852fd5";
	level._effect[#"brazier_fire_blue"] = #"hash_6d3f50f00db41676";
	level._effect[#"brazier_fire_green"] = #"hash_1839d27856f4aed9";
	level._effect[#"brazier_fire_red"] = #"hash_4d95d8d2f3b07ca5";
	level._effect[#"brazier_fire_purple"] = #"hash_231c5e173b446f0c";
	level._effect[#"hash_169c8ab62603115c"] = #"hash_2a4dc3aacf70bb96";
	level._effect[#"head_fire_blue"] = #"hash_5089724c9ec9d4f7";
	level._effect[#"head_fire_green"] = #"hash_29adecede9b00a2";
	level._effect[#"head_fire_purple"] = #"hash_19cfaef54c89e021";
	level._effect[#"head_fire_red"] = #"hash_46234b48f3c3d22";
	level._effect[#"energy_soul"] = #"hash_24eb30a2d07ae5a9";
	level._effect[#"energy_soul_target"] = #"hash_6f5f4eb9267613e3";
	level._effect[#"banner_soul_burst"] = #"hash_38a043ca24c928f5";
	level._effect[#"acid_death"] = #"hash_78c487ac760f594c";
	level._effect[#"hash_233e31d0c2b47b1b"] = #"hash_4d11f0ab46451330";
	level._effect[#"hash_32782b46ea19f365"] = #"hash_2fa6e69cbbe0de1";
	level._effect[#"hash_4eddc2f547bc55f6"] = #"hash_246ba1502485a840";
	level._effect[#"hash_7bd75ae600e0a590"] = "maps/zm_towers/fx8_crowd_reward_flower_exp";
	level._effect[#"hash_4c4f96aa02c32a2a"] = "maps/zm_towers/fx8_crowd_reward_flower_trail";
	level._effect[#"hash_6ff3eb2dd0078a51"] = #"hash_71198dfc5b0fd85";
	level._effect[#"hash_3f79f6da0222ebc2"] = #"hash_2f1958cd9b473bec";
	level._effect[#"hash_4a963ca015392163"] = #"hash_48344f893bb65bf2";
	level._effect[#"hash_5a3e1454226ef7a4"] = #"hash_62ef4090559ca8c8";
	level._effect[#"hash_1f7bfd354d2472e3"] = #"hash_153286962fe0c0c5";
	level._effect[#"hash_1f7511354d1e7631"] = #"hash_153992962fe6f3d7";
	level._effect[#"hash_3b3d40b9e7427939"] = #"hash_223c6a623adb13fb";
	level._effect[#"hash_504ad50f841882fe"] = #"hash_26b672f2c1c8a570";
	level._effect[#"hash_2cf77bcee904664d"] = #"hash_50ce930e4dd4bc12";
	level._effect[#"hash_2cf75dcee9043353"] = #"hash_50c7bb0e4dcee15c";
	level._effect[#"hash_4a9ad8ec06102c34"] = #"hash_4d91ce766ebeda81";
	level._effect[#"hash_4a9abeec06100006"] = #"hash_4db3c6766edbb34f";
	level._effect[#"hash_59efd6cf7ca11195"] = #"hash_35d31a887a79e68e";
	level._effect[#"hash_59efc8cf7ca0f9cb"] = #"hash_361dea887ab98078";
	level._effect[#"hash_416145285a01faa3"] = #"hash_28ad85abec3ad058";
	level._effect[#"hash_416143285a01f73d"] = #"hash_28479dabebe445ee";
	level._effect[#"hash_df4673638509cab"] = #"hash_2543453edaf343d4";
	level._effect[#"hash_df475363850b475"] = #"hash_259b253edb3d834a";
	level._effect[#"hash_4e7b1766cc26a866"] = #"zm_ai/fx8_elec_bolt";
	level._effect[#"hash_1814d4cc1867739c"] = #"hash_13f09e4051884309";
	level._effect[#"hash_314d3a2e542805c0"] = #"zombie/fx_powerup_on_red_zmb";
	level._effect[#"hash_1ff85f67b6d93430"] = #"hash_6a5c671e82cb5243";
	level._effect[#"maelstrom_camera_fx"] = #"hash_33ca6401bbf3798c";
	level._effect[#"hash_63e758aa5387132a"] = #"hash_7df55a8e3d87037a";
	level._effect[#"hash_23ba00d2f804acc2"] = #"hash_56b121a7e7eee303";
	level._effect[#"hash_5afda864f8b64f5c"] = #"hash_5f48f8d916a0f612";
	level thread namespace_8f39dfb1::init();
	level.var_d0ab70a2 = #"hash_42dcec7533a676b0";
	level.var_210ce105 = zm_towers_crowd_meter::register("zm_towers_crowd_meter");
	load::main();
	util::waitforclient(0);
	if(!zm_utility::function_e51dc2d8())
	{
		var_138ba1c2 = findvolumedecalindexarray("nardec");
		foreach(i in var_138ba1c2)
		{
			hidevolumedecal(i);
		}
	}
	level thread function_9290b227();
	level thread setup_personality_character_exerts();
	level.var_2d4bfff3 = [];
}

/*
	Name: function_5b893414
	Namespace: zm_towers
	Checksum: 0xA6A114E8
	Offset: 0x3768
	Size: 0x54
	Parameters: 7
	Flags: Linked
*/
function function_5b893414(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level thread function_26c4a8d5();
}

/*
	Name: function_26c4a8d5
	Namespace: zm_towers
	Checksum: 0x73DE6F41
	Offset: 0x37C8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_26c4a8d5()
{
	self notify("273a0aad6f4ce331");
	self endon("273a0aad6f4ce331");
	level waittill(#"hash_2a33c8604d0de6ea");
	a_players = getlocalplayers();
	array::thread_all(a_players, &postfx::playpostfxbundle, #"hash_3b0eec5d73aa6243");
	level waittill(#"hash_785fd96b8f6dfcc0");
	a_players = getlocalplayers();
	array::thread_all(a_players, &postfx::exitpostfxbundle, #"hash_3b0eec5d73aa6243");
}

/*
	Name: function_ce727843
	Namespace: zm_towers
	Checksum: 0x23B776F8
	Offset: 0x38A8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_ce727843(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		function_239993de(localclientnum, level._effect[#"entry_gate_dust"], self, "p8_zm_gla_tunnel_gate");
	}
}

/*
	Name: function_d530f71
	Namespace: zm_towers
	Checksum: 0x4A0BE8B8
	Offset: 0x3930
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_d530f71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_2ee8588651571cb");
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_2ee8588651571cb");
		if(isdefined(self.var_eb695935))
		{
			stopfx(localclientnum, self.var_eb695935);
			self.var_eb695935 = undefined;
		}
	}
}

/*
	Name: function_8565be53
	Namespace: zm_towers
	Checksum: 0xB8B0FEF2
	Offset: 0x39F8
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_8565be53(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"hash_6ff3eb2dd0078a51"], self.origin);
	playsound(localclientnum, #"hash_2e08e4ff8f949d48", self.origin);
}

/*
	Name: function_35bf68a
	Namespace: zm_towers
	Checksum: 0x372DBE7A
	Offset: 0x3AA0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_35bf68a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_77659f61538a4beb");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_77659f61538a4beb");
	}
}

/*
	Name: function_605da720
	Namespace: zm_towers
	Checksum: 0xFAC860A7
	Offset: 0x3B38
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_605da720(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_4286272708c5e5c0");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_4286272708c5e5c0");
	}
}

/*
	Name: function_2312778c
	Namespace: zm_towers
	Checksum: 0x90078555
	Offset: 0x3BD0
	Size: 0x15E
	Parameters: 7
	Flags: Linked
*/
function function_2312778c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_cf369100))
	{
		self.var_cf369100 = util::spawn_model(localclientnum, "tag_origin", self.origin);
		self.var_cf369100 linkto(self);
	}
	if(newval)
	{
		self.var_e76fb9a5 = util::playfxontag(localclientnum, level._effect[#"hash_3f79f6da0222ebc2"], self.var_cf369100, "tag_origin");
	}
	else if(isdefined(self.var_e76fb9a5))
	{
		stopfx(localclientnum, self.var_e76fb9a5);
		self.var_e76fb9a5 = undefined;
	}
	if(isdefined(self.var_cf369100))
	{
		self.var_cf369100 unlink();
		self.var_cf369100 delete();
		self.var_cf369100 = undefined;
	}
}

/*
	Name: function_240a3342
	Namespace: zm_towers
	Checksum: 0x70175AFE
	Offset: 0x3D38
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_240a3342(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071(#"hash_3e2336a0454b9574");
	}
	else
	{
		self function_5d482e78(#"hash_3e2336a0454b9574");
	}
}

/*
	Name: function_9eb43a48
	Namespace: zm_towers
	Checksum: 0xF8D0CD14
	Offset: 0x3DD0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_9eb43a48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071(#"hash_616b1855bf6ea5f2");
	}
	else
	{
		self function_5d482e78(#"hash_616b1855bf6ea5f2");
	}
}

/*
	Name: function_867fd05d
	Namespace: zm_towers
	Checksum: 0x52BD6AB4
	Offset: 0x3E68
	Size: 0x15E
	Parameters: 7
	Flags: Linked
*/
function function_867fd05d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_2bcd3d7c = playfx(localclientnum, level._effect[#"hash_4a963ca015392163"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		if(!isdefined(self.var_e29d710c))
		{
			self.var_e29d710c = self playloopsound(#"zmb_funtime_fert_smell_lp");
		}
	}
	else if(isdefined(self.var_2bcd3d7c))
	{
		stopfx(localclientnum, self.var_2bcd3d7c);
		self.var_2bcd3d7c = undefined;
	}
	if(isdefined(self.var_e29d710c))
	{
		self stoploopsound(self.var_e29d710c);
		self.var_e29d710c = undefined;
	}
}

/*
	Name: function_8fc72b02
	Namespace: zm_towers
	Checksum: 0x3A07F43E
	Offset: 0x3FD0
	Size: 0x17C
	Parameters: 7
	Flags: Linked
*/
function function_8fc72b02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get(#"hash_44451a49b3653789");
	if(newval)
	{
		s_fx.var_c0a2fa6f = playfx(localclientnum, level._effect[#"hash_5a3e1454226ef7a4"], s_fx.origin + vectorscale((0, 0, 1), 4), anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
		audio::playloopat("zmb_funtime_fert_smell_lp", s_fx.origin);
	}
	else if(isdefined(s_fx.var_c0a2fa6f))
	{
		stopfx(localclientnum, s_fx.var_c0a2fa6f);
		s_fx.var_c0a2fa6f = undefined;
	}
	audio::stoploopat("zmb_funtime_fert_smell_lp", s_fx.origin);
}

/*
	Name: function_70e21be0
	Namespace: zm_towers
	Checksum: 0xEE6E26C
	Offset: 0x4158
	Size: 0x1EC
	Parameters: 7
	Flags: Linked
*/
function function_70e21be0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!level flag::exists(#"hash_3f632a7ca8c645e9"))
	{
		level flag::init(#"hash_3f632a7ca8c645e9");
	}
	if(newval)
	{
		if(level flag::get(#"hash_3f632a7ca8c645e9"))
		{
			return;
		}
		level flag::set(#"hash_3f632a7ca8c645e9");
		callback::on_spawned(&function_345ea423);
		a_e_players = getplayers(localclientnum);
		a_e_players = array::remove_dead(a_e_players);
		array::thread_all(a_e_players, &function_345ea423, localclientnum);
	}
	else if(!level flag::get(#"hash_3f632a7ca8c645e9"))
	{
		return;
	}
	level flag::clear(#"hash_3f632a7ca8c645e9");
	callback::remove_on_spawned(&function_345ea423);
	array::notify_all(getplayers(localclientnum), #"hash_5f06618b8c668b18");
}

/*
	Name: function_345ea423
	Namespace: zm_towers
	Checksum: 0x615680D9
	Offset: 0x4350
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_345ea423(localclientnum)
{
	self notify("4e849ddafe66746f");
	self endon("4e849ddafe66746f");
	self endon(#"death", #"hash_5f06618b8c668b18");
	n_random_wait = randomfloatrange(1, 3);
	wait(n_random_wait);
	while(true)
	{
		var_9324af94 = function_5c10bd79(localclientnum);
		if(self === var_9324af94 && function_d17ae3cc(localclientnum))
		{
			playfxoncamera(localclientnum, level._effect[#"hash_1f7bfd354d2472e3"], (0, 0, 0), (1, 0, 0));
		}
		else
		{
			util::playfxontag(localclientnum, level._effect[#"hash_1f7511354d1e7631"], self, "j_head");
		}
		wait(3);
	}
}

/*
	Name: ra_eyes_beam_fire
	Namespace: zm_towers
	Checksum: 0xD58C04BB
	Offset: 0x44A0
	Size: 0x276
	Parameters: 7
	Flags: Linked
*/
function ra_eyes_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		var_d9ad5cc8 = struct::get("s_puzzle_beam_end", "targetname");
		self.var_96ce3194 = util::spawn_model(localclientnum, "tag_origin", var_d9ad5cc8.origin, var_d9ad5cc8.angles);
		level beam::launch(self, "tag_origin", self.var_96ce3194, "tag_origin", "beam8_zm_scepter_ray_lvl3");
		self playsound(localclientnum, #"hash_473e265e57e397c8");
		soundlineemitter(#"hash_4bc05f42a04dcfd8", self.origin, self.var_96ce3194.origin);
		self.var_96ce3194.sfx_id = self.var_96ce3194 playloopsound(#"hash_c0bb4bb6f79f737");
	}
	else if(isdefined(self) && isdefined(self.var_96ce3194))
	{
		soundstoplineemitter(#"hash_4bc05f42a04dcfd8", self.origin, self.var_96ce3194.origin);
		self.var_96ce3194 stoploopsound(self.var_96ce3194.sfx_id);
		self playsound(localclientnum, #"hash_488e51364172acd9");
		level beam::kill(self, "tag_origin", self.var_96ce3194, "tag_origin", "beam8_zm_scepter_ray_lvl3");
		self.var_96ce3194 delete();
		self.var_96ce3194 = undefined;
	}
}

/*
	Name: ra_rooftop_eyes_beam_fire
	Namespace: zm_towers
	Checksum: 0x942BBA7F
	Offset: 0x4720
	Size: 0x276
	Parameters: 7
	Flags: Linked
*/
function ra_rooftop_eyes_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		var_d9ad5cc8 = struct::get("s_puzzle_complete_beam_end", "targetname");
		self.var_96ce3194 = util::spawn_model(localclientnum, "tag_origin", var_d9ad5cc8.origin, var_d9ad5cc8.angles);
		level beam::launch(self, "tag_origin", self.var_96ce3194, "tag_origin", "beam8_zm_scepter_ray_lvl3");
		self playsound(localclientnum, #"hash_4ad6201a8477162e");
		soundlineemitter(#"hash_1befd714ba572b72", self.origin, self.var_96ce3194.origin);
		self.var_96ce3194.sfx_id = self.var_96ce3194 playloopsound(#"hash_625ff5d45245151d");
	}
	else if(isdefined(self) && isdefined(self.var_96ce3194))
	{
		soundstoplineemitter(#"hash_1befd714ba572b72", self.origin, self.var_96ce3194.origin);
		self.var_96ce3194 stoploopsound(self.var_96ce3194.sfx_id);
		self playsound(localclientnum, #"hash_1eeb0d38cf56cc1b");
		level beam::kill(self, "tag_origin", self.var_96ce3194, "tag_origin", "beam8_zm_scepter_ray_lvl3");
		self.var_96ce3194 delete();
		self.var_96ce3194 = undefined;
	}
}

/*
	Name: function_339af7bd
	Namespace: zm_towers
	Checksum: 0x3068F971
	Offset: 0x49A0
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_339af7bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel("p8_zm_gla_target_bull_flat");
	}
	else
	{
		stopforcestreamingxmodel("p8_zm_gla_target_bull_flat");
	}
}

/*
	Name: function_e131f9b8
	Namespace: zm_towers
	Checksum: 0x645CCA51
	Offset: 0x4A28
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_e131f9b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel("p8_zm_gla_obelisk_med_02_glyph");
	}
	else
	{
		stopforcestreamingxmodel("p8_zm_gla_obelisk_med_02_glyph");
	}
}

/*
	Name: function_b675c8b2
	Namespace: zm_towers
	Checksum: 0x15D59F9C
	Offset: 0x4AB0
	Size: 0x156
	Parameters: 7
	Flags: Linked
*/
function function_b675c8b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_4e35f286 = util::playfxontag(localclientnum, level._effect[#"powerup_on_solo"], self, "tag_eye");
		if(!isdefined(self.var_a863bc25))
		{
			self playsound(localclientnum, #"zmb_spawn_powerup");
			self.var_a863bc25 = self playloopsound(#"zmb_spawn_powerup_loop");
		}
	}
	else if(isdefined(self.var_4e35f286))
	{
		stopfx(localclientnum, self.var_4e35f286);
		self.var_4e35f286 = undefined;
	}
	if(isdefined(self.var_a863bc25))
	{
		self stoploopsound(self.var_a863bc25);
		self.var_a863bc25 = undefined;
	}
}

/*
	Name: function_9cb4a774
	Namespace: zm_towers
	Checksum: 0x676F9BB1
	Offset: 0x4C10
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_9cb4a774(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_4e35f286 = util::playfxontag(localclientnum, level._effect[#"hash_233e31d0c2b47b1b"], self, "j_neck");
	}
	else if(isdefined(self.var_4e35f286))
	{
		stopfx(localclientnum, self.var_4e35f286);
		self.var_4e35f286 = undefined;
	}
}

/*
	Name: function_eba8a203
	Namespace: zm_towers
	Checksum: 0x24CF9272
	Offset: 0x4CD8
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_eba8a203(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_e9c6dd3 = util::playfxontag(localclientnum, level._effect[#"hash_4eddc2f547bc55f6"], self, "tag_weapon_left");
	}
	else if(isdefined(self.var_e9c6dd3))
	{
		stopfx(localclientnum, self.var_e9c6dd3);
		self.var_e9c6dd3 = undefined;
	}
}

/*
	Name: function_1467cfe7
	Namespace: zm_towers
	Checksum: 0xEE72911E
	Offset: 0x4DA0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_1467cfe7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_2d78a6d1 = util::playfxontag(localclientnum, level._effect[#"hash_4eddc2f547bc55f6"], self, "tag_weapon_right");
	}
	else if(isdefined(self.var_2d78a6d1))
	{
		stopfx(localclientnum, self.var_2d78a6d1);
		self.var_2d78a6d1 = undefined;
	}
}

/*
	Name: function_70307a31
	Namespace: zm_towers
	Checksum: 0xDC11B347
	Offset: 0x4E68
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_70307a31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_4e35f286 = playfx(localclientnum, level._effect[#"powerup_on_solo"], self.origin);
	}
	else if(isdefined(self.var_4e35f286))
	{
		stopfx(localclientnum, self.var_4e35f286);
		self.var_4e35f286 = undefined;
	}
}

/*
	Name: function_f3866f6b
	Namespace: zm_towers
	Checksum: 0x8FF53F7F
	Offset: 0x4F30
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_f3866f6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_9f5d50f5 = util::playfxontag(localclientnum, level._effect[#"hash_32782b46ea19f365"], self, "tag_origin");
	}
	else if(isdefined(self.var_9f5d50f5))
	{
		stopfx(localclientnum, self.var_9f5d50f5);
		self.var_9f5d50f5 = undefined;
	}
}

/*
	Name: function_fd119bd7
	Namespace: zm_towers
	Checksum: 0xD1D17320
	Offset: 0x4FF8
	Size: 0xBE
	Parameters: 7
	Flags: None
*/
function function_fd119bd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_4e35f286 = playfx(localclientnum, level._effect[#"hash_37043a271f6dd852"], self.origin);
	}
	else if(isdefined(self.var_4e35f286))
	{
		stopfx(localclientnum, self.var_4e35f286);
		self.var_4e35f286 = undefined;
	}
}

/*
	Name: function_46125384
	Namespace: zm_towers
	Checksum: 0xA770FEF7
	Offset: 0x50C0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_46125384(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_c1713f0a = util::playfxontag(localclientnum, level._effect[#"hash_73172b799c18404e"], self, "tag_origin");
	}
	else if(isdefined(self.var_c1713f0a))
	{
		stopfx(localclientnum, self.var_c1713f0a);
		self.var_c1713f0a = undefined;
	}
}

/*
	Name: function_5eaabec
	Namespace: zm_towers
	Checksum: 0x3B014961
	Offset: 0x5188
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function function_5eaabec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_7046550bbfeaf740");
		forcestreamxmodel(#"hash_7c166ef26a8ce946");
		forcestreamxmodel(#"hash_689b65d0eb8d29fd");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_7046550bbfeaf740");
		stopforcestreamingxmodel(#"hash_7c166ef26a8ce946");
		stopforcestreamingxmodel(#"hash_689b65d0eb8d29fd");
	}
}

/*
	Name: crowd_react_boss
	Namespace: zm_towers
	Checksum: 0x5A6BD5A5
	Offset: 0x52A0
	Size: 0x2A0
	Parameters: 7
	Flags: Linked
*/
function crowd_react_boss(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		smodelanimcmd("siege_crowds_battle", "unpause", "set_anim", array::random(array(#"hash_5cb3945473641f29", #"hash_503f5811c1c5e5e6", #"hash_1f6ed2b98c8d027b", #"hash_64e6aa218a7720e8", #"hash_4754434927e48765", #"hash_121b33ccb82a7192")));
	}
	else
	{
		smodelanimcmd("siege_crowds_battle", "unpause", "set_anim", array::random(array(#"hash_6b5a40bc4e870ff3", #"hash_56072b7700ddf344", #"hash_36841dd229ef8ac1", #"hash_592b16ba1f2e74aa", #"hash_23b34e6a58a2c83f", #"hash_5669312379919260")));
	}
	smodelanimcmd("siege_crowds_battle", "goto_random", "set_playback_speed", randomfloatrange(0.75, 1));
	if(newval)
	{
		a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
		foreach(s_struct in a_structs)
		{
			wait(randomfloatrange(0.15, 0.5));
		}
	}
}

/*
	Name: crowd_react
	Namespace: zm_towers
	Checksum: 0xA0F6D2E5
	Offset: 0x5548
	Size: 0x440
	Parameters: 7
	Flags: Linked
*/
function crowd_react(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify("c259832513fb682");
	self endon("c259832513fb682");
	if(!isdefined(level.var_a258da8d))
	{
		level.var_a258da8d = 0;
	}
	switch(level.var_a258da8d)
	{
		case 0:
		{
			switch(newval)
			{
				case 0:
				{
					var_eafa8a1a = "seated";
					break;
				}
				case 1:
				{
					var_eafa8a1a = "seated_to_angry";
					break;
				}
				case 2:
				{
					var_eafa8a1a = "seated_to_neutral";
					break;
				}
				case 3:
				{
					var_eafa8a1a = "seated_to_cheer";
					break;
				}
			}
			break;
		}
		case 1:
		{
			switch(newval)
			{
				case 0:
				{
					var_eafa8a1a = "angry_to_seated";
					break;
				}
				case 1:
				{
					var_eafa8a1a = "angry";
					break;
				}
				case 2:
				{
					var_eafa8a1a = "angry_to_neutral";
					break;
				}
				case 3:
				{
					var_eafa8a1a = "angry_to_cheer";
					break;
				}
			}
			break;
		}
		case 2:
		{
			switch(newval)
			{
				case 0:
				{
					var_eafa8a1a = "neutral_to_seated";
					break;
				}
				case 1:
				{
					var_eafa8a1a = "neutral_to_angry";
					break;
				}
				case 2:
				{
					var_eafa8a1a = "neutral";
					break;
				}
				case 3:
				{
					var_eafa8a1a = "neutral_to_cheer";
					break;
				}
			}
			break;
		}
		case 3:
		{
			switch(newval)
			{
				case 0:
				{
					var_eafa8a1a = "cheer_to_seated";
					break;
				}
				case 1:
				{
					var_eafa8a1a = "cheer_to_angry";
					break;
				}
				case 2:
				{
					var_eafa8a1a = "cheer_to_neutral";
					break;
				}
				case 3:
				{
					var_eafa8a1a = "cheer";
					break;
				}
			}
			break;
		}
	}
	level.var_a258da8d = newval;
	foreach(str_group in array("siege_crowds_grp27", "siege_zm_crowds_indv_1", "siege_zm_crowds_indv_2", "siege_zm_crowds_indv_3", "siege_zm_crowds_indv_4", "siege_zm_crowds_indv_5"))
	{
		if(str_group == "siege_crowds_grp27")
		{
			level thread function_1e3bd96a(str_group, var_eafa8a1a);
		}
		else
		{
			level thread function_628c5b1f(str_group, var_eafa8a1a);
		}
		function_1bb8e9c4();
	}
}

/*
	Name: function_628c5b1f
	Namespace: zm_towers
	Checksum: 0x1D345CCD
	Offset: 0x5990
	Size: 0xFEC
	Parameters: 3
	Flags: Linked
*/
function function_628c5b1f(str_group, var_eafa8a1a, var_55a37c48)
{
	/#
		assert(isdefined(var_eafa8a1a), "");
	#/
	var_55a37c48 = (isdefined(var_55a37c48) ? var_55a37c48 : randomfloatrange(0.75, 1));
	switch(var_eafa8a1a)
	{
		case "seated_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5c60a6f5f1a9d64a")), "set_playback_speed", var_55a37c48);
			wait(1.733 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_dec580832649b0")), "set_playback_speed", var_55a37c48);
			wait(1.733 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_1ce343c6e117581e")), "set_playback_speed", var_55a37c48);
			wait(2.033 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4d9e626e573c7720")), "set_playback_speed", var_55a37c48);
			wait(3.8333 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4cff3d99c8e94c1")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6938770d4f4e8ff2")), "set_playback_speed", var_55a37c48);
			wait(3.9 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_130c0f8d88ebfed1")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6c2063a701bdda05")), "set_playback_speed", var_55a37c48);
			wait(3.333 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_72e771137a0c1fb4")), "set_playback_speed", var_55a37c48);
			wait(2.7 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4573975901365b65")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")), "set_playback_speed", var_55a37c48);
			break;
		}
	}
	smodelanimcmd(str_group, "goto_random");
}

/*
	Name: function_1e3bd96a
	Namespace: zm_towers
	Checksum: 0x370F30
	Offset: 0x6988
	Size: 0xBCA
	Parameters: 3
	Flags: Linked
*/
function function_1e3bd96a(str_group, var_eafa8a1a, var_55a37c48)
{
	/#
		assert(isdefined(var_eafa8a1a), "");
	#/
	var_55a37c48 = (isdefined(var_55a37c48) ? var_55a37c48 : randomfloatrange(0.75, 1));
	switch(var_eafa8a1a)
	{
		case "seated_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_2e2971c6c8f10114")), "set_playback_speed", var_55a37c48);
			wait(2.7);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_12629d4e935c4656")), "set_playback_speed", var_55a37c48);
			wait(2.7 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_2da56ff9700d9164")), "set_playback_speed", var_55a37c48);
			wait(2.7 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6c024bd52bb7e766")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_baf5290a3576eed")), "set_playback_speed", var_55a37c48);
			wait(8.333 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_3e5b404caf7e8b58")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_196682111694d8f1")), "set_playback_speed", var_55a37c48);
			wait(8.333 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral_to_cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6afc936043f3a9f9")), "set_playback_speed", var_55a37c48);
			wait(8.333 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6f45d5578dd7000a")), "set_playback_speed", var_55a37c48);
			wait(5 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer_to_neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_556eddf8af2677b1")), "set_playback_speed", var_55a37c48);
			wait(6.666 / var_55a37c48);
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "seated":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "angry":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "neutral":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")), "set_playback_speed", var_55a37c48);
			break;
		}
		case "cheer":
		{
			smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")), "set_playback_speed", var_55a37c48);
			break;
		}
	}
}

/*
	Name: function_1bb8e9c4
	Namespace: zm_towers
	Checksum: 0x1ACD5A6
	Offset: 0x7560
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_1bb8e9c4()
{
	if(math::cointoss())
	{
		wait(randomfloatrange(0.15, 0.5));
	}
}

/*
	Name: function_ceb8d00f
	Namespace: zm_towers
	Checksum: 0x59A3AB48
	Offset: 0x75A0
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function function_ceb8d00f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level thread function_d431f37a();
	}
	else
	{
		level notify(#"hash_53c191bb10cd9670");
		for(var_1cc68a25 = 0; var_1cc68a25 < array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27").size; var_1cc68a25++)
		{
			level thread function_1e3bd96a(array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27")[var_1cc68a25], "cheer_to_seated");
		}
	}
}

/*
	Name: function_d431f37a
	Namespace: zm_towers
	Checksum: 0xD54391F4
	Offset: 0x76C8
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_d431f37a()
{
	level notify(#"hash_53c191bb10cd9670");
	level endon(#"hash_53c191bb10cd9670");
	var_1cc68a25 = 0;
	while(true)
	{
		level thread function_1e3bd96a(array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27")[var_1cc68a25], "seated_to_cheer", 2);
		wait(2);
		level thread function_1e3bd96a(array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27")[var_1cc68a25], "cheer_to_seated", 2);
		var_1cc68a25++;
		if(var_1cc68a25 > array("siege_crowd_stand_a_grp27", "siege_crowd_stand_b_grp27", "siege_crowd_stand_c_grp27", "siege_crowd_stand_d_grp27").size - 1)
		{
			var_1cc68a25 = 0;
		}
	}
}

/*
	Name: function_99220e91
	Namespace: zm_towers
	Checksum: 0xE8C100D0
	Offset: 0x7818
	Size: 0x62
	Parameters: 7
	Flags: Linked
*/
function function_99220e91(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level.var_a46ee0d5 = 1;
	}
	else
	{
		level.var_a46ee0d5 = 0;
	}
}

/*
	Name: snd_crowd_react
	Namespace: zm_towers
	Checksum: 0x45116812
	Offset: 0x7888
	Size: 0x48C
	Parameters: 7
	Flags: Linked
*/
function snd_crowd_react(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 8)
	{
		level thread function_cdc077de(localclientnum);
		return;
	}
	if(newval == 11)
	{
		if(oldval == 5)
		{
			level thread function_cbe2ea1(localclientnum, 0);
		}
		playsound(0, #"hash_4e3cdd42739b4a0b", (0, 0, 0));
		a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
		foreach(struct in a_structs)
		{
			playsound(localclientnum, #"hash_61052d99f398097", struct.origin);
			waitframe(1);
		}
		level notify(#"hash_18e33e7f341865b5");
		return;
	}
	if(newval == 12)
	{
		level thread function_f68a332e(localclientnum, 1);
		return;
	}
	if(newval == 13)
	{
		level thread function_f68a332e(localclientnum, 0);
		return;
	}
	if(newval == 9 || newval == 10)
	{
		if(oldval == 5)
		{
			level thread function_cbe2ea1(localclientnum, 0);
		}
		level thread function_21a2fea4(localclientnum, newval);
		return;
	}
	if(newval == 14 || newval == 15)
	{
		if(oldval == 5)
		{
			level thread function_cbe2ea1(localclientnum, 0);
		}
		level thread function_ba9941c(localclientnum, newval);
		return;
	}
	if(newval == 5)
	{
		level thread function_cbe2ea1(localclientnum, 1);
		return;
	}
	if(oldval == 5)
	{
		level thread function_cbe2ea1(localclientnum, 0);
	}
	switch(newval)
	{
		case 0:
		{
			str_alias = #"hash_90cda71914ccf25";
			break;
		}
		case 1:
		{
			str_alias = #"hash_2a3c75c57c227b04";
			break;
		}
		case 2:
		{
			str_alias = #"hash_2a3c75c57c227b04";
			break;
		}
		case 3:
		{
			str_alias = #"hash_4857544e0712e0cc";
			break;
		}
		case 4:
		{
			str_alias = #"hash_4857544e0712e0cc";
			break;
		}
		case 6:
		{
			str_alias = #"hash_2a3c75c57c227b04";
			break;
		}
		case 7:
		{
			str_alias = #"hash_4857544e0712e0cc";
			break;
		}
		case 8:
		{
			str_alias = #"hash_4857544e0712e0cc";
			break;
		}
	}
	level thread function_9ed12c12(localclientnum, str_alias);
}

/*
	Name: function_9ed12c12
	Namespace: zm_towers
	Checksum: 0xCF71AF87
	Offset: 0x7D20
	Size: 0x100
	Parameters: 2
	Flags: Linked
*/
function function_9ed12c12(localclientnum, str_alias)
{
	a_structs = struct::get_array("sndCrowdOneshot", "targetname");
	foreach(s_struct in a_structs)
	{
		if(isdefined(s_struct.script_int) && s_struct.script_int)
		{
			playsound(localclientnum, str_alias, s_struct.origin);
			wait(randomfloatrange(0.15, 0.5));
		}
	}
}

/*
	Name: function_cdc077de
	Namespace: zm_towers
	Checksum: 0x1D1C92E4
	Offset: 0x7E28
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function function_cdc077de(localclientnum)
{
	a_structs = struct::get_array("sndCrowdOneshot", "targetname");
	a_structs = array::randomize(a_structs);
	var_18f6745a = struct::get("sndCrowdLevelstart", "targetname");
	playsound(localclientnum, #"hash_481bb2830d09d01f", var_18f6745a.origin);
	var_74d304e8 = 1;
	foreach(s_struct in a_structs)
	{
		if(isdefined(s_struct.script_int) && s_struct.script_int)
		{
			playsound(localclientnum, #"hash_7ef570749fdb2ff2" + var_74d304e8, s_struct.origin);
			wait(randomfloatrange(0.15, 0.5));
			var_74d304e8++;
		}
	}
	level notify(#"hash_18e33e7f341865b5");
	level notify(#"hash_61e23ff49a338bcf");
	wait(3);
	if(zm_utility::is_standard() || zm_utility::function_3bff983f())
	{
		return;
	}
	level thread function_21a2fea4(localclientnum, 9);
}

/*
	Name: function_21a2fea4
	Namespace: zm_towers
	Checksum: 0xE0646967
	Offset: 0x8048
	Size: 0x166
	Parameters: 2
	Flags: Linked
*/
function function_21a2fea4(localclientnum, var_a0d24aa6)
{
	a_structs = struct::get_array("mus_crowd", "targetname");
	var_ffc05b22 = "_start_";
	var_5babe62d = randomintrange(1, 5);
	if(var_a0d24aa6 == 10)
	{
		var_ffc05b22 = "_end_";
		var_5babe62d = randomintrange(1, 4);
	}
	foreach(s_struct in a_structs)
	{
		var_1f2066a = s_struct.script_string;
		playsound(localclientnum, "mus_crowd_" + var_1f2066a + var_ffc05b22 + var_5babe62d, s_struct.origin);
		waitframe(1);
	}
}

/*
	Name: function_cbe2ea1
	Namespace: zm_towers
	Checksum: 0xE93C5212
	Offset: 0x81B8
	Size: 0x24E
	Parameters: 3
	Flags: Linked
*/
function function_cbe2ea1(localclientnum, var_49f77cdc, var_4b327660 = 0)
{
	if(!isdefined(level.var_ecc6b1b0))
	{
		level.var_ecc6b1b0 = 0;
	}
	if(var_49f77cdc)
	{
		level.var_ecc6b1b0 = function_21a3a673(0, 4);
		a_structs = struct::get_array("sndCrowdOneshot", "targetname");
		a_structs = array::randomize(a_structs);
		foreach(s_struct in a_structs)
		{
			if(isdefined(s_struct.script_int) && s_struct.script_int || var_4b327660)
			{
				audio::playloopat("amb_crowd_positive_max_lp_" + level.var_ecc6b1b0, s_struct.origin);
				waitframe(1);
			}
		}
	}
	else
	{
		a_structs = struct::get_array("sndCrowdOneshot", "targetname");
		foreach(s_struct in a_structs)
		{
			if(isdefined(s_struct.script_int) && s_struct.script_int || var_4b327660)
			{
				audio::stoploopat("amb_crowd_positive_max_lp_" + level.var_ecc6b1b0, s_struct.origin);
				waitframe(1);
			}
		}
	}
}

/*
	Name: function_ba9941c
	Namespace: zm_towers
	Checksum: 0x7956A726
	Offset: 0x8410
	Size: 0x42C
	Parameters: 2
	Flags: Linked
*/
function function_ba9941c(localclientnum, newval)
{
	if(!isdefined(level.var_7994da16))
	{
		level.var_7994da16 = "_good";
	}
	a_structs = struct::get_array("mus_crowd", "targetname");
	if(newval == 14)
	{
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			playsound(localclientnum, "mus_crowd_" + var_1f2066a + "_special_start", s_struct.origin);
			waitframe(1);
		}
		wait(6.3);
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			audio::playloopat("mus_crowd_" + var_1f2066a + "_special_loop", s_struct.origin);
			waitframe(1);
		}
		if(isdefined(level.var_a46ee0d5) && level.var_a46ee0d5)
		{
			level.var_7994da16 = "_good";
			if(math::cointoss() && math::cointoss())
			{
				level.var_7994da16 = "_shreds";
			}
			audio::playloopat("mus_crowd_arena_rock_main" + level.var_7994da16, (0, 1205, 715));
			waitframe(1);
			audio::playloopat("mus_crowd_arena_rock_swt" + level.var_7994da16, (0, -803, 439));
		}
	}
	else if(newval == 15 || newval == 16)
	{
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			if(newval == 15)
			{
				playsound(localclientnum, "mus_crowd_" + var_1f2066a + "_special_end", s_struct.origin);
			}
			audio::stoploopat("mus_crowd_" + var_1f2066a + "_special_loop", s_struct.origin);
			waitframe(1);
		}
		if(isdefined(level.var_a46ee0d5) && level.var_a46ee0d5)
		{
			audio::stoploopat("mus_crowd_arena_rock_main" + level.var_7994da16, (0, 1205, 715));
			waitframe(1);
			audio::stoploopat("mus_crowd_arena_rock_swt" + level.var_7994da16, (0, -803, 439));
		}
	}
}

/*
	Name: function_f68a332e
	Namespace: zm_towers
	Checksum: 0x9A1BAC92
	Offset: 0x8848
	Size: 0x2F6
	Parameters: 2
	Flags: Linked
*/
function function_f68a332e(localclientnum, var_12ae4a7b)
{
	a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
	if(var_12ae4a7b)
	{
		wait(4);
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			playsound(localclientnum, "mus_crowd_" + var_1f2066a + "_boss_start", s_struct.origin);
			waitframe(1);
		}
		wait(4.8);
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			audio::playloopat("mus_crowd_" + var_1f2066a + "_boss_loop", s_struct.origin);
			waitframe(1);
		}
	}
	else
	{
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			playsound(localclientnum, "mus_crowd_" + var_1f2066a + "_boss_end", s_struct.origin);
			waitframe(1);
		}
		wait(1);
		foreach(s_struct in a_structs)
		{
			var_1f2066a = s_struct.script_string;
			audio::stoploopat("mus_crowd_" + var_1f2066a + "_boss_loop", s_struct.origin);
			waitframe(1);
		}
	}
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_towers
	Checksum: 0x29C2FD0F
	Offset: 0x8B48
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
	Name: function_b3928b74
	Namespace: zm_towers
	Checksum: 0xC38D577C
	Offset: 0x8DD8
	Size: 0x1F8
	Parameters: 7
	Flags: Linked
*/
function function_b3928b74(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx = "special_round_camera_start";
	var_59806731 = "special_round_camera_persist";
	var_bf4d56bf = self getentitynumber();
	if(newval == 2)
	{
		str_fx = "maelstrom_camera_fx";
		var_59806731 = "maelstrom_camera_fx";
	}
	if(newval)
	{
		if(self == function_5c10bd79(localclientnum))
		{
			playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
			if(isdefined(level.var_2d4bfff3[var_bf4d56bf]))
			{
				deletefx(localclientnum, level.var_2d4bfff3[var_bf4d56bf]);
			}
			level.var_2d4bfff3[var_bf4d56bf] = playfxoncamera(localclientnum, level._effect[var_59806731], (0, 0, 0), (1, 0, 0), (0, 0, 1));
		}
	}
	else
	{
		foreach(fx in level.var_2d4bfff3)
		{
			deletefx(localclientnum, fx);
		}
	}
}

/*
	Name: function_94675baf
	Namespace: zm_towers
	Checksum: 0x43625A1
	Offset: 0x8FD8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_94675baf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level exploder::exploder("exp_special_round_gas");
		setexposureactivebank(localclientnum, 2);
	}
	else
	{
		level exploder::stop_exploder("exp_special_round_gas");
		setexposureactivebank(localclientnum, 1);
	}
}

/*
	Name: function_bdc63758
	Namespace: zm_towers
	Checksum: 0x1D36B73
	Offset: 0x9098
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_bdc63758(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playsound(localclientnum, #"hash_539eb529963d7db4");
		self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_blue"], self, "j_neck");
		self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
	if(isdefined(self.sfx))
	{
		self stoploopsound(self.sfx);
		self.sfx = undefined;
	}
}

/*
	Name: function_c41817fc
	Namespace: zm_towers
	Checksum: 0x69E11109
	Offset: 0x91E0
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_c41817fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playsound(localclientnum, #"hash_539eb529963d7db4");
		self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_green"], self, "j_neck");
		self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
	if(isdefined(self.sfx))
	{
		self stoploopsound(self.sfx);
		self.sfx = undefined;
	}
}

/*
	Name: function_27a7a3be
	Namespace: zm_towers
	Checksum: 0xD62F4329
	Offset: 0x9328
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_27a7a3be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playsound(localclientnum, #"hash_539eb529963d7db4");
		self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_purple"], self, "j_neck");
		self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
	if(isdefined(self.sfx))
	{
		self stoploopsound(self.sfx);
		self.sfx = undefined;
	}
}

/*
	Name: function_d056a230
	Namespace: zm_towers
	Checksum: 0xDDFD6A36
	Offset: 0x9470
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_d056a230(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playsound(localclientnum, #"hash_539eb529963d7db4");
		self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_red"], self, "j_neck");
		self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
	if(isdefined(self.sfx))
	{
		self stoploopsound(self.sfx);
		self.sfx = undefined;
	}
}

/*
	Name: function_57f3914e
	Namespace: zm_towers
	Checksum: 0xF96A52CB
	Offset: 0x95B8
	Size: 0x302
	Parameters: 7
	Flags: Linked
*/
function function_57f3914e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get("odin_brazier");
	switch(newval)
	{
		case 0:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 1:
		{
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"brazier_fire_blue"], s_fx.origin);
			playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
			audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 2:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
			playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
			audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			break;
		}
	}
}

/*
	Name: function_6e6d4bfc
	Namespace: zm_towers
	Checksum: 0x7383A655
	Offset: 0x98C8
	Size: 0x302
	Parameters: 7
	Flags: Linked
*/
function function_6e6d4bfc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get("danu_brazier");
	switch(newval)
	{
		case 0:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 1:
		{
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"brazier_fire_green"], s_fx.origin);
			playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
			audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 2:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
			playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
			audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			break;
		}
	}
}

/*
	Name: function_66050c9e
	Namespace: zm_towers
	Checksum: 0xF599CDCC
	Offset: 0x9BD8
	Size: 0x302
	Parameters: 7
	Flags: Linked
*/
function function_66050c9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get("zeus_brazier");
	switch(newval)
	{
		case 0:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 1:
		{
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"brazier_fire_purple"], s_fx.origin);
			playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
			audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 2:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
			playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
			audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			break;
		}
	}
}

/*
	Name: function_1c231f3f
	Namespace: zm_towers
	Checksum: 0x1DA59249
	Offset: 0x9EE8
	Size: 0x302
	Parameters: 7
	Flags: Linked
*/
function function_1c231f3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_fx = struct::get("ra_brazier");
	switch(newval)
	{
		case 0:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 1:
		{
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"brazier_fire_red"], s_fx.origin);
			playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
			audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
			audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
			break;
		}
		case 2:
		{
			if(isdefined(s_fx.var_9d6d94a8))
			{
				stopfx(localclientnum, s_fx.var_9d6d94a8);
				s_fx.var_9d6d94a8 = undefined;
			}
			s_fx.var_9d6d94a8 = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
			playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
			audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
			audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
			break;
		}
	}
}

/*
	Name: function_87e8980d
	Namespace: zm_towers
	Checksum: 0x86466449
	Offset: 0xA1F8
	Size: 0xB6
	Parameters: 7
	Flags: Linked
*/
function function_87e8980d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"energy_soul"], self, "j_neck");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
}

/*
	Name: function_b29b7566
	Namespace: zm_towers
	Checksum: 0xB85DA8C6
	Offset: 0xA2B8
	Size: 0xB6
	Parameters: 7
	Flags: Linked
*/
function function_b29b7566(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"energy_soul_target"], self, "j_neck");
	}
	else if(isdefined(self.fx))
	{
		self.fx delete();
		self.fx = undefined;
	}
}

/*
	Name: banner_soul_burst
	Namespace: zm_towers
	Checksum: 0x7B902582
	Offset: 0xA378
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function banner_soul_burst(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"banner_soul_burst"], self.origin);
}

/*
	Name: function_a1d393ad
	Namespace: zm_towers
	Checksum: 0x8BA03E6D
	Offset: 0xA3F8
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_a1d393ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			forcestreamxmodel(#"p8_zm_gla_heart_zombie");
			break;
		}
		case 0:
		{
			stopforcestreamingxmodel(#"p8_zm_gla_heart_zombie");
			break;
		}
	}
}

/*
	Name: function_ee4f01d8
	Namespace: zm_towers
	Checksum: 0x888C3ED3
	Offset: 0xA4C0
	Size: 0x118
	Parameters: 7
	Flags: Linked
*/
function function_ee4f01d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_a882b6eb = struct::get_array("sndCrowdOneshot");
	foreach(var_809c9dc3 in var_a882b6eb)
	{
		playsound(localclientnum, #"hash_4857544e0712e0cc", var_809c9dc3.origin);
		n_random_wait = randomfloatrange(0.15, 0.5);
		wait(n_random_wait);
	}
}

/*
	Name: acid_trap_death_fx
	Namespace: zm_towers
	Checksum: 0x8A09BC1C
	Offset: 0xA5E0
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function acid_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_963e2d39 = util::playfxontag(localclientnum, level._effect[#"acid_death"], self, "j_spine4");
		self.var_5911b395 = self playloopsound(#"hash_21fbee9ffef9a6d7");
	}
	else if(isdefined(self.var_963e2d39))
	{
		stopfx(localclientnum, self.var_963e2d39);
		self.var_963e2d39 = undefined;
		self stoploopsound(self.var_5911b395);
	}
}

/*
	Name: function_29bd0c51
	Namespace: zm_towers
	Checksum: 0x2C1F84E2
	Offset: 0xA6F8
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_29bd0c51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_eae524c4 = util::playfxontag(localclientnum, level._effect[#"trap_switch_green"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
	}
	else if(isdefined(self.var_eae524c4))
	{
		stopfx(localclientnum, self.var_eae524c4);
		self.var_eae524c4 = undefined;
	}
}

/*
	Name: function_75347b12
	Namespace: zm_towers
	Checksum: 0x151C64F8
	Offset: 0xA7C8
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_75347b12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_326470f = util::playfxontag(localclientnum, level._effect[#"trap_switch_red"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
	}
	else if(isdefined(self.var_326470f))
	{
		stopfx(localclientnum, self.var_326470f);
		self.var_326470f = undefined;
	}
}

/*
	Name: function_25ebc4f7
	Namespace: zm_towers
	Checksum: 0x18C8540E
	Offset: 0xA898
	Size: 0x136
	Parameters: 7
	Flags: Linked
*/
function function_25ebc4f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_b07a8611 = util::playfxontag(localclientnum, level._effect[#"trap_switch_smoke"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
		if(!isdefined(self.var_7696023a))
		{
			self.var_7696023a = self playloopsound(#"hash_228d379ca7c13b55");
		}
	}
	else if(isdefined(self.var_b07a8611))
	{
		stopfx(localclientnum, self.var_b07a8611);
		self.var_b07a8611 = undefined;
	}
	if(isdefined(self.var_7696023a))
	{
		self stoploopsound(self.var_7696023a);
		self.var_7696023a = undefined;
	}
}

/*
	Name: acid_trap_postfx
	Namespace: zm_towers
	Checksum: 0x1400EB07
	Offset: 0xA9D8
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function acid_trap_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self postfx::playpostfxbundle("pstfx_zm_acid_dmg_towers");
		self postfx::playpostfxbundle("pstfx_zm_acid_dmg_towers_2");
		self.var_431ddde9 = self playloopsound(#"hash_341a3fa00975f232");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_zm_acid_dmg_towers");
		self postfx::exitpostfxbundle("pstfx_zm_acid_dmg_towers_2");
		if(isdefined(self.var_431ddde9))
		{
			self stoploopsound(self.var_431ddde9);
		}
	}
}

/*
	Name: function_a8195148
	Namespace: zm_towers
	Checksum: 0x187965C3
	Offset: 0xAAF8
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_a8195148(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_7d8225fa = util::playfxontag(localclientnum, level._effect[#"hash_42cc4bf5e47478c5"], self, "tag_origin");
	}
	else if(isdefined(self.var_7d8225fa))
	{
		stopfx(localclientnum, self.var_7d8225fa);
		self.var_7d8225fa = undefined;
	}
}

/*
	Name: function_24673586
	Namespace: zm_towers
	Checksum: 0x6FF85CD1
	Offset: 0xABC0
	Size: 0x126
	Parameters: 7
	Flags: Linked
*/
function function_24673586(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_a7333ca8 = util::playfxontag(localclientnum, level._effect[#"hash_3b746cf6eec416b2"], self, "tag_origin");
		self.var_48eb9b0 = util::playfxontag(localclientnum, level._effect[#"hash_36535f89ec2488d7"], self, "tag_origin");
	}
	else if(isdefined(self.var_a7333ca8))
	{
		stopfx(localclientnum, self.var_a7333ca8);
		stopfx(localclientnum, self.var_48eb9b0);
		self.var_a7333ca8 = undefined;
		self.var_48eb9b0 = undefined;
	}
}

/*
	Name: function_e9a85af
	Namespace: zm_towers
	Checksum: 0x4DF56C3E
	Offset: 0xACF0
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_e9a85af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	s_fx = struct::get(#"hash_43872a24dfb85c96");
	playfx(localclientnum, level._effect[#"hash_584e8f7433246444"], s_fx.origin, anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
}

/*
	Name: function_90076b73
	Namespace: zm_towers
	Checksum: 0xA5FCC4FC
	Offset: 0xADD0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_90076b73(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_daa52f70(localclientnum, "danu");
}

/*
	Name: function_e26b1e6b
	Namespace: zm_towers
	Checksum: 0xF168D246
	Offset: 0xAE38
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_e26b1e6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_daa52f70(localclientnum, "ra");
}

/*
	Name: function_25a6ede2
	Namespace: zm_towers
	Checksum: 0x11C88909
	Offset: 0xAEA0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_25a6ede2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_daa52f70(localclientnum, "odin");
}

/*
	Name: function_a2800857
	Namespace: zm_towers
	Checksum: 0xD2C5097E
	Offset: 0xAF08
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_a2800857(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_daa52f70(localclientnum, "zeus");
}

/*
	Name: function_daa52f70
	Namespace: zm_towers
	Checksum: 0x2EEAA2F0
	Offset: 0xAF70
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_daa52f70(localclientnum, var_5542e979)
{
	s_fx = struct::get(#"hash_73ea18ffc4b86f9b" + var_5542e979);
	playfx(localclientnum, level._effect[#"hash_33a4b9fa0803ab64"], s_fx.origin, anglestoforward(s_fx.angles));
}

/*
	Name: function_3fb29ca1
	Namespace: zm_towers
	Checksum: 0x50968D53
	Offset: 0xB018
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_3fb29ca1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_8b55eef7 = playfx(localclientnum, level._effect[#"hash_3dca6eaa62a8f783"], self.origin);
	}
	else if(isdefined(self.var_8b55eef7))
	{
		stopfx(localclientnum, self.var_8b55eef7);
		self.var_8b55eef7 = undefined;
	}
}

/*
	Name: function_76dd176c
	Namespace: zm_towers
	Checksum: 0xDA777BEE
	Offset: 0xB0E0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_76dd176c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_c80206ce = util::playfxontag(localclientnum, level._effect[#"hash_4c4f96aa02c32a2a"], self, "tag_origin");
	}
	else if(isdefined(self.var_c80206ce))
	{
		stopfx(localclientnum, self.var_c80206ce);
		self.var_c80206ce = undefined;
	}
}

/*
	Name: function_5dc8b5fa
	Namespace: zm_towers
	Checksum: 0xBB6C96D0
	Offset: 0xB1A8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_5dc8b5fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	playfx(localclientnum, level._effect[#"hash_7bd75ae600e0a590"], self.origin);
}

/*
	Name: function_91305947
	Namespace: zm_towers
	Checksum: 0x4D391F54
	Offset: 0xB228
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_91305947(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_48ad84f9cf6a33f0"], self, "tag_fx");
}

/*
	Name: function_ba86af94
	Namespace: zm_towers
	Checksum: 0xF7B28CE6
	Offset: 0xB2A8
	Size: 0xE6
	Parameters: 7
	Flags: Linked
*/
function function_ba86af94(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_30f4bba7 = self zbarriergetpiece(1);
	if(newval)
	{
		level.var_8832c6a2 = util::playfxontag(localclientnum, level._effect[#"hash_3974bea828fbf7f7"], var_30f4bba7, "tag_fx");
	}
	else if(isdefined(level.var_8832c6a2))
	{
		stopfx(localclientnum, level.var_8832c6a2);
		level.var_8832c6a2 = undefined;
	}
}

/*
	Name: function_36469123
	Namespace: zm_towers
	Checksum: 0xC8B470DA
	Offset: 0xB398
	Size: 0x2B2
	Parameters: 7
	Flags: Linked
*/
function function_36469123(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_2462a1c = self zbarriergetpiece(1);
	var_f8c61710 = self zbarriergetpiece(2);
	if(newval)
	{
		var_88961f1a = util::playfxontag(localclientnum, level._effect[#"hash_3a51c9895d4afcf7"], var_2462a1c, "top_skull_head_jnt");
		var_9dd8f492 = util::playfxontag(localclientnum, level._effect[#"hash_3a51c9895d4afcf7"], var_f8c61710, "top_skull_head_jnt");
		if(!isdefined(level.var_51c2c67a))
		{
			level.var_51c2c67a = [];
		}
		else if(!isarray(level.var_51c2c67a))
		{
			level.var_51c2c67a = array(level.var_51c2c67a);
		}
		level.var_51c2c67a[level.var_51c2c67a.size] = var_88961f1a;
		if(!isdefined(level.var_51c2c67a))
		{
			level.var_51c2c67a = [];
		}
		else if(!isarray(level.var_51c2c67a))
		{
			level.var_51c2c67a = array(level.var_51c2c67a);
		}
		level.var_51c2c67a[level.var_51c2c67a.size] = var_9dd8f492;
	}
	else if(isdefined(level.var_51c2c67a))
	{
		foreach(n_fx in level.var_51c2c67a)
		{
			stopfx(localclientnum, n_fx);
		}
		level.var_51c2c67a = undefined;
	}
}

/*
	Name: function_a7b41dea
	Namespace: zm_towers
	Checksum: 0xAC6D7AB2
	Offset: 0xB658
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function function_a7b41dea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_30f4bba7 = self zbarriergetpiece(2);
	if(!isdefined(level.var_25faefd0))
	{
		v_origin = var_30f4bba7 gettagorigin("j_lid");
		v_angles = var_30f4bba7 gettagangles("j_lid");
		v_angles = v_angles + vectorscale((0, 1, 0), 90);
		level.var_25faefd0 = util::spawn_model(localclientnum, "tag_origin", v_origin, v_angles);
		level.var_25faefd0 linkto(var_30f4bba7, "j_lid");
	}
	if(newval)
	{
		level.var_bf78c2cd = util::playfxontag(localclientnum, level._effect[#"hash_1add6939914df65a"], level.var_25faefd0, "tag_origin");
	}
	else if(isdefined(level.var_bf78c2cd))
	{
		stopfx(localclientnum, level.var_bf78c2cd);
		level.var_bf78c2cd = undefined;
	}
	if(isdefined(level.var_25faefd0))
	{
		level.var_25faefd0 unlink();
		level.var_25faefd0 delete();
		level.var_25faefd0 = undefined;
	}
}

/*
	Name: function_1941a5ca
	Namespace: zm_towers
	Checksum: 0xB9B33BD6
	Offset: 0xB860
	Size: 0xE6
	Parameters: 7
	Flags: Linked
*/
function function_1941a5ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_30f4bba7 = self zbarriergetpiece(2);
	if(newval)
	{
		level.var_9354725d = util::playfxontag(localclientnum, level._effect[#"hash_5dc6f97e5850e1d1"], var_30f4bba7, "tag_fx");
	}
	else if(isdefined(level.var_9354725d))
	{
		stopfx(localclientnum, level.var_9354725d);
		level.var_9354725d = undefined;
	}
}

/*
	Name: function_ef17abb4
	Namespace: zm_towers
	Checksum: 0x11869BE9
	Offset: 0xB950
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_ef17abb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_36e4ebd4(localclientnum, #"hash_50888989ae869119");
	function_36e4ebd4(localclientnum, #"hash_9c55bc1ac704fee");
}

/*
	Name: function_98d53b6b
	Namespace: zm_towers
	Checksum: 0x4363469E
	Offset: 0xB9D8
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function function_98d53b6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_3d4f2e38cdf19caa");
		forcestreamxmodel(#"hash_77c082bfbea9adca");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_3d4f2e38cdf19caa");
		stopforcestreamingxmodel(#"hash_77c082bfbea9adca");
	}
}

/*
	Name: function_a2128708
	Namespace: zm_towers
	Checksum: 0x9AFD778E
	Offset: 0xBAB0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_a2128708(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_36e4ebd4(localclientnum, "damage_heavy");
	earthquake(localclientnum, 1, 0.25, self.origin, 64);
}

/*
	Name: function_f7102023
	Namespace: zm_towers
	Checksum: 0x4D4FD03E
	Offset: 0xBB48
	Size: 0x138
	Parameters: 7
	Flags: Linked
*/
function function_f7102023(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_4dd195ea = struct::get_array("s_maelstrom_initiate_fx");
	foreach(s_fx in var_4dd195ea)
	{
		playfx(localclientnum, level._effect[#"hash_3b3d40b9e7427939"], s_fx.origin, anglestoforward(s_fx.angles));
		playsound(localclientnum, #"hash_44163603295b2408", s_fx.origin);
	}
}

/*
	Name: function_9d72720a
	Namespace: zm_towers
	Checksum: 0x953B1181
	Offset: 0xBC88
	Size: 0xE6
	Parameters: 7
	Flags: Linked
*/
function function_9d72720a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_7ef98b90 = util::playfxontag(localclientnum, level._effect[#"hash_4e7b1766cc26a866"], self, "tag_origin");
		self playsound(localclientnum, #"hash_68123d3c746fe40c");
	}
	else if(isdefined(self.var_7ef98b90))
	{
		stopfx(localclientnum, self.var_7ef98b90);
		self.var_7ef98b90 = undefined;
	}
}

/*
	Name: function_e21e7dbe
	Namespace: zm_towers
	Checksum: 0xFDDFEC52
	Offset: 0xBD78
	Size: 0x17E
	Parameters: 7
	Flags: Linked
*/
function function_e21e7dbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_8e8be900 = util::playfxontag(localclientnum, level._effect[#"hash_1814d4cc1867739c"], self, "tag_origin");
		if(!isdefined(self.var_45052c1f))
		{
			self playsound(localclientnum, #"hash_5653bacd3880f5e6");
			self.var_45052c1f = self playloopsound(#"hash_1158ca937d0645df");
		}
	}
	else if(isdefined(self.var_8e8be900))
	{
		stopfx(localclientnum, self.var_8e8be900);
		self.var_8e8be900 = undefined;
	}
	if(isdefined(self.var_45052c1f))
	{
		self playsound(localclientnum, #"hash_3dc40c9d94d68a08");
		self stoploopsound(self.var_45052c1f);
		self.var_45052c1f = undefined;
	}
}

/*
	Name: function_4a9243dc
	Namespace: zm_towers
	Checksum: 0x20779F9F
	Offset: 0xBF00
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function function_4a9243dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_32d23a6 = util::playfxontag(localclientnum, level._effect[#"hash_314d3a2e542805c0"], self, "tag_origin");
		self playsound(localclientnum, #"hash_7be24f149608de05");
	}
	else if(isdefined(self.var_32d23a6))
	{
		stopfx(localclientnum, self.var_32d23a6);
		self.var_32d23a6 = undefined;
	}
	self playsound(localclientnum, #"hash_484f870ae922590");
}

/*
	Name: function_14c0b237
	Namespace: zm_towers
	Checksum: 0xDBF5DB43
	Offset: 0xC018
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_14c0b237(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	playfx(localclientnum, level._effect[#"hash_1ff85f67b6d93430"], self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
}

/*
	Name: function_45b8306b
	Namespace: zm_towers
	Checksum: 0x5F4AA64D
	Offset: 0xC0C8
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function function_45b8306b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	playfx(localclientnum, level._effect[#"hash_1ff85f67b6d93430"], self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
	function_36e4ebd4(localclientnum, "lightninggun_fire");
	self playsound(localclientnum, #"hash_784c6d9757964494");
}

/*
	Name: function_e9192031
	Namespace: zm_towers
	Checksum: 0x74F460FC
	Offset: 0xC1C0
	Size: 0x106
	Parameters: 7
	Flags: Linked
*/
function function_e9192031(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(!isdefined(self.var_cc93270e))
		{
			self playsound(localclientnum, #"hash_5949809a2b6867a3");
			self.var_cc93270e = self playloopsound(#"hash_15a98fa81782b075");
		}
	}
	else if(isdefined(self.var_cc93270e))
	{
		self playsound(localclientnum, #"hash_2a8bc9fc5e6a2b6");
		self stoploopsound(self.var_cc93270e);
		self.var_cc93270e = undefined;
	}
}

/*
	Name: function_2d6ec02
	Namespace: zm_towers
	Checksum: 0x8178C7A2
	Offset: 0xC2D0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_2d6ec02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self playsound(localclientnum, #"hash_57b0d65c6bc36311");
}

/*
	Name: function_8ad1050e
	Namespace: zm_towers
	Checksum: 0xF3B65E63
	Offset: 0xC340
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_8ad1050e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(!isalive(self))
	{
		return;
	}
	function_36e4ebd4(localclientnum, "damage_heavy");
	earthquake(localclientnum, 1, 0.25, self.origin, 64);
}

/*
	Name: function_7dbeb0c5
	Namespace: zm_towers
	Checksum: 0xA1FBE998
	Offset: 0xC3F0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_7dbeb0c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	playfx(localclientnum, level._effect[#"hash_63e758aa5387132a"], self.origin, anglestoforward(self.angles));
}

/*
	Name: function_fa2e6690
	Namespace: zm_towers
	Checksum: 0xDFE77E5A
	Offset: 0xC488
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_fa2e6690(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_1cac7f38 = util::playfxontag(localclientnum, level._effect[#"hash_23ba00d2f804acc2"], self, "tag_origin");
	}
	else if(isdefined(self.var_1cac7f38))
	{
		stopfx(localclientnum, self.var_1cac7f38);
		self.var_1cac7f38 = undefined;
	}
}

/*
	Name: function_fc502d48
	Namespace: zm_towers
	Checksum: 0x71AC164A
	Offset: 0xC550
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_fc502d48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		level exploder::exploder("fxexp_fast_travel_orbs");
	}
	else
	{
		level exploder::stop_exploder("fxexp_fast_travel_orbs");
	}
}

/*
	Name: function_5cdc8b28
	Namespace: zm_towers
	Checksum: 0xC9457790
	Offset: 0xC5E0
	Size: 0x54
	Parameters: 7
	Flags: Linked
*/
function function_5cdc8b28(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self thread function_a8fa1dc3(newval);
}

/*
	Name: function_a8fa1dc3
	Namespace: zm_towers
	Checksum: 0x2CD1D246
	Offset: 0xC640
	Size: 0x2BE
	Parameters: 1
	Flags: Linked
*/
function function_a8fa1dc3(b_show)
{
	self notify("7dc29fd1e387db86");
	self endon("7dc29fd1e387db86");
	self endon(#"death");
	if(!self flag::exists(#"hash_71f56d0cc4c3df1f"))
	{
		self flag::init(#"hash_71f56d0cc4c3df1f");
		self flag::set(#"hash_71f56d0cc4c3df1f");
		self function_bf9d3071(#"hash_16b8b568a95931e7");
	}
	n_start_time = gettime();
	n_end_time = n_start_time + int(0.5 * 1000);
	var_f86b693b = 0;
	var_c4c52c72 = 1;
	var_5ae2cd40 = 1;
	if(!b_show)
	{
		var_f86b693b = 1;
		var_c4c52c72 = 0;
		var_5ae2cd40 = 0;
	}
	if(var_5ae2cd40)
	{
		forcestreamxmodel(self.model);
	}
	else
	{
		stopforcestreamingxmodel(self.model);
	}
	while(true)
	{
		n_time = gettime();
		if(n_time >= n_end_time)
		{
			self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", var_c4c52c72);
			self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", var_c4c52c72);
			break;
		}
		n_alpha = mapfloat(n_start_time, n_end_time, var_f86b693b, var_c4c52c72, n_time);
		self function_78233d29(#"hash_16b8b568a95931e7", "", "brightness", n_alpha);
		self function_78233d29(#"hash_16b8b568a95931e7", "", "alpha", n_alpha);
		waitframe(1);
	}
}

/*
	Name: function_5c9f28ec
	Namespace: zm_towers
	Checksum: 0x145CA11D
	Offset: 0xC908
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function function_5c9f28ec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_7a3d3907 = playfx(localclientnum, level._effect[#"hash_5afda864f8b64f5c"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
	}
	else if(isdefined(self.var_7a3d3907))
	{
		stopfx(localclientnum, self.var_7a3d3907);
		self.var_7a3d3907 = undefined;
	}
}

/*
	Name: function_e63747a9
	Namespace: zm_towers
	Checksum: 0x64F5D126
	Offset: 0xCA00
	Size: 0xD2
	Parameters: 7
	Flags: Linked
*/
function function_e63747a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval && !isdefined(self.var_2ec44947))
	{
		self.var_2ec44947 = util::playfxontag(localclientnum, level._effect[#"hash_56c34d8ec9a098c2"], self, "tag_fx_eye_01");
		self.var_e1812ec2 = util::playfxontag(localclientnum, level._effect[#"hash_56c34d8ec9a098c2"], self, "tag_fx_eye_02");
	}
}

/*
	Name: function_44a2fe02
	Namespace: zm_towers
	Checksum: 0x86AC0083
	Offset: 0xCAE0
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function function_44a2fe02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		function_a5777754(localclientnum, "ee_space");
		function_93620041(localclientnum, "arena_occluder_volume");
	}
	else
	{
		function_73b1f242(localclientnum, "ee_space");
		function_9362afb8(localclientnum, "arena_occluder_volume");
	}
}

/*
	Name: function_4c2b87ed
	Namespace: zm_towers
	Checksum: 0x8F1C8CB0
	Offset: 0xCBB0
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_4c2b87ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "lower_pit");
	}
	else
	{
		function_73b1f242(localclientnum, "lower_pit");
	}
}

/*
	Name: function_9290b227
	Namespace: zm_towers
	Checksum: 0x13363984
	Offset: 0xCC40
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
	Namespace: zm_towers
	Checksum: 0x1FE831BC
	Offset: 0xCDB0
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

