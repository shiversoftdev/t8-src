// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_11c0a75851de7fce;
#using script_14d4cc4687ff9afd;
#using script_14f4a3c583c77d4b;
#using script_193e6daef46bb88b;
#using script_27e13de8e5cf7b4;
#using script_2c5e325003fa52e2;
#using script_2fcb47e3735a6edd;
#using script_3110b4b6b21db11f;
#using script_3584f1be23529c01;
#using script_37752a01e45812b8;
#using script_3a575c42e5260e65;
#using script_3ed4043a74fa517b;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_42ac6fc8b2ff0f3e;
#using script_4333a03353e1e13a;
#using script_48586eea5c3542a4;
#using script_493d9b5ad424cee7;
#using script_4abf5d8ad3cb6c5b;
#using script_52965c854845b73;
#using script_52c6c2d1a2ef1b46;
#using script_54fe572984843999;
#using script_5a979d9fa7d64923;
#using script_5b2f999b8dbf5f77;
#using script_5b4f7a8178990872;
#using script_5bb072c3abf4652c;
#using script_5cd88351d6d269b1;
#using script_6021ce59143452c3;
#using script_652cf01d4f20aeb5;
#using script_67c9a990c0db216c;
#using script_6a3f43063dfd1bdc;
#using script_6b6fff322a8a64eb;
#using script_6e3c826b1814cab6;
#using script_6f35f7919b97e062;
#using script_7224d61ed502ea07;
#using script_72eca4c9e2aea110;
#using script_74b832926209b8e1;
#using script_ab862743b3070a;
#using script_b52a163973f339f;
#using script_d19b1fbf1d7cdd6;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_challenges.gsc;
#using scripts\zm\zm_orange_devgui.gsc;
#using scripts\zm\zm_orange_fx.gsc;
#using scripts\zm\zm_orange_gamemodes.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm\zm_orange_ww_quest.gsc;
#using scripts\zm\zm_orange_zones.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_orange;

/*
	Name: opt_in
	Namespace: zm_orange
	Checksum: 0xA12DFB57
	Offset: 0xBB0
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
	level.pack_a_punch_camo_index = 394;
	level.pack_a_punch_camo_index_number_variants = 1;
}

/*
	Name: main
	Namespace: zm_orange
	Checksum: 0x8AF793B5
	Offset: 0xC20
	Size: 0xB2C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level thread lui::function_b95a3ba5("full_screen_movie", &full_screen_movie::register, "full_screen_movie");
	zm::init_fx();
	level.custom_spawner_entry[#"crawl"] = &namespace_509a75d1::function_45bb11e4;
	level.var_c02e63 = &namespace_3263198e::function_583cad13;
	clientfield::register("actor", "sndActorUnderwater", 28000, 1, "int");
	level._effect[#"headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = "blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = "electric/fx8_sparks_burst_dir_sm_orange_os";
	level thread namespace_a59839fe::init();
	level.var_c1013f84 = 1;
	level._no_vending_machine_auto_collision = 1;
	level.default_start_location = "start_room";
	level.default_game_mode = "zclassic";
	level.disableclassselection = 0;
	callback::on_ai_spawned(&function_8c000d3b);
	level.var_22fda912 = &function_9f50079d;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	level.var_d0ab70a2 = #"hash_544f128e274c84e0";
	level._allow_melee_weapon_switching = 1;
	level.zombiemode_reusing_pack_a_punch = 1;
	level.var_161cb00c = 1;
	level.var_61afcb81 = 64;
	if(zm_utility::is_standard())
	{
		var_6811b7e = struct::get_array("perk_vapor_altar");
		foreach(var_5baafbb2 in var_6811b7e)
		{
			var_5baafbb2.var_21c535b = -1;
		}
	}
	level namespace_86eed980::init();
	level namespace_f9df92f::preload();
	level namespace_be178848::init();
	level namespace_67594c4a::init();
	level namespace_5449c7ba::init();
	level namespace_379af75a::preload();
	level namespace_99a6629b::init();
	level namespace_6036de69::init();
	level namespace_790eb878::init();
	level namespace_f93d2fa1::init();
	level namespace_ec1f72a0::preload();
	level namespace_55999fe::preload();
	level namespace_f7a40df8::preload();
	level namespace_44916ada::init();
	level namespace_18db89ed::init();
	level zm_orange_ww_quest::init();
	level namespace_5095a550::preload();
	level namespace_e9563b61::init();
	level namespace_78baa66c::preload();
	load::main();
	setdvar(#"zombie_unlock_all", 0);
	level.zones = [];
	level.zone_manager_init_func = &namespace_17555f14::zone_init;
	init_zones[0] = "docks_1";
	level thread zm_zonemgr::manage_zones(init_zones);
	level.random_pandora_box_start = 1;
	level.start_chest_name = "lighthouse_level_1_chest";
	level.open_chest_location = [];
	level.open_chest_location[0] = "lighthouse_level_1_chest";
	level.open_chest_location[1] = "lighthouse_station_chest";
	level.open_chest_location[2] = "frozen_crevasse_chest";
	level.open_chest_location[3] = "beach_chest";
	level.open_chest_location[4] = "forecastle_chest";
	level.open_chest_location[5] = "navigation_chest";
	level.open_chest_location[6] = "cargo_hold_chest";
	level.open_chest_location[7] = "human_infusion_chest";
	level._zombiemode_custom_box_move_logic = &function_c3d2b3ee;
	level flag::init(#"hash_142bf0da77232815");
	level thread sndfunctions();
	level thread namespace_85e029d3::init();
	level thread namespace_86eed980::main();
	level thread namespace_f9df92f::main();
	level thread namespace_be178848::main();
	level thread namespace_67594c4a::main();
	level thread namespace_5449c7ba::main();
	level thread namespace_565e073b::main();
	level thread namespace_6036de69::main();
	level thread namespace_99a6629b::main();
	level thread namespace_790eb878::main();
	level thread namespace_ec1f72a0::main();
	level thread namespace_55999fe::main();
	level thread namespace_f7a40df8::main();
	level thread namespace_44916ada::main();
	level thread namespace_16c9989b::main();
	level thread namespace_18db89ed::main();
	level thread zm_orange_ww_quest::main();
	level thread namespace_17555f14::main();
	level thread namespace_3263198e::init();
	level thread namespace_379af75a::main();
	level thread namespace_bda88164::init();
	level thread namespace_5095a550::init();
	level thread namespace_e9563b61::main();
	level thread function_681c28c9();
	level thread function_486119ea();
	level thread function_30829a12();
	callback::function_74872db6(&play_avalanche);
	if(!zm_utility::function_e51dc2d8())
	{
		var_47cef04a = getent("ee_ind", "targetname");
		if(isdefined(var_47cef04a))
		{
			var_47cef04a delete();
		}
	}
	if(zm_utility::is_trials())
	{
		level thread namespace_78baa66c::main();
	}
	level flag::init("fasttravel_disabled");
	level thread function_4dacc177();
	/#
		level thread namespace_c3bb1e21::init();
	#/
	e_spawner = getent("zombie_spawner", "script_noteworthy");
	e_spawner spawner::add_spawn_function(&function_6be9c49c);
	level flag::init(#"hash_7a06360d0821c8e1");
	level thread function_227dcc04();
}

/*
	Name: function_9f50079d
	Namespace: zm_orange
	Checksum: 0xE059AEBB
	Offset: 0x1758
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
	Namespace: zm_orange
	Checksum: 0x634726AA
	Offset: 0x1790
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
	Name: include_weapons
	Namespace: zm_orange
	Checksum: 0x80F724D1
	Offset: 0x1860
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function include_weapons()
{
}

/*
	Name: precachecustomcharacters
	Namespace: zm_orange
	Checksum: 0x80F724D1
	Offset: 0x1870
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function precachecustomcharacters()
{
}

/*
	Name: assign_lowest_unused_character_index
	Namespace: zm_orange
	Checksum: 0xB3FAA01E
	Offset: 0x1880
	Size: 0x270
	Parameters: 0
	Flags: Linked
*/
function assign_lowest_unused_character_index()
{
	charindexarray = [];
	charindexarray[0] = 0;
	charindexarray[1] = 1;
	charindexarray[2] = 2;
	charindexarray[3] = 3;
	players = getplayers();
	if(players.size == 1)
	{
		charindexarray = array::randomize(charindexarray);
		return charindexarray[0];
	}
	if(players.size == 2)
	{
		foreach(player in players)
		{
			if(isdefined(player.characterindex))
			{
				if(player.characterindex == 2 || player.characterindex == 0)
				{
					if(randomint(100) > 50)
					{
						return 1;
					}
					return 3;
				}
				if(player.characterindex == 3 || player.characterindex == 1)
				{
					if(randomint(100) > 50)
					{
						return 0;
					}
					return 2;
				}
			}
		}
	}
	else
	{
		foreach(player in players)
		{
			if(isdefined(player.characterindex))
			{
				arrayremovevalue(charindexarray, player.characterindex, 0);
			}
		}
		if(charindexarray.size > 0)
		{
			return charindexarray[0];
		}
	}
	return 0;
}

/*
	Name: givecustomcharacters
	Namespace: zm_orange
	Checksum: 0xCAF9C4C9
	Offset: 0x1AF8
	Size: 0x214
	Parameters: 0
	Flags: None
*/
function givecustomcharacters()
{
	if(isdefined(level.hotjoin_player_setup) && [[level.hotjoin_player_setup]]("c_zom_farmgirl_viewhands"))
	{
		return;
	}
	self detachall();
	if(!isdefined(self.characterindex))
	{
		self.characterindex = assign_lowest_unused_character_index();
	}
	self.favorite_wall_weapons_list = [];
	self.talks_in_danger = 0;
	self setcharacterbodytype(self.characterindex);
	switch(self.characterindex)
	{
		case 0:
		{
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
			break;
		}
		case 1:
		{
			self.talks_in_danger = 1;
			level.rich_sq_player = self;
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
			break;
		}
		case 2:
		{
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
			break;
		}
		case 3:
		{
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
			break;
		}
	}
	self thread set_exert_id();
}

/*
	Name: set_exert_id
	Namespace: zm_orange
	Checksum: 0x291EFFA3
	Offset: 0x1D18
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function set_exert_id()
{
	self endon(#"disconnect");
	util::wait_network_frame();
	util::wait_network_frame();
	self zm_audio::setexertvoice(self.characterindex + 1);
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_orange
	Checksum: 0xB8323646
	Offset: 0x1D80
	Size: 0x508
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[17][#"hitmed"] = "vox_stuh_exert_pain";
	level.exert_sounds[18][#"hitmed"] = "vox_mist_exert_pain";
	level.exert_sounds[19][#"hitmed"] = "vox_marl_exert_pain";
	level.exert_sounds[20][#"hitmed"] = "vox_russ_exert_pain";
	level.exert_sounds[17][#"hitlrg"] = "vox_stuh_exert_pain";
	level.exert_sounds[18][#"hitlrg"] = "vox_mist_exert_pain";
	level.exert_sounds[19][#"hitlrg"] = "vox_marl_exert_pain";
	level.exert_sounds[20][#"hitlrg"] = "vox_russ_exert_pain";
	level.exert_sounds[17][#"cough"] = "vox_stuh_exert_gas_cough";
	level.exert_sounds[18][#"cough"] = "vox_mist_exert_gas_cough";
	level.exert_sounds[19][#"cough"] = "vox_marl_exert_gas_cough";
	level.exert_sounds[20][#"cough"] = "vox_russ_exert_gas_cough";
	level.exert_sounds[17][#"drowning"] = "vox_stuh_exert_underwater_air_low";
	level.exert_sounds[18][#"drowning"] = "vox_mist_exert_underwater_air_low";
	level.exert_sounds[19][#"drowning"] = "vox_marl_exert_underwater_air_low";
	level.exert_sounds[20][#"drowning"] = "vox_russ_exert_underwater_air_low";
	level.exert_sounds[17][#"underwater_emerge"] = "vox_stuh_exert_underwater_emerge_breath";
	level.exert_sounds[18][#"underwater_emerge"] = "vox_mist_exert_underwater_emerge_breath";
	level.exert_sounds[19][#"underwater_emerge"] = "vox_marl_exert_underwater_emerge_breath";
	level.exert_sounds[20][#"underwater_emerge"] = "vox_russ_exert_underwater_emerge_breath";
	level.exert_sounds[17][#"underwater_gasp"] = "vox_stuh_exert_underwater_emerge_gasp";
	level.exert_sounds[18][#"underwater_gasp"] = "vox_mist_exert_underwater_emerge_gasp";
	level.exert_sounds[19][#"underwater_gasp"] = "vox_marl_exert_underwater_emerge_gasp";
	level.exert_sounds[20][#"underwater_gasp"] = "vox_russ_exert_underwater_emerge_gasp";
	level.exert_sounds[17][#"hash_65836673931273db"] = array("vox_freeze_exert_plr_17_0", "vox_freeze_exert_plr_17_1", "vox_freeze_exert_plr_17_2");
	level.exert_sounds[18][#"hash_65836673931273db"] = array("vox_freeze_exert_plr_18_0", "vox_freeze_exert_plr_18_1", "vox_freeze_exert_plr_18_2");
	level.exert_sounds[19][#"hash_65836673931273db"] = array("vox_freeze_exert_plr_19_0", "vox_freeze_exert_plr_19_1", "vox_freeze_exert_plr_19_2");
	level.exert_sounds[20][#"hash_65836673931273db"] = array("vox_freeze_exert_plr_20_0", "vox_freeze_exert_plr_20_1", "vox_freeze_exert_plr_20_2");
}

/*
	Name: function_8c000d3b
	Namespace: zm_orange
	Checksum: 0x6AC85023
	Offset: 0x2290
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_8c000d3b()
{
	if(self ai::has_behavior_attribute("gravity"))
	{
		while(isalive(self))
		{
			depth = getwaterheight(self.origin) - self.origin[2];
			if(depth > 48)
			{
				self ai::set_behavior_attribute("gravity", "low");
				if(!self clientfield::get("sndActorUnderwater"))
				{
					self clientfield::set("sndActorUnderwater", 1);
				}
			}
			else if(self ai::get_behavior_attribute("gravity") != "normal")
			{
				self ai::set_behavior_attribute("gravity", "normal");
				if(self clientfield::get("sndActorUnderwater"))
				{
					self clientfield::set("sndActorUnderwater", 0);
				}
			}
			wait(0.5);
		}
	}
}

/*
	Name: sndfunctions
	Namespace: zm_orange
	Checksum: 0xC596E1DC
	Offset: 0x2410
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function sndfunctions()
{
	level flag::init(#"hash_778a2b8282d704f");
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
	Namespace: zm_orange
	Checksum: 0x7B4C882A
	Offset: 0x24E8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function custom_add_vox()
{
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_6a57c10f8d76df9e");
	zm_audio::loadplayervoicecategories(#"hash_50f83dce1a50995");
	namespace_3263198e::function_af205e69(#"hash_41c3d60c9fdc1c1a");
	namespace_3263198e::function_af205e69(#"hash_6a57c10f8d76df9e");
	namespace_3263198e::function_af205e69(#"hash_50f83dce1a50995");
	level flag::set(#"hash_142bf0da77232815");
}

/*
	Name: setupmusic
	Namespace: zm_orange
	Checksum: 0x78E6FC23
	Offset: 0x25D8
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "orange_roundstart_1", "orange_roundstart_2", "orange_roundstart_3");
	zm_audio::musicstate_create("round_start_first", 3, "orange_roundstart_1");
	zm_audio::musicstate_create("round_end", 3, "orange_roundend_1", "orange_roundend_2", "orange_roundend_3");
	zm_audio::musicstate_create("game_over", 5, "orange_death");
	zm_audio::musicstate_create("round_start_special", 3, "round_start_special");
	zm_audio::musicstate_create("round_end_special", 3, "round_end_special");
	zm_audio::musicstate_create("ee_song_main", 4, "ee_song_main");
	zm_audio::musicstate_create("ee_song_2", 4, "ee_song_2");
}

/*
	Name: function_c3d2b3ee
	Namespace: zm_orange
	Checksum: 0xF079556E
	Offset: 0x2748
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_c3d2b3ee()
{
	if(!level flag::get(#"hash_24952374a6e863b8"))
	{
		var_15612e55 = level.chests[level.chest_index].script_noteworthy;
		level.chests = array::randomize(level.chests);
		for(i = 0; i < level.chests.size; i++)
		{
			if(level.chests[i].script_noteworthy != var_15612e55 && (level.chests[i].script_noteworthy == "lighthouse_level_1_chest" || level.chests[i].script_noteworthy == "cargo_hold_chest" || level.chests[i].script_noteworthy == "lighthouse_station_chest" || level.chests[i].script_noteworthy == "navigation_chest" || level.chests[i].script_noteworthy == "beach_chest" || level.chests[i].script_noteworthy == "frozen_crevasse_chest" || level.chests[i].script_noteworthy == "forecastle_chest"))
			{
				level.chest_index = i;
				break;
			}
		}
	}
	else
	{
		zm_magicbox::default_box_move_logic();
	}
}

/*
	Name: function_486119ea
	Namespace: zm_orange
	Checksum: 0x43B54B84
	Offset: 0x2938
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_486119ea()
{
	self endon(#"end_game");
	if(zm_utility::is_standard() || namespace_59ff1d6c::function_901b751c(#"hash_4e0ec3fe56f08b47") == 3)
	{
		level thread function_cf95fbb7();
		return;
	}
	while(true)
	{
		var_75666412 = function_789961d3();
		if(isdefined(var_75666412))
		{
			break;
		}
		wait(1);
	}
	level thread function_1f712bb1();
	level thread function_da0655c7();
	while(true)
	{
		var_469863c6 = function_789961d3();
		if(var_469863c6 != var_75666412)
		{
			level function_2336a7c8();
			level function_1f712bb1();
			waitframe(1);
			var_75666412 = var_469863c6;
		}
		wait(1);
	}
}

/*
	Name: function_789961d3
	Namespace: zm_orange
	Checksum: 0xFA273967
	Offset: 0x2A98
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_789961d3()
{
	if(isdefined(level.chest_index) && isdefined(level.chests) && isdefined(level.chests[level.chest_index]))
	{
		return level.chests[level.chest_index].script_noteworthy;
	}
	return undefined;
}

/*
	Name: function_1f712bb1
	Namespace: zm_orange
	Checksum: 0x4DE01F1A
	Offset: 0x2B08
	Size: 0x12A
	Parameters: 0
	Flags: Linked
*/
function function_1f712bb1()
{
	var_5b117f94 = level.chests[level.chest_index].script_noteworthy;
	var_e503dc79 = level.chest_index;
	wait(3);
	switch(var_5b117f94)
	{
		case "lighthouse_level_1_chest":
		{
			level.var_af3a53b2 = function_19a4e7cf(1500, var_e503dc79);
			return;
		}
		case "navigation_chest":
		{
			level.var_af3a53b2 = function_19a4e7cf(300, var_e503dc79);
			return;
		}
		case "human_infusion_chest":
		{
			level.var_af3a53b2 = function_19a4e7cf(1100, var_e503dc79);
			return;
		}
		default:
		{
			level.var_af3a53b2 = function_19a4e7cf(0, var_e503dc79);
			return;
		}
	}
}

/*
	Name: function_19a4e7cf
	Namespace: zm_orange
	Checksum: 0x395B027D
	Offset: 0x2C40
	Size: 0xC8
	Parameters: 2
	Flags: Linked
*/
function function_19a4e7cf(n_offset, var_e503dc79)
{
	var_ef61bf9 = util::spawn_model("tag_origin", level.chests[var_e503dc79].origin + (0, 0, n_offset - 75));
	var_ef61bf9.angles = level.chests[level.chest_index].angles + (vectorscale((-1, 0, -1), 90));
	playfxontag(level._effect[#"hash_572a14944ad27060"], var_ef61bf9, "tag_origin");
	return var_ef61bf9;
}

/*
	Name: function_2336a7c8
	Namespace: zm_orange
	Checksum: 0xF6BEBB34
	Offset: 0x2D10
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_2336a7c8()
{
	if(isdefined(level.var_af3a53b2))
	{
		level.var_af3a53b2 delete();
	}
}

/*
	Name: function_da0655c7
	Namespace: zm_orange
	Checksum: 0x5D4146C5
	Offset: 0x2D48
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_da0655c7()
{
	level waittill(#"fire_sale_on");
	level function_2336a7c8();
	wait(0.1);
	function_cf95fbb7();
	level waittill(#"fire_sale_off");
	if(isdefined(level.var_2a15c034))
	{
		foreach(effect in level.var_2a15c034)
		{
			effect delete();
		}
		level thread function_1f712bb1();
	}
	level thread function_da0655c7();
}

/*
	Name: function_cf95fbb7
	Namespace: zm_orange
	Checksum: 0x4B09D82F
	Offset: 0x2E70
	Size: 0x354
	Parameters: 0
	Flags: Linked
*/
function function_cf95fbb7()
{
	while(!isdefined(level.chests))
	{
		wait(0.1);
	}
	level.var_2a15c034 = [];
	for(i = 0; i < 8; i++)
	{
		var_5b117f94 = level.chests[i].script_noteworthy;
		switch(var_5b117f94)
		{
			case "lighthouse_level_1_chest":
			{
				e_effect = function_19a4e7cf(1500, i);
				if(!isdefined(level.var_2a15c034))
				{
					level.var_2a15c034 = [];
				}
				else if(!isarray(level.var_2a15c034))
				{
					level.var_2a15c034 = array(level.var_2a15c034);
				}
				level.var_2a15c034[level.var_2a15c034.size] = e_effect;
				break;
			}
			case "navigation_chest":
			{
				e_effect = function_19a4e7cf(300, i);
				if(!isdefined(level.var_2a15c034))
				{
					level.var_2a15c034 = [];
				}
				else if(!isarray(level.var_2a15c034))
				{
					level.var_2a15c034 = array(level.var_2a15c034);
				}
				level.var_2a15c034[level.var_2a15c034.size] = e_effect;
				break;
			}
			case "human_infusion_chest":
			{
				e_effect = function_19a4e7cf(1100, i);
				if(!isdefined(level.var_2a15c034))
				{
					level.var_2a15c034 = [];
				}
				else if(!isarray(level.var_2a15c034))
				{
					level.var_2a15c034 = array(level.var_2a15c034);
				}
				level.var_2a15c034[level.var_2a15c034.size] = e_effect;
				break;
			}
			default:
			{
				e_effect = function_19a4e7cf(0, i);
				if(!isdefined(level.var_2a15c034))
				{
					level.var_2a15c034 = [];
				}
				else if(!isarray(level.var_2a15c034))
				{
					level.var_2a15c034 = array(level.var_2a15c034);
				}
				level.var_2a15c034[level.var_2a15c034.size] = e_effect;
				break;
			}
		}
	}
}

/*
	Name: function_681c28c9
	Namespace: zm_orange
	Checksum: 0xB4BF60E9
	Offset: 0x31D0
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_681c28c9()
{
	level.var_678333a6 = #"hash_11347f5077a17dcb";
	level._effect[#"chest_light"] = #"hash_1e8cb303d3103833";
	level._effect[#"chest_light_closed"] = #"hash_602f075818a2fb2e";
	level._effect[#"hash_2ff87d61167ea531"] = #"hash_1eb426cfbfef7486";
	level._effect[#"hash_4048cb4967032c4a"] = #"hash_7e272f1a9f143051";
	level._effect[#"lght_marker"] = #"hash_7dec2fde8393c0f4";
	level._effect[#"lght_marker_flare"] = #"hash_11347f5077a17dcb";
	level._effect[#"hash_578e608ef34f517a"] = #"hash_11347f5077a17dcb";
	level._effect[#"hash_572a14944ad27060"] = #"zombie/fx_weapon_box_marker_zmb";
}

/*
	Name: function_30829a12
	Namespace: zm_orange
	Checksum: 0xDD0DD28B
	Offset: 0x3378
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_30829a12()
{
	level waittill(#"start_zombie_round_logic");
	exploder::exploder("fxexp_shipArtifact_powerOffFire");
	s_notify = undefined;
	s_notify = level waittill(#"power_on2", #"hash_6f7fd3d4d070db87");
	exploder::stop_exploder("fxexp_shipArtifact_powerOffFire");
	if(s_notify._notify === "power_on2")
	{
		exploder::exploder("fxexp_shipArtifact_powerOnFire");
	}
	else
	{
		exploder::exploder("fxexp_shipArtifact_powerOffDaylight");
	}
	s_notify = undefined;
	s_notify = level waittill(#"power_on2", #"hash_6f7fd3d4d070db87");
	exploder::stop_exploder("fxexp_shipArtifact_powerOnFire");
	exploder::stop_exploder("fxexp_shipArtifact_powerOffDaylight");
	exploder::exploder("fxexp_shipArtifact_powerOnLights");
}

/*
	Name: function_227dcc04
	Namespace: zm_orange
	Checksum: 0xB7DA0127
	Offset: 0x34D0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_227dcc04()
{
	while(!level flag::get(#"hash_7a06360d0821c8e1"))
	{
		if(namespace_17555f14::function_c3bf42e9())
		{
			level flag::set(#"hash_7a06360d0821c8e1");
			level thread function_b5695720();
		}
		wait(0.25);
	}
}

/*
	Name: function_b5695720
	Namespace: zm_orange
	Checksum: 0xE421F8E5
	Offset: 0x3558
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_b5695720()
{
	e_spawner = getent("scientist_spawner", "script_noteworthy");
	e_spawner.script_noteworthy = "zombie_spawner";
	e_spawner spawner::add_spawn_function(&zm_behavior::function_57d3b5eb);
	e_spawner spawner::add_spawn_function(&function_bdf62232);
	if(!isdefined(level.zombie_spawners))
	{
		level.zombie_spawners = [];
	}
	else if(!isarray(level.zombie_spawners))
	{
		level.zombie_spawners = array(level.zombie_spawners);
	}
	level.zombie_spawners[level.zombie_spawners.size] = e_spawner;
}

/*
	Name: function_bdf62232
	Namespace: zm_orange
	Checksum: 0x6720D861
	Offset: 0x3670
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_bdf62232()
{
	self thread namespace_3263198e::function_865209df(#"hash_755b2f3c6e5db17", #"hash_6d9b683b3abbb981");
}

/*
	Name: function_6be9c49c
	Namespace: zm_orange
	Checksum: 0xC5DB3CCC
	Offset: 0x36B0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_6be9c49c()
{
	self thread namespace_3263198e::function_865209df(#"hash_1c326d6810f4e3ee", #"hash_42f42c8c6a56a111");
}

/*
	Name: play_avalanche
	Namespace: zm_orange
	Checksum: 0x85C6F129
	Offset: 0x36F0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function play_avalanche()
{
	level endon(#"end_game");
	wait(2);
	level thread scene::play("p8_fxanim_zm_ora_spawn_avalanche_bundle");
	exploder::exploder("fxexp_avalanche_event_fx");
	callback::function_50fdac80(&play_avalanche);
}

/*
	Name: function_4dacc177
	Namespace: zm_orange
	Checksum: 0xBFE9CC2F
	Offset: 0x3770
	Size: 0x122
	Parameters: 0
	Flags: Linked
*/
function function_4dacc177()
{
	namespace_59ff1d6c::function_a00576dd(undefined, undefined, &function_c8ce0a17, &function_e5086229);
	level waittill(#"start_zombie_round_logic");
	switch(namespace_59ff1d6c::function_901b751c(#"zmpowerstate"))
	{
		case 1:
		{
			break;
		}
		case 2:
		{
			level flag::set("power_on1");
			level flag::set("power_on2");
			level flag::set("power_on3");
		}
		case 0:
		{
			break;
		}
		default:
		{
		}
	}
}

/*
	Name: function_c8ce0a17
	Namespace: zm_orange
	Checksum: 0x1B0AD79B
	Offset: 0x38A0
	Size: 0x68
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = namespace_16c9989b::function_27695a82();
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

/*
	Name: function_e5086229
	Namespace: zm_orange
	Checksum: 0xAA275E3A
	Offset: 0x3910
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_e5086229(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = namespace_c402654::function_62db7b1c(1);
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

