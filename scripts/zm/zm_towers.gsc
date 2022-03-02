// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1781ac145d783f87;
#using script_18e21a7011416ce0;
#using script_1b10fdf0addd52e;
#using script_266240d702093827;
#using script_27c22e1d8df4d852;
#using script_2affe92664ace48d;
#using script_31a8049bdbd4af27;
#using script_349128b28e416f03;
#using script_3a3c430eb58ed475;
#using script_3f9e0dc8454d98e1;
#using script_42ac6fc8b2ff0f3e;
#using script_50ce372e19db9e7c;
#using script_5e036f43dab5ec66;
#using script_6021ce59143452c3;
#using script_6334bf874cddcc13;
#using script_684097158a90b5c3;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using script_715f403a46a823eb;
#using script_7224d61ed502ea07;
#using script_84036a646acb958;
#using script_891797ced4432ca;
#using script_b52a163973f339f;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_towers_achievements.gsc;
#using scripts\zm\zm_towers_challenges.gsc;
#using scripts\zm\zm_towers_gamemodes.gsc;
#using scripts\zm\zm_towers_main_quest.gsc;
#using scripts\zm\zm_towers_pap_quest.gsc;
#using scripts\zm\zm_towers_util.gsc;
#using scripts\zm\zm_towers_ww_quest.gsc;
#using scripts\zm\zm_towers_zones.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_towers;

/*
	Name: opt_in
	Namespace: zm_towers
	Checksum: 0x65372A8A
	Offset: 0xEE0
	Size: 0xCE
	Parameters: 0
	Flags: AutoExec
*/
function autoexec opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	setdvar(#"player_usewaterfriction", 0);
	setdvar(#"hash_558e57dbb6559778", 1);
	setdvar(#"hash_fb15eb644cc51ed", 3000);
	level.var_13473346 = 0;
	level.zombie_round_start_delay = 0;
	level.pack_a_punch_camo_index = 151;
	level.pack_a_punch_camo_index_number_variants = 5;
}

/*
	Name: main
	Namespace: zm_towers
	Checksum: 0x5A5E94ED
	Offset: 0xFB8
	Size: 0x1C06
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setclearanceceiling(24);
	zm::init_fx();
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
	clientfield::register("scriptmover", "zombie_head_pickup_glow", 1, 1, "int");
	clientfield::register("scriptmover", "blue_glow", 1, 1, "int");
	clientfield::register("allplayers", "force_pap_models", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_32782b46ea19f365", 1, 1, "int");
	clientfield::register("scriptmover", "sentinel_artifact_fx_mist", 1, 1, "int");
	clientfield::register("world", "crowd_react", 1, 2, "int");
	clientfield::register("world", "crowd_react_boss", 1, 1, "int");
	clientfield::register("world", "" + #"crowd_react_wave", 1, 1, "int");
	clientfield::register("toplayer", "snd_crowd_react", 1, 4, "int");
	clientfield::register("world", "special_round_smoke", 1, 1, "int");
	clientfield::register("allplayers", "special_round_camera", 1, 2, "int");
	clientfield::register("world", "brazier_fire_blue", 1, 2, "int");
	clientfield::register("world", "brazier_fire_green", 1, 2, "int");
	clientfield::register("world", "brazier_fire_purple", 1, 2, "int");
	clientfield::register("world", "brazier_fire_red", 1, 2, "int");
	clientfield::register("scriptmover", "head_fire_blue", 1, 1, "int");
	clientfield::register("scriptmover", "head_fire_green", 1, 1, "int");
	clientfield::register("scriptmover", "head_fire_purple", 1, 1, "int");
	clientfield::register("scriptmover", "head_fire_red", 1, 1, "int");
	clientfield::register("allplayers", "force_challenge_model", 1, 1, "int");
	clientfield::register("scriptmover", "energy_soul", 1, 1, "int");
	clientfield::register("scriptmover", "energy_soul_target", 1, 1, "int");
	clientfield::register("scriptmover", "banner_soul_burst", 1, 1, "counter");
	clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int");
	clientfield::register("scriptmover", "trap_switch_green", 1, 1, "int");
	clientfield::register("scriptmover", "trap_switch_red", 1, 1, "int");
	clientfield::register("scriptmover", "trap_switch_smoke", 1, 1, "int");
	clientfield::register("toplayer", "acid_trap_postfx", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7478ffee8332e21e", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_2bbcb9e09bd7bb26", 1, 1, "counter");
	clientfield::register("scriptmover", "entry_gate_dust", 1, 1, "int");
	clientfield::register("world", "" + #"hash_16b9e3d69cb7a017", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_42cc4bf5e47478c5", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3b746cf6eec416b2", 1, 1, "int");
	clientfield::register("world", "" + #"hash_584e8f7433246444", 1, 1, "int");
	clientfield::register("world", "" + #"hash_418c1c843450232b", 1, 1, "int");
	clientfield::register("world", "" + #"hash_4d547bf36c6cb2d8", 1, 1, "int");
	clientfield::register("world", "" + #"hash_38ba3ad0902aa355", 1, 1, "int");
	clientfield::register("world", "" + #"hash_24d7233bb17e6558", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3dca6eaa62a8f783", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_2c6f04d08665dbda", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2a332df32456c86f", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_48ad84f9cf6a33f0", 1, 1, "counter");
	clientfield::register("zbarrier", "" + #"hash_3974bea828fbf7f7", 1, 1, "int");
	clientfield::register("zbarrier", "" + #"hash_3a51c9895d4afcf7", 1, 1, "int");
	clientfield::register("zbarrier", "" + #"hash_1add6939914df65a", 1, 1, "int");
	clientfield::register("zbarrier", "" + #"hash_5dc6f97e5850e1d1", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_47e0e1e96b037286", 1, 1, "counter");
	clientfield::register("world", "" + #"hash_2383fd01b106ced8", 1, 1, "int");
	clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_6ff3eb2dd0078a51", 1, 1, "counter");
	clientfield::register("world", "" + #"hash_445060dbbf244b04", 1, 1, "int");
	clientfield::register("world", "" + #"hash_a2fb645044ed12e", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3f79f6da0222ebc2", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_c382c02584ba249", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_273efcc293063e5e", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4a963ca015392163", 1, 1, "int");
	clientfield::register("world", "" + #"hash_5a3e1454226ef7a4", 1, 1, "int");
	clientfield::register("world", "" + #"hash_73088ea3053b96f1", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_233e31d0c2b47b1b", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_12dfb8249f8212d2", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_17e3041649954b9f", 1, 1, "int");
	clientfield::register("scriptmover", "ra_eyes_beam_fire", 1, 1, "int");
	clientfield::register("scriptmover", "ra_rooftop_eyes_beam_fire", 1, 1, "int");
	clientfield::register("world", "" + #"hash_57c08e5f4792690c", 1, 1, "int");
	clientfield::register("world", "" + #"hash_440f23773f551a48", 1, 1, "int");
	clientfield::register("world", "" + #"hash_4e5e2b411c997804", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_3b3d40b9e7427939", 1, 1, "counter");
	clientfield::register("world", "" + #"hash_6bc33c82908d4d2c", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4e7b1766cc26a866", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1814d4cc1867739c", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_314d3a2e542805c0", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_522e903485969f46", 1, 1, "counter");
	clientfield::register("actor", "" + #"maelstrom_death", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_17002d8f9d5c197b", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_182c03ff2a21c07c", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_137bf198b0b91ba9", 1, 1, "int");
	clientfield::register("world", "" + #"hash_1f09a5290d31eb37", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_63e758aa5387132a", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_23ba00d2f804acc2", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2407f687f7d24a83", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_5afda864f8b64f5c", 1, 1, "int");
	clientfield::register("world", "" + #"hash_39e6b14b9e5b0f3d", 1, 1, "int");
	level.var_210ce105 = zm_towers_crowd_meter::register("zm_towers_crowd_meter");
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = #"electric/fx8_sparks_burst_dir_sm_orange_os";
	level._effect[#"hash_21167096dfea3409"] = #"hash_b6f89a048c38cf6";
	level.default_start_location = "zone_starting_area_ra";
	level.default_game_mode = "zclassic";
	level.var_cd8b6cd0 = 2;
	level thread namespace_8f39dfb1::init();
	if(!zm_utility::is_standard())
	{
		level.round_wait_func = &function_ebe4d15c;
	}
	level.var_262798e2 = &function_f1e7bc35;
	level.var_290ac2c3 = &function_f1e7bc35;
	level.var_ea32773 = &function_8e4eff2b;
	level thread namespace_700b02ad::init();
	level.var_22fda912 = &function_9f50079d;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	level.var_d0ab70a2 = #"hash_42dcec7533a676b0";
	level._allow_melee_weapon_switching = 1;
	level.zombiemode_reusing_pack_a_punch = 1;
	level.var_43db5ea6 = getweapon(#"hash_c78156ba6aeda14");
	callback::function_20263b9e(&namespace_11c28b18::function_c05cc102);
	level.pack_a_punch.custom_power_think = &namespace_2ea65b04::function_9b917fd5;
	level.var_ef785c4c = 0;
	level.use_powerup_volumes = 1;
	level.var_881e464e = 1;
	level._no_vending_machine_auto_collision = 1;
	level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
	spawner::add_archetype_spawn_function(#"blight_father", &function_15f5b16c);
	level.var_1c666963 = 96;
	load::main();
	level thread namespace_2e6d0155::init();
	level.zones = [];
	level.zone_manager_init_func = &namespace_31edf1d5::zone_init;
	init_zones[0] = "zone_starting_area_ra";
	level thread zm_zonemgr::manage_zones(init_zones);
	level thread function_63a4a57a();
	level.custom_pandora_show_func = &custom_pandora_show_func;
	level.random_pandora_box_start = 1;
	level.open_chest_location = [];
	level.magic_box_zbarrier_state_func = &zm_magicbox::function_35c66b27;
	level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
	level.chest_joker_custom_movement = &zm_magicbox::function_f5503c41;
	level thread magicbox_host_migration();
	level thread function_5d95d2ab();
	var_2c661c04 = struct::get_array("treasure_chest_use");
	for(i = 0; i < var_2c661c04.size; i++)
	{
		level.open_chest_location[i] = var_2c661c04[i].script_noteworthy;
	}
	level thread function_c6450415();
	level thread sndfunctions();
	level thread namespace_26ab2959::init();
	level thread namespace_ebd828b::init();
	level thread namespace_2d756999::init();
	level thread namespace_2ea65b04::init();
	level thread namespace_31edf1d5::init();
	level thread namespace_574b32d2::init();
	level thread namespace_9d301ad2::init();
	level.vending_machines_powered_on_at_start = 1;
	level flag::set("power_on");
	level.var_d5bd7049 = #"hash_30a8de8c86fd7103";
	if(!zm_utility::is_standard())
	{
		level.var_d0b54199 = &function_b770efae;
		level.custom_door_buy_check = &function_57e80330;
		level thread function_535ff7c4();
	}
	a_t_doors = getentarray("zombie_door", "targetname");
	array::thread_all(a_t_doors, &function_58a931ce);
	/#
		level thread function_2bb502f5();
	#/
	level thread setup_drawbridge();
	if(!zm_utility::function_e51dc2d8())
	{
		hidemiscmodels("narmod");
	}
	level.var_b5079c7c = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_bowie", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_burst_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_drum_pistol_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
	namespace_59ff1d6c::function_a00576dd(&function_7722c6f0, &function_389e7c22, &function_c8ce0a17, undefined);
	level.var_43216bdf = &function_b2b69ce5;
}

/*
	Name: function_b2b69ce5
	Namespace: zm_towers
	Checksum: 0x3E5D8C2B
	Offset: 0x2BC8
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b2b69ce5(b_game_ended)
{
	if(!b_game_ended)
	{
		namespace_2ea65b04::function_18b39e14();
	}
}

/*
	Name: function_8e4eff2b
	Namespace: zm_towers
	Checksum: 0x46E7EE86
	Offset: 0x2BF8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_8e4eff2b()
{
	if(isdefined(level.var_210ce105))
	{
		array::thread_all(level.players, &namespace_ebd828b::function_51ea46f3, 0, 1);
	}
}

/*
	Name: function_7722c6f0
	Namespace: zm_towers
	Checksum: 0x7325A944
	Offset: 0x2C48
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function function_7722c6f0(var_404e4288, var_8dd554ee)
{
	var_6095c0b6 = namespace_a28acff3::function_4e8157cd(var_404e4288, var_8dd554ee);
	if(isalive(var_6095c0b6.ai_spawned))
	{
		zm_transform::function_d2374144(var_6095c0b6.ai_spawned, #"blight_father");
	}
	return true;
}

/*
	Name: function_389e7c22
	Namespace: zm_towers
	Checksum: 0xCE0BE6C2
	Offset: 0x2CD0
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function function_389e7c22(var_404e4288, var_8dd554ee)
{
	if(math::cointoss())
	{
		ai = namespace_acd9c698::function_60e6998a();
	}
	else
	{
		ai = namespace_acd9c698::function_bb067153();
	}
	return true;
}

/*
	Name: function_c8ce0a17
	Namespace: zm_towers
	Checksum: 0xC7D32360
	Offset: 0x2D40
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	if(math::cointoss())
	{
		var_6095c0b6 = namespace_a28acff3::function_4e8157cd(var_404e4288, var_8dd554ee);
		if(isalive(var_6095c0b6.ai_spawned))
		{
			zm_transform::function_d2374144(var_6095c0b6.ai_spawned, array::random(array(#"hash_78ca8e8e6bdbc8ab", #"hash_266b62e342076a90", #"hash_5cfa99582cc66c59", #"hash_5d6b55906fc82ff2")));
		}
	}
	else
	{
		ai = namespace_3fe4d0d7::round_spawn();
	}
	return true;
}

/*
	Name: function_f6e12f01
	Namespace: zm_towers
	Checksum: 0xFC7E33A
	Offset: 0x2E58
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function function_f6e12f01()
{
	var_9581be99 = struct::get_array("s_ww_quest_acid_trap_unitrigger");
	var_7eb95af0 = arraycopy(level.var_4fe2f84d[#"zblueprint_trap_hellpools"]);
	var_7eb95af0 = array::randomize(var_7eb95af0);
	foreach(var_dca0e32e in var_9581be99)
	{
		var_dca0e32e namespace_574b32d2::function_a58dfad4();
	}
	foreach(var_eea6b8f1 in var_7eb95af0)
	{
		var_eea6b8f1 namespace_574b32d2::function_b4bc6524();
	}
}

/*
	Name: setup_drawbridge
	Namespace: zm_towers
	Checksum: 0x6C7DAB0C
	Offset: 0x2FB0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function setup_drawbridge()
{
	scene::init("p8_fxanim_zm_towers_drawbridge_bundle");
	level flag::wait_till("connect_odin_zeus_bridge");
	scene::play("p8_fxanim_zm_towers_drawbridge_bundle");
}

/*
	Name: function_c6450415
	Namespace: zm_towers
	Checksum: 0x9E1E455E
	Offset: 0x3010
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_c6450415()
{
	level flag::wait_till("magicbox_initialized");
	array::thread_all(level.chests, &function_1789a4cc);
}

/*
	Name: function_1789a4cc
	Namespace: zm_towers
	Checksum: 0xE208332F
	Offset: 0x3068
	Size: 0x320
	Parameters: 0
	Flags: Linked
*/
function function_1789a4cc()
{
	switch(self.script_noteworthy)
	{
		case "tower_a_chest":
		{
			str_exploder = "exp_lgt_magic_box_odin2";
			break;
		}
		case "tower_b_chest":
		{
			str_exploder = "exp_lgt_magic_box_zeus2";
			break;
		}
		case "tower_c_chest":
		{
			str_exploder = "exp_lgt_magic_box_danu2";
			break;
		}
		case "tower_d_chest":
		{
			str_exploder = "exp_lgt_magic_box_ra2";
			break;
		}
		case "tower_a_lower_chest":
		{
			str_exploder = "exp_lgt_magic_box_odinb";
			break;
		}
		case "tower_b_lower_chest":
		{
			str_exploder = "exp_lgt_magic_box_zeusb";
			break;
		}
		case "tower_c_lower_chest":
		{
			str_exploder = "exp_lgt_magic_box_danub";
			break;
		}
		case "tower_d_lower_chest":
		{
			str_exploder = "exp_lgt_magic_box_rab";
			break;
		}
		case "ra_odin_tunnel_chest":
		{
			str_exploder = "exp_lgt_magic_box_cat_swt";
			break;
		}
		case "danu_zeus_tunnel_chest":
		{
			str_exploder = "exp_lgt_magic_box_cat_net";
			break;
		}
	}
	zbarrier = self.zbarrier;
	self flag::init(#"hash_30f92e7370f31c86");
	while(true)
	{
		str_state = zbarrier zm_magicbox::get_magic_box_zbarrier_state();
		switch(str_state)
		{
			case "initial":
			{
				if(!self flag::get(#"hash_30f92e7370f31c86"))
				{
					self flag::set(#"hash_30f92e7370f31c86");
					exploder::exploder(str_exploder);
				}
				break;
			}
			case "arriving":
			{
				if(!self flag::get(#"hash_30f92e7370f31c86"))
				{
					self flag::set(#"hash_30f92e7370f31c86");
					exploder::exploder(str_exploder);
				}
				break;
			}
			case "away":
			{
				self flag::clear(#"hash_30f92e7370f31c86");
				exploder::stop_exploder(str_exploder);
				break;
			}
		}
		zbarrier waittill(#"zbarrier_state_change");
	}
}

/*
	Name: function_ebe4d15c
	Namespace: zm_towers
	Checksum: 0xA2B2CACC
	Offset: 0x3390
	Size: 0x226
	Parameters: 0
	Flags: Linked
*/
function function_ebe4d15c()
{
	level endon(#"restart_round", #"kill_round_wait");
	/#
		level endon(#"kill_round");
		if(getdvarint(#"zombie_rise_test", 0))
		{
			level waittill(#"forever");
		}
		if(zm::cheat_enabled(2))
		{
			level waittill(#"forever");
		}
		if(getdvarint(#"zombie_default_max", 0) == 0)
		{
			level waittill(#"forever");
		}
		level thread namespace_a28acff3::print_zombie_counts();
		level thread namespace_a28acff3::sndmusiconkillround();
	#/
	level.var_4b5a684c = namespace_a28acff3::get_zombie_count_for_round(level.round_number, level.players.size);
	while(true)
	{
		var_7e5b8365 = level flag::get(#"infinite_round_spawning") || (zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission);
		if(!var_7e5b8365 || level flag::get("end_round_wait"))
		{
			break;
		}
		if(level flag::get("round_reset"))
		{
			return;
		}
		wait(1);
	}
	level.var_13473346 = 0;
}

/*
	Name: adjustments_for_solo
	Namespace: zm_towers
	Checksum: 0xCC5ADE1A
	Offset: 0x35C0
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function adjustments_for_solo()
{
	if(isdefined(level.is_forever_solo_game) && level.is_forever_solo_game)
	{
		a_door_buys = getentarray("zombie_door", "targetname");
		array::thread_all(a_door_buys, &door_price_reduction_for_solo);
		a_debris_buys = getentarray("zombie_debris", "targetname");
		array::thread_all(a_debris_buys, &door_price_reduction_for_solo);
	}
}

/*
	Name: door_price_reduction_for_solo
	Namespace: zm_towers
	Checksum: 0x1FA83106
	Offset: 0x3680
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function door_price_reduction_for_solo()
{
	if(self.zombie_cost >= 750)
	{
		self.zombie_cost = self.zombie_cost - 250;
		if(isdefined(level.var_d0b54199))
		{
			self thread [[level.var_d0b54199]](self, self.zombie_cost);
		}
		else
		{
			if(self.targetname == "zombie_door")
			{
				self zm_utility::set_hint_string(self, "default_buy_door", self.zombie_cost);
			}
			else
			{
				self zm_utility::set_hint_string(self, "default_buy_debris", self.zombie_cost);
			}
		}
	}
}

/*
	Name: function_9f50079d
	Namespace: zm_towers
	Checksum: 0x6D5D5BFE
	Offset: 0x3758
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_9f50079d()
{
	zm_loadout::register_tactical_grenade_for_level("zhield_zword_dw", 1);
}

/*
	Name: offhand_weapon_give_override
	Namespace: zm_towers
	Checksum: 0x25310699
	Offset: 0x3788
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function offhand_weapon_give_override(str_weapon)
{
	self endon(#"death");
	if(zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon))
	{
		self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
		self takeweapon(self zm_loadout::get_player_tactical_grenade());
	}
	return false;
}

/*
	Name: sndfunctions
	Namespace: zm_towers
	Checksum: 0xE4A9B5A6
	Offset: 0x3858
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function sndfunctions()
{
	if(zm_utility::is_standard())
	{
		level.zmannouncerprefix = "rush";
	}
	else
	{
		level.zmannouncerprefix = "prst";
	}
	zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
	level thread setupmusic();
	level thread custom_add_vox();
	level thread function_247786e5();
	level thread setup_personality_character_exerts();
}

/*
	Name: custom_add_vox
	Namespace: zm_towers
	Checksum: 0x437E6A93
	Offset: 0x3928
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function custom_add_vox()
{
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_5963a3db3032ab46");
	zm_audio::loadplayervoicecategories(#"hash_54bad987adb5e01d");
}

/*
	Name: setupmusic
	Namespace: zm_towers
	Checksum: 0xAB728915
	Offset: 0x3998
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "towers_roundstart_1", "towers_roundstart_2", "towers_roundstart_3");
	zm_audio::musicstate_create("round_end", 3, "towers_roundend_1", "towers_roundend_2", "towers_roundend_3");
	zm_audio::musicstate_create("round_start_special", 3, "towers_roundstart_special_1");
	zm_audio::musicstate_create("round_end_special", 3, "towers_roundend_special_1");
	zm_audio::musicstate_create("game_over", 5, "towers_death");
	zm_audio::musicstate_create("ee_song", 4, "towers_ee_song");
	zm_audio::musicstate_create("ee_song_2", 4, "towers_ee_song_2");
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_towers
	Checksum: 0x74D20825
	Offset: 0x3AE0
	Size: 0x3C8
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[1][#"hitmed"] = "vox_plr_1_exert_pain";
	level.exert_sounds[2][#"hitmed"] = "vox_plr_2_exert_pain";
	level.exert_sounds[3][#"hitmed"] = "vox_plr_3_exert_pain";
	level.exert_sounds[4][#"hitmed"] = "vox_plr_4_exert_pain";
	level.exert_sounds[1][#"hitlrg"] = "vox_plr_1_exert_pain";
	level.exert_sounds[2][#"hitlrg"] = "vox_plr_2_exert_pain";
	level.exert_sounds[3][#"hitlrg"] = "vox_plr_2_exert_pain";
	level.exert_sounds[4][#"hitlrg"] = "vox_plr_3_exert_pain";
	level.exert_sounds[1][#"drowning"] = "vox_plr_1_exert_underwater_air_low";
	level.exert_sounds[2][#"drowning"] = "vox_plr_2_exert_underwater_air_low";
	level.exert_sounds[3][#"drowning"] = "vox_plr_3_exert_underwater_air_low";
	level.exert_sounds[4][#"drowning"] = "vox_plr_4_exert_underwater_air_low";
	level.exert_sounds[1][#"cough"] = "vox_plr_1_exert_gas_cough";
	level.exert_sounds[2][#"cough"] = "vox_plr_2_exert_gas_cough";
	level.exert_sounds[3][#"cough"] = "vox_plr_3_exert_gas_cough";
	level.exert_sounds[4][#"cough"] = "vox_plr_4_exert_gas_cough";
	level.exert_sounds[1][#"underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
	level.exert_sounds[2][#"underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
	level.exert_sounds[3][#"underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
	level.exert_sounds[4][#"underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
	level.exert_sounds[1][#"underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
	level.exert_sounds[2][#"underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
	level.exert_sounds[3][#"underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
	level.exert_sounds[4][#"underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

/*
	Name: function_247786e5
	Namespace: zm_towers
	Checksum: 0x4BDE102B
	Offset: 0x3EB0
	Size: 0x844
	Parameters: 0
	Flags: Linked
*/
function function_247786e5()
{
	zm_audio::sndannouncervoxadd(#"hash_5f0f1e699aa7e761", #"hash_446a22a4b34cd68d");
	zm_audio::sndannouncervoxadd(#"hash_7ff858c269b8be00", #"hash_6f7313e32ff14a9e");
	zm_audio::sndannouncervoxadd(#"hash_260c83bb9470b", #"hash_7f3dee972dfa0bf1");
	zm_audio::sndannouncervoxadd(#"hash_78c79ed7fe5a14e6", #"hash_739067da8bb4af8c");
	zm_audio::sndannouncervoxadd(#"hash_2865f19fb8f73873", #"hash_4f6a00a5a3c6564d");
	zm_audio::sndannouncervoxadd(#"hash_2a8f3ff63eb265a9", #"hash_327de5526794e5f0");
	zm_audio::sndannouncervoxadd(#"hash_7e0b3bf6d477a92f", #"hash_5b911d862216715d");
	zm_audio::sndannouncervoxadd(#"hash_7e9f4297d7232ab0", #"hash_fc0a3fb08fac69b");
	zm_audio::sndannouncervoxadd(#"hash_1c9809895527844b", #"hash_203f6b90f79090f0");
	zm_audio::sndannouncervoxadd(#"hash_5bbde3b2770c9e6a", #"hash_34daf48f11cac2b1");
	zm_audio::sndannouncervoxadd(#"hash_3b388348c6fa1fd3", #"hash_30f4de8cfdfcb5cc");
	zm_audio::sndannouncervoxadd(#"hash_597c4173f2fd41a4", #"hash_627191d10da7cc2e");
	zm_audio::sndannouncervoxadd(#"hash_550bed5125d97a89", #"hash_36a8b8db648b289b");
	zm_audio::sndannouncervoxadd(#"hash_31347fc188da1db6", #"hash_2b7cdada327d66e8");
	zm_audio::sndannouncervoxadd(#"hash_6c9a2587a2563721", #"hash_195ac056692d16d7");
	zm_audio::sndannouncervoxadd(#"special_round_start", #"hash_1efab4e86747e0f6");
	zm_audio::sndannouncervoxadd(#"hash_18134dc5b9b39a96", #"hash_71004562f08075fe");
	zm_audio::sndannouncervoxadd(#"hash_589679a12150767a", #"hash_37fd0c2a4b8e0a74");
	zm_audio::sndannouncervoxadd(#"hash_582eea77824b014d", #"hash_38dd82e156d0465");
	zm_audio::sndannouncervoxadd(#"hash_4abb12b14a38d2e9", #"hash_eabdfb2bae6559b");
	zm_audio::sndannouncervoxadd(#"hash_5cc500f9282cd290", #"hash_67a5ea42470ad330");
	zm_audio::sndannouncervoxadd(#"hash_15f5946d4968f144", #"hash_279f089aafe9045e");
	zm_audio::sndannouncervoxadd(#"hash_20c64c155f7a0065", #"hash_21bdbf69a0d0a799");
	zm_audio::sndannouncervoxadd(#"hash_355567a6fa6d44d1", #"hash_594f2e892ce6cc37");
	zm_audio::sndannouncervoxadd(#"pap_quest_completed", #"hash_20930393d4b597bd");
	zm_audio::sndannouncervoxadd(#"hash_28dbb5b91d8a954e", #"hash_2b2a7c0ea867948e");
	zm_audio::sndannouncervoxadd(#"hash_3d5fccf222ba3ab6", #"hash_2b150384d50cde7c");
	zm_audio::sndannouncervoxadd(#"hash_5719edb294612f4c", #"hash_e36933881b70a00");
	zm_audio::sndannouncervoxadd(#"hash_42bbe4989b9a4cbe", #"hash_7ce238dcabc6916d");
	zm_audio::sndannouncervoxadd(#"hash_41d25c641d7c8484", #"hash_21f31b9d98f1e332");
	zm_audio::sndannouncervoxadd(#"hash_bc10546af7f7b09", #"hash_2c87f4c5bf8b38f4");
	zm_audio::sndannouncervoxadd(#"hash_70f3ffdacf094858", #"hash_59983ce3c5c98bea");
	zm_audio::sndannouncervoxadd(#"hash_5b34919a0ea0ac80", #"hash_6394a17f6fd9a269");
	zm_audio::sndannouncervoxadd(#"hash_50cc6c9d88534d5c", #"hash_34eb08732349aadf");
	zm_audio::sndannouncervoxadd(#"hash_412f0a99d31887f", #"hash_4950f09ba2a9a065");
	zm_audio::sndannouncervoxadd(#"hash_73183fb7534361f", #"hash_f9de473901d0e7d");
	zm_audio::sndannouncervoxadd(#"hash_6211a32e1a9f23fa", #"hash_518bb65266b74f86");
	zm_audio::sndannouncervoxadd(#"hash_24e22336a0d988d0", #"hash_7af55f23689f2eb4");
	zm_audio::sndannouncervoxadd(#"hash_43b0860b33146764", #"hash_2cef54d67ed44093");
	zm_audio::sndannouncervoxadd(#"hash_c8182d04e7f43c9", #"hash_5850b57ef4133eea");
	zm_audio::sndannouncervoxadd(#"hash_77080de04389f4df", #"hash_33d02faecbf4ced5");
	zm_audio::sndannouncervoxadd(#"hash_1b8dd2e5977116cb", #"hash_58fcefd43425141f");
	zm_audio::sndannouncervoxadd(#"hash_436d318af3fd771f", #"hash_5e7804dc338f11b6");
	zm_audio::sndannouncervoxadd(#"hash_62c7007e0bc4eab6", #"hash_621cc4c04ffd6c81");
}

/*
	Name: function_63a4a57a
	Namespace: zm_towers
	Checksum: 0x1675A87
	Offset: 0x4700
	Size: 0x2FE
	Parameters: 0
	Flags: Linked
*/
function function_63a4a57a()
{
	level endon(#"end_game");
	vol_arena = getent("vol_arena", "targetname");
	var_d4061661 = array(#"zone_starting_area_tunnel", #"zone_starting_area_center", #"zone_starting_area_danu", #"zone_starting_area_ra", #"zone_starting_area_odin", #"zone_starting_area_zeus", #"zone_danu_hallway", #"zone_ra_hallway", #"zone_odin_hallway", #"zone_zeus_hallway");
	level flag::wait_till("all_players_spawned");
	while(true)
	{
		wait(1);
		var_c83ad6e3 = 0;
		foreach(e_player in util::get_active_players())
		{
			if(e_player zm_zonemgr::is_player_in_zone(var_d4061661))
			{
				var_c83ad6e3 = 1;
				break;
			}
		}
		foreach(ai_zombie in getaiarray())
		{
			if(!isdefined(ai_zombie.var_4935908f) && (isdefined(ai_zombie.b_ignore_cleanup) && ai_zombie.b_ignore_cleanup))
			{
				continue;
			}
			if(var_c83ad6e3 && ai_zombie istouching(vol_arena))
			{
				ai_zombie.b_ignore_cleanup = 1;
				ai_zombie.var_4935908f = 1;
				continue;
			}
			if(isdefined(ai_zombie.var_4935908f) && ai_zombie.var_4935908f)
			{
				ai_zombie.var_4935908f = 0;
				ai_zombie.b_ignore_cleanup = 0;
			}
		}
	}
}

/*
	Name: function_f1e7bc35
	Namespace: zm_towers
	Checksum: 0x30CFB186
	Offset: 0x4A08
	Size: 0x2D6
	Parameters: 1
	Flags: Linked
*/
function function_f1e7bc35(s_spot)
{
	self endon(#"death");
	if(isdefined(s_spot.var_c104f8c7) && s_spot.var_c104f8c7)
	{
		return;
	}
	if(level flag::get("special_round"))
	{
		self thread namespace_700b02ad::function_461a99a5(s_spot);
	}
	switch(self.archetype)
	{
		case "tiger":
		{
			str_scene = s_spot.scriptbundlename;
			if(isdefined(s_spot.var_1b4b343d))
			{
				self.var_1b4b343d = s_spot.var_1b4b343d;
			}
			break;
		}
		case "gladiator":
		{
			str_scene = s_spot.var_5b15e8cd;
			if(self.var_9fde8624 == #"gladiator_marauder")
			{
				str_scene = s_spot.var_f8f13141;
			}
			break;
		}
	}
	if(!level flag::get("special_round"))
	{
		str_gate = s_spot.script_gate;
		if(isdefined(str_gate))
		{
			mdl_gate = getent(s_spot.script_gate, "script_gate");
			if(!isdefined(mdl_gate))
			{
				mdl_gate = getent(s_spot.script_gate, "targetname");
			}
			self thread function_dccf4bb9(mdl_gate);
			if(!isdefined(str_scene))
			{
				self thread function_6f26118c(mdl_gate);
			}
		}
	}
	if(!isdefined(str_scene))
	{
		return;
	}
	var_478f47cb = 0;
	if(!isdefined(self.var_1df64653))
	{
		var_478f47cb = 1;
		self.var_1df64653 = 1;
	}
	if(isdefined(s_spot.script_gate))
	{
		self scene::play(str_scene, self);
	}
	else
	{
		level scene::play(str_scene, self);
	}
	self notify(#"hash_1d525fe23da088ca");
	if(self.archetype == #"gladiator")
	{
		self notify(#"hash_7ff69a201a93f099");
	}
	if(var_478f47cb)
	{
		self.var_1df64653 = undefined;
	}
}

/*
	Name: function_dccf4bb9
	Namespace: zm_towers
	Checksum: 0x65830913
	Offset: 0x4CE8
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function function_dccf4bb9(mdl_gate)
{
	if(!isdefined(mdl_gate.var_408d5ee6))
	{
		mdl_gate.var_408d5ee6 = 0;
		mdl_gate thread function_97678f00();
	}
	mdl_gate.var_408d5ee6++;
	self waittill(#"death", #"hash_1d525fe23da088ca");
	mdl_gate.var_408d5ee6--;
}

/*
	Name: function_6f26118c
	Namespace: zm_towers
	Checksum: 0xB041EB0
	Offset: 0x4D68
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_6f26118c(mdl_gate)
{
	self endoncallback(&function_f493ba80, #"death");
	vol_gate = getent(mdl_gate.target, "targetname");
	while(!self istouching(vol_gate))
	{
		waitframe(1);
	}
	while(self istouching(vol_gate))
	{
		waitframe(1);
	}
	self notify(#"hash_1d525fe23da088ca");
}

/*
	Name: function_f493ba80
	Namespace: zm_towers
	Checksum: 0x1D04D1C9
	Offset: 0x4E28
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_f493ba80(notifyhash)
{
	self notify(#"hash_1d525fe23da088ca");
}

/*
	Name: function_97678f00
	Namespace: zm_towers
	Checksum: 0x585CA5DA
	Offset: 0x4E50
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_97678f00()
{
	while(true)
	{
		while(self.var_408d5ee6 == 0)
		{
			waitframe(1);
		}
		v_amount = vectorscale(self.script_vector, 1);
		self moveto(self.origin + v_amount, 1);
		self playsound(#"hash_75a2099e8df5a448");
		self waittill(#"movedone");
		while(self.var_408d5ee6 > 0)
		{
			waitframe(1);
		}
		v_amount = vectorscale(self.script_vector, -1);
		self moveto(self.origin + v_amount, 1);
		self playsound(#"hash_40e8e3be1a559184");
		self waittill(#"movedone");
	}
}

/*
	Name: function_5d95d2ab
	Namespace: zm_towers
	Checksum: 0x1C9944DA
	Offset: 0x4F80
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_5d95d2ab()
{
	zm_blockers::function_6f01c3cf("zm_towers_start_boards_open", "script_label");
	zm_blockers::function_6f01c3cf("zm_towers_start_boards_open_hidden", "script_label", 1);
}

/*
	Name: custom_pandora_show_func
	Namespace: zm_towers
	Checksum: 0x320B0A11
	Offset: 0x4FD8
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function custom_pandora_show_func(anchor, anchortarget, pieces)
{
	if(!isdefined(self.pandora_light))
	{
		self thread custom_pandora_fx_func();
	}
}

/*
	Name: custom_pandora_fx_func
	Namespace: zm_towers
	Checksum: 0x654C8B52
	Offset: 0x5020
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function custom_pandora_fx_func()
{
	self endon(#"death");
	self.pandora_light = spawn("script_model", self.zbarrier.origin);
	s_pandora_fx_pos_override = struct::get(self.target, "targetname");
	if(isdefined(s_pandora_fx_pos_override) && s_pandora_fx_pos_override.script_noteworthy === "pandora_fx_pos_override")
	{
		self.pandora_light.origin = s_pandora_fx_pos_override.origin;
	}
	self.pandora_light.angles = self.zbarrier.angles + (vectorscale((-1, 0, -1), 90));
	self.pandora_light setmodel(#"tag_origin");
	if(!(isdefined(level._box_initialized) && level._box_initialized))
	{
		level flag::wait_till("start_zombie_round_logic");
		level._box_initialized = 1;
	}
	wait(1);
	if(isdefined(self) && isdefined(self.pandora_light))
	{
		if(self.zbarrier.script_string === "t8_magicbox")
		{
			playfxontag(level._effect[#"hash_21167096dfea3409"], self.pandora_light, "tag_origin");
		}
		else
		{
			playfxontag(level._effect[#"lght_marker"], self.pandora_light, "tag_origin");
		}
	}
}

/*
	Name: magicbox_host_migration
	Namespace: zm_towers
	Checksum: 0x286461B2
	Offset: 0x5238
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function magicbox_host_migration()
{
	level endon(#"end_game");
	level notify(#"mb_hostmigration");
	level endon(#"mb_hostmigration");
	while(true)
	{
		level waittill(#"host_migration_end");
		if(!isdefined(level.chests))
		{
			continue;
		}
		foreach(chest in level.chests)
		{
			if(!(isdefined(chest.hidden) && chest.hidden))
			{
				if(isdefined(chest) && isdefined(chest.pandora_light))
				{
					if(chest.zbarrier.script_string === "t8_magicbox")
					{
						playfxontag(level._effect[#"hash_21167096dfea3409"], chest.pandora_light, "tag_origin");
					}
					else
					{
						playfxontag(level._effect[#"lght_marker"], chest.pandora_light, "tag_origin");
					}
				}
			}
			util::wait_network_frame();
		}
	}
}

/*
	Name: function_15f5b16c
	Namespace: zm_towers
	Checksum: 0x5B4609BB
	Offset: 0x5410
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_15f5b16c()
{
	self.b_ignore_cleanup = 1;
}

/*
	Name: function_535ff7c4
	Namespace: zm_towers
	Checksum: 0x3F91AC7D
	Offset: 0x5430
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_535ff7c4()
{
	level flag::wait_till("all_players_spawned");
	a_t_doors = getentarray("zombie_door", "targetname");
	foreach(t_door in a_t_doors)
	{
		t_door thread function_b770efae(t_door, t_door.zombie_cost);
	}
}

/*
	Name: function_b770efae
	Namespace: zm_towers
	Checksum: 0xB43EA014
	Offset: 0x5508
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_b770efae(t_door, n_cost)
{
	if(isdefined(t_door.var_c947f134) && t_door.var_c947f134)
	{
		t_door sethintstring(level.var_d5bd7049);
	}
	else
	{
		t_door zm_utility::set_hint_string(t_door, "default_buy_door", n_cost);
	}
}

/*
	Name: function_57e80330
	Namespace: zm_towers
	Checksum: 0xC4A76C66
	Offset: 0x5590
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_57e80330(t_door)
{
	var_e1223439 = !isdefined(t_door.var_c947f134);
	return var_e1223439;
}

/*
	Name: function_58a931ce
	Namespace: zm_towers
	Checksum: 0xB488D51
	Offset: 0x55C8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_58a931ce()
{
	if(!isdefined(self.var_f5325380))
	{
		return;
	}
	var_586fa0ec = getent(self.var_f5325380, "prefabname");
	if(!isdefined(var_586fa0ec))
	{
		var_586fa0ec = getent(self.var_f5325380, "targetname");
	}
	self waittill(#"door_opened");
	var_586fa0ec delete();
}

/*
	Name: function_5b2f92b3
	Namespace: zm_towers
	Checksum: 0x3F280605
	Offset: 0x5660
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function function_5b2f92b3()
{
	var_8011b2df = getentarray("lore_room", "targetname");
	foreach(e_door in var_8011b2df)
	{
		e_door delete();
	}
	exploder::exploder("exp_lgt_body_pit_secret_room");
	clientfield::set("" + #"hash_2383fd01b106ced8", 1);
}

/*
	Name: setup_end_igc
	Namespace: zm_towers
	Checksum: 0xCC47C9BC
	Offset: 0x5758
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function setup_end_igc(var_24486b2e = 1)
{
	level flag::clear("spawn_zombies");
	level flag::set(#"pause_round_timeout");
	var_cc8c907b = getent("mdl_maelstrom_initiate", "targetname");
	var_64dcf130 = getent("mdl_maelstrom_initiate_on", "targetname");
	if(isdefined(var_cc8c907b))
	{
		var_cc8c907b delete();
	}
	if(isdefined(var_64dcf130))
	{
		var_64dcf130 delete();
	}
	if(var_24486b2e)
	{
		level zm_utility::function_9ad5aeb1(0, 1, 1, 1, 0);
		level.var_5791d548 = 1;
		zombie_doors = getentarray("zombie_door", "targetname");
		level zm_blockers::function_5989dd12(zombie_doors);
		level.var_5791d548 = undefined;
		foreach(s_box in level.chests)
		{
			s_box thread zm_magicbox::hide_chest(0);
		}
	}
	util::set_lighting_state(1);
}

/*
	Name: function_643aeb5b
	Namespace: zm_towers
	Checksum: 0x56E64A74
	Offset: 0x5968
	Size: 0xF6
	Parameters: 0
	Flags: None
*/
function function_643aeb5b()
{
	/#
		level endon(#"end_game", #"hash_70406f82f80feda9");
		zm_devgui::zombie_devgui_open_sesame();
		level flag::clear("");
		level flag::set(#"pause_round_timeout");
		level zm_utility::function_9ad5aeb1(1);
		array::thread_all(level.players, &namespace_ebd828b::function_51ea46f3, 0, 1);
		while(level.var_a9ae3ceb)
		{
			level scene::play("");
			waitframe(1);
		}
	#/
}

/*
	Name: function_1ccb7366
	Namespace: zm_towers
	Checksum: 0x86C508EB
	Offset: 0x5A68
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_1ccb7366()
{
	/#
		level endon(#"end_game", #"hash_71cb0d80cda209f1");
		level flag::clear("");
		level flag::set(#"pause_round_timeout");
		level zm_utility::function_9ad5aeb1(0, 0, 1);
		level thread scene::play("", "");
		array::thread_all(level.players, &namespace_ebd828b::function_51ea46f3, 0, 1);
		while(level.var_68d47b4e)
		{
			level thread function_72e2cc56();
			level scene::play("");
			waitframe(1);
		}
	#/
}

/*
	Name: function_72e2cc56
	Namespace: zm_towers
	Checksum: 0x28AC4E23
	Offset: 0x5BA0
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function function_72e2cc56()
{
	/#
		level endon(#"end_game");
		s_glyphs = struct::get("");
		s_flames = struct::get("");
		while(level.var_68d47b4e)
		{
			level waittill(#"hash_1ea7a5302de9c85e");
			fx_glyphs = fx::play("", s_glyphs.origin, s_glyphs.angles, "");
			waitframe(1);
			fx_fire = fx::play("", s_flames.origin, s_flames.angles, "");
			level waittill(#"hash_18462f29f613ebbf", #"hash_71cb0d80cda209f1");
			fx_fire delete();
			fx_glyphs delete();
		}
	#/
}

/*
	Name: function_ef3f5ee5
	Namespace: zm_towers
	Checksum: 0x446BBF57
	Offset: 0x5D10
	Size: 0x116
	Parameters: 0
	Flags: None
*/
function function_ef3f5ee5()
{
	/#
		level endon(#"end_game", #"hash_2231f086364099b7");
		level flag::clear("");
		level flag::set(#"pause_round_timeout");
		array::thread_all(level.players, &namespace_ebd828b::function_51ea46f3, 0, 1);
		scene::init_streamer(#"hash_44287f972922420d", #"allies");
		while(level.var_7292cf15)
		{
			level thread function_79aa236();
			level scene::play("");
			waitframe(1);
		}
	#/
}

/*
	Name: function_79aa236
	Namespace: zm_towers
	Checksum: 0x4327C14C
	Offset: 0x5E30
	Size: 0x314
	Parameters: 0
	Flags: None
*/
function function_79aa236()
{
	/#
		level waittill(#"hash_550aae2e06c238ce");
		var_307566 = getentarray("", "");
		foreach(mdl_head in var_307566)
		{
			mdl_head show();
		}
		var_307566 = getentarray("", "");
		array::thread_all(var_307566, &namespace_2ea65b04::function_9b320791);
		level thread scene::play("");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level waittill(#"hash_6899d3d9802556ad");
		level thread scene::play("");
		level thread scene::play("");
		level waittill(#"hash_61ed5ad857c2709c");
		foreach(mdl_head in var_307566)
		{
			mdl_head hide();
		}
		level thread scene::init("");
		level thread scene::init("");
		level thread scene::init("");
		level thread scene::init("");
	#/
}

/*
	Name: function_2bb502f5
	Namespace: zm_towers
	Checksum: 0xA49A18E5
	Offset: 0x6150
	Size: 0x366
	Parameters: 0
	Flags: None
*/
function function_2bb502f5()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_8d6c5e6e);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
		}
		level.var_b9714a5d = &function_51855e65;
	#/
}

/*
	Name: function_8d6c5e6e
	Namespace: zm_towers
	Checksum: 0xDEA6CCCF
	Offset: 0x64C0
	Size: 0x9F2
	Parameters: 1
	Flags: None
*/
function function_8d6c5e6e(cmd)
{
	/#
		switch(cmd)
		{
			case "play_end_igc":
			{
				level thread function_ddb8acde();
				return true;
				break;
			}
			case "hash_4c5e426034ea40ef":
			{
				level notify(#"hash_53319c10defe971b");
				level.var_f2dc2287.var_12b6c455 = 4;
				level thread namespace_2d756999::function_2cb83322(#"hash_1404102ec1359017", #"hash_71fcbb6090ff031e");
				break;
			}
			case "hash_4c5e436034ea42a2":
			{
				level notify(#"hash_53319c10defe971b");
				level.var_f2dc2287.var_12b6c455 = 5;
				level thread namespace_2d756999::function_2cb83322(#"hash_1736e8c7a79a7db8", #"hash_2251bd5cecd3ebdb");
				break;
			}
			case "hash_4c5e446034ea4455":
			{
				level notify(#"hash_53319c10defe971b");
				level.var_f2dc2287.var_12b6c455 = 6;
				level thread namespace_2d756999::function_2cb83322(#"hash_642834b4c1587ac9", #"hash_6b02638730f2f88c");
				break;
			}
			case "hash_4c5e3d6034ea3870":
			{
				level notify(#"hash_53319c10defe971b");
				level.var_f2dc2287.var_12b6c455 = 7;
				level thread namespace_2d756999::function_2cb83322(#"hash_4ccddcb7cba5b2d2", #"hash_2897f70604cc0fb6");
				break;
			}
			case "hash_efd8532550aae92":
			{
				level.var_f2dc2287.var_12b6c455 = 8;
				level thread namespace_2d756999::function_d6e81c01(#"hash_4832047b1941ace1", #"hash_3501eab062d8e553");
				break;
			}
			case "hash_efd8432550aacdf":
			{
				level.var_f2dc2287.var_12b6c455 = 9;
				level thread namespace_2d756999::function_d6e81c01(#"hash_2ee2e728ad3b547e", #"hash_4aca0608bf4fa64e");
				break;
			}
			case "hash_efd8332550aab2c":
			{
				level.var_f2dc2287.var_12b6c455 = 10;
				level thread namespace_2d756999::function_d6e81c01(#"hash_48477035102bb86f", #"hash_38bae751fa353d99");
				break;
			}
			case "hash_efd8232550aa979":
			{
				level.var_f2dc2287.var_12b6c455 = 11;
				level thread namespace_2d756999::function_d6e81c01(#"hash_49fb781467abd24c", #"hash_634818c98eff6728");
				break;
			}
			case "hash_63968ec6789bd654":
			{
				mdl_wall = level.var_f2dc2287.a_objects[14];
				mdl_wall scene::play(#"p8_fxanim_zm_towers_wall_2_bundle", mdl_wall);
				break;
			}
			case "hash_36c98a2b5fcf250c":
			{
				level flag::set(#"hash_6205682540170b8");
				level clientfield::set("" + #"hash_39e6b14b9e5b0f3d", 1);
				break;
			}
			case "hash_5f00c356627b87c":
			{
				if(isdefined(level.var_68d47b4e) && level.var_68d47b4e)
				{
					level.var_68d47b4e = 0;
				}
				else
				{
					level.var_68d47b4e = 1;
					level thread function_1ccb7366();
				}
				break;
			}
			case "hash_3417e35e6adedf86":
			{
				if(isdefined(level.var_a9ae3ceb) && level.var_a9ae3ceb)
				{
					level.var_a9ae3ceb = 0;
				}
				else
				{
					level.var_a9ae3ceb = 1;
					level thread function_643aeb5b();
				}
				break;
			}
			case "hash_614f9d774217e602":
			{
				if(isdefined(level.var_7292cf15) && level.var_7292cf15)
				{
					level.var_7292cf15 = 0;
				}
				else
				{
					level.var_7292cf15 = 1;
					level thread function_ef3f5ee5();
				}
				break;
			}
			case "hash_50d92ca3c6c7c2a8":
			{
				level thread function_4110a06f();
				return true;
				break;
			}
			case "hash_3ce58f31f72a510f":
			{
				level thread function_9dc8cf3();
				return true;
				break;
			}
			case "hash_213c0ea9d797b6ea":
			{
				foreach(player in level.players)
				{
					player flag::set(#"hash_4246a36eeaccdedb");
					player flag::set(#"hash_1e11ea0627c40424");
					player flag::set(#"hash_15ea02b45ed633fa");
				}
				return true;
				break;
			}
			case "hash_237913b2f4a85a44":
			{
				level thread zm_towers_challenges::function_a83b406a();
				return true;
				break;
			}
			case "lore_room":
			{
				level thread function_5b2f92b3();
				return true;
				break;
			}
			case "hash_27bc74ddac87b156":
			{
				level thread namespace_2ea65b04::function_438a415(#"danu");
				return true;
				break;
			}
			case "hash_3bb09c753859632b":
			{
				level thread namespace_2ea65b04::function_438a415(#"ra");
				return true;
				break;
			}
			case "hash_40f87ec1dffc67d0":
			{
				level thread namespace_2ea65b04::function_438a415(#"odin");
				return true;
				break;
			}
			case "hash_2ca290409187993b":
			{
				level thread namespace_2ea65b04::function_438a415(#"zeus");
				return true;
				break;
			}
			case "hash_68370bceab1f118":
			{
				level thread namespace_2ea65b04::function_438a415(#"all");
				return true;
				break;
			}
			case "hash_2d60025acca3891":
			{
				level thread namespace_2ea65b04::function_883e88be("");
				return true;
				break;
			}
			case "hash_31ebe5f3e866cec9":
			{
				level thread namespace_2ea65b04::function_883e88be("");
				return true;
				break;
			}
			case "hash_42709656cacf1035":
			{
				level thread namespace_2ea65b04::function_883e88be("");
				return true;
				break;
			}
			case "hash_6aecfc20f8d3ae0d":
			{
				level flag::set(#"hash_3551c4ab09311644");
				return true;
				break;
			}
			case "hash_5220b8897cc03896":
			{
				level flag::set(#"hash_392f20a71becaec7");
				level flag::set(#"hash_3551c4ab09311644");
				return true;
				break;
			}
			case "hash_12584bff43cd127a":
			{
				level flag::set(#"hash_17425b597c04b9c3");
				level flag::set(#"hash_392f20a71becaec7");
				level flag::set(#"hash_3551c4ab09311644");
				return true;
				break;
			}
		}
	#/
}

/*
	Name: function_ddb8acde
	Namespace: zm_towers
	Checksum: 0x94C368B9
	Offset: 0x6EC0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_ddb8acde()
{
	/#
		level thread scene::init_streamer(#"hash_18b88682c325ad3d", #"allies");
		level setup_end_igc();
		level scene::play(#"hash_18b88682c325ad3d");
	#/
}

/*
	Name: function_4110a06f
	Namespace: zm_towers
	Checksum: 0x3C3D98D1
	Offset: 0x6F40
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_4110a06f()
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		level namespace_2ea65b04::function_97e78811(1, 1);
		level namespace_2ea65b04::function_156669dd(1, 1);
	#/
}

/*
	Name: function_9dc8cf3
	Namespace: zm_towers
	Checksum: 0xAD53F21C
	Offset: 0x6FA8
	Size: 0x118
	Parameters: 0
	Flags: None
*/
function function_9dc8cf3()
{
	/#
		foreach(e_player in level.activeplayers)
		{
			if(namespace_52d8d460::function_65a59ce0(e_player getcurrentweapon()))
			{
				e_player.var_c9d375dc.n_charge_level++;
				e_player clientfield::set("" + #"hash_58757f4a64fedf21", e_player.var_c9d375dc.n_charge_level);
				if(e_player.var_c9d375dc.n_charge_level >= 3)
				{
					e_player thread namespace_52d8d460::player_flame_on();
				}
			}
		}
	#/
}

/*
	Name: function_51855e65
	Namespace: zm_towers
	Checksum: 0x9B8AD436
	Offset: 0x70C8
	Size: 0x1B4
	Parameters: 1
	Flags: Private
*/
function private function_51855e65(round_number)
{
	/#
		var_efac84b3 = array(0, 500, 1000, 1000, 1400, 4000, 5000, 5500, 5500, 5500, 8000, 8000, 8000, 8000, 9000, 9000, 9000, 9500, 9500, 9500, 9500, 11000, 11000, 11000, 11000, 13000, 13000, 13000, 13000, 14000);
		var_ef0a371f = round_number - 1;
		/#
			assert(var_ef0a371f >= 0 && var_ef0a371f < 30);
		#/
		foreach(player in getplayers())
		{
			player zm_score::function_c1f146ff(var_efac84b3[var_ef0a371f]);
		}
		if(round_number >= 9)
		{
			namespace_b22c99a5::function_3e209fb6();
		}
		if(round_number >= 24)
		{
			namespace_b22c99a5::function_9c71b46f();
		}
	#/
}

