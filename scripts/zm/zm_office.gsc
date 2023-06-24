// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_minigun.gsc;
#using scripts\zm\zm_office_teleporters.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using script_174ebb9642933bf7;
#using scripts\zm\weapons\zm_weap_katana.gsc;
#using scripts\zm\zm_office_defcon.gsc;
#using scripts\zm_common\bgbs\zm_bgb_nowhere_but_there.gsc;
#using scripts\zm\weapons\zm_weap_gravityspikes.gsc;
#using script_293299be863018bb;
#using scripts\zm\zm_office_special_rounds.gsc;
#using scripts\zm\weapons\zm_weap_cymbal_monkey.gsc;
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using script_4bae07eadc57bb51;
#using scripts\zm\zm_office_trials.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm\zm_office_elevators.gsc;
#using script_59a783d756554a80;
#using scripts\zm\weapons\zm_weap_flamethrower.gsc;
#using scripts\zm_common\zm_hud.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using script_63da2325262612ba;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\zm_office_floors.gsc;
#using scripts\zm_common\zm_wallbuy.gsc;
#using script_7b75a29159ce123e;
#using script_7be39c34f66312aa;
#using script_ab862743b3070a;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_office_fx.gsc;
#using scripts\zm\zm_office_gamemodes.gsc;
#using scripts\zm\zm_office_sound.gsc;
#using scripts\zm\zm_office_traps.gsc;
#using scripts\zm\zm_office_ww_quest.gsc;
#using scripts\zm\zm_office_zones.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_office;

/*
	Name: opt_in
	Namespace: zm_office
	Checksum: 0x7F0BA067
	Offset: 0xB38
	Size: 0x62
	Parameters: 0
	Flags: AutoExec
*/
function autoexec opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	level.bgb_machine_count = 2;
	level.random_pandora_box_start = 1;
	level.pack_a_punch_camo_index = 161;
	level.pack_a_punch_camo_index_number_variants = 5;
}

/*
	Name: main
	Namespace: zm_office
	Checksum: 0x2C41FDD
	Offset: 0xBA8
	Size: 0x90E
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setclearanceceiling(17);
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	zm::init_fx();
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
	clientfield::register("world", "flicker_function_controller", 1, 1, "int");
	clientfield::register("world", "flicker_function_controller_persistant", 1, 1, "int");
	level._effect[#"headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = "blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = "electric/fx8_sparks_burst_dir_sm_orange_os";
	level.var_c1013f84 = 1;
	level._no_vending_machine_auto_collision = 1;
	level.default_start_location = "start_room";
	level.default_game_mode = "zclassic";
	level.disableclassselection = 0;
	level.var_22fda912 = &function_9f50079d;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	level.var_d0ab70a2 = #"hash_2ed6ad41883dc026";
	level._allow_melee_weapon_switching = 1;
	level.zombiemode_reusing_pack_a_punch = 1;
	level.var_161cb00c = 1;
	level.var_ef785c4c = 0;
	level.pack_a_punch.custom_power_think = &zm_office_teleporters::function_9b917fd5;
	zm_pap_util::set_interaction_height(28);
	zm_pap_util::function_11fdb083(16);
	if(zm_utility::is_standard())
	{
		var_6811b7e = struct::get_array("perk_vapor_altar");
		foreach(var_5baafbb2 in var_6811b7e)
		{
			var_5baafbb2.var_21c535b = -1;
		}
	}
	load::main();
	level.zones = [];
	level.zone_manager_init_func = &zm_office_zones::zone_init;
	init_zones[0] = "conference_level1";
	level thread zm_zonemgr::manage_zones(init_zones);
	level.random_pandora_box_start = 1;
	level.start_chest_name = "level3_chest1";
	level.open_chest_location = [];
	level.open_chest_location[0] = "level1_chest1";
	level.open_chest_location[1] = "level1_chest2";
	level.open_chest_location[2] = "level1_chest3";
	level.open_chest_location[3] = "level2_chest1";
	level.open_chest_location[4] = "level2_chest2";
	level.open_chest_location[5] = "level2_chest3";
	level.open_chest_location[6] = "level3_chest1";
	level.open_chest_location[7] = "level3_chest2";
	level.open_chest_location[8] = "level3_chest3";
	if(zm_utility::is_trials())
	{
		level._zombiemode_custom_box_move_logic = &function_31085f45;
	}
	level thread sndfunctions();
	level thread metal_detectors();
	level thread zm_office_zones::init();
	level thread zm_office_floors::init();
	level thread zm_office_fx::init();
	level thread zm_office_elevators::init();
	level thread wait_for_power();
	level thread zm_office_traps::init();
	level thread namespace_ef310bfe::init();
	level thread zm_office_special_rounds::init();
	level thread namespace_a5657ff1::init();
	level thread namespace_6a81d072::init();
	level thread zm_office_defcon::pentagon_packapunch_init();
	level thread zm_office_ww_quest::init();
	level thread namespace_6f62781f::init();
	level thread namespace_8f53e87b::init();
	level thread zm_office_sound::main();
	if(!zm_trial::function_b47f6aba())
	{
		level thread namespace_55f8626e::init();
	}
	if(zm_utility::is_classic())
	{
		level thread play_starting_vox();
	}
	level thread function_7437db04();
	/#
		level thread office_devgui();
	#/
	level thread registergondola_moving_watcher();
	level thread function_8aea12();
	level thread function_785cadc4();
	zm_sq::register(#"main_quest", #"step1", #"main_quest_step1", &function_7b48256b, &function_e3a10039, 1);
	zm_sq::start(#"main_quest");
	zm_custom::function_a00576dd(undefined, undefined, &function_c8ce0a17, &function_e5086229);
	if(zm_custom::function_901b751c(#"zmenhancedstate") == 2)
	{
		level flag::set(#"hash_2a1fc2e349c48462");
	}
	level.registerquest_key_pickup_explode = &registerquest_key_pickup_explode;
	level.var_eeb98313 = &function_eeb98313;
	level.valid_poi_max_radius = 200;
}

/*
	Name: function_7b48256b
	Namespace: zm_office
	Checksum: 0x972D3D7A
	Offset: 0x14C0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_7b48256b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		scene::add_scene_func("cin_zm_office_outro", &function_a8b0b884, "play");
		scene::add_scene_func("cin_zm_office_outro", &function_335eca01, "done");
		scene::add_scene_func("cin_zm_office_outro", &function_335eca01, "stop");
		callback::function_74872db6(&outro_watcher);
		level waittill(#"main_quest_complete");
	}
}

/*
	Name: function_e3a10039
	Namespace: zm_office
	Checksum: 0x943DFC32
	Offset: 0x15A8
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_e3a10039(var_5ea5c94d, ended_early)
{
	level thread scene::play("cin_zm_office_outro");
	callback::function_50fdac80(&outro_watcher);
}

/*
	Name: function_7437db04
	Namespace: zm_office
	Checksum: 0x5BE8DCCC
	Offset: 0x1608
	Size: 0x228
	Parameters: 0
	Flags: Linked
*/
function function_7437db04()
{
	if(getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		var_43148fe7 = array("p8_fxanim_gp_wire_sparking_xlong_thick_bundle", "p8_fxanim_gp_wire_sparking_ground_01_bundle", "p8_fxanim_gp_wire_sparking_xsml_bundle");
		var_fa5ebd9 = array("p8_zm_off_caution_tape_f", "p8_zm_off_caution_tape_a", "p8_zm_off_caution_tape_b");
		a_script_models = getentarray("script_model", "classname");
		foreach(str_model in var_fa5ebd9)
		{
			foreach(e_model in a_script_models)
			{
				if(e_model.model === str_model)
				{
					e_model delete();
				}
			}
		}
		wait(0.5);
		foreach(str_scene in var_43148fe7)
		{
			scene::stop(str_scene, 1);
		}
	}
}

/*
	Name: function_c8ce0a17
	Namespace: zm_office
	Checksum: 0x6A0FE822
	Offset: 0x1838
	Size: 0x68
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = zm_office_special_rounds::function_dd836251();
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

/*
	Name: function_e5086229
	Namespace: zm_office
	Checksum: 0xEB06C273
	Offset: 0x18A8
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_e5086229(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = zombie_dog_util::function_62db7b1c(1);
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

/*
	Name: registergondola_moving_watcher
	Namespace: zm_office
	Checksum: 0x5BC739AB
	Offset: 0x1920
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function registergondola_moving_watcher()
{
	level clientfield::set("flicker_function_controller", 1);
	level clientfield::set("flicker_function_controller_persistant", 1);
	level._effect[#"zombie_light_board"] = #"hash_e1d8f427f2f23c6";
	level.var_6579276 = level._effect[#"zombie_light_board"];
	var_4ef1324a = getentarray("yellow_conf_screen_part", "script_noteworthy");
	var_4d8e3426 = getent("fx_light_origin", "script_noteworthy");
	var_4d8e3426.fx_ent = util::spawn_model("tag_origin", var_4d8e3426.origin);
	var_4d8e3426.fx_ent.angles = var_4d8e3426.angles;
	var_4d8e3426.var_72873bf = playfxontag(level.var_6579276, var_4d8e3426.fx_ent, "tag_origin");
	var_4d8e3426.var_72873bf linkto(var_4ef1324a[0]);
	level waittill(#"hash_2124984d1ece329c");
	exploder::exploder("fxexp_script_power_on");
	level waittill(#"hash_21249b4d1ece37b5");
	exploder::exploder("fxexp_script_power_off");
	wait(2.5);
	var_4d8e3426.var_72873bf hide();
}

/*
	Name: function_8aea12
	Namespace: zm_office
	Checksum: 0xD58268E3
	Offset: 0x1B40
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_8aea12()
{
	var_c6025348 = getentarray("lab_light_spinning_off", "script_noteworthy");
	var_a8947e7c = getentarray("lab_light_spinning_on", "script_noteworthy");
	wait(1);
	foreach(light in var_a8947e7c)
	{
		light hide();
	}
	level waittill(#"hash_2124984d1ece329c");
	foreach(light in var_a8947e7c)
	{
		light show();
	}
	foreach(light in var_c6025348)
	{
		light hide();
	}
	exploder::stop_exploder("fxexp_script_lgt_lab_spinning");
	exploder::exploder("fxexp_script_lgt_lab_spinning");
}

/*
	Name: function_31085f45
	Namespace: zm_office
	Checksum: 0xF7BA0B6
	Offset: 0x1D38
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_31085f45()
{
	if(level.chest_moves > 1)
	{
		zm_magicbox::default_box_move_logic();
	}
	else
	{
		level.chests = array::randomize(level.chests);
		for(i = 0; i < level.chests.size; i++)
		{
			if(level.chests[i].script_noteworthy == "level1_chest1" || level.chests[i].script_noteworthy == "level1_chest2" || level.chests[i].script_noteworthy == "level1_chest3" || level.chests[i].script_noteworthy == "level2_chest3")
			{
				level.chest_index = i;
				break;
			}
		}
	}
}

/*
	Name: function_785cadc4
	Namespace: zm_office
	Checksum: 0x1969544F
	Offset: 0x1E68
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function function_785cadc4()
{
	level.var_678333a6 = #"hash_11347f5077a17dcb";
	level._effect[#"chest_light"] = #"hash_1e8cb303d3103833";
	level._effect[#"chest_light_closed"] = #"hash_602f075818a2fb2e";
	level._effect[#"hash_2ff87d61167ea531"] = #"hash_1eb426cfbfef7486";
	level._effect[#"hash_4048cb4967032c4a"] = #"hash_7e272f1a9f143051";
	level._effect[#"lght_marker"] = #"hash_7dec2fde8393c0f4";
	level._effect[#"lght_marker_flare"] = #"hash_11347f5077a17dcb";
	level._effect[#"poltergeist_magicbox"] = #"hash_11347f5077a17dcb";
}

/*
	Name: function_9f50079d
	Namespace: zm_office
	Checksum: 0x2DB5BEA7
	Offset: 0x1FE0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_9f50079d()
{
	zm_loadout::register_tactical_grenade_for_level(#"hash_603fdd2e4ae5b2b0", 1);
}

/*
	Name: offhand_weapon_give_override
	Namespace: zm_office
	Checksum: 0xB7D7C9AB
	Offset: 0x2018
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
	Name: wait_for_power
	Namespace: zm_office
	Checksum: 0x3B58D770
	Offset: 0x20E8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function wait_for_power()
{
	level thread function_cbc7dc41();
	level thread function_65642571();
	level thread zm_office_teleporters::teleporter_init();
	level flag::wait_till("power_on");
	level thread zm_office_teleporters::function_ea199c46();
	util::wait_network_frame();
	level notify(#"hash_2124984d1ece329c");
	util::wait_network_frame();
	level notify(#"hash_21249b4d1ece37b5");
	level util::clientnotify("poa");
}

/*
	Name: sndfunctions
	Namespace: zm_office
	Checksum: 0x33C38BF8
	Offset: 0x21E0
	Size: 0xAC
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
		level.zmannouncerprefix = "zmba";
	}
	zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
	level thread setupmusic();
	level thread custom_add_vox();
	level thread setup_personality_character_exerts();
}

/*
	Name: custom_add_vox
	Namespace: zm_office
	Checksum: 0xFE2AE718
	Offset: 0x2298
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function custom_add_vox()
{
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_6d9aadb58948623b");
	zm_audio::loadplayervoicecategories(#"hash_75b01784227cb52f");
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_office
	Checksum: 0xA8375208
	Offset: 0x2308
	Size: 0x3C8
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[5][#"hitmed"] = "vox_plr_5_exert_pain";
	level.exert_sounds[6][#"hitmed"] = "vox_plr_6_exert_pain";
	level.exert_sounds[7][#"hitmed"] = "vox_plr_7_exert_pain";
	level.exert_sounds[8][#"hitmed"] = "vox_plr_8_exert_pain";
	level.exert_sounds[5][#"hitlrg"] = "vox_plr_5_exert_pain";
	level.exert_sounds[6][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[7][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[8][#"hitlrg"] = "vox_plr_7_exert_pain";
	level.exert_sounds[5][#"drowning"] = "vox_plr_5_exert_underwater_air_low";
	level.exert_sounds[6][#"drowning"] = "vox_plr_6_exert_underwater_air_low";
	level.exert_sounds[7][#"drowning"] = "vox_plr_7_exert_underwater_air_low";
	level.exert_sounds[8][#"drowning"] = "vox_plr_8_exert_underwater_air_low";
	level.exert_sounds[5][#"cough"] = "vox_plr_5_exert_gas_cough";
	level.exert_sounds[6][#"cough"] = "vox_plr_6_exert_gas_cough";
	level.exert_sounds[7][#"cough"] = "vox_plr_7_exert_gas_cough";
	level.exert_sounds[8][#"cough"] = "vox_plr_8_exert_gas_cough";
	level.exert_sounds[5][#"underwater_emerge"] = "vox_plr_5_exert_underwater_emerge_breath";
	level.exert_sounds[6][#"underwater_emerge"] = "vox_plr_6_exert_underwater_emerge_breath";
	level.exert_sounds[7][#"underwater_emerge"] = "vox_plr_7_exert_underwater_emerge_breath";
	level.exert_sounds[8][#"underwater_emerge"] = "vox_plr_8_exert_underwater_emerge_breath";
	level.exert_sounds[5][#"underwater_gasp"] = "vox_plr_5_exert_underwater_emerge_gasp";
	level.exert_sounds[6][#"underwater_gasp"] = "vox_plr_6_exert_underwater_emerge_gasp";
	level.exert_sounds[7][#"underwater_gasp"] = "vox_plr_7_exert_underwater_emerge_gasp";
	level.exert_sounds[8][#"underwater_gasp"] = "vox_plr_8_exert_underwater_emerge_gasp";
}

/*
	Name: metal_detectors
	Namespace: zm_office
	Checksum: 0x36AEC82E
	Offset: 0x26D8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function metal_detectors()
{
	trigger1 = getent("metal_detector", "targetname");
	trigger2 = getent("metal_detector_2", "targetname");
	level thread function_4a3d7c9e(trigger1);
	level thread function_4a3d7c9e(trigger2);
}

/*
	Name: function_4a3d7c9e
	Namespace: zm_office
	Checksum: 0x30B56929
	Offset: 0x2768
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_4a3d7c9e(trigger)
{
	while(true)
	{
		s_result = trigger trigger::wait_till();
		if(!isdefined(s_result.who))
		{
			continue;
		}
		if(!isplayer(s_result.who))
		{
			continue;
		}
		e_player = s_result.who;
		if(!(isdefined(e_player.var_4eee81de) && e_player.var_4eee81de))
		{
			e_player.var_4eee81de = 1;
			trigger playsound(#"evt_metal_detector");
			e_player thread function_f9229e0c(trigger);
			wait(2);
		}
	}
}

/*
	Name: function_f9229e0c
	Namespace: zm_office
	Checksum: 0x20EEA592
	Offset: 0x2868
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_f9229e0c(e_trigger)
{
	self endon(#"death");
	while(self istouching(e_trigger))
	{
		wait(0.1);
	}
	self.var_4eee81de = 0;
}

/*
	Name: setupmusic
	Namespace: zm_office
	Checksum: 0x862D871B
	Offset: 0x28C0
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "office_roundstart_1", "office_roundstart_2", "office_roundstart_3");
	zm_audio::musicstate_create("round_start_first", 3, "office_roundstart_1");
	zm_audio::musicstate_create("round_end", 3, "office_roundend_1", "office_roundend_2", "office_roundend_3");
	zm_audio::musicstate_create("game_over", 5, "office_death");
	zm_audio::musicstate_create("round_start_special", 3, "round_start_special");
	zm_audio::musicstate_create("round_end_special", 3, "round_end_special");
	zm_audio::musicstate_create("ee_song", 4, "office_ee_song");
	zm_audio::musicstate_create("ee_song_2", 4, "office_ee_song_2");
}

/*
	Name: play_starting_vox
	Namespace: zm_office
	Checksum: 0x89C0858D
	Offset: 0x2A30
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function play_starting_vox()
{
	level flag::wait_till("start_zombie_round_logic");
	wait(6);
	level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_4728c591d3ef4bea");
}

/*
	Name: function_cbc7dc41
	Namespace: zm_office
	Checksum: 0x6E84A789
	Offset: 0x2A88
	Size: 0x494
	Parameters: 0
	Flags: Linked
*/
function function_cbc7dc41()
{
	poweroffscreens = getentarray("power_off_tv_screens", "targetname");
	var_458dae44 = getentarray("power_on_tv_screens", "targetname");
	var_828004fa = getentarray("power_on_screens_glitch", "targetname");
	foreach(screen in var_458dae44)
	{
		screen hide();
	}
	foreach(screen in var_828004fa)
	{
		screen hide();
	}
	level waittill(#"hash_21249b4d1ece37b5");
	foreach(screen in poweroffscreens)
	{
		screen hide();
	}
	foreach(screen in var_458dae44)
	{
		screen show();
	}
	while(true)
	{
		foreach(screen in var_458dae44)
		{
			screen show();
		}
		wait(1 + randomfloat(5));
		foreach(screen in var_458dae44)
		{
			screen hide();
		}
		foreach(screen in var_828004fa)
		{
			screen show();
		}
		wait(randomfloat(1));
		foreach(screen in var_828004fa)
		{
			screen hide();
		}
		foreach(screen in var_458dae44)
		{
			screen show();
		}
	}
}

/*
	Name: function_65642571
	Namespace: zm_office
	Checksum: 0x5542B3A3
	Offset: 0x2F28
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_65642571()
{
	var_5314ba3e = getentarray("monitor_feed_v2", "targetname");
	foreach(monitor in var_5314ba3e)
	{
		monitor hide();
	}
	level waittill(#"hash_21249b4d1ece37b5");
	foreach(monitor in var_5314ba3e)
	{
		monitor show();
	}
}

/*
	Name: outro_watcher
	Namespace: zm_office
	Checksum: 0xD0856D7A
	Offset: 0x3050
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function outro_watcher()
{
	if(level.round_number == 150)
	{
		level notify(#"main_quest_complete");
	}
}

/*
	Name: function_a8b0b884
	Namespace: zm_office
	Checksum: 0xB93D85C2
	Offset: 0x3088
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_a8b0b884()
{
	a_ai_zombies = getaiarray();
	foreach(ai in a_ai_zombies)
	{
		if(isalive(ai))
		{
			util::stop_magic_bullet_shield(ai);
			ai.allowdeath = 1;
			ai kill();
		}
	}
	foreach(e_player in level.activeplayers)
	{
		e_player val::set(#"outro_scene", "freezecontrols", 1);
	}
	zm_vo::function_3c173d37();
	level flag::clear("spawn_zombies");
}

/*
	Name: function_335eca01
	Namespace: zm_office
	Checksum: 0xEEA39364
	Offset: 0x3220
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_335eca01()
{
	a_s_start_pos = struct::get_array("initial_spawn_points");
	for(i = 0; i < level.activeplayers.size; i++)
	{
		level.activeplayers[i] setorigin(a_s_start_pos[i].origin);
		level.activeplayers[i] setplayerangles(a_s_start_pos[i].angles);
		level.activeplayers[i] val::set(#"outro_scene", "freezecontrols", 0);
	}
	wait(5);
	level flag::set("spawn_zombies");
}

/*
	Name: registerquest_key_pickup_explode
	Namespace: zm_office
	Checksum: 0xF1F22A1E
	Offset: 0x3340
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function registerquest_key_pickup_explode(e_player)
{
	if(e_player != self && e_player laststand::player_is_in_laststand() && (!(isdefined(e_player.var_16735873) && e_player.var_16735873)) && !zm_office_floors::function_ee59e344(e_player))
	{
		return true;
	}
	return false;
}

/*
	Name: function_eeb98313
	Namespace: zm_office
	Checksum: 0x92E19148
	Offset: 0x33C8
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function function_eeb98313(a_s_respawn_points)
{
	var_5f7e6059 = [];
	var_c0a091bc = zm_office_floors::function_2fe0c64e(self.var_ca944973);
	if(isdefined(var_c0a091bc))
	{
		foreach(s_point in a_s_respawn_points)
		{
			var_3193076f = zm_office_floors::function_2fe0c64e(s_point.origin);
			if(var_3193076f === var_c0a091bc)
			{
				if(!isdefined(var_5f7e6059))
				{
					var_5f7e6059 = [];
				}
				else if(!isarray(var_5f7e6059))
				{
					var_5f7e6059 = array(var_5f7e6059);
				}
				var_5f7e6059[var_5f7e6059.size] = s_point;
			}
		}
		return var_5f7e6059;
	}
	return a_s_respawn_points;
}

/*
	Name: office_devgui
	Namespace: zm_office
	Checksum: 0x4EB09DDD
	Offset: 0x3508
	Size: 0x1A0
	Parameters: 0
	Flags: Private
*/
function private office_devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"hash_1c410d7e116d84b7", "");
			switch(str_command)
			{
				case "go_defcon5":
				{
					level thread zm_office_defcon::function_d2f6cecb();
					break;
				}
				case "hash_721e1a59dcdbed92":
				{
					namespace_a5657ff1::function_5642f347();
					break;
				}
				case "hash_3b41cd4492082280":
				{
					namespace_a5657ff1::function_f33d3ab5();
					break;
				}
				case "enable_ww_crate":
				{
					level.s_ww_quest_reward zm_office_ww_quest::function_68f68bb4();
					break;
				}
			}
			setdvar(#"hash_1c410d7e116d84b7", "");
		}
	#/
}

